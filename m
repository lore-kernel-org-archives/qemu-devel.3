Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673E0CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 07:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvt1n-00063z-6L; Tue, 09 Sep 2025 03:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uvt1k-00063J-S7
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 03:44:32 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uvt1h-00047n-Up
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 03:44:32 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cf2d:0:640:140f:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 29B33807F0;
 Tue, 09 Sep 2025 10:44:27 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b64::1:1] (unknown [2a02:6bf:8080:b64::1:1])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id MiDIr96FpqM0-8ZXj8VML; Tue, 09 Sep 2025 10:44:26 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757403866;
 bh=OUtwTq1pA70otzZLEtLKyCfL6U//NSC9o7nDFafBS9Q=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=IWYV/7d+BRCEEpOeTGyjXplw2gt51GY0Iq98iu6+d5UX0/tn0gTTN1NL2+Zj8L5qe
 RSER039z/a3eos4IvPv5Xy2CsiIK0KT6F+rxmMg2Kk/IOPl7suaSOJpnpPkW5fk8/Z
 UnXNq3s5V1WEDnCWcXv6tBhpkVS3SMscz5d0N3k8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <fa01e354-289b-4dc7-bfc2-02913c3e488d@yandex-team.ru>
Date: Tue, 9 Sep 2025 10:44:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/9] net/tap: implement interfaces for local migration
To: Peter Xu <peterx@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, leiyang@redhat.com,
 steven.sistare@oracle.com, yc-core@yandex-team.ru, mst@redhat.com,
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com, thuth@redhat.com,
 philmd@linaro.org, berrange@redhat.com
References: <20250905135039.2202924-1-vsementsov@yandex-team.ru>
 <20250905135039.2202924-6-vsementsov@yandex-team.ru>
 <aL75XyzSI6lEOKF3@x1.local>
 <0bdf838f-8fa8-488a-b2b8-fd6d385d05ff@yandex-team.ru>
 <aL82Jqzt5iJNNjnZ@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aL82Jqzt5iJNNjnZ@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 08.09.25 23:01, Peter Xu wrote:
> On Mon, Sep 08, 2025 at 07:48:09PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 08.09.25 18:42, Peter Xu wrote:
>>> On Fri, Sep 05, 2025 at 04:50:35PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>> +static const VMStateDescription vmstate_tap = {
>>>> +    .name = "virtio-net-device",
>>>> +    .post_load = tap_post_load,
>>>> +    .fields = (const VMStateField[]) {
>>>> +        VMSTATE_FD(fd, TAPState),
>>>> +        VMSTATE_BOOL(using_vnet_hdr, TAPState),
>>>> +        VMSTATE_BOOL(has_ufo, TAPState),
>>>> +        VMSTATE_BOOL(has_uso, TAPState),
>>>> +        VMSTATE_BOOL(enabled, TAPState),
>>>> +        VMSTATE_UINT32(host_vnet_hdr_len, TAPState),
>>>> +        VMSTATE_END_OF_LIST()
>>>> +    }
>>>> +};
>>>> +
>>>> +int tap_save(NetClientState *nc, QEMUFile *f)
>>>> +{
>>>> +    TAPState *s = DO_UPCAST(TAPState, nc, nc);
>>>> +
>>>> +    return vmstate_save_state(f, &vmstate_tap, s, 0);
>>>> +}
>>>> +
>>>> +int tap_load(NetClientState *nc, QEMUFile *f)
>>>> +{
>>>> +    TAPState *s = DO_UPCAST(TAPState, nc, nc);
>>>> +
>>>> +    return vmstate_load_state(f, &vmstate_tap, s, 0);
>>>> +}
>>>
>>> Instead of hard-coding vmstate_save_state() / vmstate_load_state(), could
>>> we make tap's VMSD to be a subsection of virtio-net's?
>>>
>>> Multifd already doesn't support qemufile, but only iochannels (which is the
>>> internal impl of qemufiles).  We might at some point start to concurrently
>>> load devices with multifd, then anything with qemufile will be a no-go and
>>> need to be serialized as legacy code in the main channel, or rewritten.
>>>
>>> IMHO it'll be great if we can avoid adding new codes operating on
>>> qemufiles, and also avoid adding any new custom VMSD fields' put()/get() if
>>> ever possible.
>>>
>>
>> Subsections are loaded after fields.
>>
>> And virtio-net already has fields
>>
>>          VMSTATE_WITH_TMP(VirtIONet, struct VirtIONetMigTmp,
>>                           vmstate_virtio_net_has_vnet),
>>
>> and
>>
>>          VMSTATE_WITH_TMP(VirtIONet, struct VirtIONetMigTmp,
>>                           vmstate_virtio_net_has_ufo),
> 
> Side note: I'm actually a bit confused on why it needs to use
> VMSTATE_WITH_TMP(), or say, the get()/put() directly.
> 
> Taking example of vmstate_virtio_net_has_ufo, afaiu, the only point here is
> that virtio_net_ufo_post_load() would check peer UFO support.  I wonder if
> that should work too to check that in virtio_net_post_load_device(), and
> fail there if anything is wrong..  then would has_ufo be able to be
> migrated as a VMSTATE_U8 field?
> 
>>
>> Which do check on virtio-net level some parameters, which should come from local migration of TAP.
>>
>> That's why I made TAP a field, and put it before these two ones. This way these two checks works.
>>
>>
>> Still, from your comment I understand that hard-coding save/load is worse problem. So I can just
>> skip checking in vmstate_virtio_net_has_vnet / vmstate_virtio_net_has_ufo with enabled "local-tap"
>> (or "fd-passing") capability (or better migration parameter). This way TAP may be a subsection.
> 
> That'll be nice, thanks.  Or would a VMSTATE_STRUCT() for TAP to work (so
> that it can also be put before the two _TMPs, but avoid raw get()/put())?
> 

I considered using VMSTATE_STRUCT, but it would mean, I should access TAPState directly from virtio-net
code. That's not possible now, as TAPState is a static type in tap.c, and think it's better to keep
it static. So, in this case, subsection should be better, if I understand correctly.

-- 
Best regards,
Vladimir


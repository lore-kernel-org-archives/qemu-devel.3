Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 611CCCD6E41
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 07:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wS8dD-0003JV-Vv; Wed, 27 May 2026 03:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wS8dB-0003JK-LU
 for qemu-devel@nongnu.org; Wed, 27 May 2026 03:24:46 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wS8d8-0004oW-PR
 for qemu-devel@nongnu.org; Wed, 27 May 2026 03:24:45 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:7605:0:640:8d9a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id D640F80739;
 Wed, 27 May 2026 10:24:36 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:69::1:d] (unknown [2a02:6bf:8080:69::1:d])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp)
 with ESMTPSA id YOTNxJ0WBmI0-XqjYu0I2; 
 Wed, 27 May 2026 10:24:35 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1779866675;
 bh=4/eAW7rNPgeu/LFrsWbu7QKi/UV4KyKSgTWlE70Q3a8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=JtLMm2g8pT0yqX4fwgQd4R0zUYxEJuQuFwbcRzxn+meeyejxpr3JPnTydD80nQUvb
 AIoeUkeH87IconoV+p8e3agxWu05AbYZIYfRsibbMhJtC7qwS+SUhQ6C/triFD8O/T
 dt/IewJBtSmWlg4zDDAvSi+ncosYg6c61sxv+2kY=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <b15693e1-161b-463d-9772-089d7a848f30@yandex-team.ru>
Date: Wed, 27 May 2026 10:24:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 5/8] virtio-net: support local migration of backend
To: Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
 armbru@redhat.com, farosas@suse.de, raphael.s.norwitz@gmail.com,
 bchaney@akamai.com, qemu-devel@nongnu.org, berrange@redhat.com,
 pbonzini@redhat.com, yc-core@yandex-team.ru,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260522120534.77653-1-vsementsov@yandex-team.ru>
 <20260522120534.77653-6-vsementsov@yandex-team.ru>
 <20260524050632-mutt-send-email-mst@kernel.org>
 <c34e9bba-0e98-4694-870f-5f92f34f1076@yandex-team.ru>
 <ahRgbmVKuonjprB2@x1.local>
 <62045016-a892-43b8-87b1-869ef8d8e9d7@yandex-team.ru>
 <ahXcvpShorJoI4iD@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <ahXcvpShorJoI4iD@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 26.05.26 20:47, Peter Xu wrote:
> On Tue, May 26, 2026 at 02:23:55PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 25.05.26 17:45, Peter Xu wrote:
>>> On Mon, May 25, 2026 at 04:51:55PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>> On 24.05.26 12:09, Michael S. Tsirkin wrote:
>>>>> On Fri, May 22, 2026 at 03:05:30PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>>>> Add virtio-net option local-migration, which is true by default,
>>>>>> but false for older machine types, which doesn't support the feature.
>>>>>>
>>>>>> When both global migration parameter "local" and new virtio-net
>>>>>> parameter "local-migration" are true, virtio-net transfer the whole
>>>>>> net backend to the destination, including open file descriptors.
>>>>>> Of-course, its only for local migration and the channel must be
>>>>>> UNIX domain socket.
>>>>>>
>>>>>> This way management tool should not care about creating new TAP, and
>>>>>> should not handle switching to it. Migration downtime become shorter.
>>>>>>
>>>>>> Support for TAP will come in the next commit.
>>>>>>
>>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy<vsementsov@yandex-team.ru>
>>>>>> Reviewed-by: Ben Chaney<bchaney@akamai.com>
>>>>> I don't get why is this a device property?
>>>>> It's clearly a backend thing?
>>>>>
>>>> Hmm.
>>>>
>>>> We want to be able to disable fd-migration per device, when common "local"
>>>> migration parameter is on.
>>>>
>>>> That's why we have parameter for virtio-net. It's also good, that we may
>>>> enable it by default for newer machine types, to make fd-migration a default
>>>> path.
>>>>
>>>> To be honest, it seems that the only thing in this patch (except for interface),
>>>> which is not about backand, is that we want to do virtio_net_update_host_features()
>>>> after backends incoming migration finished. For this, it's comfortable to have
>>>> backend migration as part of device migration stream.
>>>>
>>>> --
>>>>
>>>> Imagine, we move "local-migration" parameter to TAP device. This raise a lot of questions:
>>> Hmm, I thought we discussed this quite some time ago..  I can't remember
>>> details, but I'll try to comment with what I can still remember.
>>>
>>>> 1. We loss a possibility to set good default in machine type. Ok, we probably may add
>>>> a property to "migration" object, but this property will look like "TAP-local-migration",
>>>> and raise discussion again, that it should be property of TAP..
>>> If you recall I worked on the other series because of this desire of having
>>> tap be able to be QOMified and also support machine compat properties:
>>>
>>> https://lore.kernel.org/all/20251209162857.857593-2-peterx@redhat.com/
>>>
>>> I didn't get a lot of feedback supporting having TYPE_OBJECT_COMPAT, maybe
>>> it's an overkill only to apply object_apply_compat_props().
>>>
>>> However, just to say we can still QOMify TAP and then add its own
>>> instance_post_init() to also do object_apply_compat_props(), like quite a
>>> few other existing users, then this (1) isn't a problem, and it doesn't
>>> need to depend on my series either.
>>
>> Thanks for reminding and explanation. Previously, I thought that
>> QOMification is huge task, and your series is required. Now I see,
>> that it is not so difficult. All that's left for me to say is
>> "let's try it")
>>
>>
>> Here is an experimental diff on top on this series. If you like it,
>> I'll resend with proper division into commits:
> 
> I don't know networking, but in general it looks pretty neat to me, thanks.
> 
> Only a few nitpicks inline where I can spot.

[..]

>> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
>> index 0a8a2e85a63..e7b3cd7db01 100644
>> --- a/include/migration/vmstate.h
>> +++ b/include/migration/vmstate.h
>> @@ -178,6 +178,7 @@ typedef enum {
>>       MIG_PRI_LOW,                /* Must happen after default */
>>       MIG_PRI_DEFAULT,
>> +    MIG_PRI_TAP,                /* Must happen before virtio-net device */
> 
> It's a tradition we put random names here, but they should be cleaned up at
> some point.  For this one, it's easy to categorize it on the 1st day, maybe
> MIG_PRI_BACKEND?  Which should include anything that is a backend of an
> emulated devices.  Keeping the comment would be still very nice, though (by
> mentioning the dependency of virtio-net over TAP).

OK

> 
>>       MIG_PRI_IOMMU,              /* Must happen before PCI devices */
>>       MIG_PRI_PCI_BUS,            /* Must happen before IOMMU */
>>       MIG_PRI_VIRTIO_MEM,         /* Must happen before IOMMU */

[..]

>> --- a/qapi/net.json
>> +++ b/qapi/net.json
>> @@ -429,9 +429,18 @@
>>   #     getting TAP file descriptors from incoming migration stream.
>>   #     The option is incompatible with any of @fd, @fds, @helper, @br,
>>   #     @ifname, @sndbuf and @vnet_hdr options, and requires @script and
>> -#     @downscript be explicitly set to nothing (empty string or "no")
>> +#     @downscript be explicitly set to nothing (empty string or "no"),
>> +#     and requires also @local-migration to be set an "local"
>> +#     migration parameter be set as well.
>>   #     (Since 11.1)
>>   #
>> +# @local-migration: enable local migration for this TAP backend.
> 
> I would maybe call it "supported", then we can differenciate "enablement of
> the feature" versus "devices support this feature".
> 
> Not a big deal, though.  Below lines explain everything well, so looks good
> with/without changing.


OK for me, will do.


Thanks for fast answer, I'll make v17 soon.

-- 
Best regards,
Vladimir


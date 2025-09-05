Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E3FCA0FED
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 10:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuTSq-0003G7-CN; Fri, 05 Sep 2025 06:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uuTSo-0003Fq-RK
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 06:14:38 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1uuTSj-00065Z-3d
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 06:14:38 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:1621:0:640:12d9:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id BE7DE813BD;
 Fri, 05 Sep 2025 13:14:24 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b8f::1:11] (unknown
 [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id NEfrem0GoCg0-2INaAG9r; Fri, 05 Sep 2025 13:14:24 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1757067264;
 bh=D4rayc8FjcB+TLP2mm4uHoDFHOZVCLCTApOiAreyVmQ=;
 h=In-Reply-To:Cc:Date:References:To:From:Subject:Message-ID;
 b=YOBVo1uMaaJ1qR05hUvByNsq11lVfV+IXYFVXKS6/i9IzwmJU0SILldFp5V/L0Tb0
 Mbnk7Mt/JP+jbPJQ8/cQzhD8xL1Naj8C5sR8AzB26aGPBaQ0AZacZq42JHrQRsmFnO
 Eh+YbCFpGGeA0J5mTqYWizGfUX1kNcwfZDoD5xh4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <ba252b43-aaab-4a40-832f-3341875de17f@yandex-team.ru>
Date: Fri, 5 Sep 2025 13:14:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] net/tap: implement interfaces for local migration
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: Steven Sistare <steven.sistare@oracle.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, leiyang@redhat.com,
 yc-core@yandex-team.ru, peterx@redhat.com, mst@redhat.com, farosas@suse.de,
 eblake@redhat.com, armbru@redhat.com, thuth@redhat.com, philmd@linaro.org
References: <20250903133706.1177633-1-vsementsov@yandex-team.ru>
 <20250903133706.1177633-6-vsementsov@yandex-team.ru>
 <aLhR2unpr2xg2MYl@redhat.com>
 <16e31f9b-49ef-44a4-b9ad-0668e3c2c530@yandex-team.ru>
 <12ec1ef1-9258-4ccb-9140-bbb6a2bd93af@oracle.com>
 <eeb8603e-f78b-48be-a2e7-0dd2e0e3c8e0@yandex-team.ru>
Content-Language: en-US
In-Reply-To: <eeb8603e-f78b-48be-a2e7-0dd2e0e3c8e0@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 04.09.25 10:41, Vladimir Sementsov-Ogievskiy wrote:
> On 03.09.25 19:09, Steven Sistare wrote:
>> On 9/3/2025 11:31 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> On 03.09.25 17:34, Daniel P. Berrangé wrote:
>>>> On Wed, Sep 03, 2025 at 04:37:02PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>>>> Handle local-incoming option:
>>>>>
>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>>> ---
>>>>>   include/net/tap.h |   4 ++
>>>>>   net/tap.c         | 136 +++++++++++++++++++++++++++++++++++++++-------
>>>>>   2 files changed, 119 insertions(+), 21 deletions(-)
>>>>>
>>>>> diff --git a/include/net/tap.h b/include/net/tap.h
>>>>> index 6f34f13eae..3ef2e2dbae 100644
>>>>> --- a/include/net/tap.h
>>>>> +++ b/include/net/tap.h
>>>>> @@ -30,7 +30,11 @@
>>>>>   int tap_enable(NetClientState *nc);
>>>>>   int tap_disable(NetClientState *nc);
>>>>> +bool tap_local_incoming(NetClientState *nc);
>>>>>   int tap_get_fd(NetClientState *nc);
>>>>> +int tap_load(NetClientState *nc, QEMUFile *f);
>>>>> +int tap_save(NetClientState *nc, QEMUFile *f);
>>>>> +
>>>>>   #endif /* QEMU_NET_TAP_H */
>>>>> diff --git a/net/tap.c b/net/tap.c
>>>>> index a9d955ac5f..499db756ea 100644
>>>>> --- a/net/tap.c
>>>>> +++ b/net/tap.c
>>>>> @@ -35,6 +35,8 @@
>>>>>   #include "net/eth.h"
>>>>>   #include "net/net.h"
>>>>>   #include "clients.h"
>>>>> +#include "migration/migration.h"
>>>>> +#include "migration/qemu-file.h"
>>>>>   #include "monitor/monitor.h"
>>>>>   #include "system/system.h"
>>>>>   #include "qapi/error.h"
>>>>> @@ -82,6 +84,7 @@ typedef struct TAPState {
>>>>>       VHostNetState *vhost_net;
>>>>>       unsigned host_vnet_hdr_len;
>>>>>       Notifier exit;
>>>>> +    bool local_incoming;
>>>>>   } TAPState;
>>>>>   static void launch_script(const char *setup_script, const char *ifname,
>>>>> @@ -803,6 +806,40 @@ static int net_tap_init_vhost(TAPState *s, Error **errp) {
>>>>>       return 0;
>>>>>   }
>>>>> +int tap_save(NetClientState *nc, QEMUFile *f)
>>>>> +{
>>>>> +    TAPState *s = DO_UPCAST(TAPState, nc, nc);
>>>>> +
>>>>> +    qemu_file_put_fd(f, s->fd);
>>>>> +    qemu_put_byte(f, s->using_vnet_hdr);
>>>>> +    qemu_put_byte(f, s->has_ufo);
>>>>> +    qemu_put_byte(f, s->has_uso);
>>>>> +    qemu_put_byte(f, s->enabled);
>>>>> +    qemu_put_be32(f, s->host_vnet_hdr_len);
>>>>
>>>>
>>>> Is it neccessary to transfer that metadata, or is there perhaps a way
>>>> for the other side to query the TAP FD configuration from the kernel
>>>> to detect this ?
>>>
>>> Oh, good question, thanks for it. I just added everything and then I was debugging other places.
>>>
>>> for hdr_len we have TUNGETVNETHDRSZ, so it's possible.
>>>
>>> using_vnet_hdr, seems is equal to initial vnet_hdr option (with default to 1 if not specified), will doublecheck
>>>
>>> for ufo/uso, which are set through TUNSETOFFLOAD, we don't have direct way to
>>> get the state. But we can use the fact, that qemu tries to set them once,
>>> and these variables are unchanged after initialization. So we can try set
>>> same flags on target the same way, to understand what we have. Still,
>>> this doesn't seem absolutely safe.. Kernel may behave differently than
>>> for previous initialization, probably due to some changed settings.
>>>
>>> for enabled it seems not possible, but we handle it in virtio layer.. Oops,
>>> probably I always migrate enabled=false with this code, will check.
>>>
>>> ---
>>>
>>> On the other hand, calling extra ioctls to learn something lead to extra downtime
>>> (should be measured to be a good argument).
>>>
>>> Also, just architecturally: seems better not ask third agent about metadata that we already know.
>>>
>>> ---
>>>
>>> About forward-compatibility (if we add new fields here) - agree.
>>>
>>> Maybe turn several boolean fields into one flags field. This way we'll get several "reserved" bits for future changes.
>>>
>>>>
>>>> I'm concerned that this code / wire format is not extensible if we ever
>>>> add another similar field to TAPState in the future.
>>
>> tap_save and tap_load should be replaced with a VMStateDescription for future
>> extensibility.  Use VMSTATE_FD for the fd.  Define a postload hook for
>> tap_read_poll and net_tap_init_vhost.
> 
> How it works? I thought, if I add new field to vmsd, destination will try to load it anyway (as it loads them in a loop in vmstate_load_state()).. So, we'll have to add same new capabilities anyway to "enable" new fields (with help of .field_exists)? Same way we can add new field to current realization, with new migration capability and "if" in _load() function..
> 
> Still, seems using VMSD is better anyway, so I should do it.
> 

answering myself: at least, fields has versioning feature, which is intended for future-compatibility.

>>
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +int tap_load(NetClientState *nc, QEMUFile *f)
>>>>> +{
>>>>> +    TAPState *s = DO_UPCAST(TAPState, nc, nc);
>>>>> +
>>>>> +    s->fd = qemu_file_get_fd(f);
>>>>> +    if (s->fd < 0) {
>>>>> +        return -1;
>>>>> +    }
>>>>> +
>>>>> +    s->using_vnet_hdr = qemu_get_byte(f);
>>>>> +    s->has_ufo = qemu_get_byte(f);
>>>>> +    s->has_uso = qemu_get_byte(f);
>>>>> +    s->enabled = qemu_get_byte(f);
>>>>> +    qemu_get_be32s(f, &s->host_vnet_hdr_len);
>>>>> +
>>>>> +    tap_read_poll(s, true);
>>>>> +
>>>>> +    return net_tap_init_vhost(s, NULL);
>>>>> +}
>>>>> +
>>>>>   static int net_tap_fd_init_common(const Netdev *netdev, NetClientState *peer,
>>>>>                                     const char *model, const char *name,
>>>>>                                     const char *ifname, const char *script,
>>>>
>>>> With regards,
>>>> Daniel
>>>
>>>
>>
> 
> 


-- 
Best regards,
Vladimir


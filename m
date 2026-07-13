Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9444FC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:35:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjFsZ-0005qu-Q5; Mon, 13 Jul 2026 08:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wjFsS-0005pW-Lt
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 08:35:17 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wjFsN-0002tD-Bz
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 08:35:14 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id F33F3C08D0;
 Mon, 13 Jul 2026 15:35:07 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c5a::1:8] (unknown [2a02:6bf:8080:c5a::1:8])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id 6ZNCa30aBW20-zURoJZ5D; Mon, 13 Jul 2026 15:35:07 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1783946107;
 bh=ODo/y/Wq9dVKIcLz57LsfDmi1rgwaVkhBlyaj4o6BPk=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=E67Asl0fm7wazQsbqYzjnYlBc6yqVtYLEtTkdbTeGG9lmdFy7ltxEIMQpgwunFkBA
 SsBjXwUr7Vjvzbl/QqqqzXbI5XmeXr3OeHXuFExk9Sw+Mdd8hYqwzGKtaGDhd5ALdQ
 Rp3ZTMZErQcu1ce1x/qAHRYPjuc3CHyO6VotaNbw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <f5178fb9-d3d1-4ed1-8f0e-98f4d95be2d6@yandex-team.ru>
Date: Mon, 13 Jul 2026 15:35:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 12/14] net/tap: support local migration with virtio-net
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com,
 peterx@redhat.com, farosas@suse.de, raphael.s.norwitz@gmail.com,
 bchaney@akamai.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Jason Wang <jasowangio@gmail.com>,
 Eric Blake <eblake@redhat.com>
References: <20260710191809.721154-1-vsementsov@yandex-team.ru>
 <20260710191809.721154-13-vsementsov@yandex-team.ru>
 <alTJLI3EWU96Ks61@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <alTJLI3EWU96Ks61@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 13.07.26 14:17, Daniel P. Berrangé wrote:
> On Fri, Jul 10, 2026 at 10:18:01PM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> Support transferring of TAP state (including open fd).
>>
>> Add new property "local-migration-supported", which defines
>> whether local-migration is actually supported for this TAP device.
>> Starting from 11.2 QEMU Machine Types it's enabled by default.
>>
>> Note, that local-migration (including migrating opened FDs
>> through migration channel, which must be UNIX socket), is
>> enabled by global "local" migration parameters. But individual
>> devices may have additional options to enable/disable it
>> per device.
>>
>> The tricky thing, is that we need to know, should we do
>> call open/connect in TAP initialization code. That means,
>> that on incoming migration we want to know status of
>> "local" migration parameter at time of creating TAP device.
>> So, currently, for incoming local migration only TAP device
>> created through QMP is supported, as you need to set migration
>> parameter first (through QMP as well).
>>
>> So the full picture is:
>>
>> On source, to start outgoing "local" migration you need:
>>
>>   - migration parameter "local" set to true
>>   - "local-migration-supported" TAP option set to true (the
>>     default, starting from 11.2 QEMU Machine Types)
>>
>> If at least one of these options is not set, TAP backend
>> doesn't participate in migration.
>>
>> On target, things are more difficult:
>>
>> Same, you need both "local" and "local-migration-supported"
>> be set. And same, if one of them is not set, TAP backend
>> is initialized as usual, and doesn't accept any incoming
>> state.
>>
>> Additionally, if you are going to set "local", it must be
>> set before creating the TAP device. If TAP device created
>> with "local" unset, it initializes as usual. If you enable
>> "local" after it and start incoming migration, it will fail
>> in .pre_load handler of TAP backend.
>>
>> Moreover, there are interface restrictions: if you create TAP
>> device when QEMU is in INCOMING state, and both "local"
>> and "local-migration-supported" set, most of TAP options are
>> not allowed, and script/downscript are required to be explicitly
>> unset (set to "" or "no").
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>
>> In v17 thread we considered making new qapi parameters "unstable".
>> Still, it was because of doubtful "incoming-fds" parameter. In this
>> v18 it's completely removed, and we may live only with "local"
>> migration parameter + "local-migration-supported" TAP option.
>> This way the series doesn't conflict with suggested by Peter
>>    [PATCH RFC 0/2] migration/vl: new -incoming config:* for early migration parameters
>> So, I think, worth making one more iteration as "stable candidate".
>> If still some doubts, not problem for me to resend with "unstable" features.
>>
>>   hw/core/machine.c |   7 ++
>>   net/tap.c         | 162 ++++++++++++++++++++++++++++++++++++++++++++--
>>   qapi/net.json     |  23 ++++++-
>>   3 files changed, 185 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 15886a56b19..2a1abb29041 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -36,10 +36,16 @@
>>   #include "hw/virtio/virtio-pci.h"
>>   #include "hw/virtio/virtio-net.h"
>>   #include "hw/virtio/virtio-iommu.h"
>> +#include "net/tap.h"
>>   #include "hw/acpi/generic_event_device.h"
>>   #include "qemu/audio.h"
>>   #include "hw/arm/smmuv3.h"
>>   
>> +/*
>> + * TODO: When hw_compat_11_1 appears, local-migration-supported=false
>> + * for TYPE_TAP_NETDEV should be move to it from hw_compat_11_0.
>> + */
>> +
>>   GlobalProperty hw_compat_11_0[] = {
>>       { "chardev-vc", "encoding", "cp437" },
>>       { "tpm-crb", "cap-chunk", "off" },
>> @@ -49,6 +55,7 @@ GlobalProperty hw_compat_11_0[] = {
>>       { TYPE_ARM_SMMUV3, "ssidsize", "0" },
>>       { TYPE_ARM_SMMUV3, "oas", "44" },
>>       { "migration", "switchover-ack-legacy", "on" },
>> +    { TYPE_TAP_NETDEV, "local-migration-supported", "false" },
> 
> So disabled by default for historical machines type versions, but....
> 
>> +static void tap_instance_init(Object *obj)
>> +{
>> +    TAPState *s = TAP_NETDEV(obj);
>> +    s->local_migration_supported = true;
>> +}
> 
> ..enabled by default for all future machine type versions, but...
> 
> 
>> @@ -1005,6 +1123,23 @@ int net_init_tap(const Netdev *netdev, const char *name,
>>           return -1;
>>       }
>>   
>> +    incoming_fds = tap->local_migration_supported && migrate_local() &&
>> +                   runstate_check(RUN_STATE_INMIGRATE);
>> +
>> +    if (incoming_fds &&
>> +        (tap->fd || tap->fds || tap->helper || tap->br || tap->ifname ||
>> +         tap->has_sndbuf || tap->has_vnet_hdr ||
>> +         !tap_is_explicit_no_script(tap->script) ||
>> +         !tap_is_explicit_no_script(tap->downscript))) {
>> +        error_setg(errp, "Local incoming migration of TAP device (-incoming, "
>> +                   "migration parameter @local is set, "
>> +                   "TAP parameter @local-migration-supported is set) "
>> +                   "is incompatible with "
>> +                   "fd=, fds=, helper=, br=, ifname=, sndbuf= and vnet_hdr=, "
>> +                   "and requires explicit empty script= and downscript=");
>> +        return -1;
>> +    }
> 
> ...not usable by default unless the mgmt app knows to avoid these settings,
> but the user won't find out about this limit until they try to migrate and
> it fails at runtime, months or years after the VM was first configured &
> launched :-(

No, it fail only for RUN_STATE_INMIGRATE, and only if "local" is enabled.
If mgmt enables "local" it must know about the restrictions of using it.

> 
> AFAICT, there's also no way for mgmt apps to determine which parameters
> are forbidden, because it is merely exposed in API docs text, no way to
> introspect

Unfortunately yes.

> 
> IMHO the sane way to do this is to not have any "local-migration-supported"
> device flag at all, and also no "local" migration parameter. The src & dst
> QEMU's so badly need to be able to auto-negotiate and just do the right
> thing, otherwise this local migration optimization becomes a mgmt nightmare
> long term :-(

"local" is needed because we can't know, does transfer support fd-passing.
To auto-negotiate it, we probably need to pass a test FD to the target, as
simply checking "is it a UNIX socket" may not be enough.

"local-migration-supported" may be auto negotiated of course, if we have
auto negotiation.

> 
> And yet we don't have any auto-negotiate mechanism, and I don't want to
> block your work :-(
> 

Thanks) But finally, in short term, could we proceed with it as is, or not?

Would it be better, if I drop the default =true for new machine types, keeping
it false?


-- 
Best regards,
Vladimir


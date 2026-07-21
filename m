Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281B8C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 07:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm4i4-0006Bc-KU; Tue, 21 Jul 2026 03:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wm4i3-0006BQ-FR
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 03:16:11 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wm4i1-0001HC-A5
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 03:16:11 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 14186806C1;
 Tue, 21 Jul 2026 10:16:08 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:45b::1:22] (unknown
 [2a02:6bf:8080:45b::1:22])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id 7GQZfE2XJOs0-JMgBpKv6; Tue, 21 Jul 2026 10:16:07 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1784618167;
 bh=MdjBS/DoGlLNBYPn3DBCV31lTzovAylEeHh0j54GOes=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=apP57eE+0/dhuXqNvGlRv4B6U9XRq0eJbU0xUn2t3Q2VHp6E1v30WvvR2wrYExmh6
 wtUr25bra2OaVI7Gn6KDMYtNkVzrZuSHzs4+l/omIT2DGrxbLh9H+SytKvEnwRGhCS
 KjOPrYS8k14gXr70qaBh8pR19vN2x+Cf6s57Llp8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <6f547b5b-db44-4a14-bf70-cc6e6e7182ba@yandex-team.ru>
Date: Tue, 21 Jul 2026 10:16:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 13/15] net/tap: support local migration with virtio-net
To: Markus Armbruster <armbru@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, qemu-devel@nongnu.org,
 berrange@redhat.com, pbonzini@redhat.com, yc-core@yandex-team.ru,
 mark.caveayland@nutanix.com, Jason Wang <jasowangio@gmail.com>,
 Eric Blake <eblake@redhat.com>
References: <20260714154246.1242856-1-vsementsov@yandex-team.ru>
 <20260714154246.1242856-14-vsementsov@yandex-team.ru>
 <87a4rksuch.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87a4rksuch.fsf@pond.sub.org>
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

On 21.07.26 09:57, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> Support transferring of TAP state (including open fd).
>>
>> Add new property "local-migration-supported", which defines
>> whether local-migration is actually supported for this TAP device.
>> Starting from 11.2 QEMU Machine Types it's enabled by default.
>>
>> Note that local-migration (including migrating opened FDs
>> through migration channel, which must be UNIX socket) is
>> enabled by global "local" migration parameters. But individual
>> devices may have additional options to enable/disable it
>> per device.
>>
>> The tricky thing is that we need to know whether to call open/connect in
>> TAP initialization code, i.e. we need to know the value of migration
>> parameter "local" when creating the TAP device.  For incoming migration,
>> we can know only for TAP devices created with QMP after setting the
>> migration parameter with QMP.
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
>>   net/tap.c     | 165 ++++++++++++++++++++++++++++++++++++++++++++++++--
>>   qapi/net.json |  22 ++++++-
>>   2 files changed, 180 insertions(+), 7 deletions(-)
>>
>> diff --git a/net/tap.c b/net/tap.c
>> index 2bd4b089573..4162820bcee 100644
>> --- a/net/tap.c
>> +++ b/net/tap.c
>> @@ -38,12 +38,17 @@
>>   #include "monitor/monitor.h"
>>   #include "system/runstate.h"
>>   #include "system/system.h"
>> +#include "migration/misc.h"
>>   #include "qapi/error.h"
>>   #include "qemu/cutils.h"
>>   #include "qemu/error-report.h"
>>   #include "qemu/main-loop.h"
>>   #include "qemu/sockets.h"
>>   #include "hw/virtio/vhost.h"
>> +#include "hw/core/vmstate-if.h"
>> +#include "migration/vmstate.h"
>> +#include "qom/object.h"
>> +#include "qom/compat-properties.h"
>>   
>>   #include "net/tap.h"
>>   #include "net/util.h"
>> @@ -71,6 +76,8 @@ static const int kernel_feature_bits[] = {
>>   
>>   OBJECT_DECLARE_SIMPLE_TYPE(TAPState, TAP_NETDEV)
>>   
>> +static const VMStateDescription vmstate_tap;
>> +
>>   struct TAPState {
>>       Object parent_obj;
>>   
>> @@ -95,6 +102,7 @@ struct TAPState {
>>       int queue_index;
>>       bool read_poll_detached;
>>       VMChangeStateEntry *vmstate;
>> +    bool local_migration_supported;
>>   };
>>   
>>   static void launch_script(const char *setup_script, const char *ifname,
>> @@ -409,6 +417,8 @@ static void tap_cleanup(NetClientState *nc)
>>       tap_write_poll(s, false);
>>       close(s->fd);
>>       s->fd = -1;
>> +
>> +    vmstate_unregister(VMSTATE_IF(s), &vmstate_tap, s);
>>   }
>>   
>>   static void tap_poll(NetClientState *nc, bool enable)
>> @@ -445,6 +455,76 @@ static VHostNetState *tap_get_vhost_net(NetClientState *nc)
>>       return s->vhost_net;
>>   }
>>   
>> +static bool tap_is_wait_incoming(NetClientState *nc)
>> +{
>> +    TAPState *s = container_of(nc, TAPState, nc);
>> +    assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
>> +    return s->fd == -1;
>> +}
>> +
>> +static bool tap_pre_load(void *opaque, Error **errp)
>> +{
>> +    TAPState *s = opaque;
>> +
>> +    if (s->fd != -1) {
>> +        error_setg(errp,
>> +                   "TAP is already initialized and cannot receive "
>> +                   "incoming fd.  For local migration, 'local' "
>> +                   "migration parameter must be set _before_ "
>> +                   "creating TAP device.");
> 
>  From error_setg()'s contract:
> 
>   * The resulting message should be a single phrase, with no newline or
>   * trailing punctuation.
> 
> Suggest something like
> 
>             error_setg(errp,
>                        "TAP is already initialized and cannot receive "
>                        "incoming fd");
>             error_append_hint(errp,
>                               "Migration parameter 'local' must be set"
>                               " _before_ creating the TAP device.");
> 
> Requires ERRP_GUARD().

Will follow this, thanks

> 
>> +        return false;
>> +    }
>> +
>> +    return true;
>> +}
> 
> [...]
> 
>> diff --git a/qapi/net.json b/qapi/net.json
>> index ada0329ef9d..d0d6e303b0d 100644
>> --- a/qapi/net.json
>> +++ b/qapi/net.json
>> @@ -435,6 +435,25 @@
>>   # @poll-us: maximum number of microseconds that could be spent on busy
>>   #     polling for tap (since 2.7)
>>   #
>> +# @local-migration-supported: enable local migration for this TAP
>> +#     backend.  When set, local migration is enabled/disabled by
>> +#     migration parameter @local for this TAP backend.  When unset,
>> +#     migration parameter @local is ignored for this TAP backend.
>> +#     To be able to do incoming local migration of a TAP backend,
>> +#     migration parameter @local must be set _before_ creating the
>> +#     TAP backend.  Otherwise, TAP backend is initialized as usual,
>> +#     opening/creating TAP devices in kernel.  In this case further
>> +#     local incoming migration (with migration parameter @local set
>> +#     after creating TAP backend with @local-migration-supporeted
>> +#     parameter set) will simply fail.
>> +#     Moreover, when QEMU is in incoming migration state, migration
>> +#     parameter @local is set and @local-migration-supported is set,
>> +#     the following options are not supported and must not be set:
>> +#     @fd, @fds, @helper, @br, @ifname, @sndbuf, @vnet_hdr.
>> +#     Additionally in this case @script and @downscipt must be
>> +#     explicitly disabled (empty strings or "no").
>> +#     (Since 11.2)
> 
> Default?
> 

Default is false now, no tricks with Machine Types. Will add.

>> +#
>>   # Since: 1.2
>>   ##
>>   { 'struct': 'NetdevTapOptions',
>> @@ -453,7 +472,8 @@
>>       '*vhostfds':   'str',
>>       '*vhostforce': 'bool',
>>       '*queues':     'uint32',
>> -    '*poll-us':    'uint32'} }
>> +    '*poll-us':    'uint32',
>> +    '*local-migration-supported': 'bool' } }
>>   
>>   ##
>>   # @NetdevSocketOptions:
> 


-- 
Best regards,
Vladimir


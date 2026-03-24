Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DE6F54ABA
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 13:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w52B8-0006PV-BK; Tue, 24 Mar 2026 09:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w52Ap-0006Cs-15
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 09:52:04 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w52Al-0006pY-8K
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 09:51:58 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:7605:0:640:8d9a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id C8FE3808FC;
 Tue, 24 Mar 2026 16:51:49 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:46c::1:35] (unknown
 [2a02:6bf:8080:46c::1:35])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id lpTAdN0ARa60-3kZA60lO; Tue, 24 Mar 2026 16:51:49 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1774360309;
 bh=JmfqnTCl0CWWw9gH1+arcc3Yc6l87kCUv6ngNWCoGw4=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=r5E/YgUyVL12Z9IEZ4FvQLcjvmyVsLnKee0wOGviZl+N/EoUWtrmy4VeQh4y04ECx
 dUACHuJ7YXD/NK2gtzCvFeRFo1l5aLk49wnt9I0Lh7ewr6l7ehKbJHDI6cEqAhnOwy
 Gq3b2GMhxVpkJ+hQc2s33E8HNpnYfXcmudjVcLfI=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <d3beaccb-6903-47c2-8ffe-82b3f3cdc6b7@yandex-team.ru>
Date: Tue, 24 Mar 2026 16:51:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 6/8] net/tap: support local migration with virtio-net
To: Markus Armbruster <armbru@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, eblake@redhat.com, farosas@suse.de,
 peterx@redhat.com, zhao1.liu@intel.com, wangyanan55@huawei.com,
 philmd@linaro.org, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 davydov-max@yandex-team.ru, qemu-devel@nongnu.org, yc-core@yandex-team.ru,
 leiyang@redhat.com, raphael.s.norwitz@gmail.com, bchaney@akamai.com,
 th.huth+qemu@posteo.eu, berrange@redhat.com, pbonzini@redhat.com
References: <20260319155333.260341-1-vsementsov@yandex-team.ru>
 <20260319155333.260341-7-vsementsov@yandex-team.ru>
 <87y0jhs8z3.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87y0jhs8z3.fsf@pond.sub.org>
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

On 24.03.26 15:33, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> Support transferring of TAP state (including open fd) through
>> migration stream as part of viritio-net "local-migration".
>>
>> Add new option, incoming-fds, which should be set to true to
>> trigger new logic.
>>
>> For new option require explicitly unset script and downscript,
>> to keep possibility of implementing support for them in future.
>>
>> Note disabling read polling on source stop for TAP migration:
>> otherwise, source process may steal packages from TAP fd even
>> after source vm STOP.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   net/tap.c     | 147 +++++++++++++++++++++++++++++++++++++++++++++++---
>>   qapi/net.json |   7 ++-
>>   2 files changed, 147 insertions(+), 7 deletions(-)
>>
>> diff --git a/net/tap.c b/net/tap.c
>> index 9d6213fc3e5..2156b6cbb73 100644
>> --- a/net/tap.c
>> +++ b/net/tap.c
>> @@ -36,6 +36,7 @@
>>   #include "net/net.h"
>>   #include "clients.h"
>>   #include "monitor/monitor.h"
>> +#include "system/runstate.h"
>>   #include "system/system.h"
>>   #include "qapi/error.h"
>>   #include "qemu/cutils.h"
>> @@ -86,6 +87,9 @@ typedef struct TAPState {
>>       VHostNetState *vhost_net;
>>       unsigned host_vnet_hdr_len;
>>       Notifier exit;
>> +
>> +    bool read_poll_detached;
>> +    VMChangeStateEntry *vmstate;
>>   } TAPState;
>>   
>>   static void launch_script(const char *setup_script, const char *ifname,
>> @@ -94,19 +98,25 @@ static void launch_script(const char *setup_script, const char *ifname,
>>   static void tap_send(void *opaque);
>>   static void tap_writable(void *opaque);
>>   
>> +static bool tap_is_explicit_no_scirpt(const char *script_arg)
> 
> "scirpt"?  Do you mean "script"?
> 
>> +{
>> +    return script_arg &&
>> +        (script_arg[0] == '\0' || strcmp(script_arg, "no") == 0);
>> +}
>> +
>>   static char *tap_parse_script(const char *script_arg, const char *default_path)
>>   {
>>       g_autofree char *res = g_strdup(script_arg);
>>   
>> -    if (!res) {
>> -        res = get_relocated_path(default_path);
>> +    if (tap_is_explicit_no_scirpt(script_arg)) {
>> +        return NULL;
>>       }
>>   
>> -    if (res[0] == '\0' || strcmp(res, "no") == 0) {
>> -        return NULL;
>> +    if (!script_arg) {
>> +        return get_relocated_path(default_path);
>>       }
>>   
>> -    return g_steal_pointer(&res);
>> +    return g_strdup(script_arg);
>>   }
>>   
>>   static void tap_update_fd_handler(TAPState *s)
>> @@ -123,6 +133,23 @@ static void tap_read_poll(TAPState *s, bool enable)
>>       tap_update_fd_handler(s);
>>   }
>>   
>> +static void tap_vm_state_change(void *opaque, bool running, RunState state)
>> +{
>> +    TAPState *s = opaque;
>> +
>> +    if (running) {
>> +        if (s->read_poll_detached) {
>> +            tap_read_poll(s, true);
>> +            s->read_poll_detached = false;
>> +        }
>> +    } else if (state == RUN_STATE_FINISH_MIGRATE) {
>> +        if (s->read_poll) {
>> +            s->read_poll_detached = true;
>> +            tap_read_poll(s, false);
>> +        }
>> +    }
>> +}
>> +
>>   static void tap_write_poll(TAPState *s, bool enable)
>>   {
>>       s->write_poll = enable;
>> @@ -353,6 +380,11 @@ static void tap_cleanup(NetClientState *nc)
>>           s->exit.notify = NULL;
>>       }
>>   
>> +    if (s->vmstate) {
>> +        qemu_del_vm_change_state_handler(s->vmstate);
>> +        s->vmstate = NULL;
>> +    }
>> +
>>       tap_read_poll(s, false);
>>       tap_write_poll(s, false);
>>       close(s->fd);
>> @@ -393,6 +425,65 @@ static VHostNetState *tap_get_vhost_net(NetClientState *nc)
>>       return s->vhost_net;
>>   }
>>   
>> +static bool tap_is_wait_incoming(NetClientState *nc)
>> +{
>> +    TAPState *s = DO_UPCAST(TAPState, nc, nc);
>> +    assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
>> +    return s->fd == -1;
>> +}
>> +
>> +static int tap_pre_load(void *opaque)
>> +{
>> +    TAPState *s = opaque;
>> +
>> +    if (s->fd != -1) {
>> +        error_report(
>> +            "TAP is already initialized and cannot receive incoming fd");
>> +        return -EINVAL;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static bool tap_setup_vhost(TAPState *s, Error **errp);
>> +
>> +static int tap_post_load(void *opaque, int version_id)
>> +{
>> +    TAPState *s = opaque;
>> +    Error *local_err = NULL;
>> +
>> +    tap_read_poll(s, true);
>> +
>> +    if (s->fd < 0) {
>> +        return -1;
>> +    }
>> +
>> +    if (!tap_setup_vhost(s, &local_err)) {
>> +        error_prepend(&local_err,
>> +                      "Failed to setup vhost during TAP post-load: ");
>> +        error_report_err(local_err);
>> +        return -1;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static const VMStateDescription vmstate_tap = {
>> +    .name = "net-tap",
>> +    .pre_load = tap_pre_load,
>> +    .post_load = tap_post_load,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_FD(fd, TAPState),
>> +        VMSTATE_BOOL(using_vnet_hdr, TAPState),
>> +        VMSTATE_BOOL(has_ufo, TAPState),
>> +        VMSTATE_BOOL(has_uso, TAPState),
>> +        VMSTATE_BOOL(has_tunnel, TAPState),
>> +        VMSTATE_BOOL(enabled, TAPState),
>> +        VMSTATE_UINT32(host_vnet_hdr_len, TAPState),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>>   /* fd support */
>>   
>>   static NetClientInfo net_tap_info = {
>> @@ -412,7 +503,9 @@ static NetClientInfo net_tap_info = {
>>       .set_vnet_le = tap_set_vnet_le,
>>       .set_vnet_be = tap_set_vnet_be,
>>       .set_steering_ebpf = tap_set_steering_ebpf,
>> +    .is_wait_incoming = tap_is_wait_incoming,
>>       .get_vhost_net = tap_get_vhost_net,
>> +    .backend_vmsd = &vmstate_tap,
>>   };
>>   
>>   static TAPState *net_tap_fd_init(NetClientState *peer,
>> @@ -748,6 +841,9 @@ static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
>>       int sndbuf =
>>           (tap->has_sndbuf && tap->sndbuf) ? MIN(tap->sndbuf, INT_MAX) : INT_MAX;
>>   
>> +    s->read_poll_detached = false;
>> +    s->vmstate = qemu_add_vm_change_state_handler(tap_vm_state_change, s);
>> +
>>       if (!tap_set_sndbuf(fd, sndbuf, sndbuf_required ? errp : NULL) &&
>>           sndbuf_required) {
>>           goto failed;
>> @@ -779,6 +875,8 @@ static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
>>       return true;
>>   
>>   failed:
>> +    qemu_del_vm_change_state_handler(s->vmstate);
>> +    s->vmstate = NULL;
>>       qemu_del_net_client(&s->nc);
>>       return false;
>>   }
>> @@ -910,6 +1008,26 @@ int net_init_tap(const Netdev *netdev, const char *name,
>>           return -1;
>>       }
>>   
>> +    if (tap->incoming_fds &&
>> +        (tap->fd || tap->fds || tap->helper || tap->br || tap->ifname ||
>> +         tap->has_sndbuf || tap->has_vnet_hdr)) {
>> +        error_setg(errp, "incoming-fds is incompatible with "
>> +                   "fd=, fds=, helper=, br=, ifname=, sndbuf= and vnet_hdr=");
> 
> @incoming-fds excludes certain optional members, and ...
> 
>> +        return -1;
>> +    }
>> +
>> +    if (tap->incoming_fds &&
>> +        !(tap_is_explicit_no_scirpt(tap->script) &&
>> +          tap_is_explicit_no_scirpt(tap->downscript))) {
>> +        /*
>> +         * script="" and downscript="" are silently supported to be consistent
>> +         * with cases without incoming_fds, but do not care to put this into
>> +         * error message.
>> +         */
>> +        error_setg(errp, "incoming-fds requires script=no and downscript=no");
> 
> ... requires others.  Not documented in net.json.  Should it be?

Hmm. Excluded options are not documented as well, and as many other relations
between options around TAP.

Still, I script/downscript requirements are more unobvious, so, let's add it to doc.

> 
>> +        return -1;
>> +    }
>> +
>>       queues = tap_parse_fds_and_queues(tap, &fds, errp);
>>       if (queues < 0) {
>>           return -1;
>> @@ -928,7 +1046,24 @@ int net_init_tap(const Netdev *netdev, const char *name,
>>           goto fail;
>>       }
>>   
>> -    if (fds) {
>> +    if (tap->incoming_fds) {
>> +        for (i = 0; i < queues; i++) {
>> +            NetClientState *nc;
>> +            TAPState *s;
>> +
>> +            nc = qemu_new_net_client(&net_tap_info, peer, "tap", name);
>> +            qemu_set_info_str(nc, "incoming");
>> +
>> +            s = DO_UPCAST(TAPState, nc, nc);
>> +            s->fd = -1;
>> +            if (vhost_fds) {
>> +                s->vhostfd = vhost_fds[i];
>> +                s->vhost_busyloop_timeout = tap->has_poll_us ? tap->poll_us : 0;
>> +            } else {
>> +                s->vhostfd = -1;
>> +            }
>> +        }
>> +    } else if (fds) {
>>           for (i = 0; i < queues; i++) {
>>               if (i == 0) {
>>                   vnet_hdr = tap_probe_vnet_hdr(fds[i], errp);
>> diff --git a/qapi/net.json b/qapi/net.json
>> index 118bd349651..2240de7dbf6 100644
>> --- a/qapi/net.json
>> +++ b/qapi/net.json
>> @@ -355,6 +355,10 @@
>>   # @poll-us: maximum number of microseconds that could be spent on busy
>>   #     polling for tap (since 2.7)
>>   #
>> +# @incoming-fds: do not open or create any TAP devices.  Prepare for
>> +#     getting opened TAP file descriptors from incoming migration
>> +#     stream.  (Since 11.0)
> 
> Let's scratch "opened".
> 
> Sure you're still targeting 11.0?

Will fix

> 
>> +#
>>   # Since: 1.2
>>   ##
>>   { 'struct': 'NetdevTapOptions',
>> @@ -373,7 +377,8 @@
>>       '*vhostfds':   'str',
>>       '*vhostforce': 'bool',
>>       '*queues':     'uint32',
>> -    '*poll-us':    'uint32'} }
>> +    '*poll-us':    'uint32',
>> +    '*incoming-fds': 'bool' } }
>>   
>>   ##
>>   # @NetdevSocketOptions:
> 


-- 
Best regards,
Vladimir


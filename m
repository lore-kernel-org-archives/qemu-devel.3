Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7386C44507
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 11:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjEf5-0007DO-6V; Mon, 13 Jul 2026 07:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjEf2-0007B8-NB
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:17:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjEez-0007W1-T1
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783941435;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Wbr/j82XNz3gM7Y00bVUoE2cfM3TocKiEt1Ib3xDUPk=;
 b=Wce3cKg0B419I4UpoUbvVwYytmIRqYiLYEsCwMCdp3If35/LEmTNIt22ebiaZNIHMEyYoO
 6tumdmU9AcPqRicFVURKPMYtTWaPIBhrIl6VdHAE8KwfPE8VoTpf1jqA8JYnHxvf+OSV7x
 EJ01+vwz2EcjaSg+LtZr92oM5z/meMs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-8rhYMQesO4S1iMYbAz8Bag-1; Mon,
 13 Jul 2026 07:17:12 -0400
X-MC-Unique: 8rhYMQesO4S1iMYbAz8Bag-1
X-Mimecast-MFC-AGG-ID: 8rhYMQesO4S1iMYbAz8Bag_1783941430
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C46ED1956041; Mon, 13 Jul 2026 11:17:09 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.22])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3908C180059F; Mon, 13 Jul 2026 11:17:03 +0000 (UTC)
Date: Mon, 13 Jul 2026 12:17:00 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com,
 peterx@redhat.com, farosas@suse.de, raphael.s.norwitz@gmail.com,
 bchaney@akamai.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Jason Wang <jasowangio@gmail.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v18 12/14] net/tap: support local migration with virtio-net
Message-ID: <alTJLI3EWU96Ks61@redhat.com>
References: <20260710191809.721154-1-vsementsov@yandex-team.ru>
 <20260710191809.721154-13-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260710191809.721154-13-vsementsov@yandex-team.ru>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jul 10, 2026 at 10:18:01PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Support transferring of TAP state (including open fd).
> 
> Add new property "local-migration-supported", which defines
> whether local-migration is actually supported for this TAP device.
> Starting from 11.2 QEMU Machine Types it's enabled by default.
> 
> Note, that local-migration (including migrating opened FDs
> through migration channel, which must be UNIX socket), is
> enabled by global "local" migration parameters. But individual
> devices may have additional options to enable/disable it
> per device.
> 
> The tricky thing, is that we need to know, should we do
> call open/connect in TAP initialization code. That means,
> that on incoming migration we want to know status of
> "local" migration parameter at time of creating TAP device.
> So, currently, for incoming local migration only TAP device
> created through QMP is supported, as you need to set migration
> parameter first (through QMP as well).
> 
> So the full picture is:
> 
> On source, to start outgoing "local" migration you need:
> 
>  - migration parameter "local" set to true
>  - "local-migration-supported" TAP option set to true (the
>    default, starting from 11.2 QEMU Machine Types)
> 
> If at least one of these options is not set, TAP backend
> doesn't participate in migration.
> 
> On target, things are more difficult:
> 
> Same, you need both "local" and "local-migration-supported"
> be set. And same, if one of them is not set, TAP backend
> is initialized as usual, and doesn't accept any incoming
> state.
> 
> Additionally, if you are going to set "local", it must be
> set before creating the TAP device. If TAP device created
> with "local" unset, it initializes as usual. If you enable
> "local" after it and start incoming migration, it will fail
> in .pre_load handler of TAP backend.
> 
> Moreover, there are interface restrictions: if you create TAP
> device when QEMU is in INCOMING state, and both "local"
> and "local-migration-supported" set, most of TAP options are
> not allowed, and script/downscript are required to be explicitly
> unset (set to "" or "no").
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
> 
> In v17 thread we considered making new qapi parameters "unstable".
> Still, it was because of doubtful "incoming-fds" parameter. In this
> v18 it's completely removed, and we may live only with "local"
> migration parameter + "local-migration-supported" TAP option.
> This way the series doesn't conflict with suggested by Peter
>   [PATCH RFC 0/2] migration/vl: new -incoming config:* for early migration parameters
> So, I think, worth making one more iteration as "stable candidate".
> If still some doubts, not problem for me to resend with "unstable" features.
> 
>  hw/core/machine.c |   7 ++
>  net/tap.c         | 162 ++++++++++++++++++++++++++++++++++++++++++++--
>  qapi/net.json     |  23 ++++++-
>  3 files changed, 185 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 15886a56b19..2a1abb29041 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -36,10 +36,16 @@
>  #include "hw/virtio/virtio-pci.h"
>  #include "hw/virtio/virtio-net.h"
>  #include "hw/virtio/virtio-iommu.h"
> +#include "net/tap.h"
>  #include "hw/acpi/generic_event_device.h"
>  #include "qemu/audio.h"
>  #include "hw/arm/smmuv3.h"
>  
> +/*
> + * TODO: When hw_compat_11_1 appears, local-migration-supported=false
> + * for TYPE_TAP_NETDEV should be move to it from hw_compat_11_0.
> + */
> +
>  GlobalProperty hw_compat_11_0[] = {
>      { "chardev-vc", "encoding", "cp437" },
>      { "tpm-crb", "cap-chunk", "off" },
> @@ -49,6 +55,7 @@ GlobalProperty hw_compat_11_0[] = {
>      { TYPE_ARM_SMMUV3, "ssidsize", "0" },
>      { TYPE_ARM_SMMUV3, "oas", "44" },
>      { "migration", "switchover-ack-legacy", "on" },
> +    { TYPE_TAP_NETDEV, "local-migration-supported", "false" },

So disabled by default for historical machines type versions, but....

> +static void tap_instance_init(Object *obj)
> +{
> +    TAPState *s = TAP_NETDEV(obj);
> +    s->local_migration_supported = true;
> +}

..enabled by default for all future machine type versions, but...


> @@ -1005,6 +1123,23 @@ int net_init_tap(const Netdev *netdev, const char *name,
>          return -1;
>      }
>  
> +    incoming_fds = tap->local_migration_supported && migrate_local() &&
> +                   runstate_check(RUN_STATE_INMIGRATE);
> +
> +    if (incoming_fds &&
> +        (tap->fd || tap->fds || tap->helper || tap->br || tap->ifname ||
> +         tap->has_sndbuf || tap->has_vnet_hdr ||
> +         !tap_is_explicit_no_script(tap->script) ||
> +         !tap_is_explicit_no_script(tap->downscript))) {
> +        error_setg(errp, "Local incoming migration of TAP device (-incoming, "
> +                   "migration parameter @local is set, "
> +                   "TAP parameter @local-migration-supported is set) "
> +                   "is incompatible with "
> +                   "fd=, fds=, helper=, br=, ifname=, sndbuf= and vnet_hdr=, "
> +                   "and requires explicit empty script= and downscript=");
> +        return -1;
> +    }

...not usable by default unless the mgmt app knows to avoid these settings,
but the user won't find out about this limit until they try to migrate and
it fails at runtime, months or years after the VM was first configured &
launched :-(

AFAICT, there's also no way for mgmt apps to determine which parameters
are forbidden, because it is merely exposed in API docs text, no way to
introspect

IMHO the sane way to do this is to not have any "local-migration-supported"
device flag at all, and also no "local" migration parameter. The src & dst
QEMU's so badly need to be able to auto-negotiate and just do the right
thing, otherwise this local migration optimization becomes a mgmt nightmare
long term :-(

And yet we don't have any auto-negotiate mechanism, and I don't want to
block your work :-(

I'm annoyed that we keep creating more and more pain for both ourselves
and our mgmt apps in migration for as long as we don't address this
fundamental migration protocol design flaw.

> diff --git a/qapi/net.json b/qapi/net.json
> index ada0329ef9d..2070979f20e 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -435,6 +435,26 @@
>  # @poll-us: maximum number of microseconds that could be spent on busy
>  #     polling for tap (since 2.7)
>  #
> +# @local-migration-supported: enable local migration for this TAP
> +#     backend.  When set, local migration is enabled/disabled by
> +#     migration parameter @local for this TAP backend.  When unset,
> +#     migration parameter @local is ignored for this TAP backend.
> +#     To be able to do incoming local migration of TAP backend,
> +#     migration parameter @local must be set _before_ creating the
> +#     TAP backend.  Otherwise, TAP backend is initialized as usual,
> +#     opening/creating TAP devices in kernel.  In this case further
> +#     local incoming migration (with migration parameter @local set
> +#     after creating TAP backend with @local-migration-supporeted
> +#     parameter set) will simply fail.
> +#     Moreover, when QEMU is in incoming migration state, migration
> +#     parameter @local is set and @local-migration-supported is set,
> +#     following options are not supported and must not be set:
> +#     @ds, @fds, @helper, @br, @ifname, @sndbuf, @vnet_hdr.
> +#     Additionally in this case @script and @downscipt must be
> +#     explicitly disabled (empty strings or "no").
> +#     (Since 11.2.  Defaults to true for QEMU Machine Types >= 11.2,
> +#     and to false for QEMU Machine Types < 11.2)



> +#
>  # Since: 1.2
>  ##
>  { 'struct': 'NetdevTapOptions',
> @@ -453,7 +473,8 @@
>      '*vhostfds':   'str',
>      '*vhostforce': 'bool',
>      '*queues':     'uint32',
> -    '*poll-us':    'uint32'} }
> +    '*poll-us':    'uint32',
> +    '*local-migration-supported': 'bool' } }
>  
>  ##
>  # @NetdevSocketOptions:
> -- 
> 2.43.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C08C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 19:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjMRt-0005w9-Cz; Mon, 13 Jul 2026 15:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wjMRr-0005w0-OF
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 15:36:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wjMRo-0002DN-Nf
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 15:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783971370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cWBsE2Ah1+sRflDClg2F1sp1Me1pjCTYE6PZpaQNdc4=;
 b=XXSxMbj5BPuWBHFTD238Vf4UYpHU4T3bKx2qH7ns4OdtAHp6www/3rHu6y5INDO8Ygzdjv
 WOP1q9ndnE8Lx/HX2bRiqVp4y69nfIdVc9j0kG66769cd9I8EClCzu6Cwv014FA9bsh/Ue
 A6dYJ6a/AJVXlG0yOia0q6UMNmdodHY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-cpsyBENRNp2BjJNngS4N3g-1; Mon, 13 Jul 2026 15:36:09 -0400
X-MC-Unique: cpsyBENRNp2BjJNngS4N3g-1
X-Mimecast-MFC-AGG-ID: cpsyBENRNp2BjJNngS4N3g_1783971368
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47eaa4006a1so119806f8f.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 12:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783971368; x=1784576168; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cWBsE2Ah1+sRflDClg2F1sp1Me1pjCTYE6PZpaQNdc4=;
 b=P+TNrIqhNVy9yTsvTkBPjWL7P4nDoT4Kw3m4y1op1LdqFrMqBTuewv2D0M6VYtFHAo
 sXE3vYrPAUUJFAJgPwRcsAFKJLH3bl3LNrNHQNCP0D/NGNUgF2S2zGkLXHSdgApMEkWB
 iPCShdxihUM5TRMQZ+JOld6O/L4METutl0owUlGT/27JQBmhv7br4i4K3dFSejZOkbcJ
 356Lf98ectTRMIrQC4RO5LZzywXSv4cUNyE5vjWZokvZFnJCpuVkEEHuIuFjOSQD4r4w
 CmDivbMA9zYAckOsgggSciVmXcQ88gQL02NPC5JH7zA0vr/W5pBDlMquII0nbx1L7HB1
 Ud9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783971368; x=1784576168;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cWBsE2Ah1+sRflDClg2F1sp1Me1pjCTYE6PZpaQNdc4=;
 b=e6wZ601ixBzNiv4n1pmahP0EAsHzB2w7uDA1QpoT9dsyNa8ZNPIQBWVFfkbbaFYALY
 JHkCNmkpLtRSUdEhJE3Oa8Jtd3hNZeYiR6Dfp8JQCv39n6/U25j8MOwEocgiYCx1Wfgo
 Om9AT9tyrC75ExUg8UTzxQN7BOy8+gmOo8NRHc872prLVRlMjsSXhh9v2yjQhmBUCrAH
 eny7Y/bb7U8nTotvhXRfrHUzloE/uJXKch90jU+6EkUNZuHO/qVAoVM6GwzV05xU+Y/q
 qo5vKvfDNSMG8+G9UoP7cKHUqTtwwuyaQddPL5PWcafTDy+ps5dhjlgP5fKnV/0H0hFq
 hwhw==
X-Forwarded-Encrypted: i=1;
 AHgh+RohFebZSnsMgNl5sYoXjd60mSeTOrhVDKAAFGGb9vwPTaXeG4SUqC9MC7r6O1NBFHN88lsqkAjku+uf@nongnu.org
X-Gm-Message-State: AOJu0YyUCTFRfPzBO/AYNOyCqx+Kzv56Cu7kushwAezmmarYwK/G+fej
 I/3fucwen4CV11svvtYv7GfhLWqgIzTAERuN58Ghh9VpJZvECMwDS+9viFRN+ytjf5w161T84Cd
 yz9bB4h3aQQHojOBh6x9hAj+bYBZIeclrcnyx97zP8ERgyEb9gDaKHlqY
X-Gm-Gg: AfdE7clxARMoYbihIPgfWT5C+8veKBt1T1SW4+jYOyFdsEVYrv92PxwU64OQssyW8qo
 QhrkwBx7QrKmvLTXlCQygira7Ou+b44J3gzixG1Y8NNhi2Daz6/vRIzOp7wnXkICuQnjaRmM900
 n/DendlXPml2dVNEgCGY6kRHloHXw2YTtaO1MkFqNgLmchCEMBN/bUhOM4lt8OAB6gvMXISVxZa
 RTlFLCIhbnf2RA132CDjJOcQI6A2n1yEKpoqa7kCkbGDvx1qpfcLRzewHZAEnp5b3P9m4BROny9
 CQs0xzRZSZMVcTzHpMkyy8/aFaFbOJ4NQZldJrPCZE4Xz0yYFKUJjlhjIi0gnGddGf7klqeYCrA
 FeV+pF1vHvHIlX4e1RSJ6KiwmJTgLWo2LIms=
X-Received: by 2002:a05:6000:184d:b0:474:3708:c8 with SMTP id
 ffacd0b85a97d-47f2dcc0d79mr12314521f8f.15.1783971367882; 
 Mon, 13 Jul 2026 12:36:07 -0700 (PDT)
X-Received: by 2002:a05:6000:184d:b0:474:3708:c8 with SMTP id
 ffacd0b85a97d-47f2dcc0d79mr12314484f8f.15.1783971367202; 
 Mon, 13 Jul 2026 12:36:07 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-24-117.inter.net.il. [80.230.24.117])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464c1f84sm1827633f8f.29.2026.07.13.12.36.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 12:36:06 -0700 (PDT)
Date: Mon, 13 Jul 2026 15:36:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com, armbru@redhat.com, peterx@redhat.com,
 farosas@suse.de, raphael.s.norwitz@gmail.com, bchaney@akamai.com,
 qemu-devel@nongnu.org, berrange@redhat.com, pbonzini@redhat.com,
 yc-core@yandex-team.ru, mark.caveayland@nutanix.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Jason Wang <jasowangio@gmail.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v18 12/14] net/tap: support local migration with virtio-net
Message-ID: <20260713153340-mutt-send-email-mst@kernel.org>
References: <20260710191809.721154-1-vsementsov@yandex-team.ru>
 <20260710191809.721154-13-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710191809.721154-13-vsementsov@yandex-team.ru>
Received-SPF: permerror client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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


I am still confused why is this per device. I just do not
see where is it useful to set it for some devices
but not others. So it looks like a machine property
"incoming local migration" to me?

Sorry if I am being dense.


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
>  };
>  const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
>  
> diff --git a/net/tap.c b/net/tap.c
> index 605e5867b01..adcac70b7ea 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -38,12 +38,17 @@
>  #include "monitor/monitor.h"
>  #include "system/runstate.h"
>  #include "system/system.h"
> +#include "migration/misc.h"
>  #include "qapi/error.h"
>  #include "qemu/cutils.h"
>  #include "qemu/error-report.h"
>  #include "qemu/main-loop.h"
>  #include "qemu/sockets.h"
>  #include "hw/virtio/vhost.h"
> +#include "hw/core/vmstate-if.h"
> +#include "migration/vmstate.h"
> +#include "qom/object.h"
> +#include "qom/compat-properties.h"
>  
>  #include "net/tap.h"
>  #include "net/util.h"
> @@ -71,6 +76,8 @@ static const int kernel_feature_bits[] = {
>  
>  OBJECT_DECLARE_SIMPLE_TYPE(TAPState, TAP_NETDEV)
>  
> +static const VMStateDescription vmstate_tap;
> +
>  struct TAPState {
>      Object parent_obj;
>  
> @@ -95,6 +102,7 @@ struct TAPState {
>      int queue_index;
>      bool read_poll_detached;
>      VMChangeStateEntry *vmstate;
> +    bool local_migration_supported;
>  };
>  
>  static void launch_script(const char *setup_script, const char *ifname,
> @@ -405,6 +413,8 @@ static void tap_cleanup(NetClientState *nc)
>      tap_write_poll(s, false);
>      close(s->fd);
>      s->fd = -1;
> +
> +    vmstate_unregister(VMSTATE_IF(s), &vmstate_tap, s);
>  }
>  
>  static void tap_poll(NetClientState *nc, bool enable)
> @@ -441,6 +451,73 @@ static VHostNetState *tap_get_vhost_net(NetClientState *nc)
>      return s->vhost_net;
>  }
>  
> +static bool tap_is_wait_incoming(NetClientState *nc)
> +{
> +    TAPState *s = container_of(nc, TAPState, nc);
> +    assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
> +    return s->fd == -1;
> +}
> +
> +static int tap_pre_load(void *opaque)
> +{
> +    TAPState *s = opaque;
> +
> +    if (s->fd != -1) {
> +        error_report(
> +            "TAP is already initialized and cannot receive incoming fd");
> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}
> +
> +static bool tap_setup_vhost(TAPState *s, Error **errp);
> +
> +static int tap_post_load(void *opaque, int version_id)
> +{
> +    TAPState *s = opaque;
> +    Error *local_err = NULL;
> +
> +    tap_read_poll(s, true);
> +
> +    if (s->fd < 0) {
> +        return -1;
> +    }
> +
> +    if (!tap_setup_vhost(s, &local_err)) {
> +        error_prepend(&local_err,
> +                      "Failed to setup vhost during TAP post-load: ");
> +        error_report_err(local_err);
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +static bool tap_needed(void *opaque)
> +{
> +    TAPState *s = opaque;
> +
> +    return s->local_migration_supported && migrate_local();
> +}
> +
> +static const VMStateDescription vmstate_tap = {
> +    .name = "net-tap",
> +    .priority = MIG_PRI_BACKEND,
> +    .pre_load = tap_pre_load,
> +    .post_load = tap_post_load,
> +    .needed = tap_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_FD(fd, TAPState),
> +        VMSTATE_BOOL(using_vnet_hdr, TAPState),
> +        VMSTATE_BOOL(has_ufo, TAPState),
> +        VMSTATE_BOOL(has_uso, TAPState),
> +        VMSTATE_BOOL(has_tunnel, TAPState),
> +        VMSTATE_BOOL(enabled, TAPState),
> +        VMSTATE_UINT32(host_vnet_hdr_len, TAPState),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
>  
>  static char *tap_vmstate_if_get_id(VMStateIf *obj)
>  {
> @@ -449,17 +526,42 @@ static char *tap_vmstate_if_get_id(VMStateIf *obj)
>      return res;
>  }
>  
> +static bool tap_get_local_migration_supported_prop(Object *obj, Error **errp)
> +{
> +    TAPState *s = TAP_NETDEV(obj);
> +    return s->local_migration_supported;
> +}
> +
> +static void tap_set_local_migration_supported_prop(Object *obj, bool value,
> +                                                   Error **errp)
> +{
> +    TAPState *s = TAP_NETDEV(obj);
> +    s->local_migration_supported = value;
> +}
> +
> +static void tap_instance_init(Object *obj)
> +{
> +    TAPState *s = TAP_NETDEV(obj);
> +    s->local_migration_supported = true;
> +}
> +
>  static void tap_class_init(ObjectClass *klass, const void *data)
>  {
>      VMStateIfClass *vc = VMSTATE_IF_CLASS(klass);
>  
>      vc->get_id = tap_vmstate_if_get_id;
> +
> +    object_class_property_add_bool(klass, "local-migration-supported",
> +                                   tap_get_local_migration_supported_prop,
> +                                   tap_set_local_migration_supported_prop);
>  }
>  
>  static const TypeInfo tap_netdev_info = {
>      .name = TYPE_TAP_NETDEV,
>      .parent = TYPE_OBJECT,
>      .instance_size = sizeof(TAPState),
> +    .instance_init = tap_instance_init,
> +    .instance_post_init = object_apply_compat_props,
>      .class_init = tap_class_init,
>      .interfaces = (const InterfaceInfo[]) {
>          { TYPE_VMSTATE_IF },
> @@ -492,13 +594,16 @@ static NetClientInfo net_tap_info = {
>      .set_vnet_le = tap_set_vnet_le,
>      .set_vnet_be = tap_set_vnet_be,
>      .set_steering_ebpf = tap_set_steering_ebpf,
> +    .is_wait_incoming = tap_is_wait_incoming,
>      .get_vhost_net = tap_get_vhost_net,
>  };
>  
>  static TAPState *new_tap(NetClientState *peer,
>                           const char *model,
>                           const char *name,
> -                         int queue_index)
> +                         int queue_index,
> +                         bool has_local_migration_supported,
> +                         bool local_migration_supported)
>  {
>      TAPState *s = TAP_NETDEV(object_new(TYPE_TAP_NETDEV));
>  
> @@ -507,6 +612,12 @@ static TAPState *new_tap(NetClientState *peer,
>  
>      s->queue_index = queue_index;
>  
> +    if (has_local_migration_supported) {
> +        s->local_migration_supported = local_migration_supported;
> +    }
> +
> +    vmstate_register(VMSTATE_IF(s), VMSTATE_INSTANCE_ID_ANY, &vmstate_tap, s);
> +
>      return s;
>  }
>  
> @@ -515,10 +626,14 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
>                                   const char *name,
>                                   int fd,
>                                   int vnet_hdr,
> -                                 int queue_index)
> +                                 int queue_index,
> +                                 bool has_local_migration_supported,
> +                                 bool local_migration_supported)
>  {
>      NetOffloads ol = {};
> -    TAPState *s = new_tap(peer, model, name, queue_index);
> +    TAPState *s = new_tap(peer, model, name, queue_index,
> +                          has_local_migration_supported,
> +                          local_migration_supported);
>  
>      s->fd = fd;
>      s->host_vnet_hdr_len = vnet_hdr ? sizeof(struct virtio_net_hdr) : 0;
> @@ -755,7 +870,7 @@ int net_init_bridge(const Netdev *netdev, const char *name,
>          close(fd);
>          return -1;
>      }
> -    s = net_tap_fd_init(peer, "bridge", name, fd, vnet_hdr, 0);
> +    s = net_tap_fd_init(peer, "bridge", name, fd, vnet_hdr, 0, true, false);
>  
>      qemu_set_info_str(&s->nc, "helper=%s,br=%s", helper, br);
>  
> @@ -835,7 +950,9 @@ static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
>                               Error **errp)
>  {
>      TAPState *s = net_tap_fd_init(peer, tap->helper ? "bridge" : "tap",
> -                                  name, fd, vnet_hdr, queue_index);
> +                                  name, fd, vnet_hdr, queue_index,
> +                                  tap->has_local_migration_supported,
> +                                  tap->local_migration_supported);
>      bool sndbuf_required = tap->has_sndbuf;
>      int sndbuf =
>          (tap->has_sndbuf && tap->sndbuf) ? MIN(tap->sndbuf, INT_MAX) : INT_MAX;
> @@ -983,6 +1100,7 @@ int net_init_tap(const Netdev *netdev, const char *name,
>      /* for the no-fd, no-helper case */
>      char ifname[128];
>      int *fds = NULL, *vhost_fds = NULL;
> +    bool incoming_fds;
>  
>      assert(netdev->type == NET_CLIENT_DRIVER_TAP);
>      tap = &netdev->u.tap;
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
> +
>      queues = tap_parse_fds_and_queues(tap, &fds, errp);
>      if (queues < 0) {
>          return -1;
> @@ -1023,7 +1158,22 @@ int net_init_tap(const Netdev *netdev, const char *name,
>          goto fail;
>      }
>  
> -    if (fds) {
> +    if (incoming_fds) {
> +        for (i = 0; i < queues; i++) {
> +            TAPState *s = new_tap(peer, "tap", name, i,
> +                                  tap->has_local_migration_supported,
> +                                  tap->local_migration_supported);
> +            qemu_set_info_str(&s->nc, "incoming");
> +
> +            s->fd = -1;
> +            if (vhost_fds) {
> +                s->vhostfd = vhost_fds[i];
> +                s->vhost_busyloop_timeout = tap->has_poll_us ? tap->poll_us : 0;
> +            } else {
> +                s->vhostfd = -1;
> +            }
> +        }
> +    } else if (fds) {
>          for (i = 0; i < queues; i++) {
>              if (i == 0) {
>                  vnet_hdr = tap_probe_vnet_hdr(fds[i], errp);
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



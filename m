Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571DFCD4F5F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 08:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJT5a-0001Jl-0X; Thu, 13 Nov 2025 03:53:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vJT5T-0001D9-AG
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 03:53:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vJT5O-0001qH-Se
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 03:53:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763024025;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=5xpAhBR+RDcMUel8zK04PX2o2nGk1xXVph5O4YzxwBI=;
 b=eCtq3H0yU+WSHsWSunSEhjJhok2tV3W5RZw0KbQ+uAju0jG7l1PWoNCzSf4P+InI5hrkij
 IC9vNEqv+dtBWyShP95G2ZY6lg5IHql6+pJscU1mZk+ScaEW3o4ch/tKkgynqeWwN3cUy5
 YeIn45bN2udPyiZuy35VAFtPVsyesRw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-Us67bDswOFG8AA-cnFVmqw-1; Thu,
 13 Nov 2025 03:53:39 -0500
X-MC-Unique: Us67bDswOFG8AA-cnFVmqw-1
X-Mimecast-MFC-AGG-ID: Us67bDswOFG8AA-cnFVmqw_1763024018
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3602119560A1; Thu, 13 Nov 2025 08:53:38 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.56])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C8171955F1B; Thu, 13 Nov 2025 08:53:34 +0000 (UTC)
Date: Thu, 13 Nov 2025 08:53:30 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, mst@redhat.com,
 qemu-devel@nongnu.org, farosas@suse.de, jinpu.wang@ionos.com,
 thuth@redhat.com
Subject: Re: [RFC PATCH] virtio-net: introduce strict peer feature check
Message-ID: <aRWcimmBN23VzH55@redhat.com>
References: <20251107020149.3223-1-jasowang@redhat.com>
 <aRUCXvHkpfZgZCR0@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aRUCXvHkpfZgZCR0@x1.local>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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

On Wed, Nov 12, 2025 at 04:55:42PM -0500, Peter Xu wrote:
> On Fri, Nov 07, 2025 at 10:01:49AM +0800, Jason Wang wrote:
> > We used to clear features silently in virtio_net_get_features() even
> > if it is required. This complicates the live migration compatibility
> > as the management layer may think the feature is enabled but in fact
> > not.
> > 
> > Let's add a strict feature check to make sure if there's a mismatch
> > between the required feature and peer, fail the get_features()
> > immediately instead of waiting until the migration to fail. This
> > offload the migration compatibility completely to the management
> > layer.
> > 
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> 
> Jason, thanks for help looking into the problem!
> 
> Am I right that after this patch applied, whenever a new QEMU boots with
> the new machine types (e.g. having USO* by default ON), will fail to boot
> on an old kernel that doesn't support USO*, but ask the users to turn off
> USO* features explicitly in the virtio-net devices?

What kernel version are we talking about where there will be
incompatibility ?  Is it old enough that it pre-dates our
platform support matrix requirements ?  Ubuntu 22.04 and
RHEL-9 are currently our targets with the oldest kernels
that we need to retain compatibility with as the bare min.
I would expect machine types to work on these old platforms
without users to having to manually disable default set
features.



> 
> Thanks,
> 
> > ---
> >  hw/core/machine.c              |   1 +
> >  hw/net/virtio-net.c            | 153 +++++++++++++++++++++++++--------
> >  include/hw/virtio/virtio-net.h |   1 +
> >  3 files changed, 119 insertions(+), 36 deletions(-)
> > 
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index 681adbb7ac..a9e43c4990 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -40,6 +40,7 @@
> >  
> >  GlobalProperty hw_compat_10_1[] = {
> >      { TYPE_ACPI_GED, "x-has-hest-addr", "false" },
> > +    { TYPE_VIRTIO_NET, "strict-peer-feature-check", "false"},
> >  };
> >  const size_t hw_compat_10_1_len = G_N_ELEMENTS(hw_compat_10_1);
> >  
> > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> > index 33116712eb..3acc5ed4a6 100644
> > --- a/hw/net/virtio-net.c
> > +++ b/hw/net/virtio-net.c
> > @@ -3090,53 +3090,120 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
> >      virtio_add_feature_ex(features, VIRTIO_NET_F_MAC);
> >  
> >      if (!peer_has_vnet_hdr(n)) {
> > -        virtio_clear_feature_ex(features, VIRTIO_NET_F_CSUM);
> > -        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_TSO4);
> > -        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_TSO6);
> > -        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_ECN);
> > -
> > -        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_CSUM);
> > -        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_TSO4);
> > -        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_TSO6);
> > -        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_ECN);
> > -
> > -        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_USO);
> > -        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO4);
> > -        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
> > -
> > -        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO);
> > -        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO);
> > -        virtio_clear_feature_ex(features,
> > -                                VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM);
> > -        virtio_clear_feature_ex(features,
> > -                                VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM);
> > +        if (n->strict_peer_feature_check) {
> > +            if (virtio_has_feature_ex(features, VIRTIO_NET_F_CSUM) |
> > +                virtio_has_feature_ex(features, VIRTIO_NET_F_HOST_TSO4) |
> > +                virtio_has_feature_ex(features, VIRTIO_NET_F_HOST_TSO6) |
> > +                virtio_has_feature_ex(features, VIRTIO_NET_F_HOST_ECN) |
> > +                virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_CSUM) |
> > +                virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_TSO4) |
> > +                virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_TSO6) |
> > +                virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_ECN) |
> > +                virtio_has_feature_ex(features, VIRTIO_NET_F_HOST_USO) |
> > +                virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_USO4) |
> > +                virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_USO6) |
> > +                virtio_has_feature_ex(features,
> > +                                      VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |
> > +                virtio_has_feature_ex(features,
> > +                                      VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO) |
> > +                virtio_has_feature_ex(features,
> > +                                      VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM) |
> > +                virtio_has_feature_ex(features,
> > +                                      VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM) |
> > +                virtio_has_feature_ex(features,
> > +                                      VIRTIO_NET_F_HASH_REPORT)) {
> > +                error_setg(errp, "virtio_net: peer doesn't support vnet hdr");
> > +                return;
> > +            }
> > +        } else {
> > +            virtio_clear_feature_ex(features, VIRTIO_NET_F_CSUM);
> > +            virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_TSO4);
> > +            virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_TSO6);
> > +            virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_ECN);
> > +
> > +            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_CSUM);
> > +            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_TSO4);
> > +            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_TSO6);
> > +            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_ECN);
> > +
> > +            virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_USO);
> > +            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO4);
> > +            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
> > +
> > +            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO);
> > +            virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO);
> > +            virtio_clear_feature_ex(features,
> > +                                    VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM);
> > +            virtio_clear_feature_ex(features,
> > +                                    VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM);
> >  
> > -        virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
> > +            virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
> > +        }
> >      }
> >  
> >      if (!peer_has_vnet_hdr(n) || !peer_has_ufo(n)) {
> > -        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_UFO);
> > -        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_UFO);
> > +        if (n->strict_peer_feature_check) {
> > +            if (virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_UFO) |
> > +                virtio_has_feature_ex(features, VIRTIO_NET_F_HOST_UFO)) {
> > +                error_setg(errp, "virtio_net: peer doesn't support UFO");
> > +                return;
> > +            }
> > +        } else {
> > +            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_UFO);
> > +            virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_UFO);
> > +        }
> >      }
> >      if (!peer_has_uso(n)) {
> > -        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_USO);
> > -        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO4);
> > -        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
> > +        if (n->strict_peer_feature_check) {
> > +            if (virtio_has_feature_ex(features, VIRTIO_NET_F_HOST_USO) |
> > +                virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_USO4) |
> > +                virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_USO6)) {
> > +                error_setg(errp, "virtio_net: peer doesn't support USO");
> > +                return;
> > +            }
> > +        } else {
> > +            virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_USO);
> > +            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO4);
> > +            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
> > +        }
> >      }
> >  
> >      if (!peer_has_tunnel(n)) {
> > -        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO);
> > -        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO);
> > -        virtio_clear_feature_ex(features,
> > -                                VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM);
> > -        virtio_clear_feature_ex(features,
> > -                                VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM);
> > +        if (n->strict_peer_feature_check) {
> > +            if (virtio_has_feature_ex(features,
> > +                                      VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |
> > +                virtio_has_feature_ex(features,
> > +                                      VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO) |
> > +                virtio_has_feature_ex(features,
> > +                                      VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM) |
> > +                virtio_has_feature_ex(features,
> > +                                      VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM)) {
> > +                error_setg(errp, "virtio_net: peer doesn't support tunnel GSO");
> > +                return;
> > +            }
> > +        } else {
> > +            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO);
> > +            virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO);
> > +            virtio_clear_feature_ex(features,
> > +                                    VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM);
> > +            virtio_clear_feature_ex(features,
> > +                                    VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM);
> > +        }
> >      }
> >  
> >      if (!get_vhost_net(nc->peer)) {
> >          if (!use_own_hash) {
> > -            virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
> > -            virtio_clear_feature_ex(features, VIRTIO_NET_F_RSS);
> > +            if (n->strict_peer_feature_check) {
> > +                if (virtio_has_feature_ex(features, VIRTIO_NET_F_HASH_REPORT) |
> > +                    virtio_has_feature_ex(features, VIRTIO_NET_F_RSS)) {
> > +                    error_setg(errp,
> > +                               "virtio_net: peer doesn't support RSS/HASH_REPORT");
> > +                    return;
> > +                }
> > +            } else {
> > +                virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
> > +                virtio_clear_feature_ex(features, VIRTIO_NET_F_RSS);
> > +            }
> >          } else if (virtio_has_feature_ex(features, VIRTIO_NET_F_RSS)) {
> >              virtio_net_load_ebpf(n, errp);
> >          }
> > @@ -3145,14 +3212,26 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
> >      }
> >  
> >      if (!use_peer_hash) {
> > -        virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
> > +        if (n->strict_peer_feature_check &&
> > +            virtio_has_feature_ex(features, VIRTIO_NET_F_HASH_REPORT)) {
> > +            error_setg(errp, "virtio_net: peer doesn't HASH_REPORT");
> > +            return;
> > +        } else {
> > +            virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
> > +        }
> >  
> >          if (!use_own_hash || !virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
> >              if (!virtio_net_load_ebpf(n, errp)) {
> >                  return;
> >              }
> >  
> > -            virtio_clear_feature_ex(features, VIRTIO_NET_F_RSS);
> > +            if (n->strict_peer_feature_check &&
> > +                virtio_has_feature_ex(features, VIRTIO_NET_F_RSS)) {
> > +                error_setg(errp, "virtio_net: fail to attach eBPF for RSS");
> > +                return;
> > +            } else {
> > +                virtio_clear_feature_ex(features, VIRTIO_NET_F_RSS);
> > +            }
> >          }
> >      }
> >  
> > @@ -4313,6 +4392,8 @@ static const Property virtio_net_properties[] = {
> >                                 host_features_ex,
> >                                 VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM,
> >                                 false),
> > +    DEFINE_PROP_BOOL("strict-peer-feature-check", VirtIONet,
> > +                     strict_peer_feature_check, true),
> >  };
> >  
> >  static void virtio_net_class_init(ObjectClass *klass, const void *data)
> > diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
> > index 5b8ab7bda7..abd4ca4bb0 100644
> > --- a/include/hw/virtio/virtio-net.h
> > +++ b/include/hw/virtio/virtio-net.h
> > @@ -222,6 +222,7 @@ struct VirtIONet {
> >      /* primary failover device is hidden*/
> >      bool failover_primary_hidden;
> >      bool failover;
> > +    bool strict_peer_feature_check;
> >      DeviceListener primary_listener;
> >      QDict *primary_opts;
> >      bool primary_opts_from_json;
> > -- 
> > 2.34.1
> > 
> 
> -- 
> Peter Xu
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



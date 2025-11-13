Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD84CD8C9A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 16:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJZth-0000T1-Kl; Thu, 13 Nov 2025 11:10:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vJZtR-00009W-MZ
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 11:09:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vJZtN-0008IG-FG
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 11:09:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763050183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZrU7OPtqlqhDQixvSe1o3KqbHqEP8BWEcynu5Wrr2+Y=;
 b=NYsRBry7iZrFsHNWGq8oiWKJk78ATmIK1EM80ch311aFfDa5Nq/LbrR1y6qj8vnoP2fsx4
 jgapR6fvpegvBY+8lblATTFVRqFKeoisWztnQN+CMiZRpQ6RDwnSQ977orj75tBFwZNrlI
 BX327U14CSMPsE/Wn4VLhxZOy72WOfk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-ijy_-BrEMtiF3mCnShq-aA-1; Thu, 13 Nov 2025 11:09:38 -0500
X-MC-Unique: ijy_-BrEMtiF3mCnShq-aA-1
X-Mimecast-MFC-AGG-ID: ijy_-BrEMtiF3mCnShq-aA_1763050178
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4777b59119dso12127495e9.2
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 08:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763050177; x=1763654977; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZrU7OPtqlqhDQixvSe1o3KqbHqEP8BWEcynu5Wrr2+Y=;
 b=FTzhS9Pyk850DbbdtNobtV1mrQEg5TtEUvhH9WAU8pl5o6mm1n3l+kMA2U9OdutKbw
 9liEWdNzFqBcBPDOiWnZBoBpIPGpJnNeJWEUuAMXcCC4AiFowPr0ZWMEmafKAz61PWLN
 tVe44IZBa1RUzxoKOsrypa+J9mXa9T5vKWzFqE5mF8MjX85+Nbw54WovB7+A+vHwjXCn
 dLDvpyN+vYAxgrOg+2BsHh3tyn8mk11b3A304jFRoatnmsC2gV+EJ2Va7cL1jLup0WHP
 2vXmyLNQlmhXEWgCg0Vma55M+PIJM8ugN9a1a3vVslcvFPh1i7oN2lXYczjLh9f9sR/8
 hoUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763050177; x=1763654977;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZrU7OPtqlqhDQixvSe1o3KqbHqEP8BWEcynu5Wrr2+Y=;
 b=b8578xVueY48k3Xlt2eqJvJjEQUf4bTlV5uxxt5BKSVxitkNM5EoJaX6tnDkmM4LWl
 Hm4skNUK9+fK0OZf7XayGx09pQNNdkgsMoAGASrZzK+m6Wh5eNYD6DA1/ZGQ4hxBBBAv
 mDvZxiQlCjnoFkEusr0iROuo1tWLCgoJpCY6kjB3g0YVbOHpvEZwiMq83WpywVAvaH+v
 qwxPnwjU0J4GvbM7Sjkz/yoB0G218fei9rG2/sZB+d0t7+A9jnZOrks/BYE/eqvee1j+
 B2KQCPd3YiPhv7OQJ003YUYPGfvlxLYhPDjPeaikZ8lSbMHKC1GrTmb/IXZFDoKOqSnY
 GyjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQCDuq5d6yQRohyH7dWZJh/E8dq32UdcXGURaYj0bsQe92SUTe1k5yUN0Zs4Ff7+Vl0S+v3RSAZ1Nq@nongnu.org
X-Gm-Message-State: AOJu0YyjPWthWv4DflEdxGeeEmuJVUPkKzK3OB8OvXIDb7T/l7GJHV33
 y+fVgy9jT8b8zcheOI8sPY7emVRNiBSHHtt0agcyFn0d2Fepwin/zA+dAi302pJD4ntuT8OKwxv
 GNoHSm7fVk2Pyz6Br7zXhBwBan6xsVHG5kGut5Q7lBzHtdaoUx8XFPdM4OfTG6CLFTyU=
X-Gm-Gg: ASbGncvkFXBN8KWCwxOLHvACgOLFhkNG+8hcLDCx1geTyFiR/httmyG2FYTttrCwXev
 mT0H6vWUXZm8E0Xcs6GOUhDVxvjVJe17jEEYFnr6M/4y6Mz5NblLdB502x7tmOiwvSofZkSRXS/
 C9yVOx1csTVHAVUogTWkerErB3nZJwzIPKEl9wO3f88Slk3LyaUP08uruIY7VdlhBf57oPfMQc/
 ioC94InFpzl/5cZNY4yoOn6CjGekHLfQwkA6PJUBYqtO8wi0AotU8is3zD6+nJvsiQgqoCKm5Ic
 8pobl7OpinRaE2BBuygEBrrFHbPi9/4tKoKXPEHfmLLR2eDVA2fWWqujDujfbGI3itC15PRuMXQ
 Y8cZTNHUbXXABJWX0edY=
X-Received: by 2002:a05:600c:c177:b0:477:7975:30ea with SMTP id
 5b1f17b1804b1-4778fea1336mr7075e9.29.1763050177203; 
 Thu, 13 Nov 2025 08:09:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBnTyu1NF5nxU8CtR3OeAJA/+GNLnHuGMAA78mGVIepPDe6LvKoCeWSVflRHxR9kU26hTtwg==
X-Received: by 2002:a05:600c:c177:b0:477:7975:30ea with SMTP id
 5b1f17b1804b1-4778fea1336mr6725e9.29.1763050176574; 
 Thu, 13 Nov 2025 08:09:36 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778bd27ad5sm23070965e9.16.2025.11.13.08.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 08:09:35 -0800 (PST)
Date: Thu, 13 Nov 2025 11:09:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, qemu-devel@nongnu.org,
 peterx@redhat.com, farosas@suse.de, jinpu.wang@ionos.com,
 thuth@redhat.com, berrange@redhat.com
Subject: Re: [RFC PATCH] virtio-net: introduce strict peer feature check
Message-ID: <20251113110004-mutt-send-email-mst@kernel.org>
References: <20251107020149.3223-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107020149.3223-1-jasowang@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Nov 07, 2025 at 10:01:49AM +0800, Jason Wang wrote:
> We used to clear features silently in virtio_net_get_features() even
> if it is required. This complicates the live migration compatibility
> as the management layer may think the feature is enabled but in fact
> not.
> 
> Let's add a strict feature check to make sure if there's a mismatch
> between the required feature and peer, fail the get_features()
> immediately instead of waiting until the migration to fail. This
> offload the migration compatibility completely to the management
> layer.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

This is not really useful - how do users know how to tweak their
command lines?
We discussed this many times.
To try and solve this you need a tool that will tell you how to start
VM on X to make it migrateable to Y or Z.


More importantly,
migration is a niche thing and breaking booting perfectly good VMs 
just for that seems wrong.


If you want to keep this off by default, and have management
enable this if it knows what it's doing, then I don't really
care.



> ---
>  hw/core/machine.c              |   1 +
>  hw/net/virtio-net.c            | 153 +++++++++++++++++++++++++--------
>  include/hw/virtio/virtio-net.h |   1 +
>  3 files changed, 119 insertions(+), 36 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 681adbb7ac..a9e43c4990 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -40,6 +40,7 @@
>  
>  GlobalProperty hw_compat_10_1[] = {
>      { TYPE_ACPI_GED, "x-has-hest-addr", "false" },
> +    { TYPE_VIRTIO_NET, "strict-peer-feature-check", "false"},
>  };
>  const size_t hw_compat_10_1_len = G_N_ELEMENTS(hw_compat_10_1);
>  
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 33116712eb..3acc5ed4a6 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3090,53 +3090,120 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
>      virtio_add_feature_ex(features, VIRTIO_NET_F_MAC);
>  
>      if (!peer_has_vnet_hdr(n)) {
> -        virtio_clear_feature_ex(features, VIRTIO_NET_F_CSUM);
> -        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_TSO4);
> -        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_TSO6);
> -        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_ECN);
> -
> -        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_CSUM);
> -        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_TSO4);
> -        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_TSO6);
> -        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_ECN);
> -
> -        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_USO);
> -        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO4);
> -        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
> -
> -        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO);
> -        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO);
> -        virtio_clear_feature_ex(features,
> -                                VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM);
> -        virtio_clear_feature_ex(features,
> -                                VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM);
> +        if (n->strict_peer_feature_check) {
> +            if (virtio_has_feature_ex(features, VIRTIO_NET_F_CSUM) |
> +                virtio_has_feature_ex(features, VIRTIO_NET_F_HOST_TSO4) |
> +                virtio_has_feature_ex(features, VIRTIO_NET_F_HOST_TSO6) |
> +                virtio_has_feature_ex(features, VIRTIO_NET_F_HOST_ECN) |
> +                virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_CSUM) |
> +                virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_TSO4) |
> +                virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_TSO6) |
> +                virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_ECN) |
> +                virtio_has_feature_ex(features, VIRTIO_NET_F_HOST_USO) |
> +                virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_USO4) |
> +                virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_USO6) |
> +                virtio_has_feature_ex(features,
> +                                      VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |
> +                virtio_has_feature_ex(features,
> +                                      VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO) |
> +                virtio_has_feature_ex(features,
> +                                      VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM) |
> +                virtio_has_feature_ex(features,
> +                                      VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM) |
> +                virtio_has_feature_ex(features,
> +                                      VIRTIO_NET_F_HASH_REPORT)) {
> +                error_setg(errp, "virtio_net: peer doesn't support vnet hdr");
> +                return;
> +            }
> +        } else {
> +            virtio_clear_feature_ex(features, VIRTIO_NET_F_CSUM);
> +            virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_TSO4);
> +            virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_TSO6);
> +            virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_ECN);
> +
> +            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_CSUM);
> +            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_TSO4);
> +            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_TSO6);
> +            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_ECN);
> +
> +            virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_USO);
> +            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO4);
> +            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
> +
> +            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO);
> +            virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO);
> +            virtio_clear_feature_ex(features,
> +                                    VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM);
> +            virtio_clear_feature_ex(features,
> +                                    VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM);
>  
> -        virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
> +            virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
> +        }
>      }
>  
>      if (!peer_has_vnet_hdr(n) || !peer_has_ufo(n)) {
> -        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_UFO);
> -        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_UFO);
> +        if (n->strict_peer_feature_check) {
> +            if (virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_UFO) |
> +                virtio_has_feature_ex(features, VIRTIO_NET_F_HOST_UFO)) {
> +                error_setg(errp, "virtio_net: peer doesn't support UFO");
> +                return;
> +            }
> +        } else {
> +            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_UFO);
> +            virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_UFO);
> +        }
>      }
>      if (!peer_has_uso(n)) {
> -        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_USO);
> -        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO4);
> -        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
> +        if (n->strict_peer_feature_check) {
> +            if (virtio_has_feature_ex(features, VIRTIO_NET_F_HOST_USO) |
> +                virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_USO4) |
> +                virtio_has_feature_ex(features, VIRTIO_NET_F_GUEST_USO6)) {
> +                error_setg(errp, "virtio_net: peer doesn't support USO");
> +                return;
> +            }
> +        } else {
> +            virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_USO);
> +            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO4);
> +            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_USO6);
> +        }
>      }
>  
>      if (!peer_has_tunnel(n)) {
> -        virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO);
> -        virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO);
> -        virtio_clear_feature_ex(features,
> -                                VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM);
> -        virtio_clear_feature_ex(features,
> -                                VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM);
> +        if (n->strict_peer_feature_check) {
> +            if (virtio_has_feature_ex(features,
> +                                      VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |
> +                virtio_has_feature_ex(features,
> +                                      VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO) |
> +                virtio_has_feature_ex(features,
> +                                      VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM) |
> +                virtio_has_feature_ex(features,
> +                                      VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM)) {
> +                error_setg(errp, "virtio_net: peer doesn't support tunnel GSO");
> +                return;
> +            }
> +        } else {
> +            virtio_clear_feature_ex(features, VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO);
> +            virtio_clear_feature_ex(features, VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO);
> +            virtio_clear_feature_ex(features,
> +                                    VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM);
> +            virtio_clear_feature_ex(features,
> +                                    VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM);
> +        }
>      }
>  
>      if (!get_vhost_net(nc->peer)) {
>          if (!use_own_hash) {
> -            virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
> -            virtio_clear_feature_ex(features, VIRTIO_NET_F_RSS);
> +            if (n->strict_peer_feature_check) {
> +                if (virtio_has_feature_ex(features, VIRTIO_NET_F_HASH_REPORT) |
> +                    virtio_has_feature_ex(features, VIRTIO_NET_F_RSS)) {
> +                    error_setg(errp,
> +                               "virtio_net: peer doesn't support RSS/HASH_REPORT");
> +                    return;
> +                }
> +            } else {
> +                virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
> +                virtio_clear_feature_ex(features, VIRTIO_NET_F_RSS);
> +            }
>          } else if (virtio_has_feature_ex(features, VIRTIO_NET_F_RSS)) {
>              virtio_net_load_ebpf(n, errp);
>          }
> @@ -3145,14 +3212,26 @@ static void virtio_net_get_features(VirtIODevice *vdev, uint64_t *features,
>      }
>  
>      if (!use_peer_hash) {
> -        virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
> +        if (n->strict_peer_feature_check &&
> +            virtio_has_feature_ex(features, VIRTIO_NET_F_HASH_REPORT)) {
> +            error_setg(errp, "virtio_net: peer doesn't HASH_REPORT");
> +            return;
> +        } else {
> +            virtio_clear_feature_ex(features, VIRTIO_NET_F_HASH_REPORT);
> +        }
>  
>          if (!use_own_hash || !virtio_net_attach_ebpf_to_backend(n->nic, -1)) {
>              if (!virtio_net_load_ebpf(n, errp)) {
>                  return;
>              }
>  
> -            virtio_clear_feature_ex(features, VIRTIO_NET_F_RSS);
> +            if (n->strict_peer_feature_check &&
> +                virtio_has_feature_ex(features, VIRTIO_NET_F_RSS)) {
> +                error_setg(errp, "virtio_net: fail to attach eBPF for RSS");
> +                return;
> +            } else {
> +                virtio_clear_feature_ex(features, VIRTIO_NET_F_RSS);
> +            }
>          }
>      }
>  
> @@ -4313,6 +4392,8 @@ static const Property virtio_net_properties[] = {
>                                 host_features_ex,
>                                 VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO_CSUM,
>                                 false),
> +    DEFINE_PROP_BOOL("strict-peer-feature-check", VirtIONet,
> +                     strict_peer_feature_check, true),
>  };
>  
>  static void virtio_net_class_init(ObjectClass *klass, const void *data)
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
> index 5b8ab7bda7..abd4ca4bb0 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -222,6 +222,7 @@ struct VirtIONet {
>      /* primary failover device is hidden*/
>      bool failover_primary_hidden;
>      bool failover;
> +    bool strict_peer_feature_check;
>      DeviceListener primary_listener;
>      QDict *primary_opts;
>      bool primary_opts_from_json;
> -- 
> 2.34.1



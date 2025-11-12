Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ADAACD4853
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 22:08:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJJ0s-0002Aj-4f; Wed, 12 Nov 2025 17:08:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJIoi-0005Lh-Ua
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 16:55:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vJIof-0003I2-Ij
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 16:55:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762984547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j3ZUMuwTNX7Dqo1vtiBXmt14e+7wCBUvIkZ0++wW0DM=;
 b=LMbl2pKndTHrMJ7qxGazJWMN2QrmDeBUdEOApXYBqmarojOfCqG8u9hRskOGgeMGX+NTkw
 UK556eeqEQOtMjwHf5Vf+OnS+FEApkzoNGzLXXbGbIMfQDQGDf/ZWVQ66Jlv/pp9uiH+1R
 1PIIG19U+LSZ+674tY1qdVGYdBQxEB0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-HaAnKoHOPmqksu-8wbJlMg-1; Wed, 12 Nov 2025 16:55:46 -0500
X-MC-Unique: HaAnKoHOPmqksu-8wbJlMg-1
X-Mimecast-MFC-AGG-ID: HaAnKoHOPmqksu-8wbJlMg_1762984546
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8b17194d321so43932385a.0
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 13:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762984546; x=1763589346; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=j3ZUMuwTNX7Dqo1vtiBXmt14e+7wCBUvIkZ0++wW0DM=;
 b=cxYJU1lDNRArFdDGjbcfEXLcP7XK+JUwv+TCDPfcY3ITPUoyGfod1yNYWQd6BZd/xj
 A1P0IPopwixzIpQtCe8RyiNKLHNxyc4VRZDxuNUOR/aay9r9BWvrrz/EubBak2PfP8oI
 jhLJPCn8xBVb4YCskdavQTe4rmhJzTTXMp1QCTQjku7NPYDHgVvSZ1dagmULFxPtAjrm
 A7a0JX+fIrvTNmmU747aaC8tInQT3qjgYX8QB7M797NZ77GphfryTpQqWeJljJoKjQnm
 AkwWrikV26ZSVS27eeg872a0JA6OZZWFsAvZDhGIkC5aP9Bhav3OxYEv/xcwieoyYy9x
 Yp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762984546; x=1763589346;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j3ZUMuwTNX7Dqo1vtiBXmt14e+7wCBUvIkZ0++wW0DM=;
 b=kNfqmBsNil7Wo9Wv1BfZB/id6I0YlWGfmzPZPm5C9EVEb8/lSo0i8JbIqauzweJM2B
 3DQh8Zo4ZmOnHUM40xHkz1b9uXT9aeoQWYGH++DMwAtl1chIZpK2cCAD7Igl9FpvcY7n
 1lDNP0/ml98AI5nvsvWhAIsynbIdaMO9dUk5xuS/4CRwfMiuRjG0nYxp7jDzH0qqLZeQ
 hoc7jSFWNghyYsVxQVcy+1rhiP6VmIoHFh8DHpWS6JNdrRPLtC4Qnr6fLRd410pG/kG9
 C2i+xm54G2T7AMqKc3NdLauwSJN1B3OFTYwdNqb4/h6FruboUmIRcdIiplo2b55fgwzG
 Kyog==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnbGbTs1F9HrWR6V7HTuGkOSVbgJkvaFt4X9aIbg4PFDQQXMfXz7xhWbICfix8HIa423P4sJGLz8y3@nongnu.org
X-Gm-Message-State: AOJu0Yx7anfqoN/hCeU0KhdGGqMShgSbQ48bJCDppVbhQA97qsUHv1NI
 8hbPx11tS23iXY3FEK2JxF9yqGyY+YVoD4N6wg+VbUBBXmZuumC8E9hunoY++pEXPvS937S0rCl
 lcOQ2khrFpHodap34oECGUKqFAFL9QvACxgUf3RGZtnbhsDcWOF/OHbg3
X-Gm-Gg: ASbGncv7Kvk7lGCgGomPHRgxwtH5yvJBRFvOG+8H8sSJ3I4hmS0uGCDFcEt6I/N7w+P
 lR5xLrufzZhAZz04PUHvpLcKOt6WN5jiX5szPrqct1xuf4mNn7L/ki4sfKt7ylOs1AZcce7+DQ/
 UY1peKHb4LYYtfjyYkmJDSb30yM0l0H3LvcFGGj31yEx7nURJqWxLUOjJFaNVnL4NMxZccN5wCb
 1UqJJ5wHsqQSQCPtDmC7kzXDNgdOv4tVWxVtOMZh9FyGaH/ur/j1J2X9rNCA8t2URBeNRPWUVVM
 njpayYMYOJ3i6ggVULeWKPhr88dojR8IQFvEvsNemM1aQkAUPI8YHGwR2LSR9FibnHo=
X-Received: by 2002:a05:620a:4591:b0:8b2:9aba:e887 with SMTP id
 af79cd13be357-8b29b77aa53mr598624285a.24.1762984545438; 
 Wed, 12 Nov 2025 13:55:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtRxuUCrj1XyqtvgMlfQpMU53WACUfF3wAjXfiDXs5mmnbLk+6xaqh1HSCMuVilJl3hcRVhw==
X-Received: by 2002:a05:620a:4591:b0:8b2:9aba:e887 with SMTP id
 af79cd13be357-8b29b77aa53mr598621085a.24.1762984544888; 
 Wed, 12 Nov 2025 13:55:44 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b2aee9e4c8sm5686485a.12.2025.11.12.13.55.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Nov 2025 13:55:44 -0800 (PST)
Date: Wed, 12 Nov 2025 16:55:42 -0500
From: Peter Xu <peterx@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, mst@redhat.com,
 qemu-devel@nongnu.org, farosas@suse.de, jinpu.wang@ionos.com,
 thuth@redhat.com, berrange@redhat.com
Subject: Re: [RFC PATCH] virtio-net: introduce strict peer feature check
Message-ID: <aRUCXvHkpfZgZCR0@x1.local>
References: <20251107020149.3223-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251107020149.3223-1-jasowang@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

Jason, thanks for help looking into the problem!

Am I right that after this patch applied, whenever a new QEMU boots with
the new machine types (e.g. having USO* by default ON), will fail to boot
on an old kernel that doesn't support USO*, but ask the users to turn off
USO* features explicitly in the virtio-net devices?

Thanks,

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
> 

-- 
Peter Xu



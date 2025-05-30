Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE75DC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 04:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKrRk-0001nP-9h; Fri, 30 May 2025 00:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKrRM-0001NB-Ai
 for qemu-devel@nongnu.org; Fri, 30 May 2025 00:33:59 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKrQz-0005Hz-An
 for qemu-devel@nongnu.org; Fri, 30 May 2025 00:33:54 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-23035b3edf1so16088985ad.3
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 21:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748579611; x=1749184411;
 darn=nongnu.org; 
 h=to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OejkH4zRsERXHTFoa8W8lm+ekIjzJaKY4aOmv4SvKCA=;
 b=ScmfHSDlTdMZGLOURTAlCq41s2h/KsV6CBqKHoTvy+Yl2CD2ktt2TWxR+debaz9hJb
 g07ExsSiNjvf9k104uoW31HcsGq8PBXEsLaCkw9SB8Uf2VCYCb8YIvSWFWShogm+UgNi
 M+NMV4SfsnBWj7GZdI6eC1f9+V+mHBIgYgYGe+WYaMsblCFWQh8DxzqeMRyppu3wWn5d
 eOXh1op7K3GMRAa2eNINo/lE8nIUe+scv8UhjVJiurClOGb95djhOd/7jab4fTnilc7d
 SXW+AP42J/dTozKPTuuW158wzSnbzqBVJ7hd/n9BSK/IeYVlyCFUYf7AD7ocf9X8U8im
 k7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748579611; x=1749184411;
 h=to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OejkH4zRsERXHTFoa8W8lm+ekIjzJaKY4aOmv4SvKCA=;
 b=ZzxQPDfIdw0fC+xl7YLCS1Wa2ofrKh+WXvgqQ+REnh2GrxQbwgrXCpaj5iB+BgkPfg
 UQcoUtUreiOOSRsVOkqYCK9tVwiE16NZMTq8LcjypvSPHD0b6SaNRjj7Lq4CF7vRkqEC
 tiMMAsaEDMlAPva4faQ45w3lpmCGjzcowwhu0VKCa9JXIeBRSUYkjpIQO006zYmMu3DA
 /50L0ryxRqzDDPY4jIJbox7zwBQAZdTz2S/BeXWD0FaxfsH5TS4dmKFzdcTQCqF6EAQv
 iYPNwiINTrz/UxrO65LvENgso2ExnpHlhc6trq3YRhiAWGUqDI2jzPaCw14/7Ipxqo7X
 9DKA==
X-Gm-Message-State: AOJu0Yx/aA8+OknkZ8Up76vVKIAYbswWxnR5ko42JspqW/fcMjDaWRrC
 mkwPeDOL32gOm/Ke0HNcXCfw/dK4QeMBBWQbpXUviR4wssETUakH4p7w6ovpaXhPfKIKTFKViQb
 XokMo
X-Gm-Gg: ASbGncvdDhpAOVdvyyAwV2B4zEd7BFq0fF6wP26KHrdRgCMMEyGoMC3ywZ5MPeN9Duv
 wqPThYeBz0ltizCxfqrlcITNXajco8Ui7CV/Bh9bAJa1Ub2g0YLN/sLz0PnfQE8Bau3JHNk9bc0
 w03j7x1xrfnDh6oualnT8+K+IsQB6SnZNDoI99G05s+LOcpdb5F6UyOrqaNNFD7vdpkWryTrnz0
 ss8ISggVRykCh/MdYTrH3P1wxWpwBHyI9shGuiQQSVc4RFwN0AvW18nu10DBsauYbASd9GexlXF
 K/srKIKGUTJ9Ek0rghqW0fSn7OrUaynQRKG1lnPHZIWvqef6cK1E
X-Google-Smtp-Source: AGHT+IGcsB1XpRme+lQzDk65V0HsCC2NkakQ5KhP2BwnX8y3umu5tVknouE340pBjn/GHnqbeM63bg==
X-Received: by 2002:a17:902:cf43:b0:223:7006:4db2 with SMTP id
 d9443c01a7336-23529517b67mr30012375ad.31.1748579611025; 
 Thu, 29 May 2025 21:33:31 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-23506cf9116sm19924305ad.200.2025.05.29.21.33.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 May 2025 21:33:30 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 30 May 2025 13:33:17 +0900
Subject: [PATCH 2/6] net/vhost-vdpa: Report hashing capability
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-vdpa-v1-2-5af4109b1c19@daynix.com>
References: <20250530-vdpa-v1-0-5af4109b1c19@daynix.com>
In-Reply-To: <20250530-vdpa-v1-0-5af4109b1c19@daynix.com>
To: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Paolo Abeni <pabeni@redhat.com>, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Report hashing capability so that virtio-net can deliver the correct
capability information to the guest.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/net/net.h |  3 +++
 net/net.c         |  9 +++++++++
 net/vhost-vdpa.c  | 28 ++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/include/net/net.h b/include/net/net.h
index cdd5b109b0d2..545f4339cec8 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -60,6 +60,7 @@ typedef bool (HasVnetHdrLen)(NetClientState *, int);
 typedef void (SetOffload)(NetClientState *, int, int, int, int, int, int, int);
 typedef int (GetVnetHdrLen)(NetClientState *);
 typedef void (SetVnetHdrLen)(NetClientState *, int);
+typedef bool (GetVnetHashSupportedTypes)(NetClientState *, uint32_t *);
 typedef int (SetVnetLE)(NetClientState *, bool);
 typedef int (SetVnetBE)(NetClientState *, bool);
 typedef struct SocketReadState SocketReadState;
@@ -89,6 +90,7 @@ typedef struct NetClientInfo {
     SetVnetHdrLen *set_vnet_hdr_len;
     SetVnetLE *set_vnet_le;
     SetVnetBE *set_vnet_be;
+    GetVnetHashSupportedTypes *get_vnet_hash_supported_types;
     NetAnnounce *announce;
     SetSteeringEBPF *set_steering_ebpf;
     NetCheckPeerType *check_peer_type;
@@ -189,6 +191,7 @@ void qemu_set_offload(NetClientState *nc, int csum, int tso4, int tso6,
                       int ecn, int ufo, int uso4, int uso6);
 int qemu_get_vnet_hdr_len(NetClientState *nc);
 void qemu_set_vnet_hdr_len(NetClientState *nc, int len);
+bool qemu_get_vnet_hash_supported_types(NetClientState *nc, uint32_t *types);
 int qemu_set_vnet_le(NetClientState *nc, bool is_le);
 int qemu_set_vnet_be(NetClientState *nc, bool is_be);
 void qemu_macaddr_default_if_unset(MACAddr *macaddr);
diff --git a/net/net.c b/net/net.c
index 39d6f28158a3..d0ae3db0d864 100644
--- a/net/net.c
+++ b/net/net.c
@@ -573,6 +573,15 @@ void qemu_set_vnet_hdr_len(NetClientState *nc, int len)
     nc->info->set_vnet_hdr_len(nc, len);
 }
 
+bool qemu_get_vnet_hash_supported_types(NetClientState *nc, uint32_t *types)
+{
+    if (!nc || !nc->info->get_vnet_hash_supported_types) {
+        return false;
+    }
+
+    return nc->info->get_vnet_hash_supported_types(nc, types);
+}
+
 int qemu_set_vnet_le(NetClientState *nc, bool is_le)
 {
 #if HOST_BIG_ENDIAN
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 7ca8b46eee77..1493b08792ea 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -251,6 +251,32 @@ static bool vhost_vdpa_has_vnet_hdr(NetClientState *nc)
     return true;
 }
 
+static bool vhost_vdpa_get_vnet_hash_supported_types(NetClientState *nc,
+                                                     uint32_t *types)
+{
+    assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
+    VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
+    uint64_t features = s->vhost_vdpa.dev->features;
+    int fd = s->vhost_vdpa.shared->device_fd;
+    struct {
+        struct vhost_vdpa_config hdr;
+        uint32_t supported_hash_types;
+    } config;
+
+    if (!virtio_has_feature(features, VIRTIO_NET_F_HASH_REPORT) &&
+        !virtio_has_feature(features, VIRTIO_NET_F_RSS)) {
+        return false;
+    }
+
+    config.hdr.off = offsetof(struct virtio_net_config, supported_hash_types);
+    config.hdr.len = sizeof(config.supported_hash_types);
+
+    assert(!ioctl(fd, VHOST_VDPA_GET_CONFIG, &config));
+    *types = le32_to_cpu(config.supported_hash_types);
+
+    return true;
+}
+
 static bool vhost_vdpa_has_ufo(NetClientState *nc)
 {
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
@@ -440,6 +466,7 @@ static NetClientInfo net_vhost_vdpa_info = {
         .stop = vhost_vdpa_net_client_stop,
         .cleanup = vhost_vdpa_cleanup,
         .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
+        .get_vnet_hash_supported_types = vhost_vdpa_get_vnet_hash_supported_types,
         .has_ufo = vhost_vdpa_has_ufo,
         .set_vnet_le = vhost_vdpa_set_vnet_le,
         .check_peer_type = vhost_vdpa_check_peer_type,
@@ -1314,6 +1341,7 @@ static NetClientInfo net_vhost_vdpa_cvq_info = {
     .stop = vhost_vdpa_net_cvq_stop,
     .cleanup = vhost_vdpa_cleanup,
     .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
+    .get_vnet_hash_supported_types = vhost_vdpa_get_vnet_hash_supported_types,
     .has_ufo = vhost_vdpa_has_ufo,
     .check_peer_type = vhost_vdpa_check_peer_type,
     .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,

-- 
2.49.0



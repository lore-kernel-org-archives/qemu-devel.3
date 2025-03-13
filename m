Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41013C28B28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 06:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tscU7-0006Uv-KH; Thu, 13 Mar 2025 02:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tscTz-0006OR-2l
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 02:55:55 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tscTw-00064d-HW
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 02:55:54 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-224191d92e4so11390795ad.3
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 23:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741848951; x=1742453751;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oIFfPe5cbAFiiWq1pctwdNXgTMQOFzoPIBHYx9JfyDs=;
 b=E5SoP6x1rX89dXredw3zNgDPW2irhIhoUxian4hiHxU+2DgCFnwlFqj3ncNCkRGGhK
 87Miux2bhMe2mhYZdFnXoAFe/gGqgWipizciwLTEPL1iSNlKA8UOzJRQqArPPNroc9tD
 SsEEIOXpZpk9ZdEOyoTQ2gUBNClekkJcZBarhcuZ1GOm+nzJPdWhajh53IfquPWJRDW/
 v4oKOvp7gpnLBrUYGNI6TyHYcUjMpKWjUEKL5iDhyegkf1lpbZ4j/6fnbF3HyFXZwy7a
 7x4k05pyD9oc0DCUNHy4T7bxsntU3pwVurxw34fDiWmWsWw4Qv/O/qLFTsf6PBxy8gkK
 ohFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741848951; x=1742453751;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oIFfPe5cbAFiiWq1pctwdNXgTMQOFzoPIBHYx9JfyDs=;
 b=iiIC9nBmSL1xkweY3u7aw3tOjSugp5KjGVzfdS5WcfFtdWJd+w16ALvf+6oIeduNz1
 EvWa0GnZlTvs+j0rQDS6tWlEHf2G77EgsJ4lIRBEpv/63cyfRYblzwUYYPaGRuOCiXOf
 xtqC1tiOjtdC7dzPfBur01SMdEpJC1B6VXQbhJSyTX8LYVUes+lJm/0hlIGSQvJEQGWW
 GO7SP58lc7U8kOuXIbu7i9g+uCkL+vG/9GwWlS2kjhj5hy2jS4d7043R+0N8K5CltWmJ
 bBjgwXpNErS5BrM6ifnEkrnFIz5CXAO8oT2HgXRAq4Wj7O84b9xD9JJNl2S1nTO7rXrW
 yv4w==
X-Gm-Message-State: AOJu0Ywlw3djEM78SRCHtKouB5v2g1dV6KSvNcxVQgGaN8/PlZVxtN4x
 boMcFquIhQ83S8v6/s5pP+OdWf2hsnCc9FCLyN/ZXOv/HeJXxjii2QmNXyIuX0c=
X-Gm-Gg: ASbGncu9daPfsXcbAhwcKg0V7AwY07g8lgdzoE+O8PxnOoJ7VmZCF2+3vJPEzQBbAqz
 crB+XNxBj+Ajw0ZsHo7AH4EhtUb3WFbdOfArCWCHi9k8p2vK/Cw42CE8e5VlfzDTbvh8wS0lM+8
 8RYqvp43VgbYqKo07u1Q4hqJZ59eypZT1C3vKpEA2u5SYLivhlc/2UAJOmQEfSqdZyxrWocMoPP
 nhBcQrBLTAjx+VpvbJT9zW6GmnxGegyMNXDOe2/Ikn8iQeMiBVGXcm9Xg2OKIUp2nVnbvlDwUrq
 JrssU496p31Jzb4DdVU07+UfqzsZZXWr9yLOUn0urx3NfL/I
X-Google-Smtp-Source: AGHT+IHM94MPnply1HiTFAMxyPX2aQdw9uOvMucL8T3ozc5n4IMo3Ydsn/+ynx3+wLagBt39kVVhcQ==
X-Received: by 2002:a17:903:32ce:b0:223:4b8d:32f1 with SMTP id
 d9443c01a7336-22428882233mr396058055ad.1.1741848951161; 
 Wed, 12 Mar 2025 23:55:51 -0700 (PDT)
Received: from localhost ([157.82.205.237])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-73711694e74sm641742b3a.143.2025.03.12.23.55.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 23:55:50 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 13 Mar 2025 15:55:28 +0900
Subject: [PATCH RFC v4 02/11] net/vhost-vdpa: Report hashing capability
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-hash-v4-2-c75c494b495e@daynix.com>
References: <20250313-hash-v4-0-c75c494b495e@daynix.com>
In-Reply-To: <20250313-hash-v4-0-c75c494b495e@daynix.com>
To: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 devel@daynix.com
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
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
index f7a54f46aa72..de006f3a2265 100644
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
@@ -428,6 +454,7 @@ static NetClientInfo net_vhost_vdpa_info = {
         .stop = vhost_vdpa_net_client_stop,
         .cleanup = vhost_vdpa_cleanup,
         .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
+        .get_vnet_hash_supported_types = vhost_vdpa_get_vnet_hash_supported_types,
         .has_ufo = vhost_vdpa_has_ufo,
         .check_peer_type = vhost_vdpa_check_peer_type,
         .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,
@@ -1301,6 +1328,7 @@ static NetClientInfo net_vhost_vdpa_cvq_info = {
     .stop = vhost_vdpa_net_cvq_stop,
     .cleanup = vhost_vdpa_cleanup,
     .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
+    .get_vnet_hash_supported_types = vhost_vdpa_get_vnet_hash_supported_types,
     .has_ufo = vhost_vdpa_has_ufo,
     .check_peer_type = vhost_vdpa_check_peer_type,
     .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,

-- 
2.48.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CBFC3ABB2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 04:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKrWc-0006r0-W1; Fri, 30 May 2025 00:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKrWY-0006q1-FL
 for qemu-devel@nongnu.org; Fri, 30 May 2025 00:39:20 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKrWW-0006po-FN
 for qemu-devel@nongnu.org; Fri, 30 May 2025 00:39:18 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-234d3261631so11992945ad.1
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 21:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748579955; x=1749184755;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=N6IK2pONLYRna/BS0SsNNCt2yzso/grhSPTpd+N4Xjg=;
 b=LwodDReZPI/lZpSiLg7KV2CQV/yjkJ33ZicfXvh2ffbUy0yxAIPHUUsqfWZ02sl7MD
 FnGe89SciH9j/RLwuA8vmLRCaGHNDmguUrCgnrfAonp6skeikJP5iuRJcSOkiHw/1HR0
 Xo3wDPu1lyC3ysfA6Y4McRiV5Y24t2Jk/VgiBBZeXK+XMiNhsq3CAcmklSnEXZsaap4J
 X+u1opekaGC0M5+kPkXvdZ83Bf7YWetd3o83por97oGHEcR5aUtvxxfyc4HexaDeuuHG
 ABC9bSWRWCWsi9oujvvmpH7Nk8XdbXaKshpWyXakTNXLAYVPdOdp1lIRU5tvmm/sD+d/
 10ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748579955; x=1749184755;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N6IK2pONLYRna/BS0SsNNCt2yzso/grhSPTpd+N4Xjg=;
 b=svZYJ8KP1YbO7rz8NLlVp2Z/eCMVSsJzUP4wKmnhSPPvGfcCcJ8QiWsoe7HTNKg4YX
 QrNFK29mv+lYJgmOQHbF7s1EVN9Z95AUe+FkrDeV1iNXgit1OlmBfgplfIN21ohewxf/
 5QIetmM+N0iub55vMEJKzSnckAJvCcknIwgZT5k7xakGQFNJOaeq5dWbFQfylSrlTsEV
 Y/7yk2Dr7TBzr1VAa8eQ1eDwuOuX35Qbgur75Yd5o+kIieVX720cggWgsTRCGg1EFKG9
 or7HgCGlXs7Wk5+wYMmywZVlXiS9A+kmxp0iQbJ/AZuTx/S9eD4GoCXoBlIbmkuxMKQ9
 LTpw==
X-Gm-Message-State: AOJu0YyIWgmh1fm4ryqawOQAePtIqHvbLANfHsxHl0pVyrT3hfAxBzQD
 avp2m6DxUG2aB6fxAU0LTERr7MX9a439ndsWzuZtp9fLNIPLoGE5m+86jFP2afCId9g=
X-Gm-Gg: ASbGncsUP5sfmJX+kku1W/E4agGAxh01l6pUQmKLgmD+UeNI+WEwM09gNUO+ZtOZ/FC
 1n7TBEZIApgj1zNu4k1Luze6B0cHJ78wTMuSQb/Jqmd/7iNNrZ2l4p/PXc9qEKKafXOMqdL1j7I
 08787oV7OtJ477GVgIYAqzsz7qqXIAeRIRwDw1QeHmDTktsPRCD64NPP7yBA6QWn7ghRtj48qmY
 HnV7Gz3YNJ6aY2yL+DYgD9eXEeRaW95ALHrD09OFtfoG10qltSv3IeIvD0rdSiS7Swc7zyRGC6C
 g44ZmIpe9THpa8fDBYLB4UI5NHCEwE4U/xuA5nurLy7U+8V0hpTv
X-Google-Smtp-Source: AGHT+IF5CvUiLOyNy2RKylSeG3aoiGUK/tMYfL0zCHlei3sjy5QtYyNGm7WV0M/wg+Mh+gPLahJvcw==
X-Received: by 2002:a17:903:234f:b0:234:f15b:f158 with SMTP id
 d9443c01a7336-235390e1736mr11540765ad.13.1748579955029; 
 Thu, 29 May 2025 21:39:15 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-23506d14a85sm19959765ad.232.2025.05.29.21.39.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 May 2025 21:39:14 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 30 May 2025 13:39:09 +0900
Subject: [PATCH RFC v5 1/5] net: Allow configuring virtio hashing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-hash-v5-1-343d7d7a8200@daynix.com>
References: <20250530-hash-v5-0-343d7d7a8200@daynix.com>
In-Reply-To: <20250530-hash-v5-0-343d7d7a8200@daynix.com>
To: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Paolo Abeni <pabeni@redhat.com>, devel@daynix.com
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
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

This adds functions to configure virtio hashing and implements it
for Linux's tap. vDPA will have empty functions as configuring virtio
hashing is done with the load().

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/net/net.h | 13 +++++++++++++
 net/tap-linux.h   |  3 +++
 net/tap_int.h     |  3 +++
 net/net.c         | 11 +++++++++++
 net/tap-bsd.c     | 10 ++++++++++
 net/tap-linux.c   | 11 +++++++++++
 net/tap-solaris.c | 10 ++++++++++
 net/tap-stub.c    | 10 ++++++++++
 net/tap.c         | 15 +++++++++++++++
 net/vhost-vdpa.c  | 13 +++++++++++++
 10 files changed, 99 insertions(+)

diff --git a/include/net/net.h b/include/net/net.h
index 545f4339cec8..779cee7f4a22 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -35,6 +35,12 @@ typedef struct NICConf {
     int32_t bootindex;
 } NICConf;
 
+typedef struct NetVnetRss {
+    uint32_t hash_types;
+    uint16_t indirection_table_mask;
+    uint16_t unclassified_queue;
+} NetVnetRss;
+
 #define DEFINE_NIC_PROPERTIES(_state, _conf)                            \
     DEFINE_PROP_MACADDR("mac",   _state, _conf.macaddr),                \
     DEFINE_PROP_NETDEV("netdev", _state, _conf.peers)
@@ -61,6 +67,8 @@ typedef void (SetOffload)(NetClientState *, int, int, int, int, int, int, int);
 typedef int (GetVnetHdrLen)(NetClientState *);
 typedef void (SetVnetHdrLen)(NetClientState *, int);
 typedef bool (GetVnetHashSupportedTypes)(NetClientState *, uint32_t *);
+typedef void (SetVnetAutomq)(NetClientState *, uint32_t);
+typedef void (SetVnetRss)(NetClientState *, const NetVnetRss *, bool);
 typedef int (SetVnetLE)(NetClientState *, bool);
 typedef int (SetVnetBE)(NetClientState *, bool);
 typedef struct SocketReadState SocketReadState;
@@ -91,6 +99,8 @@ typedef struct NetClientInfo {
     SetVnetLE *set_vnet_le;
     SetVnetBE *set_vnet_be;
     GetVnetHashSupportedTypes *get_vnet_hash_supported_types;
+    SetVnetAutomq *set_vnet_automq;
+    SetVnetRss *set_vnet_rss;
     NetAnnounce *announce;
     SetSteeringEBPF *set_steering_ebpf;
     NetCheckPeerType *check_peer_type;
@@ -192,6 +202,9 @@ void qemu_set_offload(NetClientState *nc, int csum, int tso4, int tso6,
 int qemu_get_vnet_hdr_len(NetClientState *nc);
 void qemu_set_vnet_hdr_len(NetClientState *nc, int len);
 bool qemu_get_vnet_hash_supported_types(NetClientState *nc, uint32_t *types);
+void qemu_set_vnet_automq(NetClientState *nc, uint32_t hash_types);
+void qemu_set_vnet_rss(NetClientState *nc, const NetVnetRss *rss,
+                       bool hash_report);
 int qemu_set_vnet_le(NetClientState *nc, bool is_le);
 int qemu_set_vnet_be(NetClientState *nc, bool is_be);
 void qemu_macaddr_default_if_unset(MACAddr *macaddr);
diff --git a/net/tap-linux.h b/net/tap-linux.h
index 9a58cecb7f47..5bca6cab1867 100644
--- a/net/tap-linux.h
+++ b/net/tap-linux.h
@@ -32,6 +32,9 @@
 #define TUNSETVNETLE _IOW('T', 220, int)
 #define TUNSETVNETBE _IOW('T', 222, int)
 #define TUNSETSTEERINGEBPF _IOR('T', 224, int)
+#define TUNSETVNETREPORTINGAUTOMQ _IOR('T', 229, __u32)
+#define TUNSETVNETREPORTINGRSS _IOR('T', 230, NetVnetRss)
+#define TUNSETVNETRSS _IOR('T', 231, struct NetVnetRss)
 
 #endif
 
diff --git a/net/tap_int.h b/net/tap_int.h
index 8857ff299d22..248d1efa51a0 100644
--- a/net/tap_int.h
+++ b/net/tap_int.h
@@ -27,6 +27,7 @@
 #define NET_TAP_INT_H
 
 #include "qapi/qapi-types-net.h"
+#include "net/net.h"
 
 int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
              int vnet_hdr_required, int mq_required, Error **errp);
@@ -40,6 +41,8 @@ int tap_probe_has_uso(int fd);
 void tap_fd_set_offload(int fd, int csum, int tso4, int tso6, int ecn, int ufo,
                         int uso4, int uso6);
 void tap_fd_set_vnet_hdr_len(int fd, int len);
+void tap_fd_set_vnet_automq(int fd, uint32_t hash_types);
+void tap_fd_set_vnet_rss(int fd, const NetVnetRss *rss, bool hash_report);
 int tap_fd_set_vnet_le(int fd, int vnet_is_le);
 int tap_fd_set_vnet_be(int fd, int vnet_is_be);
 int tap_fd_enable(int fd);
diff --git a/net/net.c b/net/net.c
index d0ae3db0d864..7e21e1a373ab 100644
--- a/net/net.c
+++ b/net/net.c
@@ -582,6 +582,17 @@ bool qemu_get_vnet_hash_supported_types(NetClientState *nc, uint32_t *types)
     return nc->info->get_vnet_hash_supported_types(nc, types);
 }
 
+void qemu_set_vnet_automq(NetClientState *nc, uint32_t hash_types)
+{
+    nc->info->set_vnet_automq(nc, hash_types);
+}
+
+void qemu_set_vnet_rss(NetClientState *nc, const NetVnetRss *rss,
+                       bool hash_report)
+{
+    nc->info->set_vnet_rss(nc, rss, hash_report);
+}
+
 int qemu_set_vnet_le(NetClientState *nc, bool is_le)
 {
 #if HOST_BIG_ENDIAN
diff --git a/net/tap-bsd.c b/net/tap-bsd.c
index b4c84441ba8b..8ed384f02c5b 100644
--- a/net/tap-bsd.c
+++ b/net/tap-bsd.c
@@ -221,6 +221,16 @@ void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
 }
 
+void tap_fd_set_vnet_automq(int fd, uint32_t hash_types)
+{
+    g_assert_not_reached();
+}
+
+void tap_fd_set_vnet_rss(int fd, const NetVnetRss *rss, bool hash_report)
+{
+    g_assert_not_reached();
+}
+
 int tap_fd_set_vnet_le(int fd, int is_le)
 {
     return -EINVAL;
diff --git a/net/tap-linux.c b/net/tap-linux.c
index 22ec2f45d2b7..d0adb168e977 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -205,6 +205,17 @@ void tap_fd_set_vnet_hdr_len(int fd, int len)
     }
 }
 
+void tap_fd_set_vnet_automq(int fd, uint32_t hash_types)
+{
+    assert(!ioctl(fd, TUNSETVNETREPORTINGAUTOMQ, &hash_types));
+}
+
+void tap_fd_set_vnet_rss(int fd, const NetVnetRss *rss, bool hash_report)
+{
+    unsigned int cmd = hash_report ? TUNSETVNETREPORTINGRSS : TUNSETVNETRSS;
+    assert(!ioctl(fd, cmd, rss));
+}
+
 int tap_fd_set_vnet_le(int fd, int is_le)
 {
     int arg = is_le ? 1 : 0;
diff --git a/net/tap-solaris.c b/net/tap-solaris.c
index 51b7830bef1d..bc76a030e7f9 100644
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -225,6 +225,16 @@ void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
 }
 
+void tap_fd_set_vnet_automq(int fd, uint32_t hash_types)
+{
+    g_assert_not_reached();
+}
+
+void tap_fd_set_vnet_rss(int fd, const NetVnetRss *rss, bool hash_report)
+{
+    g_assert_not_reached();
+}
+
 int tap_fd_set_vnet_le(int fd, int is_le)
 {
     return -EINVAL;
diff --git a/net/tap-stub.c b/net/tap-stub.c
index 38673434cbd6..511ddfc707eb 100644
--- a/net/tap-stub.c
+++ b/net/tap-stub.c
@@ -56,6 +56,16 @@ void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
 }
 
+void tap_fd_set_vnet_automq(int fd, uint32_t hash_types)
+{
+    g_assert_not_reached();
+}
+
+void tap_fd_set_vnet_rss(int fd, const NetVnetRss *rss, bool hash_report)
+{
+    g_assert_not_reached();
+}
+
 int tap_fd_set_vnet_le(int fd, int is_le)
 {
     return -EINVAL;
diff --git a/net/tap.c b/net/tap.c
index ae1c7e398321..e93f5f951057 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -248,6 +248,19 @@ static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
     s->using_vnet_hdr = true;
 }
 
+static void tap_set_vnet_automq(NetClientState *nc, uint32_t hash_types)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    return tap_fd_set_vnet_automq(s->fd, hash_types);
+}
+
+static void tap_set_vnet_rss(NetClientState *nc, const NetVnetRss *rss,
+                             bool hash_report)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    return tap_fd_set_vnet_rss(s->fd, rss, hash_report);
+}
+
 static int tap_set_vnet_le(NetClientState *nc, bool is_le)
 {
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
@@ -344,6 +357,8 @@ static NetClientInfo net_tap_info = {
     .has_vnet_hdr_len = tap_has_vnet_hdr_len,
     .set_offload = tap_set_offload,
     .set_vnet_hdr_len = tap_set_vnet_hdr_len,
+    .set_vnet_automq = tap_set_vnet_automq,
+    .set_vnet_rss = tap_set_vnet_rss,
     .set_vnet_le = tap_set_vnet_le,
     .set_vnet_be = tap_set_vnet_be,
     .set_steering_ebpf = tap_set_steering_ebpf,
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 149c0f7f1766..43822f1f79da 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -271,6 +271,15 @@ static bool vhost_vdpa_get_vnet_hash_supported_types(NetClientState *nc,
     return true;
 }
 
+static void vhost_vdpa_set_vnet_automq(NetClientState *nc, uint32_t hash_types)
+{
+}
+
+static void vhost_vdpa_set_vnet_rss(NetClientState *nc, const NetVnetRss *rss,
+                                    bool hash_report)
+{
+}
+
 static bool vhost_vdpa_has_ufo(NetClientState *nc)
 {
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
@@ -461,6 +470,8 @@ static NetClientInfo net_vhost_vdpa_info = {
         .cleanup = vhost_vdpa_cleanup,
         .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
         .get_vnet_hash_supported_types = vhost_vdpa_get_vnet_hash_supported_types,
+        .set_vnet_automq = vhost_vdpa_set_vnet_automq,
+        .set_vnet_rss = vhost_vdpa_set_vnet_rss,
         .has_ufo = vhost_vdpa_has_ufo,
         .set_vnet_le = vhost_vdpa_set_vnet_le,
         .check_peer_type = vhost_vdpa_check_peer_type,
@@ -1335,6 +1346,8 @@ static NetClientInfo net_vhost_vdpa_cvq_info = {
     .cleanup = vhost_vdpa_cleanup,
     .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
     .get_vnet_hash_supported_types = vhost_vdpa_get_vnet_hash_supported_types,
+    .set_vnet_automq = vhost_vdpa_set_vnet_automq,
+    .set_vnet_rss = vhost_vdpa_set_vnet_rss,
     .has_ufo = vhost_vdpa_has_ufo,
     .check_peer_type = vhost_vdpa_check_peer_type,
 };

-- 
2.49.0



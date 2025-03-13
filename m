Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF03C28B28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 06:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tscUi-0007QQ-Qe; Thu, 13 Mar 2025 02:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tscUG-0006j1-Fj
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 02:56:14 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tscUE-00068j-7j
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 02:56:12 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-219f8263ae0so11196815ad.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 23:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741848969; x=1742453769;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MgQDpkdeB+gab9lnEM4WvK+cxeAmq+htFO9Du/yWDvw=;
 b=kOrpoFFtGofTIgyByPTXmC0GwoNuI348B4on7bNVKZPPLWbsjeFchse8Xry/bJEOy/
 5wMvo8v4A5zbGXoetUTqVVdRM7p0WmUXQ3pwy1ST4z0T28877fGyM16g+cAVC9Se3UDY
 TcxR30TTW3A0EnSjVz9DkZlLryAY359wsIYfIE36PSjsmnfbpA8cLWDnecxd8poPWC1o
 wZoe8BzrLWWgviKL7RI8/MkKSjm8/CyKAokSrJmGtbHOqXxZsamylMxzHK+VbUZ22D8t
 IE6MYTqxdwwHl+4iRUElWRgxmsZFUUKuaHomT8Omex6ExO05L/YaYMJvtkBG0wewNVQ/
 rUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741848969; x=1742453769;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MgQDpkdeB+gab9lnEM4WvK+cxeAmq+htFO9Du/yWDvw=;
 b=N8B6pzMIOAWDvsnWJ+/fesmnL7GT+ms0OXXeWOOisTEBdQtlt8os0h7gbFxhbiSMWN
 C4QcEt+bzdaDjkGTIR6zO8dXjwAulmrzv+g0LFuHXdKI/kFM2jEBX9a1kIIHdj49OWNT
 LLhVz36DbRyrvGW6F+7gkzqjgssL0bBMr7v/GyHC9G8/66TBgQm+LaCi6d5YSB33Ib3i
 WiPDAWMfK5iGDWWCmxyJCjBn1WCqNfQhnZRAPb7Bml8zyia29IEYJbKR9x0DyxmDVoj/
 ggkcGOWMS5U2H4G0AXL0UXz/wwdfSV4bKj3djapTQ+KC2ZlSjQuhkIXYAdIve+tXQYD0
 iJvw==
X-Gm-Message-State: AOJu0Yxa0XCXr0HK4LmNUFoUcciOmGD+83+d/Xsb/SRBwhjZiofVrKmT
 2JfkZP5FrS4ROR8L0CkcryoFTPfUbwICIufg588RNwE70Ub+QgIp3wyUfJI+L0QAnkPLB6Jmxut
 T6LA=
X-Gm-Gg: ASbGncvMXvuutuhdWQC0dpF/nsc+SliX2VPW3nK5B0qp2QZstnQKFm5D1Jq5+o4PEFa
 zUnLitg/HOtYrceoLymfivyDSShMsbbjRr/AIAhfX3Kxi9Dw23/g7MVJmTZX+cXLMd584qfDc1M
 rIiQF5Lwg76jfiQuVLKBw73wE5Q65NlapkEUrHNtMjgvjUdyQ7oQhuTlDSSor9R0a3FI366o4On
 sDVSlNvfgQ3kUpHyF9fNFlX+r1QSMWi1TtAvIgZ1B3l4t/Fcz7euZbb30iIVBN7EhqITuC2k+wZ
 3bcVg4RrX9KFVkyABi9eb7Wh5ouzy6Ur5fXtN1icKxGHX2aBAgXvlYqSKZ0=
X-Google-Smtp-Source: AGHT+IG6r3p8xi8Lt47DQwevXJcaIQYoVt+HaSWDhBCiHZgG4uHoEv9PVa4lkZdUjG8CLLM77yUxGQ==
X-Received: by 2002:a17:902:e745:b0:223:3bf6:7e6a with SMTP id
 d9443c01a7336-22592e2c969mr153166385ad.12.1741848968836; 
 Wed, 12 Mar 2025 23:56:08 -0700 (PDT)
Received: from localhost ([157.82.205.237])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-225c6888675sm6542825ad.51.2025.03.12.23.56.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 23:56:08 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 13 Mar 2025 15:55:33 +0900
Subject: [PATCH RFC v4 07/11] net: Allow configuring virtio hashing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-hash-v4-7-c75c494b495e@daynix.com>
References: <20250313-hash-v4-0-c75c494b495e@daynix.com>
In-Reply-To: <20250313-hash-v4-0-c75c494b495e@daynix.com>
To: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 devel@daynix.com
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

This adds set_vnet_hash() to configure virtio hashing and implements it
for Linux's tap. vDPA will have an empty function as configuring virtio
hashing is done with the load().

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/net/net.h | 17 +++++++++++++++++
 net/tap-linux.h   |  1 +
 net/tap_int.h     |  2 ++
 net/net.c         |  5 +++++
 net/tap-bsd.c     |  5 +++++
 net/tap-linux.c   |  5 +++++
 net/tap-solaris.c |  5 +++++
 net/tap-stub.c    |  5 +++++
 net/tap.c         |  7 +++++++
 net/vhost-vdpa.c  |  7 +++++++
 10 files changed, 59 insertions(+)

diff --git a/include/net/net.h b/include/net/net.h
index 545f4339cec8..fa69e14c9829 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -35,6 +35,20 @@ typedef struct NICConf {
     int32_t bootindex;
 } NICConf;
 
+#define NET_VNET_HASH_REPORT 1
+#define NET_VNET_HASH_RSS 2
+
+typedef struct NetVnetHash {
+    uint16_t flags;
+    uint8_t pad[2];
+    uint32_t types;
+} NetVnetHash;
+
+typedef struct NetVnetHashRss {
+    uint16_t indirection_table_mask;
+    uint16_t unclassified_queue;
+} NetVnetHashRss;
+
 #define DEFINE_NIC_PROPERTIES(_state, _conf)                            \
     DEFINE_PROP_MACADDR("mac",   _state, _conf.macaddr),                \
     DEFINE_PROP_NETDEV("netdev", _state, _conf.peers)
@@ -61,6 +75,7 @@ typedef void (SetOffload)(NetClientState *, int, int, int, int, int, int, int);
 typedef int (GetVnetHdrLen)(NetClientState *);
 typedef void (SetVnetHdrLen)(NetClientState *, int);
 typedef bool (GetVnetHashSupportedTypes)(NetClientState *, uint32_t *);
+typedef void (SetVnetHash)(NetClientState *, const NetVnetHash *);
 typedef int (SetVnetLE)(NetClientState *, bool);
 typedef int (SetVnetBE)(NetClientState *, bool);
 typedef struct SocketReadState SocketReadState;
@@ -91,6 +106,7 @@ typedef struct NetClientInfo {
     SetVnetLE *set_vnet_le;
     SetVnetBE *set_vnet_be;
     GetVnetHashSupportedTypes *get_vnet_hash_supported_types;
+    SetVnetHash *set_vnet_hash;
     NetAnnounce *announce;
     SetSteeringEBPF *set_steering_ebpf;
     NetCheckPeerType *check_peer_type;
@@ -192,6 +208,7 @@ void qemu_set_offload(NetClientState *nc, int csum, int tso4, int tso6,
 int qemu_get_vnet_hdr_len(NetClientState *nc);
 void qemu_set_vnet_hdr_len(NetClientState *nc, int len);
 bool qemu_get_vnet_hash_supported_types(NetClientState *nc, uint32_t *types);
+void qemu_set_vnet_hash(NetClientState *nc, const NetVnetHash *hash);
 int qemu_set_vnet_le(NetClientState *nc, bool is_le);
 int qemu_set_vnet_be(NetClientState *nc, bool is_be);
 void qemu_macaddr_default_if_unset(MACAddr *macaddr);
diff --git a/net/tap-linux.h b/net/tap-linux.h
index 9a58cecb7f47..5fac64c24f99 100644
--- a/net/tap-linux.h
+++ b/net/tap-linux.h
@@ -32,6 +32,7 @@
 #define TUNSETVNETLE _IOW('T', 220, int)
 #define TUNSETVNETBE _IOW('T', 222, int)
 #define TUNSETSTEERINGEBPF _IOR('T', 224, int)
+#define TUNSETVNETHASH _IOW('T', 229, NetVnetHash)
 
 #endif
 
diff --git a/net/tap_int.h b/net/tap_int.h
index 8857ff299d22..e1b53e343397 100644
--- a/net/tap_int.h
+++ b/net/tap_int.h
@@ -27,6 +27,7 @@
 #define NET_TAP_INT_H
 
 #include "qapi/qapi-types-net.h"
+#include "net/net.h"
 
 int tap_open(char *ifname, int ifname_size, int *vnet_hdr,
              int vnet_hdr_required, int mq_required, Error **errp);
@@ -40,6 +41,7 @@ int tap_probe_has_uso(int fd);
 void tap_fd_set_offload(int fd, int csum, int tso4, int tso6, int ecn, int ufo,
                         int uso4, int uso6);
 void tap_fd_set_vnet_hdr_len(int fd, int len);
+void tap_fd_set_vnet_hash(int fd, const NetVnetHash *hash);
 int tap_fd_set_vnet_le(int fd, int vnet_is_le);
 int tap_fd_set_vnet_be(int fd, int vnet_is_be);
 int tap_fd_enable(int fd);
diff --git a/net/net.c b/net/net.c
index d0ae3db0d864..eaf82082137d 100644
--- a/net/net.c
+++ b/net/net.c
@@ -582,6 +582,11 @@ bool qemu_get_vnet_hash_supported_types(NetClientState *nc, uint32_t *types)
     return nc->info->get_vnet_hash_supported_types(nc, types);
 }
 
+void qemu_set_vnet_hash(NetClientState *nc, const NetVnetHash *hash)
+{
+    nc->info->set_vnet_hash(nc, hash);
+}
+
 int qemu_set_vnet_le(NetClientState *nc, bool is_le)
 {
 #if HOST_BIG_ENDIAN
diff --git a/net/tap-bsd.c b/net/tap-bsd.c
index b4c84441ba8b..2eee0c0a0ec5 100644
--- a/net/tap-bsd.c
+++ b/net/tap-bsd.c
@@ -221,6 +221,11 @@ void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
 }
 
+void tap_fd_set_vnet_hash(int fd, const NetVnetHash *hash)
+{
+    g_assert_not_reached();
+}
+
 int tap_fd_set_vnet_le(int fd, int is_le)
 {
     return -EINVAL;
diff --git a/net/tap-linux.c b/net/tap-linux.c
index 22ec2f45d2b7..c053828b056b 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -205,6 +205,11 @@ void tap_fd_set_vnet_hdr_len(int fd, int len)
     }
 }
 
+void tap_fd_set_vnet_hash(int fd, const NetVnetHash *hash)
+{
+    assert(!ioctl(fd, TUNSETVNETHASH, hash));
+}
+
 int tap_fd_set_vnet_le(int fd, int is_le)
 {
     int arg = is_le ? 1 : 0;
diff --git a/net/tap-solaris.c b/net/tap-solaris.c
index 51b7830bef1d..c65104b84e93 100644
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -225,6 +225,11 @@ void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
 }
 
+void tap_fd_set_vnet_hash(int fd, const NetVnetHash *hash)
+{
+    g_assert_not_reached();
+}
+
 int tap_fd_set_vnet_le(int fd, int is_le)
 {
     return -EINVAL;
diff --git a/net/tap-stub.c b/net/tap-stub.c
index 38673434cbd6..5bdc76216b7f 100644
--- a/net/tap-stub.c
+++ b/net/tap-stub.c
@@ -56,6 +56,11 @@ void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
 }
 
+void tap_fd_set_vnet_hash(int fd, const NetVnetHash *hash)
+{
+    g_assert_not_reached();
+}
+
 int tap_fd_set_vnet_le(int fd, int is_le)
 {
     return -EINVAL;
diff --git a/net/tap.c b/net/tap.c
index ae1c7e398321..1136018c1965 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -248,6 +248,12 @@ static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
     s->using_vnet_hdr = true;
 }
 
+static void tap_set_vnet_hash(NetClientState *nc, const NetVnetHash *hash)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    return tap_fd_set_vnet_hash(s->fd, hash);
+}
+
 static int tap_set_vnet_le(NetClientState *nc, bool is_le)
 {
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
@@ -344,6 +350,7 @@ static NetClientInfo net_tap_info = {
     .has_vnet_hdr_len = tap_has_vnet_hdr_len,
     .set_offload = tap_set_offload,
     .set_vnet_hdr_len = tap_set_vnet_hdr_len,
+    .set_vnet_hash = tap_set_vnet_hash,
     .set_vnet_le = tap_set_vnet_le,
     .set_vnet_be = tap_set_vnet_be,
     .set_steering_ebpf = tap_set_steering_ebpf,
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index d35348b1e742..e5ee7cd22d4f 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -271,6 +271,11 @@ static bool vhost_vdpa_get_vnet_hash_supported_types(NetClientState *nc,
     return true;
 }
 
+static void vhost_vdpa_set_vnet_hash(NetClientState *nc,
+                                     const NetVnetHash *hash)
+{
+}
+
 static bool vhost_vdpa_has_ufo(NetClientState *nc)
 {
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
@@ -449,6 +454,7 @@ static NetClientInfo net_vhost_vdpa_info = {
         .cleanup = vhost_vdpa_cleanup,
         .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
         .get_vnet_hash_supported_types = vhost_vdpa_get_vnet_hash_supported_types,
+        .set_vnet_hash = vhost_vdpa_set_vnet_hash,
         .has_ufo = vhost_vdpa_has_ufo,
         .check_peer_type = vhost_vdpa_check_peer_type,
 };
@@ -1322,6 +1328,7 @@ static NetClientInfo net_vhost_vdpa_cvq_info = {
     .cleanup = vhost_vdpa_cleanup,
     .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
     .get_vnet_hash_supported_types = vhost_vdpa_get_vnet_hash_supported_types,
+    .set_vnet_hash = vhost_vdpa_set_vnet_hash,
     .has_ufo = vhost_vdpa_has_ufo,
     .check_peer_type = vhost_vdpa_check_peer_type,
 };

-- 
2.48.1



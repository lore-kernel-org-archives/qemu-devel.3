Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1444C35FE0
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 01:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spe0i-0003iw-6m; Sat, 14 Sep 2024 21:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spe0f-0003gW-Au
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:25:05 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spe0d-0005SS-4v
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:25:05 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-206bd1c6ccdso19040495ad.3
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2024 18:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726363502; x=1726968302;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=05vEGgLAWx+iSc8sGRfqXN4iIzwNlz6gmxjzBkX2S4M=;
 b=FoNbcGBuVuy/UI1RFU9Xl62T2Xtj2tTN0d4MurFCvuJetvLV735r5iiyYRxLVwa6Pw
 DlmLaZtZY84KNJ7ctEV084WuXtvEkzcI+m0NM70Q0GWihfmtbRr/ZHQ5HpwnBCg6eLmG
 gi0Vi35VQonR9FbgjvVyEMbYzbqdkpUI4gRdYx3fV2gScRh7Hkohszc8JiomNomtUawk
 BeUU1AABimdk24pZA20Bn3KgTxe35DnaAIMk90q/e8/y7b1Uau5n9FKCe5k3o15ZL9Xo
 4PSxBRwi95F1JqRGNoa6XVutBGqo4V1g36l3tv3wWT3jK9cKPvWGcCLK3dd7glHTsKWe
 w6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726363502; x=1726968302;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=05vEGgLAWx+iSc8sGRfqXN4iIzwNlz6gmxjzBkX2S4M=;
 b=Ma3JkM6LWJ5rUf39LL9Rh5u7VCq0FyZ/h9//bp3Z4MoqnDnmVPRvxAPiySFZVkBFr0
 XqHbaBYPHNTOGQYd4zrxddy1lqLdEcLf8JvZua8fNXfpv8TXo7NzJOuPwUlujKjqUahq
 g5QqplygJMDlrpq0upGa7mKuetxJaW58X3mAsxmHk0LUZFSRp2YnnlPbVvAZBigDNm2p
 iQPGlQlJv+/8Z4teasO51OUPajgNfFbOQgExEI5AvE5OTljnHVkzwG4LO559LwTp1PkH
 VSy1/l1PTlyxdjcFZ79GEZ9L9OFfRfSMG8bIlOcvUbFafKFZK7O6zfHAZ9nXoKf8NW0G
 cylQ==
X-Gm-Message-State: AOJu0Yx+f7zfQLxgSghU0viQC990RTGgyFOsp1web9B9nhQLBefQ5kB+
 l14x/BzVs2CeAlSsp9y3mgebyf2ECR45nCZzEcyfyxZ7cHspLyL2PzzhnMVt4WlXM0vA2FmeWsI
 rEOs=
X-Google-Smtp-Source: AGHT+IHo1xikBKBGlaHCAa1ysKqwUQv99VGI9V22/WQsXsf2ShiEyvhokw3vX3aRufYLWi4e8y6tZw==
X-Received: by 2002:a17:902:d58c:b0:207:2093:99bb with SMTP id
 d9443c01a7336-20782529c52mr83732095ad.31.1726363501525; 
 Sat, 14 Sep 2024 18:25:01 -0700 (PDT)
Received: from localhost ([210.160.217.68])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-2079470f326sm14720875ad.203.2024.09.14.18.24.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Sep 2024 18:25:01 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 15 Sep 2024 10:23:48 +0900
Subject: [PATCH RFC v3 07/11] net: Allow configuring virtio hashing
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240915-hash-v3-7-79cb08d28647@daynix.com>
References: <20240915-hash-v3-0-79cb08d28647@daynix.com>
In-Reply-To: <20240915-hash-v3-0-79cb08d28647@daynix.com>
To: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
index 099616c8cbe3..0c7e3513cf5f 100644
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
@@ -195,6 +211,7 @@ void qemu_set_offload(NetClientState *nc, int csum, int tso4, int tso6,
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
index 3b04f8fe5d6b..db365b6ec211 100644
--- a/net/net.c
+++ b/net/net.c
@@ -568,6 +568,11 @@ bool qemu_get_vnet_hash_supported_types(NetClientState *nc, uint32_t *types)
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
index 1226d5fda2d9..e96d38eec922 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -194,6 +194,11 @@ void tap_fd_set_vnet_hdr_len(int fd, int len)
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
index 51f7aec39d9e..8d451c745d70 100644
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
index 5d846db5e71f..767fd8def468 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -278,6 +278,11 @@ static bool vhost_vdpa_get_vnet_hash_supported_types(NetClientState *nc,
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
@@ -457,6 +462,7 @@ static NetClientInfo net_vhost_vdpa_info = {
         .cleanup = vhost_vdpa_cleanup,
         .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
         .get_vnet_hash_supported_types = vhost_vdpa_get_vnet_hash_supported_types,
+        .set_vnet_hash = vhost_vdpa_set_vnet_hash,
         .has_ufo = vhost_vdpa_has_ufo,
         .check_peer_type = vhost_vdpa_check_peer_type,
 };
@@ -1324,6 +1330,7 @@ static NetClientInfo net_vhost_vdpa_cvq_info = {
     .cleanup = vhost_vdpa_cleanup,
     .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
     .get_vnet_hash_supported_types = vhost_vdpa_get_vnet_hash_supported_types,
+    .set_vnet_hash = vhost_vdpa_set_vnet_hash,
     .has_ufo = vhost_vdpa_has_ufo,
     .check_peer_type = vhost_vdpa_check_peer_type,
 };

-- 
2.46.0



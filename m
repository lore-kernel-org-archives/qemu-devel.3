Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642E3C35FE1
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 01:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spe0K-0002pj-Lx; Sat, 14 Sep 2024 21:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spe0H-0002p9-9m
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:24:42 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spe0F-0005RF-NS
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:24:41 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-71788bfe60eso2466693b3a.1
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2024 18:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726363477; x=1726968277;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yTKMLrThNs3dDMSlreK+ICpdf6za+wNhj1qJUdDtbIo=;
 b=lNbT4h0Pw575LN5xrvKA2delDYklaum3sStyH4Mk+yySyu8xaqq2IA3qge8ucgDVBb
 FdWYrKHbSMXgRnLmB1xG8kfFh7FtC9DYr6ky6ocyz38Ex10p2HTzE+z8t7cB8hBumkBD
 7Or2w1HEBMjwXOJhBOU77zi7TC3AwmlxercdfeVlBdD/xlVHM8twi4IWH7fRhwE7b+jg
 yjddGoJQWOoEhZxwTGD8WbG/DC9CR/KnDvFrA7MfiQU+9ZJEOPKJEDi39tm5JW8Jt9em
 67uR2/PUDhm3eRIQhIG1zd9cW/LEi/j3oKLGic1EjuW+EvkfBywdFeGCK/oRoeWmK9eu
 9A6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726363477; x=1726968277;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yTKMLrThNs3dDMSlreK+ICpdf6za+wNhj1qJUdDtbIo=;
 b=Uuls1QR7sZ5B0IJYChg3kKX395Pa5d2Ni38ruRypx9YFfJm6qEFpVdDfit0w0l6q2I
 96T/YPWyTKO5xidkGjkvS8aevLKt23Nx9+DtbCwGYeDMH0RPSphqr+iHucqtcUDwvohu
 afyS6ZgYTGnnJiumASxC/mvNu/Y1Zjz4j0N+XJj+Ew8dSRo3sb4C3hBf/XHoPiwLPiMx
 fK6b0o5KBeY2rt2g5L1bxAMR5eYEBksOkIUy1+80MoCBkjUq9epo0ZCayxhkZFvzakeI
 Ga/mA1NcDwz4ZvoNscdzY+PnRmWVT4pU8E9O/S4k5UuocE7yVw+MHyHS/Dl4HqqmYusb
 4eIw==
X-Gm-Message-State: AOJu0YwM76K+7jZGMS2jDc1O+5o01zx+rJWIjV8XZzHC5IIg73xMK7Js
 9PTbnObDW41or3qNFInE4ueMz3seRAIUjFBI61CdS8hvJ11tygTmJP0KZC9l027JbDJ7TeBO2Ad
 LXOM=
X-Google-Smtp-Source: AGHT+IF51Z3E1n81FIknv+NP7KqLvmXf1UHAyU8TlecPRkU/WdUhRauCD08sHwMOYE+RCQvvAvtGKg==
X-Received: by 2002:a05:6a21:1190:b0:1cf:6baf:61c0 with SMTP id
 adf61e73a8af0-1cf764c29e6mr17117920637.44.1726363477574; 
 Sat, 14 Sep 2024 18:24:37 -0700 (PDT)
Received: from localhost ([210.160.217.68])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-719449b370fsm1529648b3a.0.2024.09.14.18.24.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Sep 2024 18:24:37 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 15 Sep 2024 10:23:43 +0900
Subject: [PATCH RFC v3 02/11] net/vhost-vdpa: Report hashing capability
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240915-hash-v3-2-79cb08d28647@daynix.com>
References: <20240915-hash-v3-0-79cb08d28647@daynix.com>
In-Reply-To: <20240915-hash-v3-0-79cb08d28647@daynix.com>
To: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
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

Report hashing capability so that virtio-net can deliver the correct
capability information to the guest.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/net/net.h |  3 +++
 net/net.c         |  9 +++++++++
 net/vhost-vdpa.c  | 28 ++++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/include/net/net.h b/include/net/net.h
index c8f679761bf9..099616c8cbe3 100644
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
@@ -192,6 +194,7 @@ void qemu_set_offload(NetClientState *nc, int csum, int tso4, int tso6,
                       int ecn, int ufo, int uso4, int uso6);
 int qemu_get_vnet_hdr_len(NetClientState *nc);
 void qemu_set_vnet_hdr_len(NetClientState *nc, int len);
+bool qemu_get_vnet_hash_supported_types(NetClientState *nc, uint32_t *types);
 int qemu_set_vnet_le(NetClientState *nc, bool is_le);
 int qemu_set_vnet_be(NetClientState *nc, bool is_be);
 void qemu_macaddr_default_if_unset(MACAddr *macaddr);
diff --git a/net/net.c b/net/net.c
index 6938da05e077..3b04f8fe5d6b 100644
--- a/net/net.c
+++ b/net/net.c
@@ -559,6 +559,15 @@ void qemu_set_vnet_hdr_len(NetClientState *nc, int len)
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
index 03457ead663a..af0c3c448c1f 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -258,6 +258,32 @@ static bool vhost_vdpa_has_vnet_hdr(NetClientState *nc)
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
@@ -436,6 +462,7 @@ static NetClientInfo net_vhost_vdpa_info = {
         .stop = vhost_vdpa_net_client_stop,
         .cleanup = vhost_vdpa_cleanup,
         .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
+        .get_vnet_hash_supported_types = vhost_vdpa_get_vnet_hash_supported_types,
         .has_ufo = vhost_vdpa_has_ufo,
         .check_peer_type = vhost_vdpa_check_peer_type,
         .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,
@@ -1303,6 +1330,7 @@ static NetClientInfo net_vhost_vdpa_cvq_info = {
     .stop = vhost_vdpa_net_cvq_stop,
     .cleanup = vhost_vdpa_cleanup,
     .has_vnet_hdr = vhost_vdpa_has_vnet_hdr,
+    .get_vnet_hash_supported_types = vhost_vdpa_get_vnet_hash_supported_types,
     .has_ufo = vhost_vdpa_has_ufo,
     .check_peer_type = vhost_vdpa_check_peer_type,
     .set_steering_ebpf = vhost_vdpa_set_steering_ebpf,

-- 
2.46.0



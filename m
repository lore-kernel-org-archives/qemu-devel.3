Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC8AC54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 04:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKrWh-0006sq-Vw; Fri, 30 May 2025 00:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKrWg-0006s5-A0
 for qemu-devel@nongnu.org; Fri, 30 May 2025 00:39:26 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uKrWe-0006rQ-DN
 for qemu-devel@nongnu.org; Fri, 30 May 2025 00:39:25 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b2c41acd479so1186167a12.2
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 21:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1748579963; x=1749184763;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Mx7zGASuywiR+Ti11wYezZ6qGVfJB8X9zlwy+2u3tYU=;
 b=VQl/1Ir4TSMDpxodTk/0CLfl7ewkvIOAhpVAliNO6H2b7FEjsIE/L4Ukbu46gMQe0D
 6kv5gnvTB/zz6+Z4HDswU1tIln2oN5MC/RMBU43dEyzHrVgDme6fPYhrhnDj0sgv7xdO
 /MLU/Ei1H0g4OjvG1Uoh+rsd6dukyU3khcSBwtStiFnDEmvr6uff9jshCOWYI72v5DrU
 gYq4O/Lt4L1l5t+yF7zKAdVJsrMxz+5BtpQVRGD4T2uB8A6diTY7n9101i1AfNAwLwwv
 AJzV0XbDS58IhiqnxhTA4Wmk4dla6EPFm1JxP/mzC+IhY+9s+W4bhq+i9ozuvEt8hy7l
 RWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748579963; x=1749184763;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mx7zGASuywiR+Ti11wYezZ6qGVfJB8X9zlwy+2u3tYU=;
 b=vcf25SOUcsjWvkRYY0C5ajfHwHQQ9cUwKGlURbuutIDzm3A6nqZSXzeK8KyBg96y4k
 /emY5+84PDmW0nOdbEuVmFDQug9XI+Ii2dG/GJHX3UlXC2MDPNcDofQ7oUogNJ3va2sH
 TKu3UXu+RpTtVp7gMcGlcAW/Jh380ucBKB1YP5E7aiyTDKKyfEZ3ybnfNwBdj7+MA1bm
 9088EBabmMI8BI9Fjf8kQIjGk9lSJkCGos314+/sS8ueFPHVYtYHnXqwLBYMT0ljUoGI
 3qFrW/arnHq+Dag6HMWFhg6IfuSKIlDMJ7U3IRsAcXeD34DVObrOOmIJsxLzOfbkCotL
 7irA==
X-Gm-Message-State: AOJu0Yw18rCX2K2JVu0KdetMcT1/nLE5CVexKgMJlQJ2W5G7XdD118Ib
 gWovcTLY8TwjskRe/UVjdbCBD6zlCOD1rWrmT5EuXx69nwbDUsUv5hT2JYCV5hKYGxY=
X-Gm-Gg: ASbGncuynvQ90XOOFxe5OlBaQrBwXoqiJLcPPw1spfm4tuKAruu3HUvkZwsAtJURBqN
 PdfEzqwpMZlvm1+NQHI2n58yo8TRGrPdYBMx8EDMEJSWLUk9i+8xTDJNKyL5PcY658RfJLUmqvr
 nxtLuiZOikgPmu15KykFB/hq6g+ii/qZbi8RV/a+MSKz9+IWxfUjn2roQfoVtWUfqwgG6e3cr6X
 smPZzYy3HRTRSOEp3IjbgqMp7IkM9LBDpQvuZMx7jzYWLHo1QKTwdoKl49LOiXrTjFWzby8SP4h
 Lq9Ak5QTEl5lMwuoF4IiakiLhaqg9jzupkd/Zt/y+napTaflnDFi
X-Google-Smtp-Source: AGHT+IFLbR9TY06Ln9AL54x2ktJlvUISgmUTKebG27Rh2dHIPHqLTDXmYgEHz0Qdw+mCPzti2xo/oA==
X-Received: by 2002:a17:90b:17c5:b0:311:eb85:96f2 with SMTP id
 98e67ed59e1d1-31241735eadmr2577665a91.21.1748579962596; 
 Thu, 29 May 2025 21:39:22 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-3124e2e9c9fsm359092a91.30.2025.05.29.21.39.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 May 2025 21:39:22 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 30 May 2025 13:39:12 +0900
Subject: [PATCH RFC v5 4/5] tap: Report virtio-net hashing support on Linux
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-hash-v5-4-343d7d7a8200@daynix.com>
References: <20250530-hash-v5-0-343d7d7a8200@daynix.com>
In-Reply-To: <20250530-hash-v5-0-343d7d7a8200@daynix.com>
To: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Paolo Abeni <pabeni@redhat.com>, devel@daynix.com
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x533.google.com
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

This allows offloading virtio-net hashing to tap on Linux.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 net/tap-linux.h   | 1 +
 net/tap_int.h     | 1 +
 net/tap-bsd.c     | 5 +++++
 net/tap-linux.c   | 5 +++++
 net/tap-solaris.c | 5 +++++
 net/tap-stub.c    | 5 +++++
 net/tap.c         | 8 ++++++++
 7 files changed, 30 insertions(+)

diff --git a/net/tap-linux.h b/net/tap-linux.h
index 5bca6cab1867..fe30f4f27788 100644
--- a/net/tap-linux.h
+++ b/net/tap-linux.h
@@ -32,6 +32,7 @@
 #define TUNSETVNETLE _IOW('T', 220, int)
 #define TUNSETVNETBE _IOW('T', 222, int)
 #define TUNSETSTEERINGEBPF _IOR('T', 224, int)
+#define TUNGETVNETHASHTYPES _IOR('T', 228, __u32)
 #define TUNSETVNETREPORTINGAUTOMQ _IOR('T', 229, __u32)
 #define TUNSETVNETREPORTINGRSS _IOR('T', 230, NetVnetRss)
 #define TUNSETVNETRSS _IOR('T', 231, struct NetVnetRss)
diff --git a/net/tap_int.h b/net/tap_int.h
index 248d1efa51a0..5ff9ca721928 100644
--- a/net/tap_int.h
+++ b/net/tap_int.h
@@ -36,6 +36,7 @@ ssize_t tap_read_packet(int tapfd, uint8_t *buf, int maxlen);
 
 void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp);
 int tap_probe_vnet_hdr(int fd, Error **errp);
+bool tap_probe_vnet_hash_supported_types(int fd, uint32_t *types);
 int tap_probe_has_ufo(int fd);
 int tap_probe_has_uso(int fd);
 void tap_fd_set_offload(int fd, int csum, int tso4, int tso6, int ecn, int ufo,
diff --git a/net/tap-bsd.c b/net/tap-bsd.c
index 8ed384f02c5b..749732138502 100644
--- a/net/tap-bsd.c
+++ b/net/tap-bsd.c
@@ -217,6 +217,11 @@ int tap_probe_has_uso(int fd)
     return 0;
 }
 
+bool tap_probe_vnet_hash_supported_types(int fd, uint32_t *types)
+{
+    return false;
+}
+
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
 }
diff --git a/net/tap-linux.c b/net/tap-linux.c
index d0adb168e977..76fc88acaa18 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -196,6 +196,11 @@ int tap_probe_has_uso(int fd)
     return 1;
 }
 
+bool tap_probe_vnet_hash_supported_types(int fd, uint32_t *types)
+{
+    return !ioctl(fd, TUNGETVNETHASHTYPES, types);
+}
+
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
     if (ioctl(fd, TUNSETVNETHDRSZ, &len) == -1) {
diff --git a/net/tap-solaris.c b/net/tap-solaris.c
index bc76a030e7f9..65234c49a196 100644
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -221,6 +221,11 @@ int tap_probe_has_uso(int fd)
     return 0;
 }
 
+bool tap_probe_vnet_hash_supported_types(int fd, uint32_t *types)
+{
+    return false;
+}
+
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
 }
diff --git a/net/tap-stub.c b/net/tap-stub.c
index 511ddfc707eb..281bae2615d2 100644
--- a/net/tap-stub.c
+++ b/net/tap-stub.c
@@ -52,6 +52,11 @@ int tap_probe_has_uso(int fd)
     return 0;
 }
 
+bool tap_probe_vnet_hash_supported_types(int fd, uint32_t *types)
+{
+    return false;
+}
+
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
 }
diff --git a/net/tap.c b/net/tap.c
index e93f5f951057..4a8adcf447eb 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -248,6 +248,13 @@ static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
     s->using_vnet_hdr = true;
 }
 
+static bool tap_get_vnet_hash_supported_types(NetClientState *nc,
+                                              uint32_t *types)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    return tap_probe_vnet_hash_supported_types(s->fd, types);
+}
+
 static void tap_set_vnet_automq(NetClientState *nc, uint32_t hash_types)
 {
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
@@ -357,6 +364,7 @@ static NetClientInfo net_tap_info = {
     .has_vnet_hdr_len = tap_has_vnet_hdr_len,
     .set_offload = tap_set_offload,
     .set_vnet_hdr_len = tap_set_vnet_hdr_len,
+    .get_vnet_hash_supported_types = tap_get_vnet_hash_supported_types,
     .set_vnet_automq = tap_set_vnet_automq,
     .set_vnet_rss = tap_set_vnet_rss,
     .set_vnet_le = tap_set_vnet_le,

-- 
2.49.0



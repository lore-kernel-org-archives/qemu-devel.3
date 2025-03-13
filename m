Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F505C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 06:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tscW9-0000iS-NR; Thu, 13 Mar 2025 02:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tscUQ-00070J-Di
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 02:56:24 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tscUO-0006AW-CM
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 02:56:21 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2235189adaeso12351285ad.0
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 23:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741848979; x=1742453779;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3l8pjiY/8aFlXCHEH1zkcj/A8CNP0bkWehdzO/Jxnbc=;
 b=cMssw+LtWZG1BwxNKwYAG1CEc7G3+Q+V5hTzhS+ibmNp67pzRStjOOs1Gy7cwfQ8zr
 JYl3xX9emC5P9kX96iQaSdyFH5ON81FQXatAwu8lPFPjejFZmrCbhBfoMnwy4NG8w31v
 e/J717UjT6yLyeQTtotetnxOaILVCBIOgYDiRxmkGuq+S/3YAQqx0GWBbDbuJU4NmzpL
 n+lEwMI6kr5/9KtKeAF17IlDajWPDpFGbLEeKFRu6xV0Zy9z2quwB5srI7Bieb5ipulQ
 PGk2JKkhwy7vZNvbemoXh5FIO8bC0nn9JU80qyx5VxYSmRm0aWC+4ZHVvn6Kp7XsUGIC
 Ttxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741848979; x=1742453779;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3l8pjiY/8aFlXCHEH1zkcj/A8CNP0bkWehdzO/Jxnbc=;
 b=TZPIkNY0mwJk86FUwsJuD7DkerRM4YzfAcnWO+LbEk1V9KYn9l3ZiE2krOufSkdtST
 Lqy4cgr/+BhLFj3tZRd5DCo5eWl6MgUqaJGD7vMqPM7HqEMbJucnQWzmL71cK4TSq1KO
 SiTL2aamSx8HeCUJ2VvRaNTJQt4cx6iTba+FoIAndLudBFlF7f6hsco/Q8q/EB/AJM0z
 bdCWF59KpcqIxLBdRecyok2gLnScgzXeDJgFt6FkCmcKIcmCsfC49t95OQ0cH1+dh26Q
 Rh5t2sbEHXoHDtMAkIvbTKk7WXup4DtYiiOKsX8KiUgqYhFAtKCQ7XEHehgCBIQCraYo
 aw4g==
X-Gm-Message-State: AOJu0YyraG6uOC6UOJVXhOxfBFbvUNOQ9qb6IHB6aK1BYe1ctcTID25i
 Ev1XhlQLLUL5UeAPRLqYHeZuqO0rxr3DOSEOEIFPzLTxQCL2Wp98vu24tNA5R9iwjas/tCQ4g01
 gWAQ=
X-Gm-Gg: ASbGncute0MV1p/+oXMgdTUl5ohWvKpDVkfr3qQKCslMv8kjvEbz57qp9RViWq9m49/
 YtP9uKqkqTMlbyJMFPpCM5Ht+VMEee15Wobv7qyOHInQ8Fw3Hix9wBVdYh9FXSSBKXkPe/HGZoB
 Rx7uX39JcU7BiYPHr3g7f3nX6+lhFJYevbqRFjjVEESVGkdGc04aJH2Nndw98clOFnh5NfSOlYH
 BcXQl/DLhh1l6Z9IlSjWnEKZj2GeNcmE28G6PXktnkVkTI4daUgbqxyY0iYXKruhNUNjTJuvitL
 3yWM20VMflr+fgHgAw9AnLJeshDzkKORSmYlEW3u6MIcwLQ6
X-Google-Smtp-Source: AGHT+IFHYQLcL3jYqNXIztTlYD6SrwDfla3IzYqGPL510xDOCPaRxZ4YxSBTaGh7c2ISg3p0vCNz/A==
X-Received: by 2002:a17:902:cf0a:b0:21f:53a5:19e0 with SMTP id
 d9443c01a7336-225c66317bfmr20723055ad.12.1741848979144; 
 Wed, 12 Mar 2025 23:56:19 -0700 (PDT)
Received: from localhost ([157.82.205.237])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-225c688d93esm6515125ad.45.2025.03.12.23.56.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Mar 2025 23:56:18 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 13 Mar 2025 15:55:36 +0900
Subject: [PATCH RFC v4 10/11] tap: Report virtio-net hashing support on Linux
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-hash-v4-10-c75c494b495e@daynix.com>
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

This allows offloading virtio-net hashing to tap on Linux.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 net/tap-linux.h   |  1 +
 net/tap_int.h     |  1 +
 net/tap-bsd.c     |  5 +++++
 net/tap-linux.c   | 13 +++++++++++++
 net/tap-solaris.c |  5 +++++
 net/tap-stub.c    |  5 +++++
 net/tap.c         |  8 ++++++++
 7 files changed, 38 insertions(+)

diff --git a/net/tap-linux.h b/net/tap-linux.h
index 5fac64c24f99..c773609c799e 100644
--- a/net/tap-linux.h
+++ b/net/tap-linux.h
@@ -32,6 +32,7 @@
 #define TUNSETVNETLE _IOW('T', 220, int)
 #define TUNSETVNETBE _IOW('T', 222, int)
 #define TUNSETSTEERINGEBPF _IOR('T', 224, int)
+#define TUNGETVNETHASHCAP _IOR('T', 228, NetVnetHash)
 #define TUNSETVNETHASH _IOW('T', 229, NetVnetHash)
 
 #endif
diff --git a/net/tap_int.h b/net/tap_int.h
index e1b53e343397..84a88841b720 100644
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
index 2eee0c0a0ec5..142e1abe0420 100644
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
index c053828b056b..b45039ecbbb1 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -196,6 +196,19 @@ int tap_probe_has_uso(int fd)
     return 1;
 }
 
+bool tap_probe_vnet_hash_supported_types(int fd, uint32_t *types)
+{
+    NetVnetHash hash;
+
+    if (ioctl(fd, TUNGETVNETHASHCAP, &hash)) {
+        return false;
+    }
+
+    *types = hash.types;
+
+    return true;
+}
+
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
     if (ioctl(fd, TUNSETVNETHDRSZ, &len) == -1) {
diff --git a/net/tap-solaris.c b/net/tap-solaris.c
index c65104b84e93..00d1c850680d 100644
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
index 5bdc76216b7f..a4718654fbeb 100644
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
index 1136018c1965..98083bcd515e 100644
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
 static void tap_set_vnet_hash(NetClientState *nc, const NetVnetHash *hash)
 {
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
@@ -350,6 +357,7 @@ static NetClientInfo net_tap_info = {
     .has_vnet_hdr_len = tap_has_vnet_hdr_len,
     .set_offload = tap_set_offload,
     .set_vnet_hdr_len = tap_set_vnet_hdr_len,
+    .get_vnet_hash_supported_types = tap_get_vnet_hash_supported_types,
     .set_vnet_hash = tap_set_vnet_hash,
     .set_vnet_le = tap_set_vnet_le,
     .set_vnet_be = tap_set_vnet_be,

-- 
2.48.1



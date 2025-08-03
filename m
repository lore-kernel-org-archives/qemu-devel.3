Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B6B7C87FCB
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 08:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiTgo-0006xZ-7I; Sun, 03 Aug 2025 04:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <murlockkinght@gmail.com>)
 id 1uiQrY-0004Ob-3O
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 01:02:24 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <murlockkinght@gmail.com>)
 id 1uiQrW-0007M6-01
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 01:02:23 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5550dca1241so2736577e87.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 22:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754197338; x=1754802138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NwucwcSXfwXkVavnOGWSBLXmJ1XhOY3pa2/WitbGGN4=;
 b=CpTqYc+xgtc9Um2cCFLFdfAotGcnIxYBFZUmdCe2EtWy8bmUZKY1NvvZDXN4Wiucsd
 r10aBVM7AvIiuonrQd4S1E4Id4ZPGNQ8Eb/LWTKT/vcO5ZilDIFCDZx1DXdIboEsiGB5
 UnlyevAND4+pKmfbflTaSC1DfnkA3ykNKpEwUFB1uZa5c2VR5FhAcYRtD+RpvnBZCCI8
 KxX+FMkTE7V1G3V5O88eVp/dTPfRrz30Q4wCDFKjPnUT/aaSw8B3+Ug0EMhkIPpGfa5b
 pZX1gBm6BvJvbLxy/83Sq8S7A6Hba99B3umSXJfVjGeN91ImufK6mtaxCFNPw2iWwbco
 qiWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754197338; x=1754802138;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NwucwcSXfwXkVavnOGWSBLXmJ1XhOY3pa2/WitbGGN4=;
 b=OgdIOSpbiDTPNu/fXLRfe3Fqb46S7qaljH4iafO9Fo1zTTG0cm7zGBeLaJeccLjuZT
 Kxx8BGdLyeyyh+s/FECTI1sEMeOIuUEVZqzXVivqiAAO5KQxwvb0nxUDri2Cyn46Auah
 WOxB8MSb5aEYhHS1dMG4QOTZ2qiMw/XA0SUx/7loemt4hHHpToviGTzE8V58Tl9wEOTK
 4zELeHmGIlSlfA2Z14JeYm6LC2BoL3Rmb3SeYGsVVJb+CjLBTKVMBppuitUbwyXoetss
 OBVUH/ZQkQouA8Lt620NqHs9Akxffb4aBJ9un+vqBk8v6LlR148o70Wp/M1mYqHcjmhD
 7Arw==
X-Gm-Message-State: AOJu0Yxbhbzu8OpjoxkNA5mSsCMu1BRmv0EQIp14085sBStbOA1S4Ngd
 noiYVp5yd3mCAtAimcwwIdT+8Lpyr/5dkTeDbHIZkpfn+vfVyPdxaQxp3frBZSi8
X-Gm-Gg: ASbGnct5PpnrGCmLit1UAFZbr/9NiZnkAc1AJSjA4ySg82J359EKIewFbVX7ZIFsYaJ
 Mv5PoH7tSikkLsSCqyLBabbLN95ehxytXKGV/zGziwVNiBxwVRLknl51K6o9Jc2bJvR0ZDU+sxi
 wLXzpYNwamLAVUDLd3X1n/dVFkP41GlrBsz/AK3eYp2bBhwvYeIIdk7GeibgcZSfepkjF9acsFH
 +CigbZr5aAnRsS+rmaw54e+ZvB6ZCfP5ItkdUfjOZHUaJxswOdYZu+KN+10FYw/CsSNaORqDtrU
 brOlWjWMUVROSNyHVwEOjGmzs42VMZB4sM8m1rcZXq/KuKG6mYD7U8cnfNj1QHWQXYrZvwk2cjd
 h0RmXUtz/mLQGQBGv/oMDXD2Vi+smJJVgf7Ki7b0fOXTy5WM=
X-Google-Smtp-Source: AGHT+IH6jebBZXAdP9TCmdIBkI6tClkdexnw/vsp6RuwG7UQVOFlqdJ8zuFIdQeAuz+X1wKNAtc0VQ==
X-Received: by 2002:a05:6512:23a1:b0:55b:81d8:dcf3 with SMTP id
 2adb3069b0e04-55b97b7fcddmr1445829e87.32.1754197338085; 
 Sat, 02 Aug 2025 22:02:18 -0700 (PDT)
Received: from MURLOC (l37-193-36-68.novotelecom.ru. [37.193.36.68])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55b8898bd6esm1225462e87.6.2025.08.02.22.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 22:02:17 -0700 (PDT)
From: Viktor Kurilko <murlockkinght@gmail.com>
To: qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org,
	Viktor Kurilko <murlockkinght@gmail.com>
Subject: [PATCH v2] Add a feature for mapping a host unix socket to a guest
 tcp socket
Date: Sun,  3 Aug 2025 12:01:04 +0700
Message-ID: <20250803050124.32007-1-murlockkinght@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=murlockkinght@gmail.com; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 03 Aug 2025 03:14:05 -0400
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

This patch adds the ability to map a host unix socket to a guest tcp socket when
using the slirp backend. This feature was added in libslirp version 4.7.0.

Signed-off-by: Viktor Kurilko <murlockkinght@gmail.com>
---
Fixed checking the path length.
Fixed copying the path.
Unnecessary access has been deleted.
Unlink is needed to delete the socket remaining from the previous vm.

 net/slirp.c | 61 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 13 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index 9657e86a84..d096ee7ce6 100644
--- a/net/slirp.c
+++ b/net/slirp.c
@@ -795,12 +795,16 @@ void hmp_hostfwd_remove(Monitor *mon, const QDict *qdict)
 
 static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
 {
-    struct sockaddr_in host_addr = {
-        .sin_family = AF_INET,
-        .sin_addr = {
-            .s_addr = INADDR_ANY,
-        },
-    };
+    union {
+        struct sockaddr_in in;
+#if !defined(WIN32) && SLIRP_CHECK_VERSION(4, 7, 0)
+        struct sockaddr_un un;
+#endif
+    } host_addr = {0};
+    host_addr.in.sin_family = AF_INET;
+    host_addr.in.sin_addr.s_addr = INADDR_ANY;
+    socklen_t host_addr_size = sizeof(host_addr.in);
+
     struct sockaddr_in guest_addr = {
         .sin_family = AF_INET,
         .sin_addr = {
@@ -833,7 +837,7 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
         fail_reason = "Missing : separator";
         goto fail_syntax;
     }
-    if (buf[0] != '\0' && !inet_aton(buf, &host_addr.sin_addr)) {
+    if (buf[0] != '\0' && !inet_aton(buf, &host_addr.in.sin_addr)) {
         fail_reason = "Bad host address";
         goto fail_syntax;
     }
@@ -842,12 +846,43 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
         fail_reason = "Bad host port separator";
         goto fail_syntax;
     }
-    err = qemu_strtoi(buf, &end, 0, &host_port);
-    if (err || host_port < 0 || host_port > 65535) {
-        fail_reason = "Bad host port";
-        goto fail_syntax;
+#if !defined(WIN32) && SLIRP_CHECK_VERSION(4, 7, 0)
+    if (buf[0] == '/') {
+        if (is_udp) {
+            fail_reason = "Mapping unix to udp is not supported";
+            goto fail_syntax;
+        }
+        size_t path_len = strlen(buf);
+        if (path_len > sizeof(host_addr.un.sun_path) - 1) {
+            fail_reason = "Unix socket path is too long";
+            goto fail_syntax;
+        }
+
+        struct stat st;
+        if (stat(buf, &st) == 0) {
+            if (!S_ISSOCK(st.st_mode)) {
+                fail_reason = "file exists and it's not unix socket";
+                goto fail_syntax;
+            }
+
+            if (unlink(buf) < 0) {
+                error_setg_errno(errp, errno, "Failed to unlink '%s'", buf);
+                goto fail_syntax;
+            }
+        }
+        host_addr.un.sun_family = AF_UNIX;
+        memcpy(host_addr.un.sun_path, buf, path_len);
+        host_addr_size = sizeof(host_addr.un);
+    } else
+#endif
+    {
+        err = qemu_strtoi(buf, &end, 0, &host_port);
+        if (err || host_port < 0 || host_port > 65535) {
+            fail_reason = "Bad host port";
+            goto fail_syntax;
+        }
+        host_addr.in.sin_port = htons(host_port);
     }
-    host_addr.sin_port = htons(host_port);
 
     if (get_str_sep(buf, sizeof(buf), &p, ':') < 0) {
         fail_reason = "Missing guest address";
@@ -867,7 +902,7 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
 
 #if SLIRP_CHECK_VERSION(4, 5, 0)
     err = slirp_add_hostxfwd(s->slirp,
-            (struct sockaddr *) &host_addr, sizeof(host_addr),
+            (struct sockaddr *) &host_addr, host_addr_size,
             (struct sockaddr *) &guest_addr, sizeof(guest_addr),
             is_udp ? SLIRP_HOSTFWD_UDP : 0);
 #else
-- 
2.50.1



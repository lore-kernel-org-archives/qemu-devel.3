Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E066C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 04:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ui43q-0001Qz-65; Sat, 02 Aug 2025 00:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <murlockkinght@gmail.com>)
 id 1ui38M-0003xe-6k
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 23:42:10 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <murlockkinght@gmail.com>)
 id 1ui38K-0007sY-Fy
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 23:42:09 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-55b7e35a452so3252813e87.2
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 20:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754106125; x=1754710925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HA/sSTJ/TsrP8e7BaMtckKqvisPKBTmwGV5a6cGQNl8=;
 b=QSrpPa3U9ZUoaf4GkfTxLm7qD4NMsvN3pEagEPe2PRcvAKsKq9qhZpjLRnbICqcRoc
 M/YkX6aTPU3NUtKpftxiq8OAMN1ghjsKhHowIoeW6p4tPX9fVb1PZmS5f7ri6JWLtAiJ
 Knw5M5Cgxsvm1C3as9ii9DuY9OIRpVOKB7LB4X3ktyvGfV8VlvZLoA4yqZwRzFQqaTsu
 VyzcrM0YlYQPL63pS56KoLb2HHr9apwMsPSdvFNgpVp/ivMOvdm6nnXLnFOgOVTwC26S
 8Ulp4D3PRA3VsxhPfJD5TkFC59fdSMNUxqAbhiIivSirXlsSoi0TEZC/IKxVxjMtZdg9
 iDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754106125; x=1754710925;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HA/sSTJ/TsrP8e7BaMtckKqvisPKBTmwGV5a6cGQNl8=;
 b=WVu/CiNWaIGYw9ZzbnfN00nEAGIT8ArvbHT6Fnwwb2b5Y1lVyBrzByhem4MNQJPSQq
 SxcAJrp6vE8XUVlBiL//blfbf/NnIG1pPGPaa2sgMYlq7zH83m2dEvFugQyZqk24T4H7
 cGgR6p0BFJTz86LTL/Oo6CA2rbsjuOrTSNxxVLjgF1V/YmcwMNlFTdmzpoUu2Th6HdSk
 /2+JVOUMH+IwSY4m1btdnu2hIcfagdf2OOAJaZBo5y5Fdq1o2EP/PRuZakeuGY73wqf4
 mKeQi04m9Gxhyyb4yHWTGSGmGqOfMxQ3xIfGV7Qyb8vLSRnTuPk0F83JxoGm0qg6Q6h7
 IsMQ==
X-Gm-Message-State: AOJu0Yy56ji6j4+bG8PWqaoBSug3TvVwZEWepN5KQnnc2FLa+a5J6JNV
 XkiILO+dFC1PJ78A5F7HeEPX3QbvVtGx7TVnpkVJ7wqN0pv50j4tqtZoBB/8ZwRR
X-Gm-Gg: ASbGncv+iHrLGDJBDEuH3TlhhhFFzMcniPdlvIvpFJlNRMo97YAG3ug7Z8va/FgAuMm
 gFHNAeprUpnmKsHzrY/Il8WOW2MYsvb6F/gC1kzeY1iVKSdVA+3az3gIS44ltcZLqv9Ac61uBk3
 +OuvL6mmcV6fTpMzfkrkt3Hen/W8Ax5tDFptAvCld5R9ndxmAA/ctNSKlRtERf97TXnldGKcZuc
 0ZufVdNN3GBSJeVonwvufWFIlWYrFdjkwMeoEIk6aGPIz3OT8bVt/40mo/Doudg4P/PiaemGyNz
 vVTjniZ1D2Y5s2XYjQ2twHZeyE8j++VdpoaqsOQUb10HuP0nvvM1lqyQvPXwTKcHYAjBNJZYE81
 F5xCC8Iy127MygwF68X5ShVQ5tPS8R6tbqsfxQYM+CLKSc7Q=
X-Google-Smtp-Source: AGHT+IEZFUKdZR6c1vwIOHTUrL0O0LumK1Qqq9bHpNzd930u5KdxogzZocdU5doqUJavyFc9TQCbYQ==
X-Received: by 2002:a05:6512:1252:b0:55b:941d:bde3 with SMTP id
 2adb3069b0e04-55b97a67c13mr554810e87.10.1754106124496; 
 Fri, 01 Aug 2025 20:42:04 -0700 (PDT)
Received: from MURLOC (l37-193-36-68.novotelecom.ru. [37.193.36.68])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55b8898bd28sm830711e87.19.2025.08.01.20.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 20:42:03 -0700 (PDT)
From: Viktor Kurilko <murlockkinght@gmail.com>
To: qemu-devel@nongnu.org
Cc: samuel.thibault@ens-lyon.org,
	Viktor Kurilko <murlockkinght@gmail.com>
Subject: [PATCH] Add a feature for mapping a host unix socket to a guest tcp
 socket
Date: Sat,  2 Aug 2025 10:41:54 +0700
Message-ID: <20250802034154.7834-1-murlockkinght@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=murlockkinght@gmail.com; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 02 Aug 2025 00:41:32 -0400
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
 net/slirp.c | 65 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 52 insertions(+), 13 deletions(-)

diff --git a/net/slirp.c b/net/slirp.c
index 9657e86a84..fc03e58402 100644
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
@@ -842,12 +846,47 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
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
+        if (strlen(buf) > sizeof(host_addr.un.sun_path)) {
+            fail_reason = "Unix socket path is too long";
+            goto fail_syntax;
+        }
+        if (access(buf, F_OK) == 0) {
+            struct stat st;
+            if (stat(buf, &st) < 0) {
+                error_setg_errno(errp, errno, "Failed to stat '%s'", buf);
+                goto fail_syntax;
+            }
+
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
+
+        host_addr.un.sun_family = AF_UNIX;
+        memcpy(host_addr.un.sun_path, buf, sizeof(host_addr.un.sun_path));
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
@@ -867,7 +906,7 @@ static int slirp_hostfwd(SlirpState *s, const char *redir_str, Error **errp)
 
 #if SLIRP_CHECK_VERSION(4, 5, 0)
     err = slirp_add_hostxfwd(s->slirp,
-            (struct sockaddr *) &host_addr, sizeof(host_addr),
+            (struct sockaddr *) &host_addr, host_addr_size,
             (struct sockaddr *) &guest_addr, sizeof(guest_addr),
             is_udp ? SLIRP_HOSTFWD_UDP : 0);
 #else
-- 
2.50.1



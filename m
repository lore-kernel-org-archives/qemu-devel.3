Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE672C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 00:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saldi-0008Ef-IT; Sun, 04 Aug 2024 20:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saldg-00086B-FQ
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 20:31:52 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1salde-0002Jp-SH
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 20:31:52 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-70d2b921cd1so8973281b3a.1
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 17:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722817909; x=1723422709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W8wloA238Rk9C1XCBXsRbgtFn/P+Z4RpbJw5FHD4LSg=;
 b=no9g+cF7i2SPDvqzbjzzpwImCOBFaFlePq1zHQ9CMzNCoa9p7SpRW4SPLOtFeCrPqP
 40hI1xHC4cageNpmONS7xeIh4woZ39eVALO1BYfMOGdNGvaKOxM0bKjiEGJ5mZh8FSzT
 xiZYQuyTXvKwX9aeWGe1ND42zwPeBRJPnnkLg2hMMFcntpODWdOSPhpdG+OSKuSIXW34
 xiK4HvUE46oUrP+qCnP1z7x6bpZ1mDqLROSJQ2jOJztbg3JPO5qp4Y8r4aBFdamJjqqp
 0YC9fUPkK3DpX5EKf5TGC4QEYeSlfs9ahssUzmd4WwIhQFzjc2F6omEQCFv4Zl4sIEQ+
 NfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722817909; x=1723422709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W8wloA238Rk9C1XCBXsRbgtFn/P+Z4RpbJw5FHD4LSg=;
 b=Fdin+vjr8L/DyEoZ/pjscXJ7OiFKgR85zFbOgB8djfmor8H6TDDIwnCjHTG2oCEnfB
 YTOx7FH8SnKfiAkAIrUZ2g1xm/SDo7L38y5oJptSQSN+UPhxhUh9gHb4pVntJYsLVbr6
 e9SaT3sZTVdFQ+lQThDccdtSBtSTzxM+Rb3l6Rabxc7Dfw10ctpO6P5z+YAdc7fvK3F9
 aipLinyLqO2dRtzQeojjJhG2CRqKTsPD+vmDaKpACnidUrvF7OxiZ+W6NOom9gXULTDe
 g7oaIW6p12xmvW29CTQN7WLLOw6cevURV2aSJpejedAHPz9Ly/DI3FWenQTHB8wvnJKH
 3f0g==
X-Gm-Message-State: AOJu0Yz/WPsMIkHlAHf0rlU4BIn+NpfK8qzCG7YLAgzWuaB2E8G9vda5
 af61hgFcxbBy4kH4/TGT/V35+94oATTKPYeIL6dAGaw+Mkbu2edVrOMmsxK6qH/I3BVJBlZY/yX
 fAhY0nQ==
X-Google-Smtp-Source: AGHT+IHeBj42U4EyspU8ERcDuYOk1rg9SnhvJpOreqRiSepaXuyIpLjXYNVnWE6Tj+dOQnwSkArVeg==
X-Received: by 2002:a05:6a20:729c:b0:1be:c5d9:5a19 with SMTP id
 adf61e73a8af0-1c6995c9d4fmr16817280637.24.1722817909352; 
 Sun, 04 Aug 2024 17:31:49 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ed16cb3sm4576038b3a.179.2024.08.04.17.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Aug 2024 17:31:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 4/6] net/tap: Factorize fd closing after forking
Date: Mon,  5 Aug 2024 10:31:27 +1000
Message-ID: <20240805003130.1421051-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240805003130.1421051-1-richard.henderson@linaro.org>
References: <20240805003130.1421051-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Clément Léger <cleger@rivosinc.com>

The same code is used twice to actually close all open file descriptors
after forking. Factorize it in a single place.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240802145423.3232974-4-cleger@rivosinc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 net/tap.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/net/tap.c b/net/tap.c
index 51f7aec39d..7b2d5d5703 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -385,6 +385,17 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
     return s;
 }
 
+static void close_all_fds_after_fork(int excluded_fd)
+{
+    int open_max = sysconf(_SC_OPEN_MAX), i;
+
+    for (i = 3; i < open_max; i++) {
+        if (i != excluded_fd) {
+            close(i);
+        }
+    }
+}
+
 static void launch_script(const char *setup_script, const char *ifname,
                           int fd, Error **errp)
 {
@@ -400,13 +411,7 @@ static void launch_script(const char *setup_script, const char *ifname,
         return;
     }
     if (pid == 0) {
-        int open_max = sysconf(_SC_OPEN_MAX), i;
-
-        for (i = 3; i < open_max; i++) {
-            if (i != fd) {
-                close(i);
-            }
-        }
+        close_all_fds_after_fork(fd);
         parg = args;
         *parg++ = (char *)setup_script;
         *parg++ = (char *)ifname;
@@ -490,17 +495,11 @@ static int net_bridge_run_helper(const char *helper, const char *bridge,
         return -1;
     }
     if (pid == 0) {
-        int open_max = sysconf(_SC_OPEN_MAX), i;
         char *fd_buf = NULL;
         char *br_buf = NULL;
         char *helper_cmd = NULL;
 
-        for (i = 3; i < open_max; i++) {
-            if (i != sv[1]) {
-                close(i);
-            }
-        }
-
+        close_all_fds_after_fork(sv[1]);
         fd_buf = g_strdup_printf("%s%d", "--fd=", sv[1]);
 
         if (strrchr(helper, ' ') || strrchr(helper, '\t')) {
-- 
2.43.0



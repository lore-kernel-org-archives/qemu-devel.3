Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A75AC52D70
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 14:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZtgI-0003mj-Qp; Fri, 02 Aug 2024 10:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sZtgG-0003e6-B5
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 10:54:56 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1sZtgE-0005FX-Ok
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 10:54:56 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1fc53f91ed3so4589675ad.0
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 07:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722610493; x=1723215293;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MacBk+b81Y9XSBf3+Dejb8DivJ0DDo61Nr8SOpG9EWU=;
 b=pu0PDmphpWvAx2V7bKZPZi/uIpDD5LBQgrAfpnvPySfkCtt3wuPF0wMpLRtYWRlhu4
 gTOz1BO3pXuuXfySeOAG7G7935Tz0MQi8Xz1yo4Km0bI3CC5oIvIl5VJ9WOYDVLC/YZD
 IScS/x8HwGZqXo9EodlsdsWR1Werg4xoZkSGXTSqBeD86LFL7OP/aDUTSw9iTlqZ0PRl
 z+plNoRFfX4itVmi2w32ZE3K8tGm44PHvc4/Bmz880XEEiOsYPAjWMeY/BL09I0NOcFP
 ESDa/Fu4+0NkMfQewTdpn/am3A6CcVTqEKZNb3iqkonciKo+F+8MeqmIaVRrdJQSeY9r
 dGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722610493; x=1723215293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MacBk+b81Y9XSBf3+Dejb8DivJ0DDo61Nr8SOpG9EWU=;
 b=m7VwL1Evgcg4txXwXGwoUq/0bwzWIaEILqidzMXLwYAlBjjTjaOM/nWWY0dnTMJW+u
 oXfHVQUuRKkYxpysVvEsSKT1xoGjbFDbDamwTOU7G/jTrgc/2hSTTjQWH9P+55NGb3WI
 XxPfAyxD5OClRFae429Ip84Uxgi28nSlzrCRxsHhW1PyRwU86XJC9p6Jr02qGf9xTglV
 D3vUhxW00eJ8o/x8VIYbV/TD2mFgmXZB0G3W8Bsk4oVJZF+2krhkhO0M7ArH53q47QBr
 CNre93Re6IChkEAXHMRrUQexFdp3w8Je6x3myA4fQhNsIyRlTrrkfANUiTRaqq8g8CdC
 PuJA==
X-Gm-Message-State: AOJu0Yxr/FpvAPPaCqIC0pu6Y3Rstb/vuwVoOBaBd1rGLD7JGBkMEUrw
 eC2YT4MazTlrPGjF/Sqvmys1zdmUxu+hwuy14f+4lHflcQ0zQg+VrsLC8aGhcWYpDgMkCny86jl
 XsDQ=
X-Google-Smtp-Source: AGHT+IEU6nGKnBmqq1WFJHeOlgdzhC0aE5oD0LAj7ZziQ8yOn1c8448Jrw6KxX8QKwu90VS16vX0Ig==
X-Received: by 2002:a17:902:f9c6:b0:1f7:2576:7f88 with SMTP id
 d9443c01a7336-1ff57422d34mr27930775ad.6.1722610492647; 
 Fri, 02 Aug 2024 07:54:52 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff592aee19sm17920635ad.282.2024.08.02.07.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 07:54:52 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v8 3/5] net/tap: Factorize fd closing after forking
Date: Fri,  2 Aug 2024 16:54:19 +0200
Message-ID: <20240802145423.3232974-4-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802145423.3232974-1-cleger@rivosinc.com>
References: <20240802145423.3232974-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=cleger@rivosinc.com; helo=mail-pl1-x62d.google.com
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

The same code is used twice to actually close all open file descriptors
after forking. Factorize it in a single place.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
2.45.2



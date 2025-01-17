Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9430FC02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:29:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr5w-0007D3-UH; Fri, 17 Jan 2025 13:29:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5m-0005uv-UA
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:15 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5k-0000K0-Pm
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:29:14 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso45917705ad.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138551; x=1737743351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0BxlAlZ9XLTNeL7T1oRc03rmXf8028Tv8zN2J/x03Ms=;
 b=H0QoWTduSe/TwLqIho0SC6EzyZO0G8GTlsM8WlPTOW7soCysFWqkWSh4HHwKUzuOg9
 8rQz2XPCsvdy8LJpqh+vemZPx+ZqKcNzAjd8XHr86CvMqRLSPDK2TTEPIS1HGdL4f/f0
 2jImlyi2yJ9Y6mUIDtfMvmtjXSuAz2V52eXHVP7v8jiZIVs+PcqOqVzp78Ki3LQlbjB5
 sD0H29B/S9LF6ockF5gHQ4bI6KHZtVpPBpcXT4B5SFLt7ZrrE71DWbQZxXK0mgY5TEbA
 tKe19WJ2l5CCpfqlvyOaoQBfT/S3gLaNK28kSBBY5pxR+XPGP8NdyvdmP0X9kw98TCff
 f4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138551; x=1737743351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0BxlAlZ9XLTNeL7T1oRc03rmXf8028Tv8zN2J/x03Ms=;
 b=KZ74kEE3I5e76IBOKUhHpNxKO6swRuc/LrVtzFk25/PsC2EiogVTXrwkuKgYH0uASx
 BbUW0ElHAxYgLVfcuYGXOBphrdPzw3W52l6r8r5bfjhOle23aQgAvUIG1KIG/xf+S46R
 J46A+/fbN9Qz7QXPI4qF3x9tmMzVSUVl8BFnzClNgFUZwjfgBROF7WPBHUMmzk7uf4QG
 8lSbKrJmwEsAotUSSDpcWhf6CMyaGexLOghI50JeEzO7/FxJ2LesrIDoR+75oenzoxBE
 wj0Reh9fqzWtIesLRlFXfruSx+yE6leVlptnuOmGamWA0qokITgo85kfS50jEAa48yzL
 pC1A==
X-Gm-Message-State: AOJu0Yz0uTzqI67gge0U8yGP1aROv8z7ml0AbRB6chfLmrOowLfi7yOH
 74zKffQpIS7Hu+Q2FWDdxBFHaxdrHMerSVOIF8hXux2Mhw503MLIotYiLbm1glJKqDTFZatUlAJ
 b
X-Gm-Gg: ASbGncv70xZB0Piw5LiC0kAVSeBHuDLIHOFrsLvQ0mfp7PpEzqCSeWPRq+Qi5XWtUF9
 8fvz09Z02Zz9HP7ropKzsG+Tg4PGGATxwEpS20Q3aTm3nLIXjunN+dlht0VW4NiJFAdJI3sxVOB
 NR9Aq4cQLsgQHot4d98PTjE4OiD3bbLMawyFdh7P30huSFBNBJvP25MVW8XRHGfedIsr0zgQnFO
 Bs7i+pFBpZaUwLzP3o0o1wBBhfj8qip2n12GCZmgvwJwDFQlleYmpo7FN9MWQXMzN4nmGHCf5Qu
 2b2oVomRwmIzPqU=
X-Google-Smtp-Source: AGHT+IGzgnZCSOt2iPSXLwM2jt/nbTK6MQSeBmeYtJv1a3cF6vNccqVeh9Hs+3o0gqXgtz9+0dKceg==
X-Received: by 2002:a17:90b:1f88:b0:2ee:db8a:2a01 with SMTP id
 98e67ed59e1d1-2f782d5d838mr5106023a91.30.1737138551290; 
 Fri, 17 Jan 2025 10:29:11 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f77629bf96sm2614105a91.36.2025.01.17.10.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:29:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 63/68] util/cpuinfo-riscv: Detect Zbs
Date: Fri, 17 Jan 2025 10:24:51 -0800
Message-ID: <20250117182456.2077110-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250102181601.1421059-2-richard.henderson@linaro.org>
---
 host/include/riscv/host/cpuinfo.h |  5 +++--
 util/cpuinfo-riscv.c              | 18 ++++++++++++++++--
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/host/include/riscv/host/cpuinfo.h b/host/include/riscv/host/cpuinfo.h
index cdc784e7b6..b2b53dbf62 100644
--- a/host/include/riscv/host/cpuinfo.h
+++ b/host/include/riscv/host/cpuinfo.h
@@ -9,8 +9,9 @@
 #define CPUINFO_ALWAYS          (1u << 0)  /* so cpuinfo is nonzero */
 #define CPUINFO_ZBA             (1u << 1)
 #define CPUINFO_ZBB             (1u << 2)
-#define CPUINFO_ZICOND          (1u << 3)
-#define CPUINFO_ZVE64X          (1u << 4)
+#define CPUINFO_ZBS             (1u << 3)
+#define CPUINFO_ZICOND          (1u << 4)
+#define CPUINFO_ZVE64X          (1u << 5)
 
 /* Initialized with a constructor. */
 extern unsigned cpuinfo;
diff --git a/util/cpuinfo-riscv.c b/util/cpuinfo-riscv.c
index 971c924012..0291b7218a 100644
--- a/util/cpuinfo-riscv.c
+++ b/util/cpuinfo-riscv.c
@@ -36,7 +36,8 @@ static void sigill_handler(int signo, siginfo_t *si, void *data)
 /* Called both as constructor and (possibly) via other constructors. */
 unsigned __attribute__((constructor)) cpuinfo_init(void)
 {
-    unsigned left = CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZICOND | CPUINFO_ZVE64X;
+    unsigned left = CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZBS
+                  | CPUINFO_ZICOND | CPUINFO_ZVE64X;
     unsigned info = cpuinfo;
 
     if (info) {
@@ -50,6 +51,9 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
 #if defined(__riscv_arch_test) && defined(__riscv_zbb)
     info |= CPUINFO_ZBB;
 #endif
+#if defined(__riscv_arch_test) && defined(__riscv_zbs)
+    info |= CPUINFO_ZBS;
+#endif
 #if defined(__riscv_arch_test) && defined(__riscv_zicond)
     info |= CPUINFO_ZICOND;
 #endif
@@ -71,7 +75,8 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
             && pair.key >= 0) {
             info |= pair.value & RISCV_HWPROBE_EXT_ZBA ? CPUINFO_ZBA : 0;
             info |= pair.value & RISCV_HWPROBE_EXT_ZBB ? CPUINFO_ZBB : 0;
-            left &= ~(CPUINFO_ZBA | CPUINFO_ZBB);
+            info |= pair.value & RISCV_HWPROBE_EXT_ZBS ? CPUINFO_ZBS : 0;
+            left &= ~(CPUINFO_ZBA | CPUINFO_ZBB | CPUINFO_ZBS);
 #ifdef RISCV_HWPROBE_EXT_ZICOND
             info |= pair.value & RISCV_HWPROBE_EXT_ZICOND ? CPUINFO_ZICOND : 0;
             left &= ~CPUINFO_ZICOND;
@@ -117,6 +122,15 @@ unsigned __attribute__((constructor)) cpuinfo_init(void)
             left &= ~CPUINFO_ZBB;
         }
 
+        if (left & CPUINFO_ZBS) {
+            /* Probe for Zbs: bext zero,zero,zero. */
+            got_sigill = 0;
+            asm volatile(".insn r 0x33, 5, 0x24, zero, zero, zero"
+                         : : : "memory");
+            info |= got_sigill ? 0 : CPUINFO_ZBS;
+            left &= ~CPUINFO_ZBS;
+        }
+
         if (left & CPUINFO_ZICOND) {
             /* Probe for Zicond: czero.eqz zero,zero,zero. */
             got_sigill = 0;
-- 
2.43.0



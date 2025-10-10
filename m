Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0C5CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 05:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v75aI-0006ig-8q; Fri, 10 Oct 2025 01:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v75aG-0006hh-78
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 01:22:28 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v75aB-0000q3-U1
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 01:22:27 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b85so1796326f8f.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 22:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760073737; x=1760678537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zbFtXmgKLDprgmGJY/TWguwPUYSMMdFqqAgUegtnmcg=;
 b=Ns+sFRzXi7KlsTzD8RH5kqJzyl3I246T2hLiVE/utNmg3Q+EC4EVStqQsJpRLYMr3L
 WrTfkxMTVYAa/Qy9wjGFtbQozrWB21MX/XB5nMotd5bNzM8ryajx+fI6RAmd4MGN35Mn
 8t8s+2pSU92g4F52aBiskDkFGCO3J2Wq/QL5LU+TJ5s0Gm5Aj8clTbubOYD1Lu23nalk
 C5MUexBouI9fTFcr25w+f7G8XTZAwV4H4Q8U3ZOgaZmsXAFKWoecfqEpl2zozsYbNJFk
 LaE/P7NEqA/GwMHhXvkv4BHAOc3CCmgu6ath148A5OBfW/t0qrOuzlmFbotq4YonMNMZ
 6TAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760073737; x=1760678537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zbFtXmgKLDprgmGJY/TWguwPUYSMMdFqqAgUegtnmcg=;
 b=uY7wU98xLZgfFrjp2g5V5Er3pP3ae15LU8jVneZIgIoZxYwwRScVksemoQLlWz900r
 DcQFUB83UgQzmdH1QgcwuudJjKntMWlxHDfpwDaPk1jnwAaXWibf03CrKgkt/4Rzw+tE
 E6hq7B+gi6vAWp2IzOOYJgWCCytwQTyx7yk3gfUZzeSD4QxtdMN+7NCPa1jigydnkLN5
 kKJBc4Ggm93rqkBH5XgTKTW+F4u65jtJKG9JF5xh/bID9Eh6ry7oAguQY1jSp1PgB5y7
 L9AaW08nMBEloK/VMSr/0VSZx+Tkovqbkk1b2JUmuTJb/miBvqXj4FTUvMGP/zFNSoDr
 xOXg==
X-Gm-Message-State: AOJu0YwsV5BESh0eg8al2qtS+0vL6DnL0INQQ2qVGT49QqrPTtw567o2
 NZI/oKrf4UoYf46VIHXExqRtKIz2QQg6WZHXn456gFojF+76ml1bDUhp/oxgae3zlx6VGXHHFg0
 B9ftzW2S2+w==
X-Gm-Gg: ASbGncsK9AkbBD7n4sHPVJe0C8lWHNzoxWodT6iDtjRtRL+7hWcgcVdbddTKR5SRHrC
 zbSBi8EnP/8+/DejZ5CPtGvslz3p/vI3GkHg16CbCSAsBey9y10SuFDxghmNJ2+62OnjOZfY+3H
 PNJP0r2+L5k/+ndmavExWJ56B1QjhEE1YicVytvmrTCPTSm3M7da/jjBoKczRBx/B/0C424Mda5
 C+qP5dqJQFQI36de7X6+BgpwV2mf8L61BDkWl1bwbc9hqcEVwP8XD/f30RZ+O/t5IgV3UjhY+ZA
 pmwIrGayTkaqZevaOYh9YL6zKA7cFz6WDNM0lSfuPTUvA9Pj5bLcg7/o5juJjogB2PZlV/4e4Mg
 K6aarZbcDnRuSp1JSDup96In3+3iRLZuycjSWttOvJ2yYZX6AkhiM40aYRdugx3KKgD2WXLn6RO
 LxpOsNJHAyBKXp21wNCkUhkAvb
X-Google-Smtp-Source: AGHT+IGjAam7DSezyPUygk8j4H0YDzjetHExV3RuauPFbbn9jxCYD9UGZtY6gsONAtEnwDopzUHxag==
X-Received: by 2002:a05:6000:24ca:b0:3ea:15cd:ac3b with SMTP id
 ffacd0b85a97d-4266e7e15eemr5830413f8f.30.1760073737392; 
 Thu, 09 Oct 2025 22:22:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce5cfe74sm2224658f8f.35.2025.10.09.22.22.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 22:22:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 07/12] target/tricore: Declare registers as TCGv_i32
Date: Fri, 10 Oct 2025 07:21:35 +0200
Message-ID: <20251010052141.42460-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010052141.42460-1-philmd@linaro.org>
References: <20251010052141.42460-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

CPUTriCoreState register are declared as uint32_t since the
target introduction in commit 48e06fe0ed8 ("target-tricore:
Add target stubs and qom-cpu").

Mechanical replacement of:

  TCGv -> TCGv_i32
  tcg_temp_new -> tcg_temp_new_i32

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/tricore/translate.c | 80 +++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 116f45135bb..194c4db8d0f 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -44,19 +44,19 @@
 /*
  * TCG registers
  */
-static TCGv cpu_PC;
-static TCGv cpu_PCXI;
-static TCGv cpu_PSW;
-static TCGv cpu_ICR;
+static TCGv_i32 cpu_PC;
+static TCGv_i32 cpu_PCXI;
+static TCGv_i32 cpu_PSW;
+static TCGv_i32 cpu_ICR;
 /* GPR registers */
-static TCGv cpu_gpr_a[16];
-static TCGv cpu_gpr_d[16];
+static TCGv_i32 cpu_gpr_a[16];
+static TCGv_i32 cpu_gpr_d[16];
 /* PSW Flag cache */
-static TCGv cpu_PSW_C;
-static TCGv cpu_PSW_V;
-static TCGv cpu_PSW_SV;
-static TCGv cpu_PSW_AV;
-static TCGv cpu_PSW_SAV;
+static TCGv_i32 cpu_PSW_C;
+static TCGv_i32 cpu_PSW_V;
+static TCGv_i32 cpu_PSW_SV;
+static TCGv_i32 cpu_PSW_AV;
+static TCGv_i32 cpu_PSW_SAV;
 
 static const char *regnames_a[] = {
       "a0"  , "a1"  , "a2"  , "a3" , "a4"  , "a5" ,
@@ -8480,14 +8480,14 @@ void cpu_state_reset(CPUTriCoreState *env)
 
 static void tricore_tcg_init_csfr(void)
 {
-    cpu_PCXI = tcg_global_mem_new(tcg_env,
-                          offsetof(CPUTriCoreState, PCXI), "PCXI");
-    cpu_PSW = tcg_global_mem_new(tcg_env,
-                          offsetof(CPUTriCoreState, PSW), "PSW");
-    cpu_PC = tcg_global_mem_new(tcg_env,
-                          offsetof(CPUTriCoreState, PC), "PC");
-    cpu_ICR = tcg_global_mem_new(tcg_env,
-                          offsetof(CPUTriCoreState, ICR), "ICR");
+    cpu_PCXI = tcg_global_mem_new_i32(tcg_env,
+                                      offsetof(CPUTriCoreState, PCXI), "PCXI");
+    cpu_PSW = tcg_global_mem_new_i32(tcg_env,
+                                     offsetof(CPUTriCoreState, PSW), "PSW");
+    cpu_PC = tcg_global_mem_new_i32(tcg_env,
+                                    offsetof(CPUTriCoreState, PC), "PC");
+    cpu_ICR = tcg_global_mem_new_i32(tcg_env,
+                                     offsetof(CPUTriCoreState, ICR), "ICR");
 }
 
 void tricore_tcg_init(void)
@@ -8496,30 +8496,30 @@ void tricore_tcg_init(void)
 
     /* reg init */
     for (i = 0 ; i < 16 ; i++) {
-        cpu_gpr_a[i] = tcg_global_mem_new(tcg_env,
-                                          offsetof(CPUTriCoreState, gpr_a[i]),
-                                          regnames_a[i]);
+        cpu_gpr_a[i] = tcg_global_mem_new_i32(tcg_env,
+                                              offsetof(CPUTriCoreState, gpr_a[i]),
+                                              regnames_a[i]);
     }
     for (i = 0 ; i < 16 ; i++) {
-        cpu_gpr_d[i] = tcg_global_mem_new(tcg_env,
-                                  offsetof(CPUTriCoreState, gpr_d[i]),
-                                           regnames_d[i]);
+        cpu_gpr_d[i] = tcg_global_mem_new_i32(tcg_env,
+                                              offsetof(CPUTriCoreState, gpr_d[i]),
+                                                       regnames_d[i]);
     }
     tricore_tcg_init_csfr();
     /* init PSW flag cache */
-    cpu_PSW_C = tcg_global_mem_new(tcg_env,
-                                   offsetof(CPUTriCoreState, PSW_USB_C),
-                                   "PSW_C");
-    cpu_PSW_V = tcg_global_mem_new(tcg_env,
-                                   offsetof(CPUTriCoreState, PSW_USB_V),
-                                   "PSW_V");
-    cpu_PSW_SV = tcg_global_mem_new(tcg_env,
-                                    offsetof(CPUTriCoreState, PSW_USB_SV),
-                                    "PSW_SV");
-    cpu_PSW_AV = tcg_global_mem_new(tcg_env,
-                                    offsetof(CPUTriCoreState, PSW_USB_AV),
-                                    "PSW_AV");
-    cpu_PSW_SAV = tcg_global_mem_new(tcg_env,
-                                     offsetof(CPUTriCoreState, PSW_USB_SAV),
-                                     "PSW_SAV");
+    cpu_PSW_C = tcg_global_mem_new_i32(tcg_env,
+                                       offsetof(CPUTriCoreState, PSW_USB_C),
+                                       "PSW_C");
+    cpu_PSW_V = tcg_global_mem_new_i32(tcg_env,
+                                       offsetof(CPUTriCoreState, PSW_USB_V),
+                                       "PSW_V");
+    cpu_PSW_SV = tcg_global_mem_new_i32(tcg_env,
+                                        offsetof(CPUTriCoreState, PSW_USB_SV),
+                                        "PSW_SV");
+    cpu_PSW_AV = tcg_global_mem_new_i32(tcg_env,
+                                        offsetof(CPUTriCoreState, PSW_USB_AV),
+                                        "PSW_AV");
+    cpu_PSW_SAV = tcg_global_mem_new_i32(tcg_env,
+                                         offsetof(CPUTriCoreState, PSW_USB_SAV),
+                                         "PSW_SAV");
 }
-- 
2.51.0



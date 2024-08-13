Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE38C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 10:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdoch-0006Uf-6y; Tue, 13 Aug 2024 06:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdocf-0006U7-IP
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 06:19:25 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdocd-0005oJ-N5
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 06:19:25 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2f0dfdc9e16so63370511fa.2
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 03:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723544362; x=1724149162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lA8uJXpJ/5fYFYlheHCIQUkasDjz5vKdapmYLx+X7e0=;
 b=U0TmQD0zaW4fVqXRZtYi+r/oabh2OV+nGnpxGZaoDP+2zUcqlyEIRG3lPNL9MKHteM
 mL0QhEypGsvlxENdwvTJlJmM9lG7IxORnoyBAaqJ0Dw3AjLp/zfyhSsWzfQgcXzc6pDD
 cWjf1IvM+FOR0d5l2SiJyar6PvlqkLBdZgC0kq5RG/WkFvvhSSOsamu6fglVCcYBUFz1
 Z9rdtr7skUr0KDmmHtKJ/+H9KhKAbBxa9ksMinlQLmNLa7MMek2t5hj9jsSDWM83X8fL
 zJMRXDHtyJoyuBgcuZgFEyVrDqNflP8Ms2BkgT54GKM/7ZfG6ogT/Oma98HmeBz4YRgZ
 APTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723544362; x=1724149162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lA8uJXpJ/5fYFYlheHCIQUkasDjz5vKdapmYLx+X7e0=;
 b=AkVnJvE+gHIL6ZdsF7Ykh9BqFaeZUo2KBA0fP2uF5oB2PA2tcOUClifySQwV3JJsV7
 JJXqGXbj+lBW408j6Eu3pDT0ET4Z0Ob3dwi2GBsBmD9QMDlFB50fbzuxmC8DHi3wZPKP
 yQCrTNZL+neuLSkX4iSypNiYJox8Xnp67Y5IMXzueotXJRNVUi/QFGy5MEurYmfT83HR
 lS3SmizsVyjtGu48fOppnVS/goa0ibgW3zlhp25Qnbib5TFlgbCHgcI2lSivNyLXkpc9
 jmkFindTN03QVhyzQ//IU1Mv9N25Fb9vdB7Eu+jprDd+ZXBJDS380VIVBOoCSA4SwYHe
 8OVQ==
X-Gm-Message-State: AOJu0YwmNAcw03QrBxfS1ZeQSLnVeEn5yfJ1k5H0bUs80nJePHFGFm/H
 AnflZaC6mgLUfa5jNYwXQOUU0qemBJPpuS3hs8OrIZOO9nZp6uvzbTFhgANMrrEeIPa0pGJ80/S
 XecE=
X-Google-Smtp-Source: AGHT+IEyqflq6Pl8VxJ9lZUmgtGAU7kpLCARNI0gu+c/YaqILxA7QXlA36JJ8daHTGMD1FW/fB2qVQ==
X-Received: by 2002:a2e:a7ca:0:b0:2ee:8453:5164 with SMTP id
 38308e7fff4ca-2f2b70cb3c9mr24176611fa.0.1723544361515; 
 Tue, 13 Aug 2024 03:19:21 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.17])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bd196a7a11sm2852621a12.53.2024.08.13.03.19.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Aug 2024 03:19:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Waldemar Brodkorb <wbx@uclibc-ng.org>
Subject: [PATCH-for-9.1 v2 1/2] target/mips: Pass page table entry size in
 bytes to get_pte()
Date: Tue, 13 Aug 2024 12:18:55 +0200
Message-ID: <20240813101856.49469-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240813101856.49469-1-philmd@linaro.org>
References: <20240813101856.49469-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In order to simplify a bit, pass the PTE size in
bytes rather than bits.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/sysemu/tlb_helper.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/mips/tcg/sysemu/tlb_helper.c b/target/mips/tcg/sysemu/tlb_helper.c
index 3ba6d369a6..a8caf3ade8 100644
--- a/target/mips/tcg/sysemu/tlb_helper.c
+++ b/target/mips/tcg/sysemu/tlb_helper.c
@@ -592,13 +592,13 @@ static void raise_mmu_exception(CPUMIPSState *env, target_ulong address,
  * resulting in a TLB or XTLB Refill exception.
  */
 
-static bool get_pte(CPUMIPSState *env, uint64_t vaddr, int entry_size,
+static bool get_pte(CPUMIPSState *env, uint64_t vaddr, unsigned entry_bytes,
         uint64_t *pte)
 {
-    if ((vaddr & ((entry_size >> 3) - 1)) != 0) {
+    if ((vaddr & (entry_bytes - 1)) != 0) {
         return false;
     }
-    if (entry_size == 64) {
+    if (entry_bytes == 8) {
         *pte = cpu_ldq_code(env, vaddr);
     } else {
         *pte = cpu_ldl_code(env, vaddr);
@@ -607,11 +607,11 @@ static bool get_pte(CPUMIPSState *env, uint64_t vaddr, int entry_size,
 }
 
 static uint64_t get_tlb_entry_layout(CPUMIPSState *env, uint64_t entry,
-        int entry_size, int ptei)
+                                     unsigned entry_bytes, int ptei)
 {
     uint64_t result = entry;
     uint64_t rixi;
-    if (ptei > entry_size) {
+    if (ptei > entry_bytes >> 3) {
         ptei -= 32;
     }
     result >>= (ptei - 2);
@@ -630,8 +630,8 @@ static int walk_directory(CPUMIPSState *env, uint64_t *vaddr,
     int psn = (env->CP0_PWCtl >> CP0PC_PSN) & 0x3F;
     int hugepg = (env->CP0_PWCtl >> CP0PC_HUGEPG) & 0x1;
     int pf_ptew = (env->CP0_PWField >> CP0PF_PTEW) & 0x3F;
-    uint32_t direntry_size = 1 << (directory_shift + 3);
-    uint32_t leafentry_size = 1 << (leaf_shift + 3);
+    uint32_t direntry_size = 1 << directory_shift;
+    uint32_t leafentry_size = 1 << leaf_shift;
     uint64_t entry;
     uint64_t paddr;
     int prot;
@@ -768,7 +768,7 @@ static bool page_table_walk_refill(CPUMIPSState *env, vaddr address,
     ptoffset0 = (ptindex >> 1) << (leaf_shift + 1);
     ptoffset1 = ptoffset0 | (1 << (leaf_shift));
 
-    leafentry_size = 1 << (leaf_shift + 3);
+    leafentry_size = 1 << leaf_shift;
 
     /* Global Directory */
     if (gdw > 0) {
-- 
2.45.2



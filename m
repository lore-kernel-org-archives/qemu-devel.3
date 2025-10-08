Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58F2CCD185
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 06:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Nyi-00027H-Ct; Wed, 08 Oct 2025 02:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6NyY-000229-Pd
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:48:40 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6NyW-0005Y6-Tu
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:48:38 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e37d10f3eso47285615e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 23:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759906115; x=1760510915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=niV3VXeKZ/R/agh1MladGxoDpcz75nvco6B0hiwhPSQ=;
 b=prLY/COMJ/FKMwKuKyY754T9BCAXvxIQ5MqnMAN0YVuI++d70VxZinxcJv0JVjp0MX
 142aHbKv4oAV04l5IegWq96abMnmmBP+l6hZYO22KtBMwjxfGf63ZFPj5r8O10RyE/ji
 sMI9NXOq1YbJjsQfMIcgjX8kxx77l1mnLhX7wBTzfoscaFPgkFSkpHp8Ai2aIN781jUX
 iFdxKCGYu7Cm41AqVpaXpMSbveLhG3KctXBiM8ZT2hiPQa7Ty9d19+TNslIy96zDliM3
 El90D3HCS4k4rRMFxgVpSvk6ACBt2IKtMjH2B/EVfoJqaVfi9zca/t8oP0pcFNIaWQfm
 drwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759906115; x=1760510915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=niV3VXeKZ/R/agh1MladGxoDpcz75nvco6B0hiwhPSQ=;
 b=FR4NBoYCgnN4oAvqR4OiCcSteEb2lF3I5NDtHVjId6WwZ4AHiXBmNLuNpCeWrg3A40
 cWYnx02Ie1PhOjCJztDhapKoDQZ9sffpycpsvuuh1F2nvMr4RVhfMBzmjZvO27CLIRUw
 f3t2s+/65FoxEorKvnHEVh99Wsh0mtX+pEIcW1QJJoDVK3Zq9dGkY0xoq9Fkvap1zlCU
 n0HYu+oQ7ELRj0xvMXdpVHSkRFUIZtLwK+u01dLVgxQg9aHYU9j3Q3sz519V+a2HDUmD
 YNxw9nwBn+2MZV693jScbNC48HM8aMnLou0KlaEm4D6kIzaeyMfadokWtFge8mEgEmGT
 rS+g==
X-Gm-Message-State: AOJu0YxdVqtGmX81MOYDNvnKFIS12sRK7Afqf6tec9Yh3I77rB63Asrd
 LniD0lE53/WN1FMKolIDz4GFtNcUpUogs9osMymAHkGAiEZ5HVR+LESYOiUl/vWg32Ux+2/9/Kj
 OVp2aAHEoUQ==
X-Gm-Gg: ASbGncuzPniMc44vkErKRHr11ElF9Mspb1L0c7+FNZPdoVkTwPgVVb5nJe75au7uhyE
 3xeAFrXCIzMlMux4VUnHMbUq1MEzPgwBSMw+pdOHHcF6tu0uSnVSBIXswFfeX8Mg6Hz5PkKj1RD
 Y9bbnyOm1oW4HJyQRlV0P1Vix/Qn3qBU4wKOtkcInDhXmgPYorqVHGol/JyZVae0P5skqUr3O2A
 fKd+a5qjZV/fLtGfOYsOPRr1CpZyKjC6SYG5RvxbJ4JTV0qg3u7I7QgVFHkUC8ftTOpsHuRf2R2
 ZNn7bmt5WV6qxF8AMrpj0UoI7edYH4LIgiSqxfzSpsuDhrxbfn9S0hoehMhpAxRqujbFVFMgc/k
 El8T5siTVOGGzuZTKQsdV0LSIYKj+heogtRd92esm5UkJXvXRyPDQphIqv/pG1s59q/cd9ZkaH/
 sS1Yb5PkJg3ZGtSIJcuU+9d5Yr
X-Google-Smtp-Source: AGHT+IEaHnuopLgU/D00QLOyE517TNJE/6Ubd43mkLzTYxzRRi71tv0TmSg51MGf0Ge+37dx83ZLhA==
X-Received: by 2002:a05:600c:1e85:b0:46e:39e4:1721 with SMTP id
 5b1f17b1804b1-46fa9aa261amr13330335e9.12.1759906114070; 
 Tue, 07 Oct 2025 23:48:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa9c0d267sm23835525e9.8.2025.10.07.23.48.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Oct 2025 23:48:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/6] target/sh4: Remove target_ulong uses in
 superh_cpu_get_phys_page_debug
Date: Wed,  8 Oct 2025 08:48:11 +0200
Message-ID: <20251008064814.90520-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008064814.90520-1-philmd@linaro.org>
References: <20251008064814.90520-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

The CPUClass::get_phys_page_debug() handler takes a 'vaddr' address
type since commit 00b941e581b ("cpu: Turn cpu_get_phys_page_debug()
into a CPUClass hook").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sh4/helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 0e13339b33b..345efbfdd0e 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -231,11 +231,11 @@ static int itlb_replacement(CPUSH4State * env)
 /* Find the corresponding entry in the right TLB
    Return entry, MMU_DTLB_MISS or MMU_DTLB_MULTIPLE
 */
-static int find_tlb_entry(CPUSH4State * env, target_ulong address,
+static int find_tlb_entry(CPUSH4State * env, vaddr address,
                           tlb_t * entries, uint8_t nbtlb, int use_asid)
 {
     int match = MMU_DTLB_MISS;
-    uint32_t start, end;
+    vaddr start, end;
     uint8_t asid;
     int i;
 
@@ -291,7 +291,7 @@ static int copy_utlb_entry_itlb(CPUSH4State *env, int utlb)
 /* Find itlb entry
    Return entry, MMU_ITLB_MISS, MMU_ITLB_MULTIPLE or MMU_DTLB_MULTIPLE
 */
-static int find_itlb_entry(CPUSH4State * env, target_ulong address,
+static int find_itlb_entry(CPUSH4State *env, vaddr address,
                            int use_asid)
 {
     int e;
@@ -309,7 +309,7 @@ static int find_itlb_entry(CPUSH4State * env, target_ulong address,
 
 /* Find utlb entry
    Return entry, MMU_DTLB_MISS, MMU_DTLB_MULTIPLE */
-static int find_utlb_entry(CPUSH4State * env, target_ulong address, int use_asid)
+static int find_utlb_entry(CPUSH4State *env, vaddr address, int use_asid)
 {
     /* per utlb access */
     increment_urc(env);
@@ -326,7 +326,7 @@ static int find_utlb_entry(CPUSH4State * env, target_ulong address, int use_asid
    MMU_IADDR_ERROR, MMU_DADDR_ERROR_READ, MMU_DADDR_ERROR_WRITE.
 */
 static int get_mmu_address(CPUSH4State *env, hwaddr *physical,
-                           int *prot, target_ulong address,
+                           int *prot, vaddr address,
                            MMUAccessType access_type)
 {
     int use_asid, n;
@@ -393,7 +393,7 @@ static int get_mmu_address(CPUSH4State *env, hwaddr *physical,
 }
 
 static int get_physical_address(CPUSH4State *env, hwaddr* physical,
-                                int *prot, target_ulong address,
+                                int *prot, vaddr address,
                                 MMUAccessType access_type)
 {
     /* P1, P2 and P4 areas do not use translation */
-- 
2.51.0



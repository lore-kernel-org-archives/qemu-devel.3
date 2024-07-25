Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AEF1C3DA70
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8NF-00063b-OC; Thu, 25 Jul 2024 19:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Mi-00032E-W3; Thu, 25 Jul 2024 19:59:21 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Md-0001id-VT; Thu, 25 Jul 2024 19:59:20 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70d1dadd5e9so422600b3a.2; 
 Thu, 25 Jul 2024 16:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951954; x=1722556754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PyjBmLiNfBMQZPRx+CP3vg4168pNueyaZlTMQ5ELWq4=;
 b=hLtNXozwT9vv5XFUJYSQBXrIiwziCg5zSByPWLCcMiLRPcUfnHvauoevXEXr/cxwBk
 Ekkgi/rsH1osAIYqtBl4SZ6eoIxENd8Ugtx84vz26ROUbsyLFWafE1EJtwDvXmOyb3mZ
 2kdai6txHWCr+aBMwdShe9chz6Uv0NmnJeaFzdb1LzpcM8lODzKnanMJ0fOCRjil65kJ
 TufDA8QfT1hlfildSNt7kp3FNGQCs1ifkVg8hjyyEXVKZoeaaBo84LvnNi2enGdCH1d9
 B3iHyjX+DBahBsYNX4U01Ug8n3mgXf4l2QykFuYgs5iAq72UXqCY7npOfUHRLY02GTmr
 r6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951954; x=1722556754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PyjBmLiNfBMQZPRx+CP3vg4168pNueyaZlTMQ5ELWq4=;
 b=RC5VA58NhMzzsLo4Ud/boxewOm7fBcIdX9MpC6R4jEH/H/ZIObSZHyEuipzBCYWJYU
 z2I4dHrXKu0gFhomkzUGOVOCxz/BneYvHdPEc3F+b4k+DyNYQFHenlGaC6pDY5VMykrJ
 L62ldlKzwG7MtzSlVf+H54TilKYXIOZR+uPJcMLt31+6ry69RZIUrh22Q1CdophiOSQW
 HMs8F/5cBoGwQcuK2ET0vLHFZPlLUjWjF3lG+xun0wte13zkshNu58RqXJALRoGX7VFd
 0AxEdWsufP3l8hjSg1LJJy0n73Nz+aEHWb0fgcdgDNJzh+mjKuWAccV3A0hb1TxAiLlj
 iLfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd29T5F61ZrO2q3ZFgR575yefvY6mAL4Qx8gI6+kaUV3P2/VxjmsNN2/zZ7WhHBID9XC9OH5XLEz1NTnWQoH2Y6HUj
X-Gm-Message-State: AOJu0YyOZhQuTOojJ10toThS6zjyVqHIr0SfoTqrtGHlG60u7hqrEQbZ
 IzqQ3wWd5sgMeVq+K0BEaCEp0vrfpmHo5nNp8ZOsMvrl8vXt2AJh1KG32g==
X-Google-Smtp-Source: AGHT+IGkVJKbqooKKvxkI3gycTxObYC3TBmSwNNoBSgqvEJqaX8O33RMbaYdOf7LP2k0Czyn4ddDCQ==
X-Received: by 2002:a05:6a20:4d98:b0:1c0:e42e:8508 with SMTP id
 adf61e73a8af0-1c47b203863mr3063401637.23.1721951954050; 
 Thu, 25 Jul 2024 16:59:14 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.59.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:59:13 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PULL 83/96] target/ppc/mmu-hash32.c: Inline and remove
 ppc_hash32_pte_prot()
Date: Fri, 26 Jul 2024 09:53:56 +1000
Message-ID: <20240725235410.451624-84-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

This is used only once and can be inlined.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu-hash32.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index 93559447ff..160311de87 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -37,17 +37,6 @@
 #  define LOG_BATS(...) do { } while (0)
 #endif
 
-static int ppc_hash32_pte_prot(int mmu_idx,
-                               target_ulong sr, ppc_hash_pte32_t pte)
-{
-    unsigned pp, key;
-
-    key = ppc_hash32_key(mmuidx_pr(mmu_idx), sr);
-    pp = pte.pte1 & HPTE32_R_PP;
-
-    return ppc_hash32_prot(key, pp, !!(sr & SR32_NX));
-}
-
 static target_ulong hash32_bat_size(int mmu_idx,
                                     target_ulong batu, target_ulong batl)
 {
@@ -341,10 +330,10 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
     CPUState *cs = CPU(cpu);
     CPUPPCState *env = &cpu->env;
     target_ulong sr;
-    hwaddr pte_offset;
+    hwaddr pte_offset, raddr;
     ppc_hash_pte32_t pte;
+    bool key;
     int prot;
-    hwaddr raddr;
 
     /* There are no hash32 large pages. */
     *psizep = TARGET_PAGE_BITS;
@@ -426,8 +415,8 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
                 "found PTE at offset %08" HWADDR_PRIx "\n", pte_offset);
 
     /* 7. Check access permissions */
-
-    prot = ppc_hash32_pte_prot(mmu_idx, sr, pte);
+    key = ppc_hash32_key(mmuidx_pr(mmu_idx), sr);
+    prot = ppc_hash32_prot(key, pte.pte1 & HPTE32_R_PP, sr & SR32_NX);
 
     if (!check_prot_access_type(prot, access_type)) {
         /* Access right violation */
-- 
2.45.2



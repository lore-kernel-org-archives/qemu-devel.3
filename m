Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21C1DC3DA4A
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2024 16:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdBpj-0006Y5-93; Sun, 11 Aug 2024 12:54:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdBpf-0006X6-CY
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 12:54:15 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdBpd-0001NM-Mb
 for qemu-devel@nongnu.org; Sun, 11 Aug 2024 12:54:15 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-36ba3b06186so1948129f8f.2
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2024 09:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723395251; x=1724000051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DgtScZp5V/ujQnHgw5dwPFrn6AurJ0lZHB0GF70OJbA=;
 b=UL/oz+7th6R0BCGXUHwbkTDLpNHdl7zWlUShQIce+XvfzhWi2ndjaUdcfyW1U8fCeO
 BFy8NRmjmD8tHuUQ0dIz3+0EvRI5WgXsXALtfiYwyDFodfkv85/w18euPcXyQTqX15UC
 mM403imywx2QmCF29GVxvSpKv3EPttv+b5X6ZkPCKl8qwFjEVuh3DwY8elK0eitGP1D0
 NH4zrcwCrcoEM8REQdh7HLwbGz5I8+xSVGySV7E5aOkv21TT7xaghiOLlqV+W6TgvOAJ
 M14B0pJxvlBF+HYZxHFmBq1wt5RG4douFGH0kn2TB3T1Ct++A8F7uzFYl2mySKpVZwZq
 N0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723395251; x=1724000051;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DgtScZp5V/ujQnHgw5dwPFrn6AurJ0lZHB0GF70OJbA=;
 b=Z5L8wtYseV2yNzabpD3Mz6ZtIEXyxQ14Jkr7uGsCPe2prEKQEfcg6kvnefp39db5VN
 HuNx0xNzkmPNHSXZKLqYwqI5/p3FqzttPw3oz6lVQkEYASbNLgnju68wfGGkQbr1w4VU
 /D9qKXEVkUew9+vpZIGJ/3n3wSZ5FQBQnTpLBR1HlXeDDqEile/7HmiL0ZUb40K6QlGQ
 KECTa+EXcRJ+GCcYbh8SSMK4zBwZjTZ8YSidbuM/YH6q6/X0o4Vp61SgVtqU1H01SgxL
 PaIp4KCp8a0pcY0JwOgAHVFtJGltgEdmOkpnV9XVTx4JAgq/+83paQCoiStDDozHEpYt
 PSbA==
X-Gm-Message-State: AOJu0Yx/izQE538azYlNdvRAVJ+/A/pXBELwDFXeURWdO908Nd8+3ni4
 fHYhffXWb5AcFtdBYVK3VeY0CO4uz4/moEPBjvJikYue51gICOx5T6aXhddeaASomZpuP6HdDXv
 H
X-Google-Smtp-Source: AGHT+IGbAXOI3QnAjZepP2jwXtwYPfMSh7pjv06YyPBjWcZ3X+2eGVJo0lgQMCyojCX/tPJXyY9uDw==
X-Received: by 2002:a5d:54d0:0:b0:367:4d9d:56a5 with SMTP id
 ffacd0b85a97d-36d5fd7fa73mr3945521f8f.44.1723395251076; 
 Sun, 11 Aug 2024 09:54:11 -0700 (PDT)
Received: from localhost.localdomain (181.red-95-127-41.staticip.rima-tde.net.
 [95.127.41.181]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4cfefa29sm5284344f8f.61.2024.08.11.09.54.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 11 Aug 2024 09:54:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Waldemar Brodkorb <wbx@uclibc-ng.org>
Subject: [PATCH-for-9.1] target/mips: Fix execution mode in
 page_table_walk_refill()
Date: Sun, 11 Aug 2024 18:54:07 +0200
Message-ID: <20240811165407.26312-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

When refactoring page_table_walk_refill() in commit 4e999bf419
we replaced the execution mode and forced it to kernel mode.
Restore the previous behavior to also get supervisor / user modes.

Reported-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Reported-by: Waldemar Brodkorb <wbx@uclibc-ng.org>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2470
Fixes: 4e999bf419 ("target/mips: Pass ptw_mmu_idx down from mips_cpu_tlb_fill")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/sysemu/tlb_helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/mips/tcg/sysemu/tlb_helper.c b/target/mips/tcg/sysemu/tlb_helper.c
index 3ba6d369a6..e7ae4f0bef 100644
--- a/target/mips/tcg/sysemu/tlb_helper.c
+++ b/target/mips/tcg/sysemu/tlb_helper.c
@@ -940,8 +940,9 @@ bool mips_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
          * Memory reads during hardware page table walking are performed
          * as if they were kernel-mode load instructions.
          */
-        int ptw_mmu_idx = (env->hflags & MIPS_HFLAG_ERL ?
-                           MMU_ERL_IDX : MMU_KERNEL_IDX);
+        int ptw_mmu_idx = (env->hflags & MIPS_HFLAG_ERL)
+                          ? MMU_ERL_IDX
+                          : (env->hflags & MIPS_HFLAG_KSU);
 
         if (page_table_walk_refill(env, address, ptw_mmu_idx)) {
             ret = get_physical_address(env, &physical, &prot, address,
-- 
2.45.2



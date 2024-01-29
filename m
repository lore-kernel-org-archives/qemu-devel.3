Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545A1C47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:36:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUb6A-0005mx-Mg; Mon, 29 Jan 2024 18:31:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb64-0005ah-3f
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:24 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUb62-00054Q-2d
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:31:23 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d51ba18e1bso31329825ad.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706571078; x=1707175878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/OUWFZBgzvOfgT4Ih6uQ0qaIP/PxSyaD+oSDUXr46+M=;
 b=uj1gZWoRXsILIVRJ+S2Tm28eMPZYBO6N5muLfVMuUDzhqg5qIys5IxNHhsVOndprg0
 /RpsKyVSeRPDzey//XAxeK1wAGi4H2bs0F5xnSpYVdLRDekrZgePPvWwBCiU/8LKKvnl
 gmp1fMFmLMxqaUJVgmfQRw3ytWOKSmT4aFlaTHFsVDSSIV5KerNoWMqeY5gtMLVMcHsx
 09XlOne+SB3yXUAczn+1ROg3MYC2IkDT1YArEJhowRyH58k8ckt8j/TpW3OvSGbfV3Vq
 oBE83NMa5HnqYdx3mdZf4v422vsgs/OB7vYDmSmTakDMHiPe15bI3aHtyS4qnz7ehcCN
 N4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706571078; x=1707175878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/OUWFZBgzvOfgT4Ih6uQ0qaIP/PxSyaD+oSDUXr46+M=;
 b=iB8L/W50rBD0o/OPobyjLE5bg+8+MupNYrJze0rPKs91p/Ruqs3SMpzagcHKFTE0Yp
 T2ypS5G4EofV7jPbsjZdI7OeZzUM8ziNBDHo0XbkBylfZk7GYmyy4u5WlfDK5B+jNG5e
 ku/uTcEV1k/IaB0uiIrMBE677BuMfKtacwgYXToAauh2WGV7AHTLnwmToAwm5Olw47jn
 4uc9+Q9FbumwtMQVWci0n0FvUQZ+woilnRrYCiD6ZQtNTqIZvFHkckmW+CBfHDwQ25Yc
 IBpruJvGhZP8E9gzOILlmScBpEYFxzWIT6+bltvrQeKhSeKOmYzTEtj7jpMdChAAo1+f
 ymOA==
X-Gm-Message-State: AOJu0YyWXC7e4YpDPy0BgGCWYLnKSLYzVSO4wUgGe75fP4M424ijkIku
 MbpMRXovPaBfyb9Bkozoj5aePBK5UBMwcZtQMpTFts+mbYhGDpJCv/wTUlV/pO7v7saDsPDlSyX
 00Ic=
X-Google-Smtp-Source: AGHT+IHlMdn7NiF3GUqkHMfKLb2OsyB1+8hlmszuwXHi1t/YNEEpKeL4pi9ONF5q0Nyw+NvUS5ZCDQ==
X-Received: by 2002:a17:903:2442:b0:1d7:490b:2c01 with SMTP id
 l2-20020a170903244200b001d7490b2c01mr6770981pls.8.1706571077951; 
 Mon, 29 Jan 2024 15:31:17 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 l6-20020a170902eb0600b001d8dbb867b1sm2710591plb.179.2024.01.29.15.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:31:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH 13/33] target/m68k: Populate CPUClass.mmu_index
Date: Tue, 30 Jan 2024 09:30:23 +1000
Message-Id: <20240129233043.34558-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129233043.34558-1-richard.henderson@linaro.org>
References: <20240129233043.34558-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 44000f5869..8a8392e694 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -56,6 +56,11 @@ static bool m68k_cpu_has_work(CPUState *cs)
     return cs->interrupt_request & CPU_INTERRUPT_HARD;
 }
 
+static int m68k_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    return cpu_env(cs)->sr & SR_S ? MMU_KERNEL_IDX : MMU_USER_IDX;
+}
+
 static void m68k_set_feature(CPUM68KState *env, int feature)
 {
     env->features |= BIT_ULL(feature);
@@ -551,6 +556,7 @@ static void m68k_cpu_class_init(ObjectClass *c, void *data)
 
     cc->class_by_name = m68k_cpu_class_by_name;
     cc->has_work = m68k_cpu_has_work;
+    cc->mmu_index = m68k_cpu_mmu_index;
     cc->dump_state = m68k_cpu_dump_state;
     cc->set_pc = m68k_cpu_set_pc;
     cc->get_pc = m68k_cpu_get_pc;
-- 
2.34.1



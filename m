Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF70CC282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdzJ-0007fF-3a; Tue, 04 Mar 2025 20:55:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdyX-0006ER-A7
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:09 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdyV-0000NP-Co
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:55:08 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22398e09e39so58667885ad.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139706; x=1741744506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZiODDY/366gqEbz3qx1fab9KEQDWoxxeKu1jXAINex8=;
 b=CdSjHsAdgDsdZmpVfJ1yg3zicdDfK3GKX6m/jTOZUvcG3NwALDcL2yqOwkr9iFxvsl
 OznaFah+vthWqu5P7KGPtlpEcNmOleDx6rwhT320uEbpZYy/d03xxNeZa0g7v3bF4lfa
 X/i2xYKu821esWPMTbWaH8Y1qnlp6uU4wl0mB2jj5SqgoK4TBJmUAZe9svOyVrB8PINV
 dKQXlWRscyFLvTTuK/1PhyPhNB3JLBzTdeFb7dPrTHWb98dM6vaP8o1D2fzasRlu02mI
 12jUBPE5Ud803SLP6UtSOYxvgG2NSxNcB+MpLwjdQRURnqaGKhAaRFUyPZ+vziAjVOKO
 FcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139706; x=1741744506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZiODDY/366gqEbz3qx1fab9KEQDWoxxeKu1jXAINex8=;
 b=txW3POo+kjKhNEG2w7UKwyGEFXHNMFuhMS+QvPIMIL3qataGoPkh2hXEK1wKS4wiNk
 24VrbcGoVaPkv1id0pvVgBhgXzk7slmDEj8PhQKlEOKtgKySW9E7uSU1y4zb+FZFKkJk
 BVCr8xiwpiG0aZirEh5IsJ24QphEtCnacXI1VkgvCDPDgrc36sYbChpS8DHg2tNYY1oy
 RRF8XIYaVA9Gye4qLQj1baoYeW0HDT79zNJdZpF1/ljPDZ2jDG3jDS37OVYahfoP4Vly
 eE86dLeWIL14EjX72GJhIr3LN8eGSHMjBae0iSO8QY3oXI5mLWDoZVBXtqouuTBqdSwI
 ac4w==
X-Gm-Message-State: AOJu0Ywf3vyEu2JE+iSvC+38ZoS8GliJV2hDiy8ZUP5DTG7GWbPvmuzh
 Jcwov4oa543xtd/Qx2Bd3TMPBMP0KdBw5eKcN67QsiuapDfo9G5wbDXwuhflfk4=
X-Gm-Gg: ASbGncuD5gLxFUQCbcO2MxL/tK2d4jX6CIzx+525W3Kn9yAShtGApdBGUow9RQW9N53
 2m5O0zR9FRgKtCiVyaCzp2wSs5ew2llYjG2aZ8plpT/xNTQxdfRGWNq+AGM/dkT61u5eVgxNUfz
 Kt8JPZKRud6cADmh/tjxprnZ6Hi+hl1xK+5vNuc8g19Mg6Q4stNtHr61uz32eKC0mrK3xUNPnb1
 FxT6IcQFN09ne/7wXVIoHU9g8wsL9km2f4tShwHv87sBgzPngysowZWRHkrvUZSMySpqqzN3QKk
 zL2jswD8Mp7t8AeEBwIFhM78+/rLw4Z0Dx/P6yCGyW4uqzctXSlltXJBjLvqwSA9kqshW2ZsxOL
 T5vbMmeA6jNGVo2owQSsKX6j9LoOP5CkpJN0IANaEuo35tke9vFs=
X-Google-Smtp-Source: AGHT+IFRM+CsB9vCeKqOmLx353E055ooYdaB87yK4mkQ8jaN74xzhKsdYU4bgBofWs3fvm4tPtV0iA==
X-Received: by 2002:a17:903:8c4:b0:220:f91a:4650 with SMTP id
 d9443c01a7336-223f1c95712mr18682595ad.19.1741139705719; 
 Tue, 04 Mar 2025 17:55:05 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.55.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:55:05 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 38/59] target/riscv/kvm: add extensions after 6.14-rc3 update
Date: Wed,  5 Mar 2025 11:52:46 +1000
Message-ID: <20250305015307.1463560-39-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Expose ziccrse, zabha and svvptc.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Message-ID: <20250221153758.652078-4-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 23ce779359..471fd554b3 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -274,6 +274,7 @@ static void kvm_riscv_update_cpu_misa_ext(RISCVCPU *cpu, CPUState *cs)
 static KVMCPUConfig kvm_multi_ext_cfgs[] = {
     KVM_EXT_CFG("zicbom", ext_zicbom, KVM_RISCV_ISA_EXT_ZICBOM),
     KVM_EXT_CFG("zicboz", ext_zicboz, KVM_RISCV_ISA_EXT_ZICBOZ),
+    KVM_EXT_CFG("ziccrse", ext_ziccrse, KVM_RISCV_ISA_EXT_ZICCRSE),
     KVM_EXT_CFG("zicntr", ext_zicntr, KVM_RISCV_ISA_EXT_ZICNTR),
     KVM_EXT_CFG("zicond", ext_zicond, KVM_RISCV_ISA_EXT_ZICOND),
     KVM_EXT_CFG("zicsr", ext_zicsr, KVM_RISCV_ISA_EXT_ZICSR),
@@ -283,6 +284,7 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] = {
     KVM_EXT_CFG("zihpm", ext_zihpm, KVM_RISCV_ISA_EXT_ZIHPM),
     KVM_EXT_CFG("zimop", ext_zimop, KVM_RISCV_ISA_EXT_ZIMOP),
     KVM_EXT_CFG("zcmop", ext_zcmop, KVM_RISCV_ISA_EXT_ZCMOP),
+    KVM_EXT_CFG("zabha", ext_zabha, KVM_RISCV_ISA_EXT_ZABHA),
     KVM_EXT_CFG("zacas", ext_zacas, KVM_RISCV_ISA_EXT_ZACAS),
     KVM_EXT_CFG("zawrs", ext_zawrs, KVM_RISCV_ISA_EXT_ZAWRS),
     KVM_EXT_CFG("zfa", ext_zfa, KVM_RISCV_ISA_EXT_ZFA),
@@ -325,6 +327,7 @@ static KVMCPUConfig kvm_multi_ext_cfgs[] = {
     KVM_EXT_CFG("svinval", ext_svinval, KVM_RISCV_ISA_EXT_SVINVAL),
     KVM_EXT_CFG("svnapot", ext_svnapot, KVM_RISCV_ISA_EXT_SVNAPOT),
     KVM_EXT_CFG("svpbmt", ext_svpbmt, KVM_RISCV_ISA_EXT_SVPBMT),
+    KVM_EXT_CFG("svvptc", ext_svvptc, KVM_RISCV_ISA_EXT_SVVPTC),
 };
 
 static void *kvmconfig_get_cfg_addr(RISCVCPU *cpu, KVMCPUConfig *kvmcfg)
-- 
2.48.1



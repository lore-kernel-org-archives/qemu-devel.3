Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE401CD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQir-0005ux-5W; Tue, 16 Jun 2026 06:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQip-0005uT-Tl
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:08:43 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQio-0003ia-CC
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:08:43 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-c85b2139015so1408959a12.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604521; x=1782209321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mBrN/o82KX/qPCIojmby70acTiwbieQ12mji/59OGMU=;
 b=B44lAT5sqbhTEtDIJ3dbK1VoKcVBZnCnS7W8EY0VhtYpihWn/tpysvIWn0F9SVb/aw
 XqWkzZZzYrKEZigUE4nwCLj2QmmVRhe/RHZsFH1Pd6gNSNevg/T8W8VeqIsI2TYWgTYT
 +5/NnE3vyXadIXOW3AT+6zjpvXRixivlbhqqrPV9yKwMrDdjjsVVlIFZR2ahkn/rRqLS
 oe3PotLcNWPaS1b/8wGraAuwWP+3aX5fVjSfkYIrk9BapdnIOIjHnWUavFEgND3yjMS2
 w5jMmpcYSZPViB4kjImGGu96CDppR5yoLdDFIXf37hj98iNX7j/m1Y+sNZJnNIrBbuGq
 IPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604521; x=1782209321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mBrN/o82KX/qPCIojmby70acTiwbieQ12mji/59OGMU=;
 b=YaT2D5ITrG4+x1EXqY7TbWIE6jmlw2fMdXlLMk1733og+xGuJJShGfGwW3u+HWYhUQ
 UKh9jJizaBkxCJtJqJe8fSz5Kxw/hUOy7jyRrCNOadBe6V8Cxsz7WsK9L4Xiygik8qpy
 k9Pa4mCT4j75edNm5RRKLg59wM7MPyD2yHfBm5rhsrIKw/6pDvJE2fp1fAMI1GrdOJCP
 ibI0RtKoarajIRmSuQjbTdZ5rxb/UVkjxC3/dMzP/c3Nv5DsXRbwsTiR9ttgL1lLScAm
 NcbO76kQCpxJ6nX+Zwoj3CYrpXrBcfeLPYsURVfw7kFlzGduI+8I5moST9H3Xhs8xMhR
 LREg==
X-Gm-Message-State: AOJu0YwgOmKq28wtcImvNqrtVNF/dIbw0WO1HG/uw0s+cKT77pLSzamC
 LUOSJ6qxHZbgEmlGTUHiupsLy60z2H2IchVrTDBydD4uS8GfVYCmVDs0eYcpyAcO
X-Gm-Gg: Acq92OEDTE0ljaHeNro78CVYK3PIpAa8KAPK0oFR2aim7y53ZPOsZygNFZpOoTAzi+f
 GXHk1u+zomRW8a4+fB8CamuCUsBVpNJSpuuSEhpAiyXTkQSNqVTCTqeXyg6Uz/tlcySfm/meDQI
 Q8J1F86S5j6DhMXX2gvHkrrQxbsaq7bT2nTudRlYQJvvNKtdg0fsoqgh8mxrwnxOa+grT25YIm8
 irQvKmEwzuB9zSa+0jmp72zH5bKWNVaw18Eq1hLWpOvB0CGz9izcGmqlCibgC3wWW/EyUkKudZf
 pcTD/aZysw1eSyKlKmJEPDO0Bo+/BiC9h8l07+yI/jNAwvFR5IGI30ka31I+J6pCtV4GYapTbwT
 t7vsqFQ6MmrWF+PPyeGE5q3RxmyTRL1VPrr9RUReoRS9ZneUx9Z3h8uxDRLsDUphP3yWgzv/1TB
 9fkzS9lLaDD4yBwGXc9ss/oVBnTM7Vbxt2gIv3FQj5
X-Received: by 2002:a05:6a20:9186:b0:39b:8dcb:f36d with SMTP id
 adf61e73a8af0-3b7e49d09f6mr3387802637.35.1781604521064; 
 Tue, 16 Jun 2026 03:08:41 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:08:40 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Jim Shu <jim.shu@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 53/83] target/riscv: Add the implied rule for G extension
Date: Tue, 16 Jun 2026 20:04:56 +1000
Message-ID: <20260616100527.1939565-54-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jim Shu <jim.shu@sifive.com>

Add the missing implied rule from G to imafd_zicsr_zifencei.
We can also remove the auto-enables in riscv_cpu_validate_g() as
IMAFD, Zicsr, Zifencei extensions can be enabled by the implied rule.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260528054213.678458-2-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c         | 14 +++++++++++++-
 target/riscv/tcg/tcg-cpu.c | 21 ++++-----------------
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5a3560308f..455d5b3d48 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2095,6 +2095,18 @@ static RISCVCPUImpliedExtsRule RVV_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule RVG_IMPLIED = {
+    .is_misa = true,
+    .ext = RVG,
+    .implied_misa_exts = RVI | RVM | RVA | RVF | RVD,
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zicsr),
+        CPU_CFG_OFFSET(ext_zifencei),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 static RISCVCPUImpliedExtsRule ZCB_IMPLIED = {
     .ext = CPU_CFG_OFFSET(ext_zcb),
     .implied_multi_exts = {
@@ -2502,7 +2514,7 @@ static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED = {
 
 RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
     &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
-    &RVM_IMPLIED, &RVV_IMPLIED, NULL
+    &RVM_IMPLIED, &RVV_IMPLIED, &RVG_IMPLIED, NULL
 };
 
 RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 60afb4ccc2..942c2851e8 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -498,30 +498,17 @@ static void riscv_cpu_validate_g(RISCVCPU *cpu)
             continue;
         }
 
-        if (!cpu_misa_ext_is_user_set(bit)) {
-            riscv_cpu_write_misa_bit(cpu, bit, true);
-            continue;
-        }
-
         if (send_warn) {
             warn_report(warn_msg, riscv_get_misa_ext_name(bit));
         }
     }
 
-    if (!cpu->cfg.ext_zicsr) {
-        if (!cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zicsr))) {
-            cpu->cfg.ext_zicsr = true;
-        } else if (send_warn) {
-            warn_report(warn_msg, "zicsr");
-        }
+    if (!cpu->cfg.ext_zicsr && send_warn) {
+        warn_report(warn_msg, "zicsr");
     }
 
-    if (!cpu->cfg.ext_zifencei) {
-        if (!cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_zifencei))) {
-            cpu->cfg.ext_zifencei = true;
-        } else if (send_warn) {
-            warn_report(warn_msg, "zifencei");
-        }
+    if (!cpu->cfg.ext_zifencei && send_warn) {
+        warn_report(warn_msg, "zifencei");
     }
 }
 
-- 
2.54.0



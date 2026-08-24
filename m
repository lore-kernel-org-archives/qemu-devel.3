Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF46C5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 06:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNZv-0003Hb-V7; Mon, 24 Aug 2026 01:50:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNYa-0001PR-KD
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:49:16 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNYX-0001tO-3X
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:49:16 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2cc61541f8cso42934065ad.0
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550550; x=1788155350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+FdWVqHvbukBDTAtIE0GsAxOTICi4E0tdgbLrJwjft8=;
 b=c5DZpth1nx8wSqsw3NWaNePj9x1f7A8b62Unb3soF/K2RxNJp0jRIcEWOku574Afcz
 lb82IhEay0+/uP2Gay0L7/l8VRkVZpRxlDty9/1l/BaaDUFdFZKvdsMt/FLxNNySZOvS
 yLV6D3hbJ7/j2VpzFzNombAICu32/CeCA0qPRYl752dCRvkFpGJQ+81rrMRG+R9xIfcS
 tA+K88wI4X7m0DyhYT+PlfQJCPjSMiYAMfULZ5f8QLVnn8c3rN/EaUW192lhSSMCbTGI
 iRP54R8yDDQ6of7njOVohks1zz87laEhtwfkZAkytkSh0cl/xUxtgWToLKjHRuXl+pgr
 PuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550550; x=1788155350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+FdWVqHvbukBDTAtIE0GsAxOTICi4E0tdgbLrJwjft8=;
 b=OaIVsZgLdn/brupXIaAZDpVx2Ji8fsLRknVQcDxrG5eNdafGd9bHxMCU3ZkgEZxNRh
 7JS1eeRYWgqaKCASSpQh/B51IBrSSWyir0MWP/tEF06FDA1AGslGHSIdB03MqDbjdH19
 b2Tga2PchC2F4Xe7mdoT2ceWjAOZAv0p79Kt4bkJTlJJ3EwMKKKo6RAlJ7yM/HldIXIl
 254oDj0AD4Q5pE9+5dA0ggxrdg7NioBnqCsPSx7PynzqoRlkv6dpSqGVZhAekanNP/DT
 iEog1lXW+miwDgJtCS54PU4aoBej9pPqt54xm3Hm+ZCdzeb4jK/CtZFEJSjHA1rMReCC
 LetA==
X-Gm-Message-State: AFuF++l5BXbBp186OBm79bX1uy4+n7A+NBQAXKmptfR94Z3bHyf9Irkz
 NXd+yGyh9xO8mWLs6k5fneAKfjDCxhLIV6q6xk4/QeSYEB71yYK8wsKCR0RWpw==
X-Gm-Gg: AR+sD115UY5x+1el5ryQgNbRnGS7opcKbfMNkIbI9EuB3FkCYde5RQqtKCb//sEG9vL
 snGJoO86AiKcjtKW8F5O/pTPVKLHpFze4A5I7hHWlp1lte7P1dQ3LFs419D4r/FahN71dRFPPQz
 Epj2y4Za/KDoEfGl7btbAtKQS6PQEU8lpuszvfOxFfugc+IrCWBaExOfbE0wBEcuuB8XgZMeysl
 BhDu63FIkmgHhq9fyIZ4vEWqeCl8NE6suQQ4JFxuiIMji2wLWK1Plfxu11deOj9/lco6E6llefG
 vorGqxrvl7KTABjlwuxSrDHqcqjqbAEw4fBLChoQRlRRxMHTjhZu2DMLWuJNaLanF2vFKSjp45c
 XMDj6dvV1LV2P6JQ8MEuOdrPpO3pdHOZo8niFrJ7BHo1EqxXorEKHR2yQ+P7OSlGIqV794NJtdz
 88oT/oWzFV93pOohPXCDlAX03SkO1/XH3dQjgH8+ZkRiGrSHgDAUi9Ur7hXTxHlv8SpEjRGZOXm
 CUyCQ==
X-Received: by 2002:a17:90b:3943:b0:38f:657:6823 with SMTP id
 98e67ed59e1d1-395c50b43bamr22972613a91.8.1787550550269; 
 Sun, 23 Aug 2026 22:49:10 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:49:09 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PULL v2 16/96] target/riscv: Add Zicclsm CPU option and enable it
 for the eligible CPUs
Date: Mon, 24 Aug 2026 15:46:46 +1000
Message-ID: <20260824054806.2790041-17-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62a.google.com
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

From: Frank Chang <frank.chang@sifive.com>

Add Zicclsm CPU option and enable it for the following eligible CPUs:

- Base 32 CPU (to be backward compatible)
- Base 64 CPU (to be backward compatible)
- XuanTie (T-Head) C908
- Tenstorrent Ascalon
- Ventana Veyron V1
- XiangShan Kunminghu
- MIPS P8700 (ISA doesn't include Zicclsm, but their datasheet claims that
  it has unaligned load/store support in hardware)

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260810055618.1175500-2-frank.chang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg_fields.h.inc | 2 ++
 target/riscv/cpu.c                | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 9eb47af0a7..f8c27a574f 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -139,6 +139,8 @@ BOOL_FIELD(has_priv_1_11)
 /* Always enabled for TCG if has_priv_1_11 */
 BOOL_FIELD(ext_ziccrse)
 
+BOOL_FIELD(ext_zicclsm)
+
 /* Vendor-specific custom extensions */
 BOOL_FIELD(ext_xtheadba)
 BOOL_FIELD(ext_xtheadbb)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e73ff53159..b2693f4c20 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3347,6 +3347,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zicbom = true,
         .cfg.ext_zicbop = true,
         .cfg.ext_zicboz = true,
+        .cfg.ext_zicclsm = true,
         .cfg.ext_zicntr = true,
         .cfg.ext_zicsr = true,
         .cfg.ext_zifencei = true,
@@ -3419,6 +3420,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zicbom = true,
         .cfg.ext_zicbop = true,
         .cfg.ext_zicboz = true,
+        .cfg.ext_zicclsm = true,
         .cfg.ext_zicntr = true,
         .cfg.ext_zicsr = true,
         .cfg.ext_zifencei = true,
@@ -3505,6 +3507,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zbs = true,
         .cfg.ext_zkt = true,
         .cfg.ext_zbkc = true,
+        .cfg.ext_zicclsm = true,
         .cfg.ext_zicsr = true,
         .cfg.ext_zifencei = true,
         .cfg.ext_zihintpause = true,
@@ -3548,6 +3551,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .cfg.ext_zicbom = true,
         .cfg.ext_zicbop = true,
         .cfg.ext_zicboz = true,
+        .cfg.ext_zicclsm = true,
         .cfg.ext_zicntr = true,
         .cfg.ext_zicond = true,
         .cfg.ext_zicsr = true,
@@ -3597,6 +3601,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
 
         /* ISA extensions */
         .cfg.mmu = true,
+        .cfg.ext_zicclsm = true,
         .cfg.ext_zifencei = true,
         .cfg.ext_zicsr = true,
         .cfg.pmp = true,
@@ -3656,6 +3661,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
      * The RISC-V Instruction Set Manual: Volume I
      * Unprivileged Architecture
      */
+    .cfg.ext_zicclsm = true,
     .cfg.ext_zicntr = true,
     .cfg.ext_zihpm = true,
     .cfg.ext_zihintntl = true,
@@ -3712,6 +3718,7 @@ static const TypeInfo riscv_cpu_type_infos[] = {
         .misa_ext = RVI | RVM | RVA | RVF | RVD | RVC | RVS | RVU,
         .priv_spec = PRIV_VERSION_1_12_0,
         .cfg.max_satp_mode = VM_1_10_SV48,
+        .cfg.ext_zicclsm = true,
         .cfg.ext_zifencei = true,
         .cfg.ext_zicsr = true,
         .cfg.mmu = true,
-- 
2.54.0



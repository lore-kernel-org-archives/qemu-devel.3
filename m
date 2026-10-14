Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E113CC6B19
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:41:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGprl-0000Hi-4D; Tue, 13 Oct 2026 23:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpra-00084T-O1
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:41:10 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGprZ-0001iF-6O
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:41:10 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2e8662d5e95so3714985ad.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949268; x=1792554068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=orIH+Bb3TpS/WphK46YabXmJ/NC8X9SYQ+BdAkjWdKY=;
 b=EaHbx2e8wAkYf92l9zWvy/uWassIPzuwklQ8osgy1aIiIZ1yXV9Kh5KCXsIo1Wu+lr
 mtVqwUGki9fUdq2P0BnWHkJhEVyxThHP35VPWn5feFhOEfSs68uPxmGIjhVkNam3KDjw
 KX2+gO7n68Ht+BsJI6o8KYv3ORYpf7XpEDQYSXrKnepLdMbImmg5+gLjh/3V78XSNyVt
 4XYAFFyxhUT/HEWBrSwGALlfSUgn5PTnRFt2czhugezL02/suDknjR3niSOxwVQo1L6W
 /iu8C9b/p8tf413LQNyfRW8hvqe+m/fu+9DDBv8AOWKWt//YPav1XeBrIPa5qN2bexon
 vAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949268; x=1792554068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=orIH+Bb3TpS/WphK46YabXmJ/NC8X9SYQ+BdAkjWdKY=;
 b=Qb+x9sMEM9COWZ/nTdNJ2rwHlr/wBr1h1wE1ENhKKyyDS1ySBZXGBgBlV8IrckfNLj
 cinnXDWtCZPC4INZjUbraOWM63mUW4ZpgYN5/icniWHoNXrN10xQMTKblrQUY9rPl1i/
 GH9+Cdt/sIrJlNSk/6wsQ9gaWrOL26z46sfHEHOeQGZCFpWuXH+BSF4HWSCxquHpf6oZ
 hBU0AkvHkwF8lqYr1eRac1vxW7YqtKhZgjjH4JqwPRf8/K56l52bZYONmjqJXiPUvYSY
 Nw5pTgN0ywpL53av0oNXSrndMGJDQqxJwPdOcyJ1ccgTqWp3EAVDQsVyFwRplN4d0OAu
 xmwA==
X-Gm-Message-State: AFq9FYK3YXoEIDt+WMTeLbxy1AoMaHRXuXQElQzhOQzuxcQtjPyN5DLY
 gWzBy/0dX6dAdif2uiqFpQV1prbE3m9JTtmQV+1gwHdSafQaNlGicodTigGgRw==
X-Gm-Gg: AYBFou1B1G0D80Ck172rZc1Gahw1kVtw+WwfvooiuOHwzOWa7DdyQX0SqmU7jgUhCWc
 Mn6Hrx2ycIEZlwhrm2iCKmxE2nVvu1tm5Za+OAq8JssBlDKxk0tK9HvkNZsCpTQBY/J95t3s9hq
 P5Tp6KGX2mmhZ/uZUsSFdqYpFx8x2BB5Y3Ft5DV4PB1MwN+EAxU40ZeJ+r7PFfcU5hPps9HE1g8
 ZLhHALJYB42LOp9XdyLQp+R+XhqrWp0XcQCX5wxWlIDGHiAy2ZmZGxRamx4dRCPZ6OruyA3gnps
 bhqjCQH/UTtIwxMutxSavvajOLMEbGIiznNsj3mroR9GnjYGsSAEj1T8O0B1OcUJUHheghmUOiO
 6Ta7JxL3rzlcP6A0BM6hTrTFM9uQLvVL211f0DkuBjmJZf9pFzFfpwzpnYAI3ukaX9U1VYKfwUm
 pXpVptDT+JeJhv8B8WIi24rnxZ6Hp2bgKoo+wyVeLm5QAdkbhlKKj2/b/1iu8EtEdW5Pd3bDLZ7
 NxjAzO/aV0m0QGxWzI+I+BXBlY=
X-Received: by 2002:a17:90b:2681:b0:3aa:ff61:9504 with SMTP id
 98e67ed59e1d1-3ab3a9127f1mr11306871a91.20.1791949267758; 
 Tue, 13 Oct 2026 20:41:07 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.41.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:41:07 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: [PULL 34/52] target/riscv: Add cfg property for SiFive int8 matmul
 extensions
Date: Wed, 14 Oct 2026 13:38:49 +1000
Message-ID: <20261014033907.3332383-35-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
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

From: Max Chou <max.chou@sifive.com>

Add the CPU config properties for SiFive's custom int8 matrix
multiply vector extensions:

- Xsfvqmaccdod: 2x8x2 int8 matrix-multiply-accumulate operations
- Xsfvqmaccqoq: 4x8x4 int8 matrix-multiply-accumulate operations

All instructions of these extensions require the Zve32x extension
to be present whenever either extension is enabled. Validate this
in riscv_cpu_validate_vendor_ext() alongside the existing vector
extension validation in riscv_cpu_validate_set_extensions().

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Message-ID: <20260927082534.3228237-2-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu_cfg_fields.h.inc |  2 ++
 target/riscv/cpu.c                |  2 ++
 target/riscv/tcg/tcg-cpu.c        | 16 ++++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 55a79da194..85fc3ad8bb 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -161,6 +161,8 @@ BOOL_FIELD(ext_xmipscbop)
 BOOL_FIELD(ext_xmipscmov)
 BOOL_FIELD(ext_xmipslsp)
 BOOL_FIELD(ext_xlrbr)
+BOOL_FIELD(ext_xsfvqmaccdod)
+BOOL_FIELD(ext_xsfvqmaccqoq)
 
 BOOL_FIELD(big_endian)
 BOOL_FIELD(mmu)
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d0ee2433fd..b8cedbf7e9 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -302,6 +302,8 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
     ISA_EXT_DATA_ENTRY(xmipscmov, PRIV_VERSION_1_12_0, ext_xmipscmov),
     ISA_EXT_DATA_ENTRY(xmipslsp, PRIV_VERSION_1_12_0, ext_xmipslsp),
+    ISA_EXT_DATA_ENTRY(xsfvqmaccdod, PRIV_VERSION_1_13_0, ext_xsfvqmaccdod),
+    ISA_EXT_DATA_ENTRY(xsfvqmaccqoq, PRIV_VERSION_1_13_0, ext_xsfvqmaccqoq),
     ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
     ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
     ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index ae5166b13a..2ab0efa3a2 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -436,6 +436,16 @@ static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
     }
 }
 
+static void riscv_cpu_validate_vendor_ext(RISCVCPU *cpu, Error **errp)
+{
+    if ((cpu->cfg.ext_xsfvqmaccdod || cpu->cfg.ext_xsfvqmaccqoq) &&
+        !cpu->cfg.ext_zve32x) {
+        error_setg(errp, "Xsfvqmaccdod/Xsfvqmaccqoq extensions require "
+                         "Zve32x extension");
+        return;
+    }
+}
+
 static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
 {
     CPURISCVState *env = &cpu->env;
@@ -819,6 +829,12 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    riscv_cpu_validate_vendor_ext(cpu, &local_err);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     if (mcc->def->misa_mxl_max == MXL_RV32 && cpu->cfg.ext_svukte) {
         error_setg(errp, "svukte is not supported for RV32");
         return;
-- 
2.55.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84DDDFF8850
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 06:10:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHFAI-0005NY-Ln; Mon, 27 Apr 2026 02:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wHFAB-0005L9-F3
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 02:09:47 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wHFA9-0000p6-41
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 02:09:46 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-35fc0d7c310so6304180a91.1
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 23:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1777270184; x=1777874984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=up4bWLNmkEPnVy8RL9+169lx2FD5CzITGBtONeIsssc=;
 b=eZHfyCnrxHIyEyWTO9eR2UPWV3wlUYkH6asfhleRNkifziUXOrQUdi0rdbX7+xKLw2
 LsZYOEIwkYxdd0zTT/swcROd5FtFJ1QCLgh1AZvgZ0/fEtdOgrg5wrQY4ym29NBpcJF/
 7BtL0mfGKrav5wbE8CwUizMMuurYlVFHpFDwv+VG6Wowk/a+XUcxsyRSqnYmIfmfovQj
 0VaW1HOm5hIDZH83aAvGXNtW/2llF14sbke3q74Qjrzjb+jo6I66hKfaVTdqGGaeqIQQ
 fJ8cK7ISW4d9qL9swIehYipYCeG0kyGpwzaoAwYG3g/HDBGkuGQ3LR2zE83wCfeYuCQp
 lToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777270184; x=1777874984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=up4bWLNmkEPnVy8RL9+169lx2FD5CzITGBtONeIsssc=;
 b=WRyeabVMWmLNaajWx8jA5qovPa4Tzvb5vIFYQEPai/kojF5r420672+v5wZSuAdJOX
 gAIZTv3iDumPAMKd1sGRTaIYd95drt8oLSBkd48tRYAe4CJTSJnt9zwSrUQg/PpP/Vfi
 r+e1e3ZrE3NwSWGEEO5xZiJ1aiq94fuFmco+L59euFffoDO1hFqeivi+/xJF6T2UHiBc
 KhU5nrv+q0Qgff0ssozMxDj4CkKeKVSjE1InTnBn31aoiD/jhQdGZi+1MBpGA1cYK9Ih
 dTCIzi25+KLh7dW4va6G8khngZLwhb4tyXQSfLPYeT/OS2wq1EEl67SWUDChZsEjTvi5
 f+/g==
X-Gm-Message-State: AOJu0YwY1vbT719j8Hcl+iF0O/K6NZtQ4nWeB33g3Hy30nxAtkSe0koh
 n1qiWm8WVqH7L/F15UuAM67ipifx5ZiVjesFbEXKm49vlkr52GqKMducvPsd9m4A4AmuinzjIUZ
 txfLk7ZfLo/m3NNZ/p2mP6FFECFuxoxxjFJv64GwUP7kvGirnLeVEDJABE3Ciit+wI8XaqQRaly
 VXSQQTYos/5rkZicId78JWmMEqRFziwu22qNLX8vU=
X-Gm-Gg: AeBDietLAPWxBNwjGaEH6vXeeaP2eVf6AJVigIAGbgaNrbF7Wd3ehXl8MbycYkCxKPL
 +F0LgDeicHmhr+xFkpMHPsyPRqnbcbZxEvZayxT/29MKqrqn7y/4ZKx75P494LskwPoi7xwbd7l
 TD6wxMGEceCexIuF9iUqbz0wCYqeIMI3OQgJyEKdK9Wbs2ts8pLe50HL0ftKsbHLXSWN9rjGG2Y
 1Pp1VAodBqlJ+fR5dva2sZhtyfIVCdX0HgAP6Jv4W4qoNRke/+JxuhZdlKoFSLj5QaSp1MF3AYG
 W1qozU5ucD5anFz8Cjk6QcjuGBXLoFt74BQ8mk5x/bfq5RZJoLtUpPIKV7aYGGH3AprWeOCaLWA
 AGIrImYaFfZsp09DYJsGQEtjkhCp13+A6/ONw7M32kabDIg1vhfWyOqEjqWaVPo3szTlYjm+nvt
 OhqqHVAKqKybUSb4RbCMCNSXQsq6GFS7s5mDle+nH/ZXuuvFqQXRKYSchz3MsGPAUZQA6zEA0O7
 pmyMTUAYHyHF3M5KG0750nC+laNQRpSDQuKsQ==
X-Received: by 2002:a17:90b:380c:b0:35f:b5df:448 with SMTP id
 98e67ed59e1d1-3614049ed12mr43312761a91.24.1777270183650; 
 Sun, 26 Apr 2026 23:09:43 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-361410bac6dsm30290710a91.14.2026.04.26.23.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 23:09:43 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 2/9] target/riscv: Add cfg property for Zvfofp8min extension
Date: Mon, 27 Apr 2026 14:09:21 +0800
Message-ID: <20260427060928.2322570-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427060928.2322570-1-max.chou@sifive.com>
References: <20260427060928.2322570-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

According to the ISA spec of Zvfofp8min extension,

"The Zvfofp8min extension requires on the Zve32f extension."

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c                | 1 +
 target/riscv/cpu_cfg_fields.h.inc | 1 +
 target/riscv/tcg/tcg-cpu.c        | 5 +++++
 target/riscv/vector_helper.c      | 3 ++-
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index ce15a17c37..855c6bd4a9 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -194,6 +194,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
     ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
     ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
+    ISA_EXT_DATA_ENTRY(zvfofp8min, PRIV_VERSION_1_12_0, ext_zvfofp8min),
     ISA_EXT_DATA_ENTRY(zvkb, PRIV_VERSION_1_12_0, ext_zvkb),
     ISA_EXT_DATA_ENTRY(zvkg, PRIV_VERSION_1_12_0, ext_zvkg),
     ISA_EXT_DATA_ENTRY(zvkn, PRIV_VERSION_1_12_0, ext_zvkn),
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 734fa079f2..f9cd79bae0 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -105,6 +105,7 @@ BOOL_FIELD(ext_zvfbfmin)
 BOOL_FIELD(ext_zvfbfwma)
 BOOL_FIELD(ext_zvfh)
 BOOL_FIELD(ext_zvfhmin)
+BOOL_FIELD(ext_zvfofp8min)
 BOOL_FIELD(ext_smaia)
 BOOL_FIELD(ext_ssaia)
 BOOL_FIELD(ext_smctr)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index f3f7808895..40e7c72976 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -710,6 +710,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if (cpu->cfg.ext_zvfofp8min && !cpu->cfg.ext_zve32f) {
+        error_setg(errp, "Zvfofp8min extension depends on Zve32f extension");
+        return;
+    }
+
     if (cpu->cfg.ext_zvfh && !cpu->cfg.ext_zfhmin) {
         error_setg(errp, "Zvfh extensions requires Zfhmin extension");
         return;
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 60e2d42301..73437c1d20 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -38,7 +38,8 @@ static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
     int xlen = riscv_cpu_xlen(env);
     target_ulong reserved = 0;
 
-    if (riscv_cpu_cfg(env)->ext_zvfbfa) {
+    if (riscv_cpu_cfg(env)->ext_zvfbfa ||
+        riscv_cpu_cfg(env)->ext_zvfofp8min) {
         reserved = vtype & MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
                                            xlen - 1 - R_VTYPE_RESERVED_SHIFT);
     } else {
-- 
2.52.0



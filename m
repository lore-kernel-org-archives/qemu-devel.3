Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039F9CCA470
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 03:35:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4WTk-0007RW-I7; Thu, 02 Oct 2025 23:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WTg-0007Md-6O
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:29:04 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v4WTX-0001KA-7O
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 23:29:03 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-78af743c232so1557070b3a.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 20:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759462129; x=1760066929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vlpWwSZsU0Dbu3VqGUqbPCpGrK5tg56q0sJG8Lc+Efw=;
 b=YixLE2rz2DLGYt5Q3aj8NwgkGkEcKcTrBuZSF/XHG5w6ClD51i/68CurI3GC/DItRO
 wgs1Aw0/wbYEI6lyKskWSkpgJUKLhAkavoiVyCi2u8ATb7XhIkdop/IyERHF95yyIS5t
 qZxE3zHakKMx27BxTpRfMrOaBbzaLFxF18Qf1kMBAWfufGjzopuV5WCWWVMWcjr+fRrH
 EX84iUiLm7PCcr2uLgx/Zf96u/ZUMOltIU4b86bPXj8ZnOGqtIALL8d3OSxptmlBFQr5
 dqZvXW/9ivv52TKHMTP1fMl+d4kSa9KvS+cQqlThdslM8BbmuIo8QGczOsGthrF+s7yC
 iYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759462129; x=1760066929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vlpWwSZsU0Dbu3VqGUqbPCpGrK5tg56q0sJG8Lc+Efw=;
 b=aCZqTowLxNGdeMYQ5ggeiOaFfsc0w9ELmgn094Fcr0ag/jN/zo+8+y46kdfq1m+NQC
 relSbILdf8jqqLu1YwvDYSa3aKcOnrlmlvr5l9VQlyVGHVs1jK2yaBYW6UYZwiqJtalv
 NUOJR0A1vFWP8pkh6hUdxc6ZyAt0OQpmnwlh3GsyOd0w7oBunso3Ed/Mx1CT14FzvKam
 GeZV8BlhGTePgY+CgzMClsfZE35XFa+SMzjilUp3Yncx5IhT++kBVy0LFaS2jyk5Q4Cd
 frdcoWAsU04yhlAYSs2yScPQcU+/0kGYUpQdo37B3cvBLyhvzOs1DLTSwdMTW+i9e1ua
 QHvA==
X-Gm-Message-State: AOJu0YzkbX4t80ozKjVoYy4dZo4C5EZIx3RkYWX20itWWVJPew3j/IvR
 eES04oJphbzjw0DI2e4ovloeEnay4lNLTYxWTUcIvcrzx9XrfynRYls5zQq+0A==
X-Gm-Gg: ASbGncsJi9aBXLIyK8O/5vD2U4Y3zNTYwhb8bSRWCxhIT9/oLUN9278VEui2LADxHIQ
 N5QY3bSoB8CpUq5RZk/1Zfed8bIN8V5PIUEtGqoYkYUN4zFVmWF/al2O+z1Cd6IU6tU9xjcz+ia
 JOzd/7pcuDXBiYRyCNB5w2Qr/6HGKR66IEMMOY4tVa5hj35TGa8WmZL4M1CpTfqSoQt4N5WJH+0
 aLuaY+7ppGeXT0L7+iSREkG6Uk+fM7Y/NepPfX5cxZQSEGucfEhdE3B5Xxdw7nM8IIv+LT9P4Nb
 7O/wkJ1YG4N3f+X5PcMrRHIEkO+Ms1fOXDMdb7FM+Ija9k03ignI94mUc8OmmGgvPeo5dOuMgjn
 R/R9UCFFnWVDab1unhgt35IQ3bpBHdhrcojGSmJC/dVWOUuF431liR+FzHwkJQ/gQ3+b8o78Y9/
 pj7QdLt66Y+aGFjDnfsoewNSMtutkTmv/JDM8jK0exvccPfSiz/7ba
X-Google-Smtp-Source: AGHT+IH5w1HcIStEoYDOycQTVaNElNdhaDfB85qmi/RsR3lm+2GZzFJhWxqx5AVlzJ/pS31ODQVYbw==
X-Received: by 2002:a05:6a20:3b04:b0:32b:6e34:fce0 with SMTP id
 adf61e73a8af0-32b6e351abdmr623975637.19.1759462129589; 
 Thu, 02 Oct 2025 20:28:49 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b62ce55205csm844202a12.18.2025.10.02.20.28.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 20:28:48 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 22/26] target/riscv: rvv: Modify minimum VLEN according to
 enabled vector extensions
Date: Fri,  3 Oct 2025 13:27:14 +1000
Message-ID: <20251003032718.1324734-23-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003032718.1324734-1-alistair.francis@wdc.com>
References: <20251003032718.1324734-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42b.google.com
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

From: Max Chou <max.chou@sifive.com>

According to the RISC-V unprivileged specification, the VLEN should be greater
or equal to the ELEN. This commit modifies the minimum VLEN based on the vector
extensions and introduces a check rule for VLEN and ELEN.

  Extension     Minimum VLEN
* V                      128
* Zve64[d|f|x]            64
* Zve32[f|x]              32

Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250923090729.1887406-3-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index b3b7f14503..1150bd1469 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -417,12 +417,21 @@ static void riscv_cpu_validate_misa_priv(CPURISCVState *env, Error **errp)
 static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
                                  Error **errp)
 {
+    uint32_t min_vlen;
     uint32_t vlen = cfg->vlenb << 3;
 
-    if (vlen > RV_VLEN_MAX || vlen < 128) {
+    if (riscv_has_ext(env, RVV)) {
+        min_vlen = 128;
+    } else if (cfg->ext_zve64x) {
+        min_vlen = 64;
+    } else if (cfg->ext_zve32x) {
+        min_vlen = 32;
+    }
+
+    if (vlen > RV_VLEN_MAX || vlen < min_vlen) {
         error_setg(errp,
                    "Vector extension implementation only supports VLEN "
-                   "in the range [128, %d]", RV_VLEN_MAX);
+                   "in the range [%d, %d]", min_vlen, RV_VLEN_MAX);
         return;
     }
 
@@ -432,6 +441,12 @@ static void riscv_cpu_validate_v(CPURISCVState *env, RISCVCPUConfig *cfg,
                    "in the range [8, 64]");
         return;
     }
+
+    if (vlen < cfg->elen) {
+        error_setg(errp, "Vector extension implementation requires VLEN "
+                         "to be greater than or equal to ELEN");
+        return;
+    }
 }
 
 static void riscv_cpu_disable_priv_spec_isa_exts(RISCVCPU *cpu)
-- 
2.51.0



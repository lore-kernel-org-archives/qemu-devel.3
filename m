Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C07D5F5140F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 07:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyPLN-0003Cl-1f; Fri, 06 Mar 2026 02:11:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vyPLL-0003CK-T1
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:11:27 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vyPLK-0007kU-Dg
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:11:27 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-824af5e5c81so8839379b3a.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 23:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772781085; x=1773385885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7M4+raLDnlsy7KZxdfXOt2SaMfVSiy+jv/eZ9IfwtZI=;
 b=WvyPgzqd5s8HMzale2YE8Kit7NbTygCAWf40qdzE224Bfpp2qfBy/QvRV5N+KIgaXV
 C4WtPY9kDBFMjA7jV7yI5BRakTXw++tJRt0+2ojhvB0c+U1f6q3hPBnf6JFdSMDN9YbQ
 q3tCR2Yb7AO9CpPjUJXPo+8T2OeoNroyo0DF24qFp/fNOzhNt+fMxuAu10f1TKkudeUM
 aQ91ecyVzmGXIo0sr/RPRQFkVWFluxXPDBc4LOSD06O6svVvOGcYR8YyYJXVYut/PjDM
 AVSyDEhAWkgJ7Sg5WppWG+HSR51b+LPDmbzgfZecF9tY5FxH8Hp47rGGfEqmJcOoR84V
 DJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772781085; x=1773385885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7M4+raLDnlsy7KZxdfXOt2SaMfVSiy+jv/eZ9IfwtZI=;
 b=XfzBpbIEtOMjuGqMLeAkxvzcEcAT51nwfGfm4ekPjsZCe4ZH/bX8XsoJh+3wdXRu4P
 PWn3Ndl14sixUA6asSb5RHwC7lYhNXsJkgMsUwGixS3rQmOCm6KjiJ8sFwqH+rlUMwSZ
 IRKYlGClqFwfnEYYMqQP5sJ4yCJuEfAmk//DOXlCeZCBUHpyrmDYmUDGuCduQ1/gVkrf
 nJ8gUytFIUR8ImmeDXlmZYu6/h+RfWOpNFBx7ur1Z3wfNBIQEQABml8vLN7ks5luGBjB
 VCI7ZZzW9Nwv0PshB3W5YMvQJUbHm8DzDNpiS2DuHb024hVeQCqitxW0SoakRcS0lokn
 nS1g==
X-Gm-Message-State: AOJu0Yy3KVa1QE8M92ka1lSiciFdmsSYwnMa8pPJ0zHsFd3hNT9/LUSS
 O7Y+x4ycGvcD36WNAMLVGJKvbN3AcXaRRiBjkV4uL3aruYqxUa78Yp3G2lT+xYHnvP27bLNMZIw
 WNWvVlUx+kMY8epNkvuUN4OKmDfYxdd58RzDo+/Qn1XPM47f9YztZgxre8fIAP1Ga+74C4bQxZe
 kM/tmS2d1CJ5CfKQE+/+5uU17l/aZXMKtr7CQbngYCgjhc
X-Gm-Gg: ATEYQzyMRmbwHKQEW3qH0J1ZA3msQnD9YGW3d2r8JOIBeVQhpSY2cbJ31txYfJPpcPA
 Wb7DG1R8fJzkZajGrgGx8PEefaydKSBNXMMMcJGzKuv1BZmlE3Aqgj7JrN/CMUYr642RJ75gukJ
 xW1rESXNOUnt4wy8gnIClW1BInYrMsryP8pO4y/wP5oYjZbqJHTmaFCezGBkGUL+rIY/fkJxdJV
 zcunaASwjoAnhG6SFyZTZY+RMciK7J4XSBYjEba0KTyjsSedFhOHliJHoLuai9X2u/vdmAaQGzF
 mueqendM6/zEakJPOoRYrwOC72l3DvMa1PzyrqwZicjPr5/aO6U81ZlrtK3F4CMm2QJRBlbez16
 KKFGWDxZ0Vw5XBpRWmypmx/9tgFXtJj5gPPh/6A3aDbIPJMQMt9WjFMcRIR4d72+46GXsxxdbW4
 IoJA/r9kbOFMlNkmVH5c25fP8Y8ScmC8EGPzmJcnRO9DHKgSxKg5XaAhPlaElexjV4pDyCDMphH
 eUe/R2QRbeHdsUJYMAuI7A5/xo=
X-Received: by 2002:a05:6a00:1408:b0:824:93e4:2de1 with SMTP id
 d2e1a72fcca58-829a2eaed31mr1140486b3a.30.1772781084799; 
 Thu, 05 Mar 2026 23:11:24 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-829a4636c74sm956093b3a.12.2026.03.05.23.11.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 23:11:24 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v5 6/9] target/riscv: Introduce altfmt into DisasContext
Date: Fri,  6 Mar 2026 15:11:01 +0800
Message-ID: <20260306071105.3328365-7-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306071105.3328365-1-max.chou@sifive.com>
References: <20260306071105.3328365-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x433.google.com
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

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/translate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index cb4f443601..89d4f6fe67 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -101,6 +101,7 @@ typedef struct DisasContext {
     bool cfg_vta_all_1s;
     bool vstart_eq_zero;
     bool vl_eq_vlmax;
+    bool altfmt;
     CPUState *cs;
     TCGv zero;
     /* actual address width */
@@ -1307,6 +1308,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
     RISCVCPU *cpu = RISCV_CPU(cs);
     uint32_t tb_flags = ctx->base.tb->flags;
+    uint64_t ext_tb_flags = ctx->base.tb->cs_base;
 
     ctx->pc_save = ctx->base.pc_first;
     ctx->priv = FIELD_EX32(tb_flags, TB_FLAGS, PRIV);
@@ -1326,6 +1328,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->cfg_vta_all_1s = cpu->cfg.rvv_ta_all_1s;
     ctx->vstart_eq_zero = FIELD_EX32(tb_flags, TB_FLAGS, VSTART_EQ_ZERO);
     ctx->vl_eq_vlmax = FIELD_EX32(tb_flags, TB_FLAGS, VL_EQ_VLMAX);
+    ctx->altfmt = FIELD_EX64(ext_tb_flags, EXT_TB_FLAGS, ALTFMT);
     ctx->misa_mxl_max = mcc->def->misa_mxl_max;
     ctx->xl = FIELD_EX32(tb_flags, TB_FLAGS, XL);
     ctx->address_xl = FIELD_EX32(tb_flags, TB_FLAGS, AXL);
-- 
2.52.0



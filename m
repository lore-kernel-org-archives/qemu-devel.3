Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C459FF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 04:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHwtC-0007Qw-Fs; Wed, 29 Apr 2026 00:51:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwsx-0007B9-Ab
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:50:59 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHwsv-0000p9-8a
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 00:50:55 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2b299b3c739so56410755ad.3
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 21:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777438252; x=1778043052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=plC3YfL5KUVaXD9kpuwyDCHEonQqOYGFLhOa8lMByQc=;
 b=qvC4TyuUHMXYGFDtiqY6tCFb3ikcQhXKhXpLMoBZOl/+lOguy+6lvO1iqm/UsBlJtD
 OaVD5s5XSoGxCPxKjoWSlitodwfnkbGl2ffMeIvoHCtgUwBrHUYTUkkyFiCF2Zoga5/8
 dMKZi48LoMICc/EHN6/5C/tFnXUrHGh+ExiCAKq7SA/OoaU+H9aUaLudkBY2k7sQWEnu
 mBNbKPJz4p5Mao6LXK2LDxJhcfOV1cZtVSigsLwaPZ2g4jI1YR0ILdwl7ir1TBhNgbhZ
 M4ZV67mLw4u6lGtSclDPNiY9mii/M7/C6qMl+5xvWyAeXQsXumhNODTJdfYh2y9p8Obb
 UZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777438252; x=1778043052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=plC3YfL5KUVaXD9kpuwyDCHEonQqOYGFLhOa8lMByQc=;
 b=gh62Y5yDN4r1kfzJ06jJfgdPlRWp2ZvI53+MCl1ECl2meY5IaYYdk3XV0WxzIBVrce
 4eE1hiKGLf5WG/YQyxD+0gNKq8q6tPwz1yEsvJiQr0VCWZAWBqiDO2H/0Vah22jg4fCA
 tRh7ON44IG0y1/HTGPHOCvNCFy1PJcuoRA2ROv4dSNELTCGQLGjVW59LCYAtsETO1Nts
 4Oe7QBgIDt9/YzRgD+CxFhO1yFqYByGpmxPyE1fH/TZ+lxvqo01vG2UwS90zraV2h94i
 uX5F8iGApGtWU5qhxsuz6hwc2u2qPmkgs6Gt2swirWmKexxKdwZQKgmeZ1fflNp7g4Mh
 ysEQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ92KpNMnllhT1OTlY3Exx02S5X+3OrcVueZfyZt4KMn8CdMDqxJMdQ0BNjlgZ81kGEla6YNEGbDDfAh@nongnu.org
X-Gm-Message-State: AOJu0YwnnuYZSG9AxZTUCdN3Oy2IizHdF0IV1OOeXD5mGD69eu+TUYRx
 CpPa4M33Jcgz29y+UCsV2VHzdPZ42DqZbX908zOWBWrzdR7JVS3GWJXfR6oZwQ==
X-Gm-Gg: AeBDieuWxNLX0Ya1ruD5U94n8nPPtF6N23kJpYi85q7ZnHk3n/YCxgYdC4aMXLSTQ4n
 lZgYCjXoKVU9cUi3iDiGhidkihKCXAhU5G/j0kv9DpMBjZQRcPLKQ1L8WClsgf8tT3jvjZyD740
 NvqCJ0OLfz9bxykGTsdM3Uxjx6VIHW7ZgyDU/rQ8h8Ta4RmiVd6zTnKByGIvfzqDJAj7gEMSciS
 Ksyxbph5GWHy8m56bEFvtkSwTPoQOAHcMyosah+vVocNfHIxbjC1MdBEDfzLjXBXrF1T00B1lh6
 BLrQq5SqVB9TOO+qghwiV0N/xsJN34wkHdoBl7M9r3jCF5sC9RfjACiQCMSd0Z645euBXH3Szpp
 QK5P/0jEAgWbxkNGotabeznN25EqXyxx5lqzd9MGHSj4FtzQ5j9/xR8KEZCcj1RU/3fEJUBCCQt
 0gZW4nceC6maW/EPCTnfixST1Vpfm1/VpZhbCaHnC8s+kDS7CHRkrQ
X-Received: by 2002:a17:903:2c8:b0:2b4:5b82:a8e3 with SMTP id
 d9443c01a7336-2b97c460ff4mr55162315ad.24.1777438251775; 
 Tue, 28 Apr 2026 21:50:51 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772ae8sm7756145ad.7.2026.04.28.21.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 21:50:51 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 32/51] target/riscv: Introduce altfmt into DisasContext
Date: Wed, 29 Apr 2026 14:47:33 +1000
Message-ID: <20260429044752.4176397-33-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260429044752.4176397-1-alistair.francis@wdc.com>
References: <20260429044752.4176397-1-alistair.francis@wdc.com>
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

From: Max Chou <max.chou@sifive.com>

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
Message-ID: <20260402125234.1371897-7-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/translate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index f6b915a7fb..f8ccf34438 100644
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
@@ -1310,6 +1311,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(cs);
     RISCVCPU *cpu = RISCV_CPU(cs);
     uint32_t tb_flags = ctx->base.tb->flags;
+    uint64_t ext_tb_flags = ctx->base.tb->cs_base;
 
     ctx->pc_save = ctx->base.pc_first;
     ctx->priv = FIELD_EX32(tb_flags, TB_FLAGS, PRIV);
@@ -1329,6 +1331,7 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->cfg_vta_all_1s = cpu->cfg.rvv_ta_all_1s;
     ctx->vstart_eq_zero = FIELD_EX32(tb_flags, TB_FLAGS, VSTART_EQ_ZERO);
     ctx->vl_eq_vlmax = FIELD_EX32(tb_flags, TB_FLAGS, VL_EQ_VLMAX);
+    ctx->altfmt = FIELD_EX64(ext_tb_flags, EXT_TB_FLAGS, ALTFMT);
     ctx->misa_mxl_max = mcc->def->misa_mxl_max;
     ctx->xl = FIELD_EX32(tb_flags, TB_FLAGS, XL);
     ctx->address_xl = FIELD_EX32(tb_flags, TB_FLAGS, AXL);
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BCFEF8FE1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmEh-00071N-B2; Wed, 04 Mar 2026 08:26:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmEV-0006mv-86
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:25:49 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vxmEN-00024O-Vi
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:25:42 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-82746ed8cb1so3779200b3a.3
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1772630734; x=1773235534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6TwcDHDQ1v/MuxhHA8/kulerJOazubocvesCRSSTWs0=;
 b=ncyRCwMfqXEoTtgh2OWy9vCeU9Ei0KSH33/xzSxUO2Lhe13SayEBjVoZCQCGiffdyT
 aFkw0BNolQ7HatmIG5WgVAExQCV86wmmEwDRlS8gLaPNVeut1ZMZIP8t5sqA5zCfTLz0
 //+2+dNbuPtEgMkt49HINfPN9d+c6dlBWCvq6dq5oPnOg7q9RPyegBgzWrlR9/rsjH2y
 E/DQZe2CFJNjJXuKnG4jIkmLNbevEnwsAVmbU1ocg2GHv5kWs0Lw5B22zQWf6fjaxyFT
 l5umDWj9DfBYdQEe/Qb7UVB4Vos15sCo3BBJkt1TFNVJq15LH59YQRpyOjls+jGbN5je
 R1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772630734; x=1773235534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6TwcDHDQ1v/MuxhHA8/kulerJOazubocvesCRSSTWs0=;
 b=AWPYPMF4IUx/kQsvU0tX+1TxiIrr/CcK2L50FOKcyKKmb4voxAethVoa4s2VoOChwW
 NRnifw73Ss7Izphc38j1RlCuY6+VLrAZV4RigX63r6AzDqCc1/xkMTyEYE4juo7TzXFV
 GmPHPgS/Vufr/F6Wvex+IkHlI1qN3pv9n8uqRPpqAtaxRHINP87n7TAuOq4rD60XCQGk
 6OZv9M/8BIhuYzJs0iurx6ULKbP+RiD6a5/v24LQgq7qoL0AxwBB6HC1Wh17Ju2Lc9ad
 BukQupINk6PjBCJeIcpgxx26ZqPmmSyDT14x/O84/dobpc8Nr953kGRIEaS+WBuVuTYO
 RG1A==
X-Gm-Message-State: AOJu0YzN7XnRIyV5cOxb3IMWNujjMFWedsVBn1pNmMVpneqYddNAAj4P
 bgAw7wF24OnWs23VvDDJuu9RlCkNNJXtoEE97oY5wQfxZxWPP0AUA0T//Sb3QhhzDyM+kc+l+TO
 oBXxKkym2+UO5F14LduaWqerd2HBmHPFe/BdxeduPGQrwyq9lnhRIa3Xgw0s7OMJIbdGkz8ABFs
 EIXpNM+l+rHMd8Y3hw8j5FhjJfowATKYJz7W6R8cTJRw==
X-Gm-Gg: ATEYQzxmKyHZg+6eXNczllvqaV365TQB1MTfNUku0ODKkbvNtJ534fRipGMtLVYbaRz
 t7HV8qhLUnvyxz8Amk082dJeZ9NtVU41hFNZc/7FbbDuWCO44XQA+3LxxvuqPeAI20NL6CG5yQc
 nwIztwHqXDxjV8w7TIlNZwT3CWqf3LWS5sAh4ZIKnqyMyMbu4xoLkxifK6P+HzTkMgNW5jw/CNq
 Aku+3b8uO9szwbAhG3AlEqv2ul9hQnBsPGgW5jcJzYCmfky6mvdJigJZy+Nz1reblxyW9xpAFe1
 86TxSHI8nPE1egjv8VSLuIVm76EMwopjO0Z/T+L50lWIgZQ7j5rbzx+7x9iFoFltpNHn0K9A3An
 LwoJKUkv6nnKd9gJUIPNuEZS0AgoZeSszZ20mBiaDmCymL4zeT6ZxZJ/3aLJB7fDOSwA5sNFWhc
 cmA+GkdouLFL8UQkvEhJ50J6RsJjMwBJPlsk17c/9tghtSxlmdvTnHdWGHdyW8/FfxvXZjfDpZE
 foPXYSJaLHlGvVgFJhM/FJvEcg=
X-Received: by 2002:a05:6a00:1492:b0:829:7057:b99e with SMTP id
 d2e1a72fcca58-82972d4abd6mr2488294b3a.54.1772630733598; 
 Wed, 04 Mar 2026 05:25:33 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739db1d6dsm16968505b3a.26.2026.03.04.05.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 05:25:33 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH v4 6/9] target/riscv: Introduce altfmt into DisasContext
Date: Wed,  4 Mar 2026 21:25:10 +0800
Message-ID: <20260304132514.2889449-7-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304132514.2889449-1-max.chou@sifive.com>
References: <20260304132514.2889449-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
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



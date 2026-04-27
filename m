Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DBEFF8850
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 06:11:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHFAW-0005ti-8t; Mon, 27 Apr 2026 02:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wHFAJ-0005UV-4s
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 02:09:55 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1wHFAG-0000t0-RZ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 02:09:54 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-35dac556bb2so5532001a91.1
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 23:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1777270191; x=1777874991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zkL3jPcMswiVx/VRRzQf1eV73SetidZ9/3wOAro8ohA=;
 b=NwztRuMvz7YSeu28w6Uf2lcPAo0mOyaCfgZ2B30PnVkE8AOlthLOB6BE0N3ZfIbG3X
 8o4i+FcxYbp2akK37ueZIUDQN6xD4oE7tHwg48unsk0pzDYdbuItbGDUFDvBTdB30+2i
 ysnbncjyPsudy0/IPImkRgkZDMSC2UPIs75N8muyhUzt5y53NUm3Se5IEUUKPeeDaQ6X
 Lsxl/imBGvC3g76btIEzRMUMev2SQRvyuzPxDVEnMBuIyMLT2kOOXV1+HWZrNoBO+910
 Ln21zm1LUv7bGKQSl1vkMIc3c8ToFABRWn1vCGs/18IHNqtWiA+jE1g2suIy2BI0JJbk
 V7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777270191; x=1777874991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zkL3jPcMswiVx/VRRzQf1eV73SetidZ9/3wOAro8ohA=;
 b=GUt62L6XFjXlirRSPIgRMNXTHlDyFgQ+zRnpAz4emGz+0cw5c0qXRHE3obT9b5DAdl
 iyTnI8Q8LjRupvrGGgzIduiPa7ESEWxIYTWD+A1CqJCCOweKRcRcnvDvknpnAB4Ej3vW
 mjXieqIgJqiuCzgAKB5CivYW3EBPKq6eVtqyVext2ip8CljPZfAKFy2juFhiMjPip77e
 pOm2XqOFMFlqOwe48gLLcKakAFStrCAc2d39NdB5w6uPjEyf6p0OdJQQQczzl1oQ86x6
 vgL8XXMsuAGwVP/8uB/ynvXvawREH7Nw8quUHW6jpg5WrrgrBo484Llr6Eo9DHmq1CaR
 WQzg==
X-Gm-Message-State: AOJu0YwCW8DEJT9Oydo1mKkJEBZ8jQFt+2q5yBnn4pfBnqpSoOyHGJZT
 AhlbgDZcV1mpmsr6GurWQvjF3+gGr8uPAenCHrCwuzxEqx02Vhw1zPb9t3TT9CnCpb2E/bG+LFR
 xd4zDOGgNIAove9Hy19SFWzjQMiJFIFjkrW2neuWOHXD9hqakfy0ArUZns/9QmA5PSHqTRLTmZp
 51/fmJ7X4dJ/ZotDiJJBM402Px2F3qtgyAPhFr6WA=
X-Gm-Gg: AeBDiesj3GXqYjBZkR8DDDDILIS6x9TOs8zIftL69Mhy9WMQYGamda9zqYyQHjRY01z
 cYl/1B9EqSGb8Leze0iYVM17YdyiMTF3ZmDVEd3cjV2QJ8PBFzncd4LU18OJLnK9rHOeqj7DXyz
 9O887Q0WFyNA8FY6F6gJiJLF0R8tq0IEyT9HygKf4E3LS47Qrl9aOsdNuTTi3AP+aGqqlRVi+Lq
 OQ6YK8chT0ZscS/vgK/wyxJeaQX7uq47o/6YFaVZSL+e3REW7iaug61zpg7Umn9BRhm0IopJcK7
 IU0qX+VU6F0zSTR0ruhCDhCdsGvhiUyUO0175k3J8kctzeNIuYHzcjup7oyDhtUtA2S6NrU4Pkj
 sJt++X5l7iTIyye3IOviu9hdpJu5xacl69i/4/PhsptGSvHHTwAD+XyM3ah1bqIh+ZyQScEb9XI
 /SNjFpq/Sdj4/kyssazPVoEK1oMlvLRUiN6k2oqUuZEdWZHO2TXpDryc+NI1FStRRGXYRBYiYwh
 s94uanedSywnJOwEELgxtoTU6R9bFwjdaupLA==
X-Received: by 2002:a17:90a:c10f:b0:35e:d012:5a39 with SMTP id
 98e67ed59e1d1-361404650eemr40252315a91.14.1777270191320; 
 Sun, 26 Apr 2026 23:09:51 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-361410bac6dsm30290710a91.14.2026.04.26.23.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 23:09:51 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 5/9] target/riscv: rvv: Make vfncvtbf16.f.f.w support BF16
 to OFP8 conversion for Zvfofp8min extension
Date: Mon, 27 Apr 2026 14:09:24 +0800
Message-ID: <20260427060928.2322570-6-max.chou@sifive.com>
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

According to the Zvfofp8min extension, the vfncvtbf16.f.f.w instruction
supports BF16 to OFP8 conversion without saturation when SEW is 8.
And the VTYPE.altfmt field is used to select the OFP8 format.
* altfmt = 0: BF16 to OFP8.e4m3
* altfmt = 1: BF16 to OFP8.e5m2

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvbf16.c.inc | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvbf16.c.inc b/target/riscv/insn_trans/trans_rvbf16.c.inc
index 86eb86f615..7e9b0a53a4 100644
--- a/target/riscv/insn_trans/trans_rvbf16.c.inc
+++ b/target/riscv/insn_trans/trans_rvbf16.c.inc
@@ -67,11 +67,20 @@ static bool trans_fcvt_s_bf16(DisasContext *ctx, arg_fcvt_s_bf16 *a)
 static bool trans_vfncvtbf16_f_f_w(DisasContext *ctx, arg_vfncvtbf16_f_f_w *a)
 {
     REQUIRE_FPU;
-    REQUIRE_ZVFBFMIN(ctx);
 
-    if (opfv_narrow_check(ctx, a) && (ctx->sew == MO_16)) {
+    if (opfv_narrow_check(ctx, a) &&
+        ((ctx->sew == MO_16 && ctx->cfg_ptr->ext_zvfbfmin) ||
+         (ctx->sew == MO_8 && ctx->cfg_ptr->ext_zvfofp8min))) {
+        gen_helper_gvec_3_ptr *fn;
         uint32_t data = 0;
 
+        if (ctx->sew == MO_16) {
+            fn = gen_helper_vfncvtbf16_f_f_w;
+        } else {
+            fn = ctx->altfmt ? gen_helper_vfncvtbf16_f_f_w_ofp8e5m2 :
+                               gen_helper_vfncvtbf16_f_f_w_ofp8e4m3;
+        }
+
         gen_set_rm_chkfrm(ctx, RISCV_FRM_DYN);
 
         data = FIELD_DP32(data, VDATA, VM, a->vm);
@@ -81,8 +90,7 @@ static bool trans_vfncvtbf16_f_f_w(DisasContext *ctx, arg_vfncvtbf16_f_f_w *a)
         tcg_gen_gvec_3_ptr(vreg_ofs(ctx, a->rd), vreg_ofs(ctx, 0),
                            vreg_ofs(ctx, a->rs2), tcg_env,
                            ctx->cfg_ptr->vlenb,
-                           ctx->cfg_ptr->vlenb, data,
-                           gen_helper_vfncvtbf16_f_f_w);
+                           ctx->cfg_ptr->vlenb, data, fn);
         finalize_rvv_inst(ctx);
         return true;
     }
-- 
2.52.0



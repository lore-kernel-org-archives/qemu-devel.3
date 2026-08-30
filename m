Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A02FC61DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2026 16:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0i0h-000632-Oh; Sun, 30 Aug 2026 12:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x0i0g-000629-GY
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 12:03:54 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1x0i0c-0007iT-Sn
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 12:03:54 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-8556ec44e9aso2515083b3a.3
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 09:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1788105829; x=1788710629; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wNG2O6yI3cqOSliBCzXTaO4rB4OupX3Tq4hwnPOUltY=;
 b=TnWAb3dEIkMJEXkmlCQzw1qUTFyCEbX4tln0HfZph6gHO7Gjy+Ht1u5bIPU+V9kh1o
 FnwmUNuBOce5CI4zEbMKgrUnYJnEWkevjEq8bCSLcKXSzC1wWV2dgIlh1vphHBT/hmQw
 5xVjURjvLMn+IDBZZCP68sZnLjBbPYHZ43u/zUR1yLqvCUQyjQY9wVyNViG1d93zTvn0
 tyMCDIyPRypP0LugeRvuNMLKv70L7MLI2Z0JDp0ArRS5hN5roqq9N6D8SqUl4yupxWIq
 iTUy9MPHqE/4iHCEie29DyEPNGv5mVs4eI7cmeDoaitLZpxiDGxt2Gt+FUL31Y+NW7vx
 efGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788105829; x=1788710629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wNG2O6yI3cqOSliBCzXTaO4rB4OupX3Tq4hwnPOUltY=;
 b=XVLISywRs4S9n52tmpzAZkOMbkokpvAgkYaZwW44VGkk6/c4psQymmHuP1Oebz8uT9
 0picrTGWBEIrdANoOFB2XuSaqWo2bGV+pBDC9C6OLiEZlONHSJ6x8BA3Z5uiylPAd+pP
 WqTlU41uB9Wsqu5z2c01JT6qpL2DLiFEaDWViLuw54TGjcOkVxPQPujBQEWtQyW3vjea
 VMZKeVNu7/3RaaLv0i0BMC5sCT29e4EiUH+5wnXoWZ5JsaITJpXOKTuYHzyFigYPeAps
 H5kviK1mVjg81++Zbeorh7mWP9vSB8pqHO1Ddk3ki2Fnp9Rx9gU3HhiJQrFKrk0GRwsf
 dQGg==
X-Gm-Message-State: AFuF++mnlFVAQOG1tT+4WOJ806WzYBcxYaNg6Aw1NJFiMA26m5iH/jkP
 0TB9+NQw5QjmW7DRSA2X4bQFEfhKf5JJaUdNsd6iNKdGC5I7ZhmiIpTveMK8CpmuyXNfe8+8G4m
 wn47ICIf+/Cop81S7amZlcWK7dFd7oINBxNTdooYeIOv5frq9pBDyVpc0mjPQMsXdHoBHQitEHn
 QbTfbvBNNYh9SQPorkinSSBELjbKEqB0bx2S+XHCYWOA==
X-Gm-Gg: AR+sD10gcNZA/Qgv4+Kp/xGOSIyh7mdct9s0ymBGfeasuQR6+rCsl7iMclThQbogTWx
 LrRdU+/TNESVZXqxMoVUD33tdaMKQdHmmjwbAcJIA/+x3pTvwWbWv/Jzp9ZdmRpsNhs6z1tbNJh
 1IFvpg7R+66oJ9zfMKN1mFwvA5OI1NfOSFZxj7UiE3Jn0nyBMaHGBNRWjFmpbswbEST5lsoGTeW
 iFZvAwBwpgilZJ+Q9fefeqVliGUMC0ARc+hKZHVTlE/LQV6ZNeUrQRIFgFWukYmwqdOPt+HTOZa
 2ncL8FhFNaNDMKD0wX4LJMDLOZL1CBJeTFMX0W+uo5jaxSYRY87NTzfYyDgzlKQkasHIXaSUWyV
 auTkz1wV/AnyppdGrRO5/065av+13IK801Ly9O7rLQ4hXAZNDPCuuXoEBuQdcUGeYVyOCU+y+yU
 LcrCsu89XJtP9qf/Ls5gYFaDOEH4cPqIfYAyPNdY6xgVVU3LcO3nGOrNytnakJkidHRk0JNRVCH
 401gusbEy3WOqlF/u4gDEH9gUsTR62+bLyK4NdRJ4T7mvSdMRWF4CRCSnmpwn4=
X-Received: by 2002:a05:6a00:3c91:b0:84e:2f2e:8def with SMTP id
 d2e1a72fcca58-85628c72f68mr32617056b3a.6.1788105829296; 
 Sun, 30 Aug 2026 09:03:49 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8569ff701d5sm2455900b3a.25.2026.08.30.09.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 09:03:48 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Max Chou <max.chou@sifive.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 2/6] target/riscv/cpu: List one implied-ext rule per line
Date: Mon, 31 Aug 2026 00:03:31 +0800
Message-ID: <20260830160335.3441069-3-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260830160335.3441069-1-max.chou@sifive.com>
References: <20260830160335.3441069-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Every entry added to riscv_multi_ext_implied_rules[] currently has to
reflow whatever line it lands on, since entries are packed several
per line. List one rule per line instead so future additions are a
pure append.

Suggested-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 58 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 14 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index b4e34daf8ec..af61a1ab48d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2909,20 +2909,50 @@ RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] = {
 };
 
 RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
-    &ZCB_IMPLIED, &ZCD_IMPLIED, &ZCE_IMPLIED,
-    &ZCF_IMPLIED, &ZCMP_IMPLIED, &ZCMT_IMPLIED,
-    &ZDINX_IMPLIED, &ZFA_IMPLIED, &ZFBFMIN_IMPLIED,
-    &ZFH_IMPLIED, &ZFHMIN_IMPLIED, &ZFINX_IMPLIED,
-    &ZHINX_IMPLIED, &ZHINXMIN_IMPLIED, &ZICNTR_IMPLIED,
-    &ZIHPM_IMPLIED, &ZK_IMPLIED, &ZKN_IMPLIED,
-    &ZKS_IMPLIED, &ZVBB_IMPLIED, &ZVE32F_IMPLIED,
-    &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED, &ZVE64X_IMPLIED,
-    &ZVFBFA_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
-    &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
-    &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
-    &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SHA_IMPLIED,
-    &SSCFG_IMPLIED, &SUPM_IMPLIED, &SSPM_IMPLIED, &SMCTR_IMPLIED,
-    &SSCTR_IMPLIED, &SSSTATEEN_IMPLIED,
+    &ZCB_IMPLIED,
+    &ZCD_IMPLIED,
+    &ZCE_IMPLIED,
+    &ZCF_IMPLIED,
+    &ZCMP_IMPLIED,
+    &ZCMT_IMPLIED,
+    &ZDINX_IMPLIED,
+    &ZFA_IMPLIED,
+    &ZFBFMIN_IMPLIED,
+    &ZFH_IMPLIED,
+    &ZFHMIN_IMPLIED,
+    &ZFINX_IMPLIED,
+    &ZHINX_IMPLIED,
+    &ZHINXMIN_IMPLIED,
+    &ZICNTR_IMPLIED,
+    &ZIHPM_IMPLIED,
+    &ZK_IMPLIED,
+    &ZKN_IMPLIED,
+    &ZKS_IMPLIED,
+    &ZVBB_IMPLIED,
+    &ZVE32F_IMPLIED,
+    &ZVE32X_IMPLIED,
+    &ZVE64D_IMPLIED,
+    &ZVE64F_IMPLIED,
+    &ZVE64X_IMPLIED,
+    &ZVFBFA_IMPLIED,
+    &ZVFBFMIN_IMPLIED,
+    &ZVFBFWMA_IMPLIED,
+    &ZVFH_IMPLIED,
+    &ZVFHMIN_IMPLIED,
+    &ZVKN_IMPLIED,
+    &ZVKNC_IMPLIED,
+    &ZVKNG_IMPLIED,
+    &ZVKNHB_IMPLIED,
+    &ZVKS_IMPLIED,
+    &ZVKSC_IMPLIED,
+    &ZVKSG_IMPLIED,
+    &SHA_IMPLIED,
+    &SSCFG_IMPLIED,
+    &SUPM_IMPLIED,
+    &SSPM_IMPLIED,
+    &SMCTR_IMPLIED,
+    &SSCTR_IMPLIED,
+    &SSSTATEEN_IMPLIED,
     NULL
 };
 
-- 
2.43.0



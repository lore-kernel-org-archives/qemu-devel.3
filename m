Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B66D10F34
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 12:42:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOEqH-0002Iz-C9; Wed, 26 Nov 2025 07:41:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vOEpo-0001nA-FO
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 07:41:25 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vOEpl-0003Nr-Rc
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 07:41:23 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4775e891b5eso28640005e9.2
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 04:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764160880; x=1764765680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3pWIda8e2UrEXXWq+lxi04bS+9Uhurh/4yQC9gLnIYs=;
 b=f6Y1Ew7uBNj0WGte654VcVSF5F6Es1XIO05AjIWSYl28kmeGixYigWlSfcRjHQYOLQ
 w7XDEOXJRrcAxvTPEelQ38jUkbTIVIR/Rw+HtWOvC3WuxLOSwCBeS1mJQ2fVxTb88mWk
 l/V4D75KQkH7L1YXjpm0rSv4Ra9c1KFth5EvTphxVJa1bsUAnOtKldX+wSvvdpxMf3er
 +fXurBJuAoCUPWg/r7IJK1nHF6u/IWRS2kK5Ll/XlLgpExu6Yc7LpUb62Dr4xrnHYw66
 60Z385fI+WLLSyGQ400EVs4voKQPKJhidaSEYxV2Cw2Z/k+emvMosA7bckmXN73gdjz+
 Ox9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764160880; x=1764765680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3pWIda8e2UrEXXWq+lxi04bS+9Uhurh/4yQC9gLnIYs=;
 b=TryDaC6EqY71FQGRGYaxYMa7LbOktWvU9dpsQ7wDfdw+XWHkHl4o3HYlJ0zvpnwPK/
 9pHC30+ckUMoygyXwiskuNK2Hah2FxSLncHrBCUxEYdAfEYhxNtfhlxoBGO+7Vqn+UMy
 wBoBuHT2np0izS1klfOxDJJhE51ZV+p0Sb+HJy9wjesIyw7e3Gln0rm38eBIuzDalaFD
 RoB+wi5LLakgh4T4FNkTNQUoa1B+6Eqen1oRDI/NNaFQwd/4PPNp15kZlajz44z0cbkH
 xgcdHIk3LmJAis6rlkyiNBAWSo+0fWRZ4UOQwOpBNePNztBT3UwgB2pdH9CVISRLNQko
 aNKQ==
X-Gm-Message-State: AOJu0Yxg+Rcxm4+lPQaZ+NpQef660XwimXvFajImxaw7LbusRi9d68UG
 NqK07PtAYFsyEpNIiyghOVMEhgftQUNZSrxOLkxOOw353MtLxfu/A4ggBabfBRM5VXP1lEijSPL
 ppxAh
X-Gm-Gg: ASbGncsvxmt+b0rWWzUTExdB4/J5od9ZJN5at1OwIY+ZcIStimwU+ZVM8aPJ2QgI8tn
 K/STo3/j8e/uOPb51kGhem3fC/bn4vrw6QOpCqY+OqLxcjyP/4CqGpjX+b1/U8P7XRDtIuSmF5P
 IUqw/cpvmk0mgeqqx0Ism5y3mMOFtd9teneZPveJ/Ohj7EwEyKgSxkG8m3+gOs7KxfSRcMkyS4B
 C6xAwRo9QAR43DyJWoYPDBKOCB1r0SrxwwTnX0jzBX8QptuqeEj7ULmbyDrmXkqOfY39JcoqCf3
 eJp4DdkfO/7MLwl5Tc5j/2xJuutbUIM140XHASUMC6SthzIYt+YT7RJ0okd8ef2NmW05y/JTq3G
 jj4mgdE1wKsYJTVIPf1clSNNYrrs/VvyKeYHX7/JxqYRSfHm8rs3OkHRTifY/O/bxqwS094xDD1
 3QU5Vq9Atmd9RLuINfhB6ueQ==
X-Google-Smtp-Source: AGHT+IGFeW24VR/G/m/izLHz2352nqwtAI5sx7N7liUTDUi2THJVUtmED8ts2jMXrG+2hILzndQbRQ==
X-Received: by 2002:a05:600c:4fcc:b0:471:9da:5252 with SMTP id
 5b1f17b1804b1-477c01ebe2amr187502335e9.29.1764160879841; 
 Wed, 26 Nov 2025 04:41:19 -0800 (PST)
Received: from jimm-x1.. ([2a10:d582:31e:0:a692:d4e2:eaed:fc4e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f2e556sm40044246f8f.5.2025.11.26.04.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 04:41:19 -0800 (PST)
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH V3 1/4] target/arm: Enable ID_AA64MMFR4_EL1 register.
Date: Wed, 26 Nov 2025 12:36:47 +0000
Message-ID: <20251126124116.351685-2-jim.macarthur@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251126124116.351685-1-jim.macarthur@linaro.org>
References: <20251126124116.351685-1-jim.macarthur@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x335.google.com
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

Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 target/arm/cpu-sysregs.h.inc | 1 +
 target/arm/helper.c          | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
index 2bb2861c62..2ba49d8478 100644
--- a/target/arm/cpu-sysregs.h.inc
+++ b/target/arm/cpu-sysregs.h.inc
@@ -14,6 +14,7 @@ DEF(ID_AA64MMFR0_EL1, 3, 0, 0, 7, 0)
 DEF(ID_AA64MMFR1_EL1, 3, 0, 0, 7, 1)
 DEF(ID_AA64MMFR2_EL1, 3, 0, 0, 7, 2)
 DEF(ID_AA64MMFR3_EL1, 3, 0, 0, 7, 3)
+DEF(ID_AA64MMFR4_EL1, 3, 0, 0, 7, 4)
 DEF(ID_PFR0_EL1, 3, 0, 0, 1, 0)
 DEF(ID_PFR1_EL1, 3, 0, 0, 1, 1)
 DEF(ID_DFR0_EL1, 3, 0, 0, 1, 2)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 27ebc6f29b..c20334fa65 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6566,11 +6566,11 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
               .resetvalue = GET_IDREG(isar, ID_AA64MMFR3) },
-            { .name = "ID_AA64MMFR4_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
+            { .name = "ID_AA64MMFR4_EL1", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 4,
               .access = PL1_R, .type = ARM_CP_CONST,
               .accessfn = access_aa64_tid3,
-              .resetvalue = 0 },
+              .resetvalue = GET_IDREG(isar, ID_AA64MMFR4) },
             { .name = "ID_AA64MMFR5_EL1_RESERVED", .state = ARM_CP_STATE_AA64,
               .opc0 = 3, .opc1 = 0, .crn = 0, .crm = 7, .opc2 = 5,
               .access = PL1_R, .type = ARM_CP_CONST,
-- 
2.43.0



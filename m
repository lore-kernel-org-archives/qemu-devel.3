Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34F9C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:44:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqEG8-0006sm-Ik; Thu, 06 Mar 2025 11:39:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqEG2-0006no-AD
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:39:39 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqEG0-0004bh-A1
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:39:37 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43bc38bb6baso5709905e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 08:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741279174; x=1741883974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0WIG0SaEOnTT7Vl+CcOLcRx6EDCmK/EJvLZA/gTBtzQ=;
 b=HOUs+GU02ulIkn54U9ZPk0a4nSMACpeUf9svog4JIY4UKovzPG5xkL/jI6JHiLPhaD
 mm3ZCM91PFWj7y2llp2HpM+kL1Ja43vYqhX1WZeQ9D2hg2YZy6hSSxYg4kjevtmuK2Wc
 NZ1A9WXfOmgGdSBCvVSixCHscWwp+NyP2JyJjjTgfhWM5M9TCU7nac+8wMcRBYtmGUt8
 kaKgIgEn/5UaQeKYbpAGw8dMsdhoR15aNpmSb92upTIMpDSvbeHe8VfMp5Pu0YE8uGGb
 PDQwdxFoHEcC6oUaKHqASPcLhY1ztbgXD7V+0NkdxVD9eCLEbFQ+7cxsKM6icA+MVLfJ
 ED2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741279174; x=1741883974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0WIG0SaEOnTT7Vl+CcOLcRx6EDCmK/EJvLZA/gTBtzQ=;
 b=NBC7IGq30gW7mfs2EPVU/91IKzP2bbPiiAp0QZNw5X0bq004ZE2CllNgUBWrhCVYqt
 TYR5qYwBCfgruUulRlrg0iG5CfbE5Fu5dmCUFi7QJC7JaBW43QnMXw96dbEOSMld2ign
 oa8f5xJKOYBhAw8ev7M60wuFh0dW7MfB+gkx6is5Es/i6zS1XLLY3MI/jq3spLz40xmh
 ytka3bsUb/2l9BE6AHuHEhQlt2xs6h1NMvYrPNjghcyJ80yum+OqtI4sC5+6FxEPODNU
 LtYf1Uk++fH+VV/AN0+ezCy7tYJk+0hSEElavgHfciGyTPuvHiET0HLss3fmqQ+WrC/d
 K+hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCt1bmumc2Q9dVKYXWNEwjI6WDfsBd898edjsJpiFat87/fbqOpw2HfFJujyBcas1/O+PHtGsH3d9n@nongnu.org
X-Gm-Message-State: AOJu0Yw+LLsvsJ/T8vfhyNGSroy7xhkDJkhvK0Cd9P8Xz2FovwN3zEnQ
 8GeKY4Q6M7Z9Txksu05CLXzQQgRzxCgW+qyuSHPnQIGOirhFtROU8I4epfkzYgoMWiixS+5g/2S
 I
X-Gm-Gg: ASbGnct5osxGs5xALacJVW+a4c0uxGI6nV/V+QpoBovhZPAzHdO98rxnjFhvz73Ujc5
 aeCbkRbdT2amCQiIvQQ71onIHIF+MuSO8cGJqKfKPKD9qc5Dkmw1mH7ODdBHOWnBNHsmb0Qemwq
 rZHiDMdywChMTX5MviP72/AporDTi8/eGmhXm+7qC42wBuCqMYpmxrs5CsxcKr8/NuHeMokVCfQ
 ldgmyFAjP0zaZArlwgVA3hIf/txVNZbu7YtFuKsGOfH40gG2DpXC1ENfw7mWRxeqDtbcpOzE1rZ
 bHoUBxgwyxbsLYXaHbqx0aKQI43gTFx+LLe9AIVT6ALP0o3i6Rk=
X-Google-Smtp-Source: AGHT+IE5ojsik7X1e+U4TVORywURpZgRGu2Wm1h5bYw+VFTI4+V0Kfxa5h1Wz19KCBnSw3NroGrIEA==
X-Received: by 2002:a5d:64cf:0:b0:390:fe13:e0ba with SMTP id
 ffacd0b85a97d-3911f756fd2mr7745130f8f.27.1741279174616; 
 Thu, 06 Mar 2025 08:39:34 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd94913fsm23999905e9.37.2025.03.06.08.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Mar 2025 08:39:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 08/10] target/arm: HCR_EL2.RW should be RAO/WI if EL1 doesn't
 support AArch32
Date: Thu,  6 Mar 2025 16:39:22 +0000
Message-ID: <20250306163925.2940297-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306163925.2940297-1-peter.maydell@linaro.org>
References: <20250306163925.2940297-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

When EL1 doesn't support AArch32, the HCR_EL2.RW bit is supposed to
be RAO/WI.  We don't enforce this.  This isn't a problem yet because
at the moment all of our CPU types with AArch64 support AArch32 at
all exception levels, but in the future this is likely to no longer
be true. Enforce the RAO/WI behaviour.

Note that we handle "reset value should honour RES1 bits" in the same
way that SCR_EL3 does, via a reset function.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1085bff0ec5..6dc6f3858fc 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5167,6 +5167,11 @@ static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
     /* Clear RES0 bits.  */
     value &= valid_mask;
 
+    /* RW is RAO/WI if EL1 is AArch64 only */
+    if (!cpu_isar_feature(aa64_aa32_el1, cpu)) {
+        value |= HCR_RW;
+    }
+
     /*
      * These bits change the MMU setup:
      * HCR_VM enables stage 2 translation
@@ -5224,6 +5229,12 @@ static void hcr_writelow(CPUARMState *env, const ARMCPRegInfo *ri,
     do_hcr_write(env, value, MAKE_64BIT_MASK(32, 32));
 }
 
+static void hcr_reset(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    /* hcr_write will set the RES1 bits on an AArch64-only CPU */
+    hcr_write(env, ri, 0);
+}
+
 /*
  * Return the effective value of HCR_EL2, at the given security state.
  * Bits that are not included here:
@@ -5459,6 +5470,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 0,
       .access = PL2_RW, .fieldoffset = offsetof(CPUARMState, cp15.hcr_el2),
       .nv2_redirect_offset = 0x78,
+      .resetfn = hcr_reset,
       .writefn = hcr_write, .raw_writefn = raw_write },
     { .name = "HCR", .state = ARM_CP_STATE_AA32,
       .type = ARM_CP_ALIAS | ARM_CP_IO,
-- 
2.43.0



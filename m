Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1181C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 18:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg7gU-0006Ue-74; Fri, 01 Mar 2024 13:32:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rg7gK-0006PW-Cy
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 13:32:30 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rg7gG-0008Kq-LO
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 13:32:28 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-412c780464dso7339215e9.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 10:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709317943; x=1709922743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9JEZmlz8rcZzNAyfALikSOUnOYbC8gIs8wauxLnIi0o=;
 b=Z5js9U12/Dkpl5Kpn6ukVxb8HgTdViDDB4vV6AWSCQmArVZ5lxZkqOBlLlljOwamlN
 MFMNtGH+g6Hvt+CBo8o8o8v7ih+Fdt2Dq+vLulSBB1JybVD48Jv3jdWXXIRDtOQDo8P/
 xbVY1HMATvpcE3Ywqie1W/ejHAQDWxvcNeUl0bynEBgxb6IR35kESNW/Wv50aAklGwA5
 5dvSeN+F4o5eftP14L27Eb7QkMsR1gntpTJe+50UwTFRY0kvz0z2vJAFzfv4J3iO8sIM
 Y+wvSDPvTTNPMFK2Ddnx9wupZ6PluEZijEuxIujUL/7nUn32XQ6Bl1++GvOEV6Uz3wCP
 pvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709317943; x=1709922743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9JEZmlz8rcZzNAyfALikSOUnOYbC8gIs8wauxLnIi0o=;
 b=klgYBfJWZzIXTuJ4EbEn+QDAnPas1IYYAitzgHpY0D0BVHD3182hai3yqRHNFLqG1V
 //pQhXcFuUxahEvGviAmfrPpJMDR5IdziNFxRwfuV6qlWI7oyGs/eqEKVijr9ySfZ3vO
 K5IByBrYh3TSJRKF2SNm3InD61oWlfAhAgWjznin3cnEI/qOxDhf0PUBaQmdS0kk480o
 nyM4/V4Pw0yhppA3VP7yX6igsb6o18oG1DXAXZjrMRsmteMeNx08noqnG3sfiyhdqTmc
 HDJRF3wwV0DqFNSP+m68mnr4Wpo2AEqS0OKZ9EhMPuPA2sph//Dw2W89GZCq/PVukl1W
 XURg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZfHGHdfw6tWXsHGqzLPLTS104K03Us1lL4qa1u1dncCagR2N3tGXWk5D0UZAdnaVCdw4WIc0Tq6ob9cV9tGruAvWfEt4=
X-Gm-Message-State: AOJu0Yw8OWPSDUp/61YGAYI3SnUwLJ2hJcUkZ0N4EDk6sWig8yMGYUu/
 04io+GIuq3SccbyH5T8Ow0RJszoWGjGyAbem2xSgf97E2d/RwEVcRtjPhwLJl0I=
X-Google-Smtp-Source: AGHT+IFtdV07smIPQ+fubdtE0ivuotzxIquW43aG8eSvLGm92NLYPxlLv3U63nB+AiG5R55zIdnQlg==
X-Received: by 2002:adf:a11e:0:b0:33d:b2fe:763c with SMTP id
 o30-20020adfa11e000000b0033db2fe763cmr1662534wro.33.1709317942908; 
 Fri, 01 Mar 2024 10:32:22 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 u2-20020adfeb42000000b0033b483d1abcsm5158934wrn.53.2024.03.01.10.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 10:32:22 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH 4/8] target/arm: Don't allow RES0 CNTHCTL_EL2 bits to be
 written
Date: Fri,  1 Mar 2024 18:32:15 +0000
Message-Id: <20240301183219.2424889-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301183219.2424889-1-peter.maydell@linaro.org>
References: <20240301183219.2424889-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Don't allow the guest to write CNTHCTL_EL2 bits which don't exist.
This is not strictly architecturally required, but it is how we've
tended to implement registers more recently.

In particular, bits [19:18] are only present with FEAT_RME,
and bits [17:12] will only be present with FEAT_ECV.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 1c82d12a883..8ec61c12440 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2968,6 +2968,24 @@ static void gt_cnthctl_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     ARMCPU *cpu = env_archcpu(env);
     uint32_t oldval = env->cp15.cnthctl_el2;
+    uint32_t valid_mask =
+        R_CNTHCTL_EL0PCTEN_MASK |
+        R_CNTHCTL_EL0VCTEN_MASK |
+        R_CNTHCTL_EVNTEN_MASK |
+        R_CNTHCTL_EVNTDIR_MASK |
+        R_CNTHCTL_EVNTI_MASK |
+        R_CNTHCTL_EL0VTEN_MASK |
+        R_CNTHCTL_EL0PTEN_MASK |
+        R_CNTHCTL_EL1PCTEN_MASK |
+        R_CNTHCTL_EL1PTEN_MASK;
+
+    if (cpu_isar_feature(aa64_rme, cpu)) {
+        valid_mask |= R_CNTHCTL_CNTVMASK_MASK | R_CNTHCTL_CNTPMASK_MASK;
+    }
+
+    /* Clear RES0 bits */
+    value &= valid_mask;
+
     raw_write(env, ri, value);
 
     if ((oldval ^ value) & R_CNTHCTL_CNTVMASK_MASK) {
-- 
2.34.1



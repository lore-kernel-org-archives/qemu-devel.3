Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A9CC282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZIK-0000w1-0K; Fri, 07 Mar 2025 10:07:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIG-0000uw-RK
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:20 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIF-0008Cr-Al
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:20 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4394a823036so16559685e9.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 07:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741360038; x=1741964838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=li357AJWMFZ6xWx4JegFBm32HWxf9f0kQo9Ln4K3jaE=;
 b=rAFbZoZD7Z+XAWCfSCJdAfQA37BplM5I/e1KlMYrhAo17inz/dHnuSANh3ahoWhYFp
 qVSoRJ/dF6n/4JB834fDTwq3vNH5iNDgrH7RD9jv1yWpkcseFAhFZOzxCa1Ob/O7kp3N
 P8KLIuHKEftjEbUJtAiKlfuPdwwB4dYOlQ2U1sSctCpAomktLyakI2c2q+BKThy00w1w
 K69CWuwEKAAtebR7Eg1V22GyKe3Z+sfcVvlWGjt1mEyr2LM/G3HK5VwPsUJO/Xp2Qa2g
 HfaKPtw0MZPxeNe5njyznWQf1yZ2JEAlzjCjl8tHgVkJdONGJor+xN/lULvk7GFR4OX6
 yF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741360038; x=1741964838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=li357AJWMFZ6xWx4JegFBm32HWxf9f0kQo9Ln4K3jaE=;
 b=omYcfchgilXtyIsdBkq6c/PMtPtmmyCnfnuo9ftDLGM+4/nkRpu+ZpPsEKJKeJCD+0
 y7HoUS+ZYFKJGMztu6OnjXrF3FiSzNjbqMRDc48B3FSLN4nusclskqA4N/MeSzjp6R4Q
 gJ6g60+rtYMyqIRn3HqXYpO9jZyjCNPIcfQ3iggcNBAFau39VdaCJbu+2v2mZZO42Vc+
 wNST0bh9uUXIqYEoCE3xeUoLsKcYnW1wvyLqUxIcEHlWcop10Enjv7moxEuszFEeoOyE
 n70KLtM2ykjmO1vrdEQpYlLId29tflv857xWfXAqkqI1B36fW5pFDVTcbJYvb5eBZNUL
 XXEA==
X-Gm-Message-State: AOJu0YwKvovV0kdKRrt/zzCpevhy0kzwSIwRq2sSPLKUUw5kjYpu1xd8
 6dmquT3EJbuXDXjstut2H5bKTyXmWsigCIXPzODMw8hOwC9/vzCEU7HUcCqDQaqIP+Rp60wlZw/
 /
X-Gm-Gg: ASbGncv4YmRBIZ4ZEIObSyN/7llxL0y6avmvlC/i77oGNensiROHp0apLjAfjQLxnDv
 +Waz/GJTdQeoGSd5rPvcu4O+Gxbz8Lb02lbJ+5LCe7o1MvFrLCZ8cjSXO818RV7T9/6ujhgOdxM
 7D2boRSFYpvWJ1E2CcOMCANEQVRd6JrESkfXjFavik2O3HVixEB+Gl0pdxPYHJ54FBem4Dz7LCJ
 iZ6AdgrPPG1zYGktfxjBv6E2jzVeQRFcFYDDUp8eJ50Fzr9ZUCvE9AbzrNr5WMVOLzV8N9ggJXq
 QgVU7CYnTs0CjvJ/FxAVi6aYzyUcgj0kGNicl0y7ppzumsZHGRg=
X-Google-Smtp-Source: AGHT+IHXSX8wH3HSky4njrUjUJLQDwakrLMLIvcwIVbsGuTqISEZ9Km4Utf+rTAU/DX8D2JSg+ZT0g==
X-Received: by 2002:a5d:5f93:0:b0:38a:88ac:f115 with SMTP id
 ffacd0b85a97d-39132d98703mr2426220f8f.34.1741360037542; 
 Fri, 07 Mar 2025 07:07:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c1031fdsm5443627f8f.89.2025.03.07.07.07.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 07:07:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/21] target/arm: Don't apply CNTVOFF_EL2 for EL2_VIRT timer
Date: Fri,  7 Mar 2025 15:06:52 +0000
Message-ID: <20250307150708.3222813-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307150708.3222813-1-peter.maydell@linaro.org>
References: <20250307150708.3222813-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

The CNTVOFF_EL2 offset register should only be applied for accessses
to CNTVCT_EL0 and for the EL1 virtual timer (CNTV_*).  We were
incorrectly applying it for the EL2 virtual timer (CNTHV_*).

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20250204125009.2281315-3-peter.maydell@linaro.org
---
 target/arm/helper.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 7f341d753cd..5729b313f84 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -2604,7 +2604,6 @@ static uint64_t gt_tval_read(CPUARMState *env, const ARMCPRegInfo *ri,
 
     switch (timeridx) {
     case GTIMER_VIRT:
-    case GTIMER_HYPVIRT:
         offset = gt_virt_cnt_offset(env);
         break;
     case GTIMER_PHYS:
@@ -2624,7 +2623,6 @@ static void gt_tval_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     switch (timeridx) {
     case GTIMER_VIRT:
-    case GTIMER_HYPVIRT:
         offset = gt_virt_cnt_offset(env);
         break;
     case GTIMER_PHYS:
-- 
2.43.0



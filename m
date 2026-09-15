Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3339C88E77
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:09:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6WeV-0006Vg-JW; Tue, 15 Sep 2026 13:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdW-0005WH-Bz
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:08:02 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdU-0003YL-MQ
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:08:02 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d391aso319425e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 10:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789492078; x=1790096878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kCE8k+/UZDCtGmNbg0+Gvk3yCe4b3Qh+CMNI9XhTgDc=;
 b=yxayiEldI8PmQXCA/1BOIk0KCnxoOEJZq7IuOybPDPo5EhvWI3GHM7KZIQpvVPPQQX
 bxXEcYKF2+jbOZifkfI+CloOilAHjWOAxBUnDNN0FibigC5MKGMzyOj5acyuJu+5t6+c
 FZ/+/RWFbym1Msdr/v2H0m64BTZET0BtMc86k3tb2dkjrwkkPX70wsAirpRobN/nQ1lG
 RtxMUphYR4hQoDFJHNfug4XSxOyhFD70e+3qauTx4v83EgJ0y02qRWuzZ62Z+5232MNK
 TNgfpN+GcPtvaBCMXLtk8jwUfIH63OmmNwC0Knb4hfvuiRFisZHhaYXHrQpQqDmodwNk
 aEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789492078; x=1790096878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kCE8k+/UZDCtGmNbg0+Gvk3yCe4b3Qh+CMNI9XhTgDc=;
 b=hyx6HLKUM/HVXjN2z+GF6RbhyFy5suAhpfrEu7TKbXiiHcw3Nm/dkLYMqaupjEgyuf
 ElVd4h1TVDppL1957rD1iRg22pjeKEpwzFEp11s40NPPe0glnLIHaE8WtMVQqo4i3vqM
 w923jXKxOal8mTCrb8GkXUjaDKspeiKK2FBa/QNR13hoJxtMSdFMmTUT94iQltzhuDEA
 vqvyT62in0h9Ss1EyxMCXrnb4w0yqKO7QErx28QNFaTDGQLBK8uORMpJNq0+dFaHq1tL
 fsF/OTveuTPhREpaJzwJbjtsj7h8sMAoYLqVXSvpRhJjk+TEhQFGnCvACW1/Yw9/uD+3
 L5Ow==
X-Gm-Message-State: AFuF++mWW7LpVR90vF0AHL8wPYzeEbNtLUSLF3fU4huQ4tVP5W5qg1lL
 duqkQV5dFklVe6tvsOIYRMKsr51cpb4r5MIKOWK+hvhlZxadYE/gdUoIudzpViKbo/+ApPdMOZU
 67lr2wBk=
X-Gm-Gg: AYBFou2JgC46WFtTKCBuThz6wmkOdjjLzmqKMJnAPbJUkzTZPURe4DE/3fMG7/OKZGV
 7bqk9cvv53iqIFI9CIhb2gO/N0RVzI4oOFuZjh9GLdwkRCHA+5cFV7SAsFhBRVZuneiJMSk0yEL
 W01nuEtBTW1aqGXmW7sSoqZJpYyczYyFao8eT1u8pJOMZn2N0F7nfOLg7HvhlijNH8EdB0NbgVE
 f+EDB3RM8qgxT+yzIpTTzVDqojWTt/Cp4uYo01rR8ygXFlWcXFr3dJqs1Z0A/aGirL6c6YPFU+t
 JqvlmwmHq497hqs8gR292OSZLrA3BDwgZ/VAbFarfkFBCybVoMLnixCrSnXYPOP3jl/FtPzWGBq
 67/Nv0W/aljNidGSxAnRKmLyzpIPG1US6LgDIScSelh6nRJp43Lv0zCazSEL38+XM5jeMY5LwC3
 ztrHjChNZGF3h7RGxdtLOIySzf2bBeP5ECUSeDYEF/qs48ZxjctYiLJbpd2aUSDArlmx5Zw7M6b
 iyr/BkRfsrKWIw3IDB6KC3Ww+TH3lrQfkllDSVSogposexk3NIrhR8CiZ91FTW0UkJACeEPBZkx
 leBH
X-Received: by 2002:a05:600c:4ed0:b0:49c:fc6c:be14 with SMTP id
 5b1f17b1804b1-49e82268adbmr24105745e9.26.1789492078360; 
 Tue, 15 Sep 2026 10:07:58 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf33e01sm431826f8f.23.2026.09.15.10.07.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 10:07:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/20] target/arm: MPU_RASR: mask TEX bits for Armv6-M
Date: Tue, 15 Sep 2026 18:07:33 +0100
Message-ID: <20260915170735.425445-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915170735.425445-1-peter.maydell@linaro.org>
References: <20260915170735.425445-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm2-x10.google.com
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

From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>

Keep the existing mask (0x173f) for CPUs with ARM_FEATURE_V7, and use a
mask that excludes TEX (0x1707) for Armv6-M. PMSAv8 is handled by the
earlier branch and is unaffected by this change.

After writing MPU_RASR on an Armv6-M CPU a subsequent read returns zero
for the TEX bits; Armv7-M behaviour remains unchanged.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/armv7m_nvic.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 51d3dba8525..4136c91f235 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1996,7 +1996,12 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         }
 
         cpu->env.pmsav7.drsr[region] = value & 0xff3f;
-        cpu->env.pmsav7.dracr[region] = (value >> 16) & 0x173f;
+        if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
+            cpu->env.pmsav7.dracr[region] = (value >> 16) & 0x173f;
+        } else {
+            /* Armv6-M has XN, AP, S, C and B, but no TEX field. */
+            cpu->env.pmsav7.dracr[region] = (value >> 16) & 0x1707;
+        }
         tlb_flush(CPU(cpu));
         break;
     }
-- 
2.43.0



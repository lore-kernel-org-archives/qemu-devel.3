Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C9FCC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 10:29:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyRud-00034v-PA; Mon, 24 Aug 2026 06:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wyRuc-00033p-AF
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 06:28:18 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wyRuY-0001q0-JL
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 06:28:17 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so25753145e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 03:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787567292; x=1788172092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aqKROqzH1WTtSlOfECpDIdu6BBJpY3xxMUxQ+mbxfpw=;
 b=p1hwnrPuDW0qP7DGJ8BZ53l+ip/AvgD7HLRvtgpFmYV5HQfQ01f5DpUdqBDaCEcGZu
 ZmSMo88R5iair6A1Rj/ttwYaZ78mR40Unz4KDy8MZP7c4dEx2AelFtCzCfvSfPyHlLEP
 pkP2Zah28zIA/jmQQDdjteutsQROTL7dB6apGL0Y/ImwbR6yzPGQF9h62bZMOabgEEtS
 GMI8WIh1QkAD/2CExi6aqp8nZdhQG2L0baZ5BsT1hAdVFgyC+znhW0KNaxMttQpz+In2
 +8Zc3LRcMJlX78xpSDykBReP3QxF3zsBWrvvyorMJrN0Oj1KjHf317ZVsaZrbRkmBsJX
 Nk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787567292; x=1788172092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=aqKROqzH1WTtSlOfECpDIdu6BBJpY3xxMUxQ+mbxfpw=;
 b=SKEEDk0N9e53gSzvesL5gqnPfj83LxdbSH2xliUtZFDwPETVq8k0gtlWiJtxsfAxXn
 6nPIJrrfjKW1oJxknxl6+a9S2CyHttvFeol4mtz1/g/gm8IBGq1c471PLtxRn90hsaNS
 JSwFhH4cej7L5qQ9tbMR6wyno+j7JCvbzxjGMCE9ssT5vZ6cAqYnyQ2sk6cp13HwDdUL
 DVtBAyG6GCZFPpN+ujgue3pxIX9fs1X2rmJ0iV23kh53pPkHIwHsIPEK4tBnH3i4wF7t
 n8tpuULBWjdUmoi6hxkRypM83FmKceI+iFEYdZ5wsbad94MUtN8GlER5uHuTW9+TCZVq
 IZ+Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp8Q10ViXr5Urq23rbWM6IcQ4Sp0a/JXxI1TAD7TD2VTTwvHWUiu5vmCjtLir66/itRxY2XdURRtTjM@nongnu.org
X-Gm-Message-State: AFuF++lPmNhPVLkBOWfLSt/hqat/xP4cV3lVl93SiKcznSYDRaNkXDuJ
 M+RLGztE8b1Jcs3dWKei3CxN66//+KHzaBACSQZD6EL4eMGSgliCUsCiO0bc3Lud3Ww=
X-Gm-Gg: AR+sD11SkP4btG5ZJXCJG+leF3fm0mPSTDdrLPYXtJP9kjF5gq6dNDSvh+U/ovDBaYx
 gfawUK0PjzFe1GEfVE4boEv7JMZFNrglN75VHD+xEf4TqcnrVYW0sYWNiFBc5OUJ0HsFVDa+JpU
 mvtVFjSJnsBVG90MBZZpUwImYT2WQ2fkWNEQj8yYMBp79xaAjZsd8wU+lYoVJnZPnlMxB4mRVo0
 Eqmb/lrLMWYbmuyda3SCvsTMBC9chsQ65gaUwDk17B7PwT9ndtbLn6qKW91ge5q6nMVXvWG31p4
 egELd699kmgSVCM9tn/UtVgJ02f1d9dcoEY4PeMmV8Yhpr9Zk5McndbqfZofA4/23ndW6zRhNLF
 6Im7MW1fmDBrZjl9y815ryJOfag299BLEAEfqoFabAqYbkuStMSjE49Q+WNJ1MOt8LZlgmAI9rL
 GkjL06aaXfSrXi1z/MkwaMKJ0Mwlhgruvlz199hi0YmZ6rLLAD083f89eEpwN8kWav+FvA/rgfj
 hzXIel2oiToJ0+ZLfpCAgE03z4KNuLWD41VY0wFDdiV064O6TgQyDa8af7Q/XWUxdQn7Q==
X-Received: by 2002:a05:600c:1548:b0:499:841c:2016 with SMTP id
 5b1f17b1804b1-499b8273456mr303455385e9.0.1787567291654; 
 Mon, 24 Aug 2026 03:28:11 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499c355e6d1sm77730095e9.6.2026.08.24.03.28.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 03:28:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 3/6] hw/intc/arm_gicv5: Regularize spacing in config_readl()
 switch
Date: Mon, 24 Aug 2026 11:28:02 +0100
Message-ID: <20260824102805.639072-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824102805.639072-1-peter.maydell@linaro.org>
References: <20260824102805.639072-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

In this file we don't put blank lines between cases in switches,
except that for the switch in config_readl() we've written it half
with blank lines and half without.  Delete the blank lines to make it
consistent with itself and the rest of the file.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I figured probably better to do this before adding a bunch
more cases to the switch, which virt support will do.
---
 hw/intc/arm_gicv5.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 20680a5c225..7480c12413b 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -1468,53 +1468,41 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
             v &= ~R_IRS_IDR0_VIRT_ONE_N_MASK;
         }
         return true;
-
     case A_IRS_IDR1:
         *data = cs->irs_idr1;
         return true;
-
     case A_IRS_IDR2:
         *data = cs->irs_idr2;
         return true;
-
     case A_IRS_IDR3:
         /* In EL3 IDR0.VIRT is 0 so this is RES0 */
         *data = domain == GICV5_ID_EL3 ? 0 : cs->irs_idr3;
         return true;
-
     case A_IRS_IDR4:
         /* In EL3 IDR0.VIRT is 0 so this is RES0 */
         *data = domain == GICV5_ID_EL3 ? 0 : cs->irs_idr4;
         return true;
-
     case A_IRS_IDR5:
         *data = cs->irs_idr5;
         return true;
-
     case A_IRS_IDR6:
         *data = cs->irs_idr6;
         return true;
-
     case A_IRS_IDR7:
         *data = cs->irs_idr7;
         return true;
-
     case A_IRS_IIDR:
         *data = cs->irs_iidr;
         return true;
-
     case A_IRS_AIDR:
         *data = cs->irs_aidr;
         return true;
-
     case A_IRS_IST_BASER:
         *data = extract64(cs->irs_ist_baser[domain], 0, 32);
         return true;
-
     case A_IRS_IST_BASER + 4:
         *data = extract64(cs->irs_ist_baser[domain], 32, 32);
         return true;
-
     case A_IRS_IST_STATUSR:
         /*
          * For QEMU writes to IRS_IST_BASER and IRS_MAP_L2_ISTR take effect
@@ -1522,11 +1510,9 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
          */
         *data = R_IRS_IST_STATUSR_IDLE_MASK;
         return true;
-
     case A_IRS_IST_CFGR:
         *data = cs->irs_ist_cfgr[domain];
         return true;
-
     case A_IRS_SPI_STATUSR:
         /*
          * QEMU writes to IRS_SPI_{CFGR,DOMAINR,SELR,VMR} take effect
@@ -1537,7 +1523,6 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
         v = FIELD_DP32(v, IRS_SPI_STATUSR, IDLE, 1);
         *data = v;
         return true;
-
     case A_IRS_SPI_CFGR:
     {
         GICv5SPIState *spi = spi_for_selr(cs, domain);
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE13CD3424
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 10:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIktt-0003u7-Nh; Fri, 01 May 2026 06:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIktr-0003si-NV
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:11 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIktq-0008E2-5p
 for qemu-devel@nongnu.org; Fri, 01 May 2026 06:15:11 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so11353765e9.3
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 03:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777630509; x=1778235309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9t7sxXRLpO6MKTnicE2Ws/es6K6rtSZrGzRNv62qnpw=;
 b=MluybssXDIArCkN8jgRhPYPoPiiJutvgjNrCo2v7OS1k5D3Cc4BacOOsBz/OpqGAo2
 B7UMDlYKhsZSDoJArrlkTCUtSHG6cXOMyBQ2I+1QvsezlOZRvQ+VjBgzk3OfwUrOyYSb
 3/976mApRFFn7E+h0n7Xa7g5g4tFwmwnEOcxKB7w/YwxdoSrJCpOXFBKPQCD9uWlR+rB
 NLLPu/vi3Si9Gtzznx3pHVfZOX94jyAgK2vkSdx9t55VS7M+fkA+mjMY2VoeAXRDumiM
 H727HnHMWF1w3cVLC9Pe3lGdiN7TV/J0VftC4TIUsv2ikra/28mi27P/HF4Qo71cUT6/
 fpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777630509; x=1778235309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9t7sxXRLpO6MKTnicE2Ws/es6K6rtSZrGzRNv62qnpw=;
 b=SH8K3A6bbxaCHKBWg3n6gIlk1mlIVjnz+s32YrIPjsc39L1vCBagMLT0rbYqaNJ/Rk
 KQruk6cDCZ2IyUa5P01fVS97T+8qOpBOuLmfnsuWPLCqLb080kYbWNICuOj06oabW0UP
 ILJMsESDSoWiNQ4zRfDHhI64hStx3JB4w2IUOsm/fwiTR9DTu8aFouqk/0+wjer4sfTM
 9DSL26j4II7gkMkXbWK0zltnFx68mbsw6JZ6lzbK19jsC99i1bGrIxugwABNrVdIquYH
 AtH4igeCZpowsLB22Re4MgDjh72rz031llELptFKxRB31howceEpZ5YKPogQDYW48LHZ
 IN0g==
X-Gm-Message-State: AOJu0YzZy/AEqhk6sti0gOsNa40DajgYmsBoPNWerRd3/cKYKf7EgRs3
 wLh6iF259528HU8iirsXNo4/Bjt1PHH27Kgv+yRoJ/Dj6JaO/M4yluKYYI23wIK6WO4Q4P4qxV4
 TJy5W
X-Gm-Gg: AeBDietdyuWzsW74zgzUb1UZnc+91rf6/rv6ghO/sMJ+k37M+nsXkdU2csdx8SKxOfz
 WIrxTLe0R8uYh+ZIVQKtWbS4WmKncgmEGqIy/RHMK/kXHOPmvslSGXGcihGHriJfomtafv4dAPT
 vOL4v3YhzrSWXRhhl6TmJRKcyDWM8KE9indNrmDaAZ1jXz1I72gQZzJ4NXIH71qNK4uxcRsWBA2
 FBsKEo9/AyyfyCDHJNKBvu0XBQxZJUv3FCWID/0p/4heprIg5zkehO8VsZpT3gyS8e0CjzEg/Ds
 psS6du5inatxHXmyJtomu73aMiI5SU7/IxA69EDT0OgvD1+pvBgIlUttexnS0REKMvwMdLZasMV
 UXSm6pXXChgQADz8ixHvDtrfvNV4bRNgi9P+AIr247jmNp37VvOEw9xKPcajzcr0KWtfmJOaTqD
 fsUjIhqK6BlogF+SP7vmhpKqkRHfKf3ENDVPzsGRqx2j3F0fYO5MaIJ1nZlB/QFjlu4jOsC+Ssn
 aQB3fn8R9tEvTW62LDmX/ZWIk3WkMKWZF+Ot9z9RnYQu+sE0Ms6
X-Received: by 2002:a05:600c:888e:b0:487:12c:e7e1 with SMTP id
 5b1f17b1804b1-48a84446ed9mr78678975e9.11.1777630508798; 
 Fri, 01 May 2026 03:15:08 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8fede418sm12863335e9.6.2026.05.01.03.15.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 03:15:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/28] hw/arm/fsl-imx8mp: Do not create redundant unimplemented
 devices
Date: Fri,  1 May 2026 11:14:38 +0100
Message-ID: <20260501101505.3485916-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501101505.3485916-1-peter.maydell@linaro.org>
References: <20260501101505.3485916-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

The GPT devices are implemented. No need to create redundant
unimplemented devices.

Fixes: f8b26121762c ("hw/arm/fsl-imx8mp: Implement general purpose
timers")
cc: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260308203516.160103-2-shentey@gmail.com

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/fsl-imx8mp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index b36df82971..33749d7fe1 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -687,6 +687,7 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
         case FSL_IMX8MP_GIC_DIST:
         case FSL_IMX8MP_GIC_REDIST:
         case FSL_IMX8MP_GPIO1 ... FSL_IMX8MP_GPIO5:
+        case FSL_IMX8MP_GPT1 ... FSL_IMX8MP_GPT6:
         case FSL_IMX8MP_ECSPI1 ... FSL_IMX8MP_ECSPI3:
         case FSL_IMX8MP_ENET1:
         case FSL_IMX8MP_I2C1 ... FSL_IMX8MP_I2C6:
-- 
2.43.0



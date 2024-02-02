Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3ADC48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:37:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvb0-0000Iz-7B; Fri, 02 Feb 2024 10:36:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvay-0000FF-6V
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:48 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvaw-0004Sz-KJ
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:36:47 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-511363611ceso1023933e87.2
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706888205; x=1707493005; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=k/KtHzrgDY0sCTDgXF5o6E+FF2YFpOZCP9knTxPgJ0Q=;
 b=OYvMROQjjs3MpNyxgBHKaxUFfA3t0wqxT5RCFiT1oC+NH+XEnfm9Z2AAiOHAvd8loQ
 2ydkWp49xM8KXZkh+uxbIpJf1cex5fAlYV/Jr0XA7Sq/LqxaEJKF74aOJCmP498NNh5t
 gUKhTPJcXfLXXTMFkrz3iSAuVQflHgo//NUlYNkkE4mrQASK5Q9iZMaD5nqBYWpIArIw
 vLGyZIgURuLUtfLM1LvY4FHOPeaioCZolhg7ASZg/5Q6WVVDzb3XoFWdfzJ1Lj4Xh+ja
 zXsPKelzhhHcY8xEXMcSlko30NLVgIShSaHBLkPeeqAzBU9QpiUtnLPMrNL2hfy3MHuD
 wcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706888205; x=1707493005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k/KtHzrgDY0sCTDgXF5o6E+FF2YFpOZCP9knTxPgJ0Q=;
 b=Qwv1UuHqaGHI5YveoQqh3BmmIJ3U+FPv0N69gVU2M+alZ9OnwzAJPVGYIXWQCZU1Bz
 +QFV3oxg5tJn5ekWbRkDJTnqvivztw5/oB9ShJKhxIYURrvk+x6WGF7QZTXZ/Ij6OcOU
 PqvS8ifyVsALhLk0QZd6hubWmnB7Z75mz+ipf30Qj0g1KmFEHw4K6hLIPBJVEcya5U9D
 8Zgcn0BuiQ9s3hi1kPairzDpfjKvaWGti92TvyOycfBd+AluCn7AObAdkkdb26Adcy4g
 Sd/xmFh2HTX6q922ukmnlYVa0SKdX75h2kUFIDt8/bbQ8N2AawZPd1BK46RQu01vkECm
 flCQ==
X-Gm-Message-State: AOJu0Yx6FMdGAeo/D0G63BkxtZZImQeKG+ZaSHhATeBHrU4qQaen1Mc5
 Yls/mNIQhmYAVIsUy2KfTZEpP/B7I9S5H3GQqdwHacrWccwKZhhnpm6+6j8kFWn9/E7+H8QZ6HB
 B
X-Google-Smtp-Source: AGHT+IHeOh3s3Xg4ln4UilKZ4jGUifVQlH91Og2dl4Xcg6A8CrUCYTKOPcEOOvcsKYKMQWPo0tE0kQ==
X-Received: by 2002:a05:6512:b8c:b0:511:3865:2dda with SMTP id
 b12-20020a0565120b8c00b0051138652ddamr1424311lfv.2.1706888204997; 
 Fri, 02 Feb 2024 07:36:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 k2-20020a05600c1c8200b0040fafd84095sm214735wms.41.2024.02.02.07.36.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 07:36:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/36] hw/arm/exynos: Add missing QOM parent for CPU cores
Date: Fri,  2 Feb 2024 15:36:14 +0000
Message-Id: <20240202153637.3710444-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202153637.3710444-1-peter.maydell@linaro.org>
References: <20240202153637.3710444-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

QDev objects created with qdev_new() need to manually add
their parent relationship with object_property_add_child().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Message-id: 20240129151828.59544-2-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/exynos4210.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index 6c428d8eeb4..57c77b140c2 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -556,6 +556,7 @@ static void exynos4210_realize(DeviceState *socdev, Error **errp)
     for (n = 0; n < EXYNOS4210_NCPUS; n++) {
         Object *cpuobj = object_new(ARM_CPU_TYPE_NAME("cortex-a9"));
 
+        object_property_add_child(OBJECT(s), "cpu[*]", cpuobj);
         /* By default A9 CPUs have EL3 enabled.  This board does not currently
          * support EL3 so the CPU EL3 property is disabled before realization.
          */
-- 
2.34.1



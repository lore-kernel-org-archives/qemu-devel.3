Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BB2C369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JSZ-0004jl-EU; Tue, 22 Apr 2025 15:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JS9-0003wm-8A
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:38:47 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JS6-0007JZ-Bs
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:38:44 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22409077c06so78136705ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350721; x=1745955521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kFuKs0ZRdu886zC1P1vHTVTWrvjMTKNkcxWEm3BTBV0=;
 b=F1Pd1ancVunOF2XYDd3v235sDXU4GEDmoLD2cs5Zmi5tMKqkRFfOYrdFEuUtIFFXSV
 8Q31664zbWjQkiDy1A3ORhuMfe9AF6oVDikFv4kBeMXB7H0CPntgktVJGLeZpvL+krcC
 xW9I88JYvaw/cMGkPi3JS0twG+vAdENi9APWiaEFV48vVA62BikqJaylEheShYYaN7mW
 1sl1roL8AQBKrx57YM1O20m5l311JI8JEert/mEVtF4j11RgLs6BpDM6lNd29zPtsH3D
 x6go7V6Apm7NXCD+puskcX9IY2P1//sKZtcgymU+1L/aGHx5S6fbKSYav9g8xLaaMiiQ
 ZF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350721; x=1745955521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kFuKs0ZRdu886zC1P1vHTVTWrvjMTKNkcxWEm3BTBV0=;
 b=I6tZi16i1QTz4vGK1Avv2E1jRuUYC85vM9l82IxPkZF11rOffdL00vc6/mGKZwVA0M
 0VgTHS8+iAG+0VudD0qCWaZo/kZQHmJlT24p0hQTW1infEfps/5EQUsGv50pCdS4wbi4
 5gyszCcqxN3w7QvpBgkaDLYuHFvSexAOmzNhwHRtu8DrzvobYViD7koiasF2DkTzkrvq
 k09ylxlWHXa1z56oE7SHhmKK0zg+rLpJuli4ZaFUUvP7+HirlBSADWWHXnHt7C4WZePy
 5vP9jVzxaRAgCILcsqMoqugtoTXL/n4v49NByn+0qycY7vCAm0Q3O2JBvJWXpM5ClVWF
 V4Ww==
X-Gm-Message-State: AOJu0YzSMS8iGqDWo8/AFUmJ/6+6UBE9Y/70Drkq1njRNm02A89abJXx
 w5Qx0u83yLZ+vOL46VF1H3145RavZZTg+f4n1uLD1wNb4Y+kZ/02LnscLmhj8aLZRBreG9YNGQN
 R
X-Gm-Gg: ASbGncsOXRJhET8BCJ9v+TBzInTOf6DEnJcKw8ksbn4cO7Tp6tHSIGS6Pv4Dr1dIJio
 7bPbGEbPWN3TTRlamGktbUhbgaW3DFFdbqDCeGBzrIEKrKrT0RILRyq/5YJotAH/7dc536+Xlnm
 N3VGR3xWp2qg/oOM1Yxa+IWfeycgeR7Ihl9bLINu2fjAQDpFyh4hDhXdU4dYR5I5y6ZLKPXY9Xq
 Sg7ADOqSEc4ossbpdxBTLSm305KFqlyUMdI47JxjXOcdxtR6mMeWiLXveybwqYpXM/8bIj3EshO
 l7HLSYH5MXpfSQQLZz01jJ/ianFHDBaICS7Qk0H3hw572YqTJLRMPki2jUApXAL6vq3uU5sxV7k
 =
X-Google-Smtp-Source: AGHT+IGg8e1fsPPryl+2CyFkZiTKv+ndwX4lQS5km2B8ytNem9NFRhhXUB1KkYkFAVz52PhuQpUwpw==
X-Received: by 2002:a17:903:1110:b0:223:f408:c3f7 with SMTP id
 d9443c01a7336-22c535831f2mr245926495ad.16.1745350720775; 
 Tue, 22 Apr 2025 12:38:40 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb484dsm88951765ad.148.2025.04.22.12.38.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:38:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 122/147] hw/arm/xlnx-zynqmp: prepare compilation unit to be
 common
Date: Tue, 22 Apr 2025 12:27:51 -0700
Message-ID: <20250422192819.302784-123-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Remove kvm unused headers.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250325045915.994760-28-pierrick.bouvier@linaro.org>
---
 hw/arm/xlnx-zynqmp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index d6022ff2d3..ec2b3a41ed 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -22,9 +22,7 @@
 #include "hw/intc/arm_gic_common.h"
 #include "hw/misc/unimp.h"
 #include "hw/boards.h"
-#include "system/kvm.h"
 #include "system/system.h"
-#include "kvm_arm.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
 
-- 
2.43.0



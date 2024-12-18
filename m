Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F230DE7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 18:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNyb5-0001Wm-69; Wed, 18 Dec 2024 13:16:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNya2-0001B8-BB
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 13:15:30 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNyZx-0007VW-ON
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 13:15:27 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d647d5df90so8558689a12.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 10:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734545715; x=1735150515; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/YHnueKZJegjzPbCxN1afH6WivB/pbe8W0/PepPUkRc=;
 b=rr2BFHW4/2pHdpsU8btR4ZmSVGABZ5BGF4ObCs7+9nvCsVZ36yg9oHZncUb8Nl8579
 qM7W9P5yyS1mOnW0j///Ew6L1fR4ub5zORvTPmHUfIdbCGUsd1TGNIeKqeMlNJ/9S/QG
 9iDa00Ai859gRLmVhguWcR3h56vLu7CDC9X4Sfw+WbQgsZAmm9aiMY/gRQncndFneK2C
 7+MROGzCfsr9iZr5bbOnh54MaZbgdmdRtYsKeE9918/VzER3aWTeVP0cYlIBVP5geYCL
 NbIkPPvVpVH3jP5ylUiq9MCeYuoL5OSTOpltUbrS03bn9GF1UaXUCbn8uQ3oNmwAMq+L
 DwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734545715; x=1735150515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/YHnueKZJegjzPbCxN1afH6WivB/pbe8W0/PepPUkRc=;
 b=OJdwWrXidrpoFOZs7NO3VJBU2urQ0Rus8oMrCeGiMzO4xS5/PoSOIlV75SOgXwp/eR
 Y/cz0uRNHkF3/QgJwQBpxHUa0CLcaWcUW0R/Yv47MGI/FRirCB3J6GACZPNDTkyTsBXL
 oc1sh6jAXyXcsE+PMLT1fAaPG8yHJeBBmImU5nUX5xDjnUQs9fNwiQPKHOr12V1mkqd5
 cTGcXRA41XMDCQvbeRNn7hJJrKQw3DfVKAs/qVWXPpHf06XqVAP/JGz8K9KlTbVe7AxE
 EsdBkbsjtypatfjIiZm/b04TtiokH8GZGPVZ8knboHI2psuXFPO3EuG7ffKfrrlLrr0v
 nlGQ==
X-Gm-Message-State: AOJu0Yyiabry7qFSAXnxielRBVQZbAD/tmR/ErKsosrmoL1H/FfvTBXX
 HDoanFq56F0xje8hOA6Bv/WVc5jsB5VlM3sOq7RCLg49a7OZQMvvT4GJEUsllnc=
X-Gm-Gg: ASbGncvCSR/TKPwCWpOIwXRPzPjYQyeYEeIeJf0iwLjMkKxvSRiDgIz3lpJmYQZrBht
 TWkATa6Thbwjz+lf0vP/5w/JX1wTZzj2UIdsL/LzR8nJS9vIp4oUm3chOJ88A9u1nTasuns/m85
 keVoGT36xkUCHS4hgFGDDUvGZrnddVkYxj4iEU5pLoDpv4/xBOrDXzJCHiuC9h9UWwx1S894SYn
 Kr0Rje3hydgoH5K+JI+9FzP4wpsG4MW6MihYYun3Zk71W30OPof6Zo=
X-Google-Smtp-Source: AGHT+IHoCskYOF9lwlHh4GLBO5KCKL26eP2BiRg5NDAUzzVE0wco+2Ookj78VwJPhpJhoYW112NEpA==
X-Received: by 2002:a05:6402:2790:b0:5d3:ba42:ea03 with SMTP id
 4fb4d7f45d1cf-5d7ee3c857emr3887517a12.8.1734545714813; 
 Wed, 18 Dec 2024 10:15:14 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d652ae137bsm5608894a12.51.2024.12.18.10.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 10:15:12 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8B4B55F86B;
 Wed, 18 Dec 2024 18:15:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <quic_llindhol@quicinc.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH v2 1/5] target/arm: document the architectural names of our
 GTIMERs
Date: Wed, 18 Dec 2024 18:15:07 +0000
Message-Id: <20241218181511.3575613-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241218181511.3575613-1-alex.bennee@linaro.org>
References: <20241218181511.3575613-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
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

As we are about to add more physical and virtual timers lets make it
clear what each timer does.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-stable@nongnu.org
---
 target/arm/gtimer.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/gtimer.h b/target/arm/gtimer.h
index b992941bef..de016e6da3 100644
--- a/target/arm/gtimer.h
+++ b/target/arm/gtimer.h
@@ -10,11 +10,11 @@
 #define TARGET_ARM_GTIMER_H
 
 enum {
-    GTIMER_PHYS     = 0,
-    GTIMER_VIRT     = 1,
-    GTIMER_HYP      = 2,
-    GTIMER_SEC      = 3,
-    GTIMER_HYPVIRT  = 4,
+    GTIMER_PHYS     = 0, /* EL1 physical timer */
+    GTIMER_VIRT     = 1, /* EL1 virtual timer */
+    GTIMER_HYP      = 2, /* EL2 physical timer */
+    GTIMER_SEC      = 3, /* EL3 physical timer */
+    GTIMER_HYPVIRT  = 4, /* EL2 virtual timer */
 #define NUM_GTIMERS   5
 };
 
-- 
2.39.5



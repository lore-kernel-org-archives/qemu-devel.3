Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E600E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 16:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJan9-0007kO-OU; Fri, 06 Dec 2024 11:02:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tJan4-0007gU-DB
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 11:02:51 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tJan2-0006WS-U2
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 11:02:50 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3862ca8e0bbso660043f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 08:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733500967; x=1734105767; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nQKmXaN26XakuY5wULDcEXM0cF+Wz7SAC/9+7yYIy8o=;
 b=vpuj1E4lLRPpCcRLCBTkfy/9rRaNVJu922Q8vCgHOiokpRNcNLLlhmI6d/CzVT7VJb
 NOtYPbhYdCqO/DbJgz5rYfDxxW6slD8nVPmLRQum91bv1NlmbUU3bbgW59eYOOXMlebJ
 X/uBi30eavZHatED+eYVIoSnVjvjJAD4j4yYn76pvHDA+WyVOZV7ZR4FMdBePHHhG1EJ
 rnect46CAyHOerocw3JR6NJcGw8HHqkgitxqvZUUCdloIyxQMx38dU13zdTjxEEwFc0I
 jHJdoPjKJZJsCPR3EF8fxS01PjUtyelP5mDq30BaqdUualBxXjTY7OAKMX1xA9y5egyt
 yjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733500967; x=1734105767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nQKmXaN26XakuY5wULDcEXM0cF+Wz7SAC/9+7yYIy8o=;
 b=DU8cgM11y1MuXquuUvRposWIP+MCFmcT7VN2iVz4u5wAonktOVPaE+pngUqmd8oW+C
 PDTvoYAauvEpxPn6paQiOL7uvwyScuDqISYDN5ULrWGO07kKN9oOD9iaFcrD4FioYR+E
 LTwfafihJ9PDXlKOgiItJWC8JyP4v3BExaIL8DuTPQc0PEw0wJuM9hMYOnpNw5aYNsQH
 afZQFlj5jldYSAPB4UCcFky2wvvcyfI7BQ/f/OAYVeAYf58Phh+GSqBoVrk+/OMUqd9j
 fFJyVG4fTNpD3YfMNj9jI8jHDjTPd3sNPUN+o5SxOAQGMgDS4u/GfKxvnSD2ml2Wc8iV
 d00A==
X-Gm-Message-State: AOJu0YzMt6509Q2HScRl4q9Vw7fYPJ31W95D03kh3j4mT2FaV5OgyRoY
 dvzIUYTvgbfqzC7F9X0WvReg4ViYaxtUfjPCtFssTuYHJ0Ir+SFjh+fqtEnA+aM=
X-Gm-Gg: ASbGncuJl21Zl39rsWyp7tWr4JUY7R+893Bs+1O2dmDL4t/E46AQj1tT5AzLZzsbrYi
 QsG/h9lnpNDRWx5P5dFqAwIPSUDVCXhfyfHOGhCvsIA2Jk9uVOG3TwoQ2ZnzE7d7flNT+KEyj4M
 XJ+Vuew4/KvX3BIiIK/R7w1y42gkFqo3Y5tn5YenmPSCKpIKjVI/bFUbt+Nf/R9F5C+fRwPDuxZ
 M0vHInPZ/ko4F/VUjaqKcnfUS537eWhO1WnWqVu1N6CvTml
X-Google-Smtp-Source: AGHT+IE3nXxUA+cTQuvr4e8tUAkisFUeUUgQBNAZhHKcI64vMsxb+6R7h86DRQBRBA3novzVjXLzxQ==
X-Received: by 2002:a05:6000:3c3:b0:385:fb34:d5a0 with SMTP id
 ffacd0b85a97d-3862b36d067mr3175114f8f.29.1733500961848; 
 Fri, 06 Dec 2024 08:02:41 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3861fd46cc8sm4791799f8f.59.2024.12.06.08.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 08:02:41 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 75DB25F9EA;
 Fri,  6 Dec 2024 16:02:39 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH 1/3] target/arm: document the architectural names of our
 GTIMERs
Date: Fri,  6 Dec 2024 16:02:37 +0000
Message-Id: <20241206160239.3229094-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241206160239.3229094-1-alex.bennee@linaro.org>
References: <20241206160239.3229094-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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

As we are about to add more physical and virtual timers lets make it
clear what each timer does.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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



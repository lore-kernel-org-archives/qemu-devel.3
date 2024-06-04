Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 207F1C27C50
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEVdX-0001eZ-U4; Tue, 04 Jun 2024 10:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sEVdW-0001d5-Ev
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:59:42 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sEVdT-0005CE-Cb
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:59:42 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-35dcd5377c4so4749831f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 07:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717513178; x=1718117978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8A5GBY6RBxkhaAlIyTmqKtiXMHCA3RDVhMBok/swKuk=;
 b=EKZ0rx8IOvebugpXEC+5Qw9LgInpB2UfsnJENSCGmGYSmr3aog9Z3N4hmZuQ9yH3D2
 fAWZJJxhdnjWPr7rElRhAzchD4BktneojRY2loXpO8mYj8lCRFwz/hRss15AHlkdiL1f
 v+gytQVykueJ4kcnOxSi/M4Ulk8UBuiTfiA3AMvCT00Jkr5GxKYsU2oYqLPLqes2J/cF
 1pX0vPtNrd/3hudxkz+GtFs0o5IhU0iZhQElIB/blvDs3NZmZwEY9zr+vphzkptJjn7b
 w0RVDvdSErtIVEeer8MG19so124O9eRWw8XP+swf+PLWVphVb/CVxGOApdp+5axnEbaw
 j/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717513178; x=1718117978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8A5GBY6RBxkhaAlIyTmqKtiXMHCA3RDVhMBok/swKuk=;
 b=ise4Cc3kFClH9yx+6KGD8Qqw1/QD5HSgN19si68d12BTeuADywrj3iHEZdJy7OCjXd
 lCZSgG7x/Bnb0Q0zG1j6UwXsWFtcy6CPZ/mOwgvgChNXQFskHk4WD2XFQVqdKhSgg7Yd
 M4RkwtMpVpsf/VcjTbNM5aMIGOKgRHYg6fUl3PR8iqIyihjCteRnXUsPCCsCu/U7Pjd7
 KBZNfZ8tth3a7baMweHY4EX1DMAA4RHZgLQaK8S4lSA4DlwJwPeBVUFPRCiOnOIVRr4d
 VBm7oVyfbgeOUC0ww/PFt5LpTz1B46e1RPlVncJdwzongd5XTryhzEuqyo7cYbti7Inh
 LMnw==
X-Gm-Message-State: AOJu0YyXeQnXU8KIjvbMeCWwPBg4qGcM82oIKuUX/D/Z1GKCil/HbEG8
 dvkiwCrmEmoJxE7rWImQS33mw/k79ydOniGr4MVYSpi84XYzupqHA/DLhwLlI7ahI54T0j+w8F9
 S
X-Google-Smtp-Source: AGHT+IFs/KitqhxahR5fQChYFnG0LYuBLhKXw4q0k93vlehoNygVViKdMKCQkJLpzB2vKKn8f9ze8Q==
X-Received: by 2002:adf:e386:0:b0:355:2db:a0d with SMTP id
 ffacd0b85a97d-35e0f2589d3mr8959035f8f.13.1717513177922; 
 Tue, 04 Jun 2024 07:59:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd064bbb1sm11767869f8f.101.2024.06.04.07.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 07:59:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/5] scripts/coverity-scan/COMPONENTS.md: Fix monitor
 component
Date: Tue,  4 Jun 2024 15:59:33 +0100
Message-Id: <20240604145934.1230583-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604145934.1230583-1-peter.maydell@linaro.org>
References: <20240604145934.1230583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

Update the 'monitor' component:
 * qapi/ and monitor/ are now subdirectories
 * add job-qmp.c

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 scripts/coverity-scan/COMPONENTS.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coverity-scan/COMPONENTS.md b/scripts/coverity-scan/COMPONENTS.md
index 205ab23b280..3864f8eda07 100644
--- a/scripts/coverity-scan/COMPONENTS.md
+++ b/scripts/coverity-scan/COMPONENTS.md
@@ -97,7 +97,7 @@ migration
   ~ .*/qemu((/include)?/migration/.*)
 
 monitor
-  ~ .*/qemu(/qapi.*|/qobject/.*|/monitor\..*|/[hq]mp\..*)
+  ~ .*/qemu((/include)?/(qapi|qobject|monitor)/.*|/job-qmp.c)
 
 nbd
   ~ .*/qemu(/nbd/.*|/include/block/nbd.*|/qemu-nbd\.c)
-- 
2.34.1



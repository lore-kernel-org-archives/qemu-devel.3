Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F89C00A94
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 16:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvJRr-0001tS-G3; Fri, 12 Apr 2024 12:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rvJRq-0001sh-15
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 12:08:18 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rvJRn-0004Zh-FH
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 12:08:17 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-417d0194705so7468445e9.2
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 09:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712938094; x=1713542894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vCinoxi3fpxu2uzsSkCV5+1SLMrawhwh7G4zKOQNXrM=;
 b=hEIaJi6dGCmXsIB0iiIe72DqFeR1QvNqquo2AKcSfV+O32Ty9OlUgxVygLwC1Dh7xl
 u2xIKCVTLA2YtjD8VkXWL8hY2njYeK8kn6TQnm7+7nVw8z4TOa2RTA2cSRMFgPNu8Deq
 tpOFIr+9sClXajfQBlotLyczdfJ1+R9vg2aemHxa1j+R5ps83ErPRE7Alo/WLl+QAgwj
 I9/QYHkqsYWETxJSBthXP9FkspdoOtXE1CLOk+83mV70qYaNnv7XyKO7wcCvsOPbm2SV
 6qpDrvgtOZjFY5rER10/wlj5+5YeouukDC2gr4EbaDSJvbTchUAxnq/+k9nquMt3Y8AA
 jY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712938094; x=1713542894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vCinoxi3fpxu2uzsSkCV5+1SLMrawhwh7G4zKOQNXrM=;
 b=DhCHSDi3BN7GJoGxZ3BZ7HzC3nw7UAUNSLKnNmDBaPZUODCLdte2oQ+zmrVP8W7zMC
 sjX23HJ5z8HmaKMm+HqZW+rPbEE1Zxf8LcjtleVME6EDyWzNpL6qXlZEOLiy6REVjGF9
 4+ok6P6FlYm4xCiUYB5oZcfzxE3At6eirVLtJlLOKNaZn39IEnhgLogBix/+VjE0pcRT
 EnWCjlVCSWMQ5eFhHfR4kgQEZoj+1/TfgORgzbMQa47AmFrSYL/p4+ZB069Iatp8VjHI
 1HhzhKfuj8J1Sd8sN2kbxO2r9W191bjjgHnwREWIVQp8aChGzrkDdKmaQmdmbdZ3+XkV
 DLag==
X-Gm-Message-State: AOJu0YymJcE2TicR8wgx7bzKCo4retU2LeA8ir+LM93ZKu0y+38BTj5c
 NqGI5NNyGtyuzaW1Fut1NFc97v4Q+EgFcm2ZAeq4dnGmQaOCDyhDGpnuMPMWqC7Mk/agRlbpS/C
 3
X-Google-Smtp-Source: AGHT+IGzuF4teuvh0S6PUmfVo4LO/a+xPHSGZHgblW7EPjNa1gLudsCX/PQ+q7GqoVmw3E9nys2YqQ==
X-Received: by 2002:a05:600c:4586:b0:417:c5cc:77a7 with SMTP id
 r6-20020a05600c458600b00417c5cc77a7mr2122453wmo.13.1712938094062; 
 Fri, 12 Apr 2024 09:08:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 cr12-20020a05600004ec00b00341ce80ea66sm4582371wrb.82.2024.04.12.09.08.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 09:08:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/6] docs/devel/reset: Update to new API for hold and exit
 phase methods
Date: Fri, 12 Apr 2024 17:08:08 +0100
Message-Id: <20240412160809.1260625-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412160809.1260625-1-peter.maydell@linaro.org>
References: <20240412160809.1260625-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

Update the reset documentation's example code to match the new API
for the hold and exit phase method APIs where they take a ResetType
argument.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/devel/reset.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/devel/reset.rst b/docs/devel/reset.rst
index 2ea85e7779b..49baa1ea271 100644
--- a/docs/devel/reset.rst
+++ b/docs/devel/reset.rst
@@ -150,25 +150,25 @@ in reset.
         mydev->var = 0;
     }
 
-    static void mydev_reset_hold(Object *obj)
+    static void mydev_reset_hold(Object *obj, ResetType type)
     {
         MyDevClass *myclass = MYDEV_GET_CLASS(obj);
         MyDevState *mydev = MYDEV(obj);
         /* call parent class hold phase */
         if (myclass->parent_phases.hold) {
-            myclass->parent_phases.hold(obj);
+            myclass->parent_phases.hold(obj, type);
         }
         /* set an IO */
         qemu_set_irq(mydev->irq, 1);
     }
 
-    static void mydev_reset_exit(Object *obj)
+    static void mydev_reset_exit(Object *obj, ResetType type)
     {
         MyDevClass *myclass = MYDEV_GET_CLASS(obj);
         MyDevState *mydev = MYDEV(obj);
         /* call parent class exit phase */
         if (myclass->parent_phases.exit) {
-            myclass->parent_phases.exit(obj);
+            myclass->parent_phases.exit(obj, type);
         }
         /* clear an IO */
         qemu_set_irq(mydev->irq, 0);
-- 
2.34.1



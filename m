Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD3ECD49239
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 15:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD3ju-0006Q0-7Y; Mon, 18 Nov 2024 10:32:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tD3js-0006Pk-Re
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 10:32:32 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tD3jr-0005TJ-7K
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 10:32:32 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-53d9ff92ee9so5153011e87.1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 07:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731943949; x=1732548749; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nse7pQZ59kZ2lu8kx2Xh14wxfZo39/Q62yLPC4uLZ1M=;
 b=TLGxwEs6iFpFhL65IInN17LmE+UhJGN+xCjUEdxcGxOr08cBQ7oGST8fqvXFAxipXh
 PXg+ZK48vkK3aKKFRMfWpLDxSS9FmG1mJ96E1vKZcm8ePTcsOturn/zq9XH4CGZKpyLY
 JGUQZbKkQ2xHpwzVvu1hJNnySoKSCotXQukBmkKqW8WUnLg6sieV7E7I/AzMDsGDKmXw
 l582O5uMRvvvfsogv4gVBVBIjQ2PZOdeEnteV66mIE+OZRz1/xUC7FigreNpWLKraZ8P
 AH5Y+kFH+uYQoIpdDlnQiJKtDv1I+Pet+ddWwFtvG1053kkjBIKYKbY0B7iCLkSTuFl0
 03Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731943949; x=1732548749;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nse7pQZ59kZ2lu8kx2Xh14wxfZo39/Q62yLPC4uLZ1M=;
 b=wqH5xLuXkg0AtqNbnS43D1SXOoTgocs1QX+iLX0RrHxnPxpMUhFlbhoOSDcaFayQjN
 3k3tuQPJE6hUy5PXTPbBN4TNWDH+PNJhPwu9JaO2Sbquv/QwctPP5WrG0dzHNM6OR5T4
 xgRf2HDPvPty65fArMFPnEoOsG+hydyF5qalH9WI1LmXNXYOpRrKU4IsatbYTm1UvrXE
 uhuz1GrB1vfpktdwUz5JrQWrxsMNfSg31BVw/KZ067eMWkAK4ctCwKiGVoY5p246FlSD
 u3AA0hgXztwUnUR+wJE9QITVTiCn8irh85b+ThB2vvEdzip247pCnzM98n2pm7MF8M/3
 vkTQ==
X-Gm-Message-State: AOJu0YxYq56IGyiRD6RT4WJEgI4amYkXsgK2MqmTKAS9G0RDXu3Pe4Np
 jXlhewmjQEx+gI05Ex0IVFwXZM0Kk+YnXjU53fS2koiLS5U5p0fMkx54N429KXWLLykXfWYqy8N
 D
X-Google-Smtp-Source: AGHT+IFQKqdfUHiIn9O906PtoAHPvzWTcDyn6IDXZ/cdHzEaFlnc74UvkaGeTg0T3kI3ybHp1r1NVg==
X-Received: by 2002:a05:6512:b19:b0:53d:a556:52a7 with SMTP id
 2adb3069b0e04-53dab2a8564mr5007157e87.34.1731943947706; 
 Mon, 18 Nov 2024 07:32:27 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dab80a10sm157910495e9.26.2024.11.18.07.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 07:32:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] .gitlab-ci.d: Raise timeout on cross-accel build jobs to 60m
Date: Mon, 18 Nov 2024 15:32:26 +0000
Message-Id: <20241118153226.1524542-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12a.google.com
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

The current 30 minute timeout on the cross_accel_build_job template
is a bit low: sometimes if the k8s runners are running slow the
can hit it, for example this cross-arm64-xen-only job hit the
30 minute timeout while still not quite finished with the compile:
https://gitlab.com/qemu-project/qemu/-/jobs/8401277985

This is partly a "runner performance can be unpredictable" issue:
https://gitlab.com/qemu-project/qemu/-/jobs/8391726482
is the same job from just a day earlier and it finished in
16 minutes. But we already have build jobs that are higher
timeouts than 30 minutes, so we have headroom to raise the
timeout here to something we're less likely to hit on a slow
runner.

Bump the cross_accel_build_job timeout to 60 mins.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 .gitlab-ci.d/crossbuild-template.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/crossbuild-template.yml b/.gitlab-ci.d/crossbuild-template.yml
index 45a98103554..303943f818f 100644
--- a/.gitlab-ci.d/crossbuild-template.yml
+++ b/.gitlab-ci.d/crossbuild-template.yml
@@ -57,7 +57,7 @@
   extends: .base_job_template
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
-  timeout: 30m
+  timeout: 60m
   cache:
     paths:
       - ccache/
-- 
2.34.1



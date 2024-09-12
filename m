Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C186DEED611
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 15:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1solSV-00043q-Ak; Thu, 12 Sep 2024 11:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1solST-00042r-BU
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 11:10:09 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1solSR-0001vi-9K
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 11:10:09 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-53660856a21so1020322e87.2
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 08:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726153805; x=1726758605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HO3ngKL1dLT7a/AYyUnoAkQsd/9xDLmkhgh8xHEpfok=;
 b=UKC+C9lcrIIccFaa2GZUnZlv0COeHUWTvsDRAakXz9x3wvAQmqQADCnsuULHcjj39j
 kyr8GoUXRv5qFO2MuIv8vOaBKnQIpIJrDjY/2lGjcAzpVXoWjShF5BFCUOKtNOEAWEm3
 EEgV88uVTadF9AvWmuu7uLwhEW8Y5XDD8Q4FbN8bBs5t6ObdQWz8e74rzE1pNywKeyI7
 oWqNvgwkTrUYx45xNOigvtrAENqblRIsbveJnT1PDAiblhw1+cYjkCKdxPLP4z4WF81J
 IREAbxHyuDyoCDgunuXMvWaN206Uydg2PvzGARV00RbctVj1hrCnsLMMpOJmtqTaU8Sf
 AR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726153805; x=1726758605;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HO3ngKL1dLT7a/AYyUnoAkQsd/9xDLmkhgh8xHEpfok=;
 b=t+IV08yMBEjPuZvEf8bsrv6rRwtyf+lCJVfVE8lk4cpzeXofWOH05yrv53fHUAdDbT
 u6xTp1PJttUAY/l9bSGD5wG7d96RJ54VBO9rl6hTZZ/mzc7JfRi5QjFc28mYVRuadugE
 VIQ8MhZ8KAdgQyki98DyAgCqH/4cyVLvQcVDgfKQe9eNS67wwahPkPAL+gda68UVvbaX
 efqsV0nldnqKoUNW89qcHu9ZgwkiQSbrGBeMZBbIb/Han6ZiXdRdNcxSEtp7qv+CRmw6
 SHcnyBtn23KDf4q+ngtw6RGJ6eYzqsWDryVvwmYO0WcX4nHvDCKz7wlSv+KIeHhczH3e
 heXw==
X-Gm-Message-State: AOJu0YwMcC94H9NlOUQhULgSeflREI6NNdduYznVCsZGf10qNDYIj6vo
 AprK8Zz0zsXT/69lY7HA8fdo6S+F3hUJGM9isPutlbqnkyjxGmnfWD4tBsq4Bl1qZo1Y1Dk2Vut
 k
X-Google-Smtp-Source: AGHT+IEmRglQ3VgRLkHsoNxdhOfQNv8Xmgnlz80ul5URJgTkYDbcgyB05SmyP0gvIgr5xktUXJhhuQ==
X-Received: by 2002:a05:6512:ac5:b0:533:4652:983a with SMTP id
 2adb3069b0e04-53678fc233fmr2396275e87.35.1726153804874; 
 Thu, 12 Sep 2024 08:10:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cc1375189sm92228915e9.1.2024.09.12.08.10.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Sep 2024 08:10:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2] .gitlab-ci.d/crossbuilds.yml: Force 'make check'
 single-threaded for cross-i686-tci
Date: Thu, 12 Sep 2024 16:10:03 +0100
Message-Id: <20240912151003.2045031-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
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

The cross-i686-tci CI job is persistently flaky with various tests
hitting timeouts.  One theory for why this is happening is that we're
running too many tests in parallel and so sometimes a test gets
starved of CPU and isn't able to complete within the timeout.

(The environment this CI job runs in seems to cause us to default
to a parallelism of 9 in the main CI.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
If this works we might be able to wind this up to -j2 or -j3,
and/or consider whether other CI jobs need something similar.
---
 .gitlab-ci.d/crossbuilds.yml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/crossbuilds.yml b/.gitlab-ci.d/crossbuilds.yml
index 459273f9da5..1e21d082aa4 100644
--- a/.gitlab-ci.d/crossbuilds.yml
+++ b/.gitlab-ci.d/crossbuilds.yml
@@ -62,7 +62,11 @@ cross-i686-tci:
     IMAGE: debian-i686-cross
     ACCEL: tcg-interpreter
     EXTRA_CONFIGURE_OPTS: --target-list=i386-softmmu,i386-linux-user,aarch64-softmmu,aarch64-linux-user,ppc-softmmu,ppc-linux-user --disable-plugins --disable-kvm
-    MAKE_CHECK_ARGS: check check-tcg
+    # Force tests to run in series, to see whether this
+    # reduces the flakiness of this CI job. The CI
+    # environment by default shows us 8 CPUs and so we
+    # would otherwise be using a parallelism of 9.
+    MAKE_CHECK_ARGS: check check-tcg -j1
 
 cross-mipsel-system:
   extends: .cross_system_build_job
-- 
2.34.1



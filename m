Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C673C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 10:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucM3C-0001LZ-20; Thu, 17 Jul 2025 06:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ucM37-0001JZ-QC
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:41:13 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ucM36-0001si-1r
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 06:41:13 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a6e2d85705so428792f8f.0
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 03:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752748869; x=1753353669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=f40l+JNxa+Qw1Eq4rHtyYUgPIKTykLZgO8+SLZoFHrw=;
 b=yvnLXiv1J8x0e/r1v8X6Ve9DVbikwESEjX6x4ZkMH4NmoLwDaJjTJD1Zk5b5TaP7gk
 7pC/i2hXbjXg71QBX7rbjZM5O74HnMY0ydeW/PjpGL7yhXMs0UvV3svBKUhXw9hcMk4H
 mvMkZtaO7bgDvpBvglcehRS7TU9lBa3B3d4khs/SZ+DKBKhJ8SKhkW4gfDGzYz3h4kcz
 cfXLyVrybtNZ8pCEatOWEmD104IMxy6P7AG1b3H+CU216DHWKqlJCJ8ZTFq2wvFTLQMm
 U1Q446hBviQvGqi95HjRHNganemlePLxRRAvdpres0lrX2XIb5yRsSuFlYHnkRvzTZSD
 masQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752748869; x=1753353669;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f40l+JNxa+Qw1Eq4rHtyYUgPIKTykLZgO8+SLZoFHrw=;
 b=LtSMCjxCBzmYuOkXRETH0l98/aPaJ+iJTZjGR092npjSCuCiwRQ8irxOoKluKFw5Zf
 yvJ7T1kXVxATyhiQNGqmnU/gpGHTnmLAftHK/eUXSUSEPkCvNGipXKRTMpNyzUwn67OG
 bxnI0FYSab57mErv08HGzWSUcDnkND9Bic74/w1NR75phnFNTMdmPfDkkoBb6cYN4oQG
 FJG8y1crlBgVmdGawcOxriD9u7HgnYPkVLNeBg2n3elO4TxghMSyhIlcp4M3pfe8GMrA
 BSig8KaXoqZjWG6kUgx7HAKbh/qVtz4A0ECMjgyAWWSUl3OahfkI4AI3AyIIsPAliNTi
 auEg==
X-Gm-Message-State: AOJu0YxPkHUj1Y89V7w4uw0cxvXjK3W2GXF/ZCb1nwVGGc2BSVhsaLJq
 RcR14iTKsO/aVgEVhLLCGDIc3yppByzb/tOIvhL5JqdCk41GD/jX7a8FQktRMYRZJrc=
X-Gm-Gg: ASbGncu3e4a2962OBAxEgDE3lPFcv9QHp9+ESNykteCuzFEIFQ6T4vKtzsYE0Sk5dUR
 71mOeohd6tLnwOHsNRVdUuv6HsOFk6Wh7mDVdUqQSmaeYXwtemhLsR5lrFtRj/sAqQ+RBlMttiS
 BsUe4MmXQe3EHEZXh1d9/OnlR2rrWNUAzP9/wqJRCPuek32tO9c/rQ9rf6UbdAQHem+7WpcA3e6
 IHj0BQ27uhxl/l894343OZTg3ti9yVgSsO6+DZLRIN5XD2wxIhIQ+te8RmwsNtUW53DmwMrH+ko
 0UV2F9Yx9jsBp6Y3/IMZNTNjKG+qxdaRj2ZMiCkev+jv4mpoMaXC8Ed/IDIqHOREY5dC/Kwn7+x
 RBUDifxjCEEUJWnwyry3V29V5dlvjIczVIA==
X-Google-Smtp-Source: AGHT+IFBmb+TymsC0W08YEySPCmqoCe8+KGUa4leAam25j8sJ77JlrImIYbc6IDOvORepwc8PPJAFg==
X-Received: by 2002:a05:6000:2486:b0:3a5:232c:6976 with SMTP id
 ffacd0b85a97d-3b60dd99677mr4771385f8f.44.1752748869405; 
 Thu, 17 Jul 2025 03:41:09 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc9268sm20297868f8f.41.2025.07.17.03.41.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 03:41:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E85115F812;
 Thu, 17 Jul 2025 11:41:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] docs/devel: fix over-quoting of QEMU_TEST_KEEP_SCRATCH
Date: Thu, 17 Jul 2025 11:41:05 +0100
Message-ID: <20250717104105.2656786-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/testing/functional.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
index 9d08abe284..2725633e09 100644
--- a/docs/devel/testing/functional.rst
+++ b/docs/devel/testing/functional.rst
@@ -67,7 +67,7 @@ By default, functional tests redirect informational logs and console output to
 log files. Specify the ``--debug`` flag to also print those to standard output.
 The test framework will automatically purge any scratch files created during
 the tests. If needing to debug a failed test, it is possible to keep these
-files around on disk by setting ```QEMU_TEST_KEEP_SCRATCH=1``` as an env
+files around on disk by setting ``QEMU_TEST_KEEP_SCRATCH=1`` as an env
 variable.  Any preserved files will be deleted the next time the test is run
 without this variable set.
 
-- 
2.47.2



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04800D41C24
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 09:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tB9vz-0002pk-Rx; Wed, 13 Nov 2024 04:45:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1tB9vw-0002oS-RH
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 04:45:09 -0500
Received: from mx.swemel.ru ([95.143.211.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frolov@swemel.ru>) id 1tB9vt-0005D1-VC
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 04:45:08 -0500
From: Dmitry Frolov <frolov@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
 t=1731491099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=e2P9VgiGE9jIwoCHPrOTENc48m3HhUdsI5MnD8h2hLU=;
 b=pOBaIuHc8HgSv50Z76xhZX8ECrN28QbDqdm5penCsj5ENJdDTZ5Fg5LNFtfjhv4vLTXaPX
 wJmazkEdyp8Yw8ORSNiljcRKF2u/i0Q8rDZ5xyEO/kvcjMk0bbOeD7UyBMSvKo+Fz8J5Sh
 F4VNYEebQnAC5oSmmteYTvryYcyLZTk=
To: farosas@suse.de,
	lvivier@redhat.com
Cc: sdl.qemu@linuxtesting.org, qemu-devel@nongnu.org,
 Dmitry Frolov <frolov@swemel.ru>
Subject: [PATCH] tests/qtest: add TIMEOUT_MULTIPLIER
Date: Wed, 13 Nov 2024 12:43:40 +0300
Message-ID: <20241113094342.282676-2-frolov@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=95.143.211.150; envelope-from=frolov@swemel.ru;
 helo=mx.swemel.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Some tests need more time when qemu is built with
"--enable-asan --enable-ubsan"

As was discussed here:
https://patchew.org/QEMU/20241112120100.176492-2-frolov@swemel.ru/

TIMEOUT_MULTIPLIER enviroment variable will be
a useful option, allowing non-invasive timeouts
increasing for a specific build.

Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
---
 scripts/mtest2make.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
index eb01a05ddb..ff60b62724 100644
--- a/scripts/mtest2make.py
+++ b/scripts/mtest2make.py
@@ -27,7 +27,9 @@ def names(self, base):
 .speed.slow = $(foreach s,$(sort $(filter-out %-thorough, $1)), --suite $s)
 .speed.thorough = $(foreach s,$(sort $1), --suite $s)
 
+ifndef TIMEOUT_MULTIPLIER
 TIMEOUT_MULTIPLIER = 1
+endif
 .mtestargs = --no-rebuild -t $(TIMEOUT_MULTIPLIER)
 ifneq ($(SPEED), quick)
 .mtestargs += --setup $(SPEED)
-- 
2.43.0



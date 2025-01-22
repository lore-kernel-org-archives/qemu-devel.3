Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A278DC02182
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 14:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tabGF-0003U4-77; Wed, 22 Jan 2025 08:59:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mordan@ispras.ru>) id 1tabGD-0003Tq-IF
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 08:59:13 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mordan@ispras.ru>) id 1tabG8-0004PF-OE
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 08:59:13 -0500
Received: from Neilbrown.intra.ispras.ru (unknown [10.10.2.179])
 by mail.ispras.ru (Postfix) with ESMTPSA id 9AD7640B2261;
 Wed, 22 Jan 2025 13:59:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 9AD7640B2261
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1737554342;
 bh=9anfFtl2ioc0X2PL6BB832cZTQjaWaaUD1brShBffTY=;
 h=From:To:Cc:Subject:Date:From;
 b=JiufbIRsAMDtHWkTuPIzzW/GAQK5o8a3QmSu0QS9C+e8u261Nq3ygAtCpkS5lZ+8w
 jjJlLKdCSw8AdB433qiD7EdTY/LvvLUKwiZZ3kX9Qm/B0NqxlTX+9jGjwDqE0jeZv4
 wIqcQnLCUUFcvIeVOcQHYr3wVn993SoR9BPZLlw8=
From: Vitalii Mordan <mordan@ispras.ru>
To: Thomas Huth <thuth@redhat.com>
Cc: Vitalii Mordan <mordan@ispras.ru>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org, Vadim Mutilin <mutilin@ispras.ru>,
 Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] Fix a data race with goflag in rcutorture test
Date: Wed, 22 Jan 2025 16:58:43 +0300
Message-Id: <20250122135843.543387-1-mordan@ispras.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84; envelope-from=mordan@ispras.ru;
 helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This patch addresses a potential data race involving the global variable
goflag in the rcutorture test. The issue is resolved by adding the atomic
qualifier to ensure proper synchronization.

Fixes: 8fda74a52b ("rcu: add rcutorture")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2750
Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
---
 tests/unit/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/unit/rcutorture.c b/tests/unit/rcutorture.c
index 7662081683..c4971632f8 100644
--- a/tests/unit/rcutorture.c
+++ b/tests/unit/rcutorture.c
@@ -70,7 +70,7 @@ int nthreadsrunning;
 #define GOFLAG_RUN  1
 #define GOFLAG_STOP 2
 
-static volatile int goflag = GOFLAG_INIT;
+static _Atomic int goflag = GOFLAG_INIT;
 
 #define RCU_READ_RUN 1000
 
-- 
2.34.1



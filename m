Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F72CE77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 11:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrwW-0006Pl-Bu; Wed, 18 Dec 2024 06:10:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrwQ-0006L8-GG
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:10:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrwO-0004XR-Rq
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:10:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734520207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LtueFiq53bccQz1wkBmXgULpP286mtbRso111uR+z5E=;
 b=KTtAWG7db/Ds8bdJGdC+F/yQwvLwg4DvinLi4KcjJ6XxVtxqxjIKUFrbRABYgeKaNCSf1p
 5xEYpwRzT1wBSNikzH5nz83q5qBCXTFVp0XKQBhzNUNkPpAuPjuERpZvYHvPSgug6SUCjD
 tTzaGvwYycigUrwkHbkTWAJMOgCXVzo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-vJNvbohmPHiuSL1lgWNIBA-1; Wed,
 18 Dec 2024 06:10:06 -0500
X-MC-Unique: vJNvbohmPHiuSL1lgWNIBA-1
X-Mimecast-MFC-AGG-ID: vJNvbohmPHiuSL1lgWNIBA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B327F19560BE
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 11:10:05 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.114])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DA56D19560AD; Wed, 18 Dec 2024 11:10:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 01/38] tests/functional: add execute permission to aspeed tests
Date: Wed, 18 Dec 2024 12:09:21 +0100
Message-ID: <20241218110958.226932-2-thuth@redhat.com>
In-Reply-To: <20241218110958.226932-1-thuth@redhat.com>
References: <20241218110958.226932-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

From: Daniel P. Berrangé <berrange@redhat.com>

Tests are expected to be directly invoked when debugging so must
have execute permission.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241217155953.3950506-2-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_aarch64_aspeed.py      | 0
 tests/functional/test_arm_aspeed_ast1030.py  | 0
 tests/functional/test_arm_aspeed_ast2500.py  | 0
 tests/functional/test_arm_aspeed_ast2600.py  | 0
 tests/functional/test_arm_aspeed_palmetto.py | 0
 tests/functional/test_arm_aspeed_rainier.py  | 0
 tests/functional/test_arm_aspeed_romulus.py  | 0
 7 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 tests/functional/test_aarch64_aspeed.py
 mode change 100644 => 100755 tests/functional/test_arm_aspeed_ast1030.py
 mode change 100644 => 100755 tests/functional/test_arm_aspeed_ast2500.py
 mode change 100644 => 100755 tests/functional/test_arm_aspeed_ast2600.py
 mode change 100644 => 100755 tests/functional/test_arm_aspeed_palmetto.py
 mode change 100644 => 100755 tests/functional/test_arm_aspeed_rainier.py
 mode change 100644 => 100755 tests/functional/test_arm_aspeed_romulus.py

diff --git a/tests/functional/test_aarch64_aspeed.py b/tests/functional/test_aarch64_aspeed.py
old mode 100644
new mode 100755
diff --git a/tests/functional/test_arm_aspeed_ast1030.py b/tests/functional/test_arm_aspeed_ast1030.py
old mode 100644
new mode 100755
diff --git a/tests/functional/test_arm_aspeed_ast2500.py b/tests/functional/test_arm_aspeed_ast2500.py
old mode 100644
new mode 100755
diff --git a/tests/functional/test_arm_aspeed_ast2600.py b/tests/functional/test_arm_aspeed_ast2600.py
old mode 100644
new mode 100755
diff --git a/tests/functional/test_arm_aspeed_palmetto.py b/tests/functional/test_arm_aspeed_palmetto.py
old mode 100644
new mode 100755
diff --git a/tests/functional/test_arm_aspeed_rainier.py b/tests/functional/test_arm_aspeed_rainier.py
old mode 100644
new mode 100755
diff --git a/tests/functional/test_arm_aspeed_romulus.py b/tests/functional/test_arm_aspeed_romulus.py
old mode 100644
new mode 100755
-- 
2.47.1



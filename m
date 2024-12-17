Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76392E77187
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 16:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNZze-0004Bv-0N; Tue, 17 Dec 2024 11:00:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNZzX-000474-PQ
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:00:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNZzT-0001tA-Qu
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:00:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734451205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X1FqZHlUAELokAeZhleWmAqzlFP/GclIZNyedA1V2Eg=;
 b=K3lVzPdh2LPwnVd+ATN6UvHvUBWWVIVujYM+xVF9/cHKEvs61YvVkUysVKeFDorykfN4un
 y9+HcIDDAMVnu9p7w5Ps9U1vy20Ce76CzF6ZKcp1fdL3L+bLISXUuonmbBlWk/jj046nec
 8895575+JbTyRx8Z1hQ2eHgWCYvcJ5A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-4RzrZGKYMf2PdT-b8QGJ8w-1; Tue,
 17 Dec 2024 11:00:03 -0500
X-MC-Unique: 4RzrZGKYMf2PdT-b8QGJ8w-1
X-Mimecast-MFC-AGG-ID: 4RzrZGKYMf2PdT-b8QGJ8w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6621519560A6; Tue, 17 Dec 2024 16:00:00 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.136])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5F88130044C1; Tue, 17 Dec 2024 15:59:58 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 01/32] tests/functional: add execute permission to aspeed
 tests
Date: Tue, 17 Dec 2024 15:59:22 +0000
Message-ID: <20241217155953.3950506-2-berrange@redhat.com>
In-Reply-To: <20241217155953.3950506-1-berrange@redhat.com>
References: <20241217155953.3950506-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

Tests are expected to be directly invoked when debugging so must
have execute permission.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
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
2.46.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CA2CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 16:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9QoQ-00037a-Sk; Thu, 16 Oct 2025 12:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9QoD-0002xg-K6
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:26:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v9Qo1-0004xM-Dj
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760631976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CsXNk0bNR7geyKHVldXcDOSqODASb0NEf1xECyBSNGA=;
 b=bBviUyg4u1nTGXz4JStRVXe2GFCzhmg5tTrItfsyynW35kD6Sxkf/FM7ds/toPqewXo3A4
 33J25IKMhHS7iR4yibogPWeL1XCTnQOuyhuiDQE9Rw/UthU3dBN60+dY0d0LPilFZBsdvk
 FUp8Wh0S/YnKYkNvha3c3FzMANEWfU0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-kPisOi7tNVGxDQvOHcK0kg-1; Thu,
 16 Oct 2025 12:26:11 -0400
X-MC-Unique: kPisOi7tNVGxDQvOHcK0kg-1
X-Mimecast-MFC-AGG-ID: kPisOi7tNVGxDQvOHcK0kg_1760631969
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB9E718002F7; Thu, 16 Oct 2025 16:26:08 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.163])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DA4781956056; Thu, 16 Oct 2025 16:26:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 01/10] python/qemu: Replace some remaining "avocados" with
 "functional tests"
Date: Thu, 16 Oct 2025 18:25:52 +0200
Message-ID: <20251016162601.442557-2-thuth@redhat.com>
In-Reply-To: <20251016162601.442557-1-thuth@redhat.com>
References: <20251016162601.442557-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

The avocado tests have been replaced by the new functional tests,
so also update this in the README.rst files in the python directory
accordingly.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251008131936.71160-1-thuth@redhat.com>
---
 python/qemu/machine/README.rst | 2 +-
 python/qemu/utils/README.rst   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/python/qemu/machine/README.rst b/python/qemu/machine/README.rst
index 8de2c3d7722..6554c693201 100644
--- a/python/qemu/machine/README.rst
+++ b/python/qemu/machine/README.rst
@@ -2,7 +2,7 @@ qemu.machine package
 ====================
 
 This package provides core utilities used for testing and debugging
-QEMU. It is used by the iotests, vm tests, avocado tests, and several
+QEMU. It is used by the iotests, vm tests, functional tests, and several
 other utilities in the ./scripts directory. It is not a fully-fledged
 SDK and it is subject to change at any time.
 
diff --git a/python/qemu/utils/README.rst b/python/qemu/utils/README.rst
index d5f2da14540..5027f0b5f11 100644
--- a/python/qemu/utils/README.rst
+++ b/python/qemu/utils/README.rst
@@ -2,6 +2,6 @@ qemu.utils package
 ==================
 
 This package provides miscellaneous utilities used for testing and
-debugging QEMU. It is used primarily by the vm and avocado tests.
+debugging QEMU. It is used primarily by the vm and functional tests.
 
 See the documentation in ``__init__.py`` for more information.
-- 
2.51.0



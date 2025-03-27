Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0B0C3600C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Mar 2025 08:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txiGW-0000ku-3M; Thu, 27 Mar 2025 04:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1txiGT-0000am-LF
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 04:07:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1txiGS-00065n-1u
 for qemu-devel@nongnu.org; Thu, 27 Mar 2025 04:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743062819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VMBpKp04CIINiZQusrQvsEbysXUo3UnkwiHZM16eSXs=;
 b=a2gmKTprnqSUzHdZknyxMfnJg0jA16q6dNEUmaCbadtQ+fr6C6Tq0gwdOgaVJAcvIJ+e7U
 3qC4ElVsC0RLdscx5Sz+UXs9rzL+G+lBcn4KoTN50hEkIxycMRFuiDBaTFfwBhxHiNcPpC
 8KGzQ1pFtkozyUlIUf48j2/vcgqP/qY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-viO8-p2bOw6sRGziXESZ-w-1; Thu,
 27 Mar 2025 04:06:40 -0400
X-MC-Unique: viO8-p2bOw6sRGziXESZ-w-1
X-Mimecast-MFC-AGG-ID: viO8-p2bOw6sRGziXESZ-w_1743062799
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9844A18007E1; Thu, 27 Mar 2025 08:06:39 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.126])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2734819560AB; Thu, 27 Mar 2025 08:06:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 5/6] tests/functional/test_aarch64_virt_gpu: Skip if "dbus"
 display isn't available
Date: Thu, 27 Mar 2025 09:06:21 +0100
Message-ID: <20250327080622.954388-6-thuth@redhat.com>
In-Reply-To: <20250327080622.954388-1-thuth@redhat.com>
References: <20250327080622.954388-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Thomas Huth <thuth@redhat.com>

This test currently fails if the "dbus" display has not been compiled
into the binary (which can happen when CFI has been enabled, for example).
Check for the error message to skip the test in that case.

While we're at it, also make sure that this test is covered in the
right section in the MAINTAINERS file.

Message-ID: <20250325061609.272847-1-thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                               | 2 +-
 tests/functional/test_aarch64_virt_gpu.py | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f470a1c9b7..c1ccb0acd14 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1018,7 +1018,7 @@ S: Maintained
 F: hw/arm/virt*
 F: include/hw/arm/virt.h
 F: docs/system/arm/virt.rst
-F: tests/functional/test_aarch64_virt.py
+F: tests/functional/test_aarch64_virt*.py
 F: tests/functional/test_aarch64_tuxrun.py
 F: tests/functional/test_arm_tuxrun.py
 
diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/test_aarch64_virt_gpu.py
index 314d994a7aa..38447278579 100755
--- a/tests/functional/test_aarch64_virt_gpu.py
+++ b/tests/functional/test_aarch64_virt_gpu.py
@@ -74,6 +74,8 @@ def _launch_virt_gpu(self, gpu_device):
                 self.skipTest("Can't access host DRM render node")
             elif "'type' does not accept value 'egl-headless'" in excp.output:
                 self.skipTest("egl-headless support is not available")
+            elif "'type' does not accept value 'dbus'" in excp.output:
+                self.skipTest("dbus display support is not available")
             else:
                 self.log.info("unhandled launch failure: %s", excp.output)
                 raise excp
-- 
2.49.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E2FCA0FF6
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 07:56:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urB04-0005Iq-7e; Wed, 27 Aug 2025 03:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urB01-0005GK-2m
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:55:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urAzw-0001wE-5A
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756281310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5gQzJ90qET6RhRj461NrORejjWHb983qUtY+6T5oBsM=;
 b=E6UMGEPIo+BWAvzF45unNrgXuTVv2SCnIkYxa6qyxY5JhrtjqJIUe/kK/nWp1gPTrSZpU2
 APSP35jRRQ3rqrGw0rXrRYH/Z1hX5Emvc9dzz+iOkCXfMKISQTwRBLsN+l3/5/vDtM9Z9b
 0bPwxHS8v7G8FLP07gSh8YqBwZnnzFY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-85_bX24FPd2ImyD8vrvZ5A-1; Wed,
 27 Aug 2025 03:55:03 -0400
X-MC-Unique: 85_bX24FPd2ImyD8vrvZ5A-1
X-Mimecast-MFC-AGG-ID: 85_bX24FPd2ImyD8vrvZ5A_1756281301
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B351A180036E; Wed, 27 Aug 2025 07:55:01 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.40])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B0EE01955F24; Wed, 27 Aug 2025 07:54:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: [PULL 03/31] tests/functional/test_aarch64_virt_gpu: Skip test if EGL
 won't initialize
Date: Wed, 27 Aug 2025 09:54:13 +0200
Message-ID: <20250827075443.559712-4-thuth@redhat.com>
In-Reply-To: <20250827075443.559712-1-thuth@redhat.com>
References: <20250827075443.559712-1-thuth@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

If you are using the Nvidia drivers and have installed new versions
of those packages but have not yet rebooted the host kernel,
attempting to use the egl-headless display will cause QEMU to fail to
start with

$ qemu-system-aarch64 -M virt -display egl-headless
qemu-system-aarch64: egl: eglInitialize failed: EGL_NOT_INITIALIZED
qemu-system-aarch64: egl: render node init failed

together with this complaint in the host kernel dmesg:

[7874777.555649] NVRM: API mismatch: the client has the version 535.247.01, but
                 NVRM: this kernel module has the version 535.230.02.  Please
                 NVRM: make sure that this kernel module and all NVIDIA driver
                 NVRM: components have the same version.

This isn't a problem with QEMU itself, so reporting this as a test
failure is misleading.  Instead skip the tests, as we already do for
various other kinds of "host system can't actually run the EGL
display" situation.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20250826123455.2856988-1-peter.maydell@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Acked-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_aarch64_virt_gpu.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/test_aarch64_virt_gpu.py
index 38447278579..4e50887c3e9 100755
--- a/tests/functional/test_aarch64_virt_gpu.py
+++ b/tests/functional/test_aarch64_virt_gpu.py
@@ -76,6 +76,8 @@ def _launch_virt_gpu(self, gpu_device):
                 self.skipTest("egl-headless support is not available")
             elif "'type' does not accept value 'dbus'" in excp.output:
                 self.skipTest("dbus display support is not available")
+            elif "eglInitialize failed: EGL_NOT_INITIALIZED" in excp.output:
+                self.skipTest("EGL failed to initialize on this host")
             else:
                 self.log.info("unhandled launch failure: %s", excp.output)
                 raise excp
-- 
2.50.1



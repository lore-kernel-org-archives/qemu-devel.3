Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 992FFC0219D
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 12:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thpQp-0005fz-Ic; Tue, 11 Feb 2025 07:32:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1thpQo-0005ez-0o
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 07:32:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1thpQm-0000Lm-Bv
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 07:32:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739277119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uc9/dlDT/bJAfXkGY2NKlVxGzjN+TLxFVh/CfDzVIY0=;
 b=MUkszilWzs7kgtxQXZcNrSjs3v2wdS+afecRRUUNJvn8DbBjjwGQW/D/y7J9OpaLJz3fem
 CDYi6zDvmx9RwMj8/CHSOxFyS6LlxijHnAX49hB5pSMgkv3xlu80I69WYpOLm+5k5csrOP
 FAM+bKjiXWarGA9hePCvKKq8dHTnwh8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-Wx3N9Yc3PBewSlNbDiV2Vw-1; Tue,
 11 Feb 2025 07:31:54 -0500
X-MC-Unique: Wx3N9Yc3PBewSlNbDiV2Vw-1
X-Mimecast-MFC-AGG-ID: Wx3N9Yc3PBewSlNbDiV2Vw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 41FDF195609F; Tue, 11 Feb 2025 12:31:53 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.52])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 13EB819560A3; Tue, 11 Feb 2025 12:31:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 2/7] tests/functional/test_aarch64_virt: Fix vulkan test
 without egl-headless
Date: Tue, 11 Feb 2025 13:31:39 +0100
Message-ID: <20250211123144.37617-3-thuth@redhat.com>
In-Reply-To: <20250211123144.37617-1-thuth@redhat.com>
References: <20250211123144.37617-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

The vulkan test currently fails if the egl-headless device is not
available. Let's add a proper check to skip the test in this case.

Fixes: 3d30f882ce ("tests/functional: extend test_aarch64_virt with vulkan test")
Reported-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20250205141140.97437-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/test_aarch64_virt.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/functional/test_aarch64_virt.py b/tests/functional/test_aarch64_virt.py
index 07c1c13638..95f5ce8b4c 100755
--- a/tests/functional/test_aarch64_virt.py
+++ b/tests/functional/test_aarch64_virt.py
@@ -189,6 +189,8 @@ def test_aarch64_virt_with_gpu(self):
                 self.skipTest("No venus support for virtio-gpu")
             elif "egl: no drm render node available" in excp.output:
                 self.skipTest("Can't access host DRM render node")
+            elif "'type' does not accept value 'egl-headless'" in excp.output:
+                self.skipTest("egl-headless support is not available")
             else:
                 self.log.info(f"unhandled launch failure: {excp.output}")
                 raise excp
-- 
2.48.1



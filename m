Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17392D729EC
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 17:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH4qx-00044h-RT; Fri, 29 Nov 2024 12:32:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tH4qe-0003mV-E7
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:32:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tH4qc-00013x-Gv
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:32:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732901525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TiL9pH5cIq3jBdyWCkXQVTmhwDXpS93CWDVMG70rST8=;
 b=hlEQ835zvtWwUYv7c9ZKN/8QITLaDMBh6zgDR6Ff0MtxCaEFVsi6u5v3EBMo54oCMYCEL7
 mfaG/hS4qFYu0E1UIi9pMcJQxCtuqGJbndiMGlsz+dBmRng6wEACvKwTXCNVV7yOb9UoFf
 XvFmsgOZQ2RazP2gGP+wy+WAmcuDkuw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-vRCoqlfTNPaSdNjJ3NJaaQ-1; Fri,
 29 Nov 2024 12:32:04 -0500
X-MC-Unique: vRCoqlfTNPaSdNjJ3NJaaQ-1
X-Mimecast-MFC-AGG-ID: vRCoqlfTNPaSdNjJ3NJaaQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E4B71955D9E; Fri, 29 Nov 2024 17:32:03 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.37])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7DF7D1955F41; Fri, 29 Nov 2024 17:32:01 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 15/22] tests/functional: add common zip_extract helper
Date: Fri, 29 Nov 2024 17:31:13 +0000
Message-ID: <20241129173120.761728-16-berrange@redhat.com>
In-Reply-To: <20241129173120.761728-1-berrange@redhat.com>
References: <20241129173120.761728-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This mirrors the existing archive_extract and cpio_extract helpers

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/qemu_test/utils.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/functional/qemu_test/utils.py b/tests/functional/qemu_test/utils.py
index 1bf1c410d5..41bd1df666 100644
--- a/tests/functional/qemu_test/utils.py
+++ b/tests/functional/qemu_test/utils.py
@@ -46,6 +46,13 @@ def archive_extract(archive, dest_dir, member=None):
         else:
             tf.extractall(path=dest_dir)
 
+def zip_extract(archive, dest_dir, member=None):
+    with zipfile.ZipFile(archive, 'r') as zf:
+        if member:
+            zf.extract(member=member, path=dest_dir)
+        else:
+            zf.extractall(path=dest_dir)
+
 def gzip_uncompress(gz_path, output_path):
     if os.path.exists(output_path):
         return
-- 
2.46.0



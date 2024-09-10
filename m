Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04337EDE9B4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 20:18:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so7JB-0007A2-04; Tue, 10 Sep 2024 16:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1so7J9-00079L-P2
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 16:17:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1so7J8-0004NU-8l
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 16:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725999469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=s3gvbQ5RxB3TbCIBAE7+fXLRQemet9i7gqFpJdp4eCQ=;
 b=Xo2MxySUpDxbgusGza5C5YrvZMwfBd0RimnGiFDbNRH6j/qplzU9Fk/s4mYRHV9FbJSr3K
 Z4U41rTgsA1V5uXaw5CPQ8m775D8A2U5TvxqZIh/v8VswxZJlQ+GAZjMFC7tZ5jJM1SsF2
 wXYs2eQx3wu0YGuDe9V42N5A9GxIW2M=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-Qi7JjdTQOMCxBnGIgQgNsA-1; Tue,
 10 Sep 2024 16:17:48 -0400
X-MC-Unique: Qi7JjdTQOMCxBnGIgQgNsA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2D2B19560A2; Tue, 10 Sep 2024 20:17:46 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.120])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BEC0619560AD; Tue, 10 Sep 2024 20:17:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] tests/functional/qemu_test: Use Python hashlib instead of
 external programs
Date: Tue, 10 Sep 2024 22:17:42 +0200
Message-ID: <20240910201742.239559-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Some systems (like OpenBSD) do not have the sha256sum or sha512sum programs
installed by default. Use the Python hashlib instead so we don't have to
rely on the external programs.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/asset.py | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tests/functional/qemu_test/asset.py b/tests/functional/qemu_test/asset.py
index d3be2aff82..3ec429217e 100644
--- a/tests/functional/qemu_test/asset.py
+++ b/tests/functional/qemu_test/asset.py
@@ -43,15 +43,21 @@ def _check(self, cache_file):
         if self.hash is None:
             return True
         if len(self.hash) == 64:
-            sum_prog = 'sha256sum'
+            hl = hashlib.sha256()
         elif len(self.hash) == 128:
-            sum_prog = 'sha512sum'
+            hl = hashlib.sha512()
         else:
             raise Exception("unknown hash type")
 
-        checksum = subprocess.check_output(
-            [sum_prog, str(cache_file)]).split()[0]
-        return self.hash == checksum.decode("utf-8")
+        # Calculate the hash of the file:
+        with open(cache_file, 'rb') as file:
+            while True:
+                chunk = file.read(1 << 20)
+                if not chunk:
+                    break
+                hl.update(chunk)
+
+        return  hl.hexdigest()
 
     def valid(self):
         return self.cache_file.exists() and self._check(self.cache_file)
-- 
2.46.0



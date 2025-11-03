Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036C2CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 11:00:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFsH0-0003oB-87; Mon, 03 Nov 2025 05:58:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vFsGy-0003nq-Po
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:58:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vFsGs-0004Hc-Ag
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762167524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4skMTA8q4CKiXos5Nlm3GfRuvfkktXGVS7jbmmBo9qg=;
 b=hSUJ16usVXHA1R3EDBcQONFScN4Iv2kmOwHnEcFXYfnTnsUeli73GGSYnlYxHpP3vieUzw
 JpNRg1QtWE/C0mdMaBTtJljGqxCzNls7wtwPIhEFa2gfTlb+R7qj0EReHvHX6soLu6cc3S
 qao6A1hIJ0sJP3s3G6FSJ2yJP9ZAKKI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-HjJ8z68ZOwKzpv97_5xSGg-1; Mon,
 03 Nov 2025 05:58:40 -0500
X-MC-Unique: HjJ8z68ZOwKzpv97_5xSGg-1
X-Mimecast-MFC-AGG-ID: HjJ8z68ZOwKzpv97_5xSGg_1762167519
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0B9C180A236; Mon,  3 Nov 2025 10:58:39 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.12])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 44E1030001A1; Mon,  3 Nov 2025 10:58:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/22] tests/functional: Fix problems in utils.py reported by
 pylint
Date: Mon,  3 Nov 2025 11:58:03 +0100
Message-ID: <20251103105824.322039-7-thuth@redhat.com>
In-Reply-To: <20251103105824.322039-1-thuth@redhat.com>
References: <20251103105824.322039-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

- put the doc strings in the right locations (after the "def" line)
- use the right indentation (4 spaces)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251015095454.1575318-7-thuth@redhat.com>
---
 tests/functional/qemu_test/utils.py | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/tests/functional/qemu_test/utils.py b/tests/functional/qemu_test/utils.py
index e7c8de81654..826c267785b 100644
--- a/tests/functional/qemu_test/utils.py
+++ b/tests/functional/qemu_test/utils.py
@@ -17,10 +17,10 @@ def get_usernet_hostfwd_port(vm):
     res = vm.cmd('human-monitor-command', command_line='info usernet')
     return get_info_usernet_hostfwd_port(res)
 
-"""
-Round up to next power of 2
-"""
 def pow2ceil(x):
+    """
+    Round up to next power of 2
+    """
     return 1 if x == 0 else 2**(x - 1).bit_length()
 
 def file_truncate(path, size):
@@ -28,12 +28,12 @@ def file_truncate(path, size):
         with open(path, 'ab+') as fd:
             fd.truncate(size)
 
-"""
-Expand file size to next power of 2
-"""
 def image_pow2ceil_expand(path):
-        size = os.path.getsize(path)
-        size_aligned = pow2ceil(size)
-        if size != size_aligned:
-            with open(path, 'ab+') as fd:
-                fd.truncate(size_aligned)
+    """
+    Expand file size to next power of 2
+    """
+    size = os.path.getsize(path)
+    size_aligned = pow2ceil(size)
+    if size != size_aligned:
+        with open(path, 'ab+') as fd:
+            fd.truncate(size_aligned)
-- 
2.51.0



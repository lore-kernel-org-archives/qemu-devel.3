Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AA3CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 09:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8yDx-0003Mc-TJ; Wed, 15 Oct 2025 05:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8yDw-0003M9-EV
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:55:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8yDs-0004cm-NW
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760522105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZWXP/RreoC01+qLMTmO6SZkRi9iXn9sDJnGu86rk9yQ=;
 b=WxrE5rrTkuqOuNjtQRn1MoppIMC0Dz74MsOJY5oXn2Efe5v2YHz5ZnvTGMiKE4UV7i68Uj
 ySixnmzVsCMc1PmDIrgQDfXyO5ZFZfsbV+jCxFnwzn8DiYHSUkyYRuH5aGblO0LWdaGjLF
 XnoYP+gguBcZf0wHu73rMfT9+/7oOTY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-06jXwHJDNqiqvhHll-Bcrg-1; Wed,
 15 Oct 2025 05:55:04 -0400
X-MC-Unique: 06jXwHJDNqiqvhHll-Bcrg-1
X-Mimecast-MFC-AGG-ID: 06jXwHJDNqiqvhHll-Bcrg_1760522103
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A9201956095; Wed, 15 Oct 2025 09:55:03 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.24])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D24FE180044F; Wed, 15 Oct 2025 09:55:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/6] tests/functional: Fix problems in linuxkerenl.py reported
 by pylint
Date: Wed, 15 Oct 2025 11:54:51 +0200
Message-ID: <20251015095454.1575318-4-thuth@redhat.com>
In-Reply-To: <20251015095454.1575318-1-thuth@redhat.com>
References: <20251015095454.1575318-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Thomas Huth <thuth@redhat.com>

Use proper indentation and lazy logging here.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/functional/qemu_test/linuxkernel.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/functional/qemu_test/linuxkernel.py b/tests/functional/qemu_test/linuxkernel.py
index 2aca0ee3cd0..a20278966be 100644
--- a/tests/functional/qemu_test/linuxkernel.py
+++ b/tests/functional/qemu_test/linuxkernel.py
@@ -24,12 +24,12 @@ def launch_kernel(self, kernel, initrd=None, dtb=None, console_index=0,
         self.vm.set_console(console_index=console_index)
         self.vm.add_args('-kernel', kernel)
         if initrd:
-                self.vm.add_args('-initrd', initrd)
+            self.vm.add_args('-initrd', initrd)
         if dtb:
-                self.vm.add_args('-dtb', dtb)
+            self.vm.add_args('-dtb', dtb)
         self.vm.launch()
         if wait_for:
-                self.wait_for_console_pattern(wait_for)
+            self.wait_for_console_pattern(wait_for)
 
     def check_http_download(self, filename, hashsum, guestport=8080,
                             pythoncmd='python3 -m http.server'):
@@ -39,7 +39,7 @@ def check_http_download(self, filename, hashsum, guestport=8080,
         hl = hashlib.sha256()
         hostport = get_usernet_hostfwd_port(self.vm)
         url = f'http://localhost:{hostport}{filename}'
-        self.log.info(f'Downloading {url} ...')
+        self.log.info('Downloading %s ...', url)
         with urllib.request.urlopen(url) as response:
             while True:
                 chunk = response.read(1 << 20)
@@ -48,5 +48,5 @@ def check_http_download(self, filename, hashsum, guestport=8080,
                 hl.update(chunk)
 
         digest = hl.hexdigest()
-        self.log.info(f'sha256sum of download is {digest}.')
+        self.log.info('sha256sum of download is %s.', digest)
         self.assertEqual(digest, hashsum)
-- 
2.51.0



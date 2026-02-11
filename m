Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC493ECD6C1
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 16:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqD9j-0005QA-W9; Wed, 11 Feb 2026 11:33:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vqD9i-0005PU-DH
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 11:33:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vqD9g-0003di-W7
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 11:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770827612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YoUohmHjGC6Kj0QBsBKyt2PLuXMEjlOnq6mLxFXPh6g=;
 b=PvqYtr3qcAmQYTwsvndkw5XXc2zkObhzozzPhpei5FSvmaDLXLjgD/eDtxfNSoxklGza0T
 f6Hh1DAKX6Jcz8THBsPNHE04dUqaWxnEMbq3lX7T3hQoXgg2jAtB40MZMbFyxmplpKfBKj
 9sEJwh920EIenT5Hcel4f/3STaMEB1g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-Q5WOyCdaNyG6C54iZZdfBg-1; Wed,
 11 Feb 2026 11:33:29 -0500
X-MC-Unique: Q5WOyCdaNyG6C54iZZdfBg-1
X-Mimecast-MFC-AGG-ID: Q5WOyCdaNyG6C54iZZdfBg_1770827608
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D626419560B3; Wed, 11 Feb 2026 16:33:27 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.45.227.9])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 455B019560A7; Wed, 11 Feb 2026 16:33:24 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 01/15] Revert "python/aqmp: fix send_fd_scm for python
 3.6.x"
Date: Wed, 11 Feb 2026 16:33:04 +0000
Message-ID: <20260211163318.938776-2-berrange@redhat.com>
In-Reply-To: <20260211163318.938776-1-berrange@redhat.com>
References: <20260211163318.938776-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This reverts commit a57cb3e23d5ac918a69d0aab918470ff0b429ff9.

The current code now only requires compatibility with Python
3.8 or later.

The conditional usage of 'sendmsg' on the async IO socket
wrapper will generate a deprecation warning on stderr
every time send_fd_scm is used with older Python versions.

This has the effect of breaking the QEMU I/O tests when run
on Python versions before the 'sendmsg' wrapper was removed.

Unconditionally accessing 'sock._sock' ensures we never use
the asyncio socket wrapper, and thus never risk triggering
deprecation warnings on any Python version

Most notably this fixes the QEMU block I/O tests on CentOS
Stream9 that use "sendmsg" for FD passing, which otherwise
generate deprecation messages breaking the expected output
comparison.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: John Snow <jsnow@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 python/qemu/qmp/qmp_client.py | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/python/qemu/qmp/qmp_client.py b/python/qemu/qmp/qmp_client.py
index 8beccfe29d..7a115b693b 100644
--- a/python/qemu/qmp/qmp_client.py
+++ b/python/qemu/qmp/qmp_client.py
@@ -720,12 +720,9 @@ def send_fd_scm(self, fd: int) -> None:
         if sock.family != socket.AF_UNIX:
             raise QMPError("Sending file descriptors requires a UNIX socket.")
 
-        if not hasattr(sock, 'sendmsg'):
-            # We need to void the warranty sticker.
-            # Access to sendmsg is scheduled for removal in Python 3.11.
-            # Find the real backing socket to use it anyway.
-            sock = sock._sock  # pylint: disable=protected-access
-
+        # Void the warranty sticker.
+        # Access to sendmsg in asyncio is scheduled for removal in Python 3.11.
+        sock = sock._sock  # pylint: disable=protected-access
         sock.sendmsg(
             [b' '],
             [(socket.SOL_SOCKET, socket.SCM_RIGHTS, struct.pack('@i', fd))]
-- 
2.53.0



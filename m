Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A24CF45C8
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 20:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfOiQ-00075o-NK; Mon, 12 Jan 2026 15:40:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vfOiP-00075Q-Kf
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 15:40:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vfOiO-0000kM-5v
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 15:40:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768250439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F/XVk7xO79WM0xuiBN1O3UY9ZGNz+SEwPoexHQYxLpg=;
 b=Y/DZIe82oWmTh5BWad3VCjIUnhMgLdV5F7he5sHf39FBEJHfadzmTU8Ynt0/B0xziQ9QoS
 ffVwtlAHamdRnWzgGcyJWc0TTEjGSG2H5VzSzlATKeO21S01nd8FLqaaL0r+iDKaCUuRvj
 D6a78xJu+5CL6RFnfUieAldX3kjT3j4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-jlPobdMLMuWDoF-AfXue0g-1; Mon,
 12 Jan 2026 15:40:35 -0500
X-MC-Unique: jlPobdMLMuWDoF-AfXue0g-1
X-Mimecast-MFC-AGG-ID: jlPobdMLMuWDoF-AfXue0g_1768250434
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F53A18005B7; Mon, 12 Jan 2026 20:40:34 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.178])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6C1D630001A2; Mon, 12 Jan 2026 20:40:31 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 01/13] Revert "python/aqmp: fix send_fd_scm for python
 3.6.x"
Date: Mon, 12 Jan 2026 20:40:14 +0000
Message-ID: <20260112204026.710659-2-berrange@redhat.com>
In-Reply-To: <20260112204026.710659-1-berrange@redhat.com>
References: <20260112204026.710659-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
2.52.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CB6CA100B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 05:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utfnw-0006uw-G1; Wed, 03 Sep 2025 01:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1utfmr-0006Gv-9p
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:12:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1utfmp-0006ZA-IB
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756876317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mW0ivbCeARcW77uG+hGeVTu54bG1KQkuvpiyp/K2kcE=;
 b=Uhr3GdmYzvyv64FQ8P3IoxgrTinwRTtnOR1F+xzhuNTDXZWUmhYZaNczComj5pVlA4X5ol
 3fUNX0q9Zr5stQ+LU6upLUMj3qJml3XTlvDstbPthlj7vr+r4lEtZNOkYuM9X2a8eabN4d
 8gP6LVvcpmL0TRwBoBfUWGfdrCWpNNw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-w0irFvrSPS6gWVlv4q6h5Q-1; Wed,
 03 Sep 2025 01:11:54 -0400
X-MC-Unique: w0irFvrSPS6gWVlv4q6h5Q-1
X-Mimecast-MFC-AGG-ID: w0irFvrSPS6gWVlv4q6h5Q_1756876313
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B723195608E; Wed,  3 Sep 2025 05:11:53 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 88F9619560B1; Wed,  3 Sep 2025 05:11:51 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Daniel=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 10/18] python: backport 'qmp-tui: Do not crash if optional
 dependencies are not met'
Date: Wed,  3 Sep 2025 01:11:16 -0400
Message-ID: <20250903051125.3020805-11-jsnow@redhat.com>
In-Reply-To: <20250903051125.3020805-1-jsnow@redhat.com>
References: <20250903051125.3020805-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Based on the discussion at https://github.com/pypa/pip/issues/9726 -
even though the setuptools documentation implies that it is possible to
guard script execution with optional dependency groups, this is not true
in practice with the scripts generated by pip.

Just do the simple thing and guard the import statements.

Signed-off-by: John Snow <jsnow@redhat.com>
cherry picked from commit df520dcacf9a75dd4c82ab1129768de4128b554c
Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/qmp/qmp_tui.py | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/python/qemu/qmp/qmp_tui.py b/python/qemu/qmp/qmp_tui.py
index 562be008d5e..53ea6c59a71 100644
--- a/python/qemu/qmp/qmp_tui.py
+++ b/python/qemu/qmp/qmp_tui.py
@@ -21,6 +21,7 @@
 import logging
 from logging import Handler, LogRecord
 import signal
+import sys
 from typing import (
     List,
     Optional,
@@ -30,10 +31,20 @@
     cast,
 )
 
-from pygments import lexers
-from pygments import token as Token
-import urwid
-import urwid_readline
+
+try:
+    from pygments import lexers
+    from pygments import token as Token
+    import urwid
+    import urwid_readline
+except ModuleNotFoundError as exc:
+    print(
+        f"Module '{exc.name}' not found.",
+        "You need the optional 'tui' group: pip install qemu.qmp[tui]",
+        sep='\n',
+        file=sys.stderr,
+    )
+    sys.exit(1)
 
 from .error import ProtocolError
 from .legacy import QEMUMonitorProtocol, QMPBadPortError
-- 
2.50.1



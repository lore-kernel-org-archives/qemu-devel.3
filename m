Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60149CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 20:31:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utB7p-0004Fm-BA; Mon, 01 Sep 2025 16:27:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1utB7n-0004EL-0i
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 16:27:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1utB7l-00007V-4o
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 16:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756758452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mW0ivbCeARcW77uG+hGeVTu54bG1KQkuvpiyp/K2kcE=;
 b=a/wwA1cyYtRNfQMDprrTSQjmkvUcbEI43o7q4AdqTREKkEZDlRQJCQH80cYXggSvDbUDlU
 4GWpSpJ5CKlayJwNw/21UJq1rTXvyF0w+nz6UZ2BPm4VRt8z4TdrFAfob/a+xe0lq3naf3
 4Yk/Uvi8/w1x+nXWTvjy/qd0PN/lNHk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-cH7OfPcEMbexJQsNkRTUEg-1; Mon,
 01 Sep 2025 16:27:30 -0400
X-MC-Unique: cH7OfPcEMbexJQsNkRTUEg-1
X-Mimecast-MFC-AGG-ID: cH7OfPcEMbexJQsNkRTUEg_1756758450
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14876180047F; Mon,  1 Sep 2025 20:27:30 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.85])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5079F19560AB; Mon,  1 Sep 2025 20:27:28 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 10/19] python: backport 'qmp-tui: Do not crash if optional
 dependencies are not met'
Date: Mon,  1 Sep 2025 16:26:52 -0400
Message-ID: <20250901202702.2971212-11-jsnow@redhat.com>
In-Reply-To: <20250901202702.2971212-1-jsnow@redhat.com>
References: <20250901202702.2971212-1-jsnow@redhat.com>
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



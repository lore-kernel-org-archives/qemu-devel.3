Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D84C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 03:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpfkg-0003hj-Uv; Tue, 04 Mar 2025 22:48:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfkW-0002kY-M0
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:48:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfkU-0006MY-1t
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:48:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741146525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7RoKJbqlQB3AZV623n4GqGylO66vrkMFX3kGFcnwnYw=;
 b=FCr+lpiXh2B0BlIVlen3stqKzJ9gyG2OxSVcb+Gn2qr/4C617LC2aILdO+8hAks3X9SUuA
 ziny4UkG+wqaK+mTp56Fa2pk7tEZNYKyVsZRDNXw6hOZjzDgeAEqFy2bNgpf5hdjuJMb/k
 Sw7Hvs6I/AO2TQsWN0aPMFLx5rgWy5w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-7NnxBmKoN8iQ4naF68p7Vg-1; Tue,
 04 Mar 2025 22:48:37 -0500
X-MC-Unique: 7NnxBmKoN8iQ4naF68p7Vg-1
X-Mimecast-MFC-AGG-ID: 7NnxBmKoN8iQ4naF68p7Vg_1741146516
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39E9E1800262; Wed,  5 Mar 2025 03:48:36 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.45])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AAB941956095; Wed,  5 Mar 2025 03:48:32 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 38/57] docs/qapidoc: add visit_module() method
Date: Tue,  4 Mar 2025 22:45:47 -0500
Message-ID: <20250305034610.960147-39-jsnow@redhat.com>
In-Reply-To: <20250305034610.960147-1-jsnow@redhat.com>
References: <20250305034610.960147-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This method annotates the start of a new module, crediting the source
location to the first line of the module file.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index c243bb6faaa..6de8c900543 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -28,6 +28,7 @@
 
 from contextlib import contextmanager
 import os
+from pathlib import Path
 import sys
 from typing import TYPE_CHECKING
 
@@ -121,6 +122,14 @@ def ensure_blank_line(self) -> None:
             # +2: correct for zero/one index, then increment by one.
             self.add_line_raw("", fname, line + 2)
 
+    # Transmogrification core methods
+
+    def visit_module(self, path: str) -> None:
+        name = Path(path).stem
+        # module directives are credited to the first line of a module file.
+        self.add_line_raw(f".. qapi:module:: {name}", path, 1)
+        self.ensure_blank_line()
+
 
 class QAPISchemaGenDepVisitor(QAPISchemaVisitor):
     """A QAPI schema visitor which adds Sphinx dependencies each module
-- 
2.48.1



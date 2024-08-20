Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4825C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 00:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgCfC-0006op-K4; Mon, 19 Aug 2024 20:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sgCf1-0005y9-Ad
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 20:23:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sgCez-0003sp-CW
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 20:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724113420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bihOoSkwA1O6zLvD7UvAJE+9N3HlxTZKpPu6NWV7caA=;
 b=VXA8ImMdkrwEeeNTvjKiXYcZ8/Y9F6C2KP6BexcYcxCcxcNg72/UZNgUM2JUB6F3dpzkV+
 E8wbkFXstCZtPInaTOGEjIROc33q+rKQ4kt1kvTVBkKlkE//XhKH+unDXZ/Js73qCcnYDj
 05Vx2ja7GZmtIeo8f2jlB4qvOjKDm9Q=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-fABkUriQPhi2uGZXnJIoKg-1; Mon,
 19 Aug 2024 20:23:36 -0400
X-MC-Unique: fABkUriQPhi2uGZXnJIoKg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 967191954B23; Tue, 20 Aug 2024 00:23:35 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.8.20])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3333419560A3; Tue, 20 Aug 2024 00:23:33 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Beraldo Leal <bleal@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/8] python/qapi: ignore missing docstrings in pylint
Date: Mon, 19 Aug 2024 20:23:14 -0400
Message-ID: <20240820002318.1380276-6-jsnow@redhat.com>
In-Reply-To: <20240820002318.1380276-1-jsnow@redhat.com>
References: <20240820002318.1380276-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.134,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Maybe temporary, I am not sure. Instead of disabling docstring checking
*globally* for all of our python files, just disable it for QAPI
modules.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/commands.py   | 2 ++
 scripts/qapi/common.py     | 2 ++
 scripts/qapi/events.py     | 2 ++
 scripts/qapi/expr.py       | 2 ++
 scripts/qapi/gen.py        | 2 ++
 scripts/qapi/introspect.py | 2 ++
 scripts/qapi/main.py       | 2 ++
 scripts/qapi/parser.py     | 2 ++
 scripts/qapi/schema.py     | 2 +-
 scripts/qapi/source.py     | 2 ++
 scripts/qapi/types.py      | 2 ++
 scripts/qapi/visit.py      | 2 ++
 12 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index cffed6cd3ba..b01de93c965 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -13,6 +13,8 @@
 See the COPYING file in the top-level directory.
 """
 
+# pylint: disable=missing-docstring
+
 from typing import (
     Dict,
     List,
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 444b3acf53a..918a1ab728a 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -11,6 +11,8 @@
 # This work is licensed under the terms of the GNU GPL, version 2.
 # See the COPYING file in the top-level directory.
 
+# pylint: disable=missing-docstring
+
 import re
 import sys
 from typing import (
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index 36dc0c50c78..9ab9ff4e695 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -12,6 +12,8 @@
 See the COPYING file in the top-level directory.
 """
 
+# pylint: disable=missing-docstring
+
 from typing import List, Optional
 
 from .common import c_enum_const, c_name, mcgen
diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index f60e580dd36..c137dcf950a 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -13,6 +13,8 @@
 # This work is licensed under the terms of the GNU GPL, version 2.
 # See the COPYING file in the top-level directory.
 
+# pylint: disable=missing-docstring
+
 """
 Normalize and validate (context-free) QAPI schema expression structures.
 
diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index ce94aee8e70..f869c751e53 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -11,6 +11,8 @@
 # This work is licensed under the terms of the GNU GPL, version 2.
 # See the COPYING file in the top-level directory.
 
+# pylint: disable=missing-docstring
+
 from contextlib import contextmanager
 import os
 import re
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 9d499f90b7c..44edc42d18b 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -11,6 +11,8 @@
 See the COPYING file in the top-level directory.
 """
 
+# pylint: disable=missing-docstring
+
 from typing import (
     Any,
     Dict,
diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
index 316736b6a29..24ffa15aa2c 100644
--- a/scripts/qapi/main.py
+++ b/scripts/qapi/main.py
@@ -7,6 +7,8 @@
 This is the main entry point for generating C code from the QAPI schema.
 """
 
+# pylint: disable=missing-docstring
+
 import argparse
 import sys
 from typing import Optional
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 9bb039fe8d3..9113c9d1506 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -14,6 +14,8 @@
 # This work is licensed under the terms of the GNU GPL, version 2.
 # See the COPYING file in the top-level directory.
 
+# pylint: disable=missing-docstring
+
 from collections import OrderedDict
 import os
 import re
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index d65c35f6ee6..a06b3e30ffd 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -12,7 +12,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2.
 # See the COPYING file in the top-level directory.
 
-# pylint: disable=too-many-lines
+# pylint: disable=too-many-lines, missing-docstring
 
 # TODO catching name collisions in generated code would be nice
 
diff --git a/scripts/qapi/source.py b/scripts/qapi/source.py
index 7b379fdc925..ad7f4e1a0e5 100644
--- a/scripts/qapi/source.py
+++ b/scripts/qapi/source.py
@@ -9,6 +9,8 @@
 # This work is licensed under the terms of the GNU GPL, version 2.
 # See the COPYING file in the top-level directory.
 
+# pylint: disable=missing-docstring
+
 import copy
 from typing import List, Optional, TypeVar
 
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 0dd0b00ada3..abba5983870 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -13,6 +13,8 @@
 # See the COPYING file in the top-level directory.
 """
 
+# pylint: disable=missing-docstring
+
 from typing import List, Optional
 
 from .common import c_enum_const, c_name, mcgen
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 20ce6be9978..851f3b01e97 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -13,6 +13,8 @@
 See the COPYING file in the top-level directory.
 """
 
+# pylint: disable=missing-docstring
+
 from typing import List, Optional
 
 from .common import (
-- 
2.45.0



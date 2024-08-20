Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B145C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 00:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgCes-0005N9-HK; Mon, 19 Aug 2024 20:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sgCeq-0005BZ-DL
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 20:23:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sgCeo-0003ri-Rw
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 20:23:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724113410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uq0gvW6lhA9f5naE5+wCuwIJeRf8GGxda2e3fpP9QGY=;
 b=CRdIMNSaa+UucIzOgHsCb/LEBchLgrDsyLhRo+eIITAHVbrSOYuCTLhS2cAwiMOAa+P78v
 PzCzNZBkwTmxqmdaI6iBQgPMP2AT+GCeFK16aNO8Wllev8cN2qigi4V03IqGkwVFBQwLya
 0BjUw6Mf3dURAkRfeho86zjrc3o4WyA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-k59HPmzPM6y6AViAG_Jc2w-1; Mon,
 19 Aug 2024 20:23:27 -0400
X-MC-Unique: k59HPmzPM6y6AViAG_Jc2w-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E58951955BFA; Tue, 20 Aug 2024 00:23:24 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.8.20])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D5BDE19560A3; Tue, 20 Aug 2024 00:23:21 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Beraldo Leal <bleal@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/8] python/qapi: correct re.Match type hints for 3.13
Date: Mon, 19 Aug 2024 20:23:10 -0400
Message-ID: <20240820002318.1380276-2-jsnow@redhat.com>
In-Reply-To: <20240820002318.1380276-1-jsnow@redhat.com>
References: <20240820002318.1380276-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.134,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

typing.Match was removed in Python 3.13, so we need to use re.Match
instead. However, Python 3.8 doesn't support using re.Match as a type
hint directly, so we need a conditional for now.

The import is written oddly so that "Match" is explicitly re-exported
for re-use by other modules. mypy will complain otherwise.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/common.py | 10 +++++++++-
 scripts/qapi/parser.py |  3 +--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 737b059e629..444b3acf53a 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -12,16 +12,24 @@
 # See the COPYING file in the top-level directory.
 
 import re
+import sys
 from typing import (
     Any,
     Dict,
-    Match,
     Optional,
     Sequence,
     Union,
 )
 
 
+if sys.version_info < (3, 9):
+    # typing.Match was removed in 3.13,
+    # but it's still a necessity in 3.8.
+    from typing import \
+        Match as Match  # pylint: disable=useless-import-alias
+else:
+    Match = re.Match
+
 #: Magic string that gets removed along with all space to its right.
 EATSPACE = '\033EATSPACE.'
 POINTER_SUFFIX = ' *' + EATSPACE
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index adc85b5b394..9a42b119131 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -23,13 +23,12 @@
     Dict,
     List,
     Mapping,
-    Match,
     Optional,
     Set,
     Union,
 )
 
-from .common import must_match
+from .common import Match, must_match
 from .error import QAPISemError, QAPISourceError
 from .source import QAPISourceInfo
 
-- 
2.45.0



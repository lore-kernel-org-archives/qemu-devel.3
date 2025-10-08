Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 337F3CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 06:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6NmS-0004pm-Kx; Wed, 08 Oct 2025 02:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6NmK-0004oZ-J6
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:36:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6NmI-0004S4-JE
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759905358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3cwybQWeOVekMowd6nzUZpKOolU3NmN6Sld7UV53eoI=;
 b=gzevtS0j77+adBnSDh1mNrewHsqWb3yPgK0HLvVyMnYztgXh2wA7hqZsDnFxHgNovVZdPT
 BvG5mtEObmNO6bKmf2PCAAeEO/RQFHT9ulurpZzCeRLrh+W4qbXqCx/MVWq8SRitp4EHVl
 lr8cWbHL8BtIMUrAlJVFSTxHWqmmmqo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-kEB1Vpu6PMGT2BwuOo0RxQ-1; Wed, 08 Oct 2025 02:35:56 -0400
X-MC-Unique: kEB1Vpu6PMGT2BwuOo0RxQ-1
X-Mimecast-MFC-AGG-ID: kEB1Vpu6PMGT2BwuOo0RxQ_1759905355
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b3f2cfc26edso646080066b.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 23:35:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759905354; x=1760510154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3cwybQWeOVekMowd6nzUZpKOolU3NmN6Sld7UV53eoI=;
 b=wVbLXkcwO0LqsWQFkjSHESp31aE1jid9O4V+R7CZBIw66sfi9Ew7KvTo7WPQfJSZIZ
 JvHoSsNIbBvyoFubDKBlsLv+gQq855I20WKYlUVkGFk9lIiCgnc/02SFaCf/Oyh5GjKc
 iE4bnoOMME5AsoLqElIEvwQNcthe6PLh4ZTYKLjIDO4/OhGSEGo6lSTXkAx+k4LkV7Er
 si6R9jAjsCZunIYYWoPJFK1+V9nxODM9SzqU6GBv6dboC4zVlx7st2+PrWfz8xfsn1Mo
 C4GqMw1HQEUTm1E57wRyNRl72thoNtsPZb6+dRoUBYcK/Vh3rz+0yymlA/53712CfAOa
 ELeg==
X-Gm-Message-State: AOJu0YxUmyXtMC7thKVR8EaiWieDUI4KnE5INPF/ulI2wl8KiXUvhZU0
 LMCmqgHa2pIzhUUHLQmRaQAWG3I5hTe+KNrQwiWSNnMAnotbNoKD/6drRuJN6CXNZeTJHnxRktg
 HYm8x3ztYQYZKqdl2hJoN7OhRV/p6GUcMxpK1QoPpmllfR/vZ2SAuAtrdFWTm0Bqhvv7mZhlYQ+
 MXssO/BiF9IKYlnLAAB0EIeiVeRAvwJPfAB+cELJ08
X-Gm-Gg: ASbGncvqZPtYUEzcSb/pqO9aEt8/PNoyt5xkTWvbVsu42qY2E+MH5alPju7GI4YJnF8
 G7ywvqZ5rtycMea3WjbVF47Paz0vo/cU2U6LFiEeFOupYTVx30AsPG/8Fr25hh1nB6rmTj2+dUY
 2HFHaAOAdr2DkLX19GfNCZK2m5R2SXzPVBN/aP0EL65brH6lD54Dg/UEXTNTyeizXAZcOJFg9H6
 KOq0e4azt7XyHHOL7ncJOqYyqQQyS3f1OSn4bIfynsMBkg231SEm/H7aWwtddU7y6zl8FDjPSrY
 6llezUkffs5TuxeQ3NWDOudNgB3hEM/FVvBO7nY8vzqB4D1CH6YLeZiSmW7fJiIC1x+ec/u+v4U
 qWZTpfYm87VAFaEIf8nePUAkxQ8qDxMKegqHAc+8Xl++8M7JU
X-Received: by 2002:a17:907:26c8:b0:b3d:30d8:b8a0 with SMTP id
 a640c23a62f3a-b50ac5d1de5mr257002266b.52.1759905354267; 
 Tue, 07 Oct 2025 23:35:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB2Ssw42h8jtaQ+6Jtt9apt0oZGHMU8EPB8qDaPBUnGfShsEy2JATEFPUXyJIfK4sxnkhFMw==
X-Received: by 2002:a17:907:26c8:b0:b3d:30d8:b8a0 with SMTP id
 a640c23a62f3a-b50ac5d1de5mr256999666b.52.1759905353852; 
 Tue, 07 Oct 2025 23:35:53 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b486970a786sm1629156566b.46.2025.10.07.23.35.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 23:35:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH 2/6] tracetool: apply isort and add check
Date: Wed,  8 Oct 2025 08:35:41 +0200
Message-ID: <20251008063546.376603-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008063546.376603-1-pbonzini@redhat.com>
References: <20251008063546.376603-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Sort imports automatically, to keep the coding style more uniform.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/tests/tracetool-isort.sh      | 4 ++++
 scripts/tracetool.py                 | 5 ++---
 scripts/tracetool/backend/dtrace.py  | 1 -
 scripts/tracetool/backend/ftrace.py  | 3 +--
 scripts/tracetool/backend/log.py     | 3 +--
 scripts/tracetool/backend/simple.py  | 1 -
 scripts/tracetool/backend/syslog.py  | 3 +--
 scripts/tracetool/backend/ust.py     | 1 -
 scripts/tracetool/format/d.py        | 2 +-
 scripts/tracetool/format/log_stap.py | 1 -
 scripts/tracetool/format/stap.py     | 1 -
 11 files changed, 10 insertions(+), 15 deletions(-)
 create mode 100755 python/tests/tracetool-isort.sh

diff --git a/python/tests/tracetool-isort.sh b/python/tests/tracetool-isort.sh
new file mode 100755
index 00000000000..b23f3d48448
--- /dev/null
+++ b/python/tests/tracetool-isort.sh
@@ -0,0 +1,4 @@
+#!/bin/sh -e
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+python3 -m isort --sp . -c ../scripts/tracetool/
diff --git a/scripts/tracetool.py b/scripts/tracetool.py
index 0fdc9cb9477..22fdc29e01f 100755
--- a/scripts/tracetool.py
+++ b/scripts/tracetool.py
@@ -12,13 +12,12 @@
 __email__      = "stefanha@redhat.com"
 
 
-import sys
 import getopt
+import sys
 
-from tracetool import error_write, out, out_open
 import tracetool.backend
 import tracetool.format
-
+from tracetool import error_write, out, out_open
 
 _SCRIPT = ""
 
diff --git a/scripts/tracetool/backend/dtrace.py b/scripts/tracetool/backend/dtrace.py
index b4af403025c..0fbd98ee91b 100644
--- a/scripts/tracetool/backend/dtrace.py
+++ b/scripts/tracetool/backend/dtrace.py
@@ -14,7 +14,6 @@
 
 from tracetool import out
 
-
 PUBLIC = True
 
 
diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
index e03698a2edf..0d77bd23a51 100644
--- a/scripts/tracetool/backend/ftrace.py
+++ b/scripts/tracetool/backend/ftrace.py
@@ -12,8 +12,7 @@
 __email__      = "stefanha@redhat.com"
 
 
-from tracetool import out, expand_format_string
-
+from tracetool import expand_format_string, out
 
 PUBLIC = True
 CHECK_TRACE_EVENT_GET_STATE = True
diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index 9e3e5046f5f..bbfb56911d9 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -12,8 +12,7 @@
 __email__      = "stefanha@redhat.com"
 
 
-from tracetool import out, expand_format_string
-
+from tracetool import expand_format_string, out
 
 PUBLIC = True
 CHECK_TRACE_EVENT_GET_STATE = True
diff --git a/scripts/tracetool/backend/simple.py b/scripts/tracetool/backend/simple.py
index b131e4fc194..b67257ce7e9 100644
--- a/scripts/tracetool/backend/simple.py
+++ b/scripts/tracetool/backend/simple.py
@@ -14,7 +14,6 @@
 
 from tracetool import out
 
-
 PUBLIC = True
 CHECK_TRACE_EVENT_GET_STATE = True
 
diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/backend/syslog.py
index 12b826593db..c3efab036cf 100644
--- a/scripts/tracetool/backend/syslog.py
+++ b/scripts/tracetool/backend/syslog.py
@@ -12,8 +12,7 @@
 __email__      = "stefanha@redhat.com"
 
 
-from tracetool import out, expand_format_string
-
+from tracetool import expand_format_string, out
 
 PUBLIC = True
 CHECK_TRACE_EVENT_GET_STATE = True
diff --git a/scripts/tracetool/backend/ust.py b/scripts/tracetool/backend/ust.py
index 3aa9bb1da29..a70e3d83e1d 100644
--- a/scripts/tracetool/backend/ust.py
+++ b/scripts/tracetool/backend/ust.py
@@ -14,7 +14,6 @@
 
 from tracetool import out
 
-
 PUBLIC = True
 
 
diff --git a/scripts/tracetool/format/d.py b/scripts/tracetool/format/d.py
index e9e33dfe30a..0befd444e82 100644
--- a/scripts/tracetool/format/d.py
+++ b/scripts/tracetool/format/d.py
@@ -12,9 +12,9 @@
 __email__      = "stefanha@redhat.com"
 
 
-from tracetool import out
 from sys import platform
 
+from tracetool import out
 
 # Reserved keywords from
 # https://wikis.oracle.com/display/DTrace/Types,+Operators+and+Expressions
diff --git a/scripts/tracetool/format/log_stap.py b/scripts/tracetool/format/log_stap.py
index 259303a189d..99c6181f389 100644
--- a/scripts/tracetool/format/log_stap.py
+++ b/scripts/tracetool/format/log_stap.py
@@ -18,7 +18,6 @@
 from tracetool.backend.simple import is_string
 from tracetool.format.stap import stap_escape
 
-
 STATE_SKIP = 0
 STATE_LITERAL = 1
 STATE_MACRO = 2
diff --git a/scripts/tracetool/format/stap.py b/scripts/tracetool/format/stap.py
index 285c9203ba7..f917bd7545d 100644
--- a/scripts/tracetool/format/stap.py
+++ b/scripts/tracetool/format/stap.py
@@ -15,7 +15,6 @@
 from tracetool import out
 from tracetool.backend.dtrace import binary, probeprefix
 
-
 # Technically 'self' is not used by systemtap yet, but
 # they recommended we keep it in the reserved list anyway
 RESERVED_WORDS = (
-- 
2.51.0



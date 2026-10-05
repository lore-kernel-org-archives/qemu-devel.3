Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D168DCA5FF5
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 12:11:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDhXc-0000Fn-E6; Mon, 05 Oct 2026 08:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xDhVY-00065n-N5
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 08:09:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xDhVX-0004kL-6T
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 08:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791202166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8QAy4v1uDsaW1jXNef0N/kSUwVVGFwuEViT3sCjXjt0=;
 b=BUmczZCLKQ1xnJiZhuOlLKUbgz+4WjzC/shlM6vAuYqjv6uWmWGxRiaPdvwnBX/gvSLLZp
 ZO9OG688TwPywjxq/s1nPyuJpqE5FgZpmRv4U4ohdjwt2CAWS4uAuiqoKuqzfm3ZSuV8uK
 2QUMxi4XLHM5zTXWALiD41yaQimHP5E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-l1cw23vcO1OyIqPFO3smLQ-1; Mon,
 05 Oct 2026 08:09:23 -0400
X-MC-Unique: l1cw23vcO1OyIqPFO3smLQ-1
X-Mimecast-MFC-AGG-ID: l1cw23vcO1OyIqPFO3smLQ_1791202162
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE2C61953990; Mon,  5 Oct 2026 12:09:21 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 83FCC3001D2A; Mon,  5 Oct 2026 12:09:20 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 13/24] trace: remove redundant headers from simple trace
 backend code
Date: Mon,  5 Oct 2026 13:08:44 +0100
Message-ID: <20261005120855.421973-14-berrange@redhat.com>
In-Reply-To: <20261005120855.421973-1-berrange@redhat.com>
References: <20261005120855.421973-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The main formatter for .h/.c files for generated trace code
already includes osdep.h and control.h, so it is redundant
for the simple trace backend to add them too.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/tracetool/backend/simple.py | 4 +---
 tests/tracetool/all.c               | 2 --
 tests/tracetool/simple.c            | 2 --
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/scripts/tracetool/backend/simple.py b/scripts/tracetool/backend/simple.py
index b131e4fc194..e22683c7d2a 100644
--- a/scripts/tracetool/backend/simple.py
+++ b/scripts/tracetool/backend/simple.py
@@ -48,9 +48,7 @@ def generate_h_backend_dstate(event, group):
 
 
 def generate_c_begin(events, group):
-    out('#include "qemu/osdep.h"',
-        '#include "trace/control.h"',
-        '#include "trace/simple.h"',
+    out('#include "trace/simple.h"',
         '')
 
 
diff --git a/tests/tracetool/all.c b/tests/tracetool/all.c
index 820ddb575b0..3b8d4d32d17 100644
--- a/tests/tracetool/all.c
+++ b/tests/tracetool/all.c
@@ -34,8 +34,6 @@ static void trace_testsuite_register_events(void)
     trace_event_register_group(testsuite_trace_events);
 }
 trace_init(trace_testsuite_register_events)
-#include "qemu/osdep.h"
-#include "trace/control.h"
 #include "trace/simple.h"
 
 void _simple_trace_test_blah(void *context, const char *filename)
diff --git a/tests/tracetool/simple.c b/tests/tracetool/simple.c
index 820ddb575b0..3b8d4d32d17 100644
--- a/tests/tracetool/simple.c
+++ b/tests/tracetool/simple.c
@@ -34,8 +34,6 @@ static void trace_testsuite_register_events(void)
     trace_event_register_group(testsuite_trace_events);
 }
 trace_init(trace_testsuite_register_events)
-#include "qemu/osdep.h"
-#include "trace/control.h"
 #include "trace/simple.h"
 
 void _simple_trace_test_blah(void *context, const char *filename)
-- 
2.55.0



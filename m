Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7DE6070303
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 20:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Sys5afgd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOhRW-00072l-VU; Wed, 04 Nov 2026 15:18:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xOhRM-0006zC-0w
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 15:18:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xOhRK-00066z-Eb
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 15:18:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793823513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gkkz7NQLFS94E1ZeoUXFtFHJe+s6Qg+c1y84IQKKE4k=;
 b=Sys5afgdNy4IFpBCjmgfoplsc2g5uw0vwptSnc9RT19Spaqr28MF9Q3LftnXN0nWkbIG6S
 M01yW8g/3i4O41UUmjXDK3/q3lfhtdgp+a0R0geXzsdzaEQQcIQSLON5GpvgeEQBnVwSKC
 Ozz8/g5finnhpv8kAxe1imRN64CCISs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-463-OrIPcHMtNfWaL90iiMEVww-1; Wed,
 04 Nov 2026 15:18:29 -0500
X-MC-Unique: OrIPcHMtNfWaL90iiMEVww-1
X-Mimecast-MFC-AGG-ID: OrIPcHMtNfWaL90iiMEVww_1793823507
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 521391800596; Wed,  4 Nov 2026 20:18:27 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 591BD39206; Wed,  4 Nov 2026 20:18:26 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, xen-devel@lists.xenproject.org,
 qemu-ppc@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL v2 13/25] trace: remove redundant headers from simple trace
 backend code
Date: Wed,  4 Nov 2026 15:17:49 -0500
Message-ID: <20261104201802.11556-14-stefanha@redhat.com>
In-Reply-To: <20261104201802.11556-1-stefanha@redhat.com>
References: <20261104201802.11556-1-stefanha@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daniel P. Berrangé <berrange@redhat.com>

The main formatter for .h/.c files for generated trace code
already includes osdep.h and control.h, so it is redundant
for the simple trace backend to add them too.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20261102142844.3464712-14-berrange@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/tracetool/all.c               | 2 --
 tests/tracetool/simple.c            | 2 --
 scripts/tracetool/backend/simple.py | 4 +---
 3 files changed, 1 insertion(+), 7 deletions(-)

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
 
 
-- 
2.56.0



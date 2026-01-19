Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD7E1D29C4D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 19:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhucL-0002CW-Rf; Mon, 19 Jan 2026 14:08:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vhuc9-00023b-Cd
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:08:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vhuc6-0000uR-PN
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 14:08:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768849714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iDD3m9+6vrdoCwdV9CML/lAYXwH542ggYVyS9HO3KmE=;
 b=AnbrZ6J08ZjYyaQzNotn7VUdGkNGpJAL5e85DHFt9/KgemErGRV+oBX4OgXrZdKRou7KsX
 9wTdvsudgYsRgehfOu1wkN612YITZXjyI9NsXFoOoMWfl/0lW3kim2JNCi/S+5vjWUlkQ6
 JbBDBxPyEabiePZc5AqCX2slzCf3ZLw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-j0iQmdHiMWWjDGRu-SmYiA-1; Mon,
 19 Jan 2026 14:08:32 -0500
X-MC-Unique: j0iQmdHiMWWjDGRu-SmYiA-1
X-Mimecast-MFC-AGG-ID: j0iQmdHiMWWjDGRu-SmYiA_1768849711
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EB92195608E; Mon, 19 Jan 2026 19:08:31 +0000 (UTC)
Received: from localhost (unknown [10.2.16.150])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D3C2119560AB; Mon, 19 Jan 2026 19:08:30 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Richard Henderson <rth@twiddle.net>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 3/8] tracetool: "import annotations"
Date: Mon, 19 Jan 2026 14:08:18 -0500
Message-ID: <20260119190823.867761-4-stefanha@redhat.com>
In-Reply-To: <20260119190823.867761-1-stefanha@redhat.com>
References: <20260119190823.867761-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

In preparations for adding type annotations, make Python process them lazily.

This avoids the need to express some annotations as strings.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20251008063546.376603-4-pbonzini@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 scripts/tracetool.py                         | 2 ++
 scripts/tracetool/__init__.py                | 2 ++
 scripts/tracetool/backend/__init__.py        | 2 ++
 scripts/tracetool/backend/dtrace.py          | 2 ++
 scripts/tracetool/backend/ftrace.py          | 2 ++
 scripts/tracetool/backend/log.py             | 2 ++
 scripts/tracetool/backend/simple.py          | 2 ++
 scripts/tracetool/backend/syslog.py          | 2 ++
 scripts/tracetool/backend/ust.py             | 2 ++
 scripts/tracetool/format/__init__.py         | 2 ++
 scripts/tracetool/format/c.py                | 2 ++
 scripts/tracetool/format/d.py                | 2 ++
 scripts/tracetool/format/h.py                | 2 ++
 scripts/tracetool/format/log_stap.py         | 2 ++
 scripts/tracetool/format/rs.py               | 2 ++
 scripts/tracetool/format/simpletrace_stap.py | 2 ++
 scripts/tracetool/format/stap.py             | 2 ++
 scripts/tracetool/format/ust_events_c.py     | 2 ++
 scripts/tracetool/format/ust_events_h.py     | 2 ++
 19 files changed, 38 insertions(+)

diff --git a/scripts/tracetool.py b/scripts/tracetool.py
index 22fdc29e01..390f1a371b 100755
--- a/scripts/tracetool.py
+++ b/scripts/tracetool.py
@@ -4,6 +4,8 @@
 Command-line wrapper for the tracetool machinery.
 """
 
+from __future__ import annotations
+
 __author__     = "Lluís Vilanova <vilanova@ac.upc.edu>"
 __copyright__  = "Copyright 2012-2014, Lluís Vilanova <vilanova@ac.upc.edu>"
 __license__    = "GPL version 2 or (at your option) any later version"
diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index fab98bf67e..0316f3f852 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -4,6 +4,8 @@
 Machinery for generating tracing-related intermediate files.
 """
 
+from __future__ import annotations
+
 __author__     = "Lluís Vilanova <vilanova@ac.upc.edu>"
 __copyright__  = "Copyright 2012-2017, Lluís Vilanova <vilanova@ac.upc.edu>"
 __license__    = "GPL version 2 or (at your option) any later version"
diff --git a/scripts/tracetool/backend/__init__.py b/scripts/tracetool/backend/__init__.py
index 9109a783c7..8cc9c82138 100644
--- a/scripts/tracetool/backend/__init__.py
+++ b/scripts/tracetool/backend/__init__.py
@@ -49,6 +49,8 @@
 
 """
 
+from __future__ import annotations
+
 __author__     = "Lluís Vilanova <vilanova@ac.upc.edu>"
 __copyright__  = "Copyright 2012-2014, Lluís Vilanova <vilanova@ac.upc.edu>"
 __license__    = "GPL version 2 or (at your option) any later version"
diff --git a/scripts/tracetool/backend/dtrace.py b/scripts/tracetool/backend/dtrace.py
index 5f313ddaed..c21a04c653 100644
--- a/scripts/tracetool/backend/dtrace.py
+++ b/scripts/tracetool/backend/dtrace.py
@@ -4,6 +4,8 @@
 DTrace/SystemTAP backend.
 """
 
+from __future__ import annotations
+
 __author__     = "Lluís Vilanova <vilanova@ac.upc.edu>"
 __copyright__  = "Copyright 2012-2017, Lluís Vilanova <vilanova@ac.upc.edu>"
 __license__    = "GPL version 2 or (at your option) any later version"
diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
index 0d77bd23a5..40bb323f5e 100644
--- a/scripts/tracetool/backend/ftrace.py
+++ b/scripts/tracetool/backend/ftrace.py
@@ -4,6 +4,8 @@
 Ftrace built-in backend.
 """
 
+from __future__ import annotations
+
 __author__     = "Eiichi Tsukata <eiichi.tsukata.xh@hitachi.com>"
 __copyright__  = "Copyright (C) 2013 Hitachi, Ltd."
 __license__    = "GPL version 2 or (at your option) any later version"
diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index bbfb56911d..d346a19e40 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -4,6 +4,8 @@
 Stderr built-in backend.
 """
 
+from __future__ import annotations
+
 __author__     = "Lluís Vilanova <vilanova@ac.upc.edu>"
 __copyright__  = "Copyright 2012-2017, Lluís Vilanova <vilanova@ac.upc.edu>"
 __license__    = "GPL version 2 or (at your option) any later version"
diff --git a/scripts/tracetool/backend/simple.py b/scripts/tracetool/backend/simple.py
index b67257ce7e..9c691dc231 100644
--- a/scripts/tracetool/backend/simple.py
+++ b/scripts/tracetool/backend/simple.py
@@ -4,6 +4,8 @@
 Simple built-in backend.
 """
 
+from __future__ import annotations
+
 __author__     = "Lluís Vilanova <vilanova@ac.upc.edu>"
 __copyright__  = "Copyright 2012-2017, Lluís Vilanova <vilanova@ac.upc.edu>"
 __license__    = "GPL version 2 or (at your option) any later version"
diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/backend/syslog.py
index c3efab036c..9311453c5a 100644
--- a/scripts/tracetool/backend/syslog.py
+++ b/scripts/tracetool/backend/syslog.py
@@ -4,6 +4,8 @@
 Syslog built-in backend.
 """
 
+from __future__ import annotations
+
 __author__     = "Paul Durrant <paul.durrant@citrix.com>"
 __copyright__  = "Copyright 2016, Citrix Systems Inc."
 __license__    = "GPL version 2 or (at your option) any later version"
diff --git a/scripts/tracetool/backend/ust.py b/scripts/tracetool/backend/ust.py
index a70e3d83e1..f227072512 100644
--- a/scripts/tracetool/backend/ust.py
+++ b/scripts/tracetool/backend/ust.py
@@ -4,6 +4,8 @@
 LTTng User Space Tracing backend.
 """
 
+from __future__ import annotations
+
 __author__     = "Lluís Vilanova <vilanova@ac.upc.edu>"
 __copyright__  = "Copyright 2012-2017, Lluís Vilanova <vilanova@ac.upc.edu>"
 __license__    = "GPL version 2 or (at your option) any later version"
diff --git a/scripts/tracetool/format/__init__.py b/scripts/tracetool/format/__init__.py
index 7b9d1b5782..4c606d5757 100644
--- a/scripts/tracetool/format/__init__.py
+++ b/scripts/tracetool/format/__init__.py
@@ -27,6 +27,8 @@
 
 """
 
+from __future__ import annotations
+
 __author__     = "Lluís Vilanova <vilanova@ac.upc.edu>"
 __copyright__  = "Copyright 2012-2014, Lluís Vilanova <vilanova@ac.upc.edu>"
 __license__    = "GPL version 2 or (at your option) any later version"
diff --git a/scripts/tracetool/format/c.py b/scripts/tracetool/format/c.py
index 50e03313cb..5b3459f2be 100644
--- a/scripts/tracetool/format/c.py
+++ b/scripts/tracetool/format/c.py
@@ -4,6 +4,8 @@
 trace/generated-tracers.c
 """
 
+from __future__ import annotations
+
 __author__     = "Lluís Vilanova <vilanova@ac.upc.edu>"
 __copyright__  = "Copyright 2012-2014, Lluís Vilanova <vilanova@ac.upc.edu>"
 __license__    = "GPL version 2 or (at your option) any later version"
diff --git a/scripts/tracetool/format/d.py b/scripts/tracetool/format/d.py
index 0befd444e8..dda80eeb76 100644
--- a/scripts/tracetool/format/d.py
+++ b/scripts/tracetool/format/d.py
@@ -4,6 +4,8 @@
 trace/generated-tracers.dtrace (DTrace only).
 """
 
+from __future__ import annotations
+
 __author__     = "Lluís Vilanova <vilanova@ac.upc.edu>"
 __copyright__  = "Copyright 2012-2014, Lluís Vilanova <vilanova@ac.upc.edu>"
 __license__    = "GPL version 2 or (at your option) any later version"
diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
index dd58713a15..d04cabc63e 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -4,6 +4,8 @@
 trace/generated-tracers.h
 """
 
+from __future__ import annotations
+
 __author__     = "Lluís Vilanova <vilanova@ac.upc.edu>"
 __copyright__  = "Copyright 2012-2017, Lluís Vilanova <vilanova@ac.upc.edu>"
 __license__    = "GPL version 2 or (at your option) any later version"
diff --git a/scripts/tracetool/format/log_stap.py b/scripts/tracetool/format/log_stap.py
index 99c6181f38..6551444203 100644
--- a/scripts/tracetool/format/log_stap.py
+++ b/scripts/tracetool/format/log_stap.py
@@ -4,6 +4,8 @@
 Generate .stp file that printfs log messages (DTrace with SystemTAP only).
 """
 
+from __future__ import annotations
+
 __author__     = "Daniel P. Berrange <berrange@redhat.com>"
 __copyright__  = "Copyright (C) 2014-2019, Red Hat, Inc."
 __license__    = "GPL version 2 or (at your option) any later version"
diff --git a/scripts/tracetool/format/rs.py b/scripts/tracetool/format/rs.py
index 7d9af7edfe..1dc43a3b34 100644
--- a/scripts/tracetool/format/rs.py
+++ b/scripts/tracetool/format/rs.py
@@ -4,6 +4,8 @@
 trace-DIR.rs
 """
 
+from __future__ import annotations
+
 __author__     = "Tanish Desai <tanishdesai37@gmail.com>"
 __copyright__  = "Copyright 2025, Tanish Desai <tanishdesai37@gmail.com>"
 __license__    = "GPL version 2 or (at your option) any later version"
diff --git a/scripts/tracetool/format/simpletrace_stap.py b/scripts/tracetool/format/simpletrace_stap.py
index c7bde97a85..eb58b4b959 100644
--- a/scripts/tracetool/format/simpletrace_stap.py
+++ b/scripts/tracetool/format/simpletrace_stap.py
@@ -4,6 +4,8 @@
 Generate .stp file that outputs simpletrace binary traces (DTrace with SystemTAP only).
 """
 
+from __future__ import annotations
+
 __author__     = "Stefan Hajnoczi <redhat.com>"
 __copyright__  = "Copyright (C) 2014, Red Hat, Inc."
 __license__    = "GPL version 2 or (at your option) any later version"
diff --git a/scripts/tracetool/format/stap.py b/scripts/tracetool/format/stap.py
index f917bd7545..808fb478b5 100644
--- a/scripts/tracetool/format/stap.py
+++ b/scripts/tracetool/format/stap.py
@@ -4,6 +4,8 @@
 Generate .stp file (DTrace with SystemTAP only).
 """
 
+from __future__ import annotations
+
 __author__     = "Lluís Vilanova <vilanova@ac.upc.edu>"
 __copyright__  = "Copyright 2012-2014, Lluís Vilanova <vilanova@ac.upc.edu>"
 __license__    = "GPL version 2 or (at your option) any later version"
diff --git a/scripts/tracetool/format/ust_events_c.py b/scripts/tracetool/format/ust_events_c.py
index 074226bfd3..fa7d543798 100644
--- a/scripts/tracetool/format/ust_events_c.py
+++ b/scripts/tracetool/format/ust_events_c.py
@@ -4,6 +4,8 @@
 trace/generated-ust.c
 """
 
+from __future__ import annotations
+
 __author__     = "Mohamad Gebai <mohamad.gebai@polymtl.ca>"
 __copyright__  = "Copyright 2012, Mohamad Gebai <mohamad.gebai@polymtl.ca>"
 __license__    = "GPL version 2 or (at your option) any later version"
diff --git a/scripts/tracetool/format/ust_events_h.py b/scripts/tracetool/format/ust_events_h.py
index cee7970a40..1057d02577 100644
--- a/scripts/tracetool/format/ust_events_h.py
+++ b/scripts/tracetool/format/ust_events_h.py
@@ -4,6 +4,8 @@
 trace/generated-ust-provider.h
 """
 
+from __future__ import annotations
+
 __author__     = "Mohamad Gebai <mohamad.gebai@polymtl.ca>"
 __copyright__  = "Copyright 2012, Mohamad Gebai <mohamad.gebai@polymtl.ca>"
 __license__    = "GPL version 2 or (at your option) any later version"
-- 
2.52.0



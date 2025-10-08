Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1685CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 06:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6NmU-0004rP-Aa; Wed, 08 Oct 2025 02:36:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6NmP-0004pH-5w
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:36:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6NmN-0004UY-0K
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 02:36:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759905361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HoqW7TWYZAwUlWWT3EmnRp4Dy829iUgSPqcGW4LEgAQ=;
 b=hNxgZe6GIoYo7ndp+ELiYVBZzLUe6qrgR5v1+o0OLIs6GUryaWQpB+CdGRHFgBq0zyFvTL
 qf9lUy9OUJ7MY+OPaLn0iJS/80iXBHechgMj42sWnC0j5w8ai1+UxIGxU6L6mMz+kFhhCs
 /n9YrtEJttsRZ73NEstwNIf67LvcKUs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-VNqDVHr4OTK_vn0oSJdmDw-1; Wed, 08 Oct 2025 02:36:00 -0400
X-MC-Unique: VNqDVHr4OTK_vn0oSJdmDw-1
X-Mimecast-MFC-AGG-ID: VNqDVHr4OTK_vn0oSJdmDw_1759905359
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b3afaf5defdso863391566b.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 23:36:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759905358; x=1760510158;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HoqW7TWYZAwUlWWT3EmnRp4Dy829iUgSPqcGW4LEgAQ=;
 b=mcjVjDpqzrkeymDZO504Pbo/7QVLrF05JorfzFDGdNl3tES5+RI9BrdvcaKrAecBHG
 T/iB8ITf1ex/2XHeuA17/TJCNGjebG0m4fL0hlB6BIAdx/djb28+oY/3Cvfnh6JtNi+g
 U+GfuXuheBO4mgJACprH3A/9w5WuM6hUZKF/yOos89k7sU9EluE9d78Bwu7K4S3m+ndQ
 s90eojiAhKSp8q40w0fmGZ4ghYJHCv18r2uJ+n7bEh33BkaP0ZUJA8VqX4AiS8hYXDqS
 hXzG9oXW8nWTzWXgLEah2XARJNmYHPwm6czCL53wfUoYahqxXUlktUPgA7DZzm31Qx0q
 kS8Q==
X-Gm-Message-State: AOJu0YwedADqvB6K7aiin0zXgG2H0YuLlPHKF4CGSeEyIZIvvNv5RXoa
 /HckaDzSPeTue45poNpJMQDbAl8T/ne5VTf6ZZsbawzcJTG7PoQ/A7dn89KtT69saj7m/vYR2v1
 tWZ55QVwqnYw/e0k9ydnh5wG0lyTtjdZfsYCRYNYtDowldPkB0KD1R+1uxqpTwja5krkKR2vC4x
 vqj1qxGW0lyCQGUuNEAZM1xw9GpPDTwVpCMbSBNhRO
X-Gm-Gg: ASbGncv/UVXPFyZHhxZAlQRpBXtvdGYd6M798tErdHFfpOCeSPKMYzz9AvG5TZgQpUC
 obmDLCTIBIsy+tZbW4DonZFCpuKC3/aNaZExHiB7zqSFSdG/GHlb2yXk8i2BC3ieAhzla+VYA3b
 hZm6JGuxtzJEPTngby+9xTaaopy4eb65RNRaxGDqIhyoCPvWP4SjQQwoHH/LnJ0keQW3baJtANy
 YTdemwWh7QdvC15vPBawRfUuYF8zWJdxSj1uaufLVnuVvxosrmsPZBFL1+4yHTh/IGUh0Ny+prt
 kFyMskfMiG8pJ7F7F70N/8C38g5rvQk+pVuNS3plSJwK1tRAKbGvgp0eYD3iAntQMRWpBF9GpXq
 aAfGPVyWejNzJuPib2LlNYcCheQ3WkeYjsOMwu2bFcdsSqDD2
X-Received: by 2002:a17:907:9411:b0:b40:6d68:34a4 with SMTP id
 a640c23a62f3a-b50a9d700b5mr257551666b.2.1759905357744; 
 Tue, 07 Oct 2025 23:35:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeiV0oo9lUTCsRFLHl49HsCwn4DOd8HCEUWZY+UXb/Otv8AemOibSDywaiqBF/anROPZy+gw==
X-Received: by 2002:a17:907:9411:b0:b40:6d68:34a4 with SMTP id
 a640c23a62f3a-b50a9d700b5mr257548666b.2.1759905357113; 
 Tue, 07 Oct 2025 23:35:57 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b486970b2basm1576772866b.51.2025.10.07.23.35.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 23:35:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH 3/6] tracetool: "import annotations"
Date: Wed,  8 Oct 2025 08:35:42 +0200
Message-ID: <20251008063546.376603-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008063546.376603-1-pbonzini@redhat.com>
References: <20251008063546.376603-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

In preparations for adding type annotations, make Python process them lazily.

This avoids the need to express some annotations as strings.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
index 22fdc29e01f..390f1a371bf 100755
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
index 85527c08c98..09ff6da6612 100644
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
index 9109a783c72..8cc9c821382 100644
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
index 0fbd98ee91b..fa941b2ff5c 100644
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
index 0d77bd23a51..40bb323f5e6 100644
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
index bbfb56911d9..d346a19e40f 100644
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
index b67257ce7e9..9c691dc231b 100644
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
index c3efab036cf..9311453c5a7 100644
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
index a70e3d83e1d..f2270725128 100644
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
index 7b9d1b57826..4c606d57579 100644
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
index 50e03313cbf..5b3459f2beb 100644
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
index 0befd444e82..dda80eeb766 100644
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
index dd58713a158..d04cabc63e8 100644
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
index 99c6181f389..65514442030 100644
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
index 32ac4e59770..71b847cb7bc 100644
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
index c7bde97a855..eb58b4b9592 100644
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
index f917bd7545d..808fb478b5f 100644
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
index 074226bfd37..fa7d5437984 100644
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
index cee7970a403..1057d02577e 100644
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
2.51.0



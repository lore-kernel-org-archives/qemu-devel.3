Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D1AC5B555
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 18:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLnAq-00020o-OZ; Sun, 01 Jun 2025 14:12:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uLnAo-00020G-Qq
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 14:12:42 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1uLnAm-0002oT-Vg
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 14:12:42 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-742af848148so2321613b3a.1
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 11:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748801559; x=1749406359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F26xt53SD7/0sbTj2mZq8Jxx7blMqx6sb10y95AoeDI=;
 b=TnZ8EFU5INqjOsgEsnX8pej+pxw0hQoxMzv4RD6dEXxHt+a1pA1HPhxtJuUm3Vbhjj
 gI15W2OHy7E/A/FPf+wIzPKa3t/Wc7JYA5JTV7B2ig0oy7nS+m9xK1vSB8A4lylhBmGX
 kQZKiTcbBE+QbA71t0CiAfqq/o/GEdPH68T2a+jYzB/iBIBG8HKAyFLFpflgE7I9Bdb2
 /T7HbhpUtm2wkjIjwZSomG4hk9ukav1nY+9DlR92u1huWJiS1ajRfYsKN0qFgSzzORiR
 C8vA4TBpPSmC2jH0fXDPs3RVF92yZnfz5nD1KGfU3Epxhxq+wJKNeH1manhMSj5coJWz
 BCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748801559; x=1749406359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F26xt53SD7/0sbTj2mZq8Jxx7blMqx6sb10y95AoeDI=;
 b=G325E7YQcFwgTR+H+dwgpF3vmJeQ6AgP+P3A4KHG4QXWw4nIHq1US1OMo7H4MbPRvQ
 9fN7W28OT1b4LgcsMIrr2ozrD7Q9bnDCV7t1QsozLkK81zyTlX1zQp8LHhCOkhGxwpeO
 IGVyA2wAPoxj4lsHCpV5Dt/VX7zRsrD7ZT3W+ci2a9USN0slwuAgAXYGYKO7CQMhLaa1
 lPSCmULSJyeFGqcH+00Dj/umsPZPA2qvnKrKfK/L6JxEn1JIktOM/+0JYhbSAShdL2tP
 j4BB+CuIY3X8wY1jqdNxHiOfgHg//Vg4/rAUm2JEXWJzifsK+b9QLFUy5cx72pj5y8M+
 tPLQ==
X-Gm-Message-State: AOJu0YyJrE/eyzjpVW9ZMYyA+e1jQUk3HbSdzc1+gcG/L825Eb5gVxVd
 ishpztNGk9w9J89AGhYOIAzkVeSc5+4y86eMLBop1/G04yYQwJuk1wvTEtPtxwJw38AmjA==
X-Gm-Gg: ASbGncs3DjIU9O1G8giAF0AL4jqZnplsM18aMI7AZ7tCGFJLD683Klpn5MvKeAuKS4q
 TljbrZ386gT5KN9xttgMSEWI0lAgHrvOq4+nLLenRu7TqjZfKRnxppIsbzuG6lSv1ipa1VMwGZ3
 Gq5YGMkctaDFL5gu7qqtlDGM4MW8xCBG3HlOOnxirqnfUezalSVxii70AFmrmTpFNrpQzf1jgm6
 1mdBIffe0OwUpxj/EApPuzDte/wx2t4TBa9jlTUR7CkK/DovK70whEOLeBB2YKEQdAn6kNg+D2x
 Y+DVVFAjuqteaKZqjk1tCJqdBCj/rk0euQJumh/P6R80sJt7aipfIoNpk2ooreCxHxgofjvy
X-Google-Smtp-Source: AGHT+IEARA6o8RXWdPby4uob9Hz1e7h4596ZzlNaG4nb3dimZZjdSEFafMqNoSoUTOjfIdqSl/W5tg==
X-Received: by 2002:a05:6a00:4b13:b0:73f:ff25:90b3 with SMTP id
 d2e1a72fcca58-747d1ae2c64mr8818577b3a.24.1748801559076; 
 Sun, 01 Jun 2025 11:12:39 -0700 (PDT)
Received: from ubuntu.. ([49.207.58.139]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-747afed4bafsm6189191b3a.79.2025.06.01.11.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 11:12:38 -0700 (PDT)
From: Tanish Desai <tanishdesai37@gmail.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com,
 Mads Ynddal <mads@ynddal.dk>, Tanish Desai <tanishdesai37@gmail.com>
Subject: [PATCH 1/3] trace/syslog: seperate cold paths of tracing functions
Date: Sun,  1 Jun 2025 18:12:29 +0000
Message-Id: <20250601181231.3461-2-tanishdesai37@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250601181231.3461-1-tanishdesai37@gmail.com>
References: <20250601181231.3461-1-tanishdesai37@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=tanishdesai37@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

inline: move hot paths from .c to .h for better performance
Moved frequently used hot paths from the .c file to the .h file to enable inlining
and improve performance. This approach is inspired by past QEMU optimizations,
where performance-critical code was inlined based on profiling results.

Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
---
 scripts/tracetool/backend/syslog.py | 36 +++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/backend/syslog.py
index 012970f6cc..52b8ff65ea 100644
--- a/scripts/tracetool/backend/syslog.py
+++ b/scripts/tracetool/backend/syslog.py
@@ -21,8 +21,12 @@
 
 
 def generate_h_begin(events, group):
-    out('#include <syslog.h>',
-        '')
+    out('#include <syslog.h>')
+    for event in events:
+        out('void _syslog_%(api)s(%(args)s);',
+            api=event.api(),
+            args=event.args)
+    out('')
 
 
 def generate_h(event, group):
@@ -37,17 +41,35 @@ def generate_h(event, group):
         cond = "trace_event_get_state(%s)" % ("TRACE_" + event.name.upper())
 
     out('    if (%(cond)s) {',
-        '#line %(event_lineno)d "%(event_filename)s"',
-        '        syslog(LOG_INFO, "%(name)s " %(fmt)s %(argnames)s);',
-        '#line %(out_next_lineno)d "%(out_filename)s"',
+            '       _syslog_%(api)s(%(args)s);',
         '    }',
         cond=cond,
         event_lineno=event.lineno,
         event_filename=os.path.relpath(event.filename),
         name=event.name,
         fmt=event.fmt.rstrip("\n"),
-        argnames=argnames)
-
+        argnames=argnames,
+        api=event.api(),
+        args=", ".join(event.args.names()))
+
+
+def generate_c(event, group):
+        argnames = ", ".join(event.args.names())
+        if len(event.args) > 0:
+            argnames = ", " + argnames
+        out('void _syslog_%(api)s(%(args)s){',
+        '   #line %(event_lineno)d "%(event_filename)s"',
+        '            syslog(LOG_INFO, "%(name)s " %(fmt)s %(argnames)s);',
+        '   #line %(out_next_lineno)d "%(out_filename)s"',
+        '}',
+        '',
+        event_lineno=event.lineno,
+        event_filename=os.path.relpath(event.filename),
+        name=event.name,
+        fmt=event.fmt.rstrip("\n"),
+        argnames=argnames,
+        api=event.api(),
+        args=event.args)    
 
 def generate_h_backend_dstate(event, group):
     out('    trace_event_get_state_dynamic_by_id(%(event_id)s) || \\',
-- 
2.34.1



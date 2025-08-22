Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD4DCA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 12:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQrU-0004om-Tr; Fri, 22 Aug 2025 08:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1upQrQ-0004ms-2u
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:27:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1upQrN-0002Oh-LE
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755865628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=htCTYY64s3u4/mbjf2jvp3grVQQ9g94LDvTznIBDP58=;
 b=BzJfljh5Dgnc4ULlzeKAppvWc+jPilNZKq21v1Rs1KybEmy79oEp13GAAx6xIG7ZduuZrc
 10wupO3Pz9bO4p9h86w2IGuhwq1+89rC7xYDD8ZHN9dmYwrHby8JMIeoH+WXyil4kVHM3R
 vvf4zrirhuJaNaMIkY3Zl6ilxaPUG3U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-EVTudWHEO9KrmiLl0LUlSg-1; Fri, 22 Aug 2025 08:27:07 -0400
X-MC-Unique: EVTudWHEO9KrmiLl0LUlSg-1
X-Mimecast-MFC-AGG-ID: EVTudWHEO9KrmiLl0LUlSg_1755865626
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3c380aa1ac0so824124f8f.0
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 05:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755865625; x=1756470425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=htCTYY64s3u4/mbjf2jvp3grVQQ9g94LDvTznIBDP58=;
 b=g/XAcGOT/10N9yjVf/DoC4wIQjAvoDygXQFp7ze/uyLSTVTR0JGn+yf9fARY6wB6rv
 RROZhUTtNJ/SIEz9a7RxzWxKw4NlxEl4uRlNNXuGSUjvDPu9HmQYLOrBVeMHbLPqpVRj
 9bcV7ns38GNbMm0KEYZccY6brxHg2NDYNJXMHaybqyJAkdfm5uErmjmontgDgTohocRg
 iEgULg88oic4QaUDXbjCGFpunfTXiLb6pAl8RYvDLWbVFAQ2eIcVhxaniEFukg1y3UTs
 CSydfur+lO9Evd6RPcQ57S/ShB8hPF3XbGrKfd5dmlBpfB4jjSAzUw19tr28wJkTC41N
 wKiA==
X-Gm-Message-State: AOJu0YwwXqFVpxHJvEbWlWFpWA8yvoPZwsGBPigZ6BKuwGUmF/0V3H4w
 FMQeM5BmAbySKVGE/RqoWt+4ZfqUQN/8V9yGggC1Dkaf7PkuugJJyNa7RiylNHm0BOBCT6oEs7M
 gPRIFEdw6kv0owrAygSvClEVWkPcApT8P9DcWq74rMKO32hD26YRXdSLRtTwwOUd0JSKHSb7GHw
 Qxyj+ebm3zJr8tsApSR3Gu+N9SG0L+RqZ/3WQ0EUTh
X-Gm-Gg: ASbGnctHy6tRxCk8mDxjn+Q5CgskeH0Icz6ta2smUqfPCDgRzuJBzTPcerW9EeCpASt
 9flHfx/fIKA0WLgfteP6yVycbfnM7YDZoE8aslfqywtRjPgMYFZ2CV2k3o5BG53aEBbHbi93VMm
 wQF0NG41WPv1TwH2ZQsMKordM6XPOm1EtkSHK0et2cfKWaEssfT6bcDjhnrrzjLU0ydKh5SEQsb
 awFTP5Eed3W3OyBl6q6cuTsWVmpaQHznDGNSwhufFm85gcK6vLxB/ZJKC8Otk352EsMLwkDu3Nb
 ef9m9aGuNCFFAIdIyzFoSrzwFNTOfMJuaiggLQ7AtGNqKb9IbeToWildwBk8o3UkbQqgKEwIFk9
 tAbOXHhJla5kfeNEVaOqhJRZtjKtKmeQJMFbN8HiUdQ==
X-Received: by 2002:a5d:64ed:0:b0:3b5:dafc:1525 with SMTP id
 ffacd0b85a97d-3c5dc7313famr2232948f8f.33.1755865625477; 
 Fri, 22 Aug 2025 05:27:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQbW6N9z46fAHU8L3UM37qtfoMuXROTfx9wqhUf4We2fCk7h6vboMTDv3txs3DawzRLROv6w==
X-Received: by 2002:a5d:64ed:0:b0:3b5:dafc:1525 with SMTP id
 ffacd0b85a97d-3c5dc7313famr2232922f8f.33.1755865624986; 
 Fri, 22 Aug 2025 05:27:04 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c077789c92sm15156979f8f.52.2025.08.22.05.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 05:27:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: tanishdesai37@gmail.com, stefanha@redhat.com, berrange@redhat.com,
 mads@ynddal.dk
Subject: [PATCH 03/14] trace/ftrace: move snprintf+write from tracepoints to
 ftrace.c
Date: Fri, 22 Aug 2025 14:26:44 +0200
Message-ID: <20250822122655.1353197-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822122655.1353197-1-pbonzini@redhat.com>
References: <20250822122655.1353197-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

This simplifies the Python code and reduces the size of the tracepoints.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/tracetool/ftrace.h            | 28 ++++++----------------------
 trace/ftrace.h                      |  1 +
 trace/ftrace.c                      | 15 +++++++++++++++
 scripts/tracetool/backend/ftrace.py | 12 ++----------
 4 files changed, 24 insertions(+), 32 deletions(-)

diff --git a/tests/tracetool/ftrace.h b/tests/tracetool/ftrace.h
index fe22ea0f09f..1dfe4239413 100644
--- a/tests/tracetool/ftrace.h
+++ b/tests/tracetool/ftrace.h
@@ -21,18 +21,10 @@ extern uint16_t _TRACE_TEST_WIBBLE_DSTATE;
 
 static inline void trace_test_blah(void *context, const char *filename)
 {
-    {
-        char ftrace_buf[MAX_TRACE_STRLEN];
-        int unused __attribute__ ((unused));
-        int trlen;
-        if (trace_event_get_state(TRACE_TEST_BLAH)) {
+    if (trace_event_get_state(TRACE_TEST_BLAH)) {
 #line 4 "trace-events"
-            trlen = snprintf(ftrace_buf, MAX_TRACE_STRLEN,
-                             "test_blah " "Blah context=%p filename=%s" "\n" , context, filename);
-#line 33 "ftrace.h"
-            trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);
-            unused = write(trace_marker_fd, ftrace_buf, trlen);
-        }
+        ftrace_write("test_blah " "Blah context=%p filename=%s" "\n" , context, filename);
+#line 28 "ftrace.h"
     }
 }
 
@@ -42,18 +34,10 @@ static inline void trace_test_blah(void *context, const char *filename)
 
 static inline void trace_test_wibble(void *context, int value)
 {
-    {
-        char ftrace_buf[MAX_TRACE_STRLEN];
-        int unused __attribute__ ((unused));
-        int trlen;
-        if (trace_event_get_state(TRACE_TEST_WIBBLE)) {
+    if (trace_event_get_state(TRACE_TEST_WIBBLE)) {
 #line 5 "trace-events"
-            trlen = snprintf(ftrace_buf, MAX_TRACE_STRLEN,
-                             "test_wibble " "Wibble context=%p value=%d" "\n" , context, value);
-#line 54 "ftrace.h"
-            trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);
-            unused = write(trace_marker_fd, ftrace_buf, trlen);
-        }
+        ftrace_write("test_wibble " "Wibble context=%p value=%d" "\n" , context, value);
+#line 41 "ftrace.h"
     }
 }
 #endif /* TRACE_TESTSUITE_GENERATED_TRACERS_H */
diff --git a/trace/ftrace.h b/trace/ftrace.h
index cb5e35d2171..16c122816d1 100644
--- a/trace/ftrace.h
+++ b/trace/ftrace.h
@@ -8,5 +8,6 @@
 extern int trace_marker_fd;
 
 bool ftrace_init(void);
+G_GNUC_PRINTF(1, 2) void ftrace_write(const char *fmt, ...);
 
 #endif /* TRACE_FTRACE_H */
diff --git a/trace/ftrace.c b/trace/ftrace.c
index 9749543d9b2..6875faedb9c 100644
--- a/trace/ftrace.c
+++ b/trace/ftrace.c
@@ -38,6 +38,21 @@ static int find_mount(char *mount_point, const char *fstype)
     return ret;
 }
 
+void ftrace_write(const char *fmt, ...)
+{
+    char ftrace_buf[MAX_TRACE_STRLEN];
+    int unused __attribute__ ((unused));
+    int trlen;
+    va_list ap;
+
+    va_start(ap, fmt);
+    trlen = vsnprintf(ftrace_buf, MAX_TRACE_STRLEN, fmt, ap);
+    va_end(ap);
+
+    trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);
+    unused = write(trace_marker_fd, ftrace_buf, trlen);
+}
+
 bool ftrace_init(void)
 {
     char mount_point[PATH_MAX];
diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
index 5fa30ccc08e..a07f8a9dfd8 100644
--- a/scripts/tracetool/backend/ftrace.py
+++ b/scripts/tracetool/backend/ftrace.py
@@ -28,18 +28,10 @@ def generate_h(event, group):
     if len(event.args) > 0:
         argnames = ", " + argnames
 
-    out('    {',
-        '        char ftrace_buf[MAX_TRACE_STRLEN];',
-        '        int unused __attribute__ ((unused));',
-        '        int trlen;',
-        '        if (trace_event_get_state(%(event_id)s)) {',
+    out('    if (trace_event_get_state(%(event_id)s)) {',
         '#line %(event_lineno)d "%(event_filename)s"',
-        '            trlen = snprintf(ftrace_buf, MAX_TRACE_STRLEN,',
-        '                             "%(name)s " %(fmt)s "\\n" %(argnames)s);',
+        '        ftrace_write("%(name)s " %(fmt)s "\\n" %(argnames)s);',
         '#line %(out_next_lineno)d "%(out_filename)s"',
-        '            trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);',
-        '            unused = write(trace_marker_fd, ftrace_buf, trlen);',
-        '        }',
         '    }',
         name=event.name,
         args=event.args,
-- 
2.50.1



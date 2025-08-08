Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66F9C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 09:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukJ8M-0007OJ-ST; Fri, 08 Aug 2025 05:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ukJ8F-0007Lu-7L
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 05:11:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ukJ8C-0006fD-FP
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 05:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754644277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=BBBWJErk9W1nyFb+opxhU9ykLp60/V7VwNBhHOrobqc=;
 b=PJnXzjFL8vAOoo8Dv+aZXYgYfQKr9Cgx9FkQcsYk9NHVRPXzxF68aMsJfVrc27EhPHotJE
 5TpxWfy9X25M+5AhtORWxbfxQZnHhLgpV1Y1jV/l6/pk4SNBkW+kxKbFsR5X15CaxQDTAA
 jWao8geU4LgnMUZ8oWtEGFpRcAgiSog=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-IiMf2vV8MiGGYh3IzeBzUw-1; Fri, 08 Aug 2025 05:11:15 -0400
X-MC-Unique: IiMf2vV8MiGGYh3IzeBzUw-1
X-Mimecast-MFC-AGG-ID: IiMf2vV8MiGGYh3IzeBzUw_1754644274
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3b78aa2a113so835461f8f.2
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 02:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754644273; x=1755249073;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BBBWJErk9W1nyFb+opxhU9ykLp60/V7VwNBhHOrobqc=;
 b=TBf14SlD8RLRp7Q30HpgjIsjHCB91L/VOT77hP756A8kEeYOOsChri4PVFMoLFWdqD
 rMkFSYQZtwGQiS+Soon2rJGOP293+LC4ZsZztrzwn1Iph2BUzVzThKUSpdhJWzH449kC
 HR8XGnMKJnmvu6NhJrfiq+yWqnnpB+8i5XrosvGrueDUjzmDoBUTsiBOK2JJ6IS1/N1W
 eSoAhEvTPcaFJ7KhJtE9xhicvOolIZ33ExMrwdNuibLpSqhUQK+z5sI4rR+vuBZ8zSYe
 fhsIJ9NnoOPD0aNxSXqsMxk0vE6K/PdV9gmRr1vyvc1q6Tr0TlR7doav9AFxGGYnMo7x
 IH3w==
X-Gm-Message-State: AOJu0YwpOlcTjxuNeckxc9trka3NfY7UyhxeeRsyjGmYg0zMe7lJTSTU
 sZy2Yla8Cv7p5Jn84FrCp/QcQNtOfFRp8uAfkKkGIAgIkRfYxUaoZHrMuYwSHj91zh5ha6Ifyth
 QW7a5Ky73XSXSn61sVCTdpgtvLAIl0PMFwSjeP6XzyfCVMB0qYOnaqtr3to7P2SatgsQPlJabZL
 YBvgJqsu4a2NS8Z8+PWTJCHsrOiTI8HmRquYb1m5Qa
X-Gm-Gg: ASbGnctPcYH0v8g+hprvkTJpqq92YchaPgf7vnw5PsBtlpSMYg+ZzSyQnMddXeMaXmD
 mqa7S1jmI/2fq1YmBeSj+1u8T6Qrdu6c+GPOClHbiAddDhABPnVHNhnS+4HJV+7cQ5ez78Wzumn
 7Wb7McZNHUgI1DlfWxTW9FZF8E1xUIzf6xSufnSBUANFaynhrhJjkYCqjEoMzl619IxxLwD1C2o
 vrogYoG9Mjf6ytSFRs7qns42VTN4Pc7ejc0Js3N7OZwydcFrS6iRz0C6ZiQUnYsfOLvhdxCkTw2
 zwLmNUX16GpOrSl82e5MtiPKmy5FWY/DhO5XgR9F3gQ=
X-Received: by 2002:a05:6000:290a:b0:3b8:f924:183d with SMTP id
 ffacd0b85a97d-3b900b51312mr1898480f8f.47.1754644273341; 
 Fri, 08 Aug 2025 02:11:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa4nzGOlNdoM7FPiwtCMKC4k1+8GJ+7L5/xew/W3/0xsREpPeKkYF7el1eTe4mU1ZN4OQSfw==
X-Received: by 2002:a05:6000:290a:b0:3b8:f924:183d with SMTP id
 ffacd0b85a97d-3b900b51312mr1898436f8f.47.1754644272732; 
 Fri, 08 Aug 2025 02:11:12 -0700 (PDT)
Received: from [10.169.150.72] ([131.175.147.2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458b866392csm152146115e9.2.2025.08.08.02.11.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 02:11:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] trace/ftrace: move snprintf+write from tracepoints to ftrace.c
Date: Fri,  8 Aug 2025 11:11:10 +0200
Message-ID: <20250808091110.23126-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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
 tests/tracetool/ftrace.h            | 26 ++++----------------------
 trace/ftrace.h                      |  1 +
 trace/ftrace.c                      | 13 +++++++++++++
 scripts/tracetool/backend/ftrace.py | 13 ++-----------
 4 files changed, 20 insertions(+), 33 deletions(-)

diff --git a/tests/tracetool/ftrace.h b/tests/tracetool/ftrace.h
index aa8d720a922..83e4adeed4d 100644
--- a/tests/tracetool/ftrace.h
+++ b/tests/tracetool/ftrace.h
@@ -21,18 +21,9 @@ extern uint16_t _TRACE_TEST_WIBBLE_DSTATE;
 
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
-#line 33 "[stdout]"
-            trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);
-            unused = write(trace_marker_fd, ftrace_buf, trlen);
-        }
+        ftrace_write("test_blah " "Blah context=%p filename=%s" "\n" , context, filename);
     }
 }
 
@@ -42,18 +33,9 @@ static inline void trace_test_blah(void *context, const char *filename)
 
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
-#line 54 "[stdout]"
-            trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);
-            unused = write(trace_marker_fd, ftrace_buf, trlen);
-        }
+        ftrace_write("test_wibble " "Wibble context=%p value=%d" "\n" , context, value);
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
index 9749543d9b2..1d7e1ee6f6d 100644
--- a/trace/ftrace.c
+++ b/trace/ftrace.c
@@ -38,6 +38,19 @@ static int find_mount(char *mount_point, const char *fstype)
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
+    trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);
+    unused = write(trace_marker_fd, ftrace_buf, trlen);
+}
+
 bool ftrace_init(void)
 {
     char mount_point[PATH_MAX];
diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
index 5fa30ccc08e..1a96231dbab 100644
--- a/scripts/tracetool/backend/ftrace.py
+++ b/scripts/tracetool/backend/ftrace.py
@@ -28,18 +28,9 @@ def generate_h(event, group):
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
-        '#line %(out_next_lineno)d "%(out_filename)s"',
-        '            trlen = MIN(trlen, MAX_TRACE_STRLEN - 1);',
-        '            unused = write(trace_marker_fd, ftrace_buf, trlen);',
-        '        }',
+        '        ftrace_write("%(name)s " %(fmt)s "\\n" %(argnames)s);',
         '    }',
         name=event.name,
         args=event.args,
-- 
2.50.1



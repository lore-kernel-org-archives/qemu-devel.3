Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6369CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV60-0004cf-BW; Thu, 30 Apr 2026 13:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV5t-0004am-Ud
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:22:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV5n-0004B9-Tr
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:22:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+uGb0wizViXSjvbg5PQVLkxmFWS6aEyQNVK65+EI6LU=;
 b=EaA3j6LevpbbDRtDrmKBULWd1QGEvo7QV7+Ub0pm8oeay8yTYUnOwG+JhMPOO2OHUtrIrA
 TrI1KAEsw51GU5/zssmJju3qP8VUEO7xKa6BXxv1L08B8MvVOl6b37f0KPcz1DsjTJtqin
 khikV/N3xNDZVTcL7iCIJl4/q2RGFaM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-BAUcWOvbMPKeeaE9IaWIjw-1; Thu, 30 Apr 2026 13:22:25 -0400
X-MC-Unique: BAUcWOvbMPKeeaE9IaWIjw-1
X-Mimecast-MFC-AGG-ID: BAUcWOvbMPKeeaE9IaWIjw_1777569745
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8b1f4478ca7so32593706d6.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569744; x=1778174544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+uGb0wizViXSjvbg5PQVLkxmFWS6aEyQNVK65+EI6LU=;
 b=PSlEM6y/gqTLbyRtnPaJU1BRwuSF1h94M6C71ewGk02jAJJR3o095YkKpRpf5DoOd5
 iQhPy+TIfrFcvdUiVR4iS8giQl4fSV/SLza50MCcT8cCvLYYAceGmHDvphMxbUfDz6JA
 DJ3Vnf0ri57metzG/+4GTSLTcNUwPxOG2wakS9u2khuwDUYEYQXKqrUVBRPj1ylIssJS
 21muAa9ekK+MCO0uNx/zHOgb0oZdjm3qSefscqstfQvkAHUIvLG0c5H5LgjH5QDln86e
 wFGhYClNBZy7uU13Z4yKRWvEOmhSjw51fgpATM6ZN1o2ZVoQCpQ/w7845KAk1+81CPqP
 QPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569744; x=1778174544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+uGb0wizViXSjvbg5PQVLkxmFWS6aEyQNVK65+EI6LU=;
 b=CVQpFbbegDcIqm7gV5hBS5qU/FLQGOhSxmrfsSLUJx4n+362VMWl2c2nlsmYQkWuOd
 l+u7DNHtoNHF9lUDwpB3X/tJvsRLN4J52bi5bzhON2h4sC8OAwcFPhKVtI95Wr1ETOs2
 6ES0IQkkO4D2YKaLwxoNOz26SSkEPolsJUvsP8cb8MhuyylApwWq3wjiafDk7XR0UGqH
 c1DJMkkGwxMrgHsD0JzgvNfJu2XoaDa9PEOuyxAxVnzLbOL2nsoyk00WANUbgx1bFhBz
 ydM3p1/5m+5Qc1/PjXt4Jg5nIP1qQywrd949GgFvGWFYbFzwWQsb1RqGM5RPAmR/2oaQ
 95sA==
X-Gm-Message-State: AOJu0YxYMsq8vItNobo43NSORbZap2+WkeQ+x/2okojaIIY/ABNkC8WQ
 56FeZK19LI3KSWMNUCvKL2gUGChhZfOKp9NBrKoKe89RNf2BrVGPdWtVMxDGAjwav19JTjTcTif
 nGhyPtUMUy4JU9N1OPHunSADX4GGVOoBtcrVRHWdmFcv6aMGdwwTBWAm5/sgztkIlVSY9dJPyQx
 LhI6KqxcXzTibLl2UA/c3u7Y7X4p8I+dnWIZ47lilq
X-Gm-Gg: AeBDieuaVWsA/DVzFL7D1wkia8Co3KOJNUfE7kWKk026GcKxoSrjD3tU2Hs8/A/85E+
 s5qrhQuilN8u0uBDZ3BuamE6aeL30kX7vFPD3g8RLK9SARcV+N5GU1jvpS4ZFYqQFL5ZUS4CEfj
 MRHyNDQODPYK2NSfC9BGRnQ7AMv1i3UfiRALAgRwW8DJiqZkzZaWsuEkK57lfLf/LoQ5aZfpDda
 J+EGjR1j7/F6eU2Iz8/Zor0PJikpVb80Q//zIBrEsA44VE5u823+JsbjdIf7vaNMF98N/yl2BDY
 vA7BDJNwoIxP9XdX98peWeS/QNMxswVqoMCxHuvLVqRKNU7LO5t9D9+hOUC3V6lX8HJp+tZqRQf
 CcJG8+ZEt86h8tl/W62gS1AX0ncZeWg9PjQQN6nzDiGzBsS/s81BzSrYqhl6WxN1/8sjEpBcGk3
 +G5hjTvhytwcus20h7TPVMNZ7qQZmvqkyorTQ=
X-Received: by 2002:a05:6214:c4d:b0:8b3:f58e:9a9 with SMTP id
 6a1803df08f44-8b3fe6e583dmr59270516d6.4.1777569743731; 
 Thu, 30 Apr 2026 10:22:23 -0700 (PDT)
X-Received: by 2002:a05:6214:c4d:b0:8b3:f58e:9a9 with SMTP id
 6a1803df08f44-8b3fe6e583dmr59269716d6.4.1777569743130; 
 Thu, 30 Apr 2026 10:22:23 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ff301ba6sm23813886d6.1.2026.04.30.10.22.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:22:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Subject: [PULL 04/58] tests: add test for json-streamer.c error recovery
Date: Thu, 30 Apr 2026 19:21:10 +0200
Message-ID: <20260430172204.1006673-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
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

Before rewriting the error recovery code to work in a push parsing
setup, make sure that we have tests for it.

Cover various cases of invalid JSON, to check that structural
recovery based on balanced brackets and braces works; and
lexer-based recovery which documents "\f" as a sure fire
way to reset the lexer.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/unit/check-json-parser.c | 159 +++++++++++++++++++++++++++++++++
 tests/unit/meson.build         |   1 +
 2 files changed, 160 insertions(+)
 create mode 100644 tests/unit/check-json-parser.c

diff --git a/tests/unit/check-json-parser.c b/tests/unit/check-json-parser.c
new file mode 100644
index 00000000000..656a4752470
--- /dev/null
+++ b/tests/unit/check-json-parser.c
@@ -0,0 +1,159 @@
+/*
+ * Unit tests for JSON Parser error recovery
+ *
+ * Copyright 2026 Red Hat
+ * Author: Paolo Bonzini <pbonzini@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
+ * See the COPYING.LIB file in the top-level directory.
+ */
+
+/*
+ * Missing tests:
+ * - multiple JSON values in a single stream
+ * - multiple invocations of json_message_parser_feed()
+ *   (does not really matter much because of how
+ *   json_lexer_feed() is implemented)
+ * - most JSON types are only covered by check-json.c.
+ */
+
+#include "qemu/osdep.h"
+
+#include "qapi/error.h"
+#include "qobject/qbool.h"
+#include "qobject/json-parser.h"
+
+typedef struct ParseResult {
+    int errors;
+    QObject *result;
+} ParseResult;
+
+static void parse_emit(void *opaque, QObject *json, Error *err)
+{
+    ParseResult *r = opaque;
+
+    g_assert_cmpint(!json, !=, !err);
+    if (err) {
+        r->errors++;
+        error_free(err);
+    } else {
+        g_assert_null(r->result);
+        r->result = json;
+    }
+}
+
+static ParseResult do_parse(const char *input)
+{
+    ParseResult r = { 0, NULL };
+    JSONMessageParser parser;
+
+    json_message_parser_init(&parser, parse_emit, &r, NULL);
+    json_message_parser_feed(&parser, input, strlen(input));
+    json_message_parser_flush(&parser);
+    json_message_parser_destroy(&parser);
+    return r;
+}
+
+static void check_result(const char *input, int expected_errors,
+                         QType expected_type)
+{
+    ParseResult r = do_parse(input);
+
+    g_assert_cmpint(r.errors, ==, expected_errors);
+    g_assert_nonnull(r.result);
+    g_assert_cmpint(qobject_type(r.result), ==, expected_type);
+    qobject_unref(r.result);
+}
+
+static void check_result_error(const char *input, int expected_errors)
+{
+    ParseResult r = do_parse(input);
+
+    g_assert_cmpint(r.errors, ==, expected_errors);
+    g_assert_null(r.result);
+}
+
+static void test_simple(void)
+{
+    check_result("false", 0, QTYPE_QBOOL);
+}
+
+static void test_whitespace(void)
+{
+    check_result(" false", 0, QTYPE_QBOOL);
+}
+
+static void test_extra_closing_braces(void)
+{
+    check_result("}}false", 2, QTYPE_QBOOL);
+}
+
+static void test_bad_dict(void)
+{
+    check_result("{ 'abc' }false", 1, QTYPE_QBOOL);
+}
+
+static void test_trailing_comma(void)
+{
+    check_result("[ 'abc', ]false", 1, QTYPE_QBOOL);
+}
+
+static void test_lexer_recovery(void)
+{
+    check_result("\f{}", 1, QTYPE_QDICT);
+    check_result("\f[]", 1, QTYPE_QLIST);
+    check_result("\f:false", 2, QTYPE_QBOOL);
+    check_result("\f,false", 2, QTYPE_QBOOL);
+
+    /*
+     * Alphabetic characters do not start a new parsing.  This is
+     * slightly weird but it keeps the lexer simple and works well for
+     * QMP (where valid input is a sequence of dictionaries).
+     */
+    check_result_error("\ffalse", 1);
+    check_result_error("\f'str'", 1);
+    check_result_error("\f\"str\"", 1);
+}
+
+static void test_lexer_recovery_nested(void)
+{
+    check_result("{[{\f{}", 1, QTYPE_QDICT);
+    check_result("{[{\f[]", 1, QTYPE_QLIST);
+    check_result("{[{\f:false", 2, QTYPE_QBOOL);
+    check_result("{[{\f,false", 2, QTYPE_QBOOL);
+
+    /*
+     * As in test_lexer_recovery, these do not produce a successful
+     * parse after \f.
+     */
+    check_result_error("{[{\ffalse", 1);
+    check_result_error("{[{\f'str'", 1);
+    check_result_error("{[{\f\"str\"", 1);
+}
+
+static void test_nested(void)
+{
+    check_result("[{'a']}false", 1, QTYPE_QBOOL);
+}
+
+static void test_nested_multiple(void)
+{
+    check_result("[{'a']}[{'a']}false", 2, QTYPE_QBOOL);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    g_test_add_func("/json-parser/simple", test_simple);
+    g_test_add_func("/json-parser/whitespace", test_whitespace);
+    g_test_add_func("/json-parser/error-recovery/extra-closing-braces", test_extra_closing_braces);
+    g_test_add_func("/json-parser/error-recovery/bad-dict", test_bad_dict);
+    g_test_add_func("/json-parser/error-recovery/trailing-comma", test_trailing_comma);
+    g_test_add_func("/json-parser/error-recovery/lexer", test_lexer_recovery);
+    g_test_add_func("/json-parser/error-recovery/lexer/nested", test_lexer_recovery_nested);
+    g_test_add_func("/json-parser/error-recovery/nested", test_nested);
+    g_test_add_func("/json-parser/error-recovery/nested/multiple", test_nested_multiple);
+
+    return g_test_run();
+}
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index 41e8b06c339..03d36748c73 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -10,6 +10,7 @@ tests = {
   'check-qnull': [],
   'check-qobject': [],
   'check-qjson': [],
+  'check-json-parser': [],
   'check-qlit': [],
   'test-error-report': [],
   'test-qobject-output-visitor': [testqapi],
-- 
2.54.0



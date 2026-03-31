Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42939FF60EF
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 10:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7VtB-0004uP-Su; Tue, 31 Mar 2026 06:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w7Vt9-0004u6-7O
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 05:59:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w7Vt7-0000sD-IJ
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 05:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774951196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+0zHznXzq5gUaXzFdXxiRJ2w0BmRcXmHhMrkP/J4v1k=;
 b=Sc49GItN92N04wH1KD+LGaBE1wnwRHD8M+NqrVf7TJvYotx9b7mluXR93MP+eZl6rCE+zt
 qskAys4c2oqNOVTVaySabBW9RMDJdwuiZZ7whvPQTvslDRbxlwEQSjz4kIhNaNK/rLBpN9
 LwQl4ZR1vAV2JftVh+Z5VyLDDdJwTnM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-eN4c7DXQMQCrPDumvr_qwg-1; Tue, 31 Mar 2026 05:59:54 -0400
X-MC-Unique: eN4c7DXQMQCrPDumvr_qwg-1
X-Mimecast-MFC-AGG-ID: eN4c7DXQMQCrPDumvr_qwg_1774951193
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43cffbe261eso1397825f8f.2
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 02:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774951193; x=1775555993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+0zHznXzq5gUaXzFdXxiRJ2w0BmRcXmHhMrkP/J4v1k=;
 b=eFNB8AktohoIOCxVF+fyBfuP7gMl6y0WpNCS62bJhM1tZoXHiQ4dxiOgd2gMeGHDT+
 2TqDOqxKBqaQXKLQwmlTJwHxd6vhjFmEvi411dsAhkNcINRehM7sXfXDFIA2umZo5Y/A
 2oaa0JVYulIhkLI4Ld05WDvIk2cxAHFWy3Fg+qVQZqmJaLKlkVV224BWyaIFBOYbHG0x
 2P2VBDYJEWRRtnl79CaIPrDjeQWRpLeTZUD/8QOJpfUz4bqlhOYWbOIr0ndNOiyLoJ8I
 3kGfj0rXgRHBOc64e6N4Win4wE2CqT0c7c3sTq8kfbyuCdSJbavnFDjhCHw65HYKJZUi
 zqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774951193; x=1775555993;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+0zHznXzq5gUaXzFdXxiRJ2w0BmRcXmHhMrkP/J4v1k=;
 b=IaHN5y/78ZlESs4TZdUdaaYwlA99QrKtmag8aHM2I9OQarfR2khjS68Nf2FwQS2ZvL
 6YBJtiQJWzgvY+8J/y30GdwSLuJgOG/BWVCeR6y3HhwWgyoHC6ev7Qm2oY6x9tn78TYI
 FMEOsWpWjKpLRpEc/Z+pPmnFGy6gq2KcP0dzFlLEA1ibfvn/GyVzbANF0QBZoMPuIPeN
 I0h/Eou5td4URbUDNmk58F+IeJ9hSKpjRivYZj2VCu7fD3O4am+rz9i+YzvsmbS3KXwW
 Qwv5rTzT4StZdHt34cs4l/CWHfvBy3zeHT/06s4uhnLSPTh4YW2C1p5rCCYEHP9MDLKl
 wO4w==
X-Gm-Message-State: AOJu0Yys0Mzpoy4UN25TwuGgCsHIYzACNcIKbpwgpdXLBvpMfPpf+YDh
 UWFrpp0S2upTGWGkQe1y88yjqjlJeCNngDKd1vfI2v8DclH3k2VOO9AU4DGLzbPWlSBDu+4gKTa
 5ydBQXqFeafyFx09vDlqzW/FTFPW7WiVw0y7+fN2tGLWxcDfgjKE/cpIASAKoeADIyzG3dAdU15
 tJXKrocnYoHt4cHekfvzPzpFbbaoZMIl3UNyBVKFUx
X-Gm-Gg: ATEYQzwdj8PGysu/Q+kRppjItHwRwWE2qcK5NT/fzyoDDPaZZsxuiljipBaufK71V8n
 NLh8+xCQA+9Mi1+FMzvuoWK+XKUrSwwQBerVywnrXI1b0dLEL+UcNDDQ7fh8N3Mk53uevh24P1q
 k1vR+Km1kaP+sVdt7JvEs0OakP7eKxl+CCAOMxK10DPXnG1zdzqeVDQsq2xRK/iEZKedRQ6mDE/
 Imti6DyjKxCWjqMiDL72jIZZ4qZ9VRvquoFU7rXmw7HG97h+F9GmaT7xch6FxTChAId+6z/7Y8P
 Qp0YxgoJxogBQWlCTucKb+7BRM5EvCmOzaYivF1Kibge9ZPz0VJIRQreFKHhuzF2I7BHUB5Nthg
 FbxesvZWUKtR8C2MaEs4/aHlXr3VFADH5L6LzonKd82hcjuxTU0KYmRweSEhi5WrzGRFWlP7C1v
 ZI7TzbgO+e5LpQAeQm1ETz3WaQ
X-Received: by 2002:a5d:5d07:0:b0:43b:6a55:e26a with SMTP id
 ffacd0b85a97d-43b9ea776c6mr27853572f8f.51.1774951192832; 
 Tue, 31 Mar 2026 02:59:52 -0700 (PDT)
X-Received: by 2002:a5d:5d07:0:b0:43b:6a55:e26a with SMTP id
 ffacd0b85a97d-43b9ea776c6mr27853513f8f.51.1774951192341; 
 Tue, 31 Mar 2026 02:59:52 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf21eba4dsm28054941f8f.11.2026.03.31.02.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 02:59:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH] tests: add test for json-streamer.c error recovery
Date: Tue, 31 Mar 2026 11:59:50 +0200
Message-ID: <20260331095950.512326-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/unit/check-json-parser.c | 145 +++++++++++++++++++++++++++++++++
 tests/unit/meson.build         |   1 +
 2 files changed, 146 insertions(+)
 create mode 100644 tests/unit/check-json-parser.c

diff --git a/tests/unit/check-json-parser.c b/tests/unit/check-json-parser.c
new file mode 100644
index 00000000000..ca2d5f41097
--- /dev/null
+++ b/tests/unit/check-json-parser.c
@@ -0,0 +1,145 @@
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
+    if (err) {
+        r->errors++;
+        error_free(err);
+    } else {
+        qobject_unref(r->result);
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
+static void check_result(const char *input, int expected_errors, QType expected_type)
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
+     * alphabetic characters do not start a new parsing, this is slightly weird
+     * but it keeps the lexer simple and works well for QMP (where valid input
+     * is a sequence of dictionaries)
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
+    /* same as test_lexer_recovery */
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
2.53.0



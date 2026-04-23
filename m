Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C68FDEE25
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 16:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFx1U-0003e3-3l; Thu, 23 Apr 2026 12:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFx1P-0003dK-Er
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 12:35:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFx1L-00054y-Ps
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 12:35:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776962117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=AsJAWnCoNbs1oy2JrjrDhcMoGfn46TVOMFyDrJmHCAM=;
 b=E1SxaozFrXOoj94ump6iIa7CMKdozhci3EIpNmIqyQgNK+qabrsPfTEdEPP5ZtpRywekUZ
 GcCvRUnEpmhAp9atwrHmp3XnYSb0Ve8AQZLYky08zHHAK2X/xQJtiqRmFBLgxMftzioKU/
 bPcKUoZCcLuXX8bLHWa5uef91ygz6sI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-7hUswZwnNCqx94iKzoxh2w-1; Thu, 23 Apr 2026 12:35:13 -0400
X-MC-Unique: 7hUswZwnNCqx94iKzoxh2w-1
X-Mimecast-MFC-AGG-ID: 7hUswZwnNCqx94iKzoxh2w_1776962112
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-488d56f87e8so56964895e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 09:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776962111; x=1777566911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AsJAWnCoNbs1oy2JrjrDhcMoGfn46TVOMFyDrJmHCAM=;
 b=pOhOJiLPsenHgsIAQId7C5hGvkPWY5NppKigTZZcvQ06kGPT5vfewqSzMECPnYLEqc
 fbfrImmMbffMqhiGWU8WdaMGH4YmtRUgKSKxWlfZYhD32kqEEpG7Z36EJUqmifMC2WX5
 FuPo2AM60D0DedPY1krYzEvKA09Xxcv5Sv9sDF1Q80EjBt54RREVhBgdSc2ULEZG78Lf
 E5x/ijWxBOMerF1Ae91hUKBvs3XoD7ZMZp6qZhOGwxetifbQ7tiCtXsn0UhbeK1b2sFK
 GuYvjtGw2jj21haCj9yoOu4S6Laa85lwyyAoX1n0+j4IxUluOmJGCP2tNI6iXJBvmXgn
 sZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776962111; x=1777566911;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AsJAWnCoNbs1oy2JrjrDhcMoGfn46TVOMFyDrJmHCAM=;
 b=sJD2JUKoq1zKhdBHm2U4Ujs4M9pHRhwI0wX8my0IUpsaNODUXU7lDfmx1Qel3a/5Lh
 4dcz3alS25g4y7aMaH/D7NtS+sE1OyPeCLrDAjsgP061WbZJ52nnwq7G/Hol+lXpFvSU
 zre8XZk+HBl837ikFgufCog0Z+T2Z4qebTv6VDOqEltZfxnNaLd1fDiQ6gdwc6ShCsAp
 wyFSIxqI9sA33cFtBoydXhcCpvMQ6RlW4uB3pie7FBooGklJCC63gRd0JkAQc4eQQLZm
 bTahMNNNmhC1hdzJcT9dST+BckC95RpLSUW1DrecbmG3azDGta5rYW/yEB98YCIC3Pgj
 j3MA==
X-Gm-Message-State: AOJu0YxGRJ9LomQv1Eg3uLEExUCjqJxtwwFkHHaQsWO0j2Ghy2b9+1Ta
 cx1kFN7iqeJDT83+mQEUYlVDdDLuqOpMeOGZ7OBmxbkxBCF8koHPDfR3gpYOdJ5Fl3fHSBHPSbM
 eKf7MjP3sakFCOYZk+NWoFYlTnXRRWF7dZWRdQVmkaCcpP/DsGKRq0Pe4ddjWsylA/pZXNM26bG
 Ru1EUyReZ3nyidiPulP6Bmpx1uslgSgujgjMG/o6Y2
X-Gm-Gg: AeBDiev/0DfMWe/rkzaHeC7+zfO1WFZVyr9uEcwxgjxPvh8bUrwF2FPFQfFdEguf/Jl
 MInDT3QXaE9jORFElKSuuxP4joooHwn2I4CPaP/E4Jv9iboaQunZQSY0FPtvS9sI2hZDpYvPSs3
 8CjU7t0AW2/FhezK3CIjIr5IGi8LuOkiWFviqIu8B8L2KwZZttEAr+ct+KXqyea1Ze4uS4mX5IM
 PBn8ZOhcTYiMkcZUzAQ+y35uBTF4LAHHY1jkCGXklEAeW/pChD5mrRHzBxj30H8vVcuFiFPjdwt
 N7+CsomRomIuIZeCYIBGgyhBJ35llgGOUL4y5uj/Ji7esbEHwBkPtf6oRk+OIw6TOmVqYG7/NOH
 C00xUWSWUmmahnCySXfJ4klSp62PfDrz3LnZemzNJ9fxYcnrluPdmosYS+8bWxMMyEcOV1eeJ15
 Jmz9OZxG6XpEdD0PbzRUXXlys1kdqQgaW71w==
X-Received: by 2002:a05:600c:c4a8:b0:48a:52ee:5776 with SMTP id
 5b1f17b1804b1-48a52ee579dmr236331745e9.11.1776962111364; 
 Thu, 23 Apr 2026 09:35:11 -0700 (PDT)
X-Received: by 2002:a05:600c:c4a8:b0:48a:52ee:5776 with SMTP id
 5b1f17b1804b1-48a52ee579dmr236331195e9.11.1776962110743; 
 Thu, 23 Apr 2026 09:35:10 -0700 (PDT)
Received: from [192.168.1.84] ([93.56.170.76])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891cc7b2efsm185613685e9.0.2026.04.23.09.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 09:35:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH v2] tests: add test for json-streamer.c error recovery
Date: Thu, 23 Apr 2026 18:35:09 +0200
Message-ID: <20260423163509.502729-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/unit/check-json-parser.c | 159 +++++++++++++++++++++++++++++++++
 tests/unit/meson.build         |   1 +
 2 files changed, 160 insertions(+)
 create mode 100644 tests/unit/check-json-parser.c

diff --git a/tests/unit/check-json-parser.c b/tests/unit/check-json-parser.c
new file mode 100644
index 00000000000..5e833eac1f9
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
2.53.0



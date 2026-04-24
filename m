Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DF9FB44A6
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 06:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG9ZM-0008JK-Ur; Fri, 24 Apr 2026 01:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wG9ZM-0008J6-8y
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 01:59:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wG9ZJ-0001Vt-9z
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 01:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777010351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1cxC1OnqufF5ZuXFzPwntXThqyTdjBDee+5LsqdTJkg=;
 b=P+4YKutATbzdXl1flrCrs3Sn69x+UYSuFblb/IoIdk9XQpKtZL96bZTAxrIkRlWOuwUmbG
 KmyEDpfpgOm7KNnJNSKO+Ucv8dGrP49z1I2g6m2Sz3Mu31OaHMWsz0eVXPmbEaWH1k3BZy
 HjfMoPEB9cn8DCf+xxW3+HHbi5zTACg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-EIeTt3jKMQGoPWbTBn8J4A-1; Fri,
 24 Apr 2026 01:59:09 -0400
X-MC-Unique: EIeTt3jKMQGoPWbTBn8J4A-1
X-Mimecast-MFC-AGG-ID: EIeTt3jKMQGoPWbTBn8J4A_1777010348
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BC4D180034D
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 05:59:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.30])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E798619560B7
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 05:59:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6650D21E6A28; Fri, 24 Apr 2026 07:59:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2] tests: add test for json-streamer.c error recovery
In-Reply-To: <20260423163509.502729-1-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Thu, 23 Apr 2026 18:35:09 +0200")
References: <20260423163509.502729-1-pbonzini@redhat.com>
Date: Fri, 24 Apr 2026 07:59:05 +0200
Message-ID: <87ik9gkifq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Before rewriting the error recovery code to work in a push parsing
> setup, make sure that we have tests for it.
>
> Cover various cases of invalid JSON, to check that structural
> recovery based on balanced brackets and braces works; and
> lexer-based recovery which documents "\f" as a sure fire
> way to reset the lexer.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/unit/check-json-parser.c | 159 +++++++++++++++++++++++++++++++++
>  tests/unit/meson.build         |   1 +
>  2 files changed, 160 insertions(+)
>  create mode 100644 tests/unit/check-json-parser.c
>
> diff --git a/tests/unit/check-json-parser.c b/tests/unit/check-json-parser.c
> new file mode 100644
> index 00000000000..5e833eac1f9
> --- /dev/null
> +++ b/tests/unit/check-json-parser.c
> @@ -0,0 +1,159 @@
> +/*
> + * Unit tests for JSON Parser error recovery
> + *
> + * Copyright 2026 Red Hat
> + * Author: Paolo Bonzini <pbonzini@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
> + * See the COPYING.LIB file in the top-level directory.
> + */
> +
> +/*
> + * Missing tests:
> + * - multiple JSON values in a single stream
> + * - multiple invocations of json_message_parser_feed()
> + *   (does not really matter much because of how
> + *   json_lexer_feed() is implemented)
> + * - most JSON types are only covered by check-json.c.
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "qapi/error.h"
> +#include "qobject/qbool.h"
> +#include "qobject/json-parser.h"
> +
> +typedef struct ParseResult {
> +    int errors;
> +    QObject *result;
> +} ParseResult;
> +
> +static void parse_emit(void *opaque, QObject *json, Error *err)
> +{
> +    ParseResult *r = opaque;
> +
> +    g_assert_cmpint(!json, !=, !err);
> +    if (err) {
> +        r->errors++;
> +        error_free(err);
> +    } else {
> +        g_assert_null(r->result);
> +        qobject_unref(r->result);

Do we still need the unref?

> +        r->result = json;
> +    }
> +}
> +
> +static ParseResult do_parse(const char *input)
> +{
> +    ParseResult r = { 0, NULL };
> +    JSONMessageParser parser;
> +
> +    json_message_parser_init(&parser, parse_emit, &r, NULL);
> +    json_message_parser_feed(&parser, input, strlen(input));
> +    json_message_parser_flush(&parser);
> +    json_message_parser_destroy(&parser);
> +    return r;
> +}
> +
> +static void check_result(const char *input, int expected_errors, QType expected_type)

Line break after the second parameter would be easier to read.  Not
worth a respin.

> +{
> +    ParseResult r = do_parse(input);
> +
> +    g_assert_cmpint(r.errors, ==, expected_errors);
> +    g_assert_nonnull(r.result);
> +    g_assert_cmpint(qobject_type(r.result), ==, expected_type);
> +    qobject_unref(r.result);
> +}
> +
> +static void check_result_error(const char *input, int expected_errors)
> +{
> +    ParseResult r = do_parse(input);
> +
> +    g_assert_cmpint(r.errors, ==, expected_errors);
> +    g_assert_null(r.result);
> +}
> +
> +static void test_simple(void)
> +{
> +    check_result("false", 0, QTYPE_QBOOL);
> +}
> +
> +static void test_whitespace(void)
> +{
> +    check_result(" false", 0, QTYPE_QBOOL);
> +}
> +
> +static void test_extra_closing_braces(void)
> +{
> +    check_result("}}false", 2, QTYPE_QBOOL);
> +}
> +
> +static void test_bad_dict(void)
> +{
> +    check_result("{ 'abc' }false", 1, QTYPE_QBOOL);
> +}
> +
> +static void test_trailing_comma(void)
> +{
> +    check_result("[ 'abc', ]false", 1, QTYPE_QBOOL);
> +}
> +
> +static void test_lexer_recovery(void)
> +{
> +    check_result("\f{}", 1, QTYPE_QDICT);
> +    check_result("\f[]", 1, QTYPE_QLIST);
> +    check_result("\f:false", 2, QTYPE_QBOOL);
> +    check_result("\f,false", 2, QTYPE_QBOOL);
> +
> +    /*
> +     * Alphabetic characters do not start a new parsing.  This is
> +     * slightly weird but it keeps the lexer simple and works well for
> +     * QMP (where valid input is a sequence of dictionaries).
> +     */
> +    check_result_error("\ffalse", 1);
> +    check_result_error("\f'str'", 1);
> +    check_result_error("\f\"str\"", 1);
> +}
> +
> +static void test_lexer_recovery_nested(void)
> +{
> +    check_result("{[{\f{}", 1, QTYPE_QDICT);
> +    check_result("{[{\f[]", 1, QTYPE_QLIST);
> +    check_result("{[{\f:false", 2, QTYPE_QBOOL);
> +    check_result("{[{\f,false", 2, QTYPE_QBOOL);
> +
> +    /*
> +     * As in test_lexer_recovery, these do not produce a successful
> +     * parse after \f.
> +     */
> +    check_result_error("{[{\ffalse", 1);
> +    check_result_error("{[{\f'str'", 1);
> +    check_result_error("{[{\f\"str\"", 1);
> +}
> +
> +static void test_nested(void)
> +{
> +    check_result("[{'a']}false", 1, QTYPE_QBOOL);
> +}
> +
> +static void test_nested_multiple(void)
> +{
> +    check_result("[{'a']}[{'a']}false", 2, QTYPE_QBOOL);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +    g_test_init(&argc, &argv, NULL);
> +
> +    g_test_add_func("/json-parser/simple", test_simple);
> +    g_test_add_func("/json-parser/whitespace", test_whitespace);
> +    g_test_add_func("/json-parser/error-recovery/extra-closing-braces", test_extra_closing_braces);
> +    g_test_add_func("/json-parser/error-recovery/bad-dict", test_bad_dict);
> +    g_test_add_func("/json-parser/error-recovery/trailing-comma", test_trailing_comma);
> +    g_test_add_func("/json-parser/error-recovery/lexer", test_lexer_recovery);
> +    g_test_add_func("/json-parser/error-recovery/lexer/nested", test_lexer_recovery_nested);
> +    g_test_add_func("/json-parser/error-recovery/nested", test_nested);
> +    g_test_add_func("/json-parser/error-recovery/nested/multiple", test_nested_multiple);
> +
> +    return g_test_run();
> +}
> diff --git a/tests/unit/meson.build b/tests/unit/meson.build
> index 41e8b06c339..03d36748c73 100644
> --- a/tests/unit/meson.build
> +++ b/tests/unit/meson.build
> @@ -10,6 +10,7 @@ tests = {
>    'check-qnull': [],
>    'check-qobject': [],
>    'check-qjson': [],
> +  'check-json-parser': [],
>    'check-qlit': [],
>    'test-error-report': [],
>    'test-qobject-output-visitor': [testqapi],

Reviewed-by: Markus Armbruster <armbru@redhat.com>



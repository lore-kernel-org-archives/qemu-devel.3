Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56E8F89251
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 11:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF9IW-0002lp-Rn; Tue, 21 Apr 2026 07:29:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wF9IV-0002lH-Kz
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 07:29:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wF9IT-0000Co-Op
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 07:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776770977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5N0lt7l2j7DMKClQ9Y1cfCKfyBEWNj6BvOgzKB+Hc7Q=;
 b=aYXXYC3tp9xkILXhp+1Z8HbIs344VarnDjFY6+t8SQ/k3hL6TOt1JjJVptlkOuM/I1PWIH
 +LPFy2E/waNmzCP+jieODgj0Kb8k/JECgV0UP67KzpVOcxZvEUbHhVv/NSovkHSVfF7YIP
 0kvboyENqB9lr3XDgbuWZjbrniSmJ44=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-CmMXiON-O8KR1aL83QyAGw-1; Tue,
 21 Apr 2026 07:29:36 -0400
X-MC-Unique: CmMXiON-O8KR1aL83QyAGw-1
X-Mimecast-MFC-AGG-ID: CmMXiON-O8KR1aL83QyAGw_1776770975
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F46D18005AB
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 11:29:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.22])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B9F7519560AB
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 11:29:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1D50221E6A28; Tue, 21 Apr 2026 13:29:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] tests: add test for json-streamer.c error recovery
In-Reply-To: <20260331095950.512326-1-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Tue, 31 Mar 2026 11:59:50 +0200")
References: <20260331095950.512326-1-pbonzini@redhat.com>
Date: Tue, 21 Apr 2026 13:29:32 +0200
Message-ID: <871pg87dr7.fsf@pond.sub.org>
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
>  tests/unit/check-json-parser.c | 145 +++++++++++++++++++++++++++++++++
>  tests/unit/meson.build         |   1 +
>  2 files changed, 146 insertions(+)
>  create mode 100644 tests/unit/check-json-parser.c
>
> diff --git a/tests/unit/check-json-parser.c b/tests/unit/check-json-parser.c
> new file mode 100644
> index 00000000000..ca2d5f41097
> --- /dev/null
> +++ b/tests/unit/check-json-parser.c
> @@ -0,0 +1,145 @@
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

Recommend

       assert(!json != !err);

> +    if (err) {
> +        r->errors++;
> +        error_free(err);

ParseResult.errors counts errors, and ...

> +    } else {
> +        qobject_unref(r->result);
> +        r->result = json;

.result is the last value successfully parsed.

Suggest to comment struct ParseResult accordingly.

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

This is similar to qobject_from_json(), but geared towards testing error
recovery:

* qobject_from_json() treats multiple JSON values as error, do_parse()
  returns the last one.

* qobject_from_json() returns the last error, do_parse() returns the
  number of errors.

Okay.

> +
> +static void check_result(const char *input, int expected_errors, QType expected_type)

Break the line after the second parameter, please.

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

This one isn't about error recovery.  It's arguably redundant with
check-qjson.c's keyword_literal().

> +
> +static void test_whitespace(void)
> +{
> +    check_result(" false", 0, QTYPE_QBOOL);
> +}

Also not about error recovery.  Sort of redundant with check-qjson.c's
simple_whitespace().

> +
> +static void test_extra_closing_braces(void)
> +{
> +    check_result("}}false", 2, QTYPE_QBOOL);
> +}

Overlap with check-qjson.c's multiple_values().

> +
> +static void test_bad_dict(void)
> +{
> +    check_result("{ 'abc' }false", 1, QTYPE_QBOOL);
> +}

Interesting: just one error, because error recovery eats false.

> +
> +static void test_trailing_comma(void)
> +{
> +    check_result("[ 'abc', ]false", 1, QTYPE_QBOOL);
> +}

Likewise.

> +
> +static void test_lexer_recovery(void)
> +{
> +    check_result("\f{}", 1, QTYPE_QDICT);
> +    check_result("\f[]", 1, QTYPE_QLIST);
> +    check_result("\f:false", 2, QTYPE_QBOOL);
> +    check_result("\f,false", 2, QTYPE_QBOOL);
> +
> +    /*
> +     * alphabetic characters do not start a new parsing, this is slightly weird
> +     * but it keeps the lexer simple and works well for QMP (where valid input
> +     * is a sequence of dictionaries)
> +     */

Please wrap comment lines a bit earlier for legibility:

       /*
        * Alphabetic characters do not start a new parsing.  This is
        * slightly weird but it keeps the lexer simple and works well for
        * QMP (where valid input is a sequence of dictionaries).
        */

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
> +    /* same as test_lexer_recovery */

Really?

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

check-json-parser.c and check-qjson.c both test the JSON parser.

check-json-parser.c tests at the json-parser.h level, and focuses on
error recovery.

check-qjson.c tests one level up at the qjson.h level, where error
recovery is not testable.

Perhaps the JSON parser tests should all be in one place.  This is not a
demand :)



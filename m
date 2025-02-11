Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0060AC0219D
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 21:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thxjB-0000nN-BL; Tue, 11 Feb 2025 16:23:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1thxj9-0000n4-7i
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 16:23:31 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1thxj5-0001VC-Ju
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 16:23:30 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9409F211B8;
 Tue, 11 Feb 2025 21:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739309004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nUpxduoRHU+M6oE1mDUMH9ZBsKGfwShYoclZ1vzt/A4=;
 b=G2IjzN718L4GendtMX7Jq1Td/PzoAwM5ZbK/7Y7FVuDETjPi9s+z4ttIlv6+WOfGldNZuC
 sFQddK0c4bnCnnD5L91zF9Oz2bM82R1qp7Wb+DYDS1zbXGLnEbqvbvkdhUJPFymvcAr/cs
 MqbVNdSAOL+jGgpsR/WtQ78dyPr4qUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739309004;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nUpxduoRHU+M6oE1mDUMH9ZBsKGfwShYoclZ1vzt/A4=;
 b=PUM/I/VJPj7+/9P7mKVzFAVpkJZ2KkkoN0kcuiS21cufSUEEh4CEbEQc7yorQVQQnR3ygH
 7dT3Sxhk2GsoneDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739309003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nUpxduoRHU+M6oE1mDUMH9ZBsKGfwShYoclZ1vzt/A4=;
 b=TnyP00CU5iVyR+r8oemMjEFANnP6DnbtKWVCkAiVchZvGn70VoqyEY1l8IXf281KmNPiKe
 IQte7FdJelPvEiHyIfByuibqMcUGji4Z/7LpIs6J0ZTJQyI9YMJ3usBvgIt22CEEAdKqSz
 wQwK4U12ReD5OSTGT5H6oZbSwafYTTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739309003;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nUpxduoRHU+M6oE1mDUMH9ZBsKGfwShYoclZ1vzt/A4=;
 b=i4/19o6elyo/I6CXIay60pAYRIl8ekdnhc6fxQHBAeiKLX9/lBctV6880C5TtecLOyvT3z
 GNhOfhznwIBRPODw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1345D13782;
 Tue, 11 Feb 2025 21:23:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /GKqMcq/q2f9UQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 11 Feb 2025 21:23:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 8/9] tests/qtest/migration: Add a cancel test
In-Reply-To: <Z6urZeOyLYRJzMM8@x1.local>
References: <20250211150136.6781-1-farosas@suse.de>
 <20250211150136.6781-9-farosas@suse.de> <Z6urZeOyLYRJzMM8@x1.local>
Date: Tue, 11 Feb 2025 18:23:20 -0300
Message-ID: <87pljouqev.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Tue, Feb 11, 2025 at 12:01:35PM -0300, Fabiano Rosas wrote:
>> The qmp_migrate_cancel() command is poorly tested and code inspection
>> reveals that there might be concurrency issues with its usage. Add a
>> test that runs a migration and calls qmp_migrate_cancel() at specific
>> moments.
>> 
>> In order to make the test more deterministic, instead of calling
>> qmp_migrate_cancel() at random moments during migration, do it after
>> the migration status change events are seen.
>> 
>> The expected result is that qmp_migrate_cancel() on the source ends
>> migration on the source with the "cancelled" state and ends migration
>> on the destination with the "failed" state. The only exception is that
>> a failed migration should continue in the failed state.
>> 
>> Cancelling is not allowed during postcopy (no test is added for this
>> because it's a trivial check in the code).
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  tests/qtest/migration/precopy-tests.c | 176 ++++++++++++++++++++++++++
>>  1 file changed, 176 insertions(+)
>> 
>> diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
>> index 162fa69531..ba273d10b9 100644
>> --- a/tests/qtest/migration/precopy-tests.c
>> +++ b/tests/qtest/migration/precopy-tests.c
>> @@ -20,6 +20,7 @@
>>  #include "migration/migration-util.h"
>>  #include "ppc-util.h"
>>  #include "qobject/qlist.h"
>> +#include "qapi-types-migration.h"
>>  #include "qemu/module.h"
>>  #include "qemu/option.h"
>>  #include "qemu/range.h"
>> @@ -536,6 +537,161 @@ static void test_multifd_tcp_cancel(void)
>>      migrate_end(from, to2, true);
>>  }
>>  
>> +static void test_cancel_src_after_failed(QTestState *from, QTestState *to,
>> +                                         const char *uri, const char *phase)
>> +{
>> +    /*
>> +     * No migrate_incoming_qmp() at the start to force source into
>> +     * failed state during migrate_qmp().
>> +     */
>> +
>> +    wait_for_serial("src_serial");
>> +    migrate_ensure_converge(from);
>> +
>> +    migrate_qmp(from, to, uri, NULL, "{}");
>> +
>> +    migration_event_wait(from, phase);
>> +    migrate_cancel(from);
>> +
>> +    /* cancelling will not move the migration out of 'failed' */
>> +
>> +    wait_for_migration_status(from, "failed",
>> +                              (const char * []) { "completed", NULL });
>> +
>> +    /*
>> +     * Not waiting for the destination because it never started
>> +     * migration.
>> +     */
>> +}
>> +
>> +static void test_cancel_src_after_cancelled(QTestState *from, QTestState *to,
>> +                                            const char *uri, const char *phase)
>> +{
>> +    migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
>> +
>> +    wait_for_serial("src_serial");
>> +    migrate_ensure_converge(from);
>> +
>> +    migrate_qmp(from, to, uri, NULL, "{}");
>> +
>> +    /* To move to cancelled/cancelling */
>> +    migrate_cancel(from);
>> +    migration_event_wait(from, phase);
>> +
>> +    /* The migrate_cancel under test */
>> +    migrate_cancel(from);
>> +
>> +    wait_for_migration_status(from, "cancelled",
>> +                              (const char * []) { "completed", NULL });
>> +
>> +    wait_for_migration_status(to, "failed",
>> +                              (const char * []) { "completed", NULL });
>> +}
>> +
>> +static void test_cancel_src_after_complete(QTestState *from, QTestState *to,
>> +                                           const char *uri, const char *phase)
>> +{
>> +    migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
>> +
>> +    wait_for_serial("src_serial");
>> +    migrate_ensure_converge(from);
>> +
>> +    migrate_qmp(from, to, uri, NULL, "{}");
>> +
>> +    migration_event_wait(from, phase);
>> +    migrate_cancel(from);
>> +
>> +    /*
>> +     * qmp_migrate_cancel() exits early if migration is not running
>> +     * anymore, the status will not change to cancelled.
>> +     */
>> +    wait_for_migration_complete(from);
>> +    wait_for_migration_complete(to);
>> +}
>> +
>> +static void test_cancel_src_after_none(QTestState *from, QTestState *to,
>> +                                       const char *uri, const char *phase)
>> +{
>> +    /*
>> +     * Test that cancelling without a migration happening does not
>> +     * affect subsequent migrations
>> +     */
>> +    migrate_cancel(to);
>> +
>> +    wait_for_serial("src_serial");
>> +    migrate_cancel(from);
>> +
>> +    migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
>> +
>> +    migrate_ensure_converge(from);
>> +    migrate_qmp(from, to, uri, NULL, "{}");
>> +
>> +    wait_for_migration_complete(from);
>> +    wait_for_migration_complete(to);
>> +}
>> +
>> +static void test_cancel_src_pre_switchover(QTestState *from, QTestState *to,
>> +                                           const char *uri, const char *phase)
>> +{
>> +    migrate_set_capability(from, "pause-before-switchover", true);
>> +    migrate_set_capability(to, "pause-before-switchover", true);
>> +
>> +    migrate_set_capability(from, "multifd", true);
>> +    migrate_set_capability(to, "multifd", true);
>> +
>> +    migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
>> +
>> +    wait_for_serial("src_serial");
>> +    migrate_ensure_converge(from);
>> +
>> +    migrate_qmp(from, to, uri, NULL, "{}");
>> +
>> +    migration_event_wait(from, phase);
>> +    migrate_cancel(from);
>> +    migration_event_wait(from, "cancelling");
>> +
>> +    wait_for_migration_status(from, "cancelled",
>> +                              (const char * []) { "completed", NULL });
>> +
>> +    wait_for_migration_status(to, "failed",
>> +                              (const char * []) { "completed", NULL });
>> +}
>> +
>> +static void test_cancel_src_after_status(void *opaque)
>> +{
>> +    const char *test_path = opaque;
>> +    g_autofree char *phase = g_path_get_basename(test_path);
>> +    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
>> +    QTestState *from, *to;
>> +    MigrateStart args = {
>> +        .hide_stderr = true,
>> +    };
>> +
>> +    if (migrate_start(&from, &to, "defer", &args)) {
>> +        return;
>> +    }
>> +
>> +    if (g_str_equal(phase, "cancelling") ||
>> +        g_str_equal(phase, "cancelled")) {
>> +        test_cancel_src_after_cancelled(from, to, uri, phase);
>> +
>> +    } else if (g_str_equal(phase, "completed")) {
>> +        test_cancel_src_after_complete(from, to, uri, phase);
>> +
>> +    } else if (g_str_equal(phase, "failed")) {
>> +        test_cancel_src_after_failed(from, to, uri, phase);
>> +
>> +    } else if (g_str_equal(phase, "none")) {
>> +        test_cancel_src_after_none(from, to, uri, phase);
>> +
>> +    } else {
>> +        /* any state that comes before pre-switchover */
>> +        test_cancel_src_pre_switchover(from, to, uri, phase);
>
> [1]
>
>> +    }
>> +
>> +    migrate_end(from, to, false);
>> +}
>
> I'm OK with the current status, considering it at least enlarge our cancel
> testcases so definitely good to have:
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> Though one thing to mention is the new "test_full()" abstraction doesn't
> yet look like to benefit us a huge lot, IMHO.
>
> These are the new tests:
>
> # /x86_64/migration/cancel/src/after/none
> # /x86_64/migration/cancel/src/after/setup             [*]
> # /x86_64/migration/cancel/src/after/cancelling
> # /x86_64/migration/cancel/src/after/cancelled
> # /x86_64/migration/cancel/src/after/active
> # /x86_64/migration/cancel/src/after/completed
> # /x86_64/migration/cancel/src/after/failed
> # /x86_64/migration/cancel/src/after/pre-switchover    [*]
>
> We have only one abstracted path [1] to test random status, but that so far
> only covers two cases marked with [*].  It is hard to say whether the
> abstraction is necessary, or maybe it's easier we always register separate
> test cases.  So it's still slightly debatable whether we could make all
> above "if .. if else .. if else ... else" into separate tests.
>

It gets super boilerplatey:


    for (int i = MIGRATION_STATUS_NONE; i < MIGRATION_STATUS__MAX; i++) {
        switch (i) {
        case MIGRATION_STATUS_DEVICE:          /* happens too fast */
        case MIGRATION_STATUS_WAIT_UNPLUG:     /* no support in tests */
        case MIGRATION_STATUS_COLO:            /* no support in tests */
        case MIGRATION_STATUS_POSTCOPY_ACTIVE: /* postcopy can't be cancelled */
        case MIGRATION_STATUS_POSTCOPY_PAUSED:
        case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
        case MIGRATION_STATUS_POSTCOPY_RECOVER:
            continue;
        case MIGRATION_STATUS_NONE:
            migration_test_add("/migration/cancel/src/after/none",
                               test_cancel_src_after_none);
            break;
        case MIGRATION_STATUS_SETUP:
            migration_test_add("/migration/cancel/src/after/setup",
                               test_cancel_src_after_setup);
            break;
        case MIGRATION_STATUS_CANCELLING:
            migration_test_add("/migration/cancel/src/after/cancelling",
                               test_cancel_src_after_cancelling);
            break;
        case MIGRATION_STATUS_CANCELLED:
            migration_test_add("/migration/cancel/src/after/cancelled",
                               test_cancel_src_after_cancelled);
            break;
        case MIGRATION_STATUS_ACTIVE:
            migration_test_add("/migration/cancel/src/after/active",
                               test_cancel_src_after_active);
            break;
        case MIGRATION_STATUS_COMPLETED:
            migration_test_add("/migration/cancel/src/after/completed",
                               test_cancel_src_after_completed);
            break;
        case MIGRATION_STATUS_FAILED:
            migration_test_add("/migration/cancel/src/after/failed",
                               test_cancel_src_after_failed);
            break;
        case MIGRATION_STATUS_PRE_SWITCHOVER:
            migration_test_add("/migration/cancel/src/after/pre-switchover",
                               test_cancel_src_after_pre_switchover);
            break;
        }
    }

}

void test_cancel_src_after_cancelling(void)
{
    test_cancel_src_after_cancel("cancelling");
}

void test_cancel_src_after_cancelled(void)
{
    test_cancel_src_after_cancel("cancelled");
}

void test_cancel_src_after_setup(void)
{
    test_cancel_src_after("setup");
}

void test_cancel_src_after_active(void)
{
    test_cancel_src_after("active");
}

void test_cancel_src_after_pre_switchover(void)
{
    test_cancel_src_after("pre-switchover");
}

static void test_cancel_src_after_failed(void)
{
    ...
    migration_event_wait(from, "failed");
    ...
}

static void test_cancel_src_after_cancel(const char *phase)
{
    ...    
    migration_event_wait(from, phase);
    ...
}

static void test_cancel_src_after_complete(void)
{
    migration_event_wait(from, "complete");
    ...
}

static void test_cancel_src_after_none(void)
{
    ...
}

static void test_cancel_src_after(const char *phase)
{
   ...
   migration_event_wait(from, phase);
   ...
}


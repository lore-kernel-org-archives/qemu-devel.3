Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA6DC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 19:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thwN0-0002GI-De; Tue, 11 Feb 2025 14:56:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thwMy-0002Fv-Jp
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 14:56:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thwMw-0008M9-AC
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 14:56:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739303788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ERtkZUPraXTR80P06QF3QtjwOiGmwOkmhRJ6xLVw990=;
 b=Sd6Qv6cg0mV63EXW4aAzBqjThffj0nbjqGLlmmcCwXVHRpeMjB8wJMVEO3H14vbiYD7TK7
 /z163CSRwr/aRRZIrGa2I2L295sxxS+8huRTTCOGz0EpNgd4voSROYIrxSjn9PADW49drn
 c2olphMS8o8dsqOUY5CXsKjVpSUnFPI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473--17iXM3_MCK438Fgkx2ocw-1; Tue, 11 Feb 2025 14:56:26 -0500
X-MC-Unique: -17iXM3_MCK438Fgkx2ocw-1
X-Mimecast-MFC-AGG-ID: -17iXM3_MCK438Fgkx2ocw
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6e45d629308so28677846d6.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 11:56:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739303785; x=1739908585;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ERtkZUPraXTR80P06QF3QtjwOiGmwOkmhRJ6xLVw990=;
 b=FUafVmmPIrnVO1YO5pUOg5j0th8rRPDhgz92Du1LBBwh/KCmXIZDNytPIdcYeu23VL
 n+un0sggb6b7V6ojIF3hoRplGZQ969AOq2wq8LezXllquj/6g92Dyk8VMaRQsex+og8d
 z3BnRKt9nxlOwc8Uhqv98aEuNjLnfU/+fHv8zZj9lON9Jsmu65XRc6P/w6fxof7Xxk9n
 a4Y2q5P7xPODMKFiv+QgENioL611w8Ac6wG2Dt8NSYEWYl2oMpo7DfOK+lc/IhD3H+36
 +LtqUM6XgIi7KyKZ/faZb0gOvxnT3ZlGd/wmRK5o5sUW34lohfreDZa1wQ+QkrEt5e22
 Cv8A==
X-Gm-Message-State: AOJu0YwVFgTQUub3Z0Bso29Iq06tF1YvI4uKWa8ml5m5J05c8knEvgPv
 Q06UtjmxOPCStDWbbp8pwu+OGZYEG2YrMMGb9biqyMdYzfiqUGUYzl4nXHs1SCmErVlQSBx1+rc
 1xgOQifLD68jeU7kt8Hosl8TxnAx0QABu3Hy5zR8CsA/k+0M8NkaE
X-Gm-Gg: ASbGnctUc/xoy6Vu3HI0/deZGg1yEF8+1eq3ZaV5Sl77frkRJi9hInUseLWd41JxXqQ
 cjCAxhFL3LQTXPxjTQqRiwqao5RlPBK/j3/lLzsZhvfSc5m6db884ZSqkdhUv02xTUDRb9EMmWJ
 3+PSQA0C3DKzF9a2dxulzIWRqGESZmGPkWGcPqqZxSQmxjk8OdFj5fayK27eVI4ONIOkzGFBYLM
 PT5SRuVOLI8RItZJ9+xz4gQ25/E+DoEoWGG03385nvQWc7pA0OTCSS2zmk=
X-Received: by 2002:a05:6214:1303:b0:6e4:2d8e:5cce with SMTP id
 6a1803df08f44-6e46edacde7mr14390226d6.36.1739303785383; 
 Tue, 11 Feb 2025 11:56:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXuH++v5vjG8qPhbdCLrwUYS5DZaW3poc2Le0NwdYu2aoyJdCyXA0RpP+zyQbNuAdvjaBbvA==
X-Received: by 2002:a05:6214:1303:b0:6e4:2d8e:5cce with SMTP id
 6a1803df08f44-6e46edacde7mr14389866d6.36.1739303785010; 
 Tue, 11 Feb 2025 11:56:25 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e4524925eesm43718216d6.14.2025.02.11.11.56.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 11:56:24 -0800 (PST)
Date: Tue, 11 Feb 2025 14:56:21 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 8/9] tests/qtest/migration: Add a cancel test
Message-ID: <Z6urZeOyLYRJzMM8@x1.local>
References: <20250211150136.6781-1-farosas@suse.de>
 <20250211150136.6781-9-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250211150136.6781-9-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Feb 11, 2025 at 12:01:35PM -0300, Fabiano Rosas wrote:
> The qmp_migrate_cancel() command is poorly tested and code inspection
> reveals that there might be concurrency issues with its usage. Add a
> test that runs a migration and calls qmp_migrate_cancel() at specific
> moments.
> 
> In order to make the test more deterministic, instead of calling
> qmp_migrate_cancel() at random moments during migration, do it after
> the migration status change events are seen.
> 
> The expected result is that qmp_migrate_cancel() on the source ends
> migration on the source with the "cancelled" state and ends migration
> on the destination with the "failed" state. The only exception is that
> a failed migration should continue in the failed state.
> 
> Cancelling is not allowed during postcopy (no test is added for this
> because it's a trivial check in the code).
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration/precopy-tests.c | 176 ++++++++++++++++++++++++++
>  1 file changed, 176 insertions(+)
> 
> diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
> index 162fa69531..ba273d10b9 100644
> --- a/tests/qtest/migration/precopy-tests.c
> +++ b/tests/qtest/migration/precopy-tests.c
> @@ -20,6 +20,7 @@
>  #include "migration/migration-util.h"
>  #include "ppc-util.h"
>  #include "qobject/qlist.h"
> +#include "qapi-types-migration.h"
>  #include "qemu/module.h"
>  #include "qemu/option.h"
>  #include "qemu/range.h"
> @@ -536,6 +537,161 @@ static void test_multifd_tcp_cancel(void)
>      migrate_end(from, to2, true);
>  }
>  
> +static void test_cancel_src_after_failed(QTestState *from, QTestState *to,
> +                                         const char *uri, const char *phase)
> +{
> +    /*
> +     * No migrate_incoming_qmp() at the start to force source into
> +     * failed state during migrate_qmp().
> +     */
> +
> +    wait_for_serial("src_serial");
> +    migrate_ensure_converge(from);
> +
> +    migrate_qmp(from, to, uri, NULL, "{}");
> +
> +    migration_event_wait(from, phase);
> +    migrate_cancel(from);
> +
> +    /* cancelling will not move the migration out of 'failed' */
> +
> +    wait_for_migration_status(from, "failed",
> +                              (const char * []) { "completed", NULL });
> +
> +    /*
> +     * Not waiting for the destination because it never started
> +     * migration.
> +     */
> +}
> +
> +static void test_cancel_src_after_cancelled(QTestState *from, QTestState *to,
> +                                            const char *uri, const char *phase)
> +{
> +    migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
> +
> +    wait_for_serial("src_serial");
> +    migrate_ensure_converge(from);
> +
> +    migrate_qmp(from, to, uri, NULL, "{}");
> +
> +    /* To move to cancelled/cancelling */
> +    migrate_cancel(from);
> +    migration_event_wait(from, phase);
> +
> +    /* The migrate_cancel under test */
> +    migrate_cancel(from);
> +
> +    wait_for_migration_status(from, "cancelled",
> +                              (const char * []) { "completed", NULL });
> +
> +    wait_for_migration_status(to, "failed",
> +                              (const char * []) { "completed", NULL });
> +}
> +
> +static void test_cancel_src_after_complete(QTestState *from, QTestState *to,
> +                                           const char *uri, const char *phase)
> +{
> +    migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
> +
> +    wait_for_serial("src_serial");
> +    migrate_ensure_converge(from);
> +
> +    migrate_qmp(from, to, uri, NULL, "{}");
> +
> +    migration_event_wait(from, phase);
> +    migrate_cancel(from);
> +
> +    /*
> +     * qmp_migrate_cancel() exits early if migration is not running
> +     * anymore, the status will not change to cancelled.
> +     */
> +    wait_for_migration_complete(from);
> +    wait_for_migration_complete(to);
> +}
> +
> +static void test_cancel_src_after_none(QTestState *from, QTestState *to,
> +                                       const char *uri, const char *phase)
> +{
> +    /*
> +     * Test that cancelling without a migration happening does not
> +     * affect subsequent migrations
> +     */
> +    migrate_cancel(to);
> +
> +    wait_for_serial("src_serial");
> +    migrate_cancel(from);
> +
> +    migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
> +
> +    migrate_ensure_converge(from);
> +    migrate_qmp(from, to, uri, NULL, "{}");
> +
> +    wait_for_migration_complete(from);
> +    wait_for_migration_complete(to);
> +}
> +
> +static void test_cancel_src_pre_switchover(QTestState *from, QTestState *to,
> +                                           const char *uri, const char *phase)
> +{
> +    migrate_set_capability(from, "pause-before-switchover", true);
> +    migrate_set_capability(to, "pause-before-switchover", true);
> +
> +    migrate_set_capability(from, "multifd", true);
> +    migrate_set_capability(to, "multifd", true);
> +
> +    migrate_incoming_qmp(to, uri, NULL, "{ 'exit-on-error': false }");
> +
> +    wait_for_serial("src_serial");
> +    migrate_ensure_converge(from);
> +
> +    migrate_qmp(from, to, uri, NULL, "{}");
> +
> +    migration_event_wait(from, phase);
> +    migrate_cancel(from);
> +    migration_event_wait(from, "cancelling");
> +
> +    wait_for_migration_status(from, "cancelled",
> +                              (const char * []) { "completed", NULL });
> +
> +    wait_for_migration_status(to, "failed",
> +                              (const char * []) { "completed", NULL });
> +}
> +
> +static void test_cancel_src_after_status(void *opaque)
> +{
> +    const char *test_path = opaque;
> +    g_autofree char *phase = g_path_get_basename(test_path);
> +    g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
> +    QTestState *from, *to;
> +    MigrateStart args = {
> +        .hide_stderr = true,
> +    };
> +
> +    if (migrate_start(&from, &to, "defer", &args)) {
> +        return;
> +    }
> +
> +    if (g_str_equal(phase, "cancelling") ||
> +        g_str_equal(phase, "cancelled")) {
> +        test_cancel_src_after_cancelled(from, to, uri, phase);
> +
> +    } else if (g_str_equal(phase, "completed")) {
> +        test_cancel_src_after_complete(from, to, uri, phase);
> +
> +    } else if (g_str_equal(phase, "failed")) {
> +        test_cancel_src_after_failed(from, to, uri, phase);
> +
> +    } else if (g_str_equal(phase, "none")) {
> +        test_cancel_src_after_none(from, to, uri, phase);
> +
> +    } else {
> +        /* any state that comes before pre-switchover */
> +        test_cancel_src_pre_switchover(from, to, uri, phase);

[1]

> +    }
> +
> +    migrate_end(from, to, false);
> +}

I'm OK with the current status, considering it at least enlarge our cancel
testcases so definitely good to have:

Reviewed-by: Peter Xu <peterx@redhat.com>

Though one thing to mention is the new "test_full()" abstraction doesn't
yet look like to benefit us a huge lot, IMHO.

These are the new tests:

# /x86_64/migration/cancel/src/after/none
# /x86_64/migration/cancel/src/after/setup             [*]
# /x86_64/migration/cancel/src/after/cancelling
# /x86_64/migration/cancel/src/after/cancelled
# /x86_64/migration/cancel/src/after/active
# /x86_64/migration/cancel/src/after/completed
# /x86_64/migration/cancel/src/after/failed
# /x86_64/migration/cancel/src/after/pre-switchover    [*]

We have only one abstracted path [1] to test random status, but that so far
only covers two cases marked with [*].  It is hard to say whether the
abstraction is necessary, or maybe it's easier we always register separate
test cases.  So it's still slightly debatable whether we could make all
above "if .. if else .. if else ... else" into separate tests.

> +
>  static void calc_dirty_rate(QTestState *who, uint64_t calc_time)
>  {
>      qtest_qmp_assert_success(who,
> @@ -1018,4 +1174,24 @@ void migration_test_add_precopy(MigrationTestEnv *env)
>                                 test_vcpu_dirty_limit);
>          }
>      }
> +
> +    /* ensure new status don't go unnoticed */
> +    assert(MIGRATION_STATUS__MAX == 15);
> +
> +    for (int i = MIGRATION_STATUS_NONE; i < MIGRATION_STATUS__MAX; i++) {
> +        switch (i) {
> +        case MIGRATION_STATUS_DEVICE: /* happens too fast */
> +        case MIGRATION_STATUS_WAIT_UNPLUG: /* no support in tests */
> +        case MIGRATION_STATUS_COLO: /* no support in tests */
> +        case MIGRATION_STATUS_POSTCOPY_ACTIVE: /* postcopy can't be cancelled */
> +        case MIGRATION_STATUS_POSTCOPY_PAUSED:
> +        case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
> +        case MIGRATION_STATUS_POSTCOPY_RECOVER:
> +            continue;
> +        default:
> +            migration_test_add_suffix("/migration/cancel/src/after/",
> +                                      MigrationStatus_str(i),
> +                                      test_cancel_src_after_status);
> +        }
> +    }
>  }
> -- 
> 2.35.3
> 

-- 
Peter Xu



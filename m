Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CE7D44D46
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 10:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8dep-0000MR-6g; Wed, 06 Nov 2024 05:53:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8den-0000MA-N3
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 05:53:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t8dej-00082q-Qo
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 05:53:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730890376;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=jmnl29xlRclN7kg8s0sjpjPkGtVH89Qf95QE6SIJUi8=;
 b=CKSBrC7Gp/p77kDIUw0heH8NTMNcVNIuwwaiC6nYSmaAuuPdI49XtTvQEjNKzk79QPCOEh
 pbUwKkPTSeK4ha8SpNBuOs1UzMz/yumWzprNvWOcHgnN+vT0xCAvyBDkBTClvmoDDzIkqh
 2vyXcRdbk7mvBfSFMhumRCOjMye3Qyc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-470-6LH_yQhuNcmMzB36LlmGUw-1; Wed,
 06 Nov 2024 05:52:53 -0500
X-MC-Unique: 6LH_yQhuNcmMzB36LlmGUw-1
X-Mimecast-MFC-AGG-ID: 6LH_yQhuNcmMzB36LlmGUw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BC9F19560B4; Wed,  6 Nov 2024 10:52:52 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.182])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22E601956088; Wed,  6 Nov 2024 10:52:48 +0000 (UTC)
Date: Wed, 6 Nov 2024 10:52:45 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 06/22] tests/qtest/migration: Move qmp helpers to a
 separate file
Message-ID: <ZytKfYirP-R1mRNV@redhat.com>
References: <20241105180837.5990-1-farosas@suse.de>
 <20241105180837.5990-7-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241105180837.5990-7-farosas@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Nov 05, 2024 at 03:08:21PM -0300, Fabiano Rosas wrote:
> We current have a bunch of non-test functions in migration-test.c and
> some others in migration-helpers.c. In order to split migration-test.c
> into separate test binaries, these helpers need to go somewhere
> else.
> 
> To avoid making migration-helpers even larger, move all QMP-related
> functions into a new migration-qmp.c file and put it under the
> qtest/migration/ directory.
> 
> The new file holds everything that has as its main responsibility to
> call into QMP.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/meson.build                |   1 +
>  tests/qtest/migration-helpers.c        | 250 +------------
>  tests/qtest/migration-helpers.h        |  18 +-
>  tests/qtest/migration-test.c           | 237 +-----------
>  tests/qtest/migration/migration-qmp.c  | 485 +++++++++++++++++++++++++
>  tests/qtest/migration/migration-util.h |  45 +++

I would have expected the header to be named 'migration-qmp.h' to match
the source file naming, and not merge all of migration-helpers.h into
it in the next patch which seems to partially defeat the point of splitting
up the files.

>  tests/qtest/virtio-net-failover.c      |   1 +
>  7 files changed, 541 insertions(+), 496 deletions(-)
>  create mode 100644 tests/qtest/migration/migration-qmp.c
>  create mode 100644 tests/qtest/migration/migration-util.h
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index f6001a0b0f..30dff3abe0 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -331,6 +331,7 @@ tpmemu_files = ['tpm-emu.c', 'tpm-util.c', 'tpm-tests.c']
>  migration_files = [files(
>    'migration-helpers.c',
>    'migration/bootfile.c',
> +  'migration/migration-qmp.c',
>  )]
>  
>  if gnutls.found()
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index 2786f9c860..218ee4e59f 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -12,7 +12,6 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/ctype.h"
> -#include "qapi/qmp/qjson.h"
>  #include "qapi/qapi-visit-sockets.h"
>  #include "qapi/qobject-input-visitor.h"
>  #include "qapi/error.h"
> @@ -23,14 +22,6 @@
>  #include "migration-helpers.h"
>  #include "migration/bootfile.h"
>  
> -/*
> - * Number of seconds we wait when looking for migration
> - * status changes, to avoid test suite hanging forever
> - * when things go wrong. Needs to be higher enough to
> - * avoid false positives on loaded hosts.
> - */
> -#define MIGRATION_STATUS_WAIT_TIMEOUT 120
> -
>  static char *SocketAddress_to_str(SocketAddress *addr)
>  {
>      switch (addr->type) {
> @@ -100,8 +91,7 @@ static SocketAddressList *migrate_get_socket_address(QTestState *who)
>      return addrs;
>  }
>  
> -static char *
> -migrate_get_connect_uri(QTestState *who)
> +char *migrate_get_connect_uri(QTestState *who)
>  {
>      SocketAddressList *addrs;
>      char *connect_uri;
> @@ -126,7 +116,7 @@ migrate_get_connect_qdict(QTestState *who)
>      return connect_qdict;
>  }
>  
> -static void migrate_set_ports(QTestState *to, QList *channel_list)
> +void migrate_set_ports(QTestState *to, QList *channel_list)
>  {
>      QDict *addr;
>      QListEntry *entry;
> @@ -168,222 +158,6 @@ bool migrate_watch_for_events(QTestState *who, const char *name,
>      return false;
>  }
>  
> -void migrate_qmp_fail(QTestState *who, const char *uri,
> -                      const char *channels, const char *fmt, ...)
> -{
> -    va_list ap;
> -    QDict *args, *err;
> -
> -    va_start(ap, fmt);
> -    args = qdict_from_vjsonf_nofail(fmt, ap);
> -    va_end(ap);
> -
> -    g_assert(!qdict_haskey(args, "uri"));
> -    if (uri) {
> -        qdict_put_str(args, "uri", uri);
> -    }
> -
> -    g_assert(!qdict_haskey(args, "channels"));
> -    if (channels) {
> -        QObject *channels_obj = qobject_from_json(channels, &error_abort);
> -        qdict_put_obj(args, "channels", channels_obj);
> -    }
> -
> -    err = qtest_qmp_assert_failure_ref(
> -        who, "{ 'execute': 'migrate', 'arguments': %p}", args);
> -
> -    g_assert(qdict_haskey(err, "desc"));
> -
> -    qobject_unref(err);
> -}
> -
> -/*
> - * Send QMP command "migrate".
> - * Arguments are built from @fmt... (formatted like
> - * qobject_from_jsonf_nofail()) with "uri": @uri spliced in.
> - */
> -void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
> -                 const char *channels, const char *fmt, ...)
> -{
> -    va_list ap;
> -    QDict *args;
> -    g_autofree char *connect_uri = NULL;
> -
> -    va_start(ap, fmt);
> -    args = qdict_from_vjsonf_nofail(fmt, ap);
> -    va_end(ap);
> -
> -    g_assert(!qdict_haskey(args, "uri"));
> -    if (uri) {
> -        qdict_put_str(args, "uri", uri);
> -    } else if (!channels) {
> -        connect_uri = migrate_get_connect_uri(to);
> -        qdict_put_str(args, "uri", connect_uri);
> -    }
> -
> -    g_assert(!qdict_haskey(args, "channels"));
> -    if (channels) {
> -        QObject *channels_obj = qobject_from_json(channels, &error_abort);
> -        QList *channel_list = qobject_to(QList, channels_obj);
> -        migrate_set_ports(to, channel_list);
> -        qdict_put_obj(args, "channels", channels_obj);
> -    }
> -
> -    qtest_qmp_assert_success(who,
> -                             "{ 'execute': 'migrate', 'arguments': %p}", args);
> -}
> -
> -void migrate_set_capability(QTestState *who, const char *capability,
> -                            bool value)
> -{
> -    qtest_qmp_assert_success(who,
> -                             "{ 'execute': 'migrate-set-capabilities',"
> -                             "'arguments': { "
> -                             "'capabilities': [ { "
> -                             "'capability': %s, 'state': %i } ] } }",
> -                             capability, value);
> -}
> -
> -void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
> -{
> -    va_list ap;
> -    QDict *args, *rsp;
> -
> -    va_start(ap, fmt);
> -    args = qdict_from_vjsonf_nofail(fmt, ap);
> -    va_end(ap);
> -
> -    g_assert(!qdict_haskey(args, "uri"));
> -    qdict_put_str(args, "uri", uri);
> -
> -    /* This function relies on the event to work, make sure it's enabled */
> -    migrate_set_capability(to, "events", true);
> -
> -    rsp = qtest_qmp(to, "{ 'execute': 'migrate-incoming', 'arguments': %p}",
> -                    args);
> -
> -    if (!qdict_haskey(rsp, "return")) {
> -        g_autoptr(GString) s = qobject_to_json_pretty(QOBJECT(rsp), true);
> -        g_test_message("%s", s->str);
> -    }
> -
> -    g_assert(qdict_haskey(rsp, "return"));
> -    qobject_unref(rsp);
> -
> -    migration_event_wait(to, "setup");
> -}
> -
> -/*
> - * Note: caller is responsible to free the returned object via
> - * qobject_unref() after use
> - */
> -QDict *migrate_query(QTestState *who)
> -{
> -    return qtest_qmp_assert_success_ref(who, "{ 'execute': 'query-migrate' }");
> -}
> -
> -QDict *migrate_query_not_failed(QTestState *who)
> -{
> -    const char *status;
> -    QDict *rsp = migrate_query(who);
> -    status = qdict_get_str(rsp, "status");
> -    if (g_str_equal(status, "failed")) {
> -        g_printerr("query-migrate shows failed migration: %s\n",
> -                   qdict_get_str(rsp, "error-desc"));
> -    }
> -    g_assert(!g_str_equal(status, "failed"));
> -    return rsp;
> -}
> -
> -/*
> - * Note: caller is responsible to free the returned object via
> - * g_free() after use
> - */
> -static gchar *migrate_query_status(QTestState *who)
> -{
> -    QDict *rsp_return = migrate_query(who);
> -    gchar *status = g_strdup(qdict_get_str(rsp_return, "status"));
> -
> -    g_assert(status);
> -    qobject_unref(rsp_return);
> -
> -    return status;
> -}
> -
> -static bool check_migration_status(QTestState *who, const char *goal,
> -                                   const char **ungoals)
> -{
> -    bool ready;
> -    char *current_status;
> -    const char **ungoal;
> -
> -    current_status = migrate_query_status(who);
> -    ready = strcmp(current_status, goal) == 0;
> -    if (!ungoals) {
> -        g_assert_cmpstr(current_status, !=, "failed");
> -        /*
> -         * If looking for a state other than completed,
> -         * completion of migration would cause the test to
> -         * hang.
> -         */
> -        if (strcmp(goal, "completed") != 0) {
> -            g_assert_cmpstr(current_status, !=, "completed");
> -        }
> -    } else {
> -        for (ungoal = ungoals; *ungoal; ungoal++) {
> -            g_assert_cmpstr(current_status, !=,  *ungoal);
> -        }
> -    }
> -    g_free(current_status);
> -    return ready;
> -}
> -
> -void wait_for_migration_status(QTestState *who,
> -                               const char *goal, const char **ungoals)
> -{
> -    g_test_timer_start();
> -    while (!check_migration_status(who, goal, ungoals)) {
> -        usleep(1000);
> -
> -        g_assert(g_test_timer_elapsed() < MIGRATION_STATUS_WAIT_TIMEOUT);
> -    }
> -}
> -
> -void wait_for_migration_complete(QTestState *who)
> -{
> -    wait_for_migration_status(who, "completed", NULL);
> -}
> -
> -void wait_for_migration_fail(QTestState *from, bool allow_active)
> -{
> -    g_test_timer_start();
> -    QDict *rsp_return;
> -    char *status;
> -    bool failed;
> -
> -    do {
> -        status = migrate_query_status(from);
> -        bool result = !strcmp(status, "setup") || !strcmp(status, "failed") ||
> -            (allow_active && !strcmp(status, "active"));
> -        if (!result) {
> -            fprintf(stderr, "%s: unexpected status status=%s allow_active=%d\n",
> -                    __func__, status, allow_active);
> -        }
> -        g_assert(result);
> -        failed = !strcmp(status, "failed");
> -        g_free(status);
> -
> -        g_assert(g_test_timer_elapsed() < MIGRATION_STATUS_WAIT_TIMEOUT);
> -    } while (!failed);
> -
> -    /* Is the machine currently running? */
> -    rsp_return = qtest_qmp_assert_success_ref(from,
> -                                              "{ 'execute': 'query-status' }");
> -    g_assert(qdict_haskey(rsp_return, "running"));
> -    g_assert(qdict_get_bool(rsp_return, "running"));
> -    qobject_unref(rsp_return);
> -}
> -
>  char *find_common_machine_version(const char *mtype, const char *var1,
>                                    const char *var2)
>  {
> @@ -509,23 +283,3 @@ bool probe_o_direct_support(const char *tmpfs)
>      return true;
>  }
>  #endif
> -
> -/*
> - * Wait for a "MIGRATION" event.  This is what Libvirt uses to track
> - * migration status changes.
> - */
> -void migration_event_wait(QTestState *s, const char *target)
> -{
> -    QDict *response, *data;
> -    const char *status;
> -    bool found;
> -
> -    do {
> -        response = qtest_qmp_eventwait_ref(s, "MIGRATION");
> -        data = qdict_get_qdict(response, "data");
> -        g_assert(data);
> -        status = qdict_get_str(data, "status");
> -        found = (strcmp(status, target) == 0);
> -        qobject_unref(response);
> -    } while (!found);
> -}
> diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
> index 72dba369fb..2cb1f78d9e 100644
> --- a/tests/qtest/migration-helpers.h
> +++ b/tests/qtest/migration-helpers.h
> @@ -25,21 +25,6 @@ typedef struct QTestMigrationState {
>  bool migrate_watch_for_events(QTestState *who, const char *name,
>                                QDict *event, void *opaque);
>  
> -G_GNUC_PRINTF(5, 6)
> -void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
> -                 const char *channels, const char *fmt, ...);
> -
> -G_GNUC_PRINTF(3, 4)
> -void migrate_incoming_qmp(QTestState *who, const char *uri,
> -                          const char *fmt, ...);
> -
> -G_GNUC_PRINTF(4, 5)
> -void migrate_qmp_fail(QTestState *who, const char *uri,
> -                      const char *channels, const char *fmt, ...);
> -
> -void migrate_set_capability(QTestState *who, const char *capability,
> -                            bool value);
> -
>  QDict *migrate_query(QTestState *who);
>  QDict *migrate_query_not_failed(QTestState *who);
>  
> @@ -63,6 +48,7 @@ static inline bool probe_o_direct_support(const char *tmpfs)
>  }
>  #endif
>  void migration_test_add(const char *path, void (*fn)(void));
> -void migration_event_wait(QTestState *s, const char *target);
> +char *migrate_get_connect_uri(QTestState *who);
> +void migrate_set_ports(QTestState *to, QList *channel_list);
>  
>  #endif /* MIGRATION_HELPERS_H */
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 599adc422c..f55423467d 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -13,18 +13,18 @@
>  #include "qemu/osdep.h"
>  
>  #include "libqtest.h"
> -#include "qapi/qmp/qdict.h"
> +#include "qapi/qmp/qlist.h"
>  #include "qemu/module.h"
>  #include "qemu/option.h"
>  #include "qemu/range.h"
>  #include "qemu/sockets.h"
>  #include "chardev/char.h"
>  #include "crypto/tlscredspsk.h"
> -#include "qapi/qmp/qlist.h"
>  #include "ppc-util.h"
>  
>  #include "migration-helpers.h"
>  #include "migration/bootfile.h"
> +#include "migration/migration-util.h"
>  #ifdef CONFIG_GNUTLS
>  # include "tests/unit/crypto-tls-psk-helpers.h"
>  # ifdef CONFIG_TASN1
> @@ -170,89 +170,6 @@ static void wait_for_serial(const char *side)
>      } while (true);
>  }
>  
> -static void wait_for_stop(QTestState *who, QTestMigrationState *state)
> -{
> -    if (!state->stop_seen) {
> -        qtest_qmp_eventwait(who, "STOP");
> -    }
> -}
> -
> -static void wait_for_resume(QTestState *who, QTestMigrationState *state)
> -{
> -    if (!state->resume_seen) {
> -        qtest_qmp_eventwait(who, "RESUME");
> -    }
> -}
> -
> -static void wait_for_suspend(QTestState *who, QTestMigrationState *state)
> -{
> -    if (state->suspend_me && !state->suspend_seen) {
> -        qtest_qmp_eventwait(who, "SUSPEND");
> -    }
> -}
> -
> -/*
> - * It's tricky to use qemu's migration event capability with qtest,
> - * events suddenly appearing confuse the qmp()/hmp() responses.
> - */
> -
> -static int64_t read_ram_property_int(QTestState *who, const char *property)
> -{
> -    QDict *rsp_return, *rsp_ram;
> -    int64_t result;
> -
> -    rsp_return = migrate_query_not_failed(who);
> -    if (!qdict_haskey(rsp_return, "ram")) {
> -        /* Still in setup */
> -        result = 0;
> -    } else {
> -        rsp_ram = qdict_get_qdict(rsp_return, "ram");
> -        result = qdict_get_try_int(rsp_ram, property, 0);
> -    }
> -    qobject_unref(rsp_return);
> -    return result;
> -}
> -
> -static int64_t read_migrate_property_int(QTestState *who, const char *property)
> -{
> -    QDict *rsp_return;
> -    int64_t result;
> -
> -    rsp_return = migrate_query_not_failed(who);
> -    result = qdict_get_try_int(rsp_return, property, 0);
> -    qobject_unref(rsp_return);
> -    return result;
> -}
> -
> -static uint64_t get_migration_pass(QTestState *who)
> -{
> -    return read_ram_property_int(who, "dirty-sync-count");
> -}
> -
> -static void read_blocktime(QTestState *who)
> -{
> -    QDict *rsp_return;
> -
> -    rsp_return = migrate_query_not_failed(who);
> -    g_assert(qdict_haskey(rsp_return, "postcopy-blocktime"));
> -    qobject_unref(rsp_return);
> -}
> -
> -/*
> - * Wait for two changes in the migration pass count, but bail if we stop.
> - */
> -static void wait_for_migration_pass(QTestState *who)
> -{
> -    uint64_t pass, prev_pass = 0, changes = 0;
> -
> -    while (changes < 2 && !src_state.stop_seen && !src_state.suspend_seen) {
> -        usleep(1000);
> -        pass = get_migration_pass(who);
> -        changes += (pass != prev_pass);
> -        prev_pass = pass;
> -    }
> -}
> -
>  static void check_guests_ram(QTestState *who)
>  {
>      /* Our ASM test will have been incrementing one byte from each page from
> @@ -308,114 +225,6 @@ static void cleanup(const char *filename)
>      unlink(path);
>  }
>  
> -static long long migrate_get_parameter_int(QTestState *who,
> -                                           const char *parameter)
> -{
> -    QDict *rsp;
> -    long long result;
> -
> -    rsp = qtest_qmp_assert_success_ref(
> -        who, "{ 'execute': 'query-migrate-parameters' }");
> -    result = qdict_get_int(rsp, parameter);
> -    qobject_unref(rsp);
> -    return result;
> -}
> -
> -static void migrate_check_parameter_int(QTestState *who, const char *parameter,
> -                                        long long value)
> -{
> -    long long result;
> -
> -    result = migrate_get_parameter_int(who, parameter);
> -    g_assert_cmpint(result, ==, value);
> -}
> -
> -static void migrate_set_parameter_int(QTestState *who, const char *parameter,
> -                                      long long value)
> -{
> -    qtest_qmp_assert_success(who,
> -                             "{ 'execute': 'migrate-set-parameters',"
> -                             "'arguments': { %s: %lld } }",
> -                             parameter, value);
> -    migrate_check_parameter_int(who, parameter, value);
> -}
> -
> -static char *migrate_get_parameter_str(QTestState *who,
> -                                       const char *parameter)
> -{
> -    QDict *rsp;
> -    char *result;
> -
> -    rsp = qtest_qmp_assert_success_ref(
> -        who, "{ 'execute': 'query-migrate-parameters' }");
> -    result = g_strdup(qdict_get_str(rsp, parameter));
> -    qobject_unref(rsp);
> -    return result;
> -}
> -
> -static void migrate_check_parameter_str(QTestState *who, const char *parameter,
> -                                        const char *value)
> -{
> -    g_autofree char *result = migrate_get_parameter_str(who, parameter);
> -    g_assert_cmpstr(result, ==, value);
> -}
> -
> -static void migrate_set_parameter_str(QTestState *who, const char *parameter,
> -                                      const char *value)
> -{
> -    qtest_qmp_assert_success(who,
> -                             "{ 'execute': 'migrate-set-parameters',"
> -                             "'arguments': { %s: %s } }",
> -                             parameter, value);
> -    migrate_check_parameter_str(who, parameter, value);
> -}
> -
> -static long long migrate_get_parameter_bool(QTestState *who,
> -                                            const char *parameter)
> -{
> -    QDict *rsp;
> -    int result;
> -
> -    rsp = qtest_qmp_assert_success_ref(
> -        who, "{ 'execute': 'query-migrate-parameters' }");
> -    result = qdict_get_bool(rsp, parameter);
> -    qobject_unref(rsp);
> -    return !!result;
> -}
> -
> -static void migrate_check_parameter_bool(QTestState *who, const char *parameter,
> -                                         int value)
> -{
> -    int result;
> -
> -    result = migrate_get_parameter_bool(who, parameter);
> -    g_assert_cmpint(result, ==, value);
> -}
> -
> -static void migrate_set_parameter_bool(QTestState *who, const char *parameter,
> -                                       int value)
> -{
> -    qtest_qmp_assert_success(who,
> -                             "{ 'execute': 'migrate-set-parameters',"
> -                             "'arguments': { %s: %i } }",
> -                             parameter, value);
> -    migrate_check_parameter_bool(who, parameter, value);
> -}
> -
> -static void migrate_ensure_non_converge(QTestState *who)
> -{
> -    /* Can't converge with 1ms downtime + 3 mbs bandwidth limit */
> -    migrate_set_parameter_int(who, "max-bandwidth", 3 * 1000 * 1000);
> -    migrate_set_parameter_int(who, "downtime-limit", 1);
> -}
> -
> -static void migrate_ensure_converge(QTestState *who)
> -{
> -    /* Should converge with 30s downtime + 1 gbs bandwidth limit */
> -    migrate_set_parameter_int(who, "max-bandwidth", 1 * 1000 * 1000 * 1000);
> -    migrate_set_parameter_int(who, "downtime-limit", 30 * 1000);
> -}
> -
>  /*
>   * Our goal is to ensure that we run a single full migration
>   * iteration, and also dirty memory, ensuring that at least
> @@ -506,42 +315,6 @@ static void migrate_wait_for_dirty_mem(QTestState *from,
>      } while (qtest_readb(from, watch_address) == watch_byte);
>  }
>  
> -
> -static void migrate_pause(QTestState *who)
> -{
> -    qtest_qmp_assert_success(who, "{ 'execute': 'migrate-pause' }");
> -}
> -
> -static void migrate_continue(QTestState *who, const char *state)
> -{
> -    qtest_qmp_assert_success(who,
> -                             "{ 'execute': 'migrate-continue',"
> -                             "  'arguments': { 'state': %s } }",
> -                             state);
> -}
> -
> -static void migrate_recover(QTestState *who, const char *uri)
> -{
> -    qtest_qmp_assert_success(who,
> -                             "{ 'execute': 'migrate-recover', "
> -                             "  'id': 'recover-cmd', "
> -                             "  'arguments': { 'uri': %s } }",
> -                             uri);
> -}
> -
> -static void migrate_cancel(QTestState *who)
> -{
> -    qtest_qmp_assert_success(who, "{ 'execute': 'migrate_cancel' }");
> -}
> -
> -static void migrate_postcopy_start(QTestState *from, QTestState *to)
> -{
> -    qtest_qmp_assert_success(from, "{ 'execute': 'migrate-start-postcopy' }");
> -
> -    wait_for_stop(from, &src_state);
> -    qtest_qmp_eventwait(to, "RESUME");
> -}
> -
>  typedef struct {
>      /*
>       * QTEST_LOG=1 may override this.  When QTEST_LOG=1, we always dump errors
> @@ -1277,7 +1050,7 @@ static void test_postcopy_common(MigrateCommon *args)
>      if (migrate_postcopy_prepare(&from, &to, args)) {
>          return;
>      }
> -    migrate_postcopy_start(from, to);
> +    migrate_postcopy_start(from, to, &src_state);
>      migrate_postcopy_complete(from, to, args);
>  }
>  
> @@ -1464,7 +1237,7 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
>      migrate_set_parameter_int(from, "max-postcopy-bandwidth", 4096);
>  
>      /* Now we start the postcopy */
> -    migrate_postcopy_start(from, to);
> +    migrate_postcopy_start(from, to, &src_state);
>  
>      /*
>       * Wait until postcopy is really started; we can only run the
> @@ -1704,7 +1477,7 @@ static void test_precopy_common(MigrateCommon *args)
>               * for some dirty mem before switching to converge
>               */
>              while (args->iterations > 1) {
> -                wait_for_migration_pass(from);
> +                wait_for_migration_pass(from, &src_state);
>                  args->iterations--;
>              }
>              migrate_wait_for_dirty_mem(from, to);
> diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
> new file mode 100644
> index 0000000000..89e069e96b
> --- /dev/null
> +++ b/tests/qtest/migration/migration-qmp.c
> @@ -0,0 +1,485 @@
> +/*
> + * QTest QMP helpers for migration
> + *
> + * Copyright (c) 2016-2018 Red Hat, Inc. and/or its affiliates
> + *   based on the vhost-user-test.c that is:
> + *      Copyright (c) 2014 Virtual Open Systems Sarl.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "libqtest.h"
> +#include "migration-helpers.h"
> +#include "migration-util.h"
> +#include "qapi/error.h"
> +#include "qapi/qmp/qdict.h"
> +#include "qapi/qmp/qjson.h"
> +#include "qapi/qmp/qlist.h"
> +
> +/*
> + * Number of seconds we wait when looking for migration
> + * status changes, to avoid test suite hanging forever
> + * when things go wrong. Needs to be higher enough to
> + * avoid false positives on loaded hosts.
> + */
> +#define MIGRATION_STATUS_WAIT_TIMEOUT 120
> +
> +/*
> + * Wait for a "MIGRATION" event.  This is what Libvirt uses to track
> + * migration status changes.
> + */
> +void migration_event_wait(QTestState *s, const char *target)
> +{
> +    QDict *response, *data;
> +    const char *status;
> +    bool found;
> +
> +    do {
> +        response = qtest_qmp_eventwait_ref(s, "MIGRATION");
> +        data = qdict_get_qdict(response, "data");
> +        g_assert(data);
> +        status = qdict_get_str(data, "status");
> +        found = (strcmp(status, target) == 0);
> +        qobject_unref(response);
> +    } while (!found);
> +}
> +
> +void migrate_qmp_fail(QTestState *who, const char *uri,
> +                      const char *channels, const char *fmt, ...)
> +{
> +    va_list ap;
> +    QDict *args, *err;
> +
> +    va_start(ap, fmt);
> +    args = qdict_from_vjsonf_nofail(fmt, ap);
> +    va_end(ap);
> +
> +    g_assert(!qdict_haskey(args, "uri"));
> +    if (uri) {
> +        qdict_put_str(args, "uri", uri);
> +    }
> +
> +    g_assert(!qdict_haskey(args, "channels"));
> +    if (channels) {
> +        QObject *channels_obj = qobject_from_json(channels, &error_abort);
> +        qdict_put_obj(args, "channels", channels_obj);
> +    }
> +
> +    err = qtest_qmp_assert_failure_ref(
> +        who, "{ 'execute': 'migrate', 'arguments': %p}", args);
> +
> +    g_assert(qdict_haskey(err, "desc"));
> +
> +    qobject_unref(err);
> +}
> +
> +/*
> + * Send QMP command "migrate".
> + * Arguments are built from @fmt... (formatted like
> + * qobject_from_jsonf_nofail()) with "uri": @uri spliced in.
> + */
> +void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
> +                 const char *channels, const char *fmt, ...)
> +{
> +    va_list ap;
> +    QDict *args;
> +    g_autofree char *connect_uri = NULL;
> +
> +    va_start(ap, fmt);
> +    args = qdict_from_vjsonf_nofail(fmt, ap);
> +    va_end(ap);
> +
> +    g_assert(!qdict_haskey(args, "uri"));
> +    if (uri) {
> +        qdict_put_str(args, "uri", uri);
> +    } else if (!channels) {
> +        connect_uri = migrate_get_connect_uri(to);
> +        qdict_put_str(args, "uri", connect_uri);
> +    }
> +
> +    g_assert(!qdict_haskey(args, "channels"));
> +    if (channels) {
> +        QObject *channels_obj = qobject_from_json(channels, &error_abort);
> +        QList *channel_list = qobject_to(QList, channels_obj);
> +        migrate_set_ports(to, channel_list);
> +        qdict_put_obj(args, "channels", channels_obj);
> +    }
> +
> +    qtest_qmp_assert_success(who,
> +                             "{ 'execute': 'migrate', 'arguments': %p}", args);
> +}
> +
> +void migrate_set_capability(QTestState *who, const char *capability,
> +                            bool value)
> +{
> +    qtest_qmp_assert_success(who,
> +                             "{ 'execute': 'migrate-set-capabilities',"
> +                             "'arguments': { "
> +                             "'capabilities': [ { "
> +                             "'capability': %s, 'state': %i } ] } }",
> +                             capability, value);
> +}
> +
> +void migrate_incoming_qmp(QTestState *to, const char *uri, const char *fmt, ...)
> +{
> +    va_list ap;
> +    QDict *args, *rsp;
> +
> +    va_start(ap, fmt);
> +    args = qdict_from_vjsonf_nofail(fmt, ap);
> +    va_end(ap);
> +
> +    g_assert(!qdict_haskey(args, "uri"));
> +    qdict_put_str(args, "uri", uri);
> +
> +    /* This function relies on the event to work, make sure it's enabled */
> +    migrate_set_capability(to, "events", true);
> +
> +    rsp = qtest_qmp(to, "{ 'execute': 'migrate-incoming', 'arguments': %p}",
> +                    args);
> +
> +    if (!qdict_haskey(rsp, "return")) {
> +        g_autoptr(GString) s = qobject_to_json_pretty(QOBJECT(rsp), true);
> +        g_test_message("%s", s->str);
> +    }
> +
> +    g_assert(qdict_haskey(rsp, "return"));
> +    qobject_unref(rsp);
> +
> +    migration_event_wait(to, "setup");
> +}
> +
> +static bool check_migration_status(QTestState *who, const char *goal,
> +                                   const char **ungoals)
> +{
> +    bool ready;
> +    char *current_status;
> +    const char **ungoal;
> +
> +    current_status = migrate_query_status(who);
> +    ready = strcmp(current_status, goal) == 0;
> +    if (!ungoals) {
> +        g_assert_cmpstr(current_status, !=, "failed");
> +        /*
> +         * If looking for a state other than completed,
> +         * completion of migration would cause the test to
> +         * hang.
> +         */
> +        if (strcmp(goal, "completed") != 0) {
> +            g_assert_cmpstr(current_status, !=, "completed");
> +        }
> +    } else {
> +        for (ungoal = ungoals; *ungoal; ungoal++) {
> +            g_assert_cmpstr(current_status, !=,  *ungoal);
> +        }
> +    }
> +    g_free(current_status);
> +    return ready;
> +}
> +
> +void wait_for_migration_status(QTestState *who,
> +                               const char *goal, const char **ungoals)
> +{
> +    g_test_timer_start();
> +    while (!check_migration_status(who, goal, ungoals)) {
> +        usleep(1000);
> +
> +        g_assert(g_test_timer_elapsed() < MIGRATION_STATUS_WAIT_TIMEOUT);
> +    }
> +}
> +
> +void wait_for_migration_complete(QTestState *who)
> +{
> +    wait_for_migration_status(who, "completed", NULL);
> +}
> +
> +void wait_for_migration_fail(QTestState *from, bool allow_active)
> +{
> +    g_test_timer_start();
> +    QDict *rsp_return;
> +    char *status;
> +    bool failed;
> +
> +    do {
> +        status = migrate_query_status(from);
> +        bool result = !strcmp(status, "setup") || !strcmp(status, "failed") ||
> +            (allow_active && !strcmp(status, "active"));
> +        if (!result) {
> +            fprintf(stderr, "%s: unexpected status status=%s allow_active=%d\n",
> +                    __func__, status, allow_active);
> +        }
> +        g_assert(result);
> +        failed = !strcmp(status, "failed");
> +        g_free(status);
> +
> +        g_assert(g_test_timer_elapsed() < MIGRATION_STATUS_WAIT_TIMEOUT);
> +    } while (!failed);
> +
> +    /* Is the machine currently running? */
> +    rsp_return = qtest_qmp_assert_success_ref(from,
> +                                              "{ 'execute': 'query-status' }");
> +    g_assert(qdict_haskey(rsp_return, "running"));
> +    g_assert(qdict_get_bool(rsp_return, "running"));
> +    qobject_unref(rsp_return);
> +}
> +
> +void wait_for_stop(QTestState *who, QTestMigrationState *state)
> +{
> +    if (!state->stop_seen) {
> +        qtest_qmp_eventwait(who, "STOP");
> +    }
> +}
> +
> +void wait_for_resume(QTestState *who, QTestMigrationState *state)
> +{
> +    if (!state->resume_seen) {
> +        qtest_qmp_eventwait(who, "RESUME");
> +    }
> +}
> +
> +void wait_for_suspend(QTestState *who, QTestMigrationState *state)
> +{
> +    if (state->suspend_me && !state->suspend_seen) {
> +        qtest_qmp_eventwait(who, "SUSPEND");
> +    }
> +}
> +
> +/*
> + * Note: caller is responsible to free the returned object via
> + * qobject_unref() after use
> + */
> +QDict *migrate_query(QTestState *who)
> +{
> +    return qtest_qmp_assert_success_ref(who, "{ 'execute': 'query-migrate' }");
> +}
> +
> +QDict *migrate_query_not_failed(QTestState *who)
> +{
> +    const char *status;
> +    QDict *rsp = migrate_query(who);
> +    status = qdict_get_str(rsp, "status");
> +    if (g_str_equal(status, "failed")) {
> +        g_printerr("query-migrate shows failed migration: %s\n",
> +                   qdict_get_str(rsp, "error-desc"));
> +    }
> +    g_assert(!g_str_equal(status, "failed"));
> +    return rsp;
> +}
> +
> +/*
> + * Note: caller is responsible to free the returned object via
> + * g_free() after use
> + */
> +gchar *migrate_query_status(QTestState *who)
> +{
> +    QDict *rsp_return = migrate_query(who);
> +    gchar *status = g_strdup(qdict_get_str(rsp_return, "status"));
> +
> +    g_assert(status);
> +    qobject_unref(rsp_return);
> +
> +    return status;
> +}
> +
> +int64_t read_ram_property_int(QTestState *who, const char *property)
> +{
> +    QDict *rsp_return, *rsp_ram;
> +    int64_t result;
> +
> +    rsp_return = migrate_query_not_failed(who);
> +    if (!qdict_haskey(rsp_return, "ram")) {
> +        /* Still in setup */
> +        result = 0;
> +    } else {
> +        rsp_ram = qdict_get_qdict(rsp_return, "ram");
> +        result = qdict_get_try_int(rsp_ram, property, 0);
> +    }
> +    qobject_unref(rsp_return);
> +    return result;
> +}
> +
> +int64_t read_migrate_property_int(QTestState *who, const char *property)
> +{
> +    QDict *rsp_return;
> +    int64_t result;
> +
> +    rsp_return = migrate_query_not_failed(who);
> +    result = qdict_get_try_int(rsp_return, property, 0);
> +    qobject_unref(rsp_return);
> +    return result;
> +}
> +
> +uint64_t get_migration_pass(QTestState *who)
> +{
> +    return read_ram_property_int(who, "dirty-sync-count");
> +}
> +
> +void read_blocktime(QTestState *who)
> +{
> +    QDict *rsp_return;
> +
> +    rsp_return = migrate_query_not_failed(who);
> +    g_assert(qdict_haskey(rsp_return, "postcopy-blocktime"));
> +    qobject_unref(rsp_return);
> +}
> +
> +/*
> + * Wait for two changes in the migration pass count, but bail if we stop.
> + */
> +void wait_for_migration_pass(QTestState *who, QTestMigrationState *src_state)
> +{
> +    uint64_t pass, prev_pass = 0, changes = 0;
> +
> +    while (changes < 2 && !src_state->stop_seen && !src_state->suspend_seen) {
> +        usleep(1000);
> +        pass = get_migration_pass(who);
> +        changes += (pass != prev_pass);
> +        prev_pass = pass;
> +    }
> +}
> +
> +static long long migrate_get_parameter_int(QTestState *who,
> +                                           const char *parameter)
> +{
> +    QDict *rsp;
> +    long long result;
> +
> +    rsp = qtest_qmp_assert_success_ref(
> +        who, "{ 'execute': 'query-migrate-parameters' }");
> +    result = qdict_get_int(rsp, parameter);
> +    qobject_unref(rsp);
> +    return result;
> +}
> +
> +static void migrate_check_parameter_int(QTestState *who, const char *parameter,
> +                                        long long value)
> +{
> +    long long result;
> +
> +    result = migrate_get_parameter_int(who, parameter);
> +    g_assert_cmpint(result, ==, value);
> +}
> +
> +void migrate_set_parameter_int(QTestState *who, const char *parameter,
> +                               long long value)
> +{
> +    qtest_qmp_assert_success(who,
> +                             "{ 'execute': 'migrate-set-parameters',"
> +                             "'arguments': { %s: %lld } }",
> +                             parameter, value);
> +    migrate_check_parameter_int(who, parameter, value);
> +}
> +
> +static char *migrate_get_parameter_str(QTestState *who, const char *parameter)
> +{
> +    QDict *rsp;
> +    char *result;
> +
> +    rsp = qtest_qmp_assert_success_ref(
> +        who, "{ 'execute': 'query-migrate-parameters' }");
> +    result = g_strdup(qdict_get_str(rsp, parameter));
> +    qobject_unref(rsp);
> +    return result;
> +}
> +
> +static void migrate_check_parameter_str(QTestState *who, const char *parameter,
> +                                        const char *value)
> +{
> +    g_autofree char *result = migrate_get_parameter_str(who, parameter);
> +    g_assert_cmpstr(result, ==, value);
> +}
> +
> +void migrate_set_parameter_str(QTestState *who, const char *parameter,
> +                               const char *value)
> +{
> +    qtest_qmp_assert_success(who,
> +                             "{ 'execute': 'migrate-set-parameters',"
> +                             "'arguments': { %s: %s } }",
> +                             parameter, value);
> +    migrate_check_parameter_str(who, parameter, value);
> +}
> +
> +static long long migrate_get_parameter_bool(QTestState *who,
> +                                            const char *parameter)
> +{
> +    QDict *rsp;
> +    int result;
> +
> +    rsp = qtest_qmp_assert_success_ref(
> +        who, "{ 'execute': 'query-migrate-parameters' }");
> +    result = qdict_get_bool(rsp, parameter);
> +    qobject_unref(rsp);
> +    return !!result;
> +}
> +
> +static void migrate_check_parameter_bool(QTestState *who, const char *parameter,
> +                                         int value)
> +{
> +    int result;
> +
> +    result = migrate_get_parameter_bool(who, parameter);
> +    g_assert_cmpint(result, ==, value);
> +}
> +
> +void migrate_set_parameter_bool(QTestState *who, const char *parameter,
> +                                int value)
> +{
> +    qtest_qmp_assert_success(who,
> +                             "{ 'execute': 'migrate-set-parameters',"
> +                             "'arguments': { %s: %i } }",
> +                             parameter, value);
> +    migrate_check_parameter_bool(who, parameter, value);
> +}
> +
> +void migrate_ensure_non_converge(QTestState *who)
> +{
> +    /* Can't converge with 1ms downtime + 3 mbs bandwidth limit */
> +    migrate_set_parameter_int(who, "max-bandwidth", 3 * 1000 * 1000);
> +    migrate_set_parameter_int(who, "downtime-limit", 1);
> +}
> +
> +void migrate_ensure_converge(QTestState *who)
> +{
> +    /* Should converge with 30s downtime + 1 gbs bandwidth limit */
> +    migrate_set_parameter_int(who, "max-bandwidth", 1 * 1000 * 1000 * 1000);
> +    migrate_set_parameter_int(who, "downtime-limit", 30 * 1000);
> +}
> +
> +void migrate_pause(QTestState *who)
> +{
> +    qtest_qmp_assert_success(who, "{ 'execute': 'migrate-pause' }");
> +}
> +
> +void migrate_continue(QTestState *who, const char *state)
> +{
> +    qtest_qmp_assert_success(who,
> +                             "{ 'execute': 'migrate-continue',"
> +                             "  'arguments': { 'state': %s } }",
> +                             state);
> +}
> +
> +void migrate_recover(QTestState *who, const char *uri)
> +{
> +    qtest_qmp_assert_success(who,
> +                             "{ 'execute': 'migrate-recover', "
> +                             "  'id': 'recover-cmd', "
> +                             "  'arguments': { 'uri': %s } }",
> +                             uri);
> +}
> +
> +void migrate_cancel(QTestState *who)
> +{
> +    qtest_qmp_assert_success(who, "{ 'execute': 'migrate_cancel' }");
> +}
> +
> +void migrate_postcopy_start(QTestState *from, QTestState *to,
> +                            QTestMigrationState *src_state)
> +{
> +    qtest_qmp_assert_success(from, "{ 'execute': 'migrate-start-postcopy' }");
> +
> +    wait_for_stop(from, src_state);
> +    qtest_qmp_eventwait(to, "RESUME");
> +}
> diff --git a/tests/qtest/migration/migration-util.h b/tests/qtest/migration/migration-util.h
> new file mode 100644
> index 0000000000..e73fa5a70c
> --- /dev/null
> +++ b/tests/qtest/migration/migration-util.h
> @@ -0,0 +1,45 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef MIGRATION_UTIL_H
> +#define MIGRATION_UTIL_H
> +
> +/* migration-qmp.c */
> +G_GNUC_PRINTF(4, 5)
> +void migrate_qmp_fail(QTestState *who, const char *uri,
> +                      const char *channels, const char *fmt, ...);
> +
> +G_GNUC_PRINTF(5, 6)
> +void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
> +                 const char *channels, const char *fmt, ...);
> +
> +G_GNUC_PRINTF(3, 4)
> +void migrate_incoming_qmp(QTestState *who, const char *uri,
> +                          const char *fmt, ...);
> +
> +void migration_event_wait(QTestState *s, const char *target);
> +void migrate_set_capability(QTestState *who, const char *capability,
> +                            bool value);
> +int64_t read_ram_property_int(QTestState *who, const char *property);
> +void migrate_set_parameter_int(QTestState *who, const char *parameter,
> +                               long long value);
> +void wait_for_stop(QTestState *who, QTestMigrationState *state);
> +void wait_for_resume(QTestState *who, QTestMigrationState *state);
> +void wait_for_suspend(QTestState *who, QTestMigrationState *state);
> +gchar *migrate_query_status(QTestState *who);
> +int64_t read_migrate_property_int(QTestState *who, const char *property);
> +uint64_t get_migration_pass(QTestState *who);
> +void read_blocktime(QTestState *who);
> +void wait_for_migration_pass(QTestState *who, QTestMigrationState *src_state);
> +void migrate_set_parameter_str(QTestState *who, const char *parameter,
> +                               const char *value);
> +void migrate_set_parameter_bool(QTestState *who, const char *parameter,
> +                                int value);
> +void migrate_ensure_non_converge(QTestState *who);
> +void migrate_ensure_converge(QTestState *who);
> +void migrate_pause(QTestState *who);
> +void migrate_continue(QTestState *who, const char *state);
> +void migrate_recover(QTestState *who, const char *uri);
> +void migrate_cancel(QTestState *who);
> +void migrate_postcopy_start(QTestState *from, QTestState *to,
> +                            QTestMigrationState *src_state);
> +
> +#endif /* MIGRATION_UTIL_H */
> diff --git a/tests/qtest/virtio-net-failover.c b/tests/qtest/virtio-net-failover.c
> index 73dfabc272..a1c2c70c3a 100644
> --- a/tests/qtest/virtio-net-failover.c
> +++ b/tests/qtest/virtio-net-failover.c
> @@ -12,6 +12,7 @@
>  #include "libqos/pci.h"
>  #include "libqos/pci-pc.h"
>  #include "migration-helpers.h"
> +#include "migration/migration-util.h"
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qlist.h"
>  #include "qapi/qmp/qjson.h"
> -- 
> 2.35.3
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|



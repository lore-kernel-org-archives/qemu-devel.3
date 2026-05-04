Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F0BCD3430
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 14:31:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJuJy-0002cA-8r; Mon, 04 May 2026 10:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wJuJX-0002bZ-8z
 for qemu-devel@nongnu.org; Mon, 04 May 2026 10:30:28 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wJuJU-0000bO-Pu
 for qemu-devel@nongnu.org; Mon, 04 May 2026 10:30:27 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5130F6B2EA;
 Mon,  4 May 2026 14:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777905017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CTNAnCDk+L0dItDu9DM3u9DyDKg5Bg3QW62k6iuKpXA=;
 b=N/aHz7hUeLwFqOe/0Z8V7XfU+JnVIffnRuA3csYleQadUwMmc1mDlVdnn6d6w3XwnR0caS
 p5Xe9tZW4RWakkeRQLqSKa3YzDN0F3UhC0rRRAjc9FbNBO8fcOvFUM92Zfw+LZEXukhqAI
 Mt5lA94SSol56C8VSCwrJ7fGeu7krMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777905017;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CTNAnCDk+L0dItDu9DM3u9DyDKg5Bg3QW62k6iuKpXA=;
 b=at3EVxCxO9T1DF1LrcA0EUMfZ8MZv5aVOSOpDZP9IhsGA1xoUOUH+/sfhzpx2/21fowsZk
 omyLzQ0E8kmKEECQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="N/aHz7hU";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=at3EVxCx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777905017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CTNAnCDk+L0dItDu9DM3u9DyDKg5Bg3QW62k6iuKpXA=;
 b=N/aHz7hUeLwFqOe/0Z8V7XfU+JnVIffnRuA3csYleQadUwMmc1mDlVdnn6d6w3XwnR0caS
 p5Xe9tZW4RWakkeRQLqSKa3YzDN0F3UhC0rRRAjc9FbNBO8fcOvFUM92Zfw+LZEXukhqAI
 Mt5lA94SSol56C8VSCwrJ7fGeu7krMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777905017;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CTNAnCDk+L0dItDu9DM3u9DyDKg5Bg3QW62k6iuKpXA=;
 b=at3EVxCxO9T1DF1LrcA0EUMfZ8MZv5aVOSOpDZP9IhsGA1xoUOUH+/sfhzpx2/21fowsZk
 omyLzQ0E8kmKEECQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E14E3593A3;
 Mon,  4 May 2026 14:30:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ecW9K3it+Gk2WAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 04 May 2026 14:30:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 1/5] tests/qtest/dbus-vmstate: Bring the test up-to-date
In-Reply-To: <afO9GsCVTZdh2x96@x1.local>
References: <20260429190550.20122-1-farosas@suse.de>
 <20260429190550.20122-2-farosas@suse.de> <afO9GsCVTZdh2x96@x1.local>
Date: Mon, 04 May 2026 11:30:10 -0300
Message-ID: <87qznrp7rh.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5130F6B2EA
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

Peter Xu <peterx@redhat.com> writes:

> On Wed, Apr 29, 2026 at 04:05:46PM -0300, Fabiano Rosas wrote:
>> The dbus-vmstate-test has been disabled for years. Here's the things
>> that have changed in the meantime and how to update the test:
>> 
>> - Migration tests got new headers.
>> Update the includes.
>> 
>> - migrate_qmp got new parameters.
>> Update the caller.
>> 
>> - migrate_incoming_qmp is now used instead of -incoming URL.
>> Use -incoming defer.
>> 
>> - Tests expecting failure should not check non-zero return code.
>> Check for failed migration state instead.
>> 
>> - The test result enum was introduced.
>> Replace the migration_fail flag with the enum.
>> 
>> - The DEVICE state was added.
>> Replace wait_for_migration_complete with migration_event_wait, which
>> won't trip on intermediary states.
>> 
>> - Migration completion was reworked.
>> Explicitly wait for the RESUME event before asserting runstate is
>> RUNNING to avoid checking too quickly and seeing FINISH_MIGRATE
>> instead.
>> 
>> - The FAILING state was added.
>> Wait for it before waiting for the RESUME event.
>> 
>> - Sanity checks were added to migration_get_env().
>> Start calling that function in main.
>> 
>> - qtest_add_func now has a wrapper.
>> Replace qtest_add_func with migration_test_add. Update tests'
>> signatures to take MigrationCommon, although it's unused.
>> 
>> - meson now sets up G_TEST_DBUS_DAEMON.
>> Remove the logic around it.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> I don't think I'm confident reviewing the whole series, but you can take:
>
> Acked-by: Peter Xu <peterx@redhat.com>
>
> One trivial question below,
>
>> ---
>>  tests/qtest/dbus-vmstate-test.c | 71 +++++++++++++++++++--------------
>>  tests/qtest/meson.build         |  7 +++-
>>  2 files changed, 46 insertions(+), 32 deletions(-)
>> 
>> diff --git a/tests/qtest/dbus-vmstate-test.c b/tests/qtest/dbus-vmstate-test.c
>> index 0a82cc9f93..90c050b448 100644
>> --- a/tests/qtest/dbus-vmstate-test.c
>> +++ b/tests/qtest/dbus-vmstate-test.c
>> @@ -2,8 +2,8 @@
>>  #include <glib/gstdio.h>
>>  #include <gio/gio.h>
>>  #include "libqtest.h"
>> +#include "migration/migration-qmp.h"
>>  #include "dbus-vmstate1.h"
>> -#include "migration-helpers.h"
>>  
>>  static char *workdir;
>>  
>> @@ -29,7 +29,7 @@ typedef struct TestServer {
>>  
>>  typedef struct Test {
>>      const char *id_list;
>> -    bool migrate_fail;
>> +    int result;
>>      bool without_dst_b;
>>      TestServer srcA;
>>      TestServer dstA;
>> @@ -190,6 +190,7 @@ test_dbus_vmstate(Test *test)
>>      g_autofree char *uri = NULL;
>>      QTestState *src_qemu = NULL, *dst_qemu = NULL;
>>      guint ownsrcA, ownsrcB, owndstA, owndstB;
>> +    QTestMigrationState src_state = { };
>>  
>>      uri = g_strdup_printf("unix:%s/migsocket", workdir);
>>  
>> @@ -224,17 +225,33 @@ test_dbus_vmstate(Test *test)
>>  
>>      src_qemu = qtest_init(src_qemu_args);
>>      dst_qemu = qtest_init(dst_qemu_args);
>> +
>> +    migrate_set_capability(src_qemu, "events", true);
>> +    qtest_qmp_set_event_callback(src_qemu, migrate_watch_for_events,
>> +                                 &src_state);
>> +
>>      set_id_list(test, src_qemu);
>>      set_id_list(test, dst_qemu);
>>  
>>      thread = g_thread_new("dbus-vmstate-thread", dbus_vmstate_thread, loop);
>>  
>>      migrate_incoming_qmp(dst_qemu, uri, NULL, "{}");
>> -    migrate_qmp(src_qemu, uri, "{}");
>> +    migrate_ensure_converge(src_qemu);
>> +    migrate_qmp(src_qemu, NULL, uri, NULL, "{}");
>>      test->src_qemu = src_qemu;
>> -    if (test->migrate_fail) {
>> -        wait_for_migration_fail(src_qemu, true);
>> -        qtest_set_expected_status(dst_qemu, EXIT_FAILURE);
>> +
>> +    if (test->result != MIG_TEST_SUCCEED) {
>> +        QDict *rsp;
>> +
>> +        migration_event_wait(src_qemu, "failing");
>> +        wait_for_resume(src_qemu, &src_state);
>> +        migration_event_wait(src_qemu, "failed");
>
> Not sure if we need such detailed checks over failing, resume, failed
> events on this one, but it looks ok.
>

I actually had a hang when not checking for failing.  I didn't give it
much thought because I know we added a new state.

> Do you plan to remove wait_for_migration_fail() finally?  We still have a
> few other users.  IIUC, we could also switch to using events for
> wait_for_migration_fail().
>

Seems like a good idea to not need so many query-migrate
invocations. Except that we could hide some potential races with QMP
commands. And we lose the timeout as well. I'll take a look at what can
be done.

>> +
>> +        rsp = qtest_qmp_assert_success_ref(src_qemu,
>> +                                           "{ 'execute': 'query-status' }");
>> +        g_assert(qdict_haskey(rsp, "running"));
>> +        g_assert(qdict_get_bool(rsp, "running"));
>> +        qobject_unref(rsp);
>>      } else {
>>          wait_for_migration_complete(src_qemu);
>>      }
>> @@ -270,7 +287,7 @@ check_migrated(TestServer *s, TestServer *d)
>>  }
>>  
>>  static void
>> -test_dbus_vmstate_without_list(void)
>> +test_dbus_vmstate_without_list(char *name, MigrateCommon *args)
>>  {
>>      Test test = { 0, };
>>  
>> @@ -281,7 +298,7 @@ test_dbus_vmstate_without_list(void)
>>  }
>>  
>>  static void
>> -test_dbus_vmstate_with_list(void)
>> +test_dbus_vmstate_with_list(char *name, MigrateCommon *args)
>>  {
>>      Test test = { .id_list = "idA,idB" };
>>  
>> @@ -292,7 +309,7 @@ test_dbus_vmstate_with_list(void)
>>  }
>>  
>>  static void
>> -test_dbus_vmstate_only_a(void)
>> +test_dbus_vmstate_only_a(char *name, MigrateCommon *args)
>>  {
>>      Test test = { .id_list = "idA" };
>>  
>> @@ -303,9 +320,10 @@ test_dbus_vmstate_only_a(void)
>>  }
>>  
>>  static void
>> -test_dbus_vmstate_missing_src(void)
>> +test_dbus_vmstate_missing_src(char *name, MigrateCommon *args)
>>  {
>> -    Test test = { .id_list = "idA,idC", .migrate_fail = true };
>> +    Test test = { .id_list = "idA,idC",
>> +        .result = MIG_TEST_FAIL };
>>  
>>      /* run in subprocess to silence QEMU error reporting */
>>      if (g_test_subprocess()) {
>> @@ -320,11 +338,11 @@ test_dbus_vmstate_missing_src(void)
>>  }
>>  
>>  static void
>> -test_dbus_vmstate_missing_dst(void)
>> +test_dbus_vmstate_missing_dst(char *name, MigrateCommon *args)
>>  {
>>      Test test = { .id_list = "idA,idB",
>>                    .without_dst_b = true,
>> -                  .migrate_fail = true };
>> +                  .result = MIG_TEST_FAIL };
>>  
>>      /* run in subprocess to silence QEMU error reporting */
>>      if (g_test_subprocess()) {
>> @@ -343,15 +361,8 @@ int
>>  main(int argc, char **argv)
>>  {
>>      GError *err = NULL;
>> -    g_autofree char *dbus_daemon = NULL;
>>      int ret;
>>  
>> -    dbus_daemon = g_build_filename(G_STRINGIFY(SRCDIR),
>> -                                   "tests",
>> -                                   "dbus-vmstate-daemon.sh",
>> -                                   NULL);
>> -    g_setenv("G_TEST_DBUS_DAEMON", dbus_daemon, true);
>> -
>>      g_test_init(&argc, &argv, NULL);
>>  
>>      workdir = g_dir_make_tmp("dbus-vmstate-test-XXXXXX", &err);
>> @@ -362,16 +373,16 @@ main(int argc, char **argv)
>>  
>>      g_setenv("DBUS_VMSTATE_TEST_TMPDIR", workdir, true);
>>  
>> -    qtest_add_func("/dbus-vmstate/without-list",
>> -                   test_dbus_vmstate_without_list);
>> -    qtest_add_func("/dbus-vmstate/with-list",
>> -                   test_dbus_vmstate_with_list);
>> -    qtest_add_func("/dbus-vmstate/only-a",
>> -                   test_dbus_vmstate_only_a);
>> -    qtest_add_func("/dbus-vmstate/missing-src",
>> -                   test_dbus_vmstate_missing_src);
>> -    qtest_add_func("/dbus-vmstate/missing-dst",
>> -                   test_dbus_vmstate_missing_dst);
>> +    migration_test_add("/dbus-vmstate/without-list",
>> +                       test_dbus_vmstate_without_list);
>> +    migration_test_add("/dbus-vmstate/with-list",
>> +                       test_dbus_vmstate_with_list);
>> +    migration_test_add("/dbus-vmstate/only-a",
>> +                       test_dbus_vmstate_only_a);
>> +    migration_test_add("/dbus-vmstate/missing-src",
>> +                       test_dbus_vmstate_missing_src);
>> +    migration_test_add("/dbus-vmstate/missing-dst",
>> +                       test_dbus_vmstate_missing_dst);
>>  
>>      ret = g_test_run();
>>  
>> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
>> index b735f55fc4..0d04e2cbaa 100644
>> --- a/tests/qtest/meson.build
>> +++ b/tests/qtest/meson.build
>> @@ -126,10 +126,12 @@ if dbus_daemon.found() and gdbus_codegen.found()
>>    # Temporarily disabled due to Patchew failures:
>>    #qtests_i386 += ['dbus-vmstate-test']
>>    dbus_vmstate1 = custom_target('dbus-vmstate description',
>> -                                output: ['dbus-vmstate1.h', 'dbus-vmstate1.c'],
>> +                                build_by_default: true,
>> +                                output: [ 'dbus-vmstate1.h', 'dbus-vmstate1.c'],
>>                                  input: meson.project_source_root() / 'backends/dbus-vmstate1.xml',
>>                                  command: [gdbus_codegen, '@INPUT@',
>>                                            '--interface-prefix', 'org.qemu',
>> +                                          '--output-directory', meson.current_build_dir(),
>>                                            '--generate-c-code', '@BASENAME@']).to_list()
>>  else
>>    dbus_vmstate1 = []
>> @@ -385,7 +387,8 @@ qtests = {
>>    'bios-tables-test': [io, 'boot-sector.c', 'acpi-utils.c', 'tpm-emu.c'],
>>    'cdrom-test': files('boot-sector.c'),
>>    'dbus-vmstate-test': files('migration/migration-qmp.c',
>> -                             'migration/migration-util.c') + dbus_vmstate1,
>> +                             'migration/migration-util.c') + dbus_vmstate1 +
>> +                       [gio],
>>    'erst-test': files('erst-test.c'),
>>    'ivshmem-test': [rt, '../../contrib/ivshmem-server/ivshmem-server.c'],
>>    'migration-test': test_migration_files + migration_tls_files + migration_colo_files,
>> -- 
>> 2.51.0
>> 


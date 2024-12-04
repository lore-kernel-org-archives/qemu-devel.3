Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20315E77170
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 19:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIunE-0005dV-0G; Wed, 04 Dec 2024 14:12:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tIun6-0005aI-5V; Wed, 04 Dec 2024 14:12:04 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1tIumz-0005zS-N8; Wed, 04 Dec 2024 14:12:00 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 067891F38E;
 Wed,  4 Dec 2024 19:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733339515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cXtup8iuTaj6WKTZiGBZLEIrwgPvH9DzzNLTP4pCi6g=;
 b=r4OnxhzE1zRdb3MtPX7qcNZKFDHOW9gnr+bDkq56ShVp68REY5C9U01iCLgA6y0D4Inv2V
 aCLIGytzdbxfa8mJPK09D7JE0TYSkzpMQvu8WkX7b2Fsya4GsjH5EqIdAJLvqZ3tO2moIP
 e+O5EFRCMq6Gdu4F8mBEMOAUhS99Aqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733339515;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cXtup8iuTaj6WKTZiGBZLEIrwgPvH9DzzNLTP4pCi6g=;
 b=6GjOygjoDmB9w8JGogiwqHSUDA49N+ePXurg1GXvMAJ33a7k3R8NU5IPBNs098qkaRmhbs
 GtU5poC6DFjfClCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=r4OnxhzE;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6GjOygjo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733339515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cXtup8iuTaj6WKTZiGBZLEIrwgPvH9DzzNLTP4pCi6g=;
 b=r4OnxhzE1zRdb3MtPX7qcNZKFDHOW9gnr+bDkq56ShVp68REY5C9U01iCLgA6y0D4Inv2V
 aCLIGytzdbxfa8mJPK09D7JE0TYSkzpMQvu8WkX7b2Fsya4GsjH5EqIdAJLvqZ3tO2moIP
 e+O5EFRCMq6Gdu4F8mBEMOAUhS99Aqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733339515;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cXtup8iuTaj6WKTZiGBZLEIrwgPvH9DzzNLTP4pCi6g=;
 b=6GjOygjoDmB9w8JGogiwqHSUDA49N+ePXurg1GXvMAJ33a7k3R8NU5IPBNs098qkaRmhbs
 GtU5poC6DFjfClCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CCBA13974;
 Wed,  4 Dec 2024 19:11:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uhTJEHqpUGdvMgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 04 Dec 2024 19:11:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, =?utf-8?Q?Daniel_P_=2E?=
 =?utf-8?Q?_Berrang=C3=A9?=
 <berrange@redhat.com>, Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 peterx@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH RFC 09/11] tests/qtest/migration: Don't use hardcoded
 strings for -serial
In-Reply-To: <20241204005138.702289-10-peterx@redhat.com>
References: <20241204005138.702289-1-peterx@redhat.com>
 <20241204005138.702289-10-peterx@redhat.com>
Date: Wed, 04 Dec 2024 16:11:51 -0300
Message-ID: <87ldwvi7pk.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 067891F38E
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[11];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> From: Fabiano Rosas <farosas@suse.de>
>
> Stop using hardcoded strings for -serial so we can in the next patches
> perform more than one migration in a row. Having the serial path
> hardcoded means we cannot reuse the code when dst becomes the new src.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> Link: https://lore.kernel.org/r/20241125144612.16194-3-farosas@suse.de
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tests/qtest/migration-helpers.h |  2 +
>  tests/qtest/migration-helpers.c |  8 ++++
>  tests/qtest/migration-test.c    | 68 ++++++++++++++++++---------------
>  3 files changed, 48 insertions(+), 30 deletions(-)
>
> diff --git a/tests/qtest/migration-helpers.h b/tests/qtest/migration-helpers.h
> index 72dba369fb..c7a36a33d6 100644
> --- a/tests/qtest/migration-helpers.h
> +++ b/tests/qtest/migration-helpers.h
> @@ -20,6 +20,7 @@ typedef struct QTestMigrationState {
>      bool resume_seen;
>      bool suspend_seen;
>      bool suspend_me;
> +    char *serial;
>  } QTestMigrationState;
>  
>  bool migrate_watch_for_events(QTestState *who, const char *name,
> @@ -64,5 +65,6 @@ static inline bool probe_o_direct_support(const char *tmpfs)
>  #endif
>  void migration_test_add(const char *path, void (*fn)(void));
>  void migration_event_wait(QTestState *s, const char *target);
> +char *migrate_get_unique_serial(const char *tmpfs);
>  
>  #endif /* MIGRATION_HELPERS_H */
> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
> index 3f8ba7fa8e..7c0b54ce0e 100644
> --- a/tests/qtest/migration-helpers.c
> +++ b/tests/qtest/migration-helpers.c
> @@ -528,3 +528,11 @@ void migration_event_wait(QTestState *s, const char *target)
>          qobject_unref(response);
>      } while (!found);
>  }
> +
> +char *migrate_get_unique_serial(const char *tmpfs)
> +{
> +    static int i;
> +
> +    assert(i < INT_MAX);
> +    return g_strdup_printf("%s/serial_%d", tmpfs, i++);
> +}
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index eafc2da806..1452778c81 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -192,9 +192,8 @@ static void bootfile_create(char *dir, bool suspend_me)
>   * we get an 'A' followed by an endless string of 'B's
>   * but on the destination we won't have the A (unless we enabled suspend/resume)
>   */
> -static void wait_for_serial(const char *side)
> +static void wait_for_serial(const char *serialpath)
>  {
> -    g_autofree char *serialpath = g_strdup_printf("%s/%s", tmpfs, side);
>      FILE *serialfile = fopen(serialpath, "r");
>  
>      do {
> @@ -216,7 +215,7 @@ static void wait_for_serial(const char *side)
>              break;
>  
>          default:
> -            fprintf(stderr, "Unexpected %d on %s serial\n", readvalue, side);
> +            fprintf(stderr, "Unexpected %d on %s\n", readvalue, serialpath);
>              g_assert_not_reached();
>          }
>      } while (true);
> @@ -818,16 +817,17 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>  
>          src_state = (QTestMigrationState) { };
>          src_state.suspend_me = args->suspend_me;
> +        src_state.serial = migrate_get_unique_serial(tmpfs);
>  
>          cmd_source = g_strdup_printf("-accel kvm%s -accel tcg "
>                                       "-machine %s,%s "
>                                       "-name source,debug-threads=on "
>                                       "-m %s "
> -                                     "-serial file:%s/src_serial "
> +                                     "-serial file:%s "
>                                       "%s %s %s %s %s",
>                                       kvm_opts ? kvm_opts : "",
>                                       machine, machine_opts,
> -                                     memory_size, tmpfs,
> +                                     memory_size, src_state.serial,
>                                       arch_opts ? arch_opts : "",
>                                       arch_source ? arch_source : "",
>                                       shmem_opts ? shmem_opts : "",
> @@ -841,17 +841,18 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>      }
>  
>      dst_state = (QTestMigrationState) { };
> +    dst_state.serial = migrate_get_unique_serial(tmpfs);
>  
>      cmd_target = g_strdup_printf("-accel kvm%s -accel tcg "
>                                   "-machine %s,%s "
>                                   "-name target,debug-threads=on "
>                                   "-m %s "
> -                                 "-serial file:%s/dest_serial "
> +                                 "-serial file:%s "
>                                   "-incoming %s "
>                                   "%s %s %s %s %s",
>                                   kvm_opts ? kvm_opts : "",
>                                   machine, machine_opts,
> -                                 memory_size, tmpfs, uri,
> +                                 memory_size, dst_state.serial, uri,
>                                   arch_opts ? arch_opts : "",
>                                   arch_target ? arch_target : "",
>                                   shmem_opts ? shmem_opts : "",
> @@ -911,8 +912,10 @@ static void test_migrate_end(QTestState *from, QTestState *to, bool test_dest)
>      qtest_quit(to);
>  
>      cleanup("migsocket");
> -    cleanup("src_serial");
> -    cleanup("dest_serial");
> +    unlink(src_state.serial);
> +    g_free(src_state.serial);
> +    unlink(dst_state.serial);
> +    g_free(dst_state.serial);
>      cleanup(FILE_TEST_FILENAME);
>  }
>  
> @@ -1290,7 +1293,7 @@ static int migrate_postcopy_prepare(QTestState **from_ptr,
>                               "                'port': '0' } } ] } }");
>  
>      /* Wait for the first serial output from the source */
> -    wait_for_serial("src_serial");
> +    wait_for_serial(src_state.serial);
>      wait_for_suspend(from, &src_state);
>  
>      migrate_qmp(from, to, NULL, NULL, "{}");
> @@ -1314,7 +1317,7 @@ static void migrate_postcopy_complete(QTestState *from, QTestState *to,
>      }
>  
>      /* Make sure we get at least one "B" on destination */
> -    wait_for_serial("dest_serial");
> +    wait_for_serial(dst_state.serial);
>  
>      if (uffd_feature_thread_id) {
>          read_blocktime(to);
> @@ -1719,7 +1722,7 @@ static void test_precopy_common(MigrateCommon *args)
>  
>      /* Wait for the first serial output from the source */
>      if (args->result == MIG_TEST_SUCCEED) {
> -        wait_for_serial("src_serial");
> +        wait_for_serial(src_state.serial);
>          wait_for_suspend(from, &src_state);
>      }
>  
> @@ -1796,7 +1799,7 @@ static void test_precopy_common(MigrateCommon *args)
>              qtest_qmp_assert_success(to, "{'execute': 'system_wakeup'}");
>          }
>  
> -        wait_for_serial("dest_serial");
> +        wait_for_serial(dst_state.serial);
>      }
>  
>  finish:
> @@ -1871,7 +1874,7 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
>      }
>  
>      migrate_ensure_converge(from);
> -    wait_for_serial("src_serial");
> +    wait_for_serial(src_state.serial);
>  
>      if (stop_src) {
>          qtest_qmp_assert_success(from, "{ 'execute' : 'stop'}");
> @@ -1898,7 +1901,7 @@ static void test_file_common(MigrateCommon *args, bool stop_src)
>      }
>      wait_for_resume(to, &dst_state);
>  
> -    wait_for_serial("dest_serial");
> +    wait_for_serial(dst_state.serial);
>  
>      if (check_offset) {
>          file_check_offset_region();
> @@ -2041,7 +2044,7 @@ static void test_ignore_shared(void)
>      migrate_set_capability(to, "x-ignore-shared", true);
>  
>      /* Wait for the first serial output from the source */
> -    wait_for_serial("src_serial");
> +    wait_for_serial(src_state.serial);
>  
>      migrate_qmp(from, to, uri, NULL, "{}");
>  
> @@ -2051,7 +2054,7 @@ static void test_ignore_shared(void)
>  
>      qtest_qmp_eventwait(to, "RESUME");
>  
> -    wait_for_serial("dest_serial");
> +    wait_for_serial(dst_state.serial);
>      wait_for_migration_complete(from);
>  
>      /* Check whether shared RAM has been really skipped */
> @@ -2669,7 +2672,7 @@ static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
>      migrate_set_capability(from, "validate-uuid", true);
>  
>      /* Wait for the first serial output from the source */
> -    wait_for_serial("src_serial");
> +    wait_for_serial(src_state.serial);
>  
>      migrate_qmp(from, to, uri, NULL, "{}");
>  
> @@ -2733,7 +2736,7 @@ static void do_test_validate_uri_channel(MigrateCommon *args)
>      }
>  
>      /* Wait for the first serial output from the source */
> -    wait_for_serial("src_serial");
> +    wait_for_serial(src_state.serial);
>  
>      /*
>       * 'uri' and 'channels' validation is checked even before the migration
> @@ -2823,7 +2826,7 @@ static void test_migrate_auto_converge(void)
>      migrate_set_capability(from, "pause-before-switchover", true);
>  
>      /* Wait for the first serial output from the source */
> -    wait_for_serial("src_serial");
> +    wait_for_serial(src_state.serial);
>  
>      migrate_qmp(from, to, uri, NULL, "{}");
>  
> @@ -2885,7 +2888,7 @@ static void test_migrate_auto_converge(void)
>  
>      qtest_qmp_eventwait(to, "RESUME");
>  
> -    wait_for_serial("dest_serial");
> +    wait_for_serial(dst_state.serial);
>      wait_for_migration_complete(from);
>  
>      test_migrate_end(from, to, true);
> @@ -3296,7 +3299,7 @@ static void test_multifd_tcp_cancel(void)
>      migrate_incoming_qmp(to, "tcp:127.0.0.1:0", "{}");
>  
>      /* Wait for the first serial output from the source */
> -    wait_for_serial("src_serial");
> +    wait_for_serial(src_state.serial);
>  
>      migrate_qmp(from, to, NULL, NULL, "{}");
>  
> @@ -3307,7 +3310,8 @@ static void test_multifd_tcp_cancel(void)
>      /* Make sure QEMU process "to" exited */
>      qtest_set_expected_status(to, EXIT_FAILURE);
>      qtest_wait_qemu(to);
> -    qtest_quit(to);
> +    unlink(dst_state.serial);
> +    g_free(dst_state.serial);
>  
>      /*
>       * Ensure the source QEMU finishes its cancellation process before we
> @@ -3345,7 +3349,7 @@ static void test_multifd_tcp_cancel(void)
>      wait_for_stop(from, &src_state);
>      qtest_qmp_eventwait(to2, "RESUME");
>  
> -    wait_for_serial("dest_serial");
> +    wait_for_serial(dst_state.serial);
>      wait_for_migration_complete(from);
>      test_migrate_end(from, to2, true);
>  }
> @@ -3488,13 +3492,16 @@ static QTestState *dirtylimit_start_vm(void)
>      QTestState *vm = NULL;
>      g_autofree gchar *cmd = NULL;
>  
> +    src_state = (QTestMigrationState) { };
> +    src_state.serial = migrate_get_unique_serial(tmpfs);
> +
>      bootfile_create(tmpfs, false);
>      cmd = g_strdup_printf("-accel kvm,dirty-ring-size=4096 "
>                            "-name dirtylimit-test,debug-threads=on "
>                            "-m 150M -smp 1 "
> -                          "-serial file:%s/vm_serial "
> +                          "-serial file:%s "
>                            "-drive file=%s,format=raw ",
> -                          tmpfs, bootpath);
> +                          src_state.serial, bootpath);
>  
>      vm = qtest_init(cmd);
>      return vm;
> @@ -3503,7 +3510,8 @@ static QTestState *dirtylimit_start_vm(void)
>  static void dirtylimit_stop_vm(QTestState *vm)
>  {
>      qtest_quit(vm);
> -    cleanup("vm_serial");
> +    unlink(src_state.serial);
> +    g_free(src_state.serial);
>  }
>  
>  static void test_vcpu_dirty_limit(void)
> @@ -3519,7 +3527,7 @@ static void test_vcpu_dirty_limit(void)
>      vm = dirtylimit_start_vm();
>  
>      /* Wait for the first serial output from the vm*/
> -    wait_for_serial("vm_serial");
> +    wait_for_serial(src_state.serial);
>  
>      /* Do dirtyrate measurement with calc time equals 1s */
>      calc_dirty_rate(vm, 1);
> @@ -3612,7 +3620,7 @@ static void migrate_dirty_limit_wait_showup(QTestState *from,
>      migrate_set_capability(from, "pause-before-switchover", true);
>  
>      /* Wait for the serial output from the source */
> -    wait_for_serial("src_serial");
> +    wait_for_serial(src_state.serial);
>  }
>  
>  /*
> @@ -3751,7 +3759,7 @@ static void test_migrate_dirty_limit(void)
>  
>      qtest_qmp_eventwait(to, "RESUME");
>  
> -    wait_for_serial("dest_serial");
> +    wait_for_serial(dst_state.serial);
>      wait_for_migration_complete(from);
>  
>      test_migrate_end(from, to, true);

There's a preexisting issue in the dirty_limit test of not doing cleanup
between the two migrations that it does, causing (with this patch) one
of the serial files to get left behind, which breaks make check
SPEED=slow because the test directory cannot be removed.

Just an FYI. I'm fixing that on master and we can update this patch
afterward.


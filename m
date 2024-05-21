Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2577CC25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 12:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Osy-0002yk-7u; Tue, 21 May 2024 08:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1s9Oss-0002xK-Io; Tue, 21 May 2024 08:46:28 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1s9Osq-0004cF-CZ; Tue, 21 May 2024 08:46:26 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3E53934747;
 Tue, 21 May 2024 12:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716295581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C02whfY0sjFf50dLNjsamVTzvGDt+JL1DuUMmp0/9lo=;
 b=i81BRt/KD62A7SqTBWuFJo44eBJy7lsMAmCAB5ALzZxGl0CVLDK28JswufnWzlUJi1KsGC
 Wa1/svzGrlc18SpYAeBNFnZe/muGC6jYy+N44pR6oMHLng33n0kVLhmAoJN16yE9SFr4Ef
 3NMjfD6B6Flr0JB4m63Z/RSsVK9xI5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716295581;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C02whfY0sjFf50dLNjsamVTzvGDt+JL1DuUMmp0/9lo=;
 b=iob7FB4GHyGRb4/7wGmwmegFGjPGl6tjQe2OSryznOfvSPWXV2Ez3O8FVs4MwQCy68Aqbl
 +HKTo0oTO9pGPxCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716295581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C02whfY0sjFf50dLNjsamVTzvGDt+JL1DuUMmp0/9lo=;
 b=i81BRt/KD62A7SqTBWuFJo44eBJy7lsMAmCAB5ALzZxGl0CVLDK28JswufnWzlUJi1KsGC
 Wa1/svzGrlc18SpYAeBNFnZe/muGC6jYy+N44pR6oMHLng33n0kVLhmAoJN16yE9SFr4Ef
 3NMjfD6B6Flr0JB4m63Z/RSsVK9xI5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716295581;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C02whfY0sjFf50dLNjsamVTzvGDt+JL1DuUMmp0/9lo=;
 b=iob7FB4GHyGRb4/7wGmwmegFGjPGl6tjQe2OSryznOfvSPWXV2Ez3O8FVs4MwQCy68Aqbl
 +HKTo0oTO9pGPxCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A67EE13A21;
 Tue, 21 May 2024 12:46:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sPCxGZyXTGbeEAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 21 May 2024 12:46:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Juan Quintela
 <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Leonardo Bras <leobras@redhat.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Markus Armbruster
 <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Fam
 Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>, Li
 Zhijian <lizhijian@fujitsu.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PULL 10/38] tests/qtest/migration: Add a test for the
 analyze-migration script
In-Reply-To: <87wmnnic86.fsf@draig.linaro.org>
References: <20231017083003.15951-1-quintela@redhat.com>
 <20231017083003.15951-11-quintela@redhat.com>
 <87wmnnic86.fsf@draig.linaro.org>
Date: Tue, 21 May 2024 09:46:17 -0300
Message-ID: <87bk4zjpt2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[18]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, linaro.org:email,
 suse.de:email]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Juan Quintela <quintela@redhat.com> writes:
>
>> From: Fabiano Rosas <farosas@suse.de>
>>
>> Add a smoke test that migrates to a file and gives it to the
>> script. It should catch the most annoying errors such as changes in
>> the ram flags.
>>
>> After code has been merged it becomes way harder to figure out what is
>> causing the script to fail, the person making the change is the most
>> likely to know right away what the problem is.
>>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> Acked-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> Message-ID: <20231009184326.15777-7-farosas@suse.de>
>
> I bisected the failures I'm seeing on s390x to the introduction of this
> script. I don't know if its simply a timeout on a relatively slow VM:

What's the range of your bisect? That test has been disabled and then
reenabled on s390x. It could be tripping the bisect.

04131e0009 ("tests/qtest/migration-test: Disable the analyze-migration.py t=
est on s390x")
81c2c9dd5d ("tests/qtest/migration-test: Fix analyze-migration.py for s390x=
")

I don't think that test itself could be timing out. It's a very simple
test. It runs a migration and then uses the output to validate the
script.

I don't have a Z machine at hand and the migration tests only run with
KVM for s390x, so it would be useful to take a look at meson's
testlog.txt so we can see which test is failing and hopefully in what
way it is failing.

If you're up for it, running this in a loop is usually the best way to
catch any intermittent issues:

QTEST_QEMU_BINARY=3D./qemu-system-x86_64 ./tests/qtest/migration-test

And once you figure out which test, there's this monstrosity:

QTEST_QEMU_BINARY=3D'gdb -q --ex "set pagination off"          \
                          --ex "set print thread-events off" \
                          --ex "handle SIGUSR1 noprint"      \
                          --ex "handle SIGPIPE noprint"      \
                          --ex "run" --ex "quit \$_exitcode" \
                          --args ./qemu-system-x86_64'       \
                          gdb -q --ex "set prompt (qtest) "  \
                          --ex "handle SIGPIPE noprint"      \
                          --args ./tests/qtest/migration-test -p /x86_64/mi=
gration/<some>/<test>

> Summary of Failures:
>
>  36/546 qemu:qtest+qtest-s390x / qtest-s390x/migration-test              =
         ERROR          93.51s   killed by signal 6 SIGABRT
>
> It seems to be unstable as we pass sometimes:
>
> 11:26:42 [ajb@qemu01:~/l/q/b/system] master|=E2=80=A6 + ./pyvenv/bin/meso=
n test --repeat 100 qtest-s390x/migration-test
> ninja: Entering directory `/home/ajb/lsrc/qemu.git/builds/system'
> [1/9] Generating qemu-version.h with a custom command (wrapped by meson t=
o capture output)
>   1/100 qemu:qtest+qtest-s390x / qtest-s390x/migration-test          ERRO=
R          251.98s   killed by signal 6 SIGABRT
>>>> MALLOC_PERTURB_=3D9 PYTHON=3D/home/ajb/lsrc/qemu.git/builds/system/pyv=
env/bin/python3 G_TEST_DBUS_DAEMON=3D/home/ajb/lsrc/qemu.git/tests/dbus-vms=
tate-daemon.sh QTEST_QEMU_BINARY=3D./qemu-system-s390x QTEST_QEMU_IMG=3D./q=
emu-img QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-storage-da=
emon /home/ajb/lsrc/qemu.git/builds/system/tests/qtest/migration-test --tap=
 -k
>
>   2/100 qemu:qtest+qtest-s390x / qtest-s390x/migration-test          ERRO=
R          258.71s   killed by signal 6 SIGABRT
>>>> PYTHON=3D/home/ajb/lsrc/qemu.git/builds/system/pyvenv/bin/python3 MALL=
OC_PERTURB_=3D205 G_TEST_DBUS_DAEMON=3D/home/ajb/lsrc/qemu.git/tests/dbus-v=
mstate-daemon.sh QTEST_QEMU_BINARY=3D./qemu-system-s390x QTEST_QEMU_IMG=3D.=
/qemu-img QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-storage-=
daemon /home/ajb/lsrc/qemu.git/builds/system/tests/qtest/migration-test --t=
ap -k
>
>   3/100 qemu:qtest+qtest-s390x / qtest-s390x/migration-test          OK  =
           302.53s   46 subtests passed
>   4/100 qemu:qtest+qtest-s390x / qtest-s390x/migration-test          OK  =
           319.56s   46 subtests passed
>   5/100 qemu:qtest+qtest-s390x / qtest-s390x/migration-test          OK  =
           320.11s   46 subtests passed
>   6/100 qemu:qtest+qtest-s390x / qtest-s390x/migration-test          OK  =
           328.40s   46 subtests passed
>
> Ok:                 4=20=20=20
> Expected Fail:      0=20=20=20
> Fail:               2=20=20=20
> Unexpected Pass:    0=20=20=20
> Skipped:            0=20=20=20
> Timeout:            0=20=20=20
>
>> ---
>>  tests/qtest/migration-test.c | 60 ++++++++++++++++++++++++++++++++++++
>>  tests/qtest/meson.build      |  2 ++
>>  2 files changed, 62 insertions(+)
>>
>> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
>> index 8eb2053dbb..cef5081f8c 100644
>> --- a/tests/qtest/migration-test.c
>> +++ b/tests/qtest/migration-test.c
>> @@ -66,6 +66,8 @@ static bool got_dst_resume;
>>   */
>>  #define DIRTYLIMIT_TOLERANCE_RANGE  25  /* MB/s */
>>=20=20
>> +#define ANALYZE_SCRIPT "scripts/analyze-migration.py"
>> +
>>  #if defined(__linux__)
>>  #include <sys/syscall.h>
>>  #include <sys/vfs.h>
>> @@ -1501,6 +1503,61 @@ static void test_baddest(void)
>>      test_migrate_end(from, to, false);
>>  }
>>=20=20
>> +#ifndef _WIN32
>> +static void test_analyze_script(void)
>> +{
>> +    MigrateStart args =3D {
>> +        .opts_source =3D "-uuid 11111111-1111-1111-1111-111111111111",
>> +    };
>> +    QTestState *from, *to;
>> +    g_autofree char *uri =3D NULL;
>> +    g_autofree char *file =3D NULL;
>> +    int pid, wstatus;
>> +    const char *python =3D g_getenv("PYTHON");
>> +
>> +    if (!python) {
>> +        g_test_skip("PYTHON variable not set");
>> +        return;
>> +    }
>> +
>> +    /* dummy url */
>> +    if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", &args)) {
>> +        return;
>> +    }
>> +
>> +    /*
>> +     * Setting these two capabilities causes the "configuration"
>> +     * vmstate to include subsections for them. The script needs to
>> +     * parse those subsections properly.
>> +     */
>> +    migrate_set_capability(from, "validate-uuid", true);
>> +    migrate_set_capability(from, "x-ignore-shared", true);
>> +
>> +    file =3D g_strdup_printf("%s/migfile", tmpfs);
>> +    uri =3D g_strdup_printf("exec:cat > %s", file);
>> +
>> +    migrate_ensure_converge(from);
>> +    migrate_qmp(from, uri, "{}");
>> +    wait_for_migration_complete(from);
>> +
>> +    pid =3D fork();
>> +    if (!pid) {
>> +        close(1);
>> +        open("/dev/null", O_WRONLY);
>> +        execl(python, python, ANALYZE_SCRIPT, "-f", file, NULL);
>> +        g_assert_not_reached();
>> +    }
>> +
>> +    g_assert(waitpid(pid, &wstatus, 0) =3D=3D pid);
>> +    if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) !=3D 0) {
>> +        g_test_message("Failed to analyze the migration stream");
>> +        g_test_fail();
>> +    }
>> +    test_migrate_end(from, to, false);
>> +    cleanup("migfile");
>> +}
>> +#endif
>> +
>>  static void test_precopy_common(MigrateCommon *args)
>>  {
>>      QTestState *from, *to;
>> @@ -2837,6 +2894,9 @@ int main(int argc, char **argv)
>>      }
>>=20=20
>>      qtest_add_func("/migration/bad_dest", test_baddest);
>> +#ifndef _WIN32
>> +    qtest_add_func("/migration/analyze-script", test_analyze_script);
>> +#endif
>>      qtest_add_func("/migration/precopy/unix/plain", test_precopy_unix_p=
lain);
>>      qtest_add_func("/migration/precopy/unix/xbzrle", test_precopy_unix_=
xbzrle);
>>      /*
>> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
>> index 66795cfcd2..d6022ebd64 100644
>> --- a/tests/qtest/meson.build
>> +++ b/tests/qtest/meson.build
>> @@ -357,6 +357,8 @@ foreach dir : target_dirs
>>      test_deps +=3D [qsd]
>>    endif
>>=20=20
>> +  qtest_env.set('PYTHON', python.full_path())
>> +
>>    foreach test : target_qtests
>>      # Executables are shared across targets, declare them only the firs=
t time we
>>      # encounter them


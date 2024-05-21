Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFB2C25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 12:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9OYK-0007Bh-85; Tue, 21 May 2024 08:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s9OYD-0006ww-1S
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:25:05 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1s9OY9-0000HZ-0C
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:25:04 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a5a2c05006aso453443466b.0
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 05:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716294299; x=1716899099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I7jPevsVjjZfdD+y/Qkb88rG3MOxZYlYN8omBPST1Y4=;
 b=Hbc2mD1C8VEjhE3dKfHsbDs3ZgQPMXDgyGzA3IwqJJaFl+roZQ2UvsOcX6ClZ2fX29
 oyaIDds9ey+SNg9b4KJ3xvT4dxgvu6QphklkLVCN3HQBODO1KctEQvOickf6sa5frrly
 JTD78sba65vwenc7xFOarBH0mm34k0eVfhc0ZL56xZRmdlkxr9HdeFrAl9o3pBjGS98P
 6KcbhnA+by7u90FrgGQjZemllMDMWhfctFOdQLW/sqmIwtyzmmeRjBrFYgJXJFmM4Fp9
 KBAxf1HX7csg/p1GdtQJEiZ9/yVGZT/ZERI7u9p7Q9JuOmo0uiB4jU+avalj3NoJfT5c
 e0uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716294299; x=1716899099;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I7jPevsVjjZfdD+y/Qkb88rG3MOxZYlYN8omBPST1Y4=;
 b=LRX6oMDmHe+xwnoFVQD6gl51t61OR6HI5mkjXJqEqUiyIGmBotCcrzXGM7XIZ5EzJA
 DfMY7R9vRR3DG01BzFfQRyes2uAcSp14LARoqivW2+s5En44LmkSPCHXQjCpc9cSzLru
 IucKLVMjD57hYZxwxaSTbsNRsBJ0XDsBWD2BAaP4UdS5s4WTmUiiu9AcjvJLm9tQ57U5
 z0jUPMblSCUfSisGI0Zw8zbcc2ljwhrWRQ+wyUE67+b9gvIYDg9u4CYyUtuZzYa/CFBY
 LHp/zL/A2jRg8GszROsDZiUXO37hx0p0iTVRBw9KrhefvUBgqzahWPyPtsrIBkXRlXJw
 Y64g==
X-Gm-Message-State: AOJu0YzgYSj1uMXXBJzf9MIsZVLP2qthktnbm5uZnLO6UytD95rNowJ4
 RNgdebsVz7m2OWTH59fFoEIZoTM0msXkacutVIA8S5Y14RqY8b3W8ban7nawG0U=
X-Google-Smtp-Source: AGHT+IF9HiLD186HQCKO0quDM2ALsfHB050M4aYRvc/HwdqXRkXuzJqbYJzR2KjaHGEP8hPyFiYVWg==
X-Received: by 2002:a50:ccc8:0:b0:572:795a:b913 with SMTP id
 4fb4d7f45d1cf-5734d67fd75mr24188687a12.34.1716294298929; 
 Tue, 21 May 2024 05:24:58 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-574ea09b972sm9576094a12.47.2024.05.21.05.24.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 May 2024 05:24:58 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E038A5F8B0;
 Tue, 21 May 2024 13:24:57 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org,  Eric Blake <eblake@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Leonardo Bras
 <leobras@redhat.com>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Fam
 Zheng <fam@euphon.net>,  Stefan Hajnoczi <stefanha@redhat.com>,  Li
 Zhijian <lizhijian@fujitsu.com>,  John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org,  Cleber Rosa <crosa@redhat.com>,  Laurent Vivier
 <lvivier@redhat.com>, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PULL 10/38] tests/qtest/migration: Add a test for the
 analyze-migration script
In-Reply-To: <20231017083003.15951-11-quintela@redhat.com> (Juan Quintela's
 message of "Tue, 17 Oct 2023 10:29:35 +0200")
References: <20231017083003.15951-1-quintela@redhat.com>
 <20231017083003.15951-11-quintela@redhat.com>
Date: Tue, 21 May 2024 13:24:57 +0100
Message-ID: <87wmnnic86.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Juan Quintela <quintela@redhat.com> writes:

> From: Fabiano Rosas <farosas@suse.de>
>
> Add a smoke test that migrates to a file and gives it to the
> script. It should catch the most annoying errors such as changes in
> the ram flags.
>
> After code has been merged it becomes way harder to figure out what is
> causing the script to fail, the person making the change is the most
> likely to know right away what the problem is.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> Acked-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Message-ID: <20231009184326.15777-7-farosas@suse.de>

I bisected the failures I'm seeing on s390x to the introduction of this
script. I don't know if its simply a timeout on a relatively slow VM:

Summary of Failures:

 36/546 qemu:qtest+qtest-s390x / qtest-s390x/migration-test                =
       ERROR          93.51s   killed by signal 6 SIGABRT

It seems to be unstable as we pass sometimes:

11:26:42 [ajb@qemu01:~/l/q/b/system] master|=E2=80=A6 + ./pyvenv/bin/meson =
test --repeat 100 qtest-s390x/migration-test
ninja: Entering directory `/home/ajb/lsrc/qemu.git/builds/system'
[1/9] Generating qemu-version.h with a custom command (wrapped by meson to =
capture output)
  1/100 qemu:qtest+qtest-s390x / qtest-s390x/migration-test          ERROR =
         251.98s   killed by signal 6 SIGABRT
>>> MALLOC_PERTURB_=3D9 PYTHON=3D/home/ajb/lsrc/qemu.git/builds/system/pyve=
nv/bin/python3 G_TEST_DBUS_DAEMON=3D/home/ajb/lsrc/qemu.git/tests/dbus-vmst=
ate-daemon.sh QTEST_QEMU_BINARY=3D./qemu-system-s390x QTEST_QEMU_IMG=3D./qe=
mu-img QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-storage-dae=
mon /home/ajb/lsrc/qemu.git/builds/system/tests/qtest/migration-test --tap =
-k

  2/100 qemu:qtest+qtest-s390x / qtest-s390x/migration-test          ERROR =
         258.71s   killed by signal 6 SIGABRT
>>> PYTHON=3D/home/ajb/lsrc/qemu.git/builds/system/pyvenv/bin/python3 MALLO=
C_PERTURB_=3D205 G_TEST_DBUS_DAEMON=3D/home/ajb/lsrc/qemu.git/tests/dbus-vm=
state-daemon.sh QTEST_QEMU_BINARY=3D./qemu-system-s390x QTEST_QEMU_IMG=3D./=
qemu-img QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-storage-d=
aemon /home/ajb/lsrc/qemu.git/builds/system/tests/qtest/migration-test --ta=
p -k

  3/100 qemu:qtest+qtest-s390x / qtest-s390x/migration-test          OK    =
         302.53s   46 subtests passed
  4/100 qemu:qtest+qtest-s390x / qtest-s390x/migration-test          OK    =
         319.56s   46 subtests passed
  5/100 qemu:qtest+qtest-s390x / qtest-s390x/migration-test          OK    =
         320.11s   46 subtests passed
  6/100 qemu:qtest+qtest-s390x / qtest-s390x/migration-test          OK    =
         328.40s   46 subtests passed

Ok:                 4=20=20=20
Expected Fail:      0=20=20=20
Fail:               2=20=20=20
Unexpected Pass:    0=20=20=20
Skipped:            0=20=20=20
Timeout:            0=20=20=20

> ---
>  tests/qtest/migration-test.c | 60 ++++++++++++++++++++++++++++++++++++
>  tests/qtest/meson.build      |  2 ++
>  2 files changed, 62 insertions(+)
>
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 8eb2053dbb..cef5081f8c 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -66,6 +66,8 @@ static bool got_dst_resume;
>   */
>  #define DIRTYLIMIT_TOLERANCE_RANGE  25  /* MB/s */
>=20=20
> +#define ANALYZE_SCRIPT "scripts/analyze-migration.py"
> +
>  #if defined(__linux__)
>  #include <sys/syscall.h>
>  #include <sys/vfs.h>
> @@ -1501,6 +1503,61 @@ static void test_baddest(void)
>      test_migrate_end(from, to, false);
>  }
>=20=20
> +#ifndef _WIN32
> +static void test_analyze_script(void)
> +{
> +    MigrateStart args =3D {
> +        .opts_source =3D "-uuid 11111111-1111-1111-1111-111111111111",
> +    };
> +    QTestState *from, *to;
> +    g_autofree char *uri =3D NULL;
> +    g_autofree char *file =3D NULL;
> +    int pid, wstatus;
> +    const char *python =3D g_getenv("PYTHON");
> +
> +    if (!python) {
> +        g_test_skip("PYTHON variable not set");
> +        return;
> +    }
> +
> +    /* dummy url */
> +    if (test_migrate_start(&from, &to, "tcp:127.0.0.1:0", &args)) {
> +        return;
> +    }
> +
> +    /*
> +     * Setting these two capabilities causes the "configuration"
> +     * vmstate to include subsections for them. The script needs to
> +     * parse those subsections properly.
> +     */
> +    migrate_set_capability(from, "validate-uuid", true);
> +    migrate_set_capability(from, "x-ignore-shared", true);
> +
> +    file =3D g_strdup_printf("%s/migfile", tmpfs);
> +    uri =3D g_strdup_printf("exec:cat > %s", file);
> +
> +    migrate_ensure_converge(from);
> +    migrate_qmp(from, uri, "{}");
> +    wait_for_migration_complete(from);
> +
> +    pid =3D fork();
> +    if (!pid) {
> +        close(1);
> +        open("/dev/null", O_WRONLY);
> +        execl(python, python, ANALYZE_SCRIPT, "-f", file, NULL);
> +        g_assert_not_reached();
> +    }
> +
> +    g_assert(waitpid(pid, &wstatus, 0) =3D=3D pid);
> +    if (WIFEXITED(wstatus) && WEXITSTATUS(wstatus) !=3D 0) {
> +        g_test_message("Failed to analyze the migration stream");
> +        g_test_fail();
> +    }
> +    test_migrate_end(from, to, false);
> +    cleanup("migfile");
> +}
> +#endif
> +
>  static void test_precopy_common(MigrateCommon *args)
>  {
>      QTestState *from, *to;
> @@ -2837,6 +2894,9 @@ int main(int argc, char **argv)
>      }
>=20=20
>      qtest_add_func("/migration/bad_dest", test_baddest);
> +#ifndef _WIN32
> +    qtest_add_func("/migration/analyze-script", test_analyze_script);
> +#endif
>      qtest_add_func("/migration/precopy/unix/plain", test_precopy_unix_pl=
ain);
>      qtest_add_func("/migration/precopy/unix/xbzrle", test_precopy_unix_x=
bzrle);
>      /*
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 66795cfcd2..d6022ebd64 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -357,6 +357,8 @@ foreach dir : target_dirs
>      test_deps +=3D [qsd]
>    endif
>=20=20
> +  qtest_env.set('PYTHON', python.full_path())
> +
>    foreach test : target_qtests
>      # Executables are shared across targets, declare them only the first=
 time we
>      # encounter them

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1B4FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 15:00:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJumR-0007cc-4X; Mon, 04 May 2026 11:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wJumO-0007cS-2X
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:00:16 -0400
Received: from mail-dy1-x132e.google.com ([2607:f8b0:4864:20::132e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wJumL-0005t3-TW
 for qemu-devel@nongnu.org; Mon, 04 May 2026 11:00:15 -0400
Received: by mail-dy1-x132e.google.com with SMTP id
 5a478bee46e88-2ee1054627bso2724687eec.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 08:00:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777906810; cv=none;
 d=google.com; s=arc-20240605;
 b=Lr5x5p98VucLrMg+pZltZ40h6ZSimy1k/dynAHckC3EwDbco/oGi0lt8xOTBn/C3Y6
 7VW1F8N0eeTWgs0ec+KUZWsRU4gJiMWBGGaKdIV17O9JhPg+Z2d+BHPm1dGB3hhdMXos
 SEhpyacNiv6IUjyz3Vy/vwsbYV62ocnQ+DY73V4IsWc07cdeDh0iSLocIVu5IQE1F4L9
 +vuqjZXlkCwE1OOlvZMWFx0fRMlgUxhRPmJG+Z6sRK/sM8XNCice1z1UD3T/aMG7RJvk
 Vkh7aJuk5Ut3hVXJKgC00nW7rXK4y1/guioNesbosZPzHi+HnyQFtQCTc5GmGmcmTyvz
 3Hzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QHErzVKq4Y1NI9yaT54fCi6ej/6QIhR1Ki5B1dGbbvE=;
 fh=NA2H619veXCFzpnLTrV4lUF7uaNZbrHiQ3UDkK1HUAY=;
 b=WHvknNjolgJ3GE9Kh6QXr0jE/7oev62NBoHxtaIP58l8nF7HOA8aNxvyVLXs0PdV91
 ebhsfLu5uAhSPpHFH3uWzi/cyILhYwFpL0AZ1nCbr2VKNYtLWk1P2oLyI6p1pkUUct08
 IRSWF61Qp48Loh5uZNhvEw2DL7sYj2ZPKLtblPDRSvbfyBck2svdYPtbcG7FHyeQxRy/
 0Qw1H/q1ksaMFAtVgfrI673dAUX6l6BKFpYYWAaowkjFi2YU8QiWNo8b3Cj9XdK8mAgi
 f8cxFV+K6zuDAx7KcNhZpTEhMKn+41XLvTBLQGBsnqM+gAUR6opiax/Hldmn6qxrUVu2
 l01Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777906810; x=1778511610; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QHErzVKq4Y1NI9yaT54fCi6ej/6QIhR1Ki5B1dGbbvE=;
 b=nNS1PIZPOYyRnd/qal5VaHvb8NW9ex/htlWErVAvrFAmrxYacwPcWwkLcuzRShC6ow
 Id+9Lv1b2GPjUjfB59cd4Q1EHDe8ws8d4yGB1kD3SFyjFo3MQNSEW/s2Y1cfioO5fhXM
 ufZsH879NvYevZBPeQL07rMWEYbd9N/c7MUvEZqubX1d2ESPkJc0gX1dQ/XO+GBGp8EA
 J0q+j7I3cfTDhjGkgWC3hZMkquMAbjhMKNjUmERB/a4KodQf7se+QFn0XGFHiGcckQOY
 55fhBUBL5ZGny7Qlmvc5NketDI5kBx6YW/p9+z0cbNJSMz/L/VG+SVHHYLSTh+Et5+uG
 yH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777906810; x=1778511610;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QHErzVKq4Y1NI9yaT54fCi6ej/6QIhR1Ki5B1dGbbvE=;
 b=KWxm+t4Jjv6YO2m0JdmRA8aWGek7ZWRvywo3QJGLE2/AbEGyJ9n8H75CD3dPGPcHzp
 P+9wBtp5B10E3D7ciLJqf8nce+K9Bc6HEBBPbvrDi550NG8yBAzvWuOjBAr+fKjC3iOw
 5PTw1aphB609ECHbWPyw+SsbZagwhrFUlEPD4DRpGT7FY/l2ch1JCtr7c8F7kxPA1Izk
 zjVhYsxrr4n/WNuhuq98dzlxr1P8kZl44buLQmR0WjVHF1M+VMgNQ5zYKgNsYBY/p1MZ
 LUgLqC0gZo+kTsEip9CIwX9Gv1/Bo6dciais2ldqIuEBn5wqOo0Ap5zTqPQUDf5GYz7P
 dauQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/HdDccS4V6Mn4BVjFDkmV0LkQ8XIpAUnRge7ZCSSj1HyxrS9FS1rkcTd6DdnD9BnD4ksGhZs1HXXOa@nongnu.org
X-Gm-Message-State: AOJu0YyC/086IMuDPF9j7R5Wli4NlnvT1nBL8gwPnof1aPi9nrwc4Gws
 uxIPTKu8PObip+WC7KYPWk+X2eFuZXf79ESqeu6vw6u/hXMXTjPv1vsM7GmrAyfI5l+ERh00jl2
 TSn4cQRftObmAnFasRAO1IbSPZI6pavk=
X-Gm-Gg: AeBDiettdlimK3yaZ5LUrf/c88Q/fD+nEg08KcrIoGbbFcWQi7qPPD+EBlwLZvSxPiA
 IZtqMZB5xD7SQAxZO7RKigCC2UBUuzZmioJaoRDAICghL2Zv7nSpqU7PqIPpcDpjo9W23KNafkx
 mipIPiAwNL2bgDmHtRocb2tiLRMi8Te2Nyl+rnGTnZZUWA9KwYEIe0+1vjISMR4FzeYnif3AW/x
 5FTt2ARy5/+L7j3xmlkCqHhs63xCzcFb3aLuYyiSW3S8AiHsMcYTW/qX15CGGBsXfu5/2m7w6hn
 TBEZuC05mlcOqPJJ
X-Received: by 2002:a05:7300:dc88:b0:2f1:8f09:702a with SMTP id
 5a478bee46e88-2f18f0a03c3mr1850396eec.13.1777906809560; Mon, 04 May 2026
 08:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260429190550.20122-1-farosas@suse.de>
 <20260429190550.20122-2-farosas@suse.de>
 <afO9GsCVTZdh2x96@x1.local> <87qznrp7rh.fsf@suse.de>
In-Reply-To: <87qznrp7rh.fsf@suse.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 4 May 2026 18:59:57 +0400
X-Gm-Features: AVHnY4LaTcohZM8s8XfTq6M1V27UQzJnSK4aU0_EMs8VlfEg0nE_uavQbXjxdVY
Message-ID: <CAJ+F1CJFuO5WRpKUny_dWVMx8+ZxRMn2zHX7VK8rQUpBaAithw@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] tests/qtest/dbus-vmstate: Bring the test up-to-date
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x132e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Fabiano

On Mon, May 4, 2026 at 6:32=E2=80=AFPM Fabiano Rosas <farosas@suse.de> wrot=
e:
>
> Peter Xu <peterx@redhat.com> writes:
>
> > On Wed, Apr 29, 2026 at 04:05:46PM -0300, Fabiano Rosas wrote:
> >> The dbus-vmstate-test has been disabled for years. Here's the things
> >> that have changed in the meantime and how to update the test:
> >>
> >> - Migration tests got new headers.
> >> Update the includes.
> >>
> >> - migrate_qmp got new parameters.
> >> Update the caller.
> >>
> >> - migrate_incoming_qmp is now used instead of -incoming URL.
> >> Use -incoming defer.
> >>
> >> - Tests expecting failure should not check non-zero return code.
> >> Check for failed migration state instead.
> >>
> >> - The test result enum was introduced.
> >> Replace the migration_fail flag with the enum.
> >>
> >> - The DEVICE state was added.
> >> Replace wait_for_migration_complete with migration_event_wait, which
> >> won't trip on intermediary states.
> >>
> >> - Migration completion was reworked.
> >> Explicitly wait for the RESUME event before asserting runstate is
> >> RUNNING to avoid checking too quickly and seeing FINISH_MIGRATE
> >> instead.
> >>
> >> - The FAILING state was added.
> >> Wait for it before waiting for the RESUME event.
> >>
> >> - Sanity checks were added to migration_get_env().
> >> Start calling that function in main.
> >>
> >> - qtest_add_func now has a wrapper.
> >> Replace qtest_add_func with migration_test_add. Update tests'
> >> signatures to take MigrationCommon, although it's unused.
> >>
> >> - meson now sets up G_TEST_DBUS_DAEMON.
> >> Remove the logic around it.
> >>
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >
> > I don't think I'm confident reviewing the whole series, but you can tak=
e:
> >
> > Acked-by: Peter Xu <peterx@redhat.com>
> >
> > One trivial question below,
> >
> >> ---
> >>  tests/qtest/dbus-vmstate-test.c | 71 +++++++++++++++++++-------------=
-
> >>  tests/qtest/meson.build         |  7 +++-
> >>  2 files changed, 46 insertions(+), 32 deletions(-)
> >>
> >> diff --git a/tests/qtest/dbus-vmstate-test.c b/tests/qtest/dbus-vmstat=
e-test.c
> >> index 0a82cc9f93..90c050b448 100644
> >> --- a/tests/qtest/dbus-vmstate-test.c
> >> +++ b/tests/qtest/dbus-vmstate-test.c
> >> @@ -2,8 +2,8 @@
> >>  #include <glib/gstdio.h>
> >>  #include <gio/gio.h>
> >>  #include "libqtest.h"
> >> +#include "migration/migration-qmp.h"
> >>  #include "dbus-vmstate1.h"
> >> -#include "migration-helpers.h"
> >>
> >>  static char *workdir;
> >>
> >> @@ -29,7 +29,7 @@ typedef struct TestServer {
> >>
> >>  typedef struct Test {
> >>      const char *id_list;
> >> -    bool migrate_fail;
> >> +    int result;
> >>      bool without_dst_b;
> >>      TestServer srcA;
> >>      TestServer dstA;
> >> @@ -190,6 +190,7 @@ test_dbus_vmstate(Test *test)
> >>      g_autofree char *uri =3D NULL;
> >>      QTestState *src_qemu =3D NULL, *dst_qemu =3D NULL;
> >>      guint ownsrcA, ownsrcB, owndstA, owndstB;
> >> +    QTestMigrationState src_state =3D { };
> >>
> >>      uri =3D g_strdup_printf("unix:%s/migsocket", workdir);
> >>
> >> @@ -224,17 +225,33 @@ test_dbus_vmstate(Test *test)
> >>
> >>      src_qemu =3D qtest_init(src_qemu_args);
> >>      dst_qemu =3D qtest_init(dst_qemu_args);
> >> +
> >> +    migrate_set_capability(src_qemu, "events", true);
> >> +    qtest_qmp_set_event_callback(src_qemu, migrate_watch_for_events,
> >> +                                 &src_state);
> >> +
> >>      set_id_list(test, src_qemu);
> >>      set_id_list(test, dst_qemu);
> >>
> >>      thread =3D g_thread_new("dbus-vmstate-thread", dbus_vmstate_threa=
d, loop);
> >>
> >>      migrate_incoming_qmp(dst_qemu, uri, NULL, "{}");
> >> -    migrate_qmp(src_qemu, uri, "{}");
> >> +    migrate_ensure_converge(src_qemu);
> >> +    migrate_qmp(src_qemu, NULL, uri, NULL, "{}");
> >>      test->src_qemu =3D src_qemu;
> >> -    if (test->migrate_fail) {
> >> -        wait_for_migration_fail(src_qemu, true);
> >> -        qtest_set_expected_status(dst_qemu, EXIT_FAILURE);
> >> +
> >> +    if (test->result !=3D MIG_TEST_SUCCEED) {
> >> +        QDict *rsp;
> >> +
> >> +        migration_event_wait(src_qemu, "failing");
> >> +        wait_for_resume(src_qemu, &src_state);
> >> +        migration_event_wait(src_qemu, "failed");
> >
> > Not sure if we need such detailed checks over failing, resume, failed
> > events on this one, but it looks ok.
> >
>
> I actually had a hang when not checking for failing.  I didn't give it
> much thought because I know we added a new state.

Should we keep skipping this test then? should I wait for an updated series=
?

thanks

>
> > Do you plan to remove wait_for_migration_fail() finally?  We still have=
 a
> > few other users.  IIUC, we could also switch to using events for
> > wait_for_migration_fail().
> >
>
> Seems like a good idea to not need so many query-migrate
> invocations. Except that we could hide some potential races with QMP
> commands. And we lose the timeout as well. I'll take a look at what can
> be done.
>
> >> +
> >> +        rsp =3D qtest_qmp_assert_success_ref(src_qemu,
> >> +                                           "{ 'execute': 'query-statu=
s' }");
> >> +        g_assert(qdict_haskey(rsp, "running"));
> >> +        g_assert(qdict_get_bool(rsp, "running"));
> >> +        qobject_unref(rsp);
> >>      } else {
> >>          wait_for_migration_complete(src_qemu);
> >>      }
> >> @@ -270,7 +287,7 @@ check_migrated(TestServer *s, TestServer *d)
> >>  }
> >>
> >>  static void
> >> -test_dbus_vmstate_without_list(void)
> >> +test_dbus_vmstate_without_list(char *name, MigrateCommon *args)
> >>  {
> >>      Test test =3D { 0, };
> >>
> >> @@ -281,7 +298,7 @@ test_dbus_vmstate_without_list(void)
> >>  }
> >>
> >>  static void
> >> -test_dbus_vmstate_with_list(void)
> >> +test_dbus_vmstate_with_list(char *name, MigrateCommon *args)
> >>  {
> >>      Test test =3D { .id_list =3D "idA,idB" };
> >>
> >> @@ -292,7 +309,7 @@ test_dbus_vmstate_with_list(void)
> >>  }
> >>
> >>  static void
> >> -test_dbus_vmstate_only_a(void)
> >> +test_dbus_vmstate_only_a(char *name, MigrateCommon *args)
> >>  {
> >>      Test test =3D { .id_list =3D "idA" };
> >>
> >> @@ -303,9 +320,10 @@ test_dbus_vmstate_only_a(void)
> >>  }
> >>
> >>  static void
> >> -test_dbus_vmstate_missing_src(void)
> >> +test_dbus_vmstate_missing_src(char *name, MigrateCommon *args)
> >>  {
> >> -    Test test =3D { .id_list =3D "idA,idC", .migrate_fail =3D true };
> >> +    Test test =3D { .id_list =3D "idA,idC",
> >> +        .result =3D MIG_TEST_FAIL };
> >>
> >>      /* run in subprocess to silence QEMU error reporting */
> >>      if (g_test_subprocess()) {
> >> @@ -320,11 +338,11 @@ test_dbus_vmstate_missing_src(void)
> >>  }
> >>
> >>  static void
> >> -test_dbus_vmstate_missing_dst(void)
> >> +test_dbus_vmstate_missing_dst(char *name, MigrateCommon *args)
> >>  {
> >>      Test test =3D { .id_list =3D "idA,idB",
> >>                    .without_dst_b =3D true,
> >> -                  .migrate_fail =3D true };
> >> +                  .result =3D MIG_TEST_FAIL };
> >>
> >>      /* run in subprocess to silence QEMU error reporting */
> >>      if (g_test_subprocess()) {
> >> @@ -343,15 +361,8 @@ int
> >>  main(int argc, char **argv)
> >>  {
> >>      GError *err =3D NULL;
> >> -    g_autofree char *dbus_daemon =3D NULL;
> >>      int ret;
> >>
> >> -    dbus_daemon =3D g_build_filename(G_STRINGIFY(SRCDIR),
> >> -                                   "tests",
> >> -                                   "dbus-vmstate-daemon.sh",
> >> -                                   NULL);
> >> -    g_setenv("G_TEST_DBUS_DAEMON", dbus_daemon, true);
> >> -
> >>      g_test_init(&argc, &argv, NULL);
> >>
> >>      workdir =3D g_dir_make_tmp("dbus-vmstate-test-XXXXXX", &err);
> >> @@ -362,16 +373,16 @@ main(int argc, char **argv)
> >>
> >>      g_setenv("DBUS_VMSTATE_TEST_TMPDIR", workdir, true);
> >>
> >> -    qtest_add_func("/dbus-vmstate/without-list",
> >> -                   test_dbus_vmstate_without_list);
> >> -    qtest_add_func("/dbus-vmstate/with-list",
> >> -                   test_dbus_vmstate_with_list);
> >> -    qtest_add_func("/dbus-vmstate/only-a",
> >> -                   test_dbus_vmstate_only_a);
> >> -    qtest_add_func("/dbus-vmstate/missing-src",
> >> -                   test_dbus_vmstate_missing_src);
> >> -    qtest_add_func("/dbus-vmstate/missing-dst",
> >> -                   test_dbus_vmstate_missing_dst);
> >> +    migration_test_add("/dbus-vmstate/without-list",
> >> +                       test_dbus_vmstate_without_list);
> >> +    migration_test_add("/dbus-vmstate/with-list",
> >> +                       test_dbus_vmstate_with_list);
> >> +    migration_test_add("/dbus-vmstate/only-a",
> >> +                       test_dbus_vmstate_only_a);
> >> +    migration_test_add("/dbus-vmstate/missing-src",
> >> +                       test_dbus_vmstate_missing_src);
> >> +    migration_test_add("/dbus-vmstate/missing-dst",
> >> +                       test_dbus_vmstate_missing_dst);
> >>
> >>      ret =3D g_test_run();
> >>
> >> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> >> index b735f55fc4..0d04e2cbaa 100644
> >> --- a/tests/qtest/meson.build
> >> +++ b/tests/qtest/meson.build
> >> @@ -126,10 +126,12 @@ if dbus_daemon.found() and gdbus_codegen.found()
> >>    # Temporarily disabled due to Patchew failures:
> >>    #qtests_i386 +=3D ['dbus-vmstate-test']
> >>    dbus_vmstate1 =3D custom_target('dbus-vmstate description',
> >> -                                output: ['dbus-vmstate1.h', 'dbus-vms=
tate1.c'],
> >> +                                build_by_default: true,
> >> +                                output: [ 'dbus-vmstate1.h', 'dbus-vm=
state1.c'],
> >>                                  input: meson.project_source_root() / =
'backends/dbus-vmstate1.xml',
> >>                                  command: [gdbus_codegen, '@INPUT@',
> >>                                            '--interface-prefix', 'org.=
qemu',
> >> +                                          '--output-directory', meson=
.current_build_dir(),
> >>                                            '--generate-c-code', '@BASE=
NAME@']).to_list()
> >>  else
> >>    dbus_vmstate1 =3D []
> >> @@ -385,7 +387,8 @@ qtests =3D {
> >>    'bios-tables-test': [io, 'boot-sector.c', 'acpi-utils.c', 'tpm-emu.=
c'],
> >>    'cdrom-test': files('boot-sector.c'),
> >>    'dbus-vmstate-test': files('migration/migration-qmp.c',
> >> -                             'migration/migration-util.c') + dbus_vms=
tate1,
> >> +                             'migration/migration-util.c') + dbus_vms=
tate1 +
> >> +                       [gio],
> >>    'erst-test': files('erst-test.c'),
> >>    'ivshmem-test': [rt, '../../contrib/ivshmem-server/ivshmem-server.c=
'],
> >>    'migration-test': test_migration_files + migration_tls_files + migr=
ation_colo_files,
> >> --
> >> 2.51.0
> >>
>


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F76CFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 16:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJwIA-0000zS-31; Mon, 04 May 2026 12:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wJwI8-0000zF-CR
 for qemu-devel@nongnu.org; Mon, 04 May 2026 12:37:08 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wJwI5-0000vP-Sd
 for qemu-devel@nongnu.org; Mon, 04 May 2026 12:37:07 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0DB196A8BD;
 Mon,  4 May 2026 16:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777912622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vv/8b15FbeLbOzvZeSpzrlBkcosOsZMDykrVic6YmzM=;
 b=oIbCcxzxV7XXV5giCd8PR04rjILrZLDwpyIFh/Aq7ykKMqH1QyeksO2tAHZs9yOsPK6GtG
 sSDmk7BJptdKtCwap1pe9W9AQBdw7iasuPhCvE+xWlIUGrQG41WgLs7vc8LFLAa9yQ0T5U
 +vyBFJOVeUMJVdlGOY/ZC+8P1VP2hb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777912622;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vv/8b15FbeLbOzvZeSpzrlBkcosOsZMDykrVic6YmzM=;
 b=KKH282M6LimDcpxfgp2aplnlNIJCjwbDye9ZavMtIVRPoeOWL/X1OSl8CVkNTvSrdabhBY
 guN20nymjnDaeBBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777912622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vv/8b15FbeLbOzvZeSpzrlBkcosOsZMDykrVic6YmzM=;
 b=oIbCcxzxV7XXV5giCd8PR04rjILrZLDwpyIFh/Aq7ykKMqH1QyeksO2tAHZs9yOsPK6GtG
 sSDmk7BJptdKtCwap1pe9W9AQBdw7iasuPhCvE+xWlIUGrQG41WgLs7vc8LFLAa9yQ0T5U
 +vyBFJOVeUMJVdlGOY/ZC+8P1VP2hb4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777912622;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vv/8b15FbeLbOzvZeSpzrlBkcosOsZMDykrVic6YmzM=;
 b=KKH282M6LimDcpxfgp2aplnlNIJCjwbDye9ZavMtIVRPoeOWL/X1OSl8CVkNTvSrdabhBY
 guN20nymjnDaeBBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F523593A3;
 Mon,  4 May 2026 16:37:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id X0SRGy3L+GloWwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 04 May 2026 16:37:01 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 1/5] tests/qtest/dbus-vmstate: Bring the test up-to-date
In-Reply-To: <CAJ+F1CJFuO5WRpKUny_dWVMx8+ZxRMn2zHX7VK8rQUpBaAithw@mail.gmail.com>
References: <20260429190550.20122-1-farosas@suse.de>
 <20260429190550.20122-2-farosas@suse.de> <afO9GsCVTZdh2x96@x1.local>
 <87qznrp7rh.fsf@suse.de>
 <CAJ+F1CJFuO5WRpKUny_dWVMx8+ZxRMn2zHX7VK8rQUpBaAithw@mail.gmail.com>
Date: Mon, 04 May 2026 13:36:55 -0300
Message-ID: <87o6ivp1w8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi Fabiano
>
> On Mon, May 4, 2026 at 6:32=E2=80=AFPM Fabiano Rosas <farosas@suse.de> wr=
ote:
>>
>> Peter Xu <peterx@redhat.com> writes:
>>
>> > On Wed, Apr 29, 2026 at 04:05:46PM -0300, Fabiano Rosas wrote:
>> >> The dbus-vmstate-test has been disabled for years. Here's the things
>> >> that have changed in the meantime and how to update the test:
>> >>
>> >> - Migration tests got new headers.
>> >> Update the includes.
>> >>
>> >> - migrate_qmp got new parameters.
>> >> Update the caller.
>> >>
>> >> - migrate_incoming_qmp is now used instead of -incoming URL.
>> >> Use -incoming defer.
>> >>
>> >> - Tests expecting failure should not check non-zero return code.
>> >> Check for failed migration state instead.
>> >>
>> >> - The test result enum was introduced.
>> >> Replace the migration_fail flag with the enum.
>> >>
>> >> - The DEVICE state was added.
>> >> Replace wait_for_migration_complete with migration_event_wait, which
>> >> won't trip on intermediary states.
>> >>
>> >> - Migration completion was reworked.
>> >> Explicitly wait for the RESUME event before asserting runstate is
>> >> RUNNING to avoid checking too quickly and seeing FINISH_MIGRATE
>> >> instead.
>> >>
>> >> - The FAILING state was added.
>> >> Wait for it before waiting for the RESUME event.
>> >>
>> >> - Sanity checks were added to migration_get_env().
>> >> Start calling that function in main.
>> >>
>> >> - qtest_add_func now has a wrapper.
>> >> Replace qtest_add_func with migration_test_add. Update tests'
>> >> signatures to take MigrationCommon, although it's unused.
>> >>
>> >> - meson now sets up G_TEST_DBUS_DAEMON.
>> >> Remove the logic around it.
>> >>
>> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> >
>> > I don't think I'm confident reviewing the whole series, but you can ta=
ke:
>> >
>> > Acked-by: Peter Xu <peterx@redhat.com>
>> >
>> > One trivial question below,
>> >
>> >> ---
>> >>  tests/qtest/dbus-vmstate-test.c | 71 +++++++++++++++++++------------=
--
>> >>  tests/qtest/meson.build         |  7 +++-
>> >>  2 files changed, 46 insertions(+), 32 deletions(-)
>> >>
>> >> diff --git a/tests/qtest/dbus-vmstate-test.c b/tests/qtest/dbus-vmsta=
te-test.c
>> >> index 0a82cc9f93..90c050b448 100644
>> >> --- a/tests/qtest/dbus-vmstate-test.c
>> >> +++ b/tests/qtest/dbus-vmstate-test.c
>> >> @@ -2,8 +2,8 @@
>> >>  #include <glib/gstdio.h>
>> >>  #include <gio/gio.h>
>> >>  #include "libqtest.h"
>> >> +#include "migration/migration-qmp.h"
>> >>  #include "dbus-vmstate1.h"
>> >> -#include "migration-helpers.h"
>> >>
>> >>  static char *workdir;
>> >>
>> >> @@ -29,7 +29,7 @@ typedef struct TestServer {
>> >>
>> >>  typedef struct Test {
>> >>      const char *id_list;
>> >> -    bool migrate_fail;
>> >> +    int result;
>> >>      bool without_dst_b;
>> >>      TestServer srcA;
>> >>      TestServer dstA;
>> >> @@ -190,6 +190,7 @@ test_dbus_vmstate(Test *test)
>> >>      g_autofree char *uri =3D NULL;
>> >>      QTestState *src_qemu =3D NULL, *dst_qemu =3D NULL;
>> >>      guint ownsrcA, ownsrcB, owndstA, owndstB;
>> >> +    QTestMigrationState src_state =3D { };
>> >>
>> >>      uri =3D g_strdup_printf("unix:%s/migsocket", workdir);
>> >>
>> >> @@ -224,17 +225,33 @@ test_dbus_vmstate(Test *test)
>> >>
>> >>      src_qemu =3D qtest_init(src_qemu_args);
>> >>      dst_qemu =3D qtest_init(dst_qemu_args);
>> >> +
>> >> +    migrate_set_capability(src_qemu, "events", true);
>> >> +    qtest_qmp_set_event_callback(src_qemu, migrate_watch_for_events,
>> >> +                                 &src_state);
>> >> +
>> >>      set_id_list(test, src_qemu);
>> >>      set_id_list(test, dst_qemu);
>> >>
>> >>      thread =3D g_thread_new("dbus-vmstate-thread", dbus_vmstate_thre=
ad, loop);
>> >>
>> >>      migrate_incoming_qmp(dst_qemu, uri, NULL, "{}");
>> >> -    migrate_qmp(src_qemu, uri, "{}");
>> >> +    migrate_ensure_converge(src_qemu);
>> >> +    migrate_qmp(src_qemu, NULL, uri, NULL, "{}");
>> >>      test->src_qemu =3D src_qemu;
>> >> -    if (test->migrate_fail) {
>> >> -        wait_for_migration_fail(src_qemu, true);
>> >> -        qtest_set_expected_status(dst_qemu, EXIT_FAILURE);
>> >> +
>> >> +    if (test->result !=3D MIG_TEST_SUCCEED) {
>> >> +        QDict *rsp;
>> >> +
>> >> +        migration_event_wait(src_qemu, "failing");
>> >> +        wait_for_resume(src_qemu, &src_state);
>> >> +        migration_event_wait(src_qemu, "failed");
>> >
>> > Not sure if we need such detailed checks over failing, resume, failed
>> > events on this one, but it looks ok.
>> >
>>
>> I actually had a hang when not checking for failing.  I didn't give it
>> much thought because I know we added a new state.
>
> Should we keep skipping this test then? should I wait for an updated seri=
es?
>

No, it's all good. If I decide to change this, I'll send a patch on top.


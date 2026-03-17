Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7541FD875D
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 12:29:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2TXf-0001f0-Bu; Tue, 17 Mar 2026 08:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w2TXb-0001ee-BV
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 08:28:55 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w2TXZ-0000XL-AM
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 08:28:55 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5B3BC4D340;
 Tue, 17 Mar 2026 12:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773750531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+P0l3Dl34JiD8ybyEYWR5nIDE87+Anl8yHWt9zAAuJ0=;
 b=SOY+38zT8GWe2GzzJrtR+5DKkQYuw2hdmqmJBk68BpAco7yF+JXonZkzPC5BlPylAiuTk+
 nYplIps3ENG+QMmpqM26djENsn03jxvA6UqX0BxcUVe/J31ArYWosnSBdYDAbL0ios6y8X
 7Ku5D+Z//cPRB8Lx3fR+GoaIKeP/3J4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773750531;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+P0l3Dl34JiD8ybyEYWR5nIDE87+Anl8yHWt9zAAuJ0=;
 b=lw14MwtyoByOcptP52JtZmJgVeC5NMepAGsdGOUg/WNPjW9WtjT1OOvvvXmwG4TnTShpwN
 u4WYATDDWdpzuICQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773750531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+P0l3Dl34JiD8ybyEYWR5nIDE87+Anl8yHWt9zAAuJ0=;
 b=SOY+38zT8GWe2GzzJrtR+5DKkQYuw2hdmqmJBk68BpAco7yF+JXonZkzPC5BlPylAiuTk+
 nYplIps3ENG+QMmpqM26djENsn03jxvA6UqX0BxcUVe/J31ArYWosnSBdYDAbL0ios6y8X
 7Ku5D+Z//cPRB8Lx3fR+GoaIKeP/3J4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773750531;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+P0l3Dl34JiD8ybyEYWR5nIDE87+Anl8yHWt9zAAuJ0=;
 b=lw14MwtyoByOcptP52JtZmJgVeC5NMepAGsdGOUg/WNPjW9WtjT1OOvvvXmwG4TnTShpwN
 u4WYATDDWdpzuICQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D6A84273B;
 Tue, 17 Mar 2026 12:28:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vU5aDQJJuWlwAgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Mar 2026 12:28:50 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 58/60] tests/qtest: fix dbus-vmstate-test compilation
In-Reply-To: <20260317-qemu-vnc-v1-58-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
 <20260317-qemu-vnc-v1-58-48eb1dcf7b76@redhat.com>
Date: Tue, 17 Mar 2026 09:28:47 -0300
Message-ID: <87ms06r668.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 MID_RHS_MATCH_FROM(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

> The test is still disabled, and trying to compile it will fail now.
>
> Fix it, and remove the G_TEST_DBUS_DAEMON setting, since it is passed by
> meson test. Fwiw, the test passes here.
>

Hi, I have a series re-enabling this test and doing a few fixes, take a
look whether it helps you. I'm a bit short on time right now, but I
could rebase and post it after the freeze.

https://gitlab.com/farosas/qemu/-/commits/migration-test-dbus-vmstate?ref_t=
ype=3Dheads

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/qtest/dbus-vmstate-test.c | 11 ++---------
>  tests/qtest/meson.build         |  3 ++-
>  2 files changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/tests/qtest/dbus-vmstate-test.c b/tests/qtest/dbus-vmstate-t=
est.c
> index 6c990864e3e..ed4a52d0255 100644
> --- a/tests/qtest/dbus-vmstate-test.c
> +++ b/tests/qtest/dbus-vmstate-test.c
> @@ -3,7 +3,7 @@
>  #include <gio/gio.h>

I remember some CI job failed due to the test not declaring this
dependency.

>  #include "libqtest.h"
>  #include "dbus-vmstate1.h"
> -#include "migration-helpers.h"
> +#include "migration/migration-qmp.h"
>=20=20
>  static char *workdir;
>=20=20
> @@ -229,7 +229,7 @@ test_dbus_vmstate(Test *test)
>=20=20
>      thread =3D g_thread_new("dbus-vmstate-thread", dbus_vmstate_thread, =
loop);
>=20=20
> -    migrate_qmp(src_qemu, uri, "{}");
> +    migrate_qmp(src_qemu, dst_qemu, uri, NULL, "{}");

This works, however I have patches queued for the hardfreeze that change
some details in the migration tests infra:

- dst cmdline should use -incoming defer
- migrate_incoming_qmp needs to be called
- no more setting: qtest_set_expected_status(dst_qemu, EXIT_FAILURE);

>      test->src_qemu =3D src_qemu;
>      if (test->migrate_fail) {
>          wait_for_migration_fail(src_qemu, true);
> @@ -342,15 +342,8 @@ int
>  main(int argc, char **argv)
>  {
>      GError *err =3D NULL;
> -    g_autofree char *dbus_daemon =3D NULL;
>      int ret;
>=20=20
> -    dbus_daemon =3D g_build_filename(G_STRINGIFY(SRCDIR),
> -                                   "tests",
> -                                   "dbus-vmstate-daemon.sh",
> -                                   NULL);
> -    g_setenv("G_TEST_DBUS_DAEMON", dbus_daemon, true);
> -
>      g_test_init(&argc, &argv, NULL);
>=20=20
>      workdir =3D g_dir_make_tmp("dbus-vmstate-test-XXXXXX", &err);
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index b735f55fc40..5f8cff172c8 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -130,7 +130,8 @@ if dbus_daemon.found() and gdbus_codegen.found()
>                                  input: meson.project_source_root() / 'ba=
ckends/dbus-vmstate1.xml',
>                                  command: [gdbus_codegen, '@INPUT@',
>                                            '--interface-prefix', 'org.qem=
u',
> -                                          '--generate-c-code', '@BASENAM=
E@']).to_list()
> +                                          '--generate-c-code', '@BASENAM=
E@',
> +                                          '--output-directory', meson.cu=
rrent_build_dir()]).to_list()
>  else
>    dbus_vmstate1 =3D []
>  endif


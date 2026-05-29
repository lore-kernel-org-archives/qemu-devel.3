Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDA2CD6E4A
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 13:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSxLm-0005Xm-S5; Fri, 29 May 2026 09:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wSxLl-0005Xb-Lh
 for qemu-devel@nongnu.org; Fri, 29 May 2026 09:34:09 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wSxLj-0002s1-NU
 for qemu-devel@nongnu.org; Fri, 29 May 2026 09:34:09 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ABB6666E3A;
 Fri, 29 May 2026 13:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780061645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u64qVmyX8GlwlEOVOKDclvw6jIlj3W/TL/bkp6NNLJw=;
 b=TMzppqsPUOuB+QU80ZdX3qwy0xBzqYSRkzK0DQY+oKLoYgkba06VSgd2oikTFs3EAOyF4W
 4PH5hnwPeGlaKB3VZc5hWTZTSEXRzXpbSMzOTkihYauNfMpbkqdCyjgvhgHxMvcNHkbF5e
 QS9SOqjtepp3gmHysKnKv8vtLOPEAAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780061645;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u64qVmyX8GlwlEOVOKDclvw6jIlj3W/TL/bkp6NNLJw=;
 b=CAVR67bxo9jUUUFdD1w2T7Asfi8C+H2L6dvK7SW6SZdR9sLkPpmWUufVeOt/J7Z1XC1vSA
 4TRSYmt/180nthDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TMzppqsP;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CAVR67bx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780061645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u64qVmyX8GlwlEOVOKDclvw6jIlj3W/TL/bkp6NNLJw=;
 b=TMzppqsPUOuB+QU80ZdX3qwy0xBzqYSRkzK0DQY+oKLoYgkba06VSgd2oikTFs3EAOyF4W
 4PH5hnwPeGlaKB3VZc5hWTZTSEXRzXpbSMzOTkihYauNfMpbkqdCyjgvhgHxMvcNHkbF5e
 QS9SOqjtepp3gmHysKnKv8vtLOPEAAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780061645;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u64qVmyX8GlwlEOVOKDclvw6jIlj3W/TL/bkp6NNLJw=;
 b=CAVR67bxo9jUUUFdD1w2T7Asfi8C+H2L6dvK7SW6SZdR9sLkPpmWUufVeOt/J7Z1XC1vSA
 4TRSYmt/180nthDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 40F07779A7;
 Fri, 29 May 2026 13:34:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Byr5BM2VGWrWSgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 29 May 2026 13:34:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang?=
 =?utf-8?Q?=C3=A9?=
 <berrange@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Laurent Vivier
 <lvivier@redhat.com>, Alex Williamson <alex@shazbot.org>, =?utf-8?Q?C?=
 =?utf-8?Q?=C3=A9dric?= Le Goater
 <clg@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 32/32] tests/qtest: add D-Bus display hotplug test
In-Reply-To: <20260529-b4-ui-v1-32-8db3068421ef@redhat.com>
References: <20260529-b4-ui-v1-0-8db3068421ef@redhat.com>
 <20260529-b4-ui-v1-32-8db3068421ef@redhat.com>
Date: Fri, 29 May 2026 10:34:02 -0300
Message-ID: <87fr3atk51.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: ABB6666E3A
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[12]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

> Add a qtest that verifies display consoles are dynamically added and
> removed over D-Bus when a bochs-display device is hotplugged and
> unplugged on a q35 machine.
>
> The test plugs device_add a bochs-display, waits for the DEVICE_ADDED
> QMP event, and checks that the D-Bus VM interface reports a second
> console. It then device_del it, forces a system reset
> (q35 removal is ACPI-based and needs guest cooperation qtest cannot
> provide), waits for DEVICE_DELETED, and checks the console count again.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/qtest/dbus-display-test.c | 101 ++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 99 insertions(+), 2 deletions(-)
>
> diff --git a/tests/qtest/dbus-display-test.c b/tests/qtest/dbus-display-t=
est.c
> index 5773776cad5..7838ce7323f 100644
> --- a/tests/qtest/dbus-display-test.c
> +++ b/tests/qtest/dbus-display-test.c
> @@ -7,6 +7,8 @@
>  #include <gio/gio.h>
>  #include <gio/gunixfdlist.h>
>  #include "libqtest.h"
> +#include "qobject/qdict.h"
> +#include "qobject/qstring.h"
>  #include "ui/dbus-display1.h"
>=20=20
>  static GDBusConnection*
> @@ -38,11 +40,11 @@ test_dbus_p2p_from_fd(int fd)
>  }
>=20=20
>  static void
> -test_setup(QTestState **qts, GDBusConnection **conn)
> +test_setup_args(QTestState **qts, GDBusConnection **conn, const char *ar=
gs)
>  {
>      int pair[2];
>=20=20
> -    *qts =3D qtest_init("-display dbus,p2p=3Dyes -name dbus-test");
> +    *qts =3D qtest_init(args);
>=20=20
>      g_assert_cmpint(qemu_socketpair(AF_UNIX, SOCK_STREAM, 0, pair), =3D=
=3D, 0);
>=20=20
> @@ -52,6 +54,12 @@ test_setup(QTestState **qts, GDBusConnection **conn)
>      g_dbus_connection_start_message_processing(*conn);
>  }
>=20=20
> +static void
> +test_setup(QTestState **qts, GDBusConnection **conn)
> +{
> +    test_setup_args(qts, conn, "-display dbus,p2p=3Dyes -name dbus-test"=
);
> +}
> +
>  static void
>  test_dbus_display_vm(void)
>  {
> @@ -360,6 +368,92 @@ test_dbus_display_keyboard(void)
>      qtest_quit(qts);
>  }
>=20=20
> +static gsize
> +get_console_ids_count(GDBusConnection *conn)
> +{
> +    g_autoptr(GError) err =3D NULL;
> +    g_autoptr(QemuDBusDisplay1VMProxy) vm =3D NULL;
> +    GVariant *console_ids;
> +    gsize n_ids =3D 0;
> +
> +    vm =3D QEMU_DBUS_DISPLAY1_VM_PROXY(
> +        qemu_dbus_display1_vm_proxy_new_sync(
> +            conn,
> +            G_DBUS_PROXY_FLAGS_NONE,
> +            NULL,
> +            DBUS_DISPLAY1_ROOT "/VM",
> +            NULL,
> +            &err));
> +    g_assert_no_error(err);
> +
> +    console_ids =3D qemu_dbus_display1_vm_get_console_ids(
> +        QEMU_DBUS_DISPLAY1_VM(vm));
> +    if (console_ids) {
> +        n_ids =3D g_variant_n_children(console_ids);
> +    }
> +    return n_ids;
> +}
> +
> +static void
> +wait_device_event(QTestState *qts, const char *event_name, const char *i=
d)
> +{
> +    QDict *resp, *data;
> +    QString *qstr;
> +
> +    for (;;) {
> +        resp =3D qtest_qmp_eventwait_ref(qts, event_name);
> +        data =3D qdict_get_qdict(resp, "data");
> +        if (!data || !qdict_get(data, "device")) {
> +            qobject_unref(resp);
> +            continue;
> +        }
> +        qstr =3D qobject_to(QString, qdict_get(data, "device"));
> +        if (!strcmp(qstring_get_str(qstr), id)) {
> +            qobject_unref(resp);
> +            break;
> +        }
> +        qobject_unref(resp);
> +    }
> +}
> +
> +static void
> +test_dbus_display_hotplug(void)
> +{
> +    g_autoptr(GDBusConnection) conn =3D NULL;
> +    QTestState *qts =3D NULL;
> +    gsize n;
> +
> +    test_setup_args(&qts, &conn,
> +        "-machine q35"
> +        " -device pcie-root-port,id=3Drp0"
> +        " -display dbus,p2p=3Dyes"
> +        " -name dbus-test");
> +
> +    n =3D get_console_ids_count(conn);
> +    g_assert_cmpuint(n, =3D=3D, 1);
> +
> +    qtest_qmp_device_add(qts, "bochs-display", "bochs0",
> +                         "{'bus': 'rp0'}");
> +
> +    n =3D get_console_ids_count(conn);
> +    g_assert_cmpuint(n, =3D=3D, 2);
> +
> +    /*
> +     * On q35, PCI device removal is ACPI-based and requires guest
> +     * acknowledgement. Since qtest has no guest OS, issue the delete
> +     * request and force removal via system reset.
> +     */
> +    qtest_qmp_device_del_send(qts, "bochs0");
> +    qtest_system_reset_nowait(qts);
> +    wait_device_event(qts, "DEVICE_DELETED", "bochs0");
> +
> +    n =3D get_console_ids_count(conn);
> +    g_assert_cmpuint(n, =3D=3D, 1);
> +
> +    g_clear_object(&conn);
> +    qtest_quit(qts);
> +}
> +
>  int
>  main(int argc, char **argv)
>  {
> @@ -369,6 +463,9 @@ main(int argc, char **argv)
>      qtest_add_data_func("/dbus-display/console", GINT_TO_POINTER(false),=
 test_dbus_display_console);
>      qtest_add_data_func("/dbus-display/console/map", GINT_TO_POINTER(tru=
e), test_dbus_display_console);
>      qtest_add_func("/dbus-display/keyboard", test_dbus_display_keyboard);
> +    if (qtest_has_machine("q35") && qtest_has_device("bochs-display")) {
> +        qtest_add_func("/dbus-display/hotplug", test_dbus_display_hotplu=
g);
> +    }
>=20=20
>      return g_test_run();
>  }

Reviewed-by: Fabiano Rosas <farosas@suse.de>


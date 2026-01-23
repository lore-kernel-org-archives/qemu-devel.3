Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5535DD74EC5
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 13:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjH6D-0007Xn-61; Fri, 23 Jan 2026 08:21:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjH6A-0007Uv-TM
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:21:14 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjH68-0001aR-La
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:21:14 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2CBED337E5;
 Fri, 23 Jan 2026 13:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769174471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ldxCy2723iRolKlVVglCeLGLay7lnBgGlGhZhp9bDVY=;
 b=PauJ92gyXOmPUoqCBFK9QfhXxXQQPJ1GKlhLbP6Yp/A+x5L6pFzBzDwlrfG5ZbtiDAd2Ir
 s3F6pb6CGcDUrcL/DWzrxDAJ/tGskLHCw8ni6f0ovhQrs8VzaxGoqRwF2UTExJLOqKOxSf
 /tz8hmqWwbZns5fW4mskDtzY5iJbkeU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769174471;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ldxCy2723iRolKlVVglCeLGLay7lnBgGlGhZhp9bDVY=;
 b=JmSPZWZFtrCpii1o5Bbl3TozMxrjdat0YT+CgqZwm8XFGO6CmfaxgKenIACkadMiFvxRT5
 ny63cIKs3hlMfWBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769174471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ldxCy2723iRolKlVVglCeLGLay7lnBgGlGhZhp9bDVY=;
 b=PauJ92gyXOmPUoqCBFK9QfhXxXQQPJ1GKlhLbP6Yp/A+x5L6pFzBzDwlrfG5ZbtiDAd2Ir
 s3F6pb6CGcDUrcL/DWzrxDAJ/tGskLHCw8ni6f0ovhQrs8VzaxGoqRwF2UTExJLOqKOxSf
 /tz8hmqWwbZns5fW4mskDtzY5iJbkeU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769174471;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ldxCy2723iRolKlVVglCeLGLay7lnBgGlGhZhp9bDVY=;
 b=JmSPZWZFtrCpii1o5Bbl3TozMxrjdat0YT+CgqZwm8XFGO6CmfaxgKenIACkadMiFvxRT5
 ny63cIKs3hlMfWBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 95138136AA;
 Fri, 23 Jan 2026 13:21:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aFdpFcZ1c2nGYgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Jan 2026 13:21:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 richard.henderson@linaro.org
Subject: Re: [PATCH 1/4] tests: fix leaks in dbus-display-test
In-Reply-To: <20260122113144.2046899-2-marcandre.lureau@redhat.com>
References: <20260122113144.2046899-1-marcandre.lureau@redhat.com>
 <20260122113144.2046899-2-marcandre.lureau@redhat.com>
Date: Fri, 23 Jan 2026 10:21:07 -0300
Message-ID: <87qzrgihx8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
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

marcandre.lureau@redhat.com writes:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Close the connections and complete the method invocations.
>
> Thanks ASAN for the report.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/qtest/dbus-display-test.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/tests/qtest/dbus-display-test.c b/tests/qtest/dbus-display-t=
est.c
> index 1d5951b7117..5773776cad5 100644
> --- a/tests/qtest/dbus-display-test.c
> +++ b/tests/qtest/dbus-display-test.c
> @@ -76,6 +76,7 @@ test_dbus_display_vm(void)
>          qemu_dbus_display1_vm_get_name(QEMU_DBUS_DISPLAY1_VM(vm)),
>          =3D=3D,
>          "dbus-test");
> +    g_clear_object(&conn);
>      qtest_quit(qts);
>  }
>=20=20
> @@ -97,6 +98,8 @@ static gboolean listener_handle_scanout(
>      GVariant *arg_data,
>      TestDBusConsoleRegister *test)
>  {
> +    qemu_dbus_display1_listener_complete_scanout(object, invocation);
> +
>      if (!test->with_map) {
>          g_main_loop_quit(test->loop);
>      }
> @@ -131,6 +134,9 @@ static gboolean listener_handle_scanout_map(
>      g_assert_no_errno(addr =3D=3D MAP_FAILED ? -1 : 0);
>      g_assert_no_errno(munmap(addr, len));
>=20=20
> +    qemu_dbus_display1_listener_unix_map_complete_scanout_map(object, in=
vocation,
> +                                                              NULL);
> +
>      g_main_loop_quit(test->loop);
>=20=20
>      close(fd);
> @@ -287,6 +293,7 @@ test_dbus_display_console(const void* data)
>=20=20
>      g_clear_object(&test.server);
>      g_clear_object(&test.listener_conn);
> +    g_clear_object(&conn);
>      qtest_quit(qts);
>  }
>=20=20
> @@ -322,6 +329,7 @@ test_dbus_display_keyboard(void)
>          &err);
>      if (g_error_matches(err, G_DBUS_ERROR, G_DBUS_ERROR_UNKNOWN_METHOD))=
 {
>          g_test_skip("The VM doesn't have a console!");
> +        g_clear_object(&conn);
>          qtest_quit(qts);
>          return;
>      }
> @@ -348,6 +356,7 @@ test_dbus_display_keyboard(void)
>      g_assert_cmpint(qemu_dbus_display1_keyboard_get_modifiers(
>                          QEMU_DBUS_DISPLAY1_KEYBOARD(keyboard)), =3D=3D, =
0);
>=20=20
> +    g_clear_object(&conn);
>      qtest_quit(qts);
>  }

Acked-by: Fabiano Rosas <farosas@suse.de>


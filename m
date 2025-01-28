Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B864C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 15:00:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcn4T-0001rE-EB; Tue, 28 Jan 2025 10:00:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tcn4P-0001oT-Pg
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 10:00:05 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tcn4N-0000AB-S4
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 10:00:05 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C2CD0210F9;
 Tue, 28 Jan 2025 15:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738076401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PFzi8qR8PXEMNRyDqlcLJS32cPVPanpsfToIXqj7+3k=;
 b=fCXF04RGAwnc99aBipb5ekzpC6BLsuOTf4/0hd3JpqinuoCGEmTgfrs/PJq7rSJNPILvjx
 ppbdXUMN+31KVT8qHH6jJuX6MXJ7KzagAd9fHgcrnsxCfcmQCFb8mXn0Z2+BB7Xm/afAHw
 U0kZ7bs7Z6Yuwln3asWwOUHt1L/Wm3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738076401;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PFzi8qR8PXEMNRyDqlcLJS32cPVPanpsfToIXqj7+3k=;
 b=Um8V5YPCCfLKqnY2rJ2ilRZZ+ch8kf0pjqHxORPn/Zn+ro5hCrVgAzZ2QowgEStMdBZXCF
 xE0ovUOgGsdKIqAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738076401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PFzi8qR8PXEMNRyDqlcLJS32cPVPanpsfToIXqj7+3k=;
 b=fCXF04RGAwnc99aBipb5ekzpC6BLsuOTf4/0hd3JpqinuoCGEmTgfrs/PJq7rSJNPILvjx
 ppbdXUMN+31KVT8qHH6jJuX6MXJ7KzagAd9fHgcrnsxCfcmQCFb8mXn0Z2+BB7Xm/afAHw
 U0kZ7bs7Z6Yuwln3asWwOUHt1L/Wm3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738076401;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PFzi8qR8PXEMNRyDqlcLJS32cPVPanpsfToIXqj7+3k=;
 b=Um8V5YPCCfLKqnY2rJ2ilRZZ+ch8kf0pjqHxORPn/Zn+ro5hCrVgAzZ2QowgEStMdBZXCF
 xE0ovUOgGsdKIqAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2ECBD13625;
 Tue, 28 Jan 2025 15:00:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id py5BN/DwmGfqbQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 28 Jan 2025 15:00:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Hyman Huang
 <yong.huang@smartx.com>, Phil Dennis-Jordan <phil@philjordan.eu>, Peter Xu
 <peterx@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 4/7] tests/qtest/migration: Pass accelerator arguments
 as machine option
In-Reply-To: <20250128135429.8500-5-philmd@linaro.org>
References: <20250128135429.8500-1-philmd@linaro.org>
 <20250128135429.8500-5-philmd@linaro.org>
Date: Tue, 28 Jan 2025 11:59:57 -0300
Message-ID: <87o6zrt24y.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[10]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email, imap1.dmz-prg2.suse.org:helo,
 suse.de:mid]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> The '-accel' CLI option is handler as sugar property as
> '-machine,accel=3D'. Replace the migration tests command
> line, only using the best accelerator available (first
> hardware, then software).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  tests/qtest/migration/framework.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/fr=
amework.c
> index 38a0a1a5264..e567296b014 100644
> --- a/tests/qtest/migration/framework.c
> +++ b/tests/qtest/migration/framework.c
> @@ -214,8 +214,9 @@ int migrate_start(QTestState **from, QTestState **to,=
 const char *uri,
>      const gchar *ignore_stderr;
>      g_autofree char *shmem_opts =3D NULL;
>      g_autofree char *shmem_path =3D NULL;
> -    const char *kvm_opts =3D NULL;
> -    const char *arch =3D qtest_get_arch();
> +    const char *accel_args =3D NULL;
> +    const MigrationTestEnv *env =3D migration_get_env();
> +    const char *arch =3D env->arch;
>      const char *memory_size;
>      const char *machine_alias, *machine_opts =3D "";
>      g_autofree char *machine =3D NULL;
> @@ -296,8 +297,15 @@ int migrate_start(QTestState **from, QTestState **to=
, const char *uri,
>              memory_size, shmem_path);
>      }
>=20=20
> -    if (args->use_dirty_ring) {
> -        kvm_opts =3D ",dirty-ring-size=3D4096";
> +    if (env->has_kvm) {
> +        if (args->use_dirty_ring) {
> +            accel_args =3D "kvm,dirty-ring-size=3D4096";
> +        } else {
> +            accel_args =3D "kvm";
> +        }
> +    } else {
> +        assert(env->has_tcg);
> +        accel_args =3D "tcg";
>      }

I don't think this approach works when testing across
architectures. IIUC has_kvm will be true whenever the *test* can access
/dev/kvm. Which means if we run on a x86 while testing
qemu-system-s390x, then has_kvm=3D=3Dtrue but we actually need to use TCG,
so the fallback in the QEMU binary (-accel kvm -accel tcg) will be
automatically used.

>=20=20
>      if (!qtest_has_machine(machine_alias)) {
> @@ -311,14 +319,12 @@ int migrate_start(QTestState **from, QTestState **t=
o, const char *uri,
>=20=20
>      g_test_message("Using machine type: %s", machine);
>=20=20
> -    cmd_source =3D g_strdup_printf("-accel kvm%s -accel tcg "
> -                                 "-machine %s,%s "
> +    cmd_source =3D g_strdup_printf("-machine %s,%s,accel=3D%s "
>                                   "-name source,debug-threads=3Don "
>                                   "-m %s "
>                                   "-serial file:%s/src_serial "
>                                   "%s %s %s %s",
> -                                 kvm_opts ? kvm_opts : "",
> -                                 machine, machine_opts,
> +                                 machine, machine_opts, accel_args,
>                                   memory_size, tmpfs,
>                                   arch_opts ? arch_opts : "",
>                                   shmem_opts ? shmem_opts : "",
> @@ -332,15 +338,13 @@ int migrate_start(QTestState **from, QTestState **t=
o, const char *uri,
>                                       &src_state);
>      }
>=20=20
> -    cmd_target =3D g_strdup_printf("-accel kvm%s -accel tcg "
> -                                 "-machine %s,%s "
> +    cmd_target =3D g_strdup_printf("-machine %s,%s,accel=3D%s "
>                                   "-name target,debug-threads=3Don "
>                                   "-m %s "
>                                   "-serial file:%s/dest_serial "
>                                   "-incoming %s "
>                                   "%s %s %s %s",
> -                                 kvm_opts ? kvm_opts : "",
> -                                 machine, machine_opts,
> +                                 machine, machine_opts, accel_args,
>                                   memory_size, tmpfs, uri,
>                                   arch_opts ? arch_opts : "",
>                                   shmem_opts ? shmem_opts : "",


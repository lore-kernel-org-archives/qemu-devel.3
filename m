Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC9DC0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 15:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcn8a-0003qH-LK; Tue, 28 Jan 2025 10:04:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tcn8W-0003pG-Ou
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 10:04:20 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tcn8T-0000tV-Um
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 10:04:20 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 357E91F381;
 Tue, 28 Jan 2025 15:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738076655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wugi+eHQAeH/fR8ujFp+0wHFd9Xybv61l0kL70ij+aY=;
 b=TPMgLGRGHV/qzKVO1gIgvlTZTciJElsbkjgrxf2w67g+u8UV/DVPpDXHehD6SpoXbKvr0b
 vXr2F1Ckr+gKlq7LNM4J9aLxQEYOr/e5Sq8F1yn5kvDVK+qfNINhHIcPU5umxKDOs+scLY
 zaBz5xzsDV44eFQtmKFk4t1l6809Uyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738076655;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wugi+eHQAeH/fR8ujFp+0wHFd9Xybv61l0kL70ij+aY=;
 b=KgxsvH1bsjcQ/myC25283DlZ7KZ0sQsJngxjfmcJtIDIKXEKc8Erovh80AnR171+H9NlPZ
 kUmwdAWVhaoyhhDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738076655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wugi+eHQAeH/fR8ujFp+0wHFd9Xybv61l0kL70ij+aY=;
 b=TPMgLGRGHV/qzKVO1gIgvlTZTciJElsbkjgrxf2w67g+u8UV/DVPpDXHehD6SpoXbKvr0b
 vXr2F1Ckr+gKlq7LNM4J9aLxQEYOr/e5Sq8F1yn5kvDVK+qfNINhHIcPU5umxKDOs+scLY
 zaBz5xzsDV44eFQtmKFk4t1l6809Uyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738076655;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wugi+eHQAeH/fR8ujFp+0wHFd9Xybv61l0kL70ij+aY=;
 b=KgxsvH1bsjcQ/myC25283DlZ7KZ0sQsJngxjfmcJtIDIKXEKc8Erovh80AnR171+H9NlPZ
 kUmwdAWVhaoyhhDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1FD313625;
 Tue, 28 Jan 2025 15:04:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id L3eiF+7xmGdFPgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 28 Jan 2025 15:04:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Hyman Huang
 <yong.huang@smartx.com>, Phil Dennis-Jordan <phil@philjordan.eu>, Peter Xu
 <peterx@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 7/7] tests/qtest/migration: Allow using accelerators
 different of TCG / KVM
In-Reply-To: <20250128135429.8500-8-philmd@linaro.org>
References: <20250128135429.8500-1-philmd@linaro.org>
 <20250128135429.8500-8-philmd@linaro.org>
Date: Tue, 28 Jan 2025 12:04:11 -0300
Message-ID: <87ikpzt1xw.fsf@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, imap1.dmz-prg2.suse.org:helo,
 linaro.org:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> There is no particular reason to restrict all the framework
> to TCG or KVM, since we can check on a per-test basis which
> accelerator is available (via MigrationTestEnv::has_$ACCEL).

The reason is:

CONFIG_KVM=3Dn
CONFIG_TCG=3Dn

The check is about "there is no accelerator at all".

>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  tests/qtest/migration/framework.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/fr=
amework.c
> index 30808de14e0..e5f0712c266 100644
> --- a/tests/qtest/migration/framework.c
> +++ b/tests/qtest/migration/framework.c
> @@ -950,11 +950,6 @@ MigrationTestEnv *migration_get_env(void)
>      env->has_hvf =3D qtest_has_accel("hvf");
>      env->has_tcg =3D qtest_has_accel("tcg");
>=20=20
> -    if (!env->has_tcg && !env->has_kvm) {
> -        g_test_skip("No KVM or TCG accelerator available");
> -        return env;
> -    }
> -
>      env->has_dirty_ring =3D env->has_kvm && kvm_dirty_ring_supported();
>      env->has_uffd =3D ufd_version_check(&env->uffd_feature_thread_id);
>      env->is_x86 =3D !strcmp(env->arch, "i386") || !strcmp(env->arch, "x8=
6_64");


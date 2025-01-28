Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B6DC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 14:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcmo6-0006HO-JL; Tue, 28 Jan 2025 09:43:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tcmo4-0006Eg-Ld
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:43:12 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tcmo3-00063M-0S
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:43:12 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D46C721120;
 Tue, 28 Jan 2025 14:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738075389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JpbOMcPy0x4tgI3Ygdi1H85DMesbLLs1RTVUxva78Ls=;
 b=B8FboIdrPGjKMQzv2IW0auV4P7ipUuQ1Fp6bL8lLU1akJMv+x39UGHoa/bkRfEfPiyhy42
 koZtOX77O8wnE/d979icWHkS8D6F8SMLCD6ydZXAQBs1u11Zx/gIPmVLfF7hpD2ZH4lM52
 wNDBcPMTa7q2JfV/XwLvCCKG3LrDDTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738075389;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JpbOMcPy0x4tgI3Ygdi1H85DMesbLLs1RTVUxva78Ls=;
 b=I06N8Gnir6kCbO+jn/Tpcg5bX81Vs799Iserv9HtBeP+uZ0wcFYyJ+m3YY4ri/PKg6UsLf
 hLBt3U7NuycgQ3Bw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="O/LX+yZm";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TSIRSIF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738075388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JpbOMcPy0x4tgI3Ygdi1H85DMesbLLs1RTVUxva78Ls=;
 b=O/LX+yZmSvipaSOnfEfW4SjAZIEbe04uO8uJDrN/t3Ca3BOCJTJOPjdzVE/lthLOMlSzQf
 OJ1Yogqbc+sQUrBrtyc2ek8IYKeCBg3HuC3LGsFObG4B0h17bsuPnsCrGjtoDUGNUQmeVR
 wGt+ers7Phbikl1LAzWSUTlSBjaxAME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738075388;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JpbOMcPy0x4tgI3Ygdi1H85DMesbLLs1RTVUxva78Ls=;
 b=TSIRSIF4owVIZdwvPjvgLP5F1ukBYsL0scZ8hrEk+csgco2p8emsGND6Q7r/BNLsPbBmk/
 PSzlAFPucnIVSPBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B8B513625;
 Tue, 28 Jan 2025 14:43:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id owKKAvzsmGccMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 28 Jan 2025 14:43:08 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Hyman Huang
 <yong.huang@smartx.com>, Phil Dennis-Jordan <phil@philjordan.eu>, Peter Xu
 <peterx@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 3/7] tests/qtest/migration: Initialize
 MigrationTestEnv::arch early
In-Reply-To: <20250128135429.8500-4-philmd@linaro.org>
References: <20250128135429.8500-1-philmd@linaro.org>
 <20250128135429.8500-4-philmd@linaro.org>
Date: Tue, 28 Jan 2025 11:43:05 -0300
Message-ID: <87sep3t2x2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D46C721120
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[10];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> Some tests expect MigrationTestEnv::arch to be set. Initialize
> it early enough to avoid SIGSEGV, for example like the following
> g_str_equal() call in migration/precopy-tests.c:
>
>    954 void migration_test_add_precopy(MigrationTestEnv *env)
>    955 {
>    ...
>   1001     if (g_str_equal(env->arch, "x86_64") && env->has_dirty_ring) {
>   1002
>   1003         migration_test_add("/migration/dirty_ring",
>   1004                            test_precopy_unix_dirty_ring);
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  tests/qtest/migration/framework.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/fr=
amework.c
> index a3bd92a9519..38a0a1a5264 100644
> --- a/tests/qtest/migration/framework.c
> +++ b/tests/qtest/migration/framework.c
> @@ -938,6 +938,8 @@ MigrationTestEnv *migration_get_env(void)
>          exit(1);
>      }
>=20=20
> +    env->arch =3D qtest_get_arch();
> +
>      env->has_kvm =3D qtest_has_accel("kvm");
>      env->has_tcg =3D qtest_has_accel("tcg");
>=20=20
> @@ -948,7 +950,6 @@ MigrationTestEnv *migration_get_env(void)
>=20=20
>      env->has_dirty_ring =3D env->has_kvm && kvm_dirty_ring_supported();
>      env->has_uffd =3D ufd_version_check(&env->uffd_feature_thread_id);
> -    env->arch =3D qtest_get_arch();
>      env->is_x86 =3D !strcmp(env->arch, "i386") || !strcmp(env->arch, "x8=
6_64");
>=20=20
>      env->tmpfs =3D g_dir_make_tmp("migration-test-XXXXXX", &err);

Reviewed-by: Fabiano Rosas <farosas@suse.de>

The change itself is fine, but I think the actual issue is that we
shouldn't be calling g_test_skip() from migration_get_env(). There's no
point adding a bunch of tests if none of them will run because there's
no supported accel present. So:

    if (!env->has_tcg && !env->has_kvm) {
-        g_test_skip("No KVM or TCG accelerator available");
-        return env;
+        g_test_message("No KVM or TCG accelerator available");
+        exit(0);
    }


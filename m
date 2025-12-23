Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 235EDE748FC
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 22:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYBKN-0004wk-Sb; Tue, 23 Dec 2025 17:58:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vYBKM-0004wK-2i
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 17:58:02 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vYBKK-0006Tw-Ge
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 17:58:01 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F3C42339EE;
 Tue, 23 Dec 2025 22:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766530677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UPCyItE7te9obeQYOhIGjgKDpXQH9AkkD5hJHqbolmc=;
 b=aIdGHEexDnHLidEHxsyhbssllxjbTpsLsx29AerKh3fj6rLJ1wC33sXIZ3LmuicT4yOFz+
 /vRqKLIGBEhOwF0NVNDp4Hy+Ahd4uXkwRNL1I9X1BjiXGCPdKiqVJaVT0xUxZGVeKdWtQD
 JEMlkWs38Z7n92/qoTYyRRJGeDBUWig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766530677;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UPCyItE7te9obeQYOhIGjgKDpXQH9AkkD5hJHqbolmc=;
 b=JLEgXweTjBZN/Got2JkXkG0hEFB+UO65eU3jtaMjUeeaQOZn4zkUph6rmBJ4VZZypUqHI0
 bbV/MtKF6U8BO3Ag==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MNSQNjzD;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=itH+55+R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766530676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UPCyItE7te9obeQYOhIGjgKDpXQH9AkkD5hJHqbolmc=;
 b=MNSQNjzDcsk4jGyQa2fc0du/eMOqPXSzBV/Pj0guj0nEx4W89iXaJwMR7jcXi5Jz1qat63
 3+UXSHQLCYMzUXLUub/vxLbn8src3gR1gkC6optcLQ875XPraFC354vYAvlgPCxwdrLMJH
 EA1/1L5Oq4W8wy+pPGnaywROHSHiFi0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766530676;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UPCyItE7te9obeQYOhIGjgKDpXQH9AkkD5hJHqbolmc=;
 b=itH+55+R0BN1ZB29Pm/6XLKyLeYtADsI2WwvvaCix5iHUU0FwdlkwBGeA77j/phDNrWqmA
 DVuz6REZzdE2jgBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 71DCA3EA63;
 Tue, 23 Dec 2025 22:57:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 32uYDXMeS2lGVQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 23 Dec 2025 22:57:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Stefan
 Hajnoczi <stefanha@redhat.com>, Darren Kenny <darren.kenny@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>, Thomas Huth
 <thuth@redhat.com>, Alexander Bulekov <alxndr@bu.edu>, Qiuhao Li
 <Qiuhao.Li@outlook.com>, Laurent Vivier <lvivier@redhat.com>, Bandan Das
 <bsd@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Akihiko
 Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] tests/qtest: Do not use versioned pc-q35-5.0 machine
 anymore
In-Reply-To: <20251223211142.80417-1-philmd@linaro.org>
References: <20251223211142.80417-1-philmd@linaro.org>
Date: Tue, 23 Dec 2025 19:57:52 -0300
Message-ID: <874ipglsb3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: F3C42339EE
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,outlook.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[16];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_CC(0.00)[linaro.org,redhat.com,gmail.com,oracle.com,bu.edu,outlook.com,rsg.ci.i.u-tokyo.ac.jp];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 TAGGED_RCPT(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email, suse.de:mid, suse.de:dkim,
 suse.de:email, imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> As of QEMU v10.2.0, the v5.0.0 machines are not usable anymore.
>
> Use the latest x86 q35 machine instead, otherwise we get:
>
>   $ qemu-system-x86_64 -M pc-q35-5.0
>   qemu-system-x86_64: unsupported machine type: "pc-q35-5.0"
>   Use -machine help to list supported machines
>
> See commit a35f8577a07 ("include/hw: add macros for deprecation
> & removal of versioned machines") and f59ee044067 ("include/hw/boards:
> cope with dev/rc versions in deprecation checks") for explanation
> on automatically removed versioned machines.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> Since all builds are blocked, could we apply as build-fix on master?
> ---
>  tests/qtest/fuzz-e1000e-test.c | 2 +-
>  tests/qtest/lpc-ich9-test.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/qtest/fuzz-e1000e-test.c b/tests/qtest/fuzz-e1000e-tes=
t.c
> index 5052883fb6a..61f0553e9be 100644
> --- a/tests/qtest/fuzz-e1000e-test.c
> +++ b/tests/qtest/fuzz-e1000e-test.c
> @@ -17,7 +17,7 @@ static void test_lp1879531_eth_get_rss_ex_dst_addr(void)
>  {
>      QTestState *s;
>=20=20
> -    s =3D qtest_init("-nographic -monitor none -serial none -M pc-q35-5.=
0");
> +    s =3D qtest_init("-nographic -monitor none -serial none -M pc-q35");
>=20=20
>      qtest_outl(s, 0xcf8, 0x80001010);
>      qtest_outl(s, 0xcfc, 0xe1020000);
> diff --git a/tests/qtest/lpc-ich9-test.c b/tests/qtest/lpc-ich9-test.c
> index 8ac95b89f72..535099226ca 100644
> --- a/tests/qtest/lpc-ich9-test.c
> +++ b/tests/qtest/lpc-ich9-test.c
> @@ -15,7 +15,7 @@ static void test_lp1878642_pci_bus_get_irq_level_assert=
(void)
>  {
>      QTestState *s;
>=20=20
> -    s =3D qtest_init("-M pc-q35-5.0 "
> +    s =3D qtest_init("-M pc-q35 "
>                     "-nographic -monitor none -serial none");
>=20=20
>      qtest_outl(s, 0xcf8, 0x8000f840); /* PMBASE */

Reviewed-by: Fabiano Rosas <farosas@suse.de>


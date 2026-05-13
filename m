Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 102B5CD4F21
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 13:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN9uB-0002Us-GS; Wed, 13 May 2026 09:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wN9uA-0002UX-6l
 for qemu-devel@nongnu.org; Wed, 13 May 2026 09:45:42 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wN9u8-0000nC-9O
 for qemu-devel@nongnu.org; Wed, 13 May 2026 09:45:41 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BA8AC626B6;
 Wed, 13 May 2026 13:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778679937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=izHCzQlzILbAd64BbCKvVAxnG4dYCehLX/EJtGeatd4=;
 b=CptYtbhjagWvCE2q1K/aM2cOsbactGP6OU3dkryjUvL/42uy9Za9dY0yGBNaTLiCh0sZ4A
 ziJkbMP2Efa3SLzhgF/lGn4q5IWmY8beSrgZzCxwrzznJr8tGoYz+IEzX/A0hnAO0v2tei
 HDLcyUJvvYsY7ZZw/J9mw1Y33NYmSeU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778679937;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=izHCzQlzILbAd64BbCKvVAxnG4dYCehLX/EJtGeatd4=;
 b=ikyTfOpFRFaQXro3HDYZjBDcl/5PBRqogxTT2TV2g4v8B9gVprrJ47p+MVO5oW//fFLH+c
 yMb4eYbER04Cn4BQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CptYtbhj;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ikyTfOpF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778679937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=izHCzQlzILbAd64BbCKvVAxnG4dYCehLX/EJtGeatd4=;
 b=CptYtbhjagWvCE2q1K/aM2cOsbactGP6OU3dkryjUvL/42uy9Za9dY0yGBNaTLiCh0sZ4A
 ziJkbMP2Efa3SLzhgF/lGn4q5IWmY8beSrgZzCxwrzznJr8tGoYz+IEzX/A0hnAO0v2tei
 HDLcyUJvvYsY7ZZw/J9mw1Y33NYmSeU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778679937;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=izHCzQlzILbAd64BbCKvVAxnG4dYCehLX/EJtGeatd4=;
 b=ikyTfOpFRFaQXro3HDYZjBDcl/5PBRqogxTT2TV2g4v8B9gVprrJ47p+MVO5oW//fFLH+c
 yMb4eYbER04Cn4BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E9FB593A9;
 Wed, 13 May 2026 13:45:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JfvnF4CABGr1bgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 13 May 2026 13:45:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] tests: tag slow tests with 'slow' suite for easy filtering
In-Reply-To: <20260512065633.3542562-1-marcandre.lureau@redhat.com>
References: <20260512065633.3542562-1-marcandre.lureau@redhat.com>
Date: Wed, 13 May 2026 10:45:30 -0300
Message-ID: <87y0hnwhhh.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BA8AC626B6
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
> Add several RCU and thread-pool unit tests to the slow_tests dict,
> and tag all slow tests (both qtest and unit) with a 'slow' suite so
> they can be excluded or selected via meson test --suite/--no-suite.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/qtest/meson.build | 3 ++-
>  tests/unit/meson.build  | 9 ++++++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 728dde54b3f..2c5dcf2340f 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -493,6 +493,7 @@ foreach dir : target_dirs
>           protocol: 'tap',
>           timeout: slow_qtests.get(test, 60),
>           priority: slow_qtests.get(test, 60),
> -         suite: ['qtest', 'qtest-' + target_base])
> +         suite: ['qtest', 'qtest-' + target_base] +
> +                (slow_qtests.has_key(test) ? ['slow'] : []))

The change looks ok.=20

Acked-by: Fabiano Rosas <farosas@suse.de>

And I'll not rant about meson output.

qtest+qtest-s390x+slow - qemu:qtest-s390x/device-introspect-test
^1x   ^2x   ^            ^why ^3x   ^

>    endforeach
>  endforeach
> diff --git a/tests/unit/meson.build b/tests/unit/meson.build
> index 03d36748c73..ed1172a107c 100644
> --- a/tests/unit/meson.build
> +++ b/tests/unit/meson.build
> @@ -176,6 +176,12 @@ slow_tests =3D {
>    'test-crypto-tlscredsx509': 90,
>    'test-crypto-tlssession': 90,
>    'test-replication': 60,
> +  'rcutorture': 30,
> +  'test-rcu-list': 30,
> +  'test-rcu-simpleq': 30,
> +  'test-rcu-tailq': 30,
> +  'test-rcu-slist': 30,
> +  'test-thread-pool': 30,
>  }
>=20=20
>  foreach test_name, extra: tests
> @@ -197,5 +203,6 @@ foreach test_name, extra: tests
>         protocol: 'tap',
>         timeout: slow_tests.get(test_name, 30),
>         priority: slow_tests.get(test_name, 30),
> -       suite: ['unit'])
> +       suite: ['unit'] +
> +              (slow_tests.has_key(test_name) ? ['slow'] : []))
>  endforeach


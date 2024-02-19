Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36CFC48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 14:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc4Oz-0002mW-Sh; Mon, 19 Feb 2024 09:13:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1rc4Ox-0002ll-GP; Mon, 19 Feb 2024 09:13:47 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1rc4Ov-0008Nv-S1; Mon, 19 Feb 2024 09:13:47 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3A7FA21EEC;
 Mon, 19 Feb 2024 14:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708352021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2OdCcVlDVyB6Rl/n48Fllehgc6/oTTxOrnlT7G0ZP5s=;
 b=ELwSIhaVztP6GGd0OxYwRYesZ5tsgS0NIDlwN8X/vmum6kBmWqn9A0rfOUZytex38O5f+E
 Qj2AyA/JyAdtdRXPYnUk21MTSHoh/KK6hEbDQoah8QVvevVoJ5k6u9KApdH2Ze2yAJ5XFk
 KUQCxPd30t5V9jpm3ELdt7Ff0ozYjKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708352021;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2OdCcVlDVyB6Rl/n48Fllehgc6/oTTxOrnlT7G0ZP5s=;
 b=IuQKbZp5WQcDhrjDdcRN0Z1Fad9+Gc4iPUl+vEfzKruqHyOt3JAD8DYm/IkXsCaVeoTOcL
 otlUnk/6M9xxLqBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708352021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2OdCcVlDVyB6Rl/n48Fllehgc6/oTTxOrnlT7G0ZP5s=;
 b=ELwSIhaVztP6GGd0OxYwRYesZ5tsgS0NIDlwN8X/vmum6kBmWqn9A0rfOUZytex38O5f+E
 Qj2AyA/JyAdtdRXPYnUk21MTSHoh/KK6hEbDQoah8QVvevVoJ5k6u9KApdH2Ze2yAJ5XFk
 KUQCxPd30t5V9jpm3ELdt7Ff0ozYjKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708352021;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2OdCcVlDVyB6Rl/n48Fllehgc6/oTTxOrnlT7G0ZP5s=;
 b=IuQKbZp5WQcDhrjDdcRN0Z1Fad9+Gc4iPUl+vEfzKruqHyOt3JAD8DYm/IkXsCaVeoTOcL
 otlUnk/6M9xxLqBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B9DB6139D0;
 Mon, 19 Feb 2024 14:13:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id y+X9HxRi02VZXQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 19 Feb 2024 14:13:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: peterx@redhat.com, qemu-devel@nongnu.org, =?utf-8?Q?Daniel_P_=2E_Berra?=
 =?utf-8?Q?ng=C3=A9?=
 <berrange@redhat.com>, Sebastian Ott <sebott@redhat.com>, Eric Auger
 <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>
Subject: Re: [PATCH v2 1/3] tests/migration-test: Stick with gicv3 in
 aarch64 test
In-Reply-To: <CAFEAcA-AVjn5JdG+6eBd69o5BiJjmA1G6i4F2wVPSmRSw-X=Yg@mail.gmail.com>
References: <20240207005403.242235-1-peterx@redhat.com>
 <20240207005403.242235-2-peterx@redhat.com>
 <13862227-d782-46fe-b10f-94587c74745e@redhat.com>
 <CAFEAcA-AVjn5JdG+6eBd69o5BiJjmA1G6i4F2wVPSmRSw-X=Yg@mail.gmail.com>
Date: Mon, 19 Feb 2024 11:13:38 -0300
Message-ID: <87o7cch78t.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ELwSIhaV;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IuQKbZp5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: 3A7FA21EEC
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 19 Feb 2024 at 11:54, Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 07/02/2024 01.54, peterx@redhat.com wrote:
>> > From: Peter Xu <peterx@redhat.com>
>> >
>> > Recently we introduced cross-binary migration test.  It's always wanted
>> > that migration-test uses stable guest ABI for both QEMU binaries in th=
is
>> > case, so that both QEMU binaries will be compatible on the migration
>> > stream with the cmdline specified.
>> >
>> > Switch to a static gic version "3" rather than using version "max", so=
 that
>> > GIC should be stable now across any future QEMU binaries for migration=
-test.
>> >
>> > Here the version can actually be anything as long as the ABI is stable=
.  We
>> > choose "3" because it's the majority of what we already use in QEMU wh=
ile
>> > still new enough: "git grep gic-version=3D3" shows 6 hit, while versio=
n 4 has
>> > no direct user yet besides "max".
>> >
>> > Note that even with this change, aarch64 won't be able to work yet with
>> > migration cross binary test, but then the only missing piece will be t=
he
>> > stable CPU model.
>> >
>> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> >   tests/qtest/migration-test.c | 2 +-
>> >   1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test=
.c
>> > index 7675519cfa..8a5bb1752e 100644
>> > --- a/tests/qtest/migration-test.c
>> > +++ b/tests/qtest/migration-test.c
>> > @@ -819,7 +819,7 @@ static int test_migrate_start(QTestState **from, Q=
TestState **to,
>> >       } else if (strcmp(arch, "aarch64") =3D=3D 0) {
>> >           memory_size =3D "150M";
>> >           machine_alias =3D "virt";
>> > -        machine_opts =3D "gic-version=3Dmax";
>> > +        machine_opts =3D "gic-version=3D3";
>> >           arch_opts =3D g_strdup_printf("-cpu max -kernel %s", bootpat=
h);
>> >           start_address =3D ARM_TEST_MEM_START;
>> >           end_address =3D ARM_TEST_MEM_END;
>>
>> Looks like the migration test now fails on aarch64 when "configure" has =
been
>> run with "--without-default-devices", since that disables the gicv3 in t=
he
>> binary ... is there a way to check whether the gicv3 is available, and u=
se
>> "=3Dmax" instead if it is not?

How about adding aarch64 to the set of targets on the without-defaults
CI job?

>
> A QEMU for AArch64 with no GICv3 is of very little practical use,
> so I'm not sure it makes sense to allow users to build one like that.
> (I'm also a little surprised that it worked with 'max', because
> without a GICv3 it would try to fall back to GICv2, and if we're
> going to allow users to compile-time disable one of the GICs then
> we should definitely allow them to choose to not build GICv2.)
>
> I think I would go for disabling the migration test entirely if
> the build doesn't include the GICv3.

Makes sense. I've got my hands full right now, but I'll work on it later
this week along with your other suggestion to only test TCG.

Thanks



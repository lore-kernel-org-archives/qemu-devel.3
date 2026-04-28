Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E3BFF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 18:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHnRH-0002u6-Ai; Tue, 28 Apr 2026 14:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wHnRF-0002tu-RT
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 14:45:41 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wHnRE-00018j-3F
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 14:45:41 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6C8DD6A85A;
 Tue, 28 Apr 2026 18:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777401938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5zJ+h1PabFnQzwZCnBl3fcJ+XBOhUCoQp8gmrDScVAg=;
 b=iXXR3F/kEhW8kB1W3cH1pNe7WzgnOu+d89adX0moF8CDOJ9KlEfjTS4Jnq2/JBPyvXfK/R
 s7hI1Ss8kkyD73R/88oo8+TK1WDF1YAdQoIIJrfjEkBYHrtUgNm3hGsvMk10qJVVN0uDVu
 jVFRrMGzklM2dtaIled3r+OIgOLsmH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777401938;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5zJ+h1PabFnQzwZCnBl3fcJ+XBOhUCoQp8gmrDScVAg=;
 b=3s7YEiId2vnk5KJQ4F714SjIRkUcR0ubDuz04yXulqImbCMDq24rbz72qtEZYuX55PcRr7
 sVTgdN4meO1XFgAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777401938; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5zJ+h1PabFnQzwZCnBl3fcJ+XBOhUCoQp8gmrDScVAg=;
 b=iXXR3F/kEhW8kB1W3cH1pNe7WzgnOu+d89adX0moF8CDOJ9KlEfjTS4Jnq2/JBPyvXfK/R
 s7hI1Ss8kkyD73R/88oo8+TK1WDF1YAdQoIIJrfjEkBYHrtUgNm3hGsvMk10qJVVN0uDVu
 jVFRrMGzklM2dtaIled3r+OIgOLsmH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777401938;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5zJ+h1PabFnQzwZCnBl3fcJ+XBOhUCoQp8gmrDScVAg=;
 b=3s7YEiId2vnk5KJQ4F714SjIRkUcR0ubDuz04yXulqImbCMDq24rbz72qtEZYuX55PcRr7
 sVTgdN4meO1XFgAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09096593B0;
 Tue, 28 Apr 2026 18:45:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5Hx4MlEA8WmPKgAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 28 Apr 2026 18:45:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Stefan
 Hajnoczi <stefanha@redhat.com>, Tyrone Ting <kfting@nuvoton.com>, Hao Wu
 <wuhaotsh@google.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v1] tests/qtest: Avoid timers from default devices
In-Reply-To: <CAJSP0QXAJvSbgjxfL2eOubzNa1i3Xqc2B_rykaXzYfi9d7FPJg@mail.gmail.com>
References: <20260428160120.12130-1-farosas@suse.de>
 <CAJSP0QXAJvSbgjxfL2eOubzNa1i3Xqc2B_rykaXzYfi9d7FPJg@mail.gmail.com>
Date: Tue, 28 Apr 2026 15:45:31 -0300
Message-ID: <878qa6j54k.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 ARC_NA(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[8]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, linaro.org:email,
 suse.de:mid, suse.de:email]
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

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Tue, Apr 28, 2026 at 12:04=E2=80=AFPM Fabiano Rosas <farosas@suse.de> =
wrote:
>>
>> Having default devices enabled while testing timers leads to
>> non-deterministic behavior on the usage of the QTest
>> qtest_clock_step_next() command as the implicit devices can have
>> timers of their own that may have a deadline more recent than the
>> tested device.
>>
>> In the particular case of npcm7xx-timer-test, having SLIRP enabled in
>> the QEMU binary may cause the net_slirp_timer to shadow the clock
>> advance that was expected to trigger the NPCM7xx timer:
>>
>> npcm7xx_timer-test.c:475:test_periodic_interrupt:
>>   assertion failed (tim_read(td, TISR) =3D=3D tim_timer_bit(td)): (0x000=
00000 =3D=3D 0x00000010)
>> npcm7xx_timer-test.c:476:test_periodic_interrupt:
>> 'qtest_get_irq(global_qtest, tim_timer_irq(td))' should be TRUE
>>
>> Add the -nodefaults command line option to all tests that invoke
>> qtest_clock_step_next.
>>
>> CC: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  tests/qtest/npcm7xx_timer-test.c | 2 +-
>>  tests/qtest/pflash-cfi02-test.c  | 4 ++--
>>  tests/qtest/rtc-test.c           | 2 +-
>>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> Hi Fabiano,
> Thank you for the patch! I'm not sure this is a long-term fix since
> any code in QEMU could use timers (monitor, io channels, etc)?
>

Good point, if we go this way I'll add more words to the commit message
to make that pitfall clear.

@Alex, I was even under the impression that the issues with slirp timers
getting in the way of clock_step were entirely fixed by your changes
from:
https://lore.kernel.org/r/20250210161451.3273284-1-alex.bennee@linaro.org

Was that the intention at the time? Should we consider a timer test that
expects it to fire right after advancing the clock a mistake in the
test?

> Whether it is a full fix or not, it's definitely an improvement:
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>



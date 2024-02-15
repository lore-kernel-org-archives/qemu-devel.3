Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C85C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 13:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rabjb-0001Qp-U4; Thu, 15 Feb 2024 08:25:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1rabjZ-0001QI-PX; Thu, 15 Feb 2024 08:25:01 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1rabjX-0003zP-LL; Thu, 15 Feb 2024 08:25:01 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1D9B01F8A6;
 Thu, 15 Feb 2024 13:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708003496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=754ylKOy9LqrfRzkjNwD2BUHi8CIJ5iSOcp341b24C4=;
 b=JOwdmDjY8JH5NKGyhEX6HSw2eO1O1MY6Wu8eHb5XRJ+yfyTigfbwpgXfFbcTST7epDQZFr
 Lv7nKLrEEy3vECYboR3saSINjGOVCVGSKJ8HMIUMNEez4BVOhN7Sp4BXA1QkiTS9oZ+ShR
 b7dEVQNME+/Rrif1g5dE8AKk2ahLRjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708003496;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=754ylKOy9LqrfRzkjNwD2BUHi8CIJ5iSOcp341b24C4=;
 b=K48lE6eU/tIJ7pV58a3U9vY+I2x39RCNWRREPvu8pPW7l9RZ7bkPKOTo1vf3bsLYRTZkus
 7clfh8WoxrQpS5BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708003496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=754ylKOy9LqrfRzkjNwD2BUHi8CIJ5iSOcp341b24C4=;
 b=JOwdmDjY8JH5NKGyhEX6HSw2eO1O1MY6Wu8eHb5XRJ+yfyTigfbwpgXfFbcTST7epDQZFr
 Lv7nKLrEEy3vECYboR3saSINjGOVCVGSKJ8HMIUMNEez4BVOhN7Sp4BXA1QkiTS9oZ+ShR
 b7dEVQNME+/Rrif1g5dE8AKk2ahLRjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708003496;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=754ylKOy9LqrfRzkjNwD2BUHi8CIJ5iSOcp341b24C4=;
 b=K48lE6eU/tIJ7pV58a3U9vY+I2x39RCNWRREPvu8pPW7l9RZ7bkPKOTo1vf3bsLYRTZkus
 7clfh8WoxrQpS5BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A57013A53;
 Thu, 15 Feb 2024 13:24:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wpuEGKcQzmVKVQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 15 Feb 2024 13:24:55 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Michael Tokarev <mjt@tls.msk.ru>, peterx@redhat.com, Peter Maydell
 <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable <qemu-stable@nongnu.org>
Subject: Re: [PULL 26/34] migration/multifd: Join the TLS thread
In-Reply-To: <d3c4506f-0dbd-4171-944d-0aeb040153ad@tls.msk.ru>
References: <20240208030528.368214-1-peterx@redhat.com>
 <20240208030528.368214-27-peterx@redhat.com>
 <d60ddc11-b4b4-4fee-b9c0-08bea513f8d3@tls.msk.ru>
 <0e5720f4-63c1-4f71-ab6b-26c07614ba33@tls.msk.ru> <8734tvqipk.fsf@suse.de>
 <d3c4506f-0dbd-4171-944d-0aeb040153ad@tls.msk.ru>
Date: Thu, 15 Feb 2024 10:24:53 -0300
Message-ID: <878r3lsvve.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Michael Tokarev <mjt@tls.msk.ru> writes:

> 14.02.2024 16:27, Fabiano Rosas :
>> Michael Tokarev <mjt@tls.msk.ru> writes:
> ..>>> This change, which is suggested for -stable, while simple by its ow=
n, seems
>>>> to depend on the previous changes in this series, which are not for -s=
table.
>>>> In particular, whole "Finally recycle all the threads" loop in multifd=
_send_terminate_threads()
>>>> (to which the join is being added by this change) is moved from elsewh=
ere by
>>>> 12808db3b8 "migration/multifd: Cleanup multifd_save_cleanup()" (patch =
24 in
>>>> this same series).
>>>>
>>> We can probably add the missing join right into the previous location o=
f this
>>> loop (before 12808db3b8).=C2=A0 I did this in the attached variant for =
8.2, is
>>> this correct?
>
> I forgot to attach the patch.  It just moves the join from multifd_send_t=
erminate_threads()
> back to multifd_save_cleanup.  Attached now.
>
>> It should work. This was originally developed without the rest of the
>> changes on this PR.
>>=20
>>> And this does not pass even the basic tests, so it's not that simple :)
>>=20
>> Do you have a log of what failed?
>
> Re-running it again...  I haven't even tried to push it somewhere for CI =
to run,
> I run local `ninja test', which painted some migration tests in red.  Her=
e:
>
> 202/844 qemu:qtest+qtest-aarch64 / qtest-aarch64/migration-test   ERROR  =
 70.26s   killed by signal 6 SIGABRT
> 330/844 qemu:qtest+qtest-i386 / qtest-i386/migration-test         ERROR  =
 85.33s   killed by signal 6 SIGABRT
> 454/844 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test     ERROR  =
101.02s   killed by signal 6 SIGABRT
>
> Unfortunately I don't see anything interesting in the log:
>
> # starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-463614.=
sock -qtest-log /dev/null -chardev socket,path=3D/tmp/qtest-463614.qmp,id=
=3Dchar0=20
> -mon chardev=3Dchar0,mode=3Dcontrol -display none -audio none -accel kvm =
-accel tcg -machine pc-q35-8.2, -name target,debug-threads=3Don -m 150M -se=
rial=20
> file:/tmp/migration-test-SPJTI2/dest_serial -incoming defer -drive if=3Dn=
one,id=3Dd0,file=3D/tmp/migration-test-SPJTI2/bootsect,format=3Draw -device=
=20
> ide-hd,drive=3Dd0,secs=3D1,cyls=3D1,heads=3D1    2>/dev/null -accel qtest
> ----------------------------------- stderr ------------------------------=
-----
> ../../build/qemu/8.2/tests/qtest/libqtest.c:204: kill_qemu() detected QEM=
U death from signal 6 (Aborted)
> (test program exited with status code -6)
>
> Without the attached patch it works.

Ah ok, this is hitting the bug fixed by patch 31. Let's leave patches
26, 27 and 31 out of stable, it would be too risky to backport.



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31B7EED615
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 15:38:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1solsv-0007VC-85; Thu, 12 Sep 2024 11:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1solst-0007SF-1u
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 11:37:27 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1solsq-0007dz-Q3
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 11:37:26 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5636821AE0;
 Thu, 12 Sep 2024 15:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726155442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zWUrJxznuiXOi9FpJerPdpJTeI1LiXl8lRRLbbSASkY=;
 b=f4sqRrh/V4arhaDLpJnnkgr7pWdlt4lZ/Y32TIDqZ4z23bIBNTfZ9Oy4AdTS+gksWJ1yYE
 it2KJad+9CeEIqaUlN1UeOk8FyPIqmEecr25FLCYTejq4Vj/I/bqczQwfZYzEvJ7G9Yl+4
 RhcbTnLcOraEev8XPxFTyE4uohknsSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726155442;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zWUrJxznuiXOi9FpJerPdpJTeI1LiXl8lRRLbbSASkY=;
 b=IM/UO8jVPrkAlLWeaqw/EwmDiOwfWOjcJsRH/FOjtB9TKN0czAtJOmSmlhf9ZG69NeZk73
 8ubd82+rji3+6LCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726155442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zWUrJxznuiXOi9FpJerPdpJTeI1LiXl8lRRLbbSASkY=;
 b=f4sqRrh/V4arhaDLpJnnkgr7pWdlt4lZ/Y32TIDqZ4z23bIBNTfZ9Oy4AdTS+gksWJ1yYE
 it2KJad+9CeEIqaUlN1UeOk8FyPIqmEecr25FLCYTejq4Vj/I/bqczQwfZYzEvJ7G9Yl+4
 RhcbTnLcOraEev8XPxFTyE4uohknsSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726155442;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zWUrJxznuiXOi9FpJerPdpJTeI1LiXl8lRRLbbSASkY=;
 b=IM/UO8jVPrkAlLWeaqw/EwmDiOwfWOjcJsRH/FOjtB9TKN0czAtJOmSmlhf9ZG69NeZk73
 8ubd82+rji3+6LCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1A3513A73;
 Thu, 12 Sep 2024 15:37:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ssK2JbEK42bzGgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 12 Sep 2024 15:37:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Hyman Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, David
 Hildenbrand <david@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC 10/10] tests/migration-tests: Add test case for
 responsive CPU throttle
In-Reply-To: <ZuMEF99PF0q0U9G-@x1n>
References: <CAFEAcA99=bn4x_BjgsAsrVitXNxOUSNviz=TGezJEB+=Zj603w@mail.gmail.com>
 <Zt8H6pC2yQ2DD7DV@x1n> <87frq8lcgp.fsf@suse.de> <ZuC4pYT-atQwWePv@x1n>
 <87seu7qhao.fsf@suse.de> <ZuG-SijLg8Q27boE@x1n> <87ed5qq8e2.fsf@suse.de>
 <ZuH_pvnTCumKuXTh@x1n> <87bk0trifq.fsf@suse.de>
 <CAFEAcA9YkZiSSOAj0zH2OwF9AcziJT-zpnNVQn8BXizhSXHVOA@mail.gmail.com>
 <ZuMEF99PF0q0U9G-@x1n>
Date: Thu, 12 Sep 2024 12:37:18 -0300
Message-ID: <877cbghoi9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_SEVEN(0.00)[9];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[]
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

Peter Xu <peterx@redhat.com> writes:

> On Thu, Sep 12, 2024 at 09:13:16AM +0100, Peter Maydell wrote:
>> On Wed, 11 Sept 2024 at 22:26, Fabiano Rosas <farosas@suse.de> wrote:
>> > I don't think we're discussing total CI time at this point, so the math
>> > doesn't really add up. We're not looking into making the CI finish
>> > faster. We're looking into making migration-test finish faster. That
>> > would reduce timeouts in CI, speed-up make check and reduce the chance
>> > of random race conditions* affecting other people/staging runs.
>>=20
>> Right. The reason migration-test appears on my radar is because
>> it is very frequently the thing that shows up as "this sometimes
>> just fails or just times out and if you hit retry it goes away
>> again". That might not be migration-test's fault specifically,
>> because those retries tend to be certain CI configs (s390,
>> the i686-tci one), and I have some theories about what might be
>> causing it (e.g. build system runs 4 migration-tests in parallel,
>> which means 8 QEMU processes which is too many for the number
>> of host CPUs). But right now I look at CI job failures and my reaction
>> is "oh, it's the migration-test failing yet again" :-(
>>=20
>> For some examples from this week:
>>=20
>> https://gitlab.com/qemu-project/qemu/-/jobs/7802183144
>> https://gitlab.com/qemu-project/qemu/-/jobs/7799842373  <--------[1]
>> https://gitlab.com/qemu-project/qemu/-/jobs/7786579152  <--------[2]
>> https://gitlab.com/qemu-project/qemu/-/jobs/7786579155
>
> Ah right, the TIMEOUT is unfortunate, especially if tests can be run in
> parallel.  It indeed sounds like no good way to finally solve.. I don't
> also see how speeding up / reducing tests in migration test would help, as
> that's (from some degree..) is the same as tuning the timeout value bigge=
r.
> When the tests are less it'll fit into 480s window, but maybe it's too
> quick now we wonder whether we should shrink it to e.g. 90s, but then it
> can timeout again when on a busy host with less capability of concurrency.
>
> But indeed there're two ERRORs ([1,2] above)..  I collected some more info
> here before the log expires:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D8<=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> *** /i386/migration/multifd/tcp/plain/cancel, qtest-i386 on s390 host
>
> https://gitlab.com/qemu-project/qemu/-/jobs/7799842373
>
> 101/953 qemu:qtest+qtest-i386 / qtest-i386/migration-test                =
         ERROR          144.32s   killed by signal 6 SIGABRT
>>>> QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-storage-daemo=
n G_TEST_DBUS_DAEMON=3D/home/gitlab-runner/builds/zEr9wY_L/0/qemu-project/q=
emu/tests/dbus-vmstate-daemon.sh PYTHON=3D/home/gitlab-runner/builds/zEr9wY=
_L/0/qemu-project/qemu/build/pyvenv/bin/python3 QTEST_QEMU_IMG=3D./qemu-img=
 MALLOC_PERTURB_=3D144 QTEST_QEMU_BINARY=3D./qemu-system-i386 /home/gitlab-=
runner/builds/zEr9wY_L/0/qemu-project/qemu/build/tests/qtest/migration-test=
 --tap -k
> =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95
> stderr:
> warning: fd: migration to a file is deprecated. Use file: instead.
> warning: fd: migration to a file is deprecated. Use file: instead.
> ../tests/qtest/libqtest.c:205: kill_qemu() detected QEMU death from signa=
l 11 (Segmentation fault) (core dumped)
> (test program exited with status code -6)
> TAP parsing error: Too few tests run (expected 53, got 39)
> =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95
>
> # Start of plain tests
> # Running /i386/migration/multifd/tcp/plain/cancel
> # Using machine type: pc-i440fx-9.2
> # starting QEMU: exec ./qemu-system-i386 -qtest unix:/tmp/qtest-3273509.s=
ock -qtest-log /dev/null -chardev socket,path=3D/tmp/qtest-3273509.qmp,id=
=3Dchar0 -mon chardev=3Dchar0,mode=3Dcontrol -display none -audio none -acc=
el kvm -accel tcg -machine pc-i440fx-9.2, -name source,debug-threads=3Don -=
m 150M -serial file:/tmp/migration-test-4112T2/src_serial -drive if=3Dnone,=
id=3Dd0,file=3D/tmp/migration-test-4112T2/bootsect,format=3Draw -device ide=
-hd,drive=3Dd0,secs=3D1,cyls=3D1,heads=3D1    2>/dev/null -accel qtest
> # starting QEMU: exec ./qemu-system-i386 -qtest unix:/tmp/qtest-3273509.s=
ock -qtest-log /dev/null -chardev socket,path=3D/tmp/qtest-3273509.qmp,id=
=3Dchar0 -mon chardev=3Dchar0,mode=3Dcontrol -display none -audio none -acc=
el kvm -accel tcg -machine pc-i440fx-9.2, -name target,debug-threads=3Don -=
m 150M -serial file:/tmp/migration-test-4112T2/dest_serial -incoming defer =
-drive if=3Dnone,id=3Dd0,file=3D/tmp/migration-test-4112T2/bootsect,format=
=3Draw -device ide-hd,drive=3Dd0,secs=3D1,cyls=3D1,heads=3D1    2>/dev/null=
 -accel qtest
> ----------------------------------- stderr ------------------------------=
-----
> warning: fd: migration to a file is deprecated. Use file: instead.
> warning: fd: migration to a file is deprecated. Use file: instead.
> ../tests/qtest/libqtest.c:205: kill_qemu() detected QEMU death from signa=
l 11 (Segmentation fault) (core dumped)
>
> *** /ppc64/migration/multifd/tcp/plain/cancel, qtest-ppc64 on i686 host
>
> https://gitlab.com/qemu-project/qemu/-/jobs/7786579152
>
> 174/315 qemu:qtest+qtest-ppc64 / qtest-ppc64/migration-test              =
         ERROR          381.00s   killed by signal 6 SIGABRT
>>>> PYTHON=3D/builds/qemu-project/qemu/build/pyvenv/bin/python3 QTEST_QEMU=
_IMG=3D./qemu-img G_TEST_DBUS_DAEMON=3D/builds/qemu-project/qemu/tests/dbus=
-vmstate-daemon.sh QTEST_QEMU_BINARY=3D./qemu-system-ppc64 MALLOC_PERTURB_=
=3D178 QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-storage-dae=
mon /builds/qemu-project/qemu/build/tests/qtest/migration-test --tap -k
> =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95
> stderr:
> qemu-system-ppc64: Cannot read from TLS channel: The TLS connection was n=
on-properly terminated.
> warning: fd: migration to a file is deprecated. Use file: instead.
> warning: fd: migration to a file is deprecated. Use file: instead.
> ../tests/qtest/libqtest.c:205: kill_qemu() detected QEMU death from signa=
l 11 (Segmentation fault) (core dumped)
> (test program exited with status code -6)
> TAP parsing error: Too few tests run (expected 61, got 47)
> =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95
>
> # Start of plain tests
> # Running /ppc64/migration/multifd/tcp/plain/cancel
> # Using machine type: pseries-9.2
> # starting QEMU: exec ./qemu-system-ppc64 -qtest unix:/tmp/qtest-40766.so=
ck -qtest-log /dev/null -chardev socket,path=3D/tmp/qtest-40766.qmp,id=3Dch=
ar0 -mon chardev=3Dchar0,mode=3Dcontrol -display none -audio none -accel kv=
m -accel tcg -machine pseries-9.2,vsmt=3D8 -name source,debug-threads=3Don =
-m 256M -serial file:/tmp/migration-test-H0Z1T2/src_serial -nodefaults -mac=
hine cap-cfpc=3Dbroken,cap-sbbc=3Dbroken,cap-ibs=3Dbroken,cap-ccf-assist=3D=
off, -bios /tmp/migration-test-H0Z1T2/bootsect    2>/dev/null -accel qtest
> # starting QEMU: exec ./qemu-system-ppc64 -qtest unix:/tmp/qtest-40766.so=
ck -qtest-log /dev/null -chardev socket,path=3D/tmp/qtest-40766.qmp,id=3Dch=
ar0 -mon chardev=3Dchar0,mode=3Dcontrol -display none -audio none -accel kv=
m -accel tcg -machine pseries-9.2,vsmt=3D8 -name target,debug-threads=3Don =
-m 256M -serial file:/tmp/migration-test-H0Z1T2/dest_serial -incoming defer=
 -nodefaults -machine cap-cfpc=3Dbroken,cap-sbbc=3Dbroken,cap-ibs=3Dbroken,=
cap-ccf-assist=3Doff, -bios /tmp/migration-test-H0Z1T2/bootsect    2>/dev/n=
ull -accel qtest
> ----------------------------------- stderr ------------------------------=
-----
> qemu-system-ppc64: Cannot read from TLS channel: The TLS connection was n=
on-properly terminated.
> warning: fd: migration to a file is deprecated. Use file: instead.
> warning: fd: migration to a file is deprecated. Use file: instead.
> ../tests/qtest/libqtest.c:205: kill_qemu() detected QEMU death from signa=
l 11 (Segmentation fault) (core dumped)
>
> (test program exited with status code -6)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D8<=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> So.. it's the same test (multifd/tcp/plain/cancel) that is failing on
> different host / arch being tested.  What is more weird is the two failur=
es
> are different, the 2nd failure throw out a TLS error even though the test
> doesn't yet have tls involved.

I think that's just a parallel test being cancelled prematurely, either
due to the crash or due to the timeout.

>
> Fabiano, is this the issue you're looking at?

Yes. I can reproduce locally by running 2 processes in parallel: 1 loop
with make -j$(nproc) check and another loop with tcp/plain/cancel. It
takes ~1h to hit. I've seen crashes with ppc64, s390 and
aarch64.

> Peter, do you think it'll be helpful if we temporarily mark this test as
> "slow" too so it's not run in CI (so we still run it ourselves when prepa=
re
> migration PR, with the hope that it can reproduce)?
>
> Thanks,


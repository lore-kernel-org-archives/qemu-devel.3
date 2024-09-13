Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02A4FC616C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 17:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spASd-0001RR-Bq; Fri, 13 Sep 2024 13:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1spASc-0001Qx-6m
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 13:51:58 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1spASZ-0000FT-6B
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 13:51:57 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2F237219B2;
 Fri, 13 Sep 2024 17:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726249913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UzUZ2gvrtx4RE9E6V6pC+3eYzHPbYEjo+SWA0tbRTWk=;
 b=g6c5uzB7ZmwLEWluYwpvUyndX9l4Rq9pOS78PP0wzUq1fnbB+8PNG7eiUeHLnaCDg+s+kc
 27h8nizl0V5GzTELpLkQNKEwHMNK5oIflx4STvB0I8gRSNemCeA0A1T0si8Cpp5pHFJhQs
 Qu6pyTDbimM9wARigK/vXBc/k9+PwfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726249913;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UzUZ2gvrtx4RE9E6V6pC+3eYzHPbYEjo+SWA0tbRTWk=;
 b=WOUQVsVaftz0um8gVqxKgyu2Hk8d8onsTlmStV/eEd15nIL1xPLA0/TS3E1XvwpR28XOQ2
 4dSpAKyqCkV9heCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726249913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UzUZ2gvrtx4RE9E6V6pC+3eYzHPbYEjo+SWA0tbRTWk=;
 b=g6c5uzB7ZmwLEWluYwpvUyndX9l4Rq9pOS78PP0wzUq1fnbB+8PNG7eiUeHLnaCDg+s+kc
 27h8nizl0V5GzTELpLkQNKEwHMNK5oIflx4STvB0I8gRSNemCeA0A1T0si8Cpp5pHFJhQs
 Qu6pyTDbimM9wARigK/vXBc/k9+PwfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726249913;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UzUZ2gvrtx4RE9E6V6pC+3eYzHPbYEjo+SWA0tbRTWk=;
 b=WOUQVsVaftz0um8gVqxKgyu2Hk8d8onsTlmStV/eEd15nIL1xPLA0/TS3E1XvwpR28XOQ2
 4dSpAKyqCkV9heCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AACFA13A72;
 Fri, 13 Sep 2024 17:51:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gkpMHLh75GZNeAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 13 Sep 2024 17:51:52 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Hyman Huang
 <yong.huang@smartx.com>, qemu-devel@nongnu.org, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, David
 Hildenbrand <david@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC 10/10] tests/migration-tests: Add test case for
 responsive CPU throttle
In-Reply-To: <ZuRcgmt2DRPgPdg4@x1n>
References: <87ed5qq8e2.fsf@suse.de> <ZuH_pvnTCumKuXTh@x1n>
 <87bk0trifq.fsf@suse.de>
 <CAFEAcA9YkZiSSOAj0zH2OwF9AcziJT-zpnNVQn8BXizhSXHVOA@mail.gmail.com>
 <ZuMEF99PF0q0U9G-@x1n> <877cbghoi9.fsf@suse.de> <87ttek1o3j.fsf@suse.de>
 <ZuRTgbDhEJ7c-dcE@x1n> <87ikuz1tgz.fsf@suse.de> <87frq31t2j.fsf@suse.de>
 <ZuRcgmt2DRPgPdg4@x1n>
Date: Fri, 13 Sep 2024 14:51:49 -0300
Message-ID: <87cyl71lxm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[9]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
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

> On Fri, Sep 13, 2024 at 12:17:40PM -0300, Fabiano Rosas wrote:
>> Fabiano Rosas <farosas@suse.de> writes:
>>=20
>> > Peter Xu <peterx@redhat.com> writes:
>> >
>> >> On Thu, Sep 12, 2024 at 07:52:48PM -0300, Fabiano Rosas wrote:
>> >>> Fabiano Rosas <farosas@suse.de> writes:
>> >>>=20
>> >>> > Peter Xu <peterx@redhat.com> writes:
>> >>> >
>> >>> >> On Thu, Sep 12, 2024 at 09:13:16AM +0100, Peter Maydell wrote:
>> >>> >>> On Wed, 11 Sept 2024 at 22:26, Fabiano Rosas <farosas@suse.de> w=
rote:
>> >>> >>> > I don't think we're discussing total CI time at this point, so=
 the math
>> >>> >>> > doesn't really add up. We're not looking into making the CI fi=
nish
>> >>> >>> > faster. We're looking into making migration-test finish faster=
. That
>> >>> >>> > would reduce timeouts in CI, speed-up make check and reduce th=
e chance
>> >>> >>> > of random race conditions* affecting other people/staging runs.
>> >>> >>>=20
>> >>> >>> Right. The reason migration-test appears on my radar is because
>> >>> >>> it is very frequently the thing that shows up as "this sometimes
>> >>> >>> just fails or just times out and if you hit retry it goes away
>> >>> >>> again". That might not be migration-test's fault specifically,
>> >>> >>> because those retries tend to be certain CI configs (s390,
>> >>> >>> the i686-tci one), and I have some theories about what might be
>> >>> >>> causing it (e.g. build system runs 4 migration-tests in parallel,
>> >>> >>> which means 8 QEMU processes which is too many for the number
>> >>> >>> of host CPUs). But right now I look at CI job failures and my re=
action
>> >>> >>> is "oh, it's the migration-test failing yet again" :-(
>> >>> >>>=20
>> >>> >>> For some examples from this week:
>> >>> >>>=20
>> >>> >>> https://gitlab.com/qemu-project/qemu/-/jobs/7802183144
>> >>> >>> https://gitlab.com/qemu-project/qemu/-/jobs/7799842373  <-------=
-[1]
>> >>> >>> https://gitlab.com/qemu-project/qemu/-/jobs/7786579152  <-------=
-[2]
>> >>> >>> https://gitlab.com/qemu-project/qemu/-/jobs/7786579155
>> >>> >>
>> >>> >> Ah right, the TIMEOUT is unfortunate, especially if tests can be =
run in
>> >>> >> parallel.  It indeed sounds like no good way to finally solve.. I=
 don't
>> >>> >> also see how speeding up / reducing tests in migration test would=
 help, as
>> >>> >> that's (from some degree..) is the same as tuning the timeout val=
ue bigger.
>> >>> >> When the tests are less it'll fit into 480s window, but maybe it'=
s too
>> >>> >> quick now we wonder whether we should shrink it to e.g. 90s, but =
then it
>> >>> >> can timeout again when on a busy host with less capability of con=
currency.
>> >>> >>
>> >>> >> But indeed there're two ERRORs ([1,2] above)..  I collected some =
more info
>> >>> >> here before the log expires:
>> >>> >>
>> >>> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D8<=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >>> >>
>> >>> >> *** /i386/migration/multifd/tcp/plain/cancel, qtest-i386 on s390 =
host
>> >>> >>
>> >>> >> https://gitlab.com/qemu-project/qemu/-/jobs/7799842373
>> >>> >>
>> >>> >> 101/953 qemu:qtest+qtest-i386 / qtest-i386/migration-test        =
                 ERROR          144.32s   killed by signal 6 SIGABRT
>> >>> >>>>> QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-stora=
ge-daemon G_TEST_DBUS_DAEMON=3D/home/gitlab-runner/builds/zEr9wY_L/0/qemu-p=
roject/qemu/tests/dbus-vmstate-daemon.sh PYTHON=3D/home/gitlab-runner/build=
s/zEr9wY_L/0/qemu-project/qemu/build/pyvenv/bin/python3 QTEST_QEMU_IMG=3D./=
qemu-img MALLOC_PERTURB_=3D144 QTEST_QEMU_BINARY=3D./qemu-system-i386 /home=
/gitlab-runner/builds/zEr9wY_L/0/qemu-project/qemu/build/tests/qtest/migrat=
ion-test --tap -k
>> >>> >> =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95
>> >>> >> stderr:
>> >>> >> warning: fd: migration to a file is deprecated. Use file: instead.
>> >>> >> warning: fd: migration to a file is deprecated. Use file: instead.
>> >>> >> ../tests/qtest/libqtest.c:205: kill_qemu() detected QEMU death fr=
om signal 11 (Segmentation fault) (core dumped)
>> >>> >> (test program exited with status code -6)
>> >>> >> TAP parsing error: Too few tests run (expected 53, got 39)
>> >>> >> =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95
>> >>> >>
>> >>> >> # Start of plain tests
>> >>> >> # Running /i386/migration/multifd/tcp/plain/cancel
>> >>> >> # Using machine type: pc-i440fx-9.2
>> >>> >> # starting QEMU: exec ./qemu-system-i386 -qtest unix:/tmp/qtest-3=
273509.sock -qtest-log /dev/null -chardev socket,path=3D/tmp/qtest-3273509.=
qmp,id=3Dchar0 -mon chardev=3Dchar0,mode=3Dcontrol -display none -audio non=
e -accel kvm -accel tcg -machine pc-i440fx-9.2, -name source,debug-threads=
=3Don -m 150M -serial file:/tmp/migration-test-4112T2/src_serial -drive if=
=3Dnone,id=3Dd0,file=3D/tmp/migration-test-4112T2/bootsect,format=3Draw -de=
vice ide-hd,drive=3Dd0,secs=3D1,cyls=3D1,heads=3D1    2>/dev/null -accel qt=
est
>> >>> >> # starting QEMU: exec ./qemu-system-i386 -qtest unix:/tmp/qtest-3=
273509.sock -qtest-log /dev/null -chardev socket,path=3D/tmp/qtest-3273509.=
qmp,id=3Dchar0 -mon chardev=3Dchar0,mode=3Dcontrol -display none -audio non=
e -accel kvm -accel tcg -machine pc-i440fx-9.2, -name target,debug-threads=
=3Don -m 150M -serial file:/tmp/migration-test-4112T2/dest_serial -incoming=
 defer -drive if=3Dnone,id=3Dd0,file=3D/tmp/migration-test-4112T2/bootsect,=
format=3Draw -device ide-hd,drive=3Dd0,secs=3D1,cyls=3D1,heads=3D1    2>/de=
v/null -accel qtest
>> >>> >> ----------------------------------- stderr ----------------------=
-------------
>> >>> >> warning: fd: migration to a file is deprecated. Use file: instead.
>> >>> >> warning: fd: migration to a file is deprecated. Use file: instead.
>> >>> >> ../tests/qtest/libqtest.c:205: kill_qemu() detected QEMU death fr=
om signal 11 (Segmentation fault) (core dumped)
>> >>> >>
>> >>> >> *** /ppc64/migration/multifd/tcp/plain/cancel, qtest-ppc64 on i68=
6 host
>> >>> >>
>> >>> >> https://gitlab.com/qemu-project/qemu/-/jobs/7786579152
>> >>> >>
>> >>> >> 174/315 qemu:qtest+qtest-ppc64 / qtest-ppc64/migration-test      =
                 ERROR          381.00s   killed by signal 6 SIGABRT
>> >>> >>>>> PYTHON=3D/builds/qemu-project/qemu/build/pyvenv/bin/python3 QT=
EST_QEMU_IMG=3D./qemu-img G_TEST_DBUS_DAEMON=3D/builds/qemu-project/qemu/te=
sts/dbus-vmstate-daemon.sh QTEST_QEMU_BINARY=3D./qemu-system-ppc64 MALLOC_P=
ERTURB_=3D178 QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-stor=
age-daemon /builds/qemu-project/qemu/build/tests/qtest/migration-test --tap=
 -k
>> >>> >> =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95
>> >>> >> stderr:
>> >>> >> qemu-system-ppc64: Cannot read from TLS channel: The TLS connecti=
on was non-properly terminated.
>> >>> >> warning: fd: migration to a file is deprecated. Use file: instead.
>> >>> >> warning: fd: migration to a file is deprecated. Use file: instead.
>> >>> >> ../tests/qtest/libqtest.c:205: kill_qemu() detected QEMU death fr=
om signal 11 (Segmentation fault) (core dumped)
>> >>> >> (test program exited with status code -6)
>> >>> >> TAP parsing error: Too few tests run (expected 61, got 47)
>> >>> >> =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95
>> >>> >>
>> >>> >> # Start of plain tests
>> >>> >> # Running /ppc64/migration/multifd/tcp/plain/cancel
>> >>> >> # Using machine type: pseries-9.2
>> >>> >> # starting QEMU: exec ./qemu-system-ppc64 -qtest unix:/tmp/qtest-=
40766.sock -qtest-log /dev/null -chardev socket,path=3D/tmp/qtest-40766.qmp=
,id=3Dchar0 -mon chardev=3Dchar0,mode=3Dcontrol -display none -audio none -=
accel kvm -accel tcg -machine pseries-9.2,vsmt=3D8 -name source,debug-threa=
ds=3Don -m 256M -serial file:/tmp/migration-test-H0Z1T2/src_serial -nodefau=
lts -machine cap-cfpc=3Dbroken,cap-sbbc=3Dbroken,cap-ibs=3Dbroken,cap-ccf-a=
ssist=3Doff, -bios /tmp/migration-test-H0Z1T2/bootsect    2>/dev/null -acce=
l qtest
>> >>> >> # starting QEMU: exec ./qemu-system-ppc64 -qtest unix:/tmp/qtest-=
40766.sock -qtest-log /dev/null -chardev socket,path=3D/tmp/qtest-40766.qmp=
,id=3Dchar0 -mon chardev=3Dchar0,mode=3Dcontrol -display none -audio none -=
accel kvm -accel tcg -machine pseries-9.2,vsmt=3D8 -name target,debug-threa=
ds=3Don -m 256M -serial file:/tmp/migration-test-H0Z1T2/dest_serial -incomi=
ng defer -nodefaults -machine cap-cfpc=3Dbroken,cap-sbbc=3Dbroken,cap-ibs=
=3Dbroken,cap-ccf-assist=3Doff, -bios /tmp/migration-test-H0Z1T2/bootsect  =
  2>/dev/null -accel qtest
>> >>> >> ----------------------------------- stderr ----------------------=
-------------
>> >>> >> qemu-system-ppc64: Cannot read from TLS channel: The TLS connecti=
on was non-properly terminated.
>> >>> >> warning: fd: migration to a file is deprecated. Use file: instead.
>> >>> >> warning: fd: migration to a file is deprecated. Use file: instead.
>> >>> >> ../tests/qtest/libqtest.c:205: kill_qemu() detected QEMU death fr=
om signal 11 (Segmentation fault) (core dumped)
>> >>> >>
>> >>> >> (test program exited with status code -6)
>> >>> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D8<=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >>> >>
>> >>> >> So.. it's the same test (multifd/tcp/plain/cancel) that is failin=
g on
>> >>> >> different host / arch being tested.  What is more weird is the tw=
o failures
>> >>> >> are different, the 2nd failure throw out a TLS error even though =
the test
>> >>> >> doesn't yet have tls involved.
>> >>> >
>> >>> > I think that's just a parallel test being cancelled prematurely, e=
ither
>> >>> > due to the crash or due to the timeout.
>> >>> >
>> >>> >>
>> >>> >> Fabiano, is this the issue you're looking at?
>> >>> >
>> >>> > Yes. I can reproduce locally by running 2 processes in parallel: 1=
 loop
>> >>> > with make -j$(nproc) check and another loop with tcp/plain/cancel.=
 It
>> >>> > takes ~1h to hit. I've seen crashes with ppc64, s390 and
>> >>> > aarch64.
>> >>> >
>> >>>=20
>> >>> Ok, the issue is that after commit 5ef7e26bdb ("migration/multifd: s=
olve
>> >>> zero page causing multiple page faults"), the multifd code started u=
sing
>> >>> the rb->receivedmap bitmap, which belongs to the ram code and is
>> >>> initialized and *freed* from the ram SaveVMHandlers.
>> >>>=20
>> >>> process_incoming_migration_co()        ...
>> >>>   qemu_loadvm_state()                  multifd_nocomp_recv()
>> >>>     qemu_loadvm_state_cleanup()          ramblock_recv_bitmap_set_of=
fset()
>> >>>       rb->receivedmap =3D NULL               set_bit_atomic(..., rb-=
>receivedmap)
>> >>>   ...
>> >>>   migration_incoming_state_destroy()
>> >>>     multifd_recv_cleanup()
>> >>>       multifd_recv_terminate_threads(NULL)
>> >>>=20
>> >>> Multifd threads are live until migration_incoming_state_destroy(), w=
hich
>> >>> is called some time later.
>> >>
>> >> Thanks for the debugging.  Hmm I would expect loadvm should wait unti=
l all
>> >> ram is received somehow..
>> >
>> > Looks like a similar issue as when we didn't have the multifd_send sync
>> > working correctly and ram code would run and do cleanup.
>>=20
>> Btw, this is hard to debug, but I bet what's happening is that the
>> ram_load code itself is exiting due to qemufile error. So there wouldn't
>> be a way to make it wait for multifd.
>
> One more thing is I remember one of the error is not the crash but some T=
LS
> disconnection error.  I wonder which one you can reproduce and why that T=
LS
> code can got kicked off in the multifd cancel test.  Perhaps the memory w=
as
> simply corrupted around, so bitmap ops can write to some other memory?

I haven't seen that error. I said in another email that I think that is
due to the timeout cancelling the tests forcefully.


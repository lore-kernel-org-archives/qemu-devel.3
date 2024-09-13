Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D46FA375E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 15:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp8Np-0007CQ-Cq; Fri, 13 Sep 2024 11:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sp8No-00077E-1q
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:38:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sp8Nl-00029y-O6
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726241928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vAI+3wUpvupsLjvE9lG2UPHs29OC5x6eQHY9m2Sl3hQ=;
 b=LH3oRFE0a6tck5d3Ft9AaPgc2CoUGj+rprYaH+o4XXjHNyQlLhsBzI9bTYFri+ogqFn8VV
 dzOw7X8Qh9WAVKVWyALXDZfPqWTjFBYmvta83LaF/g2/q9Sr0nIyjFEv4GCmXIHOD4QsNw
 XYMYP8tut6uPT4h7+0Wf1eDZFts/6jk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-s1F2dxg0O5-5W1L3vPUXvA-1; Fri, 13 Sep 2024 11:38:46 -0400
X-MC-Unique: s1F2dxg0O5-5W1L3vPUXvA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6c57e50575fso19579136d6.2
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 08:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726241925; x=1726846725;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vAI+3wUpvupsLjvE9lG2UPHs29OC5x6eQHY9m2Sl3hQ=;
 b=AroxJHvKsn1bWWdyanpnmG/qYxlFp8qEtQ5AxvQpDEIycosfexIhLdHIvFtjBI7cit
 yjidKH3hXjiVB5hnPPSUd2JjTdw2FyCFTuKSbGXW+1IDUKOycqGd17Pi13DnK269Zv4m
 t3WTvAC+HJO3nQGXPkfA1SyZd5q3TEwm8mtBbdQp5L6mP3/eszkzyT2uvioaUGbsT6OU
 ea/YFCTlur5IhjISAJwYXnxPwn5QQFw5BzT57dTxd3AgXGZ7M70Ssx12egvl2b8mDNuG
 WIH3SKr4GUD8T5bH8A7kSYUCeaIvmuBHR225immmn7zUTjZCa4/e0nlcp+zZuF+ljPj2
 WtVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWs6USNzJjMDtJp+HdRrTuBiaBkW69c2dr6T3fShA0EvXIkE+P3Ydx1NKQLQ/uIDP/3MHNvzwWtx5c@nongnu.org
X-Gm-Message-State: AOJu0YyMDc8EVTs/5qvgEY1ELD9g/0+OugukGiNaKby2ewT5UiehNwFN
 wr0v/y1dRHKD35XiVJr6tRr37oaZ5ZFOGckYeUmjM+QBExyQW6cEbpKsNJtacXDa6+04wXM+8pR
 QGtnC8YSATRX6xkNzDmSWCjfSrJtYS0q46ohioxJU1JlODJ3TL/u5
X-Received: by 2002:a05:6214:3a08:b0:6c3:58b7:d703 with SMTP id
 6a1803df08f44-6c57dfb6b63mr50106186d6.22.1726241925462; 
 Fri, 13 Sep 2024 08:38:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfHNzk+ENhBRwapjvJUqycINemmsW4jr/JoQA8vPOBy2FeERNrlPsaUqGMTZmynVjABXM5Ag==
X-Received: by 2002:a05:6214:3a08:b0:6c3:58b7:d703 with SMTP id
 6a1803df08f44-6c57dfb6b63mr50105856d6.22.1726241925019; 
 Fri, 13 Sep 2024 08:38:45 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c534339a88sm67916956d6.50.2024.09.13.08.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 08:38:44 -0700 (PDT)
Date: Fri, 13 Sep 2024 11:38:42 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hyman Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC 10/10] tests/migration-tests: Add test case for
 responsive CPU throttle
Message-ID: <ZuRcgmt2DRPgPdg4@x1n>
References: <87ed5qq8e2.fsf@suse.de> <ZuH_pvnTCumKuXTh@x1n>
 <87bk0trifq.fsf@suse.de>
 <CAFEAcA9YkZiSSOAj0zH2OwF9AcziJT-zpnNVQn8BXizhSXHVOA@mail.gmail.com>
 <ZuMEF99PF0q0U9G-@x1n> <877cbghoi9.fsf@suse.de>
 <87ttek1o3j.fsf@suse.de> <ZuRTgbDhEJ7c-dcE@x1n>
 <87ikuz1tgz.fsf@suse.de> <87frq31t2j.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87frq31t2j.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.147,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 13, 2024 at 12:17:40PM -0300, Fabiano Rosas wrote:
> Fabiano Rosas <farosas@suse.de> writes:
> 
> > Peter Xu <peterx@redhat.com> writes:
> >
> >> On Thu, Sep 12, 2024 at 07:52:48PM -0300, Fabiano Rosas wrote:
> >>> Fabiano Rosas <farosas@suse.de> writes:
> >>> 
> >>> > Peter Xu <peterx@redhat.com> writes:
> >>> >
> >>> >> On Thu, Sep 12, 2024 at 09:13:16AM +0100, Peter Maydell wrote:
> >>> >>> On Wed, 11 Sept 2024 at 22:26, Fabiano Rosas <farosas@suse.de> wrote:
> >>> >>> > I don't think we're discussing total CI time at this point, so the math
> >>> >>> > doesn't really add up. We're not looking into making the CI finish
> >>> >>> > faster. We're looking into making migration-test finish faster. That
> >>> >>> > would reduce timeouts in CI, speed-up make check and reduce the chance
> >>> >>> > of random race conditions* affecting other people/staging runs.
> >>> >>> 
> >>> >>> Right. The reason migration-test appears on my radar is because
> >>> >>> it is very frequently the thing that shows up as "this sometimes
> >>> >>> just fails or just times out and if you hit retry it goes away
> >>> >>> again". That might not be migration-test's fault specifically,
> >>> >>> because those retries tend to be certain CI configs (s390,
> >>> >>> the i686-tci one), and I have some theories about what might be
> >>> >>> causing it (e.g. build system runs 4 migration-tests in parallel,
> >>> >>> which means 8 QEMU processes which is too many for the number
> >>> >>> of host CPUs). But right now I look at CI job failures and my reaction
> >>> >>> is "oh, it's the migration-test failing yet again" :-(
> >>> >>> 
> >>> >>> For some examples from this week:
> >>> >>> 
> >>> >>> https://gitlab.com/qemu-project/qemu/-/jobs/7802183144
> >>> >>> https://gitlab.com/qemu-project/qemu/-/jobs/7799842373  <--------[1]
> >>> >>> https://gitlab.com/qemu-project/qemu/-/jobs/7786579152  <--------[2]
> >>> >>> https://gitlab.com/qemu-project/qemu/-/jobs/7786579155
> >>> >>
> >>> >> Ah right, the TIMEOUT is unfortunate, especially if tests can be run in
> >>> >> parallel.  It indeed sounds like no good way to finally solve.. I don't
> >>> >> also see how speeding up / reducing tests in migration test would help, as
> >>> >> that's (from some degree..) is the same as tuning the timeout value bigger.
> >>> >> When the tests are less it'll fit into 480s window, but maybe it's too
> >>> >> quick now we wonder whether we should shrink it to e.g. 90s, but then it
> >>> >> can timeout again when on a busy host with less capability of concurrency.
> >>> >>
> >>> >> But indeed there're two ERRORs ([1,2] above)..  I collected some more info
> >>> >> here before the log expires:
> >>> >>
> >>> >> =================================8<================================
> >>> >>
> >>> >> *** /i386/migration/multifd/tcp/plain/cancel, qtest-i386 on s390 host
> >>> >>
> >>> >> https://gitlab.com/qemu-project/qemu/-/jobs/7799842373
> >>> >>
> >>> >> 101/953 qemu:qtest+qtest-i386 / qtest-i386/migration-test                         ERROR          144.32s   killed by signal 6 SIGABRT
> >>> >>>>> QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon G_TEST_DBUS_DAEMON=/home/gitlab-runner/builds/zEr9wY_L/0/qemu-project/qemu/tests/dbus-vmstate-daemon.sh PYTHON=/home/gitlab-runner/builds/zEr9wY_L/0/qemu-project/qemu/build/pyvenv/bin/python3 QTEST_QEMU_IMG=./qemu-img MALLOC_PERTURB_=144 QTEST_QEMU_BINARY=./qemu-system-i386 /home/gitlab-runner/builds/zEr9wY_L/0/qemu-project/qemu/build/tests/qtest/migration-test --tap -k
> >>> >> ――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
> >>> >> stderr:
> >>> >> warning: fd: migration to a file is deprecated. Use file: instead.
> >>> >> warning: fd: migration to a file is deprecated. Use file: instead.
> >>> >> ../tests/qtest/libqtest.c:205: kill_qemu() detected QEMU death from signal 11 (Segmentation fault) (core dumped)
> >>> >> (test program exited with status code -6)
> >>> >> TAP parsing error: Too few tests run (expected 53, got 39)
> >>> >> ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
> >>> >>
> >>> >> # Start of plain tests
> >>> >> # Running /i386/migration/multifd/tcp/plain/cancel
> >>> >> # Using machine type: pc-i440fx-9.2
> >>> >> # starting QEMU: exec ./qemu-system-i386 -qtest unix:/tmp/qtest-3273509.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-3273509.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -accel kvm -accel tcg -machine pc-i440fx-9.2, -name source,debug-threads=on -m 150M -serial file:/tmp/migration-test-4112T2/src_serial -drive if=none,id=d0,file=/tmp/migration-test-4112T2/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1    2>/dev/null -accel qtest
> >>> >> # starting QEMU: exec ./qemu-system-i386 -qtest unix:/tmp/qtest-3273509.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-3273509.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -accel kvm -accel tcg -machine pc-i440fx-9.2, -name target,debug-threads=on -m 150M -serial file:/tmp/migration-test-4112T2/dest_serial -incoming defer -drive if=none,id=d0,file=/tmp/migration-test-4112T2/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1    2>/dev/null -accel qtest
> >>> >> ----------------------------------- stderr -----------------------------------
> >>> >> warning: fd: migration to a file is deprecated. Use file: instead.
> >>> >> warning: fd: migration to a file is deprecated. Use file: instead.
> >>> >> ../tests/qtest/libqtest.c:205: kill_qemu() detected QEMU death from signal 11 (Segmentation fault) (core dumped)
> >>> >>
> >>> >> *** /ppc64/migration/multifd/tcp/plain/cancel, qtest-ppc64 on i686 host
> >>> >>
> >>> >> https://gitlab.com/qemu-project/qemu/-/jobs/7786579152
> >>> >>
> >>> >> 174/315 qemu:qtest+qtest-ppc64 / qtest-ppc64/migration-test                       ERROR          381.00s   killed by signal 6 SIGABRT
> >>> >>>>> PYTHON=/builds/qemu-project/qemu/build/pyvenv/bin/python3 QTEST_QEMU_IMG=./qemu-img G_TEST_DBUS_DAEMON=/builds/qemu-project/qemu/tests/dbus-vmstate-daemon.sh QTEST_QEMU_BINARY=./qemu-system-ppc64 MALLOC_PERTURB_=178 QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon /builds/qemu-project/qemu/build/tests/qtest/migration-test --tap -k
> >>> >> ――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
> >>> >> stderr:
> >>> >> qemu-system-ppc64: Cannot read from TLS channel: The TLS connection was non-properly terminated.
> >>> >> warning: fd: migration to a file is deprecated. Use file: instead.
> >>> >> warning: fd: migration to a file is deprecated. Use file: instead.
> >>> >> ../tests/qtest/libqtest.c:205: kill_qemu() detected QEMU death from signal 11 (Segmentation fault) (core dumped)
> >>> >> (test program exited with status code -6)
> >>> >> TAP parsing error: Too few tests run (expected 61, got 47)
> >>> >> ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
> >>> >>
> >>> >> # Start of plain tests
> >>> >> # Running /ppc64/migration/multifd/tcp/plain/cancel
> >>> >> # Using machine type: pseries-9.2
> >>> >> # starting QEMU: exec ./qemu-system-ppc64 -qtest unix:/tmp/qtest-40766.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-40766.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -accel kvm -accel tcg -machine pseries-9.2,vsmt=8 -name source,debug-threads=on -m 256M -serial file:/tmp/migration-test-H0Z1T2/src_serial -nodefaults -machine cap-cfpc=broken,cap-sbbc=broken,cap-ibs=broken,cap-ccf-assist=off, -bios /tmp/migration-test-H0Z1T2/bootsect    2>/dev/null -accel qtest
> >>> >> # starting QEMU: exec ./qemu-system-ppc64 -qtest unix:/tmp/qtest-40766.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-40766.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -accel kvm -accel tcg -machine pseries-9.2,vsmt=8 -name target,debug-threads=on -m 256M -serial file:/tmp/migration-test-H0Z1T2/dest_serial -incoming defer -nodefaults -machine cap-cfpc=broken,cap-sbbc=broken,cap-ibs=broken,cap-ccf-assist=off, -bios /tmp/migration-test-H0Z1T2/bootsect    2>/dev/null -accel qtest
> >>> >> ----------------------------------- stderr -----------------------------------
> >>> >> qemu-system-ppc64: Cannot read from TLS channel: The TLS connection was non-properly terminated.
> >>> >> warning: fd: migration to a file is deprecated. Use file: instead.
> >>> >> warning: fd: migration to a file is deprecated. Use file: instead.
> >>> >> ../tests/qtest/libqtest.c:205: kill_qemu() detected QEMU death from signal 11 (Segmentation fault) (core dumped)
> >>> >>
> >>> >> (test program exited with status code -6)
> >>> >> =================================8<================================
> >>> >>
> >>> >> So.. it's the same test (multifd/tcp/plain/cancel) that is failing on
> >>> >> different host / arch being tested.  What is more weird is the two failures
> >>> >> are different, the 2nd failure throw out a TLS error even though the test
> >>> >> doesn't yet have tls involved.
> >>> >
> >>> > I think that's just a parallel test being cancelled prematurely, either
> >>> > due to the crash or due to the timeout.
> >>> >
> >>> >>
> >>> >> Fabiano, is this the issue you're looking at?
> >>> >
> >>> > Yes. I can reproduce locally by running 2 processes in parallel: 1 loop
> >>> > with make -j$(nproc) check and another loop with tcp/plain/cancel. It
> >>> > takes ~1h to hit. I've seen crashes with ppc64, s390 and
> >>> > aarch64.
> >>> >
> >>> 
> >>> Ok, the issue is that after commit 5ef7e26bdb ("migration/multifd: solve
> >>> zero page causing multiple page faults"), the multifd code started using
> >>> the rb->receivedmap bitmap, which belongs to the ram code and is
> >>> initialized and *freed* from the ram SaveVMHandlers.
> >>> 
> >>> process_incoming_migration_co()        ...
> >>>   qemu_loadvm_state()                  multifd_nocomp_recv()
> >>>     qemu_loadvm_state_cleanup()          ramblock_recv_bitmap_set_offset()
> >>>       rb->receivedmap = NULL               set_bit_atomic(..., rb->receivedmap)
> >>>   ...
> >>>   migration_incoming_state_destroy()
> >>>     multifd_recv_cleanup()
> >>>       multifd_recv_terminate_threads(NULL)
> >>> 
> >>> Multifd threads are live until migration_incoming_state_destroy(), which
> >>> is called some time later.
> >>
> >> Thanks for the debugging.  Hmm I would expect loadvm should wait until all
> >> ram is received somehow..
> >
> > Looks like a similar issue as when we didn't have the multifd_send sync
> > working correctly and ram code would run and do cleanup.
> 
> Btw, this is hard to debug, but I bet what's happening is that the
> ram_load code itself is exiting due to qemufile error. So there wouldn't
> be a way to make it wait for multifd.

One more thing is I remember one of the error is not the crash but some TLS
disconnection error.  I wonder which one you can reproduce and why that TLS
code can got kicked off in the multifd cancel test.  Perhaps the memory was
simply corrupted around, so bitmap ops can write to some other memory?

-- 
Peter Xu



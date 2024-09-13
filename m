Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BAF0FA375A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 15:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp7mo-0006RS-1P; Fri, 13 Sep 2024 11:00:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sp7mi-0006QV-VP
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:00:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sp7mf-0006Jw-Dn
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:00:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726239627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4m4alsx8S/0kcCKsexJuUJABR7Q4IOu/djRapq6AJXg=;
 b=TtvVAPaX1dSjVT0cd7QlareRh6BXwNVtXk6lXBp93ZHCal+nEd5ACnqkXQNwFFXpSaAK6o
 p6snw4voekRFyRqSV/50qO26/jSsv+9JhK42RJuTgtiseRm+6k8A63JD86fcU2hHQdqM8e
 XqdDkSXTGV0nl410ejhZH+ovQmAgn9M=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-TsIMPJgoMby-hmb95f-WoA-1; Fri, 13 Sep 2024 11:00:26 -0400
X-MC-Unique: TsIMPJgoMby-hmb95f-WoA-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-e02a4de4f4eso4373371276.1
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 08:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726239624; x=1726844424;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4m4alsx8S/0kcCKsexJuUJABR7Q4IOu/djRapq6AJXg=;
 b=tmpy9+wv5vUJhP7IRBr5Tf6LeuxuwX492xaUIVdh9LVGZVyTeTM/ZQ1qgo6ZtyOvts
 ATLFbmYeXQQ1pnc8s97tnNv3jM0dTCRbxC9AoM5a6eBPjylMKCzv8D1Lk8am4K1Dv8Xi
 kId06GD6+h5XRTpPXJQw47zn2Q/Pla9/NeeX3HqMFMrD55oYx50Ccvus8umDqC28AQd2
 LSGvHcqVN/spMzuDzbfI+LBkgaHflCsyXeNa7w1xEs1c0V0MT5jce9+/ydSQu20oIwJd
 7RvuTjVAVxxYiEiIE5cE3A/LBQAXGyd59RbU4kjZzC+iac53Fs4964HkD4t+lqsxXJjx
 46Sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+cQVXwdPJ3T3sVZdbLxByo2IB1kQVRW8s6C6Q7uXfEHckZRrDEW/WyRxyjGz4ne8wt+K/UmrgbSeH@nongnu.org
X-Gm-Message-State: AOJu0YzTXetL5OV0GdAfBok0ZBZz4RoFLixly5K1r49SItIqYiCAuTXe
 2wPJFOUp38fYehVK8OYEqLlu7UI7jH8XYEp65fhS0dWyVlVtOUEj7BIrFDqReR0ozsLY3Qvxyv9
 j1DcibRPoqarN0lIA0HhXlwnFjy6j/IMgLA8ynFp7/M/Z8Er/Ou2B
X-Received: by 2002:a05:6902:2e0f:b0:e1d:94cf:4922 with SMTP id
 3f1490d57ef6-e1d9dbe2a60mr6347851276.33.1726239622594; 
 Fri, 13 Sep 2024 08:00:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMIVGrLF0qzcOfFZiNIzVoTx1aXYdVKwFb1n28FczUklvTTQ83i4AxJkjy00cAE6vzzFxy5w==
X-Received: by 2002:a05:6902:2e0f:b0:e1d:94cf:4922 with SMTP id
 3f1490d57ef6-e1d9dbe2a60mr6347604276.33.1726239620509; 
 Fri, 13 Sep 2024 08:00:20 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c534786129sm67380126d6.135.2024.09.13.08.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 08:00:19 -0700 (PDT)
Date: Fri, 13 Sep 2024 11:00:17 -0400
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
Message-ID: <ZuRTgbDhEJ7c-dcE@x1n>
References: <ZuC4pYT-atQwWePv@x1n> <87seu7qhao.fsf@suse.de>
 <ZuG-SijLg8Q27boE@x1n> <87ed5qq8e2.fsf@suse.de>
 <ZuH_pvnTCumKuXTh@x1n> <87bk0trifq.fsf@suse.de>
 <CAFEAcA9YkZiSSOAj0zH2OwF9AcziJT-zpnNVQn8BXizhSXHVOA@mail.gmail.com>
 <ZuMEF99PF0q0U9G-@x1n> <877cbghoi9.fsf@suse.de>
 <87ttek1o3j.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ttek1o3j.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Thu, Sep 12, 2024 at 07:52:48PM -0300, Fabiano Rosas wrote:
> Fabiano Rosas <farosas@suse.de> writes:
> 
> > Peter Xu <peterx@redhat.com> writes:
> >
> >> On Thu, Sep 12, 2024 at 09:13:16AM +0100, Peter Maydell wrote:
> >>> On Wed, 11 Sept 2024 at 22:26, Fabiano Rosas <farosas@suse.de> wrote:
> >>> > I don't think we're discussing total CI time at this point, so the math
> >>> > doesn't really add up. We're not looking into making the CI finish
> >>> > faster. We're looking into making migration-test finish faster. That
> >>> > would reduce timeouts in CI, speed-up make check and reduce the chance
> >>> > of random race conditions* affecting other people/staging runs.
> >>> 
> >>> Right. The reason migration-test appears on my radar is because
> >>> it is very frequently the thing that shows up as "this sometimes
> >>> just fails or just times out and if you hit retry it goes away
> >>> again". That might not be migration-test's fault specifically,
> >>> because those retries tend to be certain CI configs (s390,
> >>> the i686-tci one), and I have some theories about what might be
> >>> causing it (e.g. build system runs 4 migration-tests in parallel,
> >>> which means 8 QEMU processes which is too many for the number
> >>> of host CPUs). But right now I look at CI job failures and my reaction
> >>> is "oh, it's the migration-test failing yet again" :-(
> >>> 
> >>> For some examples from this week:
> >>> 
> >>> https://gitlab.com/qemu-project/qemu/-/jobs/7802183144
> >>> https://gitlab.com/qemu-project/qemu/-/jobs/7799842373  <--------[1]
> >>> https://gitlab.com/qemu-project/qemu/-/jobs/7786579152  <--------[2]
> >>> https://gitlab.com/qemu-project/qemu/-/jobs/7786579155
> >>
> >> Ah right, the TIMEOUT is unfortunate, especially if tests can be run in
> >> parallel.  It indeed sounds like no good way to finally solve.. I don't
> >> also see how speeding up / reducing tests in migration test would help, as
> >> that's (from some degree..) is the same as tuning the timeout value bigger.
> >> When the tests are less it'll fit into 480s window, but maybe it's too
> >> quick now we wonder whether we should shrink it to e.g. 90s, but then it
> >> can timeout again when on a busy host with less capability of concurrency.
> >>
> >> But indeed there're two ERRORs ([1,2] above)..  I collected some more info
> >> here before the log expires:
> >>
> >> =================================8<================================
> >>
> >> *** /i386/migration/multifd/tcp/plain/cancel, qtest-i386 on s390 host
> >>
> >> https://gitlab.com/qemu-project/qemu/-/jobs/7799842373
> >>
> >> 101/953 qemu:qtest+qtest-i386 / qtest-i386/migration-test                         ERROR          144.32s   killed by signal 6 SIGABRT
> >>>>> QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon G_TEST_DBUS_DAEMON=/home/gitlab-runner/builds/zEr9wY_L/0/qemu-project/qemu/tests/dbus-vmstate-daemon.sh PYTHON=/home/gitlab-runner/builds/zEr9wY_L/0/qemu-project/qemu/build/pyvenv/bin/python3 QTEST_QEMU_IMG=./qemu-img MALLOC_PERTURB_=144 QTEST_QEMU_BINARY=./qemu-system-i386 /home/gitlab-runner/builds/zEr9wY_L/0/qemu-project/qemu/build/tests/qtest/migration-test --tap -k
> >> ――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
> >> stderr:
> >> warning: fd: migration to a file is deprecated. Use file: instead.
> >> warning: fd: migration to a file is deprecated. Use file: instead.
> >> ../tests/qtest/libqtest.c:205: kill_qemu() detected QEMU death from signal 11 (Segmentation fault) (core dumped)
> >> (test program exited with status code -6)
> >> TAP parsing error: Too few tests run (expected 53, got 39)
> >> ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
> >>
> >> # Start of plain tests
> >> # Running /i386/migration/multifd/tcp/plain/cancel
> >> # Using machine type: pc-i440fx-9.2
> >> # starting QEMU: exec ./qemu-system-i386 -qtest unix:/tmp/qtest-3273509.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-3273509.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -accel kvm -accel tcg -machine pc-i440fx-9.2, -name source,debug-threads=on -m 150M -serial file:/tmp/migration-test-4112T2/src_serial -drive if=none,id=d0,file=/tmp/migration-test-4112T2/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1    2>/dev/null -accel qtest
> >> # starting QEMU: exec ./qemu-system-i386 -qtest unix:/tmp/qtest-3273509.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-3273509.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -accel kvm -accel tcg -machine pc-i440fx-9.2, -name target,debug-threads=on -m 150M -serial file:/tmp/migration-test-4112T2/dest_serial -incoming defer -drive if=none,id=d0,file=/tmp/migration-test-4112T2/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1    2>/dev/null -accel qtest
> >> ----------------------------------- stderr -----------------------------------
> >> warning: fd: migration to a file is deprecated. Use file: instead.
> >> warning: fd: migration to a file is deprecated. Use file: instead.
> >> ../tests/qtest/libqtest.c:205: kill_qemu() detected QEMU death from signal 11 (Segmentation fault) (core dumped)
> >>
> >> *** /ppc64/migration/multifd/tcp/plain/cancel, qtest-ppc64 on i686 host
> >>
> >> https://gitlab.com/qemu-project/qemu/-/jobs/7786579152
> >>
> >> 174/315 qemu:qtest+qtest-ppc64 / qtest-ppc64/migration-test                       ERROR          381.00s   killed by signal 6 SIGABRT
> >>>>> PYTHON=/builds/qemu-project/qemu/build/pyvenv/bin/python3 QTEST_QEMU_IMG=./qemu-img G_TEST_DBUS_DAEMON=/builds/qemu-project/qemu/tests/dbus-vmstate-daemon.sh QTEST_QEMU_BINARY=./qemu-system-ppc64 MALLOC_PERTURB_=178 QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon /builds/qemu-project/qemu/build/tests/qtest/migration-test --tap -k
> >> ――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
> >> stderr:
> >> qemu-system-ppc64: Cannot read from TLS channel: The TLS connection was non-properly terminated.
> >> warning: fd: migration to a file is deprecated. Use file: instead.
> >> warning: fd: migration to a file is deprecated. Use file: instead.
> >> ../tests/qtest/libqtest.c:205: kill_qemu() detected QEMU death from signal 11 (Segmentation fault) (core dumped)
> >> (test program exited with status code -6)
> >> TAP parsing error: Too few tests run (expected 61, got 47)
> >> ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
> >>
> >> # Start of plain tests
> >> # Running /ppc64/migration/multifd/tcp/plain/cancel
> >> # Using machine type: pseries-9.2
> >> # starting QEMU: exec ./qemu-system-ppc64 -qtest unix:/tmp/qtest-40766.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-40766.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -accel kvm -accel tcg -machine pseries-9.2,vsmt=8 -name source,debug-threads=on -m 256M -serial file:/tmp/migration-test-H0Z1T2/src_serial -nodefaults -machine cap-cfpc=broken,cap-sbbc=broken,cap-ibs=broken,cap-ccf-assist=off, -bios /tmp/migration-test-H0Z1T2/bootsect    2>/dev/null -accel qtest
> >> # starting QEMU: exec ./qemu-system-ppc64 -qtest unix:/tmp/qtest-40766.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-40766.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -accel kvm -accel tcg -machine pseries-9.2,vsmt=8 -name target,debug-threads=on -m 256M -serial file:/tmp/migration-test-H0Z1T2/dest_serial -incoming defer -nodefaults -machine cap-cfpc=broken,cap-sbbc=broken,cap-ibs=broken,cap-ccf-assist=off, -bios /tmp/migration-test-H0Z1T2/bootsect    2>/dev/null -accel qtest
> >> ----------------------------------- stderr -----------------------------------
> >> qemu-system-ppc64: Cannot read from TLS channel: The TLS connection was non-properly terminated.
> >> warning: fd: migration to a file is deprecated. Use file: instead.
> >> warning: fd: migration to a file is deprecated. Use file: instead.
> >> ../tests/qtest/libqtest.c:205: kill_qemu() detected QEMU death from signal 11 (Segmentation fault) (core dumped)
> >>
> >> (test program exited with status code -6)
> >> =================================8<================================
> >>
> >> So.. it's the same test (multifd/tcp/plain/cancel) that is failing on
> >> different host / arch being tested.  What is more weird is the two failures
> >> are different, the 2nd failure throw out a TLS error even though the test
> >> doesn't yet have tls involved.
> >
> > I think that's just a parallel test being cancelled prematurely, either
> > due to the crash or due to the timeout.
> >
> >>
> >> Fabiano, is this the issue you're looking at?
> >
> > Yes. I can reproduce locally by running 2 processes in parallel: 1 loop
> > with make -j$(nproc) check and another loop with tcp/plain/cancel. It
> > takes ~1h to hit. I've seen crashes with ppc64, s390 and
> > aarch64.
> >
> 
> Ok, the issue is that after commit 5ef7e26bdb ("migration/multifd: solve
> zero page causing multiple page faults"), the multifd code started using
> the rb->receivedmap bitmap, which belongs to the ram code and is
> initialized and *freed* from the ram SaveVMHandlers.
> 
> process_incoming_migration_co()        ...
>   qemu_loadvm_state()                  multifd_nocomp_recv()
>     qemu_loadvm_state_cleanup()          ramblock_recv_bitmap_set_offset()
>       rb->receivedmap = NULL               set_bit_atomic(..., rb->receivedmap)
>   ...
>   migration_incoming_state_destroy()
>     multifd_recv_cleanup()
>       multifd_recv_terminate_threads(NULL)
> 
> Multifd threads are live until migration_incoming_state_destroy(), which
> is called some time later.

Thanks for the debugging.  Hmm I would expect loadvm should wait until all
ram is received somehow..

And when looking, I also found we're ambiguous on the cleanups
now.. probably a separate issue that not yet cause crashes.  I meant we
even don't have a consistent order to clean these in precopy / postcopy,
as:

We have this:

  qemu_loadvm_state
    qemu_loadvm_state_cleanup              <------------- [1]
  migration_bh_schedule(process_incoming_migration_bh, mis);
  (then in bh...)
  process_incoming_migration_bh
    migration_incoming_state_destroy       <------------- [2]

But then:
  
  postcopy_ram_listen_thread
    migration_incoming_state_destroy       <------------- [2]
    qemu_loadvm_state_cleanup              <------------- [1]

I think it makes more sense to do [2] after [1], so maybe postcopy needs
changing too..

> 
> >> Peter, do you think it'll be helpful if we temporarily mark this test as
> >> "slow" too so it's not run in CI (so we still run it ourselves when prepare
> >> migration PR, with the hope that it can reproduce)?
> >>
> >> Thanks,
> 

-- 
Peter Xu



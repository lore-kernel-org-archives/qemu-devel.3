Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D81C5475B
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 05:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkdUy-00025x-63; Thu, 14 Mar 2024 01:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rkdUu-00025W-JZ
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 01:19:20 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rkdUs-0007vu-6f
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 01:19:19 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5cfd95130c6so353522a12.1
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 22:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710393556; x=1710998356; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W7NW/Xt0y6NcD72Nug/97nL1f17cQa996I7rJFnP1no=;
 b=AdedXBPLFROBvD4nOhYMA4xQdzyiKkTe0Ke5/VF1ZJoAaXvGhImVLya2LdDlewd/KJ
 jbg1QWjiC8+8gtkqFvtj9Hk9Ei635ZzxkI20rJnhOEwoB63TKUC9K6DKxwtoOOPL1Hzu
 e3escmlYKiUbz8zB4ihe2JG179Vcw0el8Iaz3LsDo+EZpDOGafJq/ytkBjoVaVdzXuOW
 bFedme3lleqCbVjfCP2f/IQQe7lCWGv0blVGwZVrIUmd6C2XPNd+HIcYd4bk1AxFpQoi
 459BGSLbWCASbBiMMRoq7Rut5np2h5Fiq4VW3JJvuKUxW6TIRFOgkXtKL80lnJH+4yDq
 N3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710393556; x=1710998356;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=W7NW/Xt0y6NcD72Nug/97nL1f17cQa996I7rJFnP1no=;
 b=KMr9uxng7MvDuptPJGBB3OujDsSaEmpWVjDekLZ8++46JH9x04LQW1KiwVLXTGV3PR
 j1+aGwlr71WF4eyekQy1bWdVU9u69Lt/p6aYU7oTzECSqC+QJPUfUu/krfN2qhySRC54
 Nv024He9UPAANbB9TAsAHEuZJn8KhMnVJC6Gpvk7LNjf++0fBDf6qC93WQNq3e0xtsYG
 6U393CLB/yJWcif2e4HvYpzBzbv5a07upIsKJndqV/aws9yT5BqFcZ/dRzeQBMPdEj9L
 aPpMVSBgqoOtgGWVo9n5PVI+G6HB0LUjtdVsXCmeHEVNVK3Gl+oxM15KssC+4Jo41ZgZ
 XlNQ==
X-Gm-Message-State: AOJu0YzWgsFLyJD4Z8KqqoUJ8OhXM0GN4EV8S8oCItzM0IwC9cDo4T6g
 hXiwjbGUnaVDYLURKM0JQRjr83phLVJzIlrD9nIILmVQIymYD4/P
X-Google-Smtp-Source: AGHT+IEJJi1qjoBpiJAvKmEC77vbgjMsjmB5K44TqHykF7iHe8wwZtxZ8fASD157/fSK5BOmtISbyg==
X-Received: by 2002:a17:90a:7f95:b0:299:df2:66b2 with SMTP id
 m21-20020a17090a7f9500b002990df266b2mr649643pjl.22.1710393556273; 
 Wed, 13 Mar 2024 22:19:16 -0700 (PDT)
Received: from localhost ([1.146.49.180]) by smtp.gmail.com with ESMTPSA id
 ca11-20020a17090af30b00b0029bfac322aasm2313211pjb.30.2024.03.13.22.19.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 22:19:16 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 14 Mar 2024 15:19:08 +1000
Message-Id: <CZT7WSOEKNLE.1WXR5AZLZCIFF@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: <qemu-devel@nongnu.org>, "Pavel Dovgalyuk" <Pavel.Dovgalyuk@ispras.ru>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, "Paolo Bonzini"
 <pbonzini@redhat.com>, "John Snow" <jsnow@redhat.com>, "Cleber Rosa"
 <crosa@redhat.com>, "Wainer dos Santos Moschetta" <wainersm@redhat.com>,
 "Beraldo Leal" <bleal@redhat.com>, "Michael Tokarev" <mjt@tls.msk.ru>
Subject: Re: [PATCH v4 05/24] Revert "replay: stop us hanging in
 rr_wait_io_event"
X-Mailer: aerc 0.15.2
References: <20240311174026.2177152-1-npiggin@gmail.com>
 <20240311174026.2177152-6-npiggin@gmail.com>
 <87v85ro9qt.fsf@draig.linaro.org> <CZRTTCV604Z3.3MT5MR0P5FWQK@wheely>
 <87a5n3mac5.fsf@draig.linaro.org>
In-Reply-To: <87a5n3mac5.fsf@draig.linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed Mar 13, 2024 at 7:03 AM AEST, Alex Benn=C3=A9e wrote:
> "Nicholas Piggin" <npiggin@gmail.com> writes:
>
> > On Tue Mar 12, 2024 at 11:33 PM AEST, Alex Benn=C3=A9e wrote:
> >> Nicholas Piggin <npiggin@gmail.com> writes:
> >>
> >> > This reverts commit 1f881ea4a444ef36a8b6907b0b82be4b3af253a2.
> >> >
> >> > That commit causes reverse_debugging.py test failures, and does
> >> > not seem to solve the root cause of the problem x86-64 still
> >> > hangs in record/replay tests.
> >>
> >> I'm still finding the reverse debugging tests failing with this series=
.
> >
> > :(
> >
> > In gitlab CI or your own testing? What are you running exactly?
>
> My own - my mistake I didn't get a clean build because of the format
> bug. However I'm seeing new failures:
>
>   env QEMU_TEST_FLAKY_TESTS=3D1 AVOCADO_TIMEOUT_EXPECTED=3D1 ./pyvenv/bin=
/avocado run ./tests/avocado/reverse_debugging.py
>   Fetching asset from ./tests/avocado/reverse_debugging.py:ReverseDebuggi=
ng_AArch64.test_aarch64_virt
>   JOB ID     : bd4b29f7afaa24dc6e32933ea9bc5e46bbc3a5a4
>   JOB LOG    : /home/alex/avocado/job-results/job-2024-03-12T20.58-bd4b29=
f/job.log
>    (1/5) ./tests/avocado/reverse_debugging.py:ReverseDebugging_X86_64.tes=
t_x86_64_pc: PASS (4.49 s)
>    (2/5) ./tests/avocado/reverse_debugging.py:ReverseDebugging_X86_64.tes=
t_x86_64_q35: PASS (4.50 s)
>    (3/5) ./tests/avocado/reverse_debugging.py:ReverseDebugging_AArch64.te=
st_aarch64_virt: FAIL: Invalid PC (read ffff2d941e4d7f28 instead of ffff2d9=
41e4d7f2c) (3.06 s)

Okay, this is the new test I added. It runs for 1 second then
reverse-steps from the end of the trace. aarch64 is flaky -- pc is at a
different place at the same icount after the reverse-step (which is
basically the second replay). This indicates some non-determinism in
execution, or something in machine reset or migration is not restoring
the state exactly.

aarch64 ran okay few times including gitlab CI before I posted the
series, but turns out it does break quite often too.

x86 has a problem with this too so I disabled it there. I'll disable it
for aarch64 too for now.

x86 and aarch64 can run the replay_linux.py test quite well (after this
series), which is much longer and more complicated. The difference there
is that it is only a single replay, it never resets the machine or
loads the initial snapshot for reverse-debugging. So to me that
indicates that execution is probably deterministic, but its the reset
reload that has the problem.

Thanks,
Nick


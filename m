Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDE0C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 21:04:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk9Ht-0002ez-U8; Tue, 12 Mar 2024 17:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk9Hj-0002eI-Q0
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 17:03:45 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rk9Hh-0005S8-N7
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 17:03:43 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-413e8f1e002so230565e9.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 14:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710277420; x=1710882220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hd+RboktKNiO7q9GvgK60P+ZsZlpCe+ghjUbd3EGIKQ=;
 b=Ux09GW1pOfbarpy1Pdvlnb7NlEtkV7n9FQDvVPqs6gdEfYsDcn/69OejloPses66Sg
 ZJnvFMLu34/fhsICD8eCPkW7lH5+ucuDeugbRBVLPZ07QgVOgw8LYI0jPYAC5iZys7+H
 esKTPnE3S49iXRninOJzPhhPCNwN/T4UY4jLZlBTJ3BiFPYAThg0Xj2Cer/HtMaThzKg
 J4Zsuj4XKqd/KmRDs6LeN04SlwaYxdIjIMFuzxKfgaBGVgFjcXWd84yR63NpRZHYxlCo
 zxBIyshW7/GwevW/W7Ruc+y6jAr7NE2jrPDnuVBLK4TsNjL0WSNoFCekYS5g9dzgbNW6
 pvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710277420; x=1710882220;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hd+RboktKNiO7q9GvgK60P+ZsZlpCe+ghjUbd3EGIKQ=;
 b=vwoQbHOiDIRwSt58qEXblk070WKZjp9C6UHxQQrSorwBpbo/Oz7oV/Ollf5md9KWUk
 z6dLm+3rhHVHpwx7UaWFr35u5v8xbNvz1byWEW5sPKM6Ehl+scakDBs+gHvhjJ6hPiqK
 M35BodtLK+8sAsH0rsGsNDsROYzKlzoX+H/T/Q8uoZqkDjYJP95AJyK5SUFOHinYNt10
 bSW9j/99DmS7SjX2ymeAEJXROKlzIzsjnEMB1wh2hM/YGjFt7gSOaozmQu3N93z8qvfz
 5iXKNJOMk0tsfdd4i3KRhKAGoFbalZ+EQ4Eovdws5WHs47yAM/uvDIBN4l3HshmyDqoF
 xdbg==
X-Gm-Message-State: AOJu0YxGh/xSA8EVQkPGPVhovw1qCLv+iazl1BGjASKnhpJmc44vHrM/
 MXxu2s0Qa5BxQh3ylFLeasxoRG+XloaDCMeL8kXsGIOxzH8B//gRuPE4+aqCnwQ=
X-Google-Smtp-Source: AGHT+IFDmuoBzSfuw/Z+/bihDPS8kezAPEBY3Q6j+ueuYoImxtl5Un2QEv9/k96QJiNjYtnaUo4+Ew==
X-Received: by 2002:a05:600c:4e8a:b0:413:16e1:eac1 with SMTP id
 f10-20020a05600c4e8a00b0041316e1eac1mr8201091wmq.33.1710277419628; 
 Tue, 12 Mar 2024 14:03:39 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 he13-20020a05600c540d00b00413331845a6sm89798wmb.13.2024.03.12.14.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 14:03:39 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B591E5F794;
 Tue, 12 Mar 2024 21:03:38 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Nicholas Piggin" <npiggin@gmail.com>
Cc: <qemu-devel@nongnu.org>,  "Pavel Dovgalyuk" <Pavel.Dovgalyuk@ispras.ru>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  "Richard
 Henderson"
 <richard.henderson@linaro.org>,  "Paolo Bonzini" <pbonzini@redhat.com>,
 "John Snow" <jsnow@redhat.com>,  "Cleber Rosa" <crosa@redhat.com>,
 "Wainer dos Santos Moschetta" <wainersm@redhat.com>,  "Beraldo Leal"
 <bleal@redhat.com>,  "Michael Tokarev" <mjt@tls.msk.ru>
Subject: Re: [PATCH v4 05/24] Revert "replay: stop us hanging in
 rr_wait_io_event"
In-Reply-To: <CZRTTCV604Z3.3MT5MR0P5FWQK@wheely> (Nicholas Piggin's message of
 "Wed, 13 Mar 2024 00:03:43 +1000")
References: <20240311174026.2177152-1-npiggin@gmail.com>
 <20240311174026.2177152-6-npiggin@gmail.com>
 <87v85ro9qt.fsf@draig.linaro.org> <CZRTTCV604Z3.3MT5MR0P5FWQK@wheely>
User-Agent: mu4e 1.12.1; emacs 29.1
Date: Tue, 12 Mar 2024 21:03:38 +0000
Message-ID: <87a5n3mac5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

"Nicholas Piggin" <npiggin@gmail.com> writes:

> On Tue Mar 12, 2024 at 11:33 PM AEST, Alex Benn=C3=A9e wrote:
>> Nicholas Piggin <npiggin@gmail.com> writes:
>>
>> > This reverts commit 1f881ea4a444ef36a8b6907b0b82be4b3af253a2.
>> >
>> > That commit causes reverse_debugging.py test failures, and does
>> > not seem to solve the root cause of the problem x86-64 still
>> > hangs in record/replay tests.
>>
>> I'm still finding the reverse debugging tests failing with this series.
>
> :(
>
> In gitlab CI or your own testing? What are you running exactly?

My own - my mistake I didn't get a clean build because of the format
bug. However I'm seeing new failures:

  env QEMU_TEST_FLAKY_TESTS=3D1 AVOCADO_TIMEOUT_EXPECTED=3D1 ./pyvenv/bin/a=
vocado run ./tests/avocado/reverse_debugging.py
  Fetching asset from ./tests/avocado/reverse_debugging.py:ReverseDebugging=
_AArch64.test_aarch64_virt
  JOB ID     : bd4b29f7afaa24dc6e32933ea9bc5e46bbc3a5a4
  JOB LOG    : /home/alex/avocado/job-results/job-2024-03-12T20.58-bd4b29f/=
job.log
   (1/5) ./tests/avocado/reverse_debugging.py:ReverseDebugging_X86_64.test_=
x86_64_pc: PASS (4.49 s)
   (2/5) ./tests/avocado/reverse_debugging.py:ReverseDebugging_X86_64.test_=
x86_64_q35: PASS (4.50 s)
   (3/5) ./tests/avocado/reverse_debugging.py:ReverseDebugging_AArch64.test=
_aarch64_virt: FAIL: Invalid PC (read ffff2d941e4d7f28 instead of ffff2d941=
e4d7f2c) (3.06 s)
   (4/5) ./tests/avocado/reverse_debugging.py:ReverseDebugging_ppc64.test_p=
pc64_pseries: PASS (16.48 s)
   (5/5) ./tests/avocado/reverse_debugging.py:ReverseDebugging_ppc64.test_p=
pc64_powernv: FAIL: Invalid PC (read 30020210 instead of 30020214) (2.80 s)
  RESULTS    : PASS 3 | ERROR 0 | FAIL 2 | SKIP 0 | WARN 0 | INTERRUPT 0 | =
CANCEL 0
  JOB TIME   : 32.18 s

>
> I found 440fx must have some bug becaues it's quite bad, but
> q35 was more stable.
>
>>
>> > The problem with short-cutting the iowait that was taken during
>> > record phase is that related events will not get consumed at the
>> > same points (e.g., reading the clock).
>> >
>> > A hang with zero icount always seems to be a symptom of an earlier
>> > problem that has caused the recording to become out of synch with
>> > the execution and consumption of events by replay.
>>
>> Would it be possible to still detect the failure mode rather than a full
>> revert?
>
> I'm not actually sure exactly how this patch causes test failures
> (or how it was fixing the ones you saw). If I can reproduce the
> ones you see I could look a bit deeper at it.
>
> I have been looking at some ways to try detect/report record/replay
> errors more sanely because it can be very hard to debug them at
> the moment. No patches quite ready to post yet, but yes if there's
> something we could do here to help we should.
>
> Thanks,
> Nick
>
>>
>> >
>> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> > ---
>> >  include/sysemu/replay.h      |  5 -----
>> >  accel/tcg/tcg-accel-ops-rr.c |  2 +-
>> >  replay/replay.c              | 21 ---------------------
>> >  3 files changed, 1 insertion(+), 27 deletions(-)
>> >
>> > diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
>> > index f229b2109c..8102fa54f0 100644
>> > --- a/include/sysemu/replay.h
>> > +++ b/include/sysemu/replay.h
>> > @@ -73,11 +73,6 @@ int replay_get_instructions(void);
>> >  /*! Updates instructions counter in replay mode. */
>> >  void replay_account_executed_instructions(void);
>> >=20=20
>> > -/**
>> > - * replay_can_wait: check if we should pause for wait-io
>> > - */
>> > -bool replay_can_wait(void);
>> > -
>> >  /* Processing clocks and other time sources */
>> >=20=20
>> >  /*! Save the specified clock */
>> > diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr=
.c
>> > index 894e73e52c..a942442a33 100644
>> > --- a/accel/tcg/tcg-accel-ops-rr.c
>> > +++ b/accel/tcg/tcg-accel-ops-rr.c
>> > @@ -109,7 +109,7 @@ static void rr_wait_io_event(void)
>> >  {
>> >      CPUState *cpu;
>> >=20=20
>> > -    while (all_cpu_threads_idle() && replay_can_wait()) {
>> > +    while (all_cpu_threads_idle()) {
>> >          rr_stop_kick_timer();
>> >          qemu_cond_wait_bql(first_cpu->halt_cond);
>> >      }
>> > diff --git a/replay/replay.c b/replay/replay.c
>> > index b8564a4813..895fa6b67a 100644
>> > --- a/replay/replay.c
>> > +++ b/replay/replay.c
>> > @@ -451,27 +451,6 @@ void replay_start(void)
>> >      replay_enable_events();
>> >  }
>> >=20=20
>> > -/*
>> > - * For none/record the answer is yes.
>> > - */
>> > -bool replay_can_wait(void)
>> > -{
>> > -    if (replay_mode =3D=3D REPLAY_MODE_PLAY) {
>> > -        /*
>> > -         * For playback we shouldn't ever be at a point we wait. If
>> > -         * the instruction count has reached zero and we have an
>> > -         * unconsumed event we should go around again and consume it.
>> > -         */
>> > -        if (replay_state.instruction_count =3D=3D 0 && replay_state.h=
as_unread_data) {
>> > -            return false;
>> > -        } else {
>> > -            replay_sync_error("Playback shouldn't have to iowait");
>> > -        }
>> > -    }
>> > -    return true;
>> > -}
>> > -
>> > -
>> >  void replay_finish(void)
>> >  {
>> >      if (replay_mode =3D=3D REPLAY_MODE_NONE) {

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


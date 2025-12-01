Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7C0D116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 12:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ3FP-0003TQ-RK; Mon, 01 Dec 2025 07:43:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vQ3FN-0003Si-VA
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 07:43:17 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vQ3FK-0002ao-NX
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 07:43:17 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-477a2ab455fso45576685e9.3
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 04:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764592993; x=1765197793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zJ5Wk3N3dflCVR6M+yoSoosczYITZV/KeM59jMEp0go=;
 b=GKc+1kA9JMnX7ONubkU5gOOB7INFzw96u9eMa2kIBHWS2WNtcgYs6Pr7eJN7YzD1jo
 U4q/A7DZ3Al7XOzoNQjoohPR8MxN8cZ8KfNTBW8XySEO6ccOtEQnC+1+w0KBBAKth197
 lPyNSsRV2S05c4BOaYlK3mq5i7NRqMtyDk8L7PK6gt/NvpT5NisT8xdJEisKN0cUMsDt
 Ygy5FP5nmHjOpmtoLSPeLD7jyZIvYJmrQvGTyILFgyDs6nXSIQOrwuvA0Q5UYQyYQSSP
 D+Ott/mRJ+YpvodkhhRa/4OXAYU/oRvHpgL/wN5z2IdB/xvMMjwXzVwdpxt4XsR21gPZ
 o5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764592993; x=1765197793;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zJ5Wk3N3dflCVR6M+yoSoosczYITZV/KeM59jMEp0go=;
 b=MdH0Lqr8v6rqIgiIMDgd7rn0JrwvlMJ8sNH5VpOJfvphbaZy3PSHaKHqvNkh57fdsv
 Sd1s/S+rhzJmB9EC+OJodiQVetSE4l+Sq8NM/klr0iPSUsWUJ+Y2NE5708eVQ1PC3S0F
 MeYEprlNELsbRg8lPkRvGMRJwmPCqsdjTNip90aQcHBVdlzmV9Eyi44gpNlxuX6DEcG3
 eT0mgvdZ/PNTTkiWQzs2sMRZeJa2SV6EFnwD8KFC7cGc1GLTOF+eQjOtzLlh9TXDsmym
 ovsTSyXLn98Db7sUbqwgflyvtXnbfCp+HFtnIiyjy6vQ8/57Sc4FJe/qX4bsnAw9q6A8
 q0mQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXuQB8ZivBQOxsdeCCKZHbLYdvPhz1CDGErWXbeLduK9qVvqoxv8ZSXTMV+7QbzX8co14GhsrCHtyM@nongnu.org
X-Gm-Message-State: AOJu0YwzaNUb+iQgFZtDOPqKvNKcNkD38Yw3wuBKUXrHIttImv8+Es4w
 +ml9z7R9sRQpxW0oc0x/nVHjZqvcZWkSmQzW7JXMG67a7nmLPr8LAFptkl4xeV+1SVc=
X-Gm-Gg: ASbGncu54/xCQIrGNO+5FXCZ7FrCtBJuDe7OUejtzfQ3OFFstyECqHIS9FKr+eQhBmO
 MmBkUlQxbPhrRlloE2J5oJWGkvtQGVNdObCdpzNsfLIw3p6P5+zQwmRFlaSXO+XJqdXPbmxUk1r
 Vv3OrKq8LFFCQuRV5kTm9gVEgQ6KyMe72aKFZ1lpFaO8zI12n0RcHb5IfN5cY014KaYxUGJ7NAk
 C+zhEbFmNCd7fBIDRJPS3RTlUokFFijOxSIUGFTAlRXP1xLuRrwnYYdzRSumwEi9caR2lhubN9A
 M6rLoAHOqTaj7cZqfkCivE/MgV+rgE1LbBeGTaVajl1eujC7f7C5ZHB/tlX6zB6UwTJzT4rx0j9
 G5taKEbQG+IiXAEeNuuvPjUl1TKidNNvkcw3Ei67032qg9dDY/B9x39dRSxY/j6u/FCksOnKLS6
 1IN2UM3Lm+whI=
X-Google-Smtp-Source: AGHT+IHJrMvnIIRwdB0WaJXMXnHKHUXBjh2iLJ1Xv4jKBfnfLJl7pa1qDzUdko28qH0kYcRKLgT8vQ==
X-Received: by 2002:a05:600c:3ba4:b0:477:95a0:fe95 with SMTP id
 5b1f17b1804b1-477c1123ae7mr513533375e9.24.1764592992412; 
 Mon, 01 Dec 2025 04:43:12 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790b0e21e8sm318333165e9.15.2025.12.01.04.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 04:43:11 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E78115F7A9;
 Mon, 01 Dec 2025 12:43:10 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>,  qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Subject: Re: [RFC PATCH] tests/functional/s390x: Add reverse debugging test
 for s390x
In-Reply-To: <f5a9796601bb90f754be75b9366149aafa2a9bb0.camel@linux.ibm.com>
 (Ilya Leoshkevich's message of "Mon, 01 Dec 2025 12:17:13 +0100")
References: <20251128133949.181828-1-thuth@redhat.com>
 <37260d74733d7631698dd9d1dc41a991b1248d3a.camel@linux.ibm.com>
 <8efd73b100f7e78b1a5bbbe89bc221397a0a115a.camel@linux.ibm.com>
 <87zf838o2w.fsf@draig.linaro.org>
 <4bf61173827c033f9591f637f83d1aedc056a51e.camel@linux.ibm.com>
 <dfc4b7b2bdb7a6678364516de03a23959965de1e.camel@linux.ibm.com>
 <6181bc6bd6b41f46a835cee58ab3215b8cefedb4.camel@linux.ibm.com>
 <87ldjmv689.fsf@draig.linaro.org>
 <f5a9796601bb90f754be75b9366149aafa2a9bb0.camel@linux.ibm.com>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Mon, 01 Dec 2025 12:43:10 +0000
Message-ID: <87a502v0dd.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> On Mon, 2025-12-01 at 10:36 +0000, Alex Benn=C3=A9e wrote:
>> Ilya Leoshkevich <iii@linux.ibm.com> writes:
>>=20
>> > On Sun, 2025-11-30 at 20:03 +0100, Ilya Leoshkevich wrote:
>> > > On Sun, 2025-11-30 at 19:32 +0100, Ilya Leoshkevich wrote:
>> > > > On Sun, 2025-11-30 at 16:47 +0000, Alex Benn=C3=A9e wrote:
>> > > > > Ilya Leoshkevich <iii@linux.ibm.com> writes:
>> > > > >=20
>> > > > > > On Fri, 2025-11-28 at 18:25 +0100, Ilya Leoshkevich wrote:
>> > > > > > > On Fri, 2025-11-28 at 14:39 +0100, Thomas Huth wrote:
>> > > > > > > > From: Thomas Huth <thuth@redhat.com>
<snip>
>> > > > > The the async_run_on_cpu is called from the vcpu thread in
>> > > > > response
>> > > > > to a
>> > > > > deterministic event at a known point in time it should be
>> > > > > fine.
>> > > > > If
>> > > > > it
>> > > > > came from another thread that is not synchronised via
>> > > > > replay_lock
>> > > > > then
>> > > > > things will go wrong.
>> > > > >=20
>> > > > > But this is a VM load save helper?
>> > > >=20
>> > > > Yes, and it's called from the main thread. Either during
>> > > > initialization, or as a reaction to GDB packets.
>> > > >=20
>> > > > Here is the call stack:
>> > > >=20
>> > > > =C2=A0 qemu_loadvm_state()
>> > > > =C2=A0=C2=A0=C2=A0 qemu_loadvm_state_main()
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_loadvm_section_start_full()
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vmstate_load()
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vmstate_loa=
d_state()
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 cpu_post_load()
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 tcg_s390_tod_updated()
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 update_ckc_timer()
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 timer_mod()
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s390_tod_lo=
ad()
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 qemu_s390_tod_set()=C2=A0 # via tdc->set()
>> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 async_run_on_cpu(tcg_s390_tod_updated)
>> > > >=20
>> > > > So you think we may have to take the replay lock around
>> > > > load_snapshot()? So that all async_run_on_cpu() calls it makes
>> > > > end
>> > > > up
>> > > > being handled by the vCPU thread deterministically.
<snip>
>> >=20
>> > I believe now I at least understand what the race is about:
>> >=20
>> > - cpu_post_load() fires the TOD timer immediately.
>> >=20
>> > - s390_tod_load() schedules work for firing the TOD timer.
>>=20
>> Is this a duplicate of work then? Could we just rely on one or the
>> other? If you drop the cpu_post_load() tweak then the vmstate load
>> helper should still ensure everything works right?
>
> Getting rid of it fixes the problem and makes sense anyway.
>
>> > - If rr loop sees work and then timer, we get one timer callback.
>> >=20
>> > - If rr loop sees timer and then work, we get two timer callbacks.
>>=20
>> If the timer is armed we should expect at least to execute a few
>> instructions before triggering the timer, unless it was armed ready
>> expired.
>
> Yes, it is armed expired.
>
> Isn't it a deficiency in record-replay that work and timers are not
> ordered relative to each other? Can't it bite us somewhere else?

They normally should be although I notice:

  void icount_handle_deadline(void)
  {
      assert(qemu_in_vcpu_thread());
      int64_t deadline =3D qemu_clock_deadline_ns_all(QEMU_CLOCK_VIRTUAL,
                                                    QEMU_TIMER_ATTR_ALL);

      /*
       * Instructions, interrupts, and exceptions are processed in cpu-exec.
       * Don't interrupt cpu thread, when these events are waiting
       * (i.e., there is no checkpoint)
       */
      if (deadline =3D=3D 0) {
          icount_notify_aio_contexts();
      }
  }

should run the pre-expired timers before we exec the current TB. But the
comment suggests it is not expecting any checkpoint related activity. I
wonder if we can assert that is the case to catch future issues.

>> > - Record and replay may diverge due to this race.
>> >=20
>> > - In this particular case divergence makes rr loop spin: it sees
>> > that
>> > =C2=A0 TOD timer has expired, but cannot invoke its callback, because
>> > there
>> > =C2=A0 is no recorded CHECKPOINT_CLOCK_VIRTUAL.
>> >=20
>> > - The order in which rr loop sees work and timer depends on whether
>> > =C2=A0 and when rr loop wakes up during load_snapshot().
>> >=20
>> > - rr loop may wake up after the main thread kicks the CPU and drops
>> > =C2=A0 the BQL, which may happen if it calls, e.g.,
>> > qemu_cond_wait_bql().

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


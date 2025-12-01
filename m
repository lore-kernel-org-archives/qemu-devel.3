Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D082D116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 10:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ1Gx-0006wU-CY; Mon, 01 Dec 2025 05:36:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vQ1Gw-0006wL-Ac
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 05:36:46 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vQ1Gs-0007n0-9B
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 05:36:46 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so27679775e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 02:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764585400; x=1765190200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mZlxXvrfSJClyWPuc3pE9daHxkFF4SgqcMiy6LS0qjI=;
 b=tWcpjCEkEuKWrKJIcavhot+e/hsy695AyL7Gd/vp2cjiuIaZgzVxcFFnc9OcZCkpt/
 1/+J8kQFXa4U/ORxb/r7OL+m2pngTFqkFtUOHNr9CMwdixzNzF1DPb6lH2um+4/kjZGw
 7UpvfSRMCzhtex98gF9PQbeIX2YgOoPFP+9i7o7qqOHOnCwWMk1GZxbj3Zompd40317M
 Z2zFy4Hv4MiGt4C2hEZJ2SxzxCoAoe4agceBO+IljBApqvzAtKlwqi/aFE1kWWGOPDYY
 bqVq90/n84cZeSVCM2t3P7vlZyACTcFy+gd0JBE14xa2tR8EnefjU1UfqJlJE/lWGlh/
 KJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764585400; x=1765190200;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mZlxXvrfSJClyWPuc3pE9daHxkFF4SgqcMiy6LS0qjI=;
 b=nusBnLyHKf4aPVJkRJQc2ZXMrD755lsrGz3cA88OLda1sqfkuwzmYe703YnXCM6Xjo
 PCs0/odjcEbSN6J39SiSQhQLVy4Y2QSM/N5yO3ndB8QQjVqd8YX22dvgqxWk9rMyNo+8
 Mo/ZXp0d8rcOIMAKdPtz9LZwviFpXj3N7kX+F8K7Gv1xxBuUJ/AqhAjN9PVaNGDofgMd
 9ldbBhJQLMzEBYbI0H58wkfO/oq21tWsODgoP+G8aZmgiEAMVRHIKrk1x2roX7Bg6XT7
 fhthnM5GGlLgO+O+KEQYI9ZVF0Z5uST9kwVRF1d4savvQQezv14fMPkTqYoC7psz+QZg
 cO5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSnyp3Jakolnbc5WxbM0kQMCDmv2Iii95jmWxNiP2gJxNU7zZylRTzfglzxU7344vH17M/oYNSfqoM@nongnu.org
X-Gm-Message-State: AOJu0Yx74li/W6+cgftfKvNg706CRAfyHhGIRruatT7MRLvsp63Y8B3A
 A5MpaloqFiJCbVqUxmhK2f2bz+8bq7SlBmTAXobC+da/95BQxkeTEBTpeLIiAO9Zfok2p9u7ZZs
 MjDVK
X-Gm-Gg: ASbGncufbkTxhfc/fwDj1+6TNM4xQXVP5t+zYKj/5tVr3pLppDMfbjRQdfaPbybKpUk
 G6NzRuZv3trvsYYT4MtM/ibi93ILjqH+asE7HN/IpfeQblzhl/WWEE19HFCA0i53rTZXzDS7lqx
 K34IwnZ1hcCm/L0AU6lYvAB4u4kXuJXqc6V4K77q+kf3OPjqX2OYWN76RgmRnVzj9hUMCAtIzPF
 BGhef7hvvXBXNE/8K5rsn9yGnKz77JUAwUM/gXgtIHNAmNGEwP9ESFPGdPMOcTsl1RYXCeWNzU7
 sRwPU4tKDRLrKZ+F9TKQ4DlOe3ShLwVItOZ+fT6WBoKGGBhRFSssiloEuZwjS+MDwx1AVl6/uDa
 /dG+ArPs1WodBGR715hzffG5E+UJkVt9Old6JxJ0BCND+wvZk+BfQmbdJt5153Kx6r2lnuzpgL6
 Q6pY5UxEmbccM=
X-Google-Smtp-Source: AGHT+IEPqx9qvPTIqglMI4ulT1mjHrAdKY1ma1cpDu5bneyd+E20i/yCxLELCBnY0Wj30ZwZCVV6cA==
X-Received: by 2002:a05:600c:4f82:b0:477:952d:fc11 with SMTP id
 5b1f17b1804b1-477c11175a9mr448503265e9.16.1764585399967; 
 Mon, 01 Dec 2025 02:36:39 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790ade13ddsm293712485e9.8.2025.12.01.02.36.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 02:36:39 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 582485F80B;
 Mon, 01 Dec 2025 10:36:38 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Thomas Huth <thuth@redhat.com>,  qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
Subject: Re: [RFC PATCH] tests/functional/s390x: Add reverse debugging test
 for s390x
In-Reply-To: <6181bc6bd6b41f46a835cee58ab3215b8cefedb4.camel@linux.ibm.com>
 (Ilya Leoshkevich's message of "Sun, 30 Nov 2025 23:59:48 +0100")
References: <20251128133949.181828-1-thuth@redhat.com>
 <37260d74733d7631698dd9d1dc41a991b1248d3a.camel@linux.ibm.com>
 <8efd73b100f7e78b1a5bbbe89bc221397a0a115a.camel@linux.ibm.com>
 <87zf838o2w.fsf@draig.linaro.org>
 <4bf61173827c033f9591f637f83d1aedc056a51e.camel@linux.ibm.com>
 <dfc4b7b2bdb7a6678364516de03a23959965de1e.camel@linux.ibm.com>
 <6181bc6bd6b41f46a835cee58ab3215b8cefedb4.camel@linux.ibm.com>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Mon, 01 Dec 2025 10:36:38 +0000
Message-ID: <87ldjmv689.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

> On Sun, 2025-11-30 at 20:03 +0100, Ilya Leoshkevich wrote:
>> On Sun, 2025-11-30 at 19:32 +0100, Ilya Leoshkevich wrote:
>> > On Sun, 2025-11-30 at 16:47 +0000, Alex Benn=C3=A9e wrote:
>> > > Ilya Leoshkevich <iii@linux.ibm.com> writes:
>> > >=20
>> > > > On Fri, 2025-11-28 at 18:25 +0100, Ilya Leoshkevich wrote:
>> > > > > On Fri, 2025-11-28 at 14:39 +0100, Thomas Huth wrote:
>> > > > > > From: Thomas Huth <thuth@redhat.com>
>> > > > > >=20
>> > > > > > We just have to make sure that we can set the endianness to
>> > > > > > big
>> > > > > > endian,
>> > > > > > then we can also run this test on s390x.
>> > > > > >=20
>> > > > > > Signed-off-by: Thomas Huth <thuth@redhat.com>
>> > > > > > ---
>> > > > > > =C2=A0Marked as RFC since it depends on the fix for this bug (=
so
>> > > > > > it
>> > > > > > cannot
>> > > > > > =C2=A0be merged yet):
>> > > > > > =C2=A0
>> > > > > > https://lore.kernel.org/qemu-devel/a0accce9-6042-4a7b-a7c7-218=
212818891@redhat.com
>> > > > > > /
>> > > > > >=20
>> > > > > > =C2=A0tests/functional/reverse_debugging.py=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 +++-
>> > > > > > =C2=A0tests/functional/s390x/meson.build=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>> > > > > > =C2=A0tests/functional/s390x/test_reverse_debug.py | 21
>> > > > > > ++++++++++++++++++++
>> > > > > > =C2=A03 files changed, 25 insertions(+), 1 deletion(-)
>> > > > > > =C2=A0create mode 100755
>> > > > > > tests/functional/s390x/test_reverse_debug.py
>> > > > >=20
>> > > > > Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
>> > > > >=20
>> > > > >=20
>> > > > > I have a simple fix which helps with your original report,
>> > > > > but
>> > > > > not
>> > > > > with this test. I'm still investigating.
>> > > > >=20
>> > > > > --- a/target/s390x/machine.c
>> > > > > +++ b/target/s390x/machine.c
>> > > > > @@ -52,6 +52,14 @@ static int cpu_pre_save(void *opaque)
>> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kvm_s390_vcpu_i=
nterrupt_pre_save(cpu);
>> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 }
>> > > > > =C2=A0
>> > > > > +=C2=A0=C2=A0=C2=A0 if (tcg_enabled()) {
>> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Ensure symme=
try with cpu_post_load() with respect
>> > > > > to
>> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * CHECKPOINT_C=
LOCK_VIRTUAL.
>> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tcg_s390_tod_updated=
(CPU(cpu), RUN_ON_CPU_NULL);
>> > > > > +=C2=A0=C2=A0=C2=A0 }
>> > > > > +
>> > > > > =C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> > > > > =C2=A0}
>> > > >=20
>> > > > Interestingly enough, this patch fails only under load, e.g.,
>> > > > if
>> > > > I
>> > > > run
>> > > > make check -j"$(nproc)" or if I run your test in isolation, but
>> > > > with
>> > > > stress-ng cpu in background. The culprit appears to be:
>> > > >=20
>> > > > s390_tod_load()
>> > > > =C2=A0 qemu_s390_tod_set()
>> > > > =C2=A0=C2=A0=C2=A0 async_run_on_cpu(tcg_s390_tod_updated)
>> > > >=20
>> > > > Depending on the system load, this additional
>> > > > tcg_s390_tod_updated()
>> > > > may or may not end up being called during handle_backward(). If
>> > > > it
>> > > > does, we get an infinite loop again, because now we need two
>> > > > checkpoints.
>> > > >=20
>> > > > I have a feeling that this code may be violating some record-
>> > > > replay
>> > > > requirement, but I can't quite put my finger on it. For
>> > > > example,
>> > > > async_run_on_cpu() does not sound like something deterministic,
>> > > > but
>> > > > then again it just queues work for rr_cpu_thread_fn(), which is
>> > > > supposed to be deterministic.
>> > >=20
>> > > The the async_run_on_cpu is called from the vcpu thread in
>> > > response
>> > > to a
>> > > deterministic event at a known point in time it should be fine.
>> > > If
>> > > it
>> > > came from another thread that is not synchronised via replay_lock
>> > > then
>> > > things will go wrong.
>> > >=20
>> > > But this is a VM load save helper?
>> >=20
>> > Yes, and it's called from the main thread. Either during
>> > initialization, or as a reaction to GDB packets.
>> >=20
>> > Here is the call stack:
>> >=20
>> > =C2=A0 qemu_loadvm_state()
>> > =C2=A0=C2=A0=C2=A0 qemu_loadvm_state_main()
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_loadvm_section_start_full()
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vmstate_load()
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vmstate_load_st=
ate()
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu=
_post_load()
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 tcg_s390_tod_updated()
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 update_ckc_timer()
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 timer_mod()
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s390_tod_load()
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qem=
u_s390_tod_set()=C2=A0 # via tdc->set()
>> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 async_run_on_cpu(tcg_s390_tod_updated)
>> >=20
>> > So you think we may have to take the replay lock around
>> > load_snapshot()? So that all async_run_on_cpu() calls it makes end
>> > up
>> > being handled by the vCPU thread deterministically.
>>=20
>> To answer my own question: apparently this is already the case; at
>> least, the following does not cause any fallout:
>>=20
>> diff --git a/include/system/replay.h b/include/system/replay.h
>> index 6859df09580..e1cd9b2f900 100644
>> --- a/include/system/replay.h
>> +++ b/include/system/replay.h
>> @@ -60,6 +60,7 @@ extern char *replay_snapshot;
>> =C2=A0
>> =C2=A0void replay_mutex_lock(void);
>> =C2=A0void replay_mutex_unlock(void);
>> +bool replay_mutex_locked(void);
>> =C2=A0
>> =C2=A0static inline void replay_unlock_guard(void *unused)
>> =C2=A0{
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index 62cc2ce25cb..ba945d3a1ea 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -3199,6 +3199,8 @@ bool save_snapshot(const char *name, bool
>> overwrite, const char *vmstate,
>> =C2=A0=C2=A0=C2=A0=C2=A0 uint64_t vm_state_size;
>> =C2=A0=C2=A0=C2=A0=C2=A0 g_autoptr(GDateTime) now =3D g_date_time_new_no=
w_local();
>> =C2=A0
>> +=C2=A0=C2=A0=C2=A0 g_assert(replay_mutex_locked());
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0 GLOBAL_STATE_CODE();
>> =C2=A0
>> =C2=A0=C2=A0=C2=A0=C2=A0 if (!migrate_can_snapshot(errp)) {
>> @@ -3390,6 +3392,8 @@ bool load_snapshot(const char *name, const char
>> *vmstate,
>> =C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0 MigrationIncomingState *mis =3D migration_incom=
ing_get_current();
>> =C2=A0
>> +=C2=A0=C2=A0=C2=A0 g_assert(replay_mutex_locked());
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0 if (!migrate_can_snapshot(errp)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>> diff --git a/replay/replay-internal.h b/replay/replay-internal.h
>> index 75249b76936..30825a0753e 100644
>> --- a/replay/replay-internal.h
>> +++ b/replay/replay-internal.h
>> @@ -124,7 +124,6 @@ void replay_get_array_alloc(uint8_t **buf, size_t
>> *size);
>> =C2=A0 * synchronisation between vCPU and main-loop threads. */
>> =C2=A0
>> =C2=A0void replay_mutex_init(void);
>> -bool replay_mutex_locked(void);
>> =C2=A0
>> =C2=A0/*! Checks error status of the file. */
>> =C2=A0void replay_check_error(void);
>
> I believe now I at least understand what the race is about:
>
> - cpu_post_load() fires the TOD timer immediately.
>
> - s390_tod_load() schedules work for firing the TOD timer.

Is this a duplicate of work then? Could we just rely on one or the
other? If you drop the cpu_post_load() tweak then the vmstate load
helper should still ensure everything works right?

> - If rr loop sees work and then timer, we get one timer callback.
>
> - If rr loop sees timer and then work, we get two timer callbacks.

If the timer is armed we should expect at least to execute a few
instructions before triggering the timer, unless it was armed ready
expired.=20

> - Record and replay may diverge due to this race.
>
> - In this particular case divergence makes rr loop spin: it sees that
>   TOD timer has expired, but cannot invoke its callback, because there
>   is no recorded CHECKPOINT_CLOCK_VIRTUAL.
>
> - The order in which rr loop sees work and timer depends on whether
>   and when rr loop wakes up during load_snapshot().
>
> - rr loop may wake up after the main thread kicks the CPU and drops
>   the BQL, which may happen if it calls, e.g., qemu_cond_wait_bql().

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


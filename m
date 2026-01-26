Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B09D19502
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 16:31:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkPUZ-0005Sm-2e; Mon, 26 Jan 2026 11:31:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vkPUU-0005Ou-9j
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 11:31:03 -0500
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vkPUS-0002rl-Ew
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 11:31:01 -0500
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-6496b6903c9so1543657d50.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 08:30:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769445059; cv=none;
 d=google.com; s=arc-20240605;
 b=ScVEeX+A2vvM3+K/inc3fuVemX2neLtFGSXNjfgwgflJhs1VnF2YxdBpguxGIFumrk
 jDgDencsiauFH+av50VvKbXb4jf2tmxZIQQ4htAKPlCWmXRbEyxGfkYqRGntjQvSdAFX
 LANcne7jISIOAy55ABfSyaHInPp+sFC0Y2PwQyyiLN8QawSDz9byG+eW1ZwbeH5da3P2
 m9mdzp7s0A1aWiI0y9TyhZ1vizpnnLU/h5rfNbT2t9ndSRDNDldkHzrC0pzSRor3NfnT
 MjKLPKqL+YXQ3FHrmfx8EKsbiFayUb2F31JpO32apnT+BEdAkX6EHLRaNbE0EqNa6lLj
 giSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SJdN8YqOKVZnoH45L7Yca+qemo5Cv3GF9Wlj1rml74Q=;
 fh=WmfeiV+KUQ1s2JsGrYuD8oSZodfTC6aOTSis/ROTgCQ=;
 b=KxktIWDpLwE2ABBWTho/Ejm2IWO9tDisRXa52tt0M2TdvKfZ9PTt4M+yFaj5Xd5Wio
 o0yTBjmkEVLg7HdAWiRw648euiN13j58tq8ONTfPePSi9wJQ7HZS5aX4MTkS2raa4llG
 RUZgVO9gBWqxX0QR7wE8GLIFHAb9GReW22ikVJylqxRpsyfEosmaMJZYrBXTs6w1KrTt
 DySZzmJ0ACelQaiWJWLh26EmZykMrcWR0Ch7kkvImpbRkcO4duwMuNaIKDsdzHQ+qGRD
 HhFWx1+6NOgYk6jCQQJ0H7mBr8YUPImHnOqBm1BjF8EeMJqcvqx0QcxZtXjQ+byqg0YH
 1uRw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769445059; x=1770049859; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SJdN8YqOKVZnoH45L7Yca+qemo5Cv3GF9Wlj1rml74Q=;
 b=Q+pbtP12o8pxL9qv1HVdgYZB2U1qRkb15e/9JgNs0HBCKWie1NqxGelB090gOS6QbY
 CUYp+Bl4BNRGTDtmIkxp+nRQR6ni/urWXhIK4OExMwGUAres+rDRkf+U8WCjeBkjWiAp
 PwP//0d4ZKlrA3Mv3bW61D7ji3pzZXxAiojPJkXQvv8c5+X3EIyX078aAKB0xqKRWOg+
 bQteVE/aQeZs8ypaJsLKc3if5DWrpD/xVWosZR9LsQDlG8m/BNVCmlxq87HoIUJNuq5I
 p4yQYV+OJa+Px6aw0//kQMvm3SVPjxxcGkcmPmCmLqYzim2xdDef8jRCp/GTtDXPTnZW
 Z+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769445059; x=1770049859;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SJdN8YqOKVZnoH45L7Yca+qemo5Cv3GF9Wlj1rml74Q=;
 b=hhBFfMwtmolNskQGG9GKTTXgeSGVB1vPepU6kFOpLnYpHKcPzX39OoCoZ4eoO+iXkK
 N3mu+IW3lcypPf2YmZIoVpezCSrt41/qxuQxRfHmKLVEIR6YNnFFLTTLxxvpScANqUXI
 U+K1Yxp2ceNRTKoNpAa+AUEIeL/AYQHYzxT+HmqphLxr3OzekehHB0fKIBn/JCKcdbAi
 fQAywWwH0faYQmn0g6FeFtJH4G0HusaXiVc6Y/T1o8kYuKbpbVg68yCLInPhOG3YGSZ0
 b5V2o4/sYNJifVlCy3LET5pgBOiAJLI6xf2WxLa5Z/bwCbhTBBiAqF4GKD12fj+Reul+
 FzRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGMRH7vEQu+0QkcZ7J8msTaFKG4Fiiad1yzZNZJLom+zXxgP9dC3YdwjDz509s9wB3r+zppWz5hxA5@nongnu.org
X-Gm-Message-State: AOJu0Yz3amstQSo4H41Gu6kH6g9xmoEaDXpsWTSpM2HBaqaH6iqfN09b
 mtRqvfE5I7DmesqeqZkx1vlT5gO4ztx0rz9XEHlzFZqZLJfGHTl4JOzfXSIRl5D0HDp0NXWmBVW
 WPiLFGUAT8wdgWcWbtP8Li/C9FRgq3G9dglN0bxeXvg==
X-Gm-Gg: AZuq6aL//0hAnEKlSJ+0+Cd6XmF706hsxQ71pMjMp15PHFPgcpFsrnQdLOP0tt3xj7Z
 IrI5/EMUGGLbFS+uU2s7foVKYj/yhzyMr5oYGJkCiDrvSsihi4VHDvT/LmY/0s5Hgt0iXCw+SLd
 X+1oq5VPtshulpowg1XRUYtBV9BMwQfY47ikYvE44+FR84kjPDJN6ZagI0sj3yyDuZbDTLWFdJG
 Ziuv1a3bWv01yoNecqsQfzFaavrtmclK91Ay8+t901j2h01vU0BB7P8kZ0VYRDEjLwoXQ==
X-Received: by 2002:a05:690e:1906:b0:640:cc09:b7c8 with SMTP id
 956f58d0204a3-64970bc55e0mr3166942d50.23.1769445058838; Mon, 26 Jan 2026
 08:30:58 -0800 (PST)
MIME-Version: 1.0
References: <20260126151612.2176451-1-sergeev0xef@gmail.com>
 <87a4y0e58a.fsf@draig.linaro.org>
In-Reply-To: <87a4y0e58a.fsf@draig.linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Jan 2026 16:30:47 +0000
X-Gm-Features: AZwV_QginKckNUGGEgDh-a-DtHsfobiM_6H392CnSQPTs1zNvQUMIwpNVoJtW1E
Message-ID: <CAFEAcA-=zZO=Gq8gmDEBvnaxLJ3k9YpB+o-A7V3WxxQJPrJiXg@mail.gmail.com>
Subject: Re: [PATCH] linux-user/syscall.c: Prevent acquiring clone_lock while
 fork()
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Aleksandr Sergeev <sergeev0xef@gmail.com>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, 26 Jan 2026 at 16:02, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Aleksandr Sergeev <sergeev0xef@gmail.com> writes:
>
> (Adding Paolo/Richard to Cc for exclusive discussion)
>
> > By the spec, fork() copies only the thread which executes it.
> > So it may happen, what while one thread is doing a fork,
> > another thread is holding `clone_lock` mutex
> > (e.g. doing a `fork()` or `exit()`).
> > So the child process is born with the mutex being held,
> > and there are nobody to release it.
> >
> > As the thread executing do_syscall() is not considered running,
> > start_exclusive() does not protect us from the case.

> >
> > +void clone_fork_start(void)
> > +{
> > +    pthread_mutex_lock(&clone_lock);
> > +}
> > +
> > +void clone_fork_end(bool child)
> > +{
> > +    if (child) {
> > +        pthread_mutex_init(&clone_lock, NULL);
> > +    } else {
> > +        pthread_mutex_unlock(&clone_lock);
> > +    }
> > +}
> > +
>
> This looks like it should just be open-coded in the:
>
>   if (flags & CLONE_VM) {
>
>   }
>
> leg of do_fork()?
>
> Or maybe I'm missing the subtly of the race condition?

It's a general thing with fork() -- we need to make sure
we hold all the mutexes in QEMU before forking, so that when
we do the fork we know the state of the data structures they
are protecting. Then after the fork the parent unlocks the
mutexes again and the child can re-init the mutex.

We don't want to open-code this because there are quite a
lot of things to handle and do_fork() isalready pretty long
and complicated. Instead we have the fork_start() and fork_end()
functions which sequence all the things that need to be handled
across the fork, including the mutex lock/unlock stuff.

I think this patch is doing it the right way, by adding this
mutex to the set of things to be handled across fork. Compare
mmap_fork_start() and mmap_fork_end() which do this for the
mmap_mutex.

-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89D9C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 13:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuWg5-0004mg-9D; Tue, 18 Mar 2025 09:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuWeQ-00047L-N9
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 09:06:38 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuWeM-0002od-Gs
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 09:06:34 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e63fd2b482fso3027603276.1
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 06:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742303189; x=1742907989; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eGksSTVfy7WjzZQYLzF7BMNJCa7dIK/nHc2HlgEHelw=;
 b=ESFcLDrUiowDnpj+cAd7NW5Os3bRml311R0qKEMt9zo/X/jkQWJ1g6CpGAfzSrHjm4
 dkhAKyaGepFZI3EWvKZ3zsEzrt+9/dnv8DAi/gCr2ZFIzp9RXmVA2dN9gqSlKKdPR0Ye
 Zp648WULF0qYdacQy4eCSojp/K3WsyUOQCQOLuyolSHMlrhU6uULbAy2ESrK41dFXGhu
 Q737ngA2S8slJeFZHmgwNnIA/fbIMAaQT0oPptzkNhzuLzKCmd1yT5ZuZElRP3GN8cuJ
 B28FJy4koPMfH8MBNfAkSFfG2MCf4+Rq3b6dhxiYRfVFxycvT86EcAuf+Tjvx+G/xbtE
 iVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742303189; x=1742907989;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eGksSTVfy7WjzZQYLzF7BMNJCa7dIK/nHc2HlgEHelw=;
 b=KVrO1tz88Jzp/d7ANSMe9LXzQix6agKEki9TWEmUU0X1QxTIliEWIMyJFSQZQ8ey/e
 PRSYd2a/DAAlLtTvIT1IfQgUl3zA3T2bUg3nqAHCgdy/2vAamvc+qHBCqj5KMdkeq27o
 8K7SWAL48J9+kDWFanHS1bDt/NM+xpQc5RPjTzsgCieHqbmzmGPJPvGC/XvXbvOVqYhz
 AU3byMjkvQPC4TVX6jS4pUn0paei9quGaXIMlL+c4dWsTatd9uR+DuP0PNM8rUgmb0eA
 Yyx2+IVmbL4VHLFCES8vrkcKKlWJpjUNCwqPUAKOmcBVIVJkdbNVNVVFpMV0lP1oCgpR
 DkaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaXIUNWOTYcqofI3XZ+k74K0sUnWdMvmxS+JKJ2oFK1Mhr9rOoMiLmdFaO6j3DG8sh1jthCdKnHOqL@nongnu.org
X-Gm-Message-State: AOJu0YwDBL/LmNXZFBXOJwwEjNFOEwRpRbFtBoOCGOSL+TgUOKxyz6tw
 k+fRnzPkOU4pJg7ATTFqWqTVGprYj5qVwK2Q7nc1rNrKl7z+8WVBCuPZMJ6jYDHIrGAeE5ZRRQv
 az64sYDYGEupBhnVbLPyYYnlg1IAKcs+fNXop3A==
X-Gm-Gg: ASbGnctXUajiWUAdOHmo/5R+7MqSQTfDLAdATh0b0KT/pKvD997C7widWsrAXxSfiyS
 juqPRHkbcIX35Id0QxBRRnP+Pd2BS38yUUIHgGetIa5cuzavy8TAIlAnvY1IxjRdm8iABA7C3Ab
 IsHMSOYGxiKdQHPNYVeFAKTgJ6JJE=
X-Google-Smtp-Source: AGHT+IH7jrUQ5Gb1Os1rJ69sZ7iZZPI55m4Q4NrNNbXnWP40kyZCtn8BX7qg+8anhLeC/GLWL3QzRPVVzO2CXd2BtYY=
X-Received: by 2002:a05:6902:2602:b0:e58:3209:bdb6 with SMTP id
 3f1490d57ef6-e63f64f7c69mr19518519276.16.1742303189277; Tue, 18 Mar 2025
 06:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <mvm1puuiqvu.fsf@suse.de>
 <ff0cde0c-67d7-4fc3-8996-ad0e8645deed@gmx.de>
 <CAFEAcA_-fODgkxLLCNf3XHBU=EvGgKx4qcE_PqNt8-4jwqnqVw@mail.gmail.com>
 <Z9lf7lniMWzoy6uS@redhat.com> <mvmmsdih5zi.fsf@suse.de>
 <Z9lqcQGdIsjUHeVJ@redhat.com>
In-Reply-To: <Z9lqcQGdIsjUHeVJ@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Mar 2025 13:06:17 +0000
X-Gm-Features: AQ5f1Jp_WIYvjcjhL-opQ7B_nxADRvUnindXZMVM_ZeZ1kLCcyhFTRaLA32yAJ0
Message-ID: <CAFEAcA9r0GKWG2_w20HxbXz+MhdsraxCa=RvzaVYO+gd2DEY4Q@mail.gmail.com>
Subject: Re: Generic way to detect qemu linux-user emulation
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Andreas Schwab <schwab@suse.de>, Helge Deller <deller@gmx.de>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
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

On Tue, 18 Mar 2025 at 12:43, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Tue, Mar 18, 2025 at 01:34:57PM +0100, Andreas Schwab wrote:
> > On M=C3=A4r 18 2025, Daniel P. Berrang=C3=A9 wrote:
> >
> > > Whereever practical, it is preferrable to check a discrete feature
> > > or behaviour in a functional way, rather than matching on "is it QEMU=
"
> >
> > Do you know a way to detect support for CLONE_VFORK that isn't too
> > expensive?
>
> No, but I feel like the right thing in this particular case is to look
> at improving our vfork impl. The current impl is incredibly crude and
> acknowledged by the original author
>
>   commit 436d124b7d538b1fd9cf72edf17770664c309856
>   Author: Andrzej Zaborowski <balrogg@gmail.com>
>   Date:   Sun Sep 21 02:39:45 2008 +0000
>
>     Band-aid vfork() emulation (Kirill Shutemov).
>
> I can see why they did it that way, but I'm feeling like it ought to
> be possible to do a better special case vfork impl ni QEMU instead of
> overloading the fork() impl.

The difficulty with vfork() (and, more generally, with various of
the clone() syscall flag combinations) is that because we use the
host libc we are restricted to the thread/process creation options
that that libc permits: which is only fork() and pthread_create().
vfork() wants "create a new process like fork with its own file
descriptors, signal handlers, etc, but share all the memory space with
the parent", and the host libc just doesn't provide us with the tools
to do that. (We can't call the host vfork() because we wouldn't be
abiding by the rules it imposes, like "don't return from the function
that called vfork".)

If we were implemented as a usermode emulator that sat on the raw
kernel syscalls, we could directly call the clone syscall and
use that to provide at least a wider range of the possible clone
flag options; but our dependency on libc means we have to avoid
doing things that would confuse it.

For vfork in particular, we could I guess do something like:
 * use real fork() to create child process
 * parent process arranges to wait until child process exits
   (via waitpid or equivalent) or it tells us it's about to exec
 * we make all the guest memory be mapped read-only in the child
   process, so we can trap writes and tell the parent about them
   so it can update its copy of the memory.
   (Sadly since we can't guaranteedly get control on termination
   events for the child before it really terminates, we can't
   do this memory-transfer in bulk at the end; otherwise we'd
   behave wrongly for the "child process gets SIGKILLed" case.)

Historically we've preferred to go for "assume that guests
will only want the looser POSIX semantics of vfork(), not the
tighter ones of the actual Linux syscall", but unfortunately
glibc has gone for the latter.

thanks
-- PMM


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD98C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 15:05:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuYVB-0006Mb-E3; Tue, 18 Mar 2025 11:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuYV8-0006KF-No
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 11:05:06 -0400
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuYV6-0004zE-Ig
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 11:05:06 -0400
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e60cab0f287so4273760276.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 08:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742310303; x=1742915103; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vPvgihXeVb6DJ2+Vf5DBg9W1O5rqPoiqUhI5UwUdzMg=;
 b=JP1TzeE6P5wnkd8biZbnsZpvBHaz3khlm7s30gRPA103AjwJKCNhHsTjzVSKo0y3GK
 RKNRTvi7gGuJe4O7r4n34Mu3KrHZibYlWiYuUVnYnrkr8BjhzgaTkUwsP5WFvg61SWVr
 kORJKfS7qlRCI9Oamecog2xMUzMQDH7jX4aJW4ywIBYkeNHDOB7Fo8t9vE1cGWKS/z1z
 JpFoA1y0+UKTmN4lA1KS6UGJdb08FNltdeW1jpSVOx1EJST4TgNiILbrXoc/Fdlrl/aS
 u1rHtRkEprxubOcNx7PBiIvDokBWS8FWXkvOqCOhIJOiTdusHXMIO/Claiml7bs4bE1M
 +6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742310303; x=1742915103;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vPvgihXeVb6DJ2+Vf5DBg9W1O5rqPoiqUhI5UwUdzMg=;
 b=dN5SQQqWeKrz1j7kGIhCqWyJT3Gk/LQTYrv0HbKKgvD3kW5S8DK3EGWXdEot6Oovne
 8VqCTACvr0okylN0uMheRCj3R+KFbxHc4mVrYj3R8gBsQiWVkGkrRLIFDtBhQlHKWH9M
 eyqFAUly19vTZUbOStHChuO4KetysrvwwiG6oVcq1PXwnsE/Txmom3mmUYWTR98ZyZrJ
 EOBO7ykZSYyM4lCveA1QpokSJcgxD3qMbp9JNWQ4+8+9qNkEEtq8uLp6739FpIdoakqf
 9px84jdOR+IdAGvTlP7agp07fd/shRFsEY3SXlowHB9Na5TvSwYI8Mf+hFrPLwSe+vU+
 rUBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVSEKuUZRF8cokiiuJjCcxxVnYu6TvrO8nzwKXqoILA+sMer05xCIlIfUBig4SeUbqkemcV0k7EMLp@nongnu.org
X-Gm-Message-State: AOJu0Yyu+MC+dHOQ0g8EMdailsbcPlaBR9oIMRf1uuot72tGxSQJWn9P
 eTdU/aCA2yK4pJ9o47UyMIaG3WX6e1Zki4RDXPe47afC2Pic+mEGRwJfoPm399M3GvGcSqmOJCS
 +5JD3RJ6ikXti0qUIC8is6e98509gE6+kmLlOag==
X-Gm-Gg: ASbGncs2qrgn4XV8JXpnX579/S58gal57YGGSaM8cwlqZoH7i8CM1EI/I98jtwO/PLi
 DxR9qoTUON/oVZnHd5ihMBRCYaPhD9aaRfO1XC5vtFJw2JUx3WRPNVjykFbZ5Ti2wKoAdmHI4Gz
 SxUfp+3Y+IW2S470UCmqlQoMKwP5M=
X-Google-Smtp-Source: AGHT+IHEQFcNpboNI6rwvt2KNDIswAMBpS0riF11Rku9DJD1N2bR4AQ9KThPZo1voHvsamWNmVjWxpVAZ5jxr3YYOuE=
X-Received: by 2002:a05:6902:6c1a:b0:e64:f4c7:36d1 with SMTP id
 3f1490d57ef6-e64f4c739f4mr4652498276.8.1742310303194; Tue, 18 Mar 2025
 08:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <mvm1puuiqvu.fsf@suse.de>
 <ff0cde0c-67d7-4fc3-8996-ad0e8645deed@gmx.de>
 <CAFEAcA_-fODgkxLLCNf3XHBU=EvGgKx4qcE_PqNt8-4jwqnqVw@mail.gmail.com>
 <Z9lf7lniMWzoy6uS@redhat.com> <mvmmsdih5zi.fsf@suse.de>
 <Z9lqcQGdIsjUHeVJ@redhat.com>
 <CAFEAcA9r0GKWG2_w20HxbXz+MhdsraxCa=RvzaVYO+gd2DEY4Q@mail.gmail.com>
 <Z9l7J0oZ8GAEqaMP@redhat.com>
In-Reply-To: <Z9l7J0oZ8GAEqaMP@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Mar 2025 15:04:51 +0000
X-Gm-Features: AQ5f1JonxKQzpj4wcbFM8yEf3SdvjPu3pRQl1ZueEJaDVhTkRTnHNiqwiEG6aDw
Message-ID: <CAFEAcA_ZBz3yvUYo5WhqmKRqCm+Jy1R01pshtU0NPRzzbP4hYQ@mail.gmail.com>
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

On Tue, 18 Mar 2025 at 13:55, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Tue, Mar 18, 2025 at 01:06:17PM +0000, Peter Maydell wrote:
> > The difficulty with vfork() (and, more generally, with various of
> > the clone() syscall flag combinations) is that because we use the
> > host libc we are restricted to the thread/process creation options
> > that that libc permits: which is only fork() and pthread_create().
> > vfork() wants "create a new process like fork with its own file
> > descriptors, signal handlers, etc, but share all the memory space with
> > the parent", and the host libc just doesn't provide us with the tools
> > to do that. (We can't call the host vfork() because we wouldn't be
> > abiding by the rules it imposes, like "don't return from the function
> > that called vfork".)
> >
> > If we were implemented as a usermode emulator that sat on the raw
> > kernel syscalls, we could directly call the clone syscall and
> > use that to provide at least a wider range of the possible clone
> > flag options; but our dependency on libc means we have to avoid
> > doing things that would confuse it.
>
> I guess I'm not seeing how libc is blocking us in this respect ?
> The clone() syscall wrapper is exposed by glibc at least, and it
> is possible to call it, albeit with some caveats that we might
> miss any logic glibc has around its fork() wrapper. The spec
> requires that any child must immediately call execve after vfrok
> so I'm wondering just what risk of confusion we would have in
> practice ?

I think my notes about clone are a red herring for vfork
specifically. For vfork in the child, the vfork spec requires
a very minimal amount of stuff to happen in the child, but QEMU's
own TCG data structures and calls and processes mean that we
will be doing a lot more than the guest does. For instance,
we need to return from the function that called vfork, so we
can continue to execute the guest code. And the guest code will
likely call into the translator to generate more code, which will
(a) mess up the TCG data structures for the parent and (b)
probably result in our calling into libc functions that aren't
OK to call.

More generally, AIUI glibc expects that it has control over what's
happening with threads, so it can set up its own data structures
for the new thread (e.g. for TLS variables). This email from the
glibc mailing list is admittedly now two decades old
https://public-inbox.org/libc-alpha/200408042007.i74K7ZOr025380@magilla.sf.=
frob.com/
but it says:

# Basically, if you want to call libc functions you should do it from a
# thread that was set up by libc or libpthread.  i.e., if you make your own
# threads with clone, only call libc functions from the initial thread.

> > For vfork in particular, we could I guess do something like:
> >  * use real fork() to create child process
> >  * parent process arranges to wait until child process exits
> >    (via waitpid or equivalent) or it tells us it's about to exec
> >  * we make all the guest memory be mapped read-only in the child
> >    process, so we can trap writes and tell the parent about them
> >    so it can update its copy of the memory.
> >    (Sadly since we can't guaranteedly get control on termination
> >    events for the child before it really terminates, we can't
> >    do this memory-transfer in bulk at the end; otherwise we'd
> >    behave wrongly for the "child process gets SIGKILLed" case.)
>
> That would get the synchronization behaviour of Linux vfork,
> but I'm not sure it'd get the performance benefits (of avoiding
> page table copying) which is what  Andreas mentioned as the
> desired thing ?

The problem is that the guest glibc is using CLONE_VFORK in
a particular way for performance reasons on real hardware,
which is valid for real kernel CLONE_VFORK but which our
lack of accuracy in emulation means we mishandle, causing the
guest to fall over. The actual performance under QEMU isn't
important.

thanks
-- PMM


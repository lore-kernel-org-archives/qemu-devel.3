Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73009CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 09:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNIK-0001Mg-Ku; Mon, 11 May 2026 05:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMNEw-0006yh-Pb
 for qemu-devel@nongnu.org; Mon, 11 May 2026 05:48:17 -0400
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMNEk-00033Q-9d
 for qemu-devel@nongnu.org; Mon, 11 May 2026 05:47:47 -0400
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-8eae9229110so564341385a.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 02:47:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778492846; cv=none;
 d=google.com; s=arc-20240605;
 b=CfG1JlhJcsxpuXssES+nEQ21Evo9XRPXFZCO8GAmIipgXSLY5tNX0yxERrKdUby/+i
 rMKyvRjhfMxRH/fJfO5B6h2W+xJIP1pDZ7cnlhbYCvV/PSRBf0MKXksWv7gv/ZFTzxbw
 XYOk0Eet4BEDOadfYjE4DA/5crjaolbhOl1ylhLsLHGIxe7Fz+Wt9gCbkqHW5F6xUgvr
 av045Ylju0ULDnSfP371Av7yTeKUTg/GlaEsDCMJmsZpsSQbosaWAR5RV7/M9XkMJVrI
 OgOytb2NSXpjWp68se+eBh5Dg9w+OHtxfntqh9nDtFNyC3HhLZQQ1tqJm6+ysTri1XG5
 JZYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xQ1O+ps8z8uEjDF8fBKbjDNQ0AqBSMl70cByDxM9fpc=;
 fh=Ztr7sPMFmI7SIAvjOSfQTAI+Xa5W8NfEcl3+dQJ3000=;
 b=c58MgMVN8bjFnq9YVmtb7r8aJkvt5pPbE40hcYNlkD9y5jr3EyCY2IlcDMwyf5Wa91
 aU6zCTe5C5l0u83mD0TcEy4EBAo5zPsblcJv7n1oNfS35T0AJ0WfAuW8cqrTYv4KdMlw
 wsrqtKNMGGCOjSscyQHrhBChEma0unJnuLwGINKN7Io0AGFPgG05kPLBkc/hnzR8WCyo
 I8KovlPwasMhW9zpa8T6DNOknCb93aAku5PYOrs0fbj1QrqiL6DHQrHJ9aVq/L9AKXlH
 SDGQb2IT6r7YdNx9/FmM4+ilJkI6QPtqshgTBv6+bhF2upcWfmwEjRWkM+ebuht8rRm2
 xKXQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778492846; x=1779097646; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xQ1O+ps8z8uEjDF8fBKbjDNQ0AqBSMl70cByDxM9fpc=;
 b=SOdL91grS/0lWU28TkkerfqAeKWXpukCwTPlYGluMo/7rnsd2pBa6fV99xalSww1hf
 wr8f00KisClI3ll9HyGTv6G28vDq98bWENQVXUBenFk1sSXv94Z0dlbSmDq9iUP8XsdF
 gBPCT0ZIiApuPA8ZJXXnLQjp0ufRio0oN5qGAWWoiefl3GJAS+6y0LsyfasVjC55IzgG
 ii4/si3kOGaVy61Fvs+buBJe5EM90C93zNZ77uk+7FqA/7L3q79B2+pOJwdQ3pUxjctq
 WIIIrsqP1UKzkAGuY+G0LI0KNeVoMY9U1GKjuV2IV0VoNnkAvcPfj3bA8pjuu3wC97Mg
 M7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778492846; x=1779097646;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xQ1O+ps8z8uEjDF8fBKbjDNQ0AqBSMl70cByDxM9fpc=;
 b=bW40UvHAbJrZ12sD1xKxFGlVu+i7EB5js4kQeS3YfdV+LnZ2fGxdtwFbBnTiRWSw9K
 2vWUmhvmNdt1EtojK1TDuQKPYyJpgiPRYjIzNu0zdmPQmJVGwvYnJPdbEml9AmIFCcI/
 RL5Vw8ZgKNslVeWrbZQiCq9XaEbRt2SOGSecjnPgSh9SJcuH77WBAJFMB1AocAJ0L3dy
 0LVUYjY2Ct/sSLeaiepKKYx+Ct8Oklxyg/vVX6XlcxmpVnM9yaWxE9cM4GCaKOS8JpWN
 vnnUdaqdOmfxpheqUrg2M/tL7K+Ky1NSK/+sZPt5fa+RXq9HQAatkVjd414j4cEpNtZv
 u3sw==
X-Gm-Message-State: AOJu0Yy4I4yyPh+68HkhKvRLRjKVi4n6u7a9hOlzt9XItTWRGVMgZRVO
 gbk7wA4gcIRyavxk1MphFY3fL6/QmMzstmB6tDqHZZIywOFLWj6qaJZ+wZzlT5zJ6JUqEOS94gd
 gP5US5i48icmPwYXE1l5f+g/q8hYqAWesUOhQA8rFuvTSB6ShjrWW
X-Gm-Gg: Acq92OFqgqNehijVSAOs1IPRGPrkShaNsklk/xwzPDU9tmwzRavl56EZIYqfqz+y+xd
 706gEU8zGXUMrHVuu2559h5nDV//iu+rcxA9OWU7udB/VXWyzZSuOxLm9CiZ/z3qKsnpusUQg8A
 zxDypapdgHctpu0C0gRTlA8OqKO3OXYhsSvcPP4gsEQ6GSNsiGSwNlWUPGNQ6rmfn0ZWIFDtZCE
 t3S3a/dvNMGpDNigQb6BacxdRp6dbbpzSVNvZRBIHd/bSlVlFQCLqSOGzXKjhDD9QkHl3XfQNYb
 ij/9akWVeZcmtcZPom5myI4JozZbqwDgu4ygP6mOGl/PYsHlRp4HSWZ7Zrg/5tepRWEMBFQxMqo
 H5g==
X-Received: by 2002:a05:690c:e04e:b0:7bf:424:bf4d with SMTP id
 00721157ae682-7bf0424ed8bmr169550227b3.2.1778491313580; Mon, 11 May 2026
 02:21:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260508152428.2648560-1-peter.maydell@linaro.org>
 <agGb1m4paju1pIN9@redhat.com>
In-Reply-To: <agGb1m4paju1pIN9@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2026 10:21:41 +0100
X-Gm-Features: AVHnY4L7WMJYrCbFOL4GKb59ZOhYJRFZI7BiBzdc8i-Hdl98rRHYWvcQI-Lm0kY
Message-ID: <CAFEAcA96mBtLE+_Agi+an0K75sGr2tkusMWfQJqbGOv=tnOUKA@mail.gmail.com>
Subject: Re: [PATCH 0/9] tools: Move more tools sources into tools/
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Gerd Hoffmann <kraxel@redhat.com>,
 Eric Blake <eblake@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=peter.maydell@linaro.org; helo=mail-qk1-x732.google.com
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

On Mon, 11 May 2026 at 10:05, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 08.05.2026 um 17:24 hat Peter Maydell geschrieben:
> > We have a set of binaries that we call "tools": they're built based on
> > the --enable-tools/--disable-tools configure setting, they're
> > documented in docs/tools, and they're standalone executables of one
> > form or another.
> >
> > Currently the sources for these are a bit scattered: many still in the
> > top level source directory, some in contrib, one or two actually in
> > the tools directory.
> >
> > As an initial attempt at cleanup, this patchset moves the sources for
> > qemu-bridge-helper, qemu-edid, qemu-img, qemu-io, qemu-nbd,
> > qemu-keymap, qemu-vmsr-helper and elf2dmp into the tools/ directory.
> >
> > The patchseries also moves the ebfp skeleton sources from tools/ebpf/
> > to ebpf/bpf-src/, because this isn't a tool by the above definition.
> >
> > As per my thread from a while back, I would ultimately like us to
> > clean up contrib/:
> > https://lore.kernel.org/qemu-devel/CAFEAcA_5HvGriDsWnb1ALuA_dgG320eKv7yuM2kThv=rfOSZQA@mail.gmail.com/
> > But parts of that clearly need more discussion. So this is just doing
> > some parts that I hope are not controversial.
> >
> > Annoyingly, meson doesn't seem to provide any way for a subdirectory
> > meson.build to say "the foo.c in this subdir builds into a foo
> > executable that lives at the top level of the builddir". And we have a
> > lot of test harness stuff plus user muscle memory that assumes that
> > qemu-img and qemu-io live there. So the build runes for these tools
> > have to stay in the top level meson.build (and tools/meson.build
> > remains an empty file). The exception is that contrib/elf2dmp/elf2dmp
> > is now tools/elf2dmp/elf2dmp, but I think the set of people who were
> > running that from the build directory will be small.
>
> Should qemu-storage-daemon be moved as well? I never particularly liked
> the storage-daemon/ directory that Paolo created in 7c58bb76 and that
> singled qemu-storage-daemon out among the tools. If the binary could
> move whereever all the other tools live, too, that would be even better.

Yes, moving qemu-storage-daemon would probably also be a good idea.
This patchset is just starting with some of the easy stuff where
I was pretty sure the move was correct.

-- PMM


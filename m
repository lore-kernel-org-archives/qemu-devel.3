Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F39C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 14:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsNN6-00059d-FE; Wed, 12 Mar 2025 10:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tsNMr-00053o-3f
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:47:38 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tsNMp-0005oG-1K
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:47:32 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e5372a2fbddso5834777276.3
 for <qemu-devel@nongnu.org>; Wed, 12 Mar 2025 07:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741790848; x=1742395648; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=06FnvgG3rM4FtufdBNIaXT+xc/OxiQgdRXMeHIDggDg=;
 b=jInK8wBsJ1nlLt8e2kjBHAtsco2NU66+hrdt3uuKyHXoTsVJ++lZSaFx8bD435pcAf
 hEgWdqA1EOECBxP9NN3OIl2nEXln8/jihcb4rg/WhjUCxnhZBw46uG+vNdLhSZ9xqon/
 i+N/z8yQAnOSPyCY/GEsXkZLFDur0xytklYZ1vZuMXjHPgyLlBR9F266paqrn2Hi4ecv
 xoxs6JK950FeH9NNVMnDh6F9nAEKlQPU3PJolDQ+legcbgT71S3uAthPkTY+/BXhaRjD
 2SVahbh7lgtM2dJeB6cUvp86gPNtXjlPJMIyvwf/BEUvN376MAVOpqcqERil99rqTCBG
 OoUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741790848; x=1742395648;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=06FnvgG3rM4FtufdBNIaXT+xc/OxiQgdRXMeHIDggDg=;
 b=qZF48aKAP1UsEohXfKQRZD8i/dlUeFzHo9x9r2zsgrHodKYSLvLEr1R1aFQF9zjndK
 WH3i7fmQw0p6Y58BPQV8JwWX4kI3sCXQI5OXLpv4lD3J5o9nbzjF846wtsUjY0RuyKdn
 WSTvxzZnjKYGmJMQN5Hdc0n13DP8+Ku3rPQahEo9PpGV/Kbu+kQJLfem6Lx+egd/Y+HH
 UGm9snveZ+u2LrskH/IOEZpIcHaZG9VMNMVNSdhgwC+1Im1oP9+ijmC3QABr3exRDQqC
 uulDP5VuWSu162qH2YV2fRsqqXchKyo54T5WrMze8HkmSCGzH3UwNjIdZSylMrE2yPHx
 2dGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB/zwXOoAzQDj72YrGHFzysO5wqMFYzelSybIcRmSY4u2FaOyK6MOcFakdLcDJj/zLigDnLFuaYkFu@nongnu.org
X-Gm-Message-State: AOJu0Yy/otXodmYyRf7NEZUClmfaYeL4K49xQcQ/y/eKBA9wDdjkbx4g
 qvrX7aYrHqJ60IK8+M2QaKg+O6NiU13gzTKfiIxSGNN+H/VeD4v1o81fUbDio3wfi//Z5u2y1I/
 b3I4BiUFkmof3uok6EjI7yd+T0KyM2gtpHos1HQ==
X-Gm-Gg: ASbGncvKrZ5dlHHY42AFfot4A/MJcmzhYmh9bbqf4RzsazRL9NEM8jybDDxFPY2nIDC
 ALAuRi7qsqtQFSrcsqSXAx8e/jhKQiMm1X7neDuGl4wpTeUkL3fplilUiaa8rr7xqKpjMTu7SuF
 rYZflrZ87G1QP/lYqe5nbJ/j2l/hE=
X-Google-Smtp-Source: AGHT+IEPjNfimaQHLtz9I27sQc7Rq8BkZyMIIwWjAuBqluC9KlFM8GYMdyQ44zl9l+60ahfgxeUeObvw+gGiZguk3JE=
X-Received: by 2002:a05:6902:228f:b0:e5d:c68c:3547 with SMTP id
 3f1490d57ef6-e635c10158fmr27663635276.4.1741790848341; Wed, 12 Mar 2025
 07:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMcbCquaBmWhx3jWBKMC1oLrMZBUVhfWFcW=_5uhVqOep4NWw@mail.gmail.com>
 <Z9GUldol1IQT1uiY@redhat.com> <Z9GY3l2pTkbpMV8L@redhat.com>
In-Reply-To: <Z9GY3l2pTkbpMV8L@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 12 Mar 2025 14:47:16 +0000
X-Gm-Features: AQ5f1JojA9M_Rj6ymmqDosFl7zgc6ByL4pUEMqwZOBNxPHDDOM3DbV7guycCp8Q
Message-ID: <CAFEAcA9+i8kKtWb3Z=ZWKdgJ1puzLdf_ek=oMYRyJX4WXPU5+g@mail.gmail.com>
Subject: Re: Cross-compilation artifact is broken
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Konstantin Kostiuk <kkostiuk@redhat.com>, QEMU <qemu-devel@nongnu.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
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

On Wed, 12 Mar 2025 at 14:24, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Wed, Mar 12, 2025 at 02:05:09PM +0000, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Mar 12, 2025 at 03:52:45PM +0200, Konstantin Kostiuk wrote:
> > > Hi All,
> > >
> > > I cross-compiled qemu-ga from current master branch
> > > (825b96dbcee23d134b691fc75618b59c5f53da32) and found strange behavior=
.
> > >
> > > Configure CLI:
> > > ./configure --disable-docs --disable-system --disable-user
> > > --cross-prefix=3Dx86_64-w64-mingw32- --enable-guest-agent
> > > --disable-guest-agent-msi --disable-qga-vss
> > > Build CLI:
> > > make -j8 qemu-ga
> > >
> > > Linker wrote the following information but exited with 0 code:
> > >
> > > /usr/lib/gcc/x86_64-w64-mingw32/14.2.0/../../../../x86_64-w64-mingw32=
/bin/ld:
> > > qga/qemu-ga.exe:/4: section below image base
> > > /usr/lib/gcc/x86_64-w64-mingw32/14.2.0/../../../../x86_64-w64-mingw32=
/bin/ld:
> > > qga/qemu-ga.exe:/24: section below image base
> > >
> > > As a result, this binary failed to start on Windows without any detai=
ls,
> > > just a message that the application is not compatible. I also tried t=
o run
> > > it with wine and got the error:
> > >
> > > wine: failed to start
> > > L"Z:\\home\\user\\Documents\\repos\\qemu\\build\\qga\\qemu-ga.exe"
> > > Application could not be started, or no application associated with t=
he
> > > specified file.
> > > ShellExecuteEx failed: Bad EXE format for
> > > Z:\home\user\Documents\repos\qemu\build\qga\qemu-ga.exe.
> > >
> > > I bisected the tree and found the commit that caused the problem:
> > > https://gitlab.com/qemu-project/qemu/-/commit/563b1a35ed1f1151505d4fe=
5f723827d1b3fd4bc
> > >
> > > Adding --disable-split-debug to the configure CLI fixes the issue.
> > >
> > > $ x86_64-w64-mingw32-gcc --version
> > > x86_64-w64-mingw32-gcc (GCC) 14.2.0
> > >
> > > My question is, is this expected behavior or is this a bug?
> >
> > Your configure args don't include "--enable-debug", so I would
> > not have expected -gsplit-dwarf to have been enabled, so I'm
> > surprised that commit casued a problem.
>
> Hmm it appears that the meson  "get_option('debug')" is entirely
> unconnected to QEMU's --enable-debug configure flag, which I did
> not realize.
>
> IOW, we've got -gsplit-dwarf enabled by default for everyone
> building QEMU, which feels dubious. IMHO only an explicit
> --enable-debug configure arg should have triggered it.
>
> In addition since its breaking Windows builds, it appears we
> need to block its usage on Windows.

Agreed, but also this seems like a bug in the Windows toolchain
here: if -gsplit-dwarf is valid for Windows then it shouldn't
produce bad executables, and if it's not valid then the compiler
should produce an error if it's provided (or ignore it, maybe).

-- PMM


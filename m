Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9090CAC58D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 11:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwfKS-0007ji-OQ; Thu, 11 Sep 2025 07:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1uwfKQ-0007iy-8K
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 07:19:02 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1uwfKN-0000cr-KJ
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 07:19:01 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4b5f3e06ba9so20170571cf.1
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 04:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757589537; x=1758194337; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JPv/G+Ht0TyikEQ19GfxaRWb/NmgmRnf2zrwd5oyVnY=;
 b=ke3qiWe29T9t1uG2b//u3eoy5S+JhKMe3vogzMS0lJUDLQEazhvznWRPZlee6PjpXf
 ja7WjMu6SbNwuk5ZVMDcbsVGiO0Acoqfsmrg6rC2JqOW8TLmuZfdKfE5u+a7cQqecfrF
 kAFr97ZGvV38OMZIF2pYn9hk2f4OAUbVqcb7GYE6WZAa8LfhqItLDj9k/etDt0qyBtsn
 QWPfgW1af6HDZDuk+Oe5C38/8/QjQD/34LrnQ2DwAd9jsVfqHhAioScWx1GROBYpPKpa
 +3jXFAZomy+CKjltjsXURMhTNljyLIJmenfyJiY2izNOUvipe+nM7fALlH2qc9Sq+Eo1
 3Hjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757589537; x=1758194337;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JPv/G+Ht0TyikEQ19GfxaRWb/NmgmRnf2zrwd5oyVnY=;
 b=YcAujgHiGB5U6b53ag6PeOSbZ5LKpJDAQ6mLBUbpQ2gX8Z7/oydAxCll2f5gWUJMnR
 Udrt6PltqHGXQzl6g/LP9bHFI3CC2C9RQ+DN56T0CU6wN+6BOjh0RdnMCSnzKkavrdkI
 wlUtH1F6yDreZtc3e+EaDfaCGQ0zAwOx+c+Ejg1/5I6lv3io6ZTkFFCU43z+ZFE/SnRm
 QhbnUm4spHrMRvmNh9kCDEbqWkwTBI3QGT/Vicn3S+d+5RrKsCFzPsC5kp7FFqDlyzgw
 iwBJNkl0Lq2BrIL72aI7DyVVD2R6g7Wisrj1fZywhIDnFLSyf5iFmIgxO5t4Nl0Khzqu
 /cFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzYJhZKde8CcTlNWmDpzHWMGiSwPucK+/7kiV2ixqihsU13KLUvQCbAGoIy/kuSR8k4LGo1mt8D6/u@nongnu.org
X-Gm-Message-State: AOJu0YzxECOzojTCA13DsvsTmO9+NRDQFC1uO7RAnSFftX2W2dZ1Nl+7
 5FDV4lThUo6F0H3Lb9HdxOyLDlO5nmobqdvLF3YbwnQrp271cZCwSsf6ifbDJleVvaOvOTbDIcB
 s7k56mp8YbY1u0lpb2BcaF0spvkLiA4PN8iqw+Ew=
X-Gm-Gg: ASbGnctKSScNpxfkuWB8Bb2oTLwLL4P2MkFvplCHI9SqXSuIwzG+0He9hLPc+tQ2mja
 YfnS4k3DI0ccGB2NQv3FfjZjLge1s5vWl+EKsbAADp1zPGLkF8PAgJMWpWu62HZIWWR1qTyGgi/
 bpKYF+YoBZ276zulDP28UlSzDz429UGzrS1SF+kQy034er7weDLeebs1pI9WgN9TaVHBmgngnN1
 ihmguqz4Yn5fA==
X-Google-Smtp-Source: AGHT+IGkJbNSBeylRZap9s+QXqG/jWkIkfJjIq6jbcJQRRuwVXhjQZcOlpHhhKKDNr/IYxbNeCMntf2VXzYxHagrRNo=
X-Received: by 2002:a05:622a:1:b0:4b4:9679:da89 with SMTP id
 d75a77b69052e-4b63479b9e6mr32256701cf.23.1757589536655; Thu, 11 Sep 2025
 04:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250908105005.2119297-1-pbonzini@redhat.com>
 <CAFEAcA8WZ1Aa==LZv+roEHdaOzoMoX3aoeBbsM4gc3d_Yq=GTA@mail.gmail.com>
In-Reply-To: <CAFEAcA8WZ1Aa==LZv+roEHdaOzoMoX3aoeBbsM4gc3d_Yq=GTA@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 11 Sep 2025 15:18:44 +0400
X-Gm-Features: Ac12FXzlZ4-tWDnuAVV0qXUmUCf9VQ5vPFAbjTmX5wK1qgI-Bp_cVVqAbwHhc_g
Message-ID: <CAJ+F1CJCJUgnFRvc6LCCMdLVrXAoaTqWzuYtKE+siW+-8vZ4=Q@mail.gmail.com>
Subject: Re: [PATCH 00/33] First Rust update for QEMU 10.2
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Thu, Sep 11, 2025 at 2:05=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Mon, 8 Sept 2025 at 11:53, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > This includes:
> > - bumping MSRV to 1.83.0 to support const_refs_to_static
> > - Zhao's safe, builder-based implementation of migration callbacks
> > - Manos's qdev properties macro.  While bit-based properties are
> >   not yet supported, that's a small change overall.
> > - the Rust crate split from Marc-Andr=C3=A9
> > - adding proc macro aliases in individual crates, also from Marc-Andr=
=C3=A9
> >
> > I'm still not convinced about having "bql" depend on "migration",
> > but I am convinced by the crate split between "util" and "bql",
> > so we can move the implementation of VMState from "bql" to
> > "migration" later if needed.
> >
> > For the purpose of getting this in as an easy-to-use base for future
> > development, I'm disabling CI from Debian and Ubuntu.  The plan is:
> > - that Debian will require trixie to enable Rust usage
> > - that Ubuntu will backport 1.83 to its 22.04 and 24.04 versions
> >   (https://bugs.launchpad.net/ubuntu/+source/rustc-1.83/+bug/2120318)
> > - that Marc-Andr=C3=A9 or someone else will add Rust to other CI jobs
>
> How far into the future does moving to 1.83.0 push our
> "we can enable rust and make it mandatory" point? I was
> hoping we would be able to do that sometime soon but this
> sounds like we're going to be still a long way out from that :-(

I suppose most distro will want to backport a newer rust in their
stable distro, like ubuntu is doing or debian with rustc-web. With
that, it shouldn't be too long before we could make Rust required.

fwiw, I am working on a series to enable Rust on our various
CI/docker/vm. I am mostly left with issues from windows and macos ..
(btw, if someone can help me investigate the linking issue on mac
https://gitlab.com/marcandre.lureau/qemu/-/jobs/11301499123, perhaps a
temporary ssh somewhere?)


--
Marc-Andr=C3=A9 Lureau


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433FCCCF2D4
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 09:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhljA-0000jK-6N; Mon, 19 Jan 2026 04:39:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vhlj8-0000iK-Oa
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 04:39:14 -0500
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vhlj7-0000R5-5M
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 04:39:14 -0500
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-78f89501423so49373697b3.1
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 01:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768815551; x=1769420351; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bS3FRY6DBVPb4AJzTSIznws4AKioAo2V1bQN2dhkAPE=;
 b=RiH79EowJNHxzVumM/Llv8g5706vmn36r7e7yzt6Gxn/P2vckUV+5QX2em3s4iAv5i
 MhWguSGHA6G31MMRl9rjJyXcP0Cy8VIwiYs8Dhwn0o0hlGEPOL+vJ26DYVowO8Ysp5aF
 LmaQHXey1pkwsn4cw0V0fBhGcSWrnrXhTOo9k7MLj0s9b47yTWEkTmeLkSAcssb3Pbo0
 7vmRhq6f516rwmdgk899TIg/+iyzkW+mjCH8pD93ilnIf6dIT+CynFmtl6YWZEIbcB+8
 72LUGNbB05T5Zod2Dg9kPnG7n+4yULqf2GA4dIvo70zKXHACeYHw8SUefrdrySalRfC7
 bZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768815551; x=1769420351;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bS3FRY6DBVPb4AJzTSIznws4AKioAo2V1bQN2dhkAPE=;
 b=LXijsEaiM/GGrk45qty+zIWa2AGpNL94A1v4olHaUrOlMFJy0Y9u3VrRrSLWVUVtMH
 D7P15EC2BNxz5apB5B15ih+SaLp2v29uGP2/3PB2d+Dq4TkiA98HMrXfbwbC9M8l/MDA
 I6Lo3HM8yD2GMe/yWARQ0F7664w4tp760TCebH+WXe8yKQGntGzBFIfnifDr4x6EkrOm
 RQl4cI25e/1YIRqyXjkoKpfMLivf4tsXZ2nSA2A8jdhq7nTAnu3gI3UcP4RKFw8Bpg58
 GzFem/+k6j1bQR8E8NeXbPuYnSUY8K8Paedl9Gq5JM0QQdD+fi/2szfAs262BWJnFzf8
 cMzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhDSYPT5+3Mzu/Aql3CCkls33K8g233X9li+JT9bRv8MKxSxoauEg35rhuBpc3kXbQz8K3M1322ISn@nongnu.org
X-Gm-Message-State: AOJu0Ywlx5R2kQZoc14SSzhwIaMDRaP0UvFuft/BPvStjilVXxZlW8jn
 D/g7Xu5e7yV9T47YJVq43h723foDe7juhS3Vq7aOuWK31imsqJ14eQG3Q455Zfav01gp3DdHVaM
 fwrV0h8qRiStx03vDzczQGWP3zLZH+1N+SIhrrvK8HA==
X-Gm-Gg: AZuq6aL4GuUGCxjW6oQAXXT16rvMy2Z4YBYCxjtIy2xT8jHoxLVQS2n07jEToEpWi1e
 7ZnM3ffUrPKygsGCKZ95MCFpdseqBEZxnnJK2UXyE/PIuGgW22aQbI608ijUqUowrRsdNSLsBsl
 LfnWvCR/PQMwVJREAtiPlA2LjZ+VZpQ7WOZuN+kF4ARyXW2BQHjp5JAWfcMzEv2AibJ8x62AdCc
 pPUhsaaQd3v6Dq62s4B/h9aDLvzhxC5XgHeGrvvfpjxv/jLss/nsfa5191Bsy0qz9I3qA==
X-Received: by 2002:a05:690e:140f:b0:63f:b6c0:23f8 with SMTP id
 956f58d0204a3-6490a67fcf2mr9785463d50.33.1768815550723; Mon, 19 Jan 2026
 01:39:10 -0800 (PST)
MIME-Version: 1.0
References: <20260106-semihosting-cpu-tswap-v1-0-646576c25f56@eonerc.rwth-aachen.de>
 <20260106-semihosting-cpu-tswap-v1-1-646576c25f56@eonerc.rwth-aachen.de>
 <ee9a0216-0a1a-46ec-b647-64045c892af3@linaro.org>
 <FDDAA4F9-C389-4E63-8DEB-B0FBE38FE5CE@eonerc.rwth-aachen.de>
In-Reply-To: <FDDAA4F9-C389-4E63-8DEB-B0FBE38FE5CE@eonerc.rwth-aachen.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Jan 2026 09:38:59 +0000
X-Gm-Features: AZwV_Qi1RDHVEyRNcULKD72VZl5J7UzC2avld0aGfZ-78LBOP2AHe9SoLwNVURc
Message-ID: <CAFEAcA-P2xqNO21rMyt2VA_tRf9yzWh8qtJFggGr4Mn-AWjj5g@mail.gmail.com>
Subject: Re: [PATCH 1/2] include/exec: Provide the cpu_tswap() functions
To: =?UTF-8?Q?Kr=C3=B6ning=2C_Martin?= <martin.kroening@eonerc.rwth-aachen.de>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Mon, 19 Jan 2026 at 09:13, martin.kroening--- via qemu development
<qemu-devel@nongnu.org> wrote:
>
> Hi Philippe,
>
> On 18.01.26, 22:33, Philippe Mathieu-Daud=C3=A9 wrote:
>
> > > These functions are needed for CPUs that support runtime-configurable=
 endianness.
> > > In those cases, components such as semihosting need to perform
> > > runtime-dependent byte swaps.
> >
> > Are you targetting user or system emulation?
> >
> > I suppose user emulation, otherwise you'd have used the
> > "semihosting/uaccess.h" API.
> >
> > But then I'm confused because a user process can't change
> > the CPU endianness...

32-bit arm user-mode processes can change the CPU endianness,
incidentally; the SETEND instruction works at EL0.

> > Can you explain your use case?
>
> Thanks for asking! I am targeting system emulation. My use case is emulat=
ing
> bare-metal software such as an OS that switches the AArch64 CPU to big-en=
dian
> mode during runtime.
>
> `{get,set}_user_u{64,32}` from "semihosting/uaccess.h" currently use
> `tswap{32,64}` from "exec/tswap.h", which do not respect runtime-configur=
able
> endianness.
>
> PATCH 1/2 introduces `cpu_tswap{32,64}`, which PATCH 2/2 integrates into
> "semihosting/uaccess.h". I can squash those commits if you prefer, of cou=
rse.
> Or did I misunderstand your question?

So I think we do definitely want to have some setup where a
big-endian guest OS gets a big-endian semihosting ABI: the
semihosting spec is not very detailed on this but it does say

# Multi-byte values in memory must be formatted as pure little-endian
# or pure big-endian to match the endianness mapping configuration of
# the processor.

The question here is more (1) which specific endianness-config
bit do we want to be looking at and (2) what is the best API
and naming for the functions inside QEMU, to make them fit in
with some of the refactoring that Phil has been doing lately,
and to make them not liable to accidental misuse.

On (1) virtio_is_big_endian looks at the current data endianness
of the CPU, which is probably the most reasonable. (I don't know
what other semihosting implementations do -- the original "debug
ROM intercepts the SVC insn" implementation might well have been
hardcoded for "this is a big-endian ROM" vs "little-endian ROM".
But I don't think anybody could be relying on still getting
the little-endian ABI even when they temporarily use SETEND to
flip to big-endian.)

On (2):

> Alex was worried about expanding the use of `virtio_is_big_endian`:
>
> > Hmm looking at the description:
> >
> >     /**
> >      * @virtio_is_big_endian: Callback to return %true if a CPU which s=
upports
> >      * runtime configurable endianness is currently big-endian.
> >      * Non-configurable CPUs can use the default implementation of this=
 method.
> >      * This method should not be used by any callers other than the pre=
-1.0
> >      * virtio devices.
> >      */
> >     bool (*virtio_is_big_endian)(CPUState *cpu);
> >
> > I'm not sure if we want to expand the usage of this hack. I think
> > Philippe is hoping to get rid of these warts eventually. Of course we
> > could rename the method and just provide a way to get the current
> > systems endianess.
>
> While not being very familiar with QEMU's source code, something like thi=
s
> seems necessary to me. I can rename `virtio_is_big_endian` to `is_big_end=
ian`
> and `cpu_virtio_is_big_endian` to `cpu_is_big_endian` if you prefer that.

The reason for naming these functions the way we have now is
that we really didn't want them to be a "this looks like the
right function to use for my purpose" general name like
"is_big_endian". Almost nothing in QEMU outside the CPU itself
should need to know about the data endianness of the CPU,
because in real hardware the devices can't tell what the CPU
is set up as, they just get/send data. The exceptions are
legacy virtio (which is a mistake that was made because nobody
was thinking about it in the original virtio device design)
and some oddball interfaces like semihosting. So the name is
intended to push people away from using it (and towards e.g.
target_big_endian()).

thanks
-- PMM


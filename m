Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7EDAF433D2
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 01:12:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDBGl-0001IK-Io; Wed, 15 Apr 2026 21:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wDBGj-0001HZ-8M
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 21:11:45 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wDBGh-0003lp-2M
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 21:11:45 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b9910707d82so940784866b.1
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 18:11:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776301900; cv=none;
 d=google.com; s=arc-20240605;
 b=AV/HI5zauNgA9PPpHgHhMB9U730O69EidkNfgaB3Apzsrdd8n4jsdVXsQIK718+BnB
 zS0mzsc6kIkCBH3YIz8zsND1QL59ZQSiwN2FyMRBJzScoUrhD+K0bRQdIiQDDydYJHE4
 DyiYk4VJlr7zAZDv5IOSNAiNDq11cu0ssx8GrQHy2H9KyhHlVWevaT5jjHtAU3cricCz
 CrppGGPY+ywWwcwUhuI5omX+HtGvhjiZ4DqbrDVvp/otgrQunqdJGmcFWNq2oh8Tk2MS
 b5NTX3s/OTX39JgwyYgzxMu742VtwYWfI9RxigtWx7r5RF6l+Szgz/inG9JU2+gHGTAs
 S6yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yV2JaUWKGc9YEk8UYb9HkTOSIV+k3AcizDQS/LizfiI=;
 fh=mGbq/RihWm1QwXG+ENpUEbYVNLXp9TFm7FtdIHey6bU=;
 b=jICtsbrzxF+PyIE7EsrDUeym5YbAUf5AnwmuQ8mEw5t+rsCQsHv0ySC5amkOEtyMZB
 WXoF4D9mcd4TefkLz3a8YMC65Y/Wcw65/gNVizwDec4eEmcHfDHQNpipJ7ciIBFrw8da
 m2PXanRntqIHCuRh1j+23PdOkPvvwY9YdDHHWRXyDIcCxNPjItzqLH18W7N+aIkJ/+7r
 CdyChC4xD2dY4BxsaDyv7492OIDthRXC6k4nJw4x9EZWq3cMKqve10Rnt0GuLwqL1WDp
 i4UBsKdyz8z9ONZTXJIliboFmmXufadzMqPP4/LNr53JXygb1yMVGQZi1bDHg+SooPP0
 FOCA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776301900; x=1776906700; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yV2JaUWKGc9YEk8UYb9HkTOSIV+k3AcizDQS/LizfiI=;
 b=MY2YlK+DcF6K132QRRD9bBffv/G5YzACW+JdjU0IUJ7WHFqdzxcPvGFhm6mFoMLS5W
 JYnV5v8oLkBJIMbptPjcIzLoRNPPA5CFPiVWWU/OAlgJzHBfxRyFRbYMee3iMurd1c/i
 jeD59vgftgbjEmjHn6IH57/kLDourtgkXnIVC2OxTJ2D//Wsjsgzg8u/A5RSme7A+Jub
 KniIvsiefXfywoBUBFU9dtWnSKLPaNDXbE8jNVbfAO8RVjY3c+rowZfDWoE8TZpx0UUL
 9MvZr7kIEnWrJ/5r0kelXHuIS6999Mtqc4S0roN1N4cG34X9ChYUCGfrkUJBPWg+I9C/
 wxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776301900; x=1776906700;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yV2JaUWKGc9YEk8UYb9HkTOSIV+k3AcizDQS/LizfiI=;
 b=N5dD1WW4CIjfQc0OeNiAjpM+/m4ClMBkVoFRAFvmFbwt11VmgNQ+U4umE79eEvZcPQ
 mKVl7t25RImngDabKpYgTfMbXdTHofQ5AqgBP5KLchcFU8fOhE0azVl0UsW/rPfPhR/t
 fdtlaCTdYcdFRaQl1YGRDNFejKCFgBXsfubCx6gDzNFDDLaSR4nopVeoWeG00dJYFPWP
 cNp14wJVfFr9ErJ5Bm6sa3T77br2jIpqq+ZNdkak0avjHyh0tObR8Gdvv6j4Mqn1iv1+
 ipnRRFdopy5ogjQFvLJ0B4eZa9CGGO4FbLX5OEMOvHqvMWu+oecGN7xNFkqSPUeMpu9k
 g+Iw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9nvVPzXMQ4v9aqqqhhJbfM2qS1oOTlJRTS9MoGcXIv9Jr64MuApHBm1NhUKhf9ct8iUyGJcXbuXAc0@nongnu.org
X-Gm-Message-State: AOJu0YweSZBCRfp0x5AI5Tm8FtqAzesW1ADW7u/Qabs2/fi0YbDPehoy
 bAQe8rQM9ZLNFqayBC04JgOpvuRFTL3wPCqln8I+wMO0IZlXdIeW2f54Q6BCj5uTRwySYv2QNrb
 SIacvV8doOVcxgyRbDSuv2UFBi+d21HE=
X-Gm-Gg: AeBDietpIzdcGyWk4dqj6/dz4tiuWAP6PxyFexuZvkXAG++2/QrKPfmdnlqZY+ZIl+J
 YGe3oquLPyoUnCEGFrLL2f1qa+bdMH+tBZBIM2bv+/IZyqobltD5yqTMNJWg3xA5CaWt58jKGx2
 DmPP/gnnXXMJSg/5tuPTYWxUIigo7K56WUhL8fQAdbYy4P2L6LOryJzaayrJyAyGbpC/oBc5aTg
 IFTS7QmXCYtaZGzvSe3Oy4HoxBLQk1XUuKiq1CIThpHO4PEez64Ty1t5HNcC4lnZ8WlqbqJzgQX
 5AAV+sqU0lOqYJyBnRgdaCAC09RYctfsd5ENQVY7v/muY4GO
X-Received: by 2002:a17:907:bb92:b0:b96:996c:8605 with SMTP id
 a640c23a62f3a-b9d727d7dcdmr1047460166b.23.1776301900137; Wed, 15 Apr 2026
 18:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260321141345.599105-1-npiggin@gmail.com>
 <2e752dc3-0ba5-4d38-9d38-d19b2b841b07@tls.msk.ru>
 <CAKmqyKM2boFhCnnFOq85xK_sjrVbr3pye45tAUgueDcyR3eBdQ@mail.gmail.com>
 <0087dcb7-ef45-4f1d-b178-9ab9a78ced54@tls.msk.ru>
 <4cfd4f96-f761-459b-9233-da81c0a8d492@canonical.com>
In-Reply-To: <4cfd4f96-f761-459b-9233-da81c0a8d492@canonical.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 16 Apr 2026 11:11:12 +1000
X-Gm-Features: AQROBzAYkv5dznDLFbEScdk25uySRjtH4RhoeMH17QxJ3BhfesR-1004dzQ2jmY
Message-ID: <CAKmqyKPobqdQ8xCoGJCyOHzGN3Co85wOcXQKaXVSNK+qxA6WeQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] linux-user/riscv: add vector state to signal
 context
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>, 
 Christian Ehrhardt <christian.ehrhardt@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Apr 15, 2026 at 6:17=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 4/3/26 21:57, Michael Tokarev wrote:
> > On 01.04.2026 07:31, Alistair Francis wrote:
> >> On Fri, Mar 27, 2026 at 9:13=E2=80=AFPM Michael Tokarev <mjt@tls.msk.r=
u> wrote:
> >
> >>>> Nicholas Piggin (5):
> >>>>     tests/tcg/riscv64: Add a user signal handling test
> >>>>     linux-user/riscv: Allow restore_sigcontext to return error
> >>>>     linux-user/riscv: Add extended state to sigcontext
> >>>>     linux-user/riscv: Add vector state to signal context
> >>>>     tests/tcg/riscv64: Add vector state to signal test
> >>>
> >>> While a bit large-ish, and being sort of new feature, but it feels th=
is
> >>> patchset should be picked up for currently active qemu stable release=
s,
> >>> when applied to the master branch.  Back-porting possibility to older
> >>> releases hasn't tested yet, though.
> >>
> >> I don't think it's high priority to backport, as Vector support is
> >> still few and far between
>
> With the SpacemiT K3 an RVA23 compliant RISC-V CPU with both vector and
> hypervisor support exists.
>
> The Ubuntu distribution is on RVA23 since release 25.10 and requires
> vector support.
>
> >
> > I noticed ubuntu had to pick these up for one of their releases, -
> > apparently they had an important-enough use case for that stuff, -
> > that's why I thought to include these too.  Hopefully it wont break
> > anything :)
>
> As described in https://bugs.launchpad.net/bugs/2133188 running riscv64
> containers on x86_64 crashes on QEMU without this patch series.
>
> The v2 series was added to QEMU in Ubuntu 26.04. We would prefer to use
> whatever is going to be backported to upstream QEMU 10.2.

Once v4 is sent I will apply it and it can be back ported from there

Alistair

>
> Best regards
>
> Heinrich


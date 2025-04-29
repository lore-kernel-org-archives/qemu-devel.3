Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31CCC369D5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 03:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9bYV-0008U4-Vo; Mon, 28 Apr 2025 23:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1u9bYR-0008Ta-BT
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 23:22:43 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1u9bYP-0002eo-Mc
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 23:22:43 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-acb2faa9f55so686388866b.3
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 20:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745896958; x=1746501758; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IQynWEklF9NiJlrVkMpuoc79RTfDbcwf9uX0EykzEeQ=;
 b=V3HYNdngG4slFobaq4CqC/+Sn3ylcJOoz6bFELtlwNwv4UaKRr7lgwC6rKpGhHh3yv
 4y/AZ8SU9/xSAX650osOOBiIrbYPzbtIDQqjYZw0BL9iMRP0gmermQaKH8uRoMesOmi8
 ya6JIjTfwVjATVc+Bx8cp/HzvtSxYFhSfHbQnbHRHp2c0yA9I5kI2T+I2YXw9kaxFqLx
 c3D+lOkFbOSZx2CXljYlsNTbeDHZ30UhcMjAApHbF/hT2wkae7Tuc5VVgINaR/aQ21ox
 yADMsMRONBhElVNKWQ+7k5lv5R4Voh6QpTJKkIY+DrHfQQX5vPmCf58i5w1CSM/ohlp6
 ZSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745896958; x=1746501758;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IQynWEklF9NiJlrVkMpuoc79RTfDbcwf9uX0EykzEeQ=;
 b=daXRb0400DOIOz+X6mzGlPclDXIKpioNc6n6TKL4NCzQ0Y32KQ9LEUd4FqtkNuTkbq
 MLRLMQUQ5cm/gzUb+bWC8rZ1x6whsOkVmcV/i1REVjIWFXMBCFT9b2GUmJ9qAdstLHmM
 2N2SD3/Cib25tj94Wg6lF4XaGyaMwwuohXFj74cwXd70BOr3k4cOZaSTP37YsBqn6Vha
 VQTI0l6jKtTUNe7M1VLKRHeGZ/a5r7csW1S+q8eDTt3WpQabsoFuTC1lGhKGkd0gVOL6
 hwdAFpWrmqCPosr/cKZdBdvrdIL2lC3EIpzWVgWEbH9LRiLXwC0nJ6FA449mafDUja3o
 3EBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0iSB6Kfl72vk32k4zsLFx0lm/nFDf95sBlezLQGNnvZwqNhwF2sn3/ggDYNs3aIfwePIKm053ypB5@nongnu.org
X-Gm-Message-State: AOJu0Yw9G1Gfc34VtKPiqizulCmb1hSrK0vTmIXDxRWrQAj9Ptk3CS17
 00NOqyo0rPBWMaEpBOwRLB1lzbW15YEltON+2t8hTOQN4Wiavag+ZzxDvq3hpjyzbt/SFcczvDe
 S5rfTckdJyvVSrS4rT2SJtAdLRgaYx1IR//c42A==
X-Gm-Gg: ASbGncuJDpz92IpN88DdHz3GWWwoYltmlMonrHCdpDM1n3XZqzbZOOrZ3tRQej1zOx+
 sPi7U6YeYpmfLeASB6sU0RwbgRWJHtTY5q/IxOqS7q1wkdu9d0W+nF72kHt89Z6HJbNOruIn0hq
 waBNNRTuq+ME0DhvhU6JKjfg==
X-Google-Smtp-Source: AGHT+IHEJ7eFWAtX+achfTiqE5y5uz4QJ8skw6ERAwETTPnl7KlmoNF3/lK3o8Pon3qIH79iBn/U03pvyblNx6ocaww=
X-Received: by 2002:a17:907:7f15:b0:ac3:8aa5:53f6 with SMTP id
 a640c23a62f3a-ace848f8408mr875596966b.24.1745896957579; Mon, 28 Apr 2025
 20:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250402135402.14526-1-zhangckid@gmail.com>
 <d39ed054-d99b-46a8-afc8-1a2981d919e1@linaro.org>
 <CAK3tnvLqGLzQffAi=dk_VzXgH_k_r_z2xNTN3tVE-G+xjpPWcw@mail.gmail.com>
 <CAK3tnvJMOe+rtjnwbfQ8nuZyQAtGMPKjgXBVo2RpkmKNtzAXpQ@mail.gmail.com>
 <CAFEAcA8i60Ydeu+rpVYdRbDkMRaQ5EPmzAbBNsMHWq9Lr3FRaA@mail.gmail.com>
In-Reply-To: <CAFEAcA8i60Ydeu+rpVYdRbDkMRaQ5EPmzAbBNsMHWq9Lr3FRaA@mail.gmail.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 29 Apr 2025 11:22:01 +0800
X-Gm-Features: ATxdqUHTBghwa2nGrePlpzi6gzdOh7uIqiYndEui0bW9AdLafdPb13_BT-Q7JBM
Message-ID: <CAK3tnvKevF_sfpmdNP9oiTW-mUpjAkinFw14JOMtxDiyMAzuSg@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/virt.c: Fix wrong default cpu type in AARCH64
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=zhangckid@gmail.com; helo=mail-ej1-x636.google.com
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

On Mon, Apr 28, 2025 at 8:47=E2=80=AFPM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Thu, 24 Apr 2025 at 09:57, Zhang Chen <zhangckid@gmail.com> wrote:
> >
> > On Thu, Apr 3, 2025 at 10:23=E2=80=AFAM Zhang Chen <zhangckid@gmail.com=
> wrote:
> > >
> > > On Thu, Apr 3, 2025 at 2:43=E2=80=AFAM Richard Henderson
> > > <richard.henderson@linaro.org> wrote:
> > > >
> > > > On 4/2/25 06:54, Zhang Chen wrote:
> > > > > Because of the CONFIG_TCG auto enabled, the cpu type "cortex-a15"
> > > > > is mistakenly set to the default AARCH64 target.
> > > >
> > > > This is the correct backward compatible setting.
> > > > In essence, it means that you *must* supply a -cpu argument.
> > > >
> > > >
> > >
> > > If the "-cpu" is required, the VM should not be started without this =
argument.
> > > If yes, I will skip this patch and submit another one to make QEMU
> > > refuse to start without this parameter.
> > >
> >
> > Ping... and let me explain this status, it is not just for the default =
value.
> > 1. The cpu type "cortex-a15" is not the correct backward compatible
> > setting for AARCH64 target.
> > The ARM cortex-a15 is a 32 bit CPU based on ARMv7-A architecture. It
> > can not boot for AARCH64 target.
> > For example, the Apple M silicon can not boot with the default -cpu val=
ue.
>
> 'qemu-system-aarch64' doesn't mean "I want an AArch64 CPU", it
> just means that you can select AArch64 machines and CPUs. Almost
> all command lines that work with qemu-system-arm also do the same
> thing if run with qemu-system-aarch64. So in this case,
> "qemu-system-aarch64 -M virt" does the same as "qemu-system-arm -M virt",
> including the CPU type selected.
>
> The Cortex-A15 is now very rarely what anybody wants, but we
> keep it this way to avoid breaking existing users' command lines.
> (It works fine if you pass it a 32-bit guest kernel.)

Thanks Peter for the detailed explanation. I got the background of the AArc=
h64.
I'm just interested in Apple M silicon with HVF recently.

Thanks
Chen

>
> thanks
> -- PMM


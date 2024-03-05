Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B443AC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 10:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhSTT-0003Me-22; Tue, 05 Mar 2024 05:56:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhSTR-0003MV-8K
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 05:56:41 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhSTN-00006Q-Tp
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 05:56:40 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-55a5e7fa471so7634789a12.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 02:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709636193; x=1710240993; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LSEgQEXFM2W6pMTMiP3I3rp7G9z/Q2yXoySaZWe0M40=;
 b=fTJgxG/Zq5v+K8mk5EI95Bv1aXzTOoryxcDpNK5hXmRNumIcokFk6xIsxSbZsd8pgd
 49T5q8t8e332XV5w8Nt4qkmkE2P0yDIwXHqM0xRbZsTN0YnvstPjdn6AHo4otzrjsvyh
 Ar6rTo9jywC/9hboReBYk9H6gw9C9wGojwcSveiFQT475dP+XE5RXmXYDN7FFcxxD9xc
 pP86aqI8IjKSk+x6g30cVCRu28GTF0CR1P3sWPbklGDJyCV72Xu6h730hV1jkWwl+DlG
 9WG0Tuinm/seU91xfJk6+rQJKEHIbi59qM75zj4Fiz0yrBv1EyWt4OiCpDm/dc9IVrW9
 lvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709636193; x=1710240993;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LSEgQEXFM2W6pMTMiP3I3rp7G9z/Q2yXoySaZWe0M40=;
 b=YRMs7ZuozqSh5U0YIaeVNPURCNsjLb4fzjTUXCwQif4NE9V707WLy5nVQpBwbRhB+y
 T81hMHOdpLLR9QypnVhz1ml4SHGzk5Wxp5UTRRQ2jpp5qIQTpVj30TVD2SEKl/zB0mfg
 uV7slDOULAmArpj2ztHTnDwQ3eZliAn1/9ejdeexAcuW+lDo4hs/Y7dES+cbe9501hNy
 iB1Dui/1SDLxnWIFrc5Nj0eT3vc0+vKSvthQbsClR3PX/3DYqWnA6oa7DnsfFbSkrxRi
 4EBaAfS2DDdmxDKCaeUVVTbL5r/0vtITuFe+2/sAs7jKwnv90Cx90tuOh7Qex1Lm9X34
 2BEw==
X-Gm-Message-State: AOJu0Yzwje5cDIOwNyKGn/pdmPQIA2g5TedDBQSR+uaKYqxvx94uvsPI
 ow7LfEdvda2Wc8rsphDj50fN0haKRCo7TqEXib56SwbOs7FdROFOwXpjrMbeUDZjdkHj+krbD9B
 trWinxub2CEKCwaXnC5ZxtEnIwGDf0G3GYgjPsA==
X-Google-Smtp-Source: AGHT+IHtiL/7nHV+VR212m66W97dI/SVDIIeR1tuKE+beG3Pkgges4p8zbWBe5kBYuEvSmpPjo3V2TlWGGYgB1o0QJU=
X-Received: by 2002:aa7:c657:0:b0:567:3108:727d with SMTP id
 z23-20020aa7c657000000b005673108727dmr4956624edr.11.1709636193367; Tue, 05
 Mar 2024 02:56:33 -0800 (PST)
MIME-Version: 1.0
References: <252c0f8d-08cd-2e7b-63b6-1bbf42ff32f8@huawei.com>
 <CAFEAcA81xV6wvBFoaGNpH9=0oAjP=toMBS=MNV_poXm5RPK-iQ@mail.gmail.com>
 <c91c1f3d-9ff1-a582-bf03-ecf182c78b1b@huawei.com>
 <CAFEAcA-O00Sc9N_esAZ1CwfjmL7uprw_pcVcP=ZLFvu0-oA0AA@mail.gmail.com>
 <f7a4fcf6-10f2-70ba-8075-d991e0538b7e@huawei.com>
In-Reply-To: <f7a4fcf6-10f2-70ba-8075-d991e0538b7e@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2024 10:56:22 +0000
Message-ID: <CAFEAcA8AArzdVnOzswxrvPsXAhTZiO4cUmnL+C-PMd7oeOC1ww@mail.gmail.com>
Subject: Re: [Question] Can I start qemu-system-aarch64 with a vmlinux(ELF
 format)?
To: Kunkun Jiang <jiangkunkun@huawei.com>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>,
 Zenghui Yu <yuzenghui@huawei.com>, sundongxu3@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 5 Mar 2024 at 10:36, Kunkun Jiang <jiangkunkun@huawei.com> wrote:
>
> Hi Peter=EF=BC=8C
>
> On 2024/2/29 17:44, Peter Maydell wrote:
> > On Thu, 29 Feb 2024 at 03:01, Kunkun Jiang <jiangkunkun@huawei.com> wro=
te:
> >> Hi Peter,
> >>
> >> On 2024/2/27 23:28, Peter Maydell wrote:
> >>> On Tue, 27 Feb 2024 at 14:42, Kunkun Jiang via <qemu-devel@nongnu.org=
> wrote:
> >>>> Hi everybody,
> >>>>
> >>>> I want to start qemu-system-aarch64 with a vmlinux,
> >>>> which is an ELF format file. The arm_load_elf() is
> >>>> implemented in arm_setup_direct_kernel_boot(). So I
> >>>> thought it was supporting the ELF format file.
> >>> No, you can't do this. The hw/arm/boot.c code assumes
> >>> that ELF files are "bare metal" binaries, whereas
> >>> uImage format, AArch64 Image format, and raw binary files
> >>> are Linux kernels. Only the last three kinds of files will
> >>> be started with the boot protocol the Linux kernel expects.
> >>>
> >>> For AArch64, pass the -kernel option the path to the Image
> >>> file, not the vmlinux file.
> >> Yes, it works fine using Image files.
> >> I would also like to ask again, is it because AArch64 does not
> >> support vmlinux, or is it because qemu does not implement
> >> this capability?
> > As I said, it is because QEMU assumes that ELF files are
> > bare metal images, not Linux kernel images.
>
> Sorry to bother you again. I still have a few questions.
> 1. What does "bare metal images" mean? Are they used in tcg mode?

By "bare metal image" I mean here guest code that is expecting
to run as if it were the only thing that ever ran on the system,
so that it starts up with the CPU coming straight out of reset.
That is, it doesn't assume that it's been started via some kind
of BIOS or bootloader that sets up registers and configures the
hardware the way Linux wants to be started.

> 2. How QEMU assumes an ELF file is a bare metal image? Can you post
> the corresponding code?

It's in hw/arm/boot.c, in the function arm_setup_direct_kernel_boot().

> 3. How can I make the hw/arm/boot.c code assumes the ELF files are
> Linux kernels?

You cannot -- changing this would break QEMU's compatibility
with existing user command lines which assume they can pass an
ELF file to QEMU to get the bare-metal-bootup behaviour.

Do not try to pass a Linux kernel vmlinux ELF file to -kernel:
as I have told you, this will not work. Pass instead the
corresponding Image file. That will work and does not need
any changes to QEMU itself.

thanks
-- PMM


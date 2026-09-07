Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9C8C79FA0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 07:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Taz-0007UP-3U; Mon, 07 Sep 2026 03:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x3Tax-0007Tv-B2
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 03:16:47 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x3Tau-0001B8-TD
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 03:16:47 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-66d1447e2b1so2245382d50.0
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 00:16:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788765403; cv=none;
 d=google.com; s=arc-20260327;
 b=XgNYv7eXOwhXc3ljAh6S28QUTqHwsSGdGDuidDry0Zj4WwJZN+tYlecIxdSSba6khg
 JDy02jb+8KzQijq97xhMwWPKD3NAdm+d04Ia+MRHrR0q05F+0oiVPecTpF9A0MnTnNIF
 vUoa8pXYn/Me92xcd0IWm0eMg9sOF04enlVtb3b6Bug6xLAISUlZxj8mz1/AMWvTKAwV
 RGXsqAOpJASSOnuAArIxqZ/QK0IJ0T8KBEdxNmY4qW3CkJtFuinNIFsnggA94p/bxJO4
 EbfbqfJepe7skju0UUn12y0t6UbazvLo20ilKsfhaTctW2CDsCY7U0STQMXVv1aX3Yri
 qaHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QCti3rgeZN1YIm9TfGLPl2KhexTOFxw/SKTwmPEtp6A=;
 fh=Zw1R+2IUdXUcdZtqWXVsel7142xFHupQLV52fZ/f5qs=;
 b=cjxjWaHbwd8l9xZ3AIbnep5l8LJt3CcefIuIVGBgHfZtiYMgMtLfgbu4Eh+BXQjAwg
 IrBOVRpqTcD+Qpt3juo7Q4UuWuInguVoVgbB7dJNQh7gLUF0ueQAHNjiS4N8mT2Lvg7U
 2x/KXHyZOLSI1SqXTklUGz/htAL2tZPPFCaBe3KTuYdYmNfUG3b5lazque+eaXUGHYXo
 0RjGv6cvxWt76vykkzstG1x4SlmHrk0hd3XPeTXLxEM4VH9ft05L5Stt3z1HAZkUQYWa
 1l39a8AKUmgnx6+P1oJkDrqjb4B+FlO9WKxdyL0eUMs/l15ohR5plRwhornGtFc2zXPA
 cN1g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1788765403; x=1789370203; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QCti3rgeZN1YIm9TfGLPl2KhexTOFxw/SKTwmPEtp6A=;
 b=Wl/nNtMYIJfudq/VboAi7rx4VReWTRJ9fVOZCbraBRThdjhB72/SnsIqufmsh1D9oL
 k/nBewySlYg7BLwM68crPg1ZzCJeHxhiQ/kswiXjA0wSu+s+teCGt2sVFdTCuiJShjw5
 rxTJ7eB84jqAb/BFX/8CnjXBScPvEzaGwA3To=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788765403; x=1789370203;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QCti3rgeZN1YIm9TfGLPl2KhexTOFxw/SKTwmPEtp6A=;
 b=gMVZREceuFhK6yvdJCnxUFkkSqM7wHi3PemwbVCtmW9nmaUFs2qSDb4hRul49AaNVV
 T6Oa0kI67EtTwncqMewQpAmaNk64PwluPTmRqfnkXzIGj/maMTzJ7+2ZQIKt55z4dyPz
 XJ8+0bPIvIZAAVMV5RIkUgbSwc7WgZ1R/l21pjCuG1Z5kNp9bPH8rY3JJAt9EwXolVIS
 /2/GRqZ4jOBE3Cza9VHuT+tYL4sAKsPYu7XtGRzgo3idG0DfFEZCEbtM4Gl6WIEr6B1X
 gc7pDSAa6Oe48/Pr9d2R93xSy8iXs7O0pqoZzGb+JIOMmlqnUsYxa2X5jnO2qeLu9UMN
 9zog==
X-Forwarded-Encrypted: i=1;
 AKwUvByMI23FlaZQQRTv3XpL2oNPKVy1ZZ+twFgJlvelXhOK2dHNRXc9G12/hBg+V9GBKrP9z7xHbGqBIPc7@nongnu.org
X-Gm-Message-State: AFuF++m7SaTZogL0vxgAWnK3ZBxW2PO1w6M7ZK1vOF34YNzqlqh6rvsq
 pFT8DMJtIzVXgcgunEHboWNYnUUV+NL6G63tvwEKAgKDbSlFeWkJohsZcUARadAcry0kBew/IXd
 bFI+P26IGJtvDVQqEhbhbAHfrjOSDW3Y=
X-Gm-Gg: AYBFou3z8QjWEFRUZt4lchRdiaauLOis9SxNwzEmzhJ/Y6RuF5szKGipwM/qqF5CwgH
 4flgTq2bipToV82eS6Q+ORccl96Ts6YHoKEATayE126gTDzRsUjsV6glGluhdeF943lpcBtfAAP
 PSgrBxArxCdY3wlyKOiHwdLSnWzeLQRj8K36YeQJcdUf2JnjEn52HwdvTDTV5qAtpJG6Cq4YHhA
 ToDJvkJpsg0hOFHFwinvwqAcIVONkbQqCrmoJe/vFaxhhjnp5o7QHiDYLZsjblFra3VMDyG7CqA
 8F00HzD5GkHUfuhP1kJo+ExsWoX/2JyMiOJctn/Syg7xD45mG8Sff6a+Freo9fkFeYRFfolnA38
 hEHJOpMC5LFlPcVsCl6ET8YWgvRiATZxSNEnHvFWAVEHN+6fHoUTzg2fsGlZWTX0aeDCz+TjRx3
 Q5Nxmcf/lyxSMZcWmaEmUrr4NnZ50=
X-Received: by 2002:a05:690e:42cf:b0:66f:c1bc:4058 with SMTP id
 956f58d0204a3-66fc1bc4289mr1725167d50.32.1788765403506; Mon, 07 Sep 2026
 00:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260903055131.257903-1-joel@jms.id.au>
 <20260903055131.257903-16-joel@jms.id.au>
 <5d681d59-4a2f-4068-b36d-4ca40ab7b921@oss.qualcomm.com>
In-Reply-To: <5d681d59-4a2f-4068-b36d-4ca40ab7b921@oss.qualcomm.com>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 7 Sep 2026 16:46:31 +0930
X-Gm-Features: AcwNN1UcYx2HqbMD2LOa_8r0qgM2x62xIoq0t9zrFPpADh8wMPNrLIavJiosD5I
Message-ID: <CACPK8Xf6Lot-Vs1-=iF+UoLZ=qBoRHhao6Z1FR8JC382qKLXBA@mail.gmail.com>
Subject: Re: [PATCH v3 15/16] hw/riscv/atlantis: Extract an Atlantis SoC device
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, 
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=joel.stan@gmail.com; helo=mail-yx1-xb12e.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, 4 Sept 2026 at 20:17, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 3/9/26 07:51, Joel Stanley wrote:
> > Introduce TYPE_TT_ATLANTIS_SOC and move the hart array, AIA, ACLINT,
> > boot ROM, UART and I2C controllers into the new TTAtlantisSoCState. The
> > machine keeps ownership of RAM, device tree generation, firmware
> > loading, and the board-level I2C slaves.
> >
> > This makes it easier to compose the SoC into a more complex machine in
> > the future.
> >
> > Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > ---
> >   include/hw/riscv/tt_atlantis.h |  21 ++++-
> >   hw/riscv/tt_atlantis.c         | 144 +++++++++++++++++++++++---------=
-
> >   2 files changed, 119 insertions(+), 46 deletions(-)
>
>
> > -struct TTAtlantisState {
> > +struct TTAtlantisSoCState {
> >       /*< private >*/
>
> While here please drop these legacy private/public comments (QOM
> style doesn't want them anymore).

Thanks, TIL. I might send a cleanup for the risc-v tree to set an
example for new code.

Cheers,

Joel


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E271FC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 09:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfcxx-0003tH-GB; Thu, 29 Feb 2024 04:44:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rfcxo-0003nz-5h
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 04:44:34 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rfcxj-0007V8-Q1
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 04:44:27 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5658082d2c4so1029939a12.1
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 01:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709199856; x=1709804656; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3od170oFZe+JPhRwwcVSY2EwQ/KEsEQiZBJf5WX4b7M=;
 b=UlnAIDm+cqgyoK2gJS11qD4zb5Zd3PBDpPUrzd0wOCSd18L97cCMSzIH/i4aA7gMKG
 x2Tyxy9oxPdpFWP+EuB4ckAK4KrieLwtm5qj+FM1nYsEfwacjTRAbAlGD/nMZSjuOvTT
 hIaMC40g+0x/yHZ6uLAClJ3kc17eFL2gmWZjFs40TkaTL+dyXkgJHcWJ9SViU6gmmYOE
 PG2HqijVL6VPddAKB+nsf/3fGLsdgMDyoj32x2qKAzmTJJBCeYNvBJAnQskRIoF7p+yV
 dq3CiGsWNb8ZRwFuu6ZS9StQbZ6UC+vj8VHDXLgmHwFhF978Jak+DvSwxMtaIT5i1nik
 x1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709199856; x=1709804656;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3od170oFZe+JPhRwwcVSY2EwQ/KEsEQiZBJf5WX4b7M=;
 b=Zh4esiLW7vCNH5ITOC83qUF0ZdQSxnt0JPDxiebbqYOerbjhGHg94V5yjix99mK7jC
 6oGlVAQHIZKf4edijiOoGQcDZTrhDuUThOgKOuXClbRAMiEu7fsh2Sclx5uWiJYUmGGm
 zezbu863UsORtuym3fI5huGe+dSWe63FB5lrj74OWAGhzvn8HQskttVeT2Irsx3+MUD2
 VTGsv/yO69efAzoXVhe8vJ9kCoxOjPLGNP1+xZTjuFDDUloozRf/vF8pdBVHZsLsHxXY
 V3+gbTBWA9YNATntRf6mS29NRdZLAhCw7Bw043xH1UZ/XrbkACcoiQW8VKREfayPnRT6
 2uGg==
X-Gm-Message-State: AOJu0Yz91sNv9tGGliPrjY1nsbMkTuCOusYjbOTNDrxOLuc1AvFuhxlw
 VU2q1sP7Q1En2FsCsc47tCRP3nHIzZmxONtrnoMIylkhdyDhQ4fpWjGSoVupkolQDIyB4GZCDkd
 VZTEcbkN+4NLUU8BoexJWyti28fA3IX+6uRh8tw==
X-Google-Smtp-Source: AGHT+IH2qZzr63X/CEkFUOpEQKu/riJjkxMbT4zYZWp6RbPDlhqaacfJkw404xO5lzxpSbh+mBK55okiX8lbCvoEIO8=
X-Received: by 2002:a50:d7d4:0:b0:564:9019:d9b1 with SMTP id
 m20-20020a50d7d4000000b005649019d9b1mr728842edj.40.1709199856501; Thu, 29 Feb
 2024 01:44:16 -0800 (PST)
MIME-Version: 1.0
References: <252c0f8d-08cd-2e7b-63b6-1bbf42ff32f8@huawei.com>
 <CAFEAcA81xV6wvBFoaGNpH9=0oAjP=toMBS=MNV_poXm5RPK-iQ@mail.gmail.com>
 <c91c1f3d-9ff1-a582-bf03-ecf182c78b1b@huawei.com>
In-Reply-To: <c91c1f3d-9ff1-a582-bf03-ecf182c78b1b@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Feb 2024 09:44:05 +0000
Message-ID: <CAFEAcA-O00Sc9N_esAZ1CwfjmL7uprw_pcVcP=ZLFvu0-oA0AA@mail.gmail.com>
Subject: Re: [Question] Can I start qemu-system-aarch64 with a vmlinux(ELF
 format)?
To: Kunkun Jiang <jiangkunkun@huawei.com>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "wanghaibin.wang@huawei.com" <wanghaibin.wang@huawei.com>,
 Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Thu, 29 Feb 2024 at 03:01, Kunkun Jiang <jiangkunkun@huawei.com> wrote:
>
> Hi Peter,
>
> On 2024/2/27 23:28, Peter Maydell wrote:
> > On Tue, 27 Feb 2024 at 14:42, Kunkun Jiang via <qemu-devel@nongnu.org> wrote:
> >> Hi everybody,
> >>
> >> I want to start qemu-system-aarch64 with a vmlinux,
> >> which is an ELF format file. The arm_load_elf() is
> >> implemented in arm_setup_direct_kernel_boot(). So I
> >> thought it was supporting the ELF format file.
> > No, you can't do this. The hw/arm/boot.c code assumes
> > that ELF files are "bare metal" binaries, whereas
> > uImage format, AArch64 Image format, and raw binary files
> > are Linux kernels. Only the last three kinds of files will
> > be started with the boot protocol the Linux kernel expects.
> >
> > For AArch64, pass the -kernel option the path to the Image
> > file, not the vmlinux file.
>
> Yes, it works fine using Image files.
> I would also like to ask again, is it because AArch64 does not
> support vmlinux, or is it because qemu does not implement
> this capability?

As I said, it is because QEMU assumes that ELF files are
bare metal images, not Linux kernel images.

-- PMM


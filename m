Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1189BCA0EFC
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Aug 2025 16:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqDw6-0005Q4-BN; Sun, 24 Aug 2025 12:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqDw5-0005Pl-2q; Sun, 24 Aug 2025 12:51:17 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqDw2-0004mt-Nh; Sun, 24 Aug 2025 12:51:16 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-55ce528022eso3590885e87.3; 
 Sun, 24 Aug 2025 09:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756054272; x=1756659072; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=e2L8UFR5i1/GnFX6GzDS4WGinFUI0mKq4C/ixqfZYvk=;
 b=ZxrRecVylcc5Zi0t3EjQl/w66P9XEU2KTjcv0xK37nrzn/+kgoHnAAiuB8JaSSC2MK
 pbPkjPjsVtreJ9JRSDUrslQ6CIucfsz7+GczW0PR5nosWbZ33HFXB0Qm9pfpRAC0OusE
 wK00C4CCxY4ffJbvrddgvR5nGn/+MKD4vDdUHVrb8/lpAUgP9PFY3KWLNjOtdTnOT4GH
 dcY4qr/QquyeDBMYEmrW5alhX8TWLUnuld9WVSYogQYm0dsgBogwO5E+BgvQphFc9aWI
 ss3Ta4tfoeTRGKijgPxZ/Yj4vjW/uRTMz/ZaWPMX1IcmAdTMoNGQHT7Y7fshdcjHQinb
 8PLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756054272; x=1756659072;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e2L8UFR5i1/GnFX6GzDS4WGinFUI0mKq4C/ixqfZYvk=;
 b=lfigLbCxBhSBYb4gWPC2hqMrdn+39N6rvuWK4y04dkpYFGeXzQjQdRYk5Y5ZWSsh99
 KkuNblrO43oFr2cWPSLiZ1G45MxS5QfpzQdle+Mrfbf8plMYEOMQjNUKp1SAHy6x6d2+
 O9f7kz0b8Q8xRqbJUXmEoB9xhYKLwvoYpkTud5CZlk04nat1gfn9aykNBM21BoaSBSei
 1SnAw7F0w5tIxpBV3T23wzRIa2nu69QYQ7jbHwvDciCZAe0QoIpF9vhaE/o0KQcE6f2q
 Qmgf6jq7N8rvWLs8myRsyEX68Ab8y3OuxvHRA++iYsxBKzHv5oUyLH53fySHs8YuPb/K
 /tQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQSuC1rMYAUFSSzh67w/sZrAzgx28zHIJucJOTQ1GdPZoCAAGaygmZitjI8dVM4vOPIml2iZ4VM1wV8A==@nongnu.org,
 AJvYcCUn/n3bafKFRddnZ48mxgaFNn5LJHvQKdHrWoA7mMX8qurVZFKdaQxz3jIMQEP7k/bzKuVXTmyg3w==@nongnu.org,
 AJvYcCXka7BYibjZmtSmoyafkdx3p7quBMkSq6Lv6lGmpjz7D+0esMNNRLsg3QiAImNQBySDFrq1ljr5pMCA5A==@nongnu.org
X-Gm-Message-State: AOJu0YzUwazSTY8pAgYH9EEQd+vLMOzv9HsJUqQxl4iX3LC8ze7eGhM/
 SHJuP85zmjr6vofOSKmXI6Ia25iTxy7Toxmsnjl1r8fAN8E5oGOeJ5ne
X-Gm-Gg: ASbGncspmgBAGpcwYWAcQMcQVQRlsf/1KLjv01v4AAl23EBbMqWCYmEdKK2ryVb+gWP
 /79UvCe03YOfdsgfR8Uwo5hN86gIL+bVWvw+8tKpOLkGQnjIk6lESGZw0WmPlDiKscTcqqli0Gb
 5WqCzOGUHK+RlKpLvGqaIOZuxJOihlVkDD2lR+KcPs+oVkjX6K63AA5VfUl5LklpUxSOzCXFGsq
 DuIKjD1gMydHD0RBS74pi8UGXDY8aFW22+nmCVcwO5DGOZrpxZ6npqss4imIJJOSi6ykhDs7k0g
 jdEewCZa5VwCNw/N3l3xN9fIa3iMuArSZpPT0obN9f9GfATw7ovkluaWP5qmqz7P1DflSY2vG98
 WimY2VZdjrrZdYEDRhKcoNHhVs2qA4LfYuNzGN1auT+CdXaeEpEcH1VPdhTPs/UMOLPU++w==
X-Google-Smtp-Source: AGHT+IEF68kARxwEOcMzD6je577oPfcmdGWvkioCCYF0Di5UWivDo4ruCKsiwjHQ9nn3HICMLevQYg==
X-Received: by 2002:a05:6512:615:10b0:55f:3786:68fd with SMTP id
 2adb3069b0e04-55f37867757mr1155257e87.18.1756054271643; 
 Sun, 24 Aug 2025 09:51:11 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55f35bffae3sm1141945e87.31.2025.08.24.09.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Aug 2025 09:51:11 -0700 (PDT)
Date: Sun, 24 Aug 2025 18:51:10 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Corvin =?iso-8859-1?Q?K=F6hne?= <corvin.koehne@gmail.com>,
 qemu-devel@nongnu.org,
 Corvin =?iso-8859-1?Q?K=F6hne?= <c.koehne@beckhoff.com>,
 qemu-arm@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Yannick =?iso-8859-1?Q?Vo=DFen?= <y.vossen@beckhoff.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v2 00/14] hw/arm: add Beckhoff CX7200 board
Message-ID: <aKtC_jPngZ8KFiTB@zapote>
References: <20250815090113.141641-1-corvin.koehne@gmail.com>
 <CAFEAcA9y-0-Oe5beVObe+SZqmByRSOYkCaKM1FDjeo0jdxjjCQ@mail.gmail.com>
 <CAFEAcA8bFFB9CxCoVi+YVcJpwcQeEn4RkALVXDzwOH930WsGMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA8bFFB9CxCoVi+YVcJpwcQeEn4RkALVXDzwOH930WsGMw@mail.gmail.com>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12b.google.com
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

On Tue, Aug 19, 2025 at 05:40:14PM +0100, Peter Maydell wrote:
> On Fri, 15 Aug 2025 at 19:06, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Fri, 15 Aug 2025 at 10:01, Corvin Köhne <corvin.koehne@gmail.com> wrote:
> > >
> > > From: Corvin Köhne <c.koehne@beckhoff.com>
> > >
> > > Hi,
> > >
> > > Beckhoff has build a board, called CX7200, based on the Xilinx Zynq A9
> > > platform. This commit series adds the Beckhoff CX7200 as new board variant to
> > > QEMU.
> > >
> > > The emulation is able to successfully boot an CX7200 image. The image includes
> > > some self tests executed on every boot. Only the cache self test fails due to
> > > QEMU emulating the cache as always being coherent. The self tests include f.e.:
> > >
> > > * Network
> > > * Flash
> > > * CCAT DMA + EEPROM [1]
> > > * TwinCAT (Beckhoff's automation control software [2])
> > >
> > > [1] https://github.com/beckhoff/ccat
> > > [2] https://www.beckhoff.com/en-us/products/automation/
> > >
> > > YannickV (14):
> > >   hw/timer: Make frequency configurable
> > >   hw/timer: Make PERIPHCLK period configurable
> > >   hw/dma/zynq-devcfg: Handle bitstream loading via DMA to 0xffffffff
> > >   hw/arm/zynq-devcfg: Prevent unintended unlock during initialization
> > >   hw/dma/zynq: Ensure PCFG_DONE bit remains set to indicate PL is in
> > >     user mode
> > >   hw/dma/zynq-devcfg: Simulate dummy PL reset
> > >   hw/dma/zynq-devcfg: Indicate power-up status of PL
> > >   hw/dma/zynq-devcfg: Fix register memory
> > >   hw/misc: Add dummy ZYNQ DDR controller
> > >   hw/misc/zynq_slcr: Add logic for DCI configuration
> > >   hw/misc: Add Beckhoff CCAT device
> > >   hw/block/m25p80: Add HAS_SR_TB flag for is25lp016d
> > >   hw/arm: Add new machine based on xilinx-zynq-a9 for Beckhoff CX7200
> > >   docs/system/arm: Add support for Beckhoff CX7200
> >
> > This patchset is on my list to review. As an initial request,
> > for a new board could we have a test in tests/functional/
> > please?
> 
> I've also now reviewed the two initial generic-arm patches
> and the ones where you add new device models. I had a
> quick scan through the bug fix patches to the existing
> zynq devices but I'd appreciate it if the Xilinx folks
> could review those ones.
>

Thanks Peter,

I reviewed patches 3 - 8 and 10.

Patch 5 and 10 have some minor whitespace issues, perhaps we could fix
on commit...

f5badc6fe5 (HEAD) hw/dma/zynq: Ensure PCFG_DONE bit remains set to indicate PL is in user mode
3: ../check.sh

ERROR: trailing whitespace
#24: FILE: hw/dma/xlnx-zynq-devcfg.c:192:
+    $

total: 1 errors, 0 warnings, 8 lines checked


e8874ea66c (HEAD, beckhoff) hw/misc/zynq_slcr: Add logic for DCI configuration
7: ../check.sh

ERROR: trailing whitespace
#72: FILE: hw/misc/zynq_slcr.c:571:
+        if (!FIELD_EX32(val, DDRIOB_DCI_CTRL, RESET) && $

total: 1 errors, 0 warnings, 61 lines checked

Cheers,
Edgar


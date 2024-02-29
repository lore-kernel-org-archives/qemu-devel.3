Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79667C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 11:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfeQl-0007eq-1f; Thu, 29 Feb 2024 06:18:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1rfeQi-0007cx-Gx
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 06:18:24 -0500
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1rfeQg-0003iD-5q
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 06:18:24 -0500
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-21fa872dce3so397289fac.2
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 03:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709205501; x=1709810301;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d8YV4iXBroKLI6tKzsLdOFl/n10PjDwe2AcFCSv5xEc=;
 b=MQ0n9STbD9cMl9iwOvwXRjTdwR7AXfvg0Vx3AlfUtO2irqKeAOvKyuXd4HO96Y16Fs
 m4OXTrtLxZ1lGmysZqZAghSrkXcXSNj6Q7iL56lX8XHRv8cti+zdEVGGZEdv3XW1DfOv
 eXBp/H0t5J2kZ7540e9KFqKsCZSxCJjDhEI7Khd/LedoAaPH42MAmjI0RlgZW+patpv0
 2C+b4SrbWotFVXoaJ5wprwlW2YTvfx1n23VGvogpDrf54cyFnxl/6WZAASnLhS8k56rB
 hrt0cdlTgttS069TvCkrfoExtxGMmbrzvUfhVkdwbdzQrvyFWJYkt5ciw23W2vj4fk/+
 9DaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709205501; x=1709810301;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d8YV4iXBroKLI6tKzsLdOFl/n10PjDwe2AcFCSv5xEc=;
 b=D4aSkMlaDB1RvjooAkXBkWhBiJpoy4SvO8vi52saFhf7GVfSAymnTf460hhYcJnABP
 TPHUe8WY7OgwIpblZHyC10BlKABD4Cskst1Ijb33PsNRroJcqYWK1ctP7f/9lFHQh0N8
 PyORqLSnex6ZhwfJ86bwFPCTVKKGA7K5q7iDglkUIfTRvHALfr2+BaifiXVUp49c0syA
 lTCfgRR/QSw7X1MH3cH1+9DyK6oW37JrgZFQaduD2lj9KsboO2+KRsJKq4HlHAQFQm26
 A6bRWjec1y7HZCdnSSaHFPr14U/oSpK3vWcl1pqhC/3uQ79FevqZUpDznRp3w/FXe9Si
 m3Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsywJXE561K0/PKyHBR5qTkYmBKiRzoXP3ZR4vV0sYA0e8M80/qxLVuhqW/R5ZpGF5wKxWDZPxJLGGX2ihkAcWF1dmXkA=
X-Gm-Message-State: AOJu0Yxpc/t1b/PdDy4bKroueYw1WRj+fzJzHiCnY6x18r514L/LYpbo
 RlLL1zQa0YJgh23yt1XfcKPrURtiY1KU3EJzlh8/YQvbYapD20FOf7Kupg2rHn9EtEZDXUkS0hY
 MnBS7RieXDh04bpzCUyvHPfawagplUxzU72pHoQ==
X-Google-Smtp-Source: AGHT+IElIrRRwSHnCgz1rs0nXTbgFTj+OGfwIAA/KvpSuK7QD/bD1F110/IZgn/i2GQ7EFq4UAdrCjw3Zwl2662HAjc=
X-Received: by 2002:a05:6870:3111:b0:21f:dfd8:e962 with SMTP id
 v17-20020a056870311100b0021fdfd8e962mr1827283oaa.0.1709205500888; Thu, 29 Feb
 2024 03:18:20 -0800 (PST)
MIME-Version: 1.0
References: <20240228125939.56925-1-heinrich.schuchardt@canonical.com>
 <fb6ef90d-4a3e-4bdd-8516-8b15c1f2329f@linaro.org>
 <b9937680-8c0b-46f6-86ef-55139562e2c4@canonical.com>
 <CAFEAcA_Bshua2BQTfOb3D1aF27ayELEt9TcQM8hkQdKaih3xHw@mail.gmail.com>
 <9c64be5c-25b8-421d-966a-bdac03dfe37c@canonical.com>
 <CAFEAcA92s+3Q3ud=zOjsyvuqZ=BjwXt3OY0n5mO_iDXovQpoRQ@mail.gmail.com>
 <20240229105900.0000490e@Huawei.com>
 <CAFEAcA_O2QPwCPE0HS9g0saEA3XbuVS_UGtRpe_o4tLRrc6Ksg@mail.gmail.com>
In-Reply-To: <CAFEAcA_O2QPwCPE0HS9g0saEA3XbuVS_UGtRpe_o4tLRrc6Ksg@mail.gmail.com>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Thu, 29 Feb 2024 12:18:10 +0100
Message-ID: <CAGNS4TYNKQdg5kDSSYbc9ifkLDCxPUF0YWZh_Ji2DP_1okWDLA@mail.gmail.com>
Subject: Re: [PATCH, v2] physmem: avoid bounce buffer too small
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=mnissler@rivosinc.com; helo=mail-oa1-x30.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 29, 2024 at 12:12=E2=80=AFPM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> On Thu, 29 Feb 2024 at 10:59, Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Thu, 29 Feb 2024 09:38:29 +0000
> > Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > > On Wed, 28 Feb 2024 at 19:07, Heinrich Schuchardt
> > > <heinrich.schuchardt@canonical.com> wrote:
> > > >
> > > > On 28.02.24 19:39, Peter Maydell wrote:
> > > > > The limitation to a page dates back to commit 6d16c2f88f2a in 200=
9,
> > > > > which was the first implementation of this function. I don't thin=
k
> > > > > there's a particular reason for that value beyond that it was
> > > > > probably a convenient value that was assumed to be likely "big en=
ough".
> > > > >
> > > > > I think the idea with this bounce-buffer has always been that thi=
s
> > > > > isn't really a code path we expected to end up in very often --
> > > > > it's supposed to be for when devices are doing DMA, which they
> > > > > will typically be doing to memory (backed by host RAM), not
> > > > > devices (backed by MMIO and needing a bounce buffer). So the
> > > > > whole mechanism is a bit "last fallback to stop things breaking
> > > > > entirely".
> > > > >
> > > > > The address_space_map() API says that it's allowed to return
> > > > > a subset of the range you ask for, so if the virtio code doesn't
> > > > > cope with the minimum being set to TARGET_PAGE_SIZE then either
> > > > > we need to fix that virtio code or we need to change the API
> > > > > of this function. (But I think you will also get a reduced
> > > > > range if you try to use it across a boundary between normal
> > > > > host-memory-backed RAM and a device MemoryRegion.)
> > > >
> > > > If we allow a bounce buffer only to be used once (via the in_use fl=
ag),
> > > > why do we allow only a single bounce buffer?
> > > >
> > > > Could address_space_map() allocate a new bounce buffer on every cal=
l and
> > > > address_space_unmap() deallocate it?
> > > >
> > > > Isn't the design with a single bounce buffer bound to fail with a
> > > > multi-threaded client as collision can be expected?
> > >
> > > Yeah, I don't suppose multi-threaded was particularly expected.
> > > Again, this is really a "handle the case where the guest does
> > > something silly" setup, which is why only one bounce buffer.
> > >
> > > Why is your guest ending up in the bounce-buffer path?
> >
> > Happens for me with emulated CXL memory.
>
> Can we put that in the "something silly" bucket? :-)
> But yes, I'm not surprised that CXL runs into this. Heinrich,
> are you doing CXL testing, or is this some other workload?
>
> > I think the case I saw
> > was split descriptors in virtio via address space caches
> > https://elixir.bootlin.com/qemu/latest/source/hw/virtio/virtio.c#L4043
> >
> > One bounce buffer is in use for the outer loop and another for the desc=
riptors
> > it is pointing to.
>
> Mmm. The other assumption made in the design of the address_space_map()
> API I think was that it was unlikely that a device would be trying
> to do two DMA operations simultaneously. This is clearly not
> true in practice. We definitely need to fix one end or other of
> this API.
>
> (I'm not sure why the bounce-buffer limit ought to be per-AddressSpace:
> is that just done in Matthias' series so that we can attach an
> x-thingy property to the individual PCI device?)

Yes, that's the result of review feedback to the early iterations of
my series. Specifically, (1) a limit is needed to prevent rogue guests
from hogging unlimited amounts of memory and (2) global parameters are
frowned upon. Setting a suitable limit is much more practical when
targeted at a given device/driver combination.


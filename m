Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E139E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 13:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM5nH-00050e-10; Fri, 13 Dec 2024 08:33:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM5nE-0004zx-2Q
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 08:33:21 -0500
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM5nC-00010j-Ck
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 08:33:19 -0500
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-6f27c47b4e6so4205657b3.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 05:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734096797; x=1734701597; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=piXXDZNp+2KqmXj1aW1aqNKgH/s5yCr0icvW0IsA9Hg=;
 b=OwdxxTbOHgrKiIJBpck0sDhESM61FtdD1fX3qdAnEQBCOEaeG1epY48f+htRVGBTkl
 qHCKGZhQYa3uUBbmA3YjYPUgHbg6qwbTgzGolkwAwNPZqw7RNfIlOfbv3y9jLU7fd4wv
 6g5wGtou4x0ZclN9VvXvKhuZgIfBrDQxCgLJ0pPhNk/i5dERTIAVXwrzCkQ7w3Sy+Ixu
 YnjRl/cWe+Q8jBejCYGSXk+5VehAo4YIxQ3ZGJeyjhIFgCL41UaxurGSePBUMQf74HYf
 riVOzWmsggYtBvdAJ7qluN/d5ZX8ZwHq7j5FM6IAkUifI6LEBFUOG3j1pWUAUKPHmghc
 5xJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734096797; x=1734701597;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=piXXDZNp+2KqmXj1aW1aqNKgH/s5yCr0icvW0IsA9Hg=;
 b=vgePTqV+dDZts4PyJVgz0SrfxvTka3Rdv4/lRShhcpksBMZhRjj+A9kRmnsOkuKVFM
 6Oit4qepKBGsvBDXedwR4fDbeT7dgF3XH1CsvmbE7wIsKcaLOj3DB751RzxW25A/FA6Q
 wKUBvihzinlPwUQrgZ7oawXAc4rgafqXQOI49ikCfHzHN4f4DSOn1hb55R7EG3hJGfiX
 4P1Ib8qY+pmcqBh3DjKNDoBkXOzCX7ezLxay/1A4tGzqhsdqBUpd7by0Ha7Og7yyBGNO
 2JM92EFVIozbV+OrF5efqKKAverjDmxvsc3yc6DaMg6CE1xdMcOaJmoMvUKkhHgymZK4
 5SeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCURgQ0TQ7o1PVg5eazV9Qx9MGuG+ozkSkUWpZ4GnXY8oF3c3D1N+IDESFbPilij/KdBCHRz0aN9s6ai@nongnu.org
X-Gm-Message-State: AOJu0YxuIdkUiJoNZqE0MR0ueR7hgseB571DRfMK7Youqc9GCaQr671z
 oNs+DFVRZaGaCRSFuCG+G0oA74dvC8dZgW2ZwnSRvLQt5MCumG4Wip/LLMs1zZV6JTFSTkrFavc
 TtY363i96uDp/LP1V5ORfDGJG+PLh3zAVmcNKWQ==
X-Gm-Gg: ASbGncto8gjN/XwwOOqskQHm6N8lrZWnPZZ1DacutpKxMJMkkNxvSSOiVUwrah1O9Bt
 i1hUNx8yzJGTX2dU1/waZYgH5vKv8yCnFq3PEX3g=
X-Google-Smtp-Source: AGHT+IF+niEYp2VW6snDtXCZIFdRKv5C4EzAfiOiO55s2/sYkM5ywAN5IexhepkTk13VQrB7VHeH/P3I3tyC9vvW0KU=
X-Received: by 2002:a05:690c:748a:b0:6ef:5688:f966 with SMTP id
 00721157ae682-6f279b9bb53mr24243737b3.37.1734096796837; Fri, 13 Dec 2024
 05:33:16 -0800 (PST)
MIME-Version: 1.0
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <Z1wh69_gZ9izr1iU@redhat.com> <Z1wsslDnwlth3A8+@nvidia.com>
In-Reply-To: <Z1wsslDnwlth3A8+@nvidia.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Dec 2024 13:33:05 +0000
Message-ID: <CAFEAcA8TW2RKyFnh-TZRpfaKfZipHD5TZy_hymUr41GJ4rs4xA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, eric.auger@redhat.com, nicolinc@nvidia.com, 
 ddutile@redhat.com, linuxarm@huawei.com, wangzhou1@hisilicon.com, 
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
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

On Fri, 13 Dec 2024 at 12:46, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Fri, Dec 13, 2024 at 12:00:43PM +0000, Daniel P. Berrang=C3=A9 wrote:
> > On Fri, Nov 08, 2024 at 12:52:37PM +0000, Shameer Kolothum via wrote:
> > > Hi,
> > >
> > > This series adds initial support for a user-creatable "arm-smmuv3-nes=
ted"
> > > device to Qemu. At present the Qemu ARM SMMUv3 emulation is per machi=
ne
> > > and cannot support multiple SMMUv3s.
> > >
> > > In order to support vfio-pci dev assignment with vSMMUv3, the physica=
l
> > > SMMUv3 has to be configured in nested mode. Having a pluggable
> > > "arm-smmuv3-nested" device enables us to have multiple vSMMUv3 for Gu=
ests
> > > running on a host with multiple physical SMMUv3s. A few benefits of d=
oing
> > > this are,
> >
> > I'm not very familiar with arm, but from this description I'm not
> > really seeing how "nesting" is involved here. You're only talking
> > about the host and 1 L1 guest, no L2 guest.
>
> nesting is the term the iommu side is using to refer to the 2
> dimensional paging, ie a guest page table on top of a hypervisor page
> table.

Isn't that more usually called "two stage" paging? Calling
that "nesting" seems like it is going to be massively confusing...

Also, how does it relate to what this series seems to be
doing, where we provide the guest with two separate SMMUs?
(Are those two SMMUs "nested" in the sense that one is sitting
behind the other?)

thanks
-- PMM


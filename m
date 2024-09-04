Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 518DBCD3431
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 09:01:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slltU-0003mx-7C; Wed, 04 Sep 2024 05:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leetroy@gmail.com>)
 id 1slltB-0003N3-KJ; Wed, 04 Sep 2024 05:01:23 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leetroy@gmail.com>)
 id 1sllt8-0005fN-RW; Wed, 04 Sep 2024 05:01:20 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-715e64ea7d1so5353278b3a.0; 
 Wed, 04 Sep 2024 02:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725440476; x=1726045276; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ew8CZVkx/AZktCKaLycnTdWlbR++RhXgyH2pplM37P4=;
 b=hWyKfVmAjfEb87KrY6w5XyjMSCQg8Ryogbms25fIx9GMw9luRZy7F/iKpDc1vl/l5E
 WFSX/7GEjwrgM8wvL7DPyIiVC/oZ9kKX+ZZuXVm0695UDqAQonH4rQe3WQCpy/zLAB34
 pLUJkRlJuSWzItCyQB997V7QvKQ8VELmWyJmJZKHfF6qQdQUPQXJgSo202vRvCArlZqv
 1USsW/uZmBGBiP2TCZeJyUJYtYj1p4C1GYjVLizWkB0TAS+EzFdKtYFNYeG7faO20pei
 MBj4+SafP5phMj8QeleghryfqMKg33s5z41BrasrCRy0Qp2saHQf+xSiudjsUDTySfHn
 B5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725440476; x=1726045276;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ew8CZVkx/AZktCKaLycnTdWlbR++RhXgyH2pplM37P4=;
 b=G/tFvaSCqBQVGVClEOGLe9hH3KUep51fC3h4ynFHaAC9L5Nwggm4oSyiRKiBPIKrnk
 W/UwOr5ayj4wsAbLaVDR8gtNkIidnyFK+zdtweUUW+3uPvdPJUWehOAMC0ERkxdGDyy9
 61c0geSz6ggL7eqLMuY5nEyXbkG2fEXH/n94z+zyz4VYohJKC6jQ3g3pB+3S5YKzNdO/
 reC3j8r7mnWtIHuBKSZtWa0TCT8DP1yV29Ke1+ibbVARidGFZ71i8Z5z2neW5thI3MiQ
 8eZu2l9o6NGhQGG2jEBHr2dkVaa2DlKLnqJXbUnkTIVR7PJGLv9kKnidyKLHQh54+rRO
 z3mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0V3hoNjeL13z1w8MJjVujjwYBEn8+IEa2Nldh2jtL9jpT2x9+rmbOAjn1uxQ4FXO5A36qLHZWzg==@nongnu.org,
 AJvYcCXMdC8V3AoqXOxLiFvdJfI0nTP4ZteQm03lznPqlTST8mm7OVGl8lBu+CTbtwlKxIkcpiUGNV8UBWQMvg==@nongnu.org
X-Gm-Message-State: AOJu0YwMq/ByRaY+U58oODPDbMOOuiYfXrlOyrfuo8FHBrAs5vPVCQfv
 DTtY/H9yfzDFHzv2hVG3viUOoyEled8CFLKPF7opZ3yBm1fvdzqhjlhP6mGXdXYZC8s9/05fEkQ
 rdSZvUP3mBR/yGyLZSc0E1TB8Mtw=
X-Google-Smtp-Source: AGHT+IEeDCG7K4yrAcfifSPdfxdZexdIeRQ8+Kxcczle2vMsamMNzpsgDqvCkP3ivFkfbaqO9ln4nbIv2/zzA6e2YYA=
X-Received: by 2002:a05:6a21:6b0c:b0:1cc:9fa6:d3a5 with SMTP id
 adf61e73a8af0-1cecdee3cc1mr17286837637.10.1725440475842; Wed, 04 Sep 2024
 02:01:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240903083528.2182190-1-jamin_lin@aspeedtech.com>
 <00aac81e-ff43-4526-960c-782e27ae043f@kaod.org>
 <SI2PR06MB50418DD956AC152E4E0911CDFC9C2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <c418168b-eb5c-459c-85b1-c7766102e558@kaod.org>
In-Reply-To: <c418168b-eb5c-459c-85b1-c7766102e558@kaod.org>
From: Troy Lee <leetroy@gmail.com>
Date: Wed, 4 Sep 2024 17:01:08 +0800
Message-ID: <CAN9Jwz0cRRb308_ZOuwOsJsPLiKp3sugGJ-YzhvALv3-f+yaCQ@mail.gmail.com>
Subject: Re: [SPAM] [PATCH v3 00/11] support I2C for AST2700
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Troy Lee <troy_lee@aspeedtech.com>, 
 Yunlin Tang <yunlin.tang@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=leetroy@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi C=C3=A9dric,

On Wed, Sep 4, 2024 at 3:29=E2=80=AFPM C=C3=A9dric Le Goater <clg@kaod.org>=
 wrote:
>
> Hello Jamin,
>
> > Just want you to know that I and Troy are working on the following task=
s for AST2700.
> > 1. Support boot from bootmcu(riscv32) instead of u-boot(Cortex-A35)
>
> Oh nice. This is a good topic for heterogeneous machines !

The basic model for bootmcu(risc-v) is working now, but we're looking for a=
 way
to integrate sram/mmio/dram together.  The ivshmem requires PCI, it might b=
e
too complicate for our use case.  There is an ivshmem-flat probably more
sutiable for us.

[PATCH 0/4] Add ivshmem-flat device - Gustavo Romero (kernel.org)
https://lore.kernel.org/qemu-devel/20231127052024.435743-1-gustavo.romero@l=
inaro.org/

>
> > 2. Support GPIO.
> >
> > After we finish above tasks, we will upstream QEMU and send our patches=
.
>
>
> There is also this issue we discussed privately on SPI write
> transactions failing on the AST27000. It looked related to
> aspeed_smc_do_snoop() but we don't have a good fix yet.
>
> When time permits, could you please open a gitlab issue with
> your findings and logs, so that we don't forget.
>
>
> Thanks,
>
> C.
>
>
Thanks,
Troy Lee


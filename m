Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4990BCFC516
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcuB-0008KG-9S; Fri, 21 Nov 2025 20:59:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vMbpp-0003NM-SC
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:50:41 -0500
Received: from mail-il1-x132.google.com ([2607:f8b0:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabihestefan@google.com>)
 id 1vMbnn-0008Qy-NX
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:50:38 -0500
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-43379b57065so36565ab.1
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 16:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1763772500; x=1764377300; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VfohI4ZesDVgxljj2Xjn7DIzuGAqMdIVECFPKbt2OKM=;
 b=DSl9GEovQO/8mydClP9ZTxuD3uX4o2arcuU6CQ4wA5NY9sY+GVOiPTQtXrw+C+/HlX
 aERsknqMNDRvjGmdAEFuMJPXoY7D1nHvbWmYXGlGVyb+hxqeEalb5zg24Q2uBOT6qA8g
 T4Wp04emlf86nFzXo6qmjm91Nsfzu8WKB1T7CrMKb7VZbPW7AIQe241QmK+lYi+QuuiO
 LLzti0IA09ZQ2lmobGfg2IZU1B0UicUohUSYErGbMZ3tFDZK4JF/PupG4QIfkqnlZ5hw
 BHYaW+q5Uhe7SplDv6Of/WCkgbySoxw4YKxS2LdGyh9OiQ37FWDy5jDzxvwkukXdbvFi
 YkUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763772500; x=1764377300;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VfohI4ZesDVgxljj2Xjn7DIzuGAqMdIVECFPKbt2OKM=;
 b=t+b7CpqK0XrrWe5Hue6W+bZKHi/IlnxnC3bo+fR6C1OOBSU9a1CU3fzFo4cY4y4Slb
 l6Y0gj89huJVjEh7V3Z+EPfWQkhoq2zQqVNBkBoQATgfFrtPpao2CY4sIMjecK/vH8Qc
 V7HBk3PCOxGnlOPtOGVBl0i/8Uwc4qEkpBq0bZnhfhw8mezhWa62Y1yDfw9tvdkRjtbk
 QQ9K3boL52WfcTsgHXAj8jXwqZbSIvJ20atqZr6CdwLfK7/lLrNc2gb9h6EQR9W43ybp
 WemrX3slVKW7Te4f+BXptLvbBbJRxbrziH/vN2LuZ0XFvsiRsiVCr2s4MVWQ5XVguNGT
 d4hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRjccbJ2krGgeyiG/EOkhK3thHBPv32Bc6v6MXG2UYfCOVu06Kz+thT2vJm3Q+7RY2I5xTRLUTs7qX@nongnu.org
X-Gm-Message-State: AOJu0Yz84bdTAhZHUcXmtkZRZNOF61KzPI96JaGiIPyS0zpev/E15DbD
 PeUMyZO5ubW1ijJuFmYq8QgjSWO+v3yzYImJ8CXyEd6nSOw7G1JEGsXejvaE8j4BAkBxnW+MGxP
 TkuUA0NmAukMZPMgF4rsIwE0FPIYYn8qosSMioNLYdzOjl7AD/MGaKIzlj9Pv7jnT
X-Gm-Gg: ASbGnctqSjXH2mz4L8TzYTpB+H0hetsCFNdlIFRIKq3Wn6VZSmtE4B0RWBPBt1yo2+K
 lX0RpREfESN8F8GNryUwlI5LmYLH9ihB8xflHEGh7VsRsj1/klLjYUKpBFeGwkMPALrz8ErpLGQ
 cqDEXqmWYVgtnK7xIYqnBVcUGxhOx7KigzKcfR/RvZEwt4V8dgeuyAOXIbYBZqiKkJe6OFTZvfu
 QTcomCSY7Xot9Uag8EVZyoI8DqGrhusdtTnbBMR5x1r3aYPJnQAzW4Uf5e+VZrVAQrj/EAmXKqS
 iUyMzZdEtiXpowtI6+mckt+88A==
X-Google-Smtp-Source: AGHT+IEDl+YXxrkmLWtlDaOM6/sKpBey+hHUuLtr+6bBZbFiWZpre0mfNEXJL9aVLlCpsbzcApR7mm9mgbL0WOI3EjY=
X-Received: by 2002:a05:6e02:2404:b0:433:5ac6:78e with SMTP id
 e9e14a558f8ab-435b847f715mr6800105ab.16.1763747225768; Fri, 21 Nov 2025
 09:47:05 -0800 (PST)
MIME-Version: 1.0
References: <20251121050108.3407445-1-jamin_lin@aspeedtech.com>
 <20251121050108.3407445-2-jamin_lin@aspeedtech.com>
 <f5892baf-cb8d-4026-9c1c-c8761889729a@linaro.org>
In-Reply-To: <f5892baf-cb8d-4026-9c1c-c8761889729a@linaro.org>
From: Nabih Estefan <nabihestefan@google.com>
Date: Fri, 21 Nov 2025 09:46:53 -0800
X-Gm-Features: AWmQ_bm2LF82oMGJ6gduvrvr8gyRvfSR87bKfL8B9iI0yaLErtHRaRR6HuP0PHM
Message-ID: <CA+QoejWajueR+y-StkT-uYtHhpyHS2GEgUR4kyrZ3wjpijgcXA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] hw/pci-host/aspeed_pcie: Update ASPEED PCIe Root
 Port capabilities and enable MSI to support hotplug
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Joel Stanley <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 troy_lee@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132;
 envelope-from=nabihestefan@google.com; helo=mail-il1-x132.google.com
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

On Thu, Nov 20, 2025 at 11:06=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 21/11/25 06:01, Jamin Lin via wrote:

Thank you for the quick turnaround on the bug fix, Jamin! Tested it
against internal models
on our end. Hotplugged devices now appear with `lspci`.

> > This patch updates the ASPEED PCIe Root Port capability layout and inte=
rrupt
> > handling to match the hardware-defined capability structure as document=
ed in
> > the PCI Express Controller (PCIE) chapter of the ASPEED SoC datasheet.
> >
> > The following capability offsets and fields are now aligned with the ac=
tual
> > hardware implementation (validated using EVB config-space dumps via
> > 'lspci -s <bdf> -vvv'):
> >
> > - Added MSI capability at offset 0x50 and enabled 1-vector MSI support
> > - Added PCI Express Capability structure at offset 0x80
> > - Added Secondary Subsystem Vendor ID (SSVID) at offset 0xC0
> > - Added AER capability at offset 0x100
> > - Implemented aer_vector() callback and MSI init/uninit hooks
> > - Updated Root Port SSID to 0x1150 to reflect the platform default
> >
> > Enabling MSI is required for proper PCIe Hotplug event signaling. This =
change
> > improves correctness and ensures QEMU Root Port behavior matches the be=
havior
> > of ASPEED hardware and downstream kernel expectations.
> >
> > Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> > ---
> >   hw/pci-host/aspeed_pcie.c | 40 ++++++++++++++++++++++++++++++++++++++=
-
> >   1 file changed, 39 insertions(+), 1 deletion(-)
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
Reviewed-by: Nabih Estefan <nabihestefan@google.com>
Tested-by: Nabih Estefan <nabihestefan@google.com>


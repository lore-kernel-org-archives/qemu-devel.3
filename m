Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23157EC1E91
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 10:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnwI5-0008JH-Dx; Thu, 05 Feb 2026 05:08:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vnwI3-0008Hv-FK
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 05:08:47 -0500
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vnwI1-00060G-5b
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 05:08:46 -0500
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-79430ef54c3so7457417b3.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 02:08:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770286124; cv=none;
 d=google.com; s=arc-20240605;
 b=PPHUmgG9cUNwIYAeFYhyFlInmSsttEUX7t5cc1U0LWUL0wjqeNuEk33VQWsk6rgKSO
 dWV/JaQFL9v+CPK5+sE8ICOXvsWfGy2PJ2czr7a+6Qyic0jWIVVwOw86UIKOwDeLqwAT
 rxn909WQYkZVkGI1miiA5HM3XQ11uf8/2yKlen6pTCms32YzC5fIsbWbVLRoAW5Nw08m
 IAEE75/XMw4c6yIotrrEZAD5h7ynBJR6yv3s/9LDb0Tz22fSvvhn96O9IAnv7gmP9CAx
 rW/akAsKlCkaPja/rR6SQ3v+UPVFt33YynKYlskY6Xds3NGOjroJW39rRv81lRzLSpkt
 T+4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zZGf57OTFyBpTKAezW0EbwiHzwWufY0vou1uc1E83/g=;
 fh=680EJJQrqnaNNw1y4v7LgIv30ddMSFWeCyB1X2vnKFk=;
 b=GrA4pkCPXdeBwwTOXVC3T9G03QpW+wPQX4qx8PjCUix3gB7TzKb0i8J5Cn+W5fVGXe
 hGhamXZLZhGqFxqXpdi08xILwbX3H/blmyp8EfoONnJfAJxDXEwt2sqz4jk78CYlWMAi
 p6mmdR1og2jNxz2T7O8C3QlhTFz+dUkv2A4x3v9YCVAgQvDvf/KLrYLxxLssGNiUthra
 0pZagdS04J49QMqC4o30NkPZ0oRPLvnDCgluLvC8PsB3yCP9UVVfwfARJsiGRm8q3SJE
 4bKotCSJPdmmIPCPaP8YNKJjDzPSG5R9DruJveeX6cdtuAGv3UbsRoflOfygR9mLr1XM
 6frQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770286124; x=1770890924; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zZGf57OTFyBpTKAezW0EbwiHzwWufY0vou1uc1E83/g=;
 b=aCVKPAGNi4xS2Bsdhj1WGR6YWlS+LMz4cyptvuFcarvqx2lCNwl3uZNt2n97UJm8Js
 T/PFkaT3vy7cXu60MO7L364SB8AlY8dt0AW9VWTOg0Ey+wHH3VuP0LovfKnuDvtX3Qp1
 IAZtyfUr4+x9oM+eGZYaTYKsXYP4U7RP8NgF67OLJM8IIvYj267yxLaLDpRJ43lTVblf
 WTyXqhIXDnz5H5kugVTgNLYB8J7iPVIL40NsYySdaGIoiOMola2+5xtJqUTFQq0Qv+Be
 gOdGyBYdMy/VUKnAJ4KdiL162hrG+4ml75cPiQ2L7PepUCoNporgcMJjMQVbhY5Qn+4T
 lmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770286124; x=1770890924;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zZGf57OTFyBpTKAezW0EbwiHzwWufY0vou1uc1E83/g=;
 b=gDkVhqpovq5IjRKb8OSI0pojK5IIJWKB49eO9l3KQDHh1cMVm7RMf0906Sw7N0N75z
 DysxRJBLpNMRKuR3XA0QmCVMa4tgPTyHS1OBqAxdht6q2hg9yopil8mYg1FOkSJM2dZG
 EtrwuqRG0O72G/X8QelzvLF2nLjmrHoJxp9ARojUvIZ1XxLM3/TPfoXcehZ9nzaVWsIb
 95cp9dMmQ4hVymWP8UWVMJ0wCENI/0VKGLHkMe6I7PGmjcXcPJPvrnMud7D7ViuNdLcc
 T0WaTq1mlHUHCd3WoCzgi+3YGGFo3GBrknaQGI56UbqurCoZoq7yXODRjnsZW5DodDXQ
 +ujg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUntGMwxDcjWa03m1XacQAd2kgLwxBCKzXK6SfYF9NzlTcHdsWVnCCAOXnO/Bj5HGd6PVa/g2dt1clk@nongnu.org
X-Gm-Message-State: AOJu0YwDaXkcRiQlOUt9C6lno9mIoRiCIrZ+X0/cEHUTocNqdflc3Hdl
 OIGcxWYhD7xoieGpxlWNoFyYQtAJ3GEa7g2SC2r/rBbrjNX8omIo7zUtR1xUheL11Vo+j5GUeqK
 pPj5kSTgNSt4A/4gTzNRCp2/9Cp4UZlvszozZhZ5qNw==
X-Gm-Gg: AZuq6aL8pcANvZsxJqN4X6TxIISNB1UNgkTdUVEXAKQD1/+/1jMIly9fa6EyTNMh1Zw
 mg8nLAzqschBD2FVOceRXdSIrRhgcHnnar+YyiafBViDIbdyf6/T7TzBou7vnGRFvvw/EhVP7cc
 eqyIO64Ujn2YLguPajpSu4iC7izfNr3XixuQeEym1tLMSH744RI9fyfAz8Db+TRSN1Lqsl7WrSP
 Sf7+nExFcwkmXAxOoN0dx20AvicGX+k2HShRlmk9b2h2r6dbvAprdm95G38uYvGbnUgHg==
X-Received: by 2002:a05:690c:305:b0:794:fcf8:f824 with SMTP id
 00721157ae682-794fe692adcmr57612817b3.28.1770286123732; Thu, 05 Feb 2026
 02:08:43 -0800 (PST)
MIME-Version: 1.0
References: <20251211102025.873506-1-me@linux.beauty>
In-Reply-To: <20251211102025.873506-1-me@linux.beauty>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Feb 2026 10:08:32 +0000
X-Gm-Features: AZwV_QiLlvkymMPBYxReoDKgqnks0cmtehoARLLhJfZ8g73tl9u9K64Boo4K3kI
Message-ID: <CAFEAcA8FcW22-TnyBKHmFUUsR=xk2u-74uPz6KisJTeG=YWxmQ@mail.gmail.com>
Subject: Re: [PATCH v6] acpi/virt: suppress UART device & SPCR when guest has
 no serial hardware
To: Li Chen <me@linux.beauty>
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Sunil V L <sunilvl@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 qemu-arm <qemu-arm@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, 
 qemu-riscv <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 11 Dec 2025 at 10:21, Li Chen <me@linux.beauty> wrote:
>
> From: Li Chen <chenl311@chinatelecom.cn>
>
> virt machines always instantiate a PL011/16550 UART at slot 0 and describ=
e
> it in ACPI (DSDT and optional SPCR table). When the command line disables
> the serial backend (e.g. "-serial none"), the guest still sees the UART a=
s
> a preferred console even though it is not usable.
>
> Teach the virt ACPI code to omit the UART device and SPCR when there is n=
o
> serial backend attached. This matches the hardware that the guest can
> actually use and avoids confusing firmware or OS code that relies on SPCR=
.
>
> The bios-tables-test qtests rely on an ACPI UART node and SPCR entry for
> UEFI-based virt machines. To keep those tests working we create a UART
> with a "null" chardev backend instead. This preserves the ACPI tables
> while discarding the firmware's serial output so it does not corrupt the
> TAP stdout stream.
>
> Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
> Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

Sorry, I must have missed this patch previously. I'm not sure that
this is a good idea, because it means:
 * the dtb version of virt and the ACPI handling diverge
 * we tangle up "what chardev do you want to connect serial output to"
   and "what UARTs does the guest see"

If the user explicitly sends the first serial port output
to nowhere with "-serial none -serial stdio" they presumably
had a reason for that and won't be happy to find that we've
adjusted the ACPI tables to redirect that output to the
second serial port they were planning to use for something else.

thanks
-- PMM


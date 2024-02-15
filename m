Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE0EC48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 09:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raXsZ-0007qN-Jt; Thu, 15 Feb 2024 04:18:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1raXsX-0007lz-Gv
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 04:18:01 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1raXsV-0001qg-RH
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 04:18:01 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-296043e44caso520759a91.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 01:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1707988678; x=1708593478; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ijxFDjhnIkpAQ3MRe5MDaADGtYJ09Q9Uu0SWLJuAY8=;
 b=kCukTzi7k04T2Re3WGwU3VE5Gs53vnULd2f4aS3PIHrSS3kgS6FFP5YYEnLRX7PeHE
 yhNJIo9P7RmY1PONVcNWseWCmlNfqDlMs2MhiO2BNRKRZqFhPTkE4jwSyyrb9qeA3h1t
 nDYvXkZlUhaVntgMNFyb3wIJ8LFTtYA9MC20gljLQ3M+oTmyqg4PTJvrSk+R6uoGQ+B2
 //oL/fsbKvGKbYsJJffdyyBlUj16CfTVMTADD6kByZCZXOyWwJCaKRhDdcSztGGPj7OY
 Yu78lCvYrTy4FkScwFxdtn9jEWGOwHFjY77TgdG3KLHOigZSYtg+4aB6tud6dFs9iadL
 Zhuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707988678; x=1708593478;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8ijxFDjhnIkpAQ3MRe5MDaADGtYJ09Q9Uu0SWLJuAY8=;
 b=JaEaAt9xu6a41h2ySwgn60y87lK8CBtqoDFRnGgscYRaWr1IfybUNPdrzqDU/uvlRH
 7QHTNBiU/7IupcVMEI8QuX3znHbr4fHldh6s5N7d5E1yh6babCRk5ukRazDgOy7yV8Wc
 VEDnEmqOO1U+M6ZqWVxNa4RIWAJIKIpeZsjjd+jjiDioXAvkMrA8DhQ57HDPZJi34ARm
 onOmGwawGtGJp+tRj7omTN8j4wViCjZV18QnNQ/lisxZ3/tN4PD+31Np6rI6v2txHySa
 eW5Dt7wSJiSKgxpejWO1EXlhRMZ6Red56dcAubS/new6pZGihdJpF8xxcUdWb/yDRqaR
 4zWw==
X-Gm-Message-State: AOJu0Yz0ZNz6acmL5NSLkn00XlK09XRDSlFAQd/8o/NCF1pNkpn/HXzl
 0qm9OQQsWC+N+U8dIdXlKIPRjtdP7DPljadNqdRvAqUt1nX2mdKs9aKJpWtYkUtus4mNlVMEIQx
 1Bm0j8AX6vO0YxKZ+zaf72Z9GZO2ZRnBXrohs
X-Google-Smtp-Source: AGHT+IH/v1kUGNLya2HjchCDP7DledbcCp/gfOWc5OdJ6EEykO6uRbvr6ZZlfdXYg28UVW+RCtrsLtngR2uHLE9hEIY=
X-Received: by 2002:a17:90b:28d:b0:299:1f80:8c44 with SMTP id
 az13-20020a17090b028d00b002991f808c44mr106457pjb.40.1707988678074; Thu, 15
 Feb 2024 01:17:58 -0800 (PST)
MIME-Version: 1.0
References: <20240131085047.18458-1-chigot@adacore.com>
 <81348d06-49f0-4102-983e-d6cf80e876a1@linaro.org>
In-Reply-To: <81348d06-49f0-4102-983e-d6cf80e876a1@linaro.org>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Thu, 15 Feb 2024 10:17:46 +0100
Message-ID: <CAJ307EhF_6_ssOje4HaL6ASiCbtkdA5CY98gtkZfRLcmX4ubiA@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] sparc/leon3: Add support for -smp
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Frederic Konrad <konrad.frederic@yahoo.fr>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=chigot@adacore.com; helo=mail-pj1-x102e.google.com
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

Hi Philippe

On Thu, Feb 15, 2024 at 10:02=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi Cl=C3=A9ment,
>
> On 31/1/24 09:50, Cl=C3=A9ment Chigot wrote:
>
> > This series allows leon3 emulations to record up 4 CPUs.
>
> > Cl=C3=A9ment Chigot (9):
> >    sparc/grlib: split out the headers for each peripherals
> >    intc/grlib_irqmp: add ncpus property
> >    intc/grlib_irqmp: implements the multiprocessor status register
> >    intc/grlib_irqmp: implements multicore irq
> >    target/sparc: implement asr17 feature for smp
> >    leon3: remove SP initialization
> >    leon3: implement multiprocessor
> >    leon3: check cpu_id in the tiny bootloader
> >    MAINTAINERS: replace Fabien by myself as Leon3 maintainer
> What is your base commit to apply this series?

It's commit 11be70677c70fdccd452a3233653949b79e97908
    Merge tag 'pull-vfio-20240129' of https://github.com/legoater/qemu
into staging

Cl=C3=A9ment


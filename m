Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE78EA3C22
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 10:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAmE8-0001ba-5T; Thu, 09 Apr 2026 06:03:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAmE0-0001TM-B2
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 06:03:01 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wAmDx-0006zU-HW
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 06:03:00 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-65005a8840dso653860d50.0
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 03:02:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775728976; cv=none;
 d=google.com; s=arc-20240605;
 b=EGWKhKC858GrdXUkUfX+z5X3c4iuZ/E4ToAwiOGMQkzVUvMdV0YolevP5dtH+eWgpu
 bEiGgPUcWTZAaBp6j/w1CGhgyoJ8Ot6fOZaWpCM+aIasKqNdcIMRMDpJ/8iKpET9tt/J
 TNO8o+4xiDNvTKJDe1N9klsf+Lx6IYLZVsn1aoeFwCwlt5wQO+J7JqK2/Ie0H8fE5dwz
 +4ZKIm1TUCI/DKpZwhVQiX5QKEd2AqXRq94kAzgf7jyUqxUoRhtx7Ho3mjR/AXL7y6OM
 tBec4plq2FMx/5SJMxD7aq9vacYOJPDakzxDmMHmStWYUFcqXHcUWygLyY3qifm9v/DA
 LVwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tgI2iP8Na7SJHYxQqxIsvVgP3n0/H2Ro+rDmqpBa+Mc=;
 fh=ZKds+nUgoQEsVQWyLb5eyl+oP68VH/5k4ombeful5ps=;
 b=cX/JVkR3gvaXQW5EWUeuxNLZvIJlprO0ihyyMFeum343c2kEsd5suGLy9nxaVXFeYg
 7uVWPpi4/8cWIuQkhlk+gv7gYO8oc8BeCZfetPhGeGqX2f/GgHHRhjS3ydkviU0X5Sgi
 AFuZlExNGScmORpkz7vBWHxzfBiP1v3rE8QLkl0W5NnqQzNABdvwiN34mH1f9SJr5DJj
 pNI2NFTZGn2RzwamPy1+5zMZdNYHo+l7lXNcE1+TkoHQsloa2ZGnFSBimtG9hpBc2cuj
 MnpkIvRBKxgX/bhlhN//fFdC43qEVFEE8PAoVTN6AhQf30+fsGFqVzqLTttycAquGXqS
 S4Tw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775728976; x=1776333776; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tgI2iP8Na7SJHYxQqxIsvVgP3n0/H2Ro+rDmqpBa+Mc=;
 b=OIhpDnt5OUQZHvi2PwMf52m/r9O0RNvWF6+bPr9EwL8xQZRzndPQMhv31EeihfoKab
 tEtlR34kUWUO6U1bE5ZO17juRb+4nHfoUA/c5kPotMDCWcMvd8bqxJcIBwHkA183P4xp
 edhJKh4hEEpkaTyef3B08YJ2jg2tSypVQz1QYIijFCFRVGQIhz0JdLIc4L5cyFnseYaA
 h0zEdw6v0ijOlS6q4vECf35yfkewUPIQ8HPPDWkjjzK4kMsMUPHphi3lMQ2H0uOu9PHm
 Dj/XhQ+2IEiFol47e/D0XPbeGobbNHXVfyep3qTDrukM7Qu2VEI2WaaVNh+xbEcfYRgf
 DZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775728976; x=1776333776;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tgI2iP8Na7SJHYxQqxIsvVgP3n0/H2Ro+rDmqpBa+Mc=;
 b=b2As2IYXBy6PKlY5lIGIhj/IHCmYk2nT+nv2WO6riYMfl+nVEbrOUIdQLkj0qP1mO4
 Axi58Xv3wqniT5Bc9mmx9LMDEhDWsXcdPIB9da/R0CI/OJg5SExn+xXyMZda1CiFIsqR
 kuPgWnQ4Oc1YOf/IrQ4nOTuqvkUL3aMNttOsWlx13iSGbd8jSo1/Lt4BnHkT5bFuxoCr
 Qv5quis8DdfkR7Jsqe13nrcy5NT3aHx1bR7ONaARJw++5jJQo7QKkdWuu5FMm5FwACql
 sDwieTHxGN4wIqHQ3SbarJxuz5gW8TazYQhcA7s6613/Mbc8sBHUDbS24i0UzrH09+H/
 06bg==
X-Gm-Message-State: AOJu0YwJ0w0GS6y7nWk8x9MhAklgA7Z/A+gc9WOMPFABVODSVzkSWkVQ
 +kPk7uLJjmwU/G6cDd2z522flCtBWneqDCjnnstkEaFuAEP7fh9eUbb/cvjGodjo9UsSfagVHUT
 0M6uchRB5oPH9jdF1XZAHlKjJ/ftUFMp7ol45YDLIsA==
X-Gm-Gg: AeBDieuAxXpqtw2eDhyzW5YzXneG0Mz3+5mL2vYsu/A9GXrvjMB3ex2FQ3w8eYu3guL
 8keMoOvUN0lRMs/nGfLFk5Xl0quscOf4Rtg/p1SCzz29rpoZ9V/ZgDDiEBP7bxmrUzrPwgHc6MP
 g0JgSha3JnRaTQlqYYW6x2jNiRTJQ01DZog0d2wRF5Vq/iCoJ9RfIFmj4rs2gh7lIsjqhxdNOCy
 fu89LYhEkZSxTFNCKuKRgQsr8hEr2ZRnRjeNmkTOxr5iTdPI6OdlOlw1oEgzVZrf+ceJX/MUMba
 Kntr6MZIyh2gyZA/Fi6ojwf9thCsh8JSXbHq0v3agJmGrHaPuZc3rE0Nke+xT2RI1Ro=
X-Received: by 2002:a05:690e:1341:b0:650:2770:804c with SMTP id
 956f58d0204a3-650486876b7mr22385160d50.10.1775728975927; Thu, 09 Apr 2026
 03:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260409-fix-unit-address-v1-0-946840930af2@iscas.ac.cn>
 <20260409-fix-unit-address-v1-4-946840930af2@iscas.ac.cn>
In-Reply-To: <20260409-fix-unit-address-v1-4-946840930af2@iscas.ac.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Apr 2026 11:02:44 +0100
X-Gm-Features: AQROBzB4vOFQCtBThFeVNhz-rrhkYkTmkKfY55-jiNqvz73txdiekCaE2oNV-30
Message-ID: <CAFEAcA9uoDVk+eu=V_twEyLH6f5pa_BA4oqd8GkXBwAazFqVhQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] hw/or1k: Use hex unit addresses in FDT CPU nodes
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: qemu-devel@nongnu.org, Leif Lindholm <leif.lindholm@oss.qualcomm.com>, 
 qemu-arm@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paul Burton <paulburton@kernel.org>, 
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Jia Liu <proljc@gmail.com>, Stafford Horne <shorne@gmail.com>, 
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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

On Thu, 9 Apr 2026 at 07:40, Vivian Wang <wangruikang@iscas.ac.cn> wrote:
>
> These unit addresses should have been in hex, not decimal, as per de
> facto convention [1]. Fix them.
>
> Link: https://lore.kernel.org/devicetree-spec/CAL_JsqJFv3+UJ-bjLGk0i7Wc+spsowCrqQZ_s3P4gN8r1W-Q-w@mail.gmail.com/ # [1]
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
> ---
>  hw/or1k/or1k-sim.c | 2 +-
>  hw/or1k/virt.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/or1k/or1k-sim.c b/hw/or1k/or1k-sim.c
> index f1b1f63274..b851e48c16 100644
> --- a/hw/or1k/or1k-sim.c
> +++ b/hw/or1k/or1k-sim.c
> @@ -138,7 +138,7 @@ static void openrisc_create_fdt(Or1ksimState *state,
>      qemu_fdt_setprop_cell(fdt, "/cpus", "#address-cells", 0x1);
>
>      for (cpu = 0; cpu < num_cpus; cpu++) {
> -        nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
> +        nodename = g_strdup_printf("/cpus/cpu@%x", (unsigned)cpu);
>          qemu_fdt_add_subnode(fdt, nodename);
>          qemu_fdt_setprop_string(fdt, nodename, "compatible",
>                                  "opencores,or1200-rtlsvn481");
> diff --git a/hw/or1k/virt.c b/hw/or1k/virt.c
> index 39f54058ab..ac644f128e 100644
> --- a/hw/or1k/virt.c
> +++ b/hw/or1k/virt.c
> @@ -162,7 +162,7 @@ static void openrisc_create_fdt(OR1KVirtState *state,
>      qemu_fdt_setprop_cell(fdt, "/cpus", "#address-cells", 0x1);
>
>      for (cpu = 0; cpu < num_cpus; cpu++) {
> -        nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
> +        nodename = g_strdup_printf("/cpus/cpu@%x", (unsigned)cpu);
>          qemu_fdt_add_subnode(fdt, nodename);
>          qemu_fdt_setprop_string(fdt, nodename, "compatible",
>                                  "opencores,or1200-rtlsvn481");

The maximum number of CPUs in both these boards is 4, so this makes
no actual difference to the node names we create. That would be
worth noting in the commit message.

-- PMM


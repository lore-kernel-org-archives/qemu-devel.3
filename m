Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9122CA0EC5
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 10:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjyWM-0006p5-Ae; Fri, 30 Aug 2024 06:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sjyWL-0006o8-5C
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 06:06:21 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sjyWI-0007Rd-1U
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 06:06:20 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c218866849so1944053a12.0
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 03:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725012371; x=1725617171; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Hs2qtB5SM0sNGdXaCHjuSBmUfcX5uW/a41hVBlDatjw=;
 b=QYO9qw0YqixTp5Ih8K2cOuUUaONUhny4s/yBuwBKbkQ8Lx5jwgR7xfmXtLAzBEnL4s
 mUL534wPnvnPvvO1xZcd0n49AqCpB1QSx3nUh4RQQOseAUs5Tb/uAZ6Cpac+YZqBgPIW
 IoFzsBRkhT/d1QtG18lu57GL3jIzlE1t8Mpzxwu4YEfYmBQ3845J0sxg3mLj9TM9GXSG
 f7TaMazZWWrmJUlJaXEFg/sCMu9Vxfm0gMEcK8t6h64xqsDRMGhESke59sjbbl5spnpG
 eVRK6xOiOGhR7kEEJUM6jMW50PgtVY1Mws3x61BnIB8CeOTnTIszlNSP7LmBo08Jrg17
 LrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725012371; x=1725617171;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hs2qtB5SM0sNGdXaCHjuSBmUfcX5uW/a41hVBlDatjw=;
 b=wWihR7ECEsBDwmcVZHJ4HYZKJQRey0zzaLYH2PBY/kQumECVGZ/6Kh4O/Lq4Wh2IQm
 iOF+HJdynfVjypnqegGQVzGY79XqSK8F4a79Qi+0PfAsxI56cftWXCO+jndCaUEwWnGa
 0temrN/bHFDwY6WfYsCZuJrrAkeomJHtSUhTIFxBSRNDy9XwJ3COt7An+GqirkoJGnyV
 AU2L1f4lRH1iS9UyCgjv9S11dBggQYCRM1B9jciRNTpA7Adj3m495n2qxC2kui37PHqe
 IX/eihAp2PDuvj9nigPESJ8u3JTcCdKRMu/qwWrxGbozEF6p2yFRWtISVzeQCkBtD57+
 Ulfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHFYdqJZiX/DCvi44VweApo06ncNMY5qhQ/wukrWPGQQsA3UKh4bC+MqpzuDuLLFGdcM3oDbW8cgnY@nongnu.org
X-Gm-Message-State: AOJu0YznxdgjkTkUqziMC7w9mBRl6VPP+NIhHLvi7X8xIJO/j0I2nxfX
 1TUxE0HLKXYEh6fz+spuBdHnH4Z/x2Os+zv2v7wIYQsXvLCKlMsYrR+onyc8u+RjXC+2Vajx83T
 4MAJdamp1zikG3RkHGKhl127xe2u9Rdxn3T4bKuG4ENklYqiX
X-Google-Smtp-Source: AGHT+IHgLDnNl+Gdj9Zzmc+HnggnHMbebf9lDuRb0YKpPajhX9MXebPumhcHZpuGPlnEFINp+ywPyKEvlT+2xBsiuPk=
X-Received: by 2002:a05:6402:5d0:b0:5bf:256a:357d with SMTP id
 4fb4d7f45d1cf-5c21eda1887mr4395538a12.38.1725012370427; Fri, 30 Aug 2024
 03:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240830072409.2399084-1-changbin.du@huawei.com>
In-Reply-To: <20240830072409.2399084-1-changbin.du@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Aug 2024 11:05:59 +0100
Message-ID: <CAFEAcA995BnypV8Yx4fA_ojAt6NopyMnCWY8Gwb840++8kx91w@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/boot: Report error msg if loading elf/dtb failed
To: Changbin Du <changbin.du@huawei.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Fri, 30 Aug 2024 at 08:24, Changbin Du <changbin.du@huawei.com> wrote:
>
> Print errors before exit. Do not exit silently.
>
> Signed-off-by: Changbin Du <changbin.du@huawei.com>
> ---
>  hw/arm/boot.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index d480a7da02cf..17c01f299831 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -839,6 +839,7 @@ static ssize_t arm_load_elf(struct arm_boot_info *info, uint64_t *pentry,
>                        1, data_swab, as);
>      if (ret <= 0) {
>          /* The header loaded but the image didn't */
> +        error_report("could not load elf '%s'", info->kernel_filename);
>          exit(1);

I agree we should print a message here.

>      }
>
> @@ -1322,6 +1323,7 @@ void arm_load_kernel(ARMCPU *cpu, MachineState *ms, struct arm_boot_info *info)
>       */
>      if (!info->skip_dtb_autoload && have_dtb(info)) {
>          if (arm_load_dtb(info->dtb_start, info, info->dtb_limit, as, ms) < 0) {
> +            error_report("could not load dtb '%s'", info->dtb_filename);
>              exit(1);

But for this case, arm_load_dtb() should be printing the error
message itself (which lets it be more precise about what went
wrong). Is there a code path where it fails to print an error?

thanks
-- PMM


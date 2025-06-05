Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86233C5B552
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 14:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNBUV-0006zB-Lg; Thu, 05 Jun 2025 10:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uNBUQ-0006y2-41
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 10:22:43 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uNBUO-0001jV-74
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 10:22:41 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-70e75bf727fso11474997b3.0
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 07:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749133358; x=1749738158; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J7onJD3eHFuligvmevpPa9xDz4N+5TRlabCU7JCGjWU=;
 b=wTUrN/NacSdk6kxQDpfI0yn1htZSm9ZHq5SH1iI5C/QhEhS8WsWersrFUQGz+WFaDP
 KevBmKi0w229pTfqKzKPwShS/TBTe8RK9I6Qrbq0lIKeJvpG/EIa0FIysoYAb0o83YR/
 xq5ydLFgIjCkZWGV8Rs5nRR+qQ//zqJxGpWAlsuiA7LJOHMtUdMHoIZF6K7SVtVmJRfF
 PQoibJiJh24xwJJaECO0h08+gwi9lUKX8CvpTTA9FPgr7vdrKVPxjx3Kh3LFIyo513XS
 TX2zYTGOICVe1H40WpCQtNi4hZtyUWqIW6PKUM7fo9lYI4In9FVzrlGCaGj5d38CNSS/
 J8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749133358; x=1749738158;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J7onJD3eHFuligvmevpPa9xDz4N+5TRlabCU7JCGjWU=;
 b=R5Tt804F1OED3q4hOMptUjRqPyXqtOQzpOMCfLYrIbI6k8/4WkVJ6jvsBtQ4qRUXlR
 974ujbwFVTktQ+/ggDWQgTFlqQbmJdI+CNRrFDHIMD1k3+QaTQUPQymoz9H/ZDuX7KUF
 Ism01rHCrljVSF0AF+OCSFe42DX7Y+icDSMvFeRNRgiji98JLTx0GvGBMkawrayQeW2a
 Yb4iApBRUK2jpQY0pu1P1g/mMYbRBvKdk36tknWRvv30Ndhv37928WymSOHL8SDmtdjg
 H0SXpWmxAepZaJxG3vaCwDTVDISRik4X4+8j6xfDSdfsVw7p8fLPiaUbgAEtjs6Bk2Qs
 UBiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPeKYncIiVL0vy0bu5IH/2NbJ+lcrJvrb2fOIL1EN5m4e1rUhHj8gdSoRHbe6jHXbCHl9j5vrjMqgj@nongnu.org
X-Gm-Message-State: AOJu0YyjfvA/3EFNlSk9TU0qENvTne/pwTJZ6x/TIJD/xZ68YzIuhgx4
 +dACphwEjIUtyt1LpzFCB0nKD8sb5GqKyKCxlJilzM1oOZkYnecCyrSSIi9h6qlnbfaL/KxS9aJ
 NFIBAcVyx6GsO1V2OODULMpuHYNUEsUVuOn3NompGow==
X-Gm-Gg: ASbGncv4MSwsg7CbmV4NzCT+AfYbadJxknu7FPBa6j4t2SoFHlYnEaUN68lESmuoXVj
 cAvZAhILfNPNff44L0ZAEVxdCQbYNkfwHbt08ukqaHwH29X6OiGQ63R8TYDsYn2YldpKvtuh+ZP
 MEtFUE1vTcMTbHH9FxtdT9QS/zN/nlo6xUTA==
X-Google-Smtp-Source: AGHT+IHkzyA50IJKgFG58xntGVA/55gAMvOFbaH4L5+ZbDHD+GSyGt9Zl+oYl9JCfsvzzVf/0vWDetru4v2odQ7NwiI=
X-Received: by 2002:a05:690c:86:b0:70e:719e:754 with SMTP id
 00721157ae682-710da193a37mr86180847b3.12.1749133358469; Thu, 05 Jun 2025
 07:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250605141801.1083266-1-peter.maydell@linaro.org>
In-Reply-To: <20250605141801.1083266-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jun 2025 15:22:27 +0100
X-Gm-Features: AX0GCFu4nGAFW8d0SeBf1TqskuJ3tlCQGLS7_tK8dMBrr3Wk7wLhnd96jlO_K0Q
Message-ID: <CAFEAcA9++obh-vtp7P9MZ9GHBTjuWGY419Dmp+P8iFJhCJiYHQ@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/mps2: Configure the AN500 CPU with 16 MPU regions
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Corentin GENDRE <cocotroupe20@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Thu, 5 Jun 2025 at 15:18, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The AN500 application note documents that it configures the Cortex-M7
> CPU to have 16 MPU regions. We weren't doing this in our emulation,
> so the CPU had only the default 8 MPU regions. Set the mpu-ns-regions
> property to 16 for this board.
>
> This bug doesn't affect any of the other board types we model in
> this source file, because they all use either the Cortex-M3 or
> Cortex-M4. Those CPUs do not have an RTL configurable number of
> MPU regions, and always provide 8 regions if the MPU is built in.
>
> Cc: qemu-stable@nongnu.org
> Reported-by: Corentin GENDRE <cocotroupe20@gmail.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/mps2.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
> index 58efb41e6db..50e1a1c1c80 100644
> --- a/hw/arm/mps2.c
> +++ b/hw/arm/mps2.c
> @@ -224,7 +224,11 @@ static void mps2_common_init(MachineState *machine)
>      switch (mmc->fpga_type) {
>      case FPGA_AN385:
>      case FPGA_AN386:
> +        qdev_prop_set_uint32(armv7m, "num-irq", 32);
> +        break;
>      case FPGA_AN500:
> +        /* The AN500 configures its Cortex-M7 with 16 MPU regions */
> +        qdev_prop_set_uint32(armv7m, "mpu-ns-dregions", 16);

Rats, I failed to actually refresh the git commit with a
fix for a bug that "make check" caught before I sent it out.
This should be "mpu-ns-regions", without the "d".

>          qdev_prop_set_uint32(armv7m, "num-irq", 32);
>          break;
>      case FPGA_AN511:

-- PMM


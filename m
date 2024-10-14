Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADF2D18123
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 15:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0MnB-0000e5-Ki; Mon, 14 Oct 2024 11:15:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0MnA-0000du-2v
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 11:15:28 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0Mn8-00088H-BR
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 11:15:27 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c96b2a10e1so2699217a12.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 08:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728918925; x=1729523725; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J4ziFelFO4NeM+7LVql2YMTQ7ZNhToeLbYNoxLKbFb8=;
 b=K1NG5o1VUrhgjljkGleY8j8GLBQtfyAwMgEiW8Fn/hbcZ3F2RtNv8cN/8mylkPqBIh
 tQd+DG46mt8GZJabsluB7XkA76KfjV9adRoFr1wBIv4/vMVsqPDzs6qGU8I2XplE7xL+
 +tYPLgzc92cd4xQeAgHyFY3LGuPpnQm0dCUHkzcrMBFZYoHYkJTelDYcgo4+yNZ3aAcm
 Wt/4zFENSUBFlXSUKwj2EjbB1JgOEDHSQKZYZ6EKip9eVLYSO8z+/XPhsoV7hcfBA1o5
 3aToK7B+0OAIm4ZrpunRvfLs+VjGzdHcuh16q9YEGilPL+ksqv+3B02GmJUU7SM35Slf
 TF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728918925; x=1729523725;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J4ziFelFO4NeM+7LVql2YMTQ7ZNhToeLbYNoxLKbFb8=;
 b=mWR5QLh4CV8RC8lL2rInE4XSFVR59Ndn8L8i4lXUvGnwG9lmaaqewvo/wd+84q1tYk
 Ur62gqMlvC9+k0vsqWVQq6e2E9NuI76g3Yy4ysur7wNUBx+TnkJ+P+O23qp+wuFlcpAR
 i5vG5SL/qR82isXD0ZbCeHscZFTUI6s9ddMMDoE386/LbPX4/5R1ckWiZlKaoD7Qq3Rf
 whvA+WQdt8AOqKUSUs/0q2zRCOA4fMWYAa9SB9/ETFKbm2OrEJ8R/fJj8f1SfEki2PRI
 gFexm8zpTXsA8gqnsZR+DXgQIKH17IsCATCGyu7xG7l5zKmnZ65LMpT2WoO8SLgx6Ov3
 UX3A==
X-Gm-Message-State: AOJu0Yyr8Ymr4o+yjTITWkyw3N+c3DpkOGMJSvhrbV+r+KQ6bu6+798d
 arnN7OYXQzr4pmgzJLh5M3C1qHirMhp/wbyPmcN5iA5Mi5PAH250ERfP/sOAnY/gAxIqGKfapVD
 JZ2UQWM49h8GKbJRCjC+gO6kDE1TDLJCCpZFFmw==
X-Google-Smtp-Source: AGHT+IEBkP8yfgyNj06bZI4pTCrGv7Y2hs5ENCVDUZmR4/Qm3FkgXjGBJbStn0eynpSTQlZqnx2IaZUbF8YFV1u1M60=
X-Received: by 2002:a05:6402:520b:b0:5c9:6936:1ad with SMTP id
 4fb4d7f45d1cf-5c96936035bmr6351730a12.5.1728918924625; Mon, 14 Oct 2024
 08:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1728299530.git.chao.liu@yeah.net>
 <bcdacdcbf7b26192aebe4723c57bd87ef986defa.1728299530.git.chao.liu@yeah.net>
In-Reply-To: <bcdacdcbf7b26192aebe4723c57bd87ef986defa.1728299530.git.chao.liu@yeah.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2024 16:15:13 +0100
Message-ID: <CAFEAcA-62u9ky6YJKgLD1pFLuO5ArpXas8a-EmvdStX0djxhVQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] xilink-zynq-devcfg: Avoid disabling devcfg memory
 region during initialization
To: Chao Liu <chao.liu@yeah.net>
Cc: qemu-devel@nongnu.org, bin.meng@windriver.com, edgar.iglesias@gmail.com, 
 alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Mon, 7 Oct 2024 at 12:25, Chao Liu <chao.liu@yeah.net> wrote:
>
> During the initialization phase, we've encountered an issue where the
> UNLOCK register is inadvertently cleared. This results in devcfg MR being
> disabled, which in turn leads to unexpected memory access exceptions when
> attempting subsequent accesses to the devcfg register. This behavior is not
> consistent with the hardware specifications.
>
> This bug was not found earlier because the ignore_memory_transaction_failures
> flag was enabled, which ignored exceptions from devcfg devices
> when access was disabled.
>
> Signed-off-by: Chao Liu <chao.liu@yeah.net>
> ---
>  hw/dma/xlnx-zynq-devcfg.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
> index e5eff9abc0..af8cc72471 100644
> --- a/hw/dma/xlnx-zynq-devcfg.c
> +++ b/hw/dma/xlnx-zynq-devcfg.c
> @@ -144,7 +144,12 @@ static void xlnx_zynq_devcfg_reset(DeviceState *dev)
>      int i;
>
>      for (i = 0; i < XLNX_ZYNQ_DEVCFG_R_MAX; ++i) {
> -        register_reset(&s->regs_info[i]);
> +        if (s->regs_info[i].access) {
> +            if (s->regs_info[i].access->addr == A_UNLOCK) {
> +                continue;
> +            }
> +            register_reset(&s->regs_info[i]);
> +        }
>      }

This looks strange. Reset should reset things. If the
UNLOCK register's reset behaviour is wrong, then shouldn't
we fix it, rather than explicitly skipping resetting it ?

thanks
-- PMM


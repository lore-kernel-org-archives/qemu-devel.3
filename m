Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53AFC8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:39:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgGi-0004Bk-Rv; Thu, 28 Aug 2025 13:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ureZV-0005lx-4J
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:29:53 -0400
Received: from [2607:f8b0:4864:20::b136] (helo=mail-yx1-xb136.google.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ureZK-0000NQ-JO
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:29:52 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-5f348748d71so598496d50.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 08:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756394979; x=1756999779; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Fq/WSuZUUb7gFwdO5YuYbxD/5AbFkvBmVSaVjPtCJGA=;
 b=Yd/9GXxnQjbuEAxVU2z25WLIULpnFnyJ7Ol7OYUhm4Hy2xeUw4ZqqEAE2LJHz3Jo6I
 cGEDmH1zJPxSehonDKYo+15KRC+c4bu2P82ydmQw/UDqIkxS/Mg/BY2qaybEw1QsR8T7
 kGgwgDldPZpRuTlolL8ENbDDB+kiTJOe3WgEfu4+3ehbCP2TmNl8eXihEml+XL/Cb/XS
 bBcpKO+FAL3YPafgAhZtaRsFZqSCVgUJtkJ8ZQUBUmJxvgZZtVI9zIkkIOUh4M98I2sj
 SODMJtbXjqVb6RvSGmowAprUub5LgcF/2+3sgXEDly6rTjGUAHywLjJq8tWAmHw1tijY
 WM4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756394979; x=1756999779;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fq/WSuZUUb7gFwdO5YuYbxD/5AbFkvBmVSaVjPtCJGA=;
 b=bR/vOr3XdImBWKTbxNfncElUjEM8667vcEmJp58p2cK4OrnQWDBtl/+T6ZRYl5THp8
 eLcR0m3vwsdabPgRoPcIyS72MM4YWXiyXmftugW2XnTijF4DuPJj8NlmN5rP1ifXFtoV
 yPCkCvS3HAoEYKkn+Ojg7SliIGZ/D7uG2WwciVWxRptDHJ8WxaFVKXtFS0OOmda7homc
 oPxP3uXiy0aZp17pPGnqIeLM6FqOi7YXVxR+vLtIHuPNnX27PVsL+d1FO2n/vN5M8JRE
 yCnViEXIIamq2GOwYsPJ7d1/WO9mOGWtt+GWadzql13mmCoysPUF91xM8Vc1w14XLs9K
 ADOw==
X-Gm-Message-State: AOJu0YwyfMUC/6HjcaoyeDrMmCjY4Xd8eCD2ls2nBAE7PFOUwBt4b6bx
 09Zsha2hhO4ZF/0ojPR7kh3ym6hPC2n9RpD2kgsSJtQFr1GELI417Fq9VHqzKO33vAu773SLUdt
 uTnHdrhnj9AoG/bRVHHCYsAtAH2J0fBU3TXaRBtRzJOIs7jqxTrRs
X-Gm-Gg: ASbGncsI5InUUSR8feN/qXxvlGU6XoN5/PNOOKvf27AZXIGmcmDeh4k1PEcwiGW+zkR
 N4tbv1nlkr8b30O6k/Or2qyhVs3SIHP/ZBUJ44yqoVsNyPbWHiXtLAO5dRk5ukNMf9x0AILOheK
 Kkzx0NBymaJxIeYm2cn6x4c4z3AH2aN8p9V8UDMK3fvOHSfZKJopfNrqOSwedja5sN63bbdrD5T
 qWB3yzDpMrHolrNJgs=
X-Google-Smtp-Source: AGHT+IGr4DQHEH/SXKJKTWs51SZtbHQCv0QQn7HPv8oEh0O2XCNQhmqe3vqU4GLDf7FYsWwwZQrt9MYBf8U1IPmmITI=
X-Received: by 2002:a05:690c:f90:b0:721:80a:abce with SMTP id
 00721157ae682-721080ab0eamr179043137b3.9.1756394979202; Thu, 28 Aug 2025
 08:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250827053822.4094239-1-richard.henderson@linaro.org>
 <20250827053822.4094239-3-richard.henderson@linaro.org>
In-Reply-To: <20250827053822.4094239-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 16:29:27 +0100
X-Gm-Features: Ac12FXxbwKwc5m__sSBg12OrG3OXgWLs_FYHFeDnVFpJ7bLf3hCM-oMvuqsK-A0
Message-ID: <CAFEAcA_z2k0ZM-dupWYhhUHSTPTAks3JmvQvr-RO1vzg5nvGWA@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/core: Use qemu_log_trylock/unlock in
 cpu_common_reset_exit
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2607:f8b0:4864:20::b136
 (failed)
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Wed, 27 Aug 2025 at 06:39, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Ensure that the "CPU Reset" message won't be separated
> from the cpu_dump_state output.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  hw/core/cpu-common.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
> index 26321be785..259cf2a3c3 100644
> --- a/hw/core/cpu-common.c
> +++ b/hw/core/cpu-common.c
> @@ -135,10 +135,15 @@ static void cpu_common_reset_hold(Object *obj, ResetType type)
>  static void cpu_common_reset_exit(Object *obj, ResetType type)
>  {
>      if (qemu_loglevel_mask(CPU_LOG_RESET)) {
> -        CPUState *cpu = CPU(obj);
> +        FILE *f = qemu_log_trylock();
>
> -        qemu_log("CPU Reset (CPU %d)\n", cpu->cpu_index);
> -        log_cpu_state(cpu, cpu->cc->reset_dump_flags);
> +        if (f) {
> +            CPUState *cpu = CPU(obj);
> +
> +            fprintf(f, "CPU Reset (CPU %d)\n", cpu->cpu_index);
> +            cpu_dump_state(cpu, f, cpu->cc->reset_dump_flags);
> +            qemu_log_unlock(f);
> +        }
>      }
>  }

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM


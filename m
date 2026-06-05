Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A56DACD6E7C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:25:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVWPq-0007mS-Gf; Fri, 05 Jun 2026 11:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wVWPp-0007mJ-Gs
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:24:57 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wVWPn-0007k3-SZ
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:24:57 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2c0c2d8b95bso13957205ad.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2026 08:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780673094; x=1781277894; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S/LuhJ7kFbqEy9PthjVDT2fB+NBxmqA5u8fR8Y/6JTU=;
 b=Zu1Uw6ujzOeNvDfxU6GEEyhXFT4kfQOln1vj1Yg8QCPkEvUmkFAfbbIjm1Zx7VkjlU
 GPeh9BRI1rf6umKy2O7Vv1v/XDoRjDJJdRNt6YkcaJ4T/ZG+bO7Z/aj8YV/YoDngDuOv
 tCgAbUUwil5BumDjjzupCUKnXAnNh1e2YyqziXblEqNlLw4zGA3xEy1OSIywQKILDrM5
 AxUAHp3/rKv6yIZU2GCMhIqfHX0M2khIYsak4SeNKxsFVE0/LXwxWyCsB7IRTLnb2mxv
 GVI2RXNLs8wMASvF5PB7D8geBd89kaQPmj+EaDENXJL0DC61KM+CId6ILvUJi8ROuO4A
 QHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780673094; x=1781277894;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S/LuhJ7kFbqEy9PthjVDT2fB+NBxmqA5u8fR8Y/6JTU=;
 b=Cx9U90ff8DebXsb/1Ep0700wNOblSzKhjAgE7Raod0R0YvG7mrc/9zIbtNTqvxTNbF
 dAwF/1cAFYTqYbxJ4c9+ExTxyAmaY/IHBYRYL0W9fxPCAhsZAjZFLW5XVRVAW1JRK4oe
 cfeS8nzRgqclXu32fEPVQBdHnty/IZWcMZLWvCs6RCLzAMooalTjbSwAAWOnZltYctgG
 JARz+WHBl9eT8B8DXfkB4FhM8eZJT+41kwr3/H88HZyVnOy2+Iq7OPGx7HIooLa7uu4w
 dhAjZjy4zZuWVXtMaRJXiLnu2y/yphnBWt8+rKlbt0uK24ZGdEpirzRoFS1JQzY/5hyO
 lVZQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/jI8PFlKXeHsDBpzMCTPUeSZ4cQKzzHQhGxB5qJx1hVMtqyanBQn9HYPIyHHhaYknBE6g7AGLsDJfd@nongnu.org
X-Gm-Message-State: AOJu0Yz0+yGtWRjHYkwizRTi+VqN269ZaVoibHPb9I/arPUbyHOInWLl
 a9XYol0aV1j0y4/rERwpnzbYGKOzslTaznMOxzHlsyqD2xc7eiSqGmwaF1IA5SRfDvEtulz+Iha
 xUyEgqNI=
X-Gm-Gg: Acq92OGB5RmFJ8wOOoYs/KdyVSRzxtAFLdxX98dfWbdG/tKmgVL9kzO7knZSMaXJNBY
 2EWgdVzeRWaTB979K+DSEX5ip0PsWn4ugNCQgT2m879TtLGM5t4M2J0QAcJAf3L9qxDCza9C0B9
 v0er/ay1VYLt6RfMmezM6Hw5ngflaxCZtunqTD4AKNp0g5d+VRTTGgqGGXiPsXTWUonfDpMX6e6
 xnruyQ0vbTOrGPl7eokkLDgFfweihAGtL/Ghru5JbSRTh9uMF4h57mDz1IWIJaPYyyboftWfoHN
 BlNK+ac1L6llLCUSGkO018IVueLISX4uqJ7MmI/01qOKeElmMyXEOWHI7zWK7C7Ap3j6velC26H
 qWWBlkS3l2B/jFM0eVjGgRIIxZS4UMUD9LjEMziz9+up+nY3z3MY5Qy6Fh4fj5P3yBLWMwogE+8
 KE3acsTmXv73586SJpzXoCCMMkymNpkMMdIwN3dQZPG07vegU=
X-Received: by 2002:a05:6a20:6a0a:b0:3b4:6dee:a427 with SMTP id
 adf61e73a8af0-3b4cd0a20b6mr4910381637.44.1780673094109; 
 Fri, 05 Jun 2026 08:24:54 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df033887sm8551845a12.2.2026.06.05.08.24.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2026 08:24:53 -0700 (PDT)
Message-ID: <55c2b247-843b-46fb-b187-c9d4dcea5fee@linaro.org>
Date: Fri, 5 Jun 2026 08:24:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tcg: Silence ubsan error on tcg_splitwx_diff causing
 overflow
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20260605132539.2775364-1-farosas@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260605132539.2775364-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 6/5/26 06:25, Fabiano Rosas wrote:
> UBSAN complains:
> runtime error: addition of unsigned offset to 0x7bc06e1f5000
> overflowed to 0x7bc02e1f5000
> 
> Change tcg_splitwx_diff to ptrdiff_t and silence the error.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   include/tcg/tcg.h | 2 +-
>   tcg/tcg.c         | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> 
> diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
> index 45c7e118c3..7669dc1c2d 100644
> --- a/include/tcg/tcg.h
> +++ b/include/tcg/tcg.h
> @@ -447,7 +447,7 @@ static inline bool temp_readonly(TCGTemp *ts)
>   
>   extern __thread TCGContext *tcg_ctx;
>   extern const void *tcg_code_gen_epilogue;
> -extern uintptr_t tcg_splitwx_diff;
> +extern ptrdiff_t tcg_splitwx_diff;
>   extern TCGv_env tcg_env;
>   
>   bool in_code_gen_buffer(const void *p);
> diff --git a/tcg/tcg.c b/tcg/tcg.c
> index 2ca44766f6..1e77f2365a 100644
> --- a/tcg/tcg.c
> +++ b/tcg/tcg.c
> @@ -244,7 +244,7 @@ unsigned int tcg_cur_ctxs;
>   unsigned int tcg_max_ctxs;
>   TCGv_env tcg_env;
>   const void *tcg_code_gen_epilogue;
> -uintptr_t tcg_splitwx_diff;
> +ptrdiff_t tcg_splitwx_diff;
>   
>   #ifndef CONFIG_TCG_INTERPRETER
>   tcg_prologue_fn *tcg_qemu_tb_exec;



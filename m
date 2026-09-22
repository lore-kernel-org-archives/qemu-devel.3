Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883A1C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 17:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x942v-0000WZ-Df; Tue, 22 Sep 2026 13:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x942t-0000WC-GP
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:12:43 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x942r-0004g6-N5
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 13:12:43 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d747ec6188so364995ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 10:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790097160; x=1790701960; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zYY/y0/j7vteoMP0r99XhiexAP9aKj21pw5B8nU/150=;
 b=hM3ZzQim/EqzuKYlwBEjBMfztQzu0KIg2CG9qcJft5AvBhAsS25LuwGGWSpQFkwo0F
 0kUq/aCYlrB+ynGrs+P40lLu95jlNOqQ457C4ot33oE1PnuwlnQbmgwOctPVUMuHXaLL
 Z1tZP76Quu/9zxZi7br19AnYwbaC8X6CE5XHFuQBBw9f4ioHK/z9z3FDMS4r754TtIw7
 YDZIujoK8Pfcn/6sWzaSzaLl4MFnttrcmQbb5Yrh4cXw6A1FyEaRhhYJv3YX4tVbiTHx
 HdjykMBqETtv5zqvQDqUSNmMfSQfqt8mpJvLyJlnrdDa0ZD/JqmmoVDyiFGt9wbH2jN1
 jRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790097160; x=1790701960;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zYY/y0/j7vteoMP0r99XhiexAP9aKj21pw5B8nU/150=;
 b=K41fL6f1YB7dplMDwZctsTZGxUphKj+WNiBxrmLMKXYM1dmmKEoRfLgi8KjVowaS9H
 pK7SpK4MX1Mjheq22s/U9DxzvJVNW1bnhpLRj3pkCbdedKMwsXF6EltbkBiJIR2RYBoF
 huzBVPQI7WQt9w0Sr6fbfXTUyj2vioImFaYbbl6otQW8ft372Mot7iwmD9VPFhrqsbdz
 zJDtVekRg+9gjxSIYNJWIAm3mwZBU/0wVaVa1QMjT5FhAxsIi+Fxkit3ibLKLiD8ztrY
 jSj7daIyze9iIU/c+F7dgozpzwmKL/O2KNlyOpwvOBEdAItXPDWxK2Hsxm0VMVNku2eq
 qcyw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwF/1Ay8gghxdYRc9tA/1C2P2uGjI+ERDFj7ygxc2Cic1r15xJBxXC+Hpt553NifUxYex9rArG0fGs1@nongnu.org
X-Gm-Message-State: AFuF++lHLTf0z5c8MBdSirjCqtbN1CaAvTgO3xPEZaqlv8zqh968T6st
 YW8A6AvatV9TIlECoLwtcCUuMsFperQl+xFtjicdNU+Xz+L3sE7Szpb8Wr33vFyew5M=
X-Gm-Gg: AYBFou2TEiY3IM2lVxqLAAbT9p6GfvojUr+llg/tvRIpqiTWMskGQ0WHW4EtRWvJmzr
 S3ZL5zj9MH0tYDvaXWB9E4HNbn58C1HP9zD2orieCJcZYJxRnSyB7snRkVGkXG/vKQyTV4HHQ9o
 YxytSM5sKQYk7k+6QZ9M6dXSeq7osxHOk2wKmuHlwuydbVM9NpmBWMnj3ZpIWDKhlY+njBmom/9
 CTS6/nE3Iuang/Q4+1S6wEqJflz7xBVF0G91bdXCRfyUmrFh0/j17L/PvwRVywL8BDrYaujoVG8
 ghasK+7U+6bT4CbRO++P6qHXY82EudFpyeUk/95flXlv/+rTE1G9JHCoXc8d8zZmHDjm7pLJNvV
 6Ccd3jKNG9ROWd5Ucl/nka+vnRc1e2fCEtZaKK5MMFKXKjYmB/X8XF5pmLASSrTJ5rttrqnZUc4
 9vy6knhx3QDd/Mjx+gw80GJgomiRkuXoIGNOjvAkGIaaZ2sTuBYCQQeJXjYgRNr75fjIo5vDQym
 JPHcpPK5qURWe+qLCLXf5fLxlHsc04AiGrnC2Gp
X-Received: by 2002:a17:903:2c50:b0:2dd:c100:4246 with SMTP id
 d9443c01a7336-2df69de94cfmr263705ad.42.1790097159958; 
 Tue, 22 Sep 2026 10:12:39 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df5d019a5esm13900995ad.25.2026.09.22.10.12.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 10:12:39 -0700 (PDT)
Message-ID: <a435c784-849c-4a0b-95bb-182068d4abfa@linaro.org>
Date: Tue, 22 Sep 2026 10:12:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user/sh4: fix race in atomic variables
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, Helge Deller <deller@gmx.de>,
 qemu-devel@nongnu.org
References: <ae75af55-eb9a-5ac2-9288-aa116a3c4000@redhat.com>
 <dfa3b2ca-b87b-4581-9769-2f90aba86c56@linaro.org>
 <2845945d-4d46-3ae9-8182-7d2288ff06ac@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <2845945d-4d46-3ae9-8182-7d2288ff06ac@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

On 9/22/26 10:04, Mikulas Patocka wrote:
> I looked at the sh4 translator and it seems that it already tries to make
> sure that the full gUSA region is translated into one TB - i.e. there is
> "ctx->base.max_insns = max_insns" in sh4_tr_init_disas_context - that will
> override the value "1" that is supplied by cpu_exec_step_atomic. The
> comments suggest that the author is aware of the fact that the gUSA region
> must be completed atomically.
> 
> So, the code that single-steps through the gUSA region is not needed.
> 
> It seems that the misbehavior is caused by the fact that if we exit from
> the gUSA TB early, we execute the rest of the region in non-exclusive
> context.
> 
> I simplified the patch, so that it adds just one method -
> revert_uninterruptible. It tests whether we are in the unfinished gUSA
> region, and if we are, it reverts PC and SP back to the beginning.

What good does that do?  You'll only restart the same block as before.

Is this really the case where you're encountering

>         if (pc != pc_end + backup || max_insns < 2) {
>             /* This is a malformed gUSA region.  Don't do anything special,
>                since the interpreter is likely to get confused.  */
>             ctx->envflags &= ~TB_FLAG_GUSA_MASK;

If you add an abort here, does it trigger?

> +    /*
> +     * If we are interrupted in the middle of the gUSA region, we must
> +     * roll-back PC to the beginning of the region. Continuing halfway
> +     * through the region would break atomicity guarantees.
> +     *
> +     * If we are interrupted after the final write instruction (i.e.
> +     * cpu->env.pc == cpu->env.gregs[0]), we must not roll-back, because
> +     * the atomic write is already committed in the memory.
> +     */
Just know that you *can't* be interrupted in the middle of a gUSA 
region.  Signals will always be delayed until the end of the 
TranslationBlock.

So this text is misleading at best.


r~


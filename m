Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A976C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 14:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrd3f-0005wr-S4; Wed, 05 Aug 2026 10:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wrd3d-0005wU-8P
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 10:57:25 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wrd3b-0001RV-PI
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 10:57:25 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so1196878a91.1
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 07:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785941841; x=1786546641; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PEwLXYgFZx+vhHrnfxaBLboM/doum9NiGmpkLXjutGI=;
 b=pypxqBtt5ufXuM0Kyu7SwVory2z6SFfdcnDP7Pqqc6ZZrBksa7aVyZlrRvzee3uubg
 Io8X3JZkAYF4kiAOqkxQi/KYW/K+ygnzmKa2oWxtkeaZI2978h312IyW4N97wKFMu6Mo
 wzYCNXcTWtcdVwgw9vzq/kshrgiLL+YsX5ftUPjSdJFap3EAgbWqkU0saXD+dSt2Ok5/
 SGphq0bq7sH9na3InBGb1Dv3s2r8IHHSSgy1CFH8JeG6QDDXE56SJyoRINdAMyihLvMp
 zdoc/Fc3m0gRHWYfkXkHdra7vNnRvqcUbVYOamJpRvfDEOlq8pmN31RpW7b/Nm+Rn5no
 VoPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785941841; x=1786546641;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PEwLXYgFZx+vhHrnfxaBLboM/doum9NiGmpkLXjutGI=;
 b=AWYcMMk9dee3kbIwwdyKeZy0i+VaK3odyRHabFN+3oIlVsYWdfyqaHKK4J0Jl05pcX
 rmlJ0avC6LO8dS0vO2qj2LKwCPqyyXOEyFUG+FU04eAOO5mry1n7nnh0oAPUczHNENqa
 wYSRKeLmjqPgNmGK4EkrtFaLwXhZMsg6NjLHLgun6tAp6EpsA23kmUtqj9hKzI2Fu6bn
 krkrOSfrCGPEncBwBF/b/abERGOxFaNb11Asf9e8iaJlsYMaptFeYBgcp0W1oxyI9KWO
 vW72DT+U7uQyAqAy4yq4I8WMxsWzFqPeQi5t7D0hKSuDbaL/g4qw0PCdG73wdhhO5Qs5
 8LYg==
X-Gm-Message-State: AOJu0YzxIzTLK6QK9uS4v87lK2xnDRhBtg+MXjXvWN8fk1DgBWWZv2XL
 sNPj76Rxt0Wqe4ZeKmZdtBiUMDxBXaye8hHE5gvVqfzgYnlNGnc4tBHliViorLCBZ4c=
X-Gm-Gg: AR+sD12SgG84Z7fzzQEKTvnaxml+tkjOXG+I6Mpr4HmVDxNIboA4/ECuFuDGHFRxnR7
 IdpK8BMhf+yDTI82+e4zq+YOaZMUKuqY8CcYmGnf3niehJSCJknFScnZl4eB+ozJE1D9u1FgUY4
 9ETzF1+VoPuVCbi40o0QH9XPnrDNklczIOrJiP0+hjm40vlreeB1jhN5EygBdiiXnoTaWiw9Bzx
 9JBCZcMikyUVxn/FulLhEBrmTxOdPpwoBR0JH9csghahMiU+0pCqdUOw9gvDBUDaQEN0XwmoMCD
 rVILRcT7oS9CmDDL/F3dKuC7yy6umO8yT61vDiXtVZ815xN4EiecjFfhTG5MBqBnIczQxMcIYWJ
 KLe3aSD2Ayzf7OxArbbWzvf8ioRCdWTdfw/Z/qqgbvvadZhtltLchmeGSNoEICjy/0LvTsr37qs
 6qI5YnoYQOWeilhaiNZY3x08RYx6lRnXicQhZy1qIey5YqVE+U7moNu1XvAW0tIc2V4tFVA6e/K
 FPgnzYuvyZt/13sYdv272bdeFQ/
X-Received: by 2002:a17:90b:2782:b0:36a:8240:2477 with SMTP id
 98e67ed59e1d1-3903c60c488mr7752217a91.19.1785941841519; 
 Wed, 05 Aug 2026 07:57:21 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38feda512f3sm4956665a91.11.2026.08.05.07.56.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2026 07:57:21 -0700 (PDT)
Message-ID: <841905d0-6967-4560-b07f-d040e992f4fa@linaro.org>
Date: Wed, 5 Aug 2026 07:56:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/sh4: Deliver SIGILL on invalid instruction
To: Mikulas Patocka <mpatocka@redhat.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Cc: qemu-devel@nongnu.org
References: <2a3f1f1e-459e-5d36-0c1c-e56568cced9c@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <2a3f1f1e-459e-5d36-0c1c-e56568cced9c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 8/3/26 12:42, Mikulas Patocka wrote:
> On invalid instruction, deliver SIGILL rather than crashing the whole
> process unconditionally.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> 
> ---
>   linux-user/sh4/cpu_loop.c |    4 ++++
>   1 file changed, 4 insertions(+)
> 
> Index: qemu/linux-user/sh4/cpu_loop.c
> ===================================================================
> --- qemu.orig/linux-user/sh4/cpu_loop.c	2026-08-02 19:02:25.000000000 +0200
> +++ qemu/linux-user/sh4/cpu_loop.c	2026-08-02 19:06:40.000000000 +0200
> @@ -64,6 +64,10 @@ void cpu_loop(CPUSH4State *env)
>               cpu_exec_step_atomic(cs);
>               arch_interrupt = false;
>               break;
> +        case 0x180:
> +            /* Illegal instruction */
> +            force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC, env->pc);
> +            break;
>           default:
>               fprintf(stderr, "Unhandled trap: 0x%x\n", trapnr);
>               cpu_dump_state(cs, stderr, 0);
> 

Missing 0x1a0, from helper_raise_slot_illegal_instruction.

r~


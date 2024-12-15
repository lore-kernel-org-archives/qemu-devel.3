Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D3FE7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 15:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMqou-0003Aq-VS; Sun, 15 Dec 2024 10:46:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMqot-0003Ag-VP
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 10:46:12 -0500
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMqop-0001MQ-67
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 10:46:11 -0500
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2a3d8857a2bso739771fac.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 07:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734277565; x=1734882365; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6vawTa2WRP+IM/GmbWVWotJk0rF9nSgPIqiJkY9ViKY=;
 b=F0bc9t9XkY2h5r8TxPilsnjzDEosQqoGJUFAWlENvVxdz9BynKVAjUDyRTbURns95x
 ypq0V45hKlz0f9kgxEFBIjrnNX/Kq6q7Z3eLG9mG0hYmJnvuIi+Y965FfxYhbm81mJvi
 YEdtWD03y4hRwJNtaGBSqhv5Si9WSBwlGB0/96M5wPAY3x0oRPYjyBj6c1kGPBKXQIt2
 am3ulM4IpY3tyjAD7ePiS/6D/NrcTmmoE3J1jgQjv7AD3cBZc+t2oP0QPk2HLh8M9lyo
 JyEvsE201D6/tZI2igA6bF/Fx7gg7zAbVtEjOMRtQPA+kdgQ2hmRldEtzkNpWomjqlBL
 lQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734277565; x=1734882365;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6vawTa2WRP+IM/GmbWVWotJk0rF9nSgPIqiJkY9ViKY=;
 b=mqpxabbPLlmPxrA/zj5Hb7RPAvcPQ5+DZrA8QfLHuN5VhGX3gfbi7gTIfoodKh4Wmn
 gUqg8hhv8u9josZ8Ga6thI7V/27qbObSLvpWVaecvI31rikMV3xcTkfzo6R/y3YXRE3p
 o8ZEiLsU7UhxZpX+Om8fqhlpSwKMXgV4WssJy8AYHuSmHTsbgSCTyNe4mbP4mT7NCVBW
 MiUh6Qc8wSAis8g60oc9zGZ237MOqt/KYd+mXEafqCKEI50yhgH6PJBgOGds2tZLHfrB
 NzfwytMukmueBaqZoDDrntmoidaDVy8CtjyPav8sUqZQYV5k7MKZgoV0xH8n6W6mlvq+
 navQ==
X-Gm-Message-State: AOJu0YweVmd6ShoTOM0aooB8jOxBj+eIYX2EA8fjFsYzigFE5MvmEAj8
 uJcwAeZuLtxX4N+qU6r6V5fVh7nN6w4OTDArAgnaDbGW3gzTMYVIvRLIXoQPhaY=
X-Gm-Gg: ASbGncuhHvMhWjaBzjFDpXGTayTTwkyvJe+wb8SNz7RIDO7kjBiKV10CdnOgkZiQBQh
 GrDEUwcXiQgI2X9R0N55Ldo/+rDJP8rz+WQ60CNaN3qonZZCO8P9zr43z05rUXETqmpzAH5IiLH
 +FUsUXYPEhAWY4PtwkBh+o/DxifSqliy0sPdkeF3Nx4wOidytdRJd679+nP9fjVn3ZjWWVH0Ad/
 RncHjQns/58skJzUGXpwko8zZQt5dby6ZxWaJq4WvUUyy25BWt1/jCkE6F19uXaUHpBPwvcu9C+
 gYNBWrDJRig4b1bvSuujIM0bRzRqJqA55lA=
X-Google-Smtp-Source: AGHT+IFN237saWoxMysF9RwgztSAxoD1ZZXG0AFfeOwn1dDS5KF+NQFZONcqNwdynw56g9fRS2qeVg==
X-Received: by 2002:a05:6871:891:b0:296:e88f:8f56 with SMTP id
 586e51a60fabf-2a3ac8b8ademr6105379fac.26.1734277564951; 
 Sun, 15 Dec 2024 07:46:04 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d24aebefsm1257768fac.3.2024.12.15.07.46.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Dec 2024 07:46:04 -0800 (PST)
Message-ID: <bb61050a-3dc3-4f1f-be61-a1b69597603e@linaro.org>
Date: Sun, 15 Dec 2024 09:46:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] target/i386: execute multiple REP/REPZ iterations
 without leaving TB
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <20241215090613.89588-1-pbonzini@redhat.com>
 <20241215090613.89588-12-pbonzini@redhat.com>
 <376ee81c-6465-4592-b4f8-9beec26199dd@linaro.org>
 <CABgObfY9idHAZzBB7AXkQgbd4O04bk6G6SR7N+qyEXLFekqyLQ@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CABgObfY9idHAZzBB7AXkQgbd4O04bk6G6SR7N+qyEXLFekqyLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
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

On 12/15/24 09:17, Paolo Bonzini wrote:
> 
> 
> Il dom 15 dic 2024, 16:07 Richard Henderson <richard.henderson@linaro.org 
> <mailto:richard.henderson@linaro.org>> ha scritto:
> 
>      > @@ -1384,6 +1409,12 @@ static void do_gen_rep(DisasContext *s, MemOp ot,
> 
>      >           gen_jcc_noeob(s, (JCC_Z << 1) | (nz ^ 1), done);
>      >       }
>      >
>      > +    if (can_loop) {
>      > +        tcg_gen_subi_tl(cx_next, cpu_regs[R_ECX], 1);
> 
>     Since we've just written back cx_next to ECX, this is the same as cx_next -= 1, yes?
> 
> 
> Yeah, I wanted to make cx_next die at the assignment to ECX but it probably does not make 
> a difference to generated code.

Not really.  It would only make a difference if cx_next was never live outside the EBB. 
But it is live across the branches to LOOP and LAST.

What might make a difference is to use the knowledge of known values in ECX, but less 
usage of cx_next itself.  Let cx_next die at the two

+        tcg_gen_brcondi_tl(TCG_COND_TSTEQ, cx_next, cx_mask, last);

by repeating the subtraction when updating ECX, i.e.

-    tcg_gen_mov_tl(cpu_regs[R_ECX], cx_next);
+    tcg_gen_subi_tl(cpu_regs[R_ECX], cpu_regs[R_ECX], 1);

This would avoid spilling cx_next to the stack.

There's a the ext32u to place somewhere.

I guess you can't hoist outside the loop before the first invocation of FN, due to the 
fault path.  To eliminate it from the main loop you'd have to unroll once.

	// no iteration
	brcond tsteq ecx, mask, done

	sub cxnext, ecx, 1
	brcond tsteq cxnext, mask, last

	// first iteration
	fn
	sub ecx, ecx, 1
	extu ecx, ecx

	sub cxnext, ecx, 1
	brcond eq cxnext, 0, last

	// subsequent iterations, ecx now known zero-extended.
  loop:
	fn
	sub ecx, ecx, 1

	sub cxnext, ecx, 1
	brcond tstne, cxnext, max, loop
	brcond eq cxnext, 0, last

etc.  It doesn't seem worthwhile to eliminate one ext32u, which will almost certainly be 
scheduled into the noise.


r~


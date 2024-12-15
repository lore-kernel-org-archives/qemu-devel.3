Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4304E77183
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 14:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMpSp-0001du-70; Sun, 15 Dec 2024 09:19:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMpSm-0001dM-JD
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 09:19:16 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMpSk-0004t8-U1
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 09:19:16 -0500
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3eb9de518e2so1556042b6e.2
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 06:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734272353; x=1734877153; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4fqV0K9zA+8GshNBoiptyOLuhjYqtR205wLwUCFY4j8=;
 b=nNIc1pNLai86t82/gOzT9b3dCVS/2DBSBtWlEXjAdmbHREBN2jgwc2lMhMydaCKNUn
 JwNkAUW/phxo05oHuawoHhmiervYQHCEIhoznCbrN/65fS1nSYVxnea3IDj+1xhFJzbu
 Nf0n/uUAocTDZ/CdeWWgrSO6ueSl9AIiD8s5KFEUf9dekA0LcOZ7mkE1fnB3VSAlBnTy
 WhpM46YUFFvx/uzDCEt1aleKlb6XjTDZIsz+sdD239H9xh1f1ciLQvmj+KD3ypiiGari
 kq+2349iwCskQa6k1mkO/NnwqbwHlWAuMtUXKYgoUu6X1PXQGcmDM2KOtoSZwFqXgGcW
 0UfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734272353; x=1734877153;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4fqV0K9zA+8GshNBoiptyOLuhjYqtR205wLwUCFY4j8=;
 b=K/wZFTQhn7FPH8zZPeg+G0VxadWZxONix+gEY+8sPYCCchDvywsJqi9VRXeyRx6miU
 0D922QLtlxO3ROg45n7MCD1adWCZjaUdNkoLleb4ER+zE+//8AGSgDi3UwbOeTeMRu2g
 HiXN3v8yDHVPY2oxnoN1Ft2CJezUeu9I1emzl/fxPWd60AREu2wzN4IwNGzSVo/QVKbF
 sB/JmVwQadgt60OlBkHtPXqV/PTmprfEqpUtHCP8J4zWnvCnnGMhAnHqMfyNsMc7bX6S
 1pZXujQIJZyB7UMcHxf6GKzn/tQjH7n39LS0H8Bz+UTgt69BoGUdLyd1O5xcSwKEoTJD
 LCUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqh/6N/JksZjzwO+5X9+9xhb9pCumrRw7HJPGPrtq0+P3Cuv930R0ZfFmicQIj6mI8kQBUp7smthTq@nongnu.org
X-Gm-Message-State: AOJu0YwJ8D0ls2YPWLlPIVVRHV7HtP0y9TdQTr/oEcsvU84+eB8qAVUR
 1GJmrmC3s5wiX3EQEFuLoIAXuXzqnJ0zJ9qokeMzhTRwTnQiBaxcZtkqZyMp5TZfhSqRCODh3ut
 NmPBs/U8u
X-Gm-Gg: ASbGncuXax3M5oLy2sc4UqgMfgnYlHs/SKBk4II+f+rmP+2P1GV1cgGjg+nhlychDsV
 FV4/jR5OKfWCkxT0xreMeeiE0cJ0U9bcQ3TXY3Har3nrSV2UKa48CP8cj1hGw0AOHrwR/++5SJC
 ITdLWo0AJHCCKTgtgwa+FTYZf6PpahAjmv9ROjOpP2fbR+2Wf2mRHAC9VD04I8/UDzvGrBNsf8m
 cU+plpd14GMRgxpCG8nDOnqk4PjsccdnAgeza5l4gZRzVNAZGoBeIw5g3LBVwIBSXFw/+Gthr0p
 XYVH1p+6yAEsXVWThJA3G1fG4Xhk3gF1kUE=
X-Google-Smtp-Source: AGHT+IGmrdtk/bWvhzv+gnRP3cGY0eW9zPrX1B4SvWKtZVt3AvXXvEWV2OYZyuNDNjbDqpOUgCyShQ==
X-Received: by 2002:a05:6808:189e:b0:3eb:71a4:9854 with SMTP id
 5614622812f47-3eba67fe536mr5648450b6e.1.1734272352987; 
 Sun, 15 Dec 2024 06:19:12 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb4545546sm1026635b6e.0.2024.12.15.06.19.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Dec 2024 06:19:12 -0800 (PST)
Message-ID: <63ef3af5-d1dc-42b5-8102-3ae604468555@linaro.org>
Date: Sun, 15 Dec 2024 08:19:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/13] target/i386: reorganize ops emitted by do_gen_rep, 
 drop repz_opt
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241215090613.89588-1-pbonzini@redhat.com>
 <20241215090613.89588-6-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241215090613.89588-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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

On 12/15/24 03:06, Paolo Bonzini wrote:
> The condition for optimizing repeat instruction is more or less the
> opposite of what you imagine: almost always the string instruction
> was_not_ optimized and optimizing the loop relied on goto_tb.
> This is obviously not great for performance, due to the cost of the
> exit-to-main-loop check, but also wrong.  In fact, after expanding
> dc->jmp_opt and simplifying "!!x" to "x", the condition for looping used
> to be:
> 
>     ((cflags & CF_NO_GOTO_TB) ||
>      (flags & (HF_RF_MASK | HF_TF_MASK | HF_INHIBIT_IRQ_MASK))) && !(cflags & CF_USE_ICOUNT)
> 
> In other words, setting aside RF (it requires special handling for REP
> instructions and it was completely missing), repeat instruction were
> being optimized if TF or inhibit IRQ flags were set.  This is certainly
> wrong for TF, because string instructions trap after every execution,
> and probably for interrupt shadow too.
> 
> Get rid of repz_opt completely.  The next patches will reintroduce the
> optimization, applying it in the common case instead of the unlikely
> and wrong one.
> 
> While at it, place the CX/ECX/RCX=0 case is at the end of the function,
> which saves a label and is clearer when reading the generated ops.
> For clarity, mark the cc_op explicitly as DYNAMIC even if at the end
> of the translation block; the cc_op can come from either the previous
> instruction or the string instruction, and currently we rely on
> a gen_update_cc_op() that is hidden in the bowels of gen_jcc() to
> spill cc_op and mark it clean.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 60 ++++++++-----------------------------
>   1 file changed, 13 insertions(+), 47 deletions(-)

It might have been clearer inlining gen_jz_ecx_string as a separate step, but no need to 
do that now.  Yes, this is much clearer code generation.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


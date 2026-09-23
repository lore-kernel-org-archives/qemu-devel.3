Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39A7AC9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 16:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Q2d-0004jj-SX; Wed, 23 Sep 2026 12:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Q2c-0004ix-2U
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 12:41:54 -0400
Received: from mail-pz2-x24.google.com ([2607:f8b0:4864:3b::24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Q2a-0006Ap-DR
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 12:41:53 -0400
Received: by mail-pz2-x24.google.com with SMTP id
 41be03b00d2f7-cc4d04d73b8so620090a12.1
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 09:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790181711; x=1790786511; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VUm71rlull0V3gaf5GalNtKAQHyKYqlvA1UGiLZ2eSI=;
 b=FbyEndUzRdNKRrpbxs3ZJGhwhlHjhRWphRYiUeqhO/fdXC8FvY0vI1K0qhQVYjxQvO
 rABiQ7pykds82RVkGpS6rJvLGkekZhQyX3cbNJEYjbdfxTsqOZKld3IF4dI0vJ6TMimo
 Z3ZZyNA3y8xkD+qbsi/pHgE+XNgYs8YJFIC3yqjrpJMXgWNjV/BH6WZzfcdTHtIVI92q
 WoVrUjdEDbjxlZJH11trjdn+XD3PtYTBVyDLk83JMj3u/gyf2jaKN2mmjbWv8mtWEi7s
 cS4OpJKvaT1v4gl1zUKO1CHdSFIHpSXG2Dgi2/X06hHYaY+dZXJYCwosLUEeEoh+QA7w
 35uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790181711; x=1790786511;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VUm71rlull0V3gaf5GalNtKAQHyKYqlvA1UGiLZ2eSI=;
 b=eHEbdzbzZcM+MMKvdMlvkebG3ZxggeRf+ppdq5/KrgFSf9chcOuR31UoTHVq4bkZWY
 EemY73UTNqo118xwLYzqel7XqtFCHwXVOWPnhAh45P/bLXW5VrlU9YKjh2KO+X6Ew18g
 +C8exUXEcOU7Uv9XbNmQSY+2TQ7BC1/4gWXFEPGAapl3hA29KeyN8Kq6wAmB8cbcEtUC
 5MxYsoYVKAhSfiE5bpLut9fFz3hauFNUI8Auctjn7IlGE4YhHyJFKmVy2Qj3YsfP2OtC
 dNO+J5v3xxFNzgiCSBf9Z4O9StufeSmcDRAVev2v/u5jT34tzl2z6phuxvSizREyUdcg
 TuRQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzqBWLJ5Hhye8ysHfO2v+NmH8y6slZmQH6SpePtCxV2CFRXk9xucTaJLU6AMSZrH9mL22d1B+X33Sb6@nongnu.org
X-Gm-Message-State: AFuF++lDgzXFCq8UQKlONA82d07N2IfqjwwpQrjiXGzrNIzNs7Uq27G+
 6RSCFHuwF2Vkq0OvDjsacfJjlUPkyjD4I0euupa8PhZ557ii8gCghVuqWY9lXLsR3ZA=
X-Gm-Gg: AYBFou1KthCGYHYFgsbtEMZKHWqZT1HYUyjDtmnV+cuqgXtuVGjzvv3IR5qSOcIcswv
 oBRnkrNOpr7qB4CPTGdoI6YHYJ5SRj0WnZzxw5B7i8vedPvRWLZ6ys4oRmts+XrKi0sG1ts3b9p
 dmKzzb1DaVM384AguNqML8NRbLj9mTpXTHatrqWJZ+GqWHy8BUX1K+OIEn1Rv7kGGzCeDdBfn31
 NVdCMsTnk1KBJ/xGXFo2ABEpyvyVQo1f8ux6yZYwKp/BAp1qmL1q/idd8lbBMNsNgvH1EdxxFJY
 jGKqYQUaD7FEPtwXu4UTkUtdWO8FMsTj2RZ1u41LnNuJ8bZaOiLCTGo4MsEw/7cf0WYfnvxscSM
 KtHft8WVCA1je4ZoJv/QOXPuIZ7NpszGhXfUYEanOSRz2smvNPZSp+4TPCz6xt1nRQmXkieFVgg
 fCj0xLUvAbweDlxw82tpaawFGvJjQLKgVBEeKAN4/iimiq4YRnh6D60zJaalEd+u0mubpU04+az
 K/Tkpolj4EjECaUgVpP7foW939w9CmXTylzy9QD
X-Received: by 2002:a17:90b:3a0e:b0:39e:4c7f:8b16 with SMTP id
 98e67ed59e1d1-3a07e628305mr3009252a91.27.1790181710436; 
 Wed, 23 Sep 2026 09:41:50 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a07ddf23desm5846843a91.10.2026.09.23.09.41.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 09:41:50 -0700 (PDT)
Message-ID: <cd42a180-d5f6-4a55-933d-c09db858d1ba@linaro.org>
Date: Wed, 23 Sep 2026 09:41:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/tcg: fix REPScalar with memory operand
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
References: <20260923124749.273446-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260923124749.273446-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::24;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x24.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/23/26 05:47, Paolo Bonzini wrote:
> By the time validate_vex() runs, e->s2 is not used anymore and
> decode->op[2].ot has already been filled in by decode_size().
> So it's the latter that has to be adjusted, just like before
> commit b7d4ec4832d ("target/i386/tcg: move VEX validation early",
> 2026-08-26).
> 
> Fixes: b7d4ec4832d ("target/i386/tcg: move VEX validation early", 2026-08-26)
> Reported-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   target/i386/tcg/decode-new.c.inc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
> index 8d1e581cfde..26f6d6277be 100644
> --- a/target/i386/tcg/decode-new.c.inc
> +++ b/target/i386/tcg/decode-new.c.inc
> @@ -2671,7 +2671,7 @@ static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
>               }
>               assert(e->op2 == X86_TYPE_W && e->s2 == X86_SIZE_x);
>               if ((s->modrm >> 6) != 3) {
> -                e->s2 = s->prefix & PREFIX_REPNZ ? X86_SIZE_sd : X86_SIZE_ss;
> +                decode->op[2].ot = s->prefix & PREFIX_REPNZ ? MO_64 : MO_32;
>               }
>           }
>           break;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


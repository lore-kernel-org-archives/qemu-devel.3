Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953D4E7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 15:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMqD2-0006Y5-PX; Sun, 15 Dec 2024 10:07:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMqCx-0006V2-Ui
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 10:07:01 -0500
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMqCw-0003pU-C6
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 10:06:59 -0500
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-29f7b5fbc9aso667822fac.3
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 07:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734275216; x=1734880016; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a7TgC2j6QqKPADsZcrifKzRscbI306q5NrOSHXtaiH0=;
 b=xzoHJfKoNO0PR86sYe/qosoXpXgzbq5yXbttg37O2ATJgYVyElcEza07IaXAF3O9UD
 JgK8lVzRNzplBZCollpvEdMjnNo3Oc0DGaEcaQt3qk+ZWRf50mpNGeJt0/R+j+9FE49k
 lby85+mRLZ2PGg2bRzToPr0mTqHFpKq8C30DzWr8zIeY5AjUr5QZq3TP6Jab/yB0UM22
 Qzqti9erEfO9tk60nbP78kRgXnfRshh6Ig+S7+TkOr627y+bsMphEW5aYdRiDAcQOJE9
 XT1rH6pNRXq92arnYniao3OzFX1v7dWPN/Ou7Wd72TdraIpHU2YucQrT6ucbVm9Lz3jg
 HUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734275216; x=1734880016;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a7TgC2j6QqKPADsZcrifKzRscbI306q5NrOSHXtaiH0=;
 b=KWgRFJ49nLfzsZjB5N4liOgV3JAo1FL16hPvfedWKlGcIojn9QjEFqPx+6qiA5y65S
 LnrBM1/wAmztOs4jXWH42p4qwX9k6AID5Z82wDaN6+MXQV2tLssZW7vtPERztIijsfJp
 SmzM9tjzdcWoNZMKAN/qcPGVyubAMGAX/PXiEBp9WTwMUx9OGKZ6L7agLnobFTIlWXA9
 EojeuZi5kD2OGRgheiD96SFPQhXOYqEm00Sz56YT7xXAbI578oUk6P3hiCMVBMHlv//v
 0EE6e/VPitBT54sylol/JgKiFY1X+PqYnryuk89xUL0v6C5e9syO9nU5NOlHeYawaIy5
 LbGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvxztgaKLhhbecViEl827SGTExxAlnrRBOdrQjlyVnakO4bVMfryiy16XGiF2qCbOLRxIDenUCr1ok@nongnu.org
X-Gm-Message-State: AOJu0Yzbu1O1UakT9XkSF5NY135S9woab47WfTM0l3W0UPfwC+ZRjgB8
 3kqSZYnGYsjfaa/EAHqA4pMUZi8ApKiSR6ZRVVSEaHFlEk1rP3tLiAByD4z/9I0=
X-Gm-Gg: ASbGnctUNOSf2eJxR9qChqiY1Rc9vHV1sfzsgnlnBFBwkFTd+3ppGoQUlQcO7kq5tpl
 tbnnfSmX+VS3jaYXLOtC3hbxwj5OdBuDR9bBobs+ty1ZroLtOvwXFyjwMicSiA2fL/6p8ZOseLz
 CWU+IjuHa63EOLwkj6DMckHbaZISQGGih+rIKiEue5Vgfpr8X23UvB2hi7dbKU5TG8+NdlN8wDI
 z4FJpCj0AjDH+XiE9fKoTge3ijhY+d7jzi4lgDfSBcHcXOVRHrCq8R+Xr6II+6RapiF3sDZFu2d
 ZZldKlSzN3PXGdur2A4gk2mYSrbCfuqsUGg=
X-Google-Smtp-Source: AGHT+IFEatHey/KX5qYmvi4tjuuy/bZp2m3ZA2C0/xoaxEQ+tZl7Bhs8PzC8V/dZZ0gj2NMlXkuKog==
X-Received: by 2002:a05:6870:612c:b0:29e:6f32:6d91 with SMTP id
 586e51a60fabf-2a3ac8de554mr4456034fac.33.1734275216070; 
 Sun, 15 Dec 2024 07:06:56 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d26ac5fasm1218590fac.32.2024.12.15.07.06.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Dec 2024 07:06:55 -0800 (PST)
Message-ID: <376ee81c-6465-4592-b4f8-9beec26199dd@linaro.org>
Date: Sun, 15 Dec 2024 09:06:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] target/i386: execute multiple REP/REPZ iterations
 without leaving TB
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241215090613.89588-1-pbonzini@redhat.com>
 <20241215090613.89588-12-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241215090613.89588-12-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2e.google.com
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
> +
> +    /*
> +     * The last iteration is handled outside the loop, so that cx_next
> +     * can never underflow.
> +     */
> +    if (can_loop) {
> +        tcg_gen_brcondi_tl(TCG_COND_TSTEQ, cx_next, cx_mask, last);
> +    }
> +
> +    gen_set_label(loop);

I know unused labels will get eliminated, but clearer if you emit the label within the IF 
as well.

> @@ -1384,6 +1409,12 @@ static void do_gen_rep(DisasContext *s, MemOp ot,
>           gen_jcc_noeob(s, (JCC_Z << 1) | (nz ^ 1), done);
>       }
>   
> +    if (can_loop) {
> +        tcg_gen_subi_tl(cx_next, cpu_regs[R_ECX], 1);

Since we've just written back cx_next to ECX, this is the same as cx_next -= 1, yes?


Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


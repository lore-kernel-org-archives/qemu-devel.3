Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FFFD78339
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIA7T-0006lq-Jq; Mon, 02 Dec 2024 12:21:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIA7S-0006kj-HH
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:21:58 -0500
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tIA7Q-0007iS-VW
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:21:58 -0500
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-466929d6013so43661981cf.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733160115; x=1733764915; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YFKSPHkpXEPoOsDCAf4mU2q+qjyLtWvyFg6hNzlnio0=;
 b=anRIzE6Kul7n3NxGV/6slFHMuQXJzSq8qr2Mfr5y9FrxqLUjYFtj9hIys7MeSDZljK
 6ZOrgBVyUWpYu/TwQWqekA4MxsAV/qwXUCXxJykOBEIZXMZFEPvYwZ5IvqqJzJVyhTeY
 d6WGJJNB8pi/ZOK35W5nQCEtFwyiIDM0786MZnIClm99gZdRA1XIpRWIL7hxkAt+J12S
 2YUbAW5duGZL52rFTAyxruwygK77pPnDkLOPaWFfoMO/Hlsclyxzxjjnwm23LxlILwwB
 epo38DW7xK6I5JTAAhXKEOCZbefobuGcJF1RQErnHEQ2S+nypXSfQTno/TActROPkUoI
 Z8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733160115; x=1733764915;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YFKSPHkpXEPoOsDCAf4mU2q+qjyLtWvyFg6hNzlnio0=;
 b=fNWPl3fnbnrq8Ye0TNyC/aKgL4X0EDLc0wzQODAKplf3tmrlam14KBLESQqSmi+8ER
 9YHsepoHeLzEeg7aMoPRkS+Yufc2VtAjEm+u8dPpa5pbFLHQg4LdmKq5KMDlXXVGUhxF
 HR6I+TvuLK+T7Ml0pi61oB9dgVndw/06jQk9nKWIVrA5+mzrCXUT9b4QAtHlIhm/D8bW
 cPIf0Ogb0ARw4GjBuTiVB4WR1p9MysdiGC1GA//qnqmxj/LTCdrfp0WOcCCtemDidzmU
 NZ7luP5o68PqQSyli2khu6e1ggIw4yi9gZDOFn63OVM9CKW+mOPSKANxCs9wHyejx57R
 BGpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeAbDmPTH2o7Z29HprlydyJZnvMVle/nuNcjriPQD/Ix5p3h5d/cnS9gIWYX8/PI05uXHAPcXdIwl/@nongnu.org
X-Gm-Message-State: AOJu0Yw7/28/ARuhQWOaU37o/Xm4wPyUzbvFnoIJ6eOn+w70ireZs2M7
 OXeZp1k1/Jjsf9sLYxviH5zOPiP+pGR4xU0AtBP843v3RFpD+sHe0HcqzZ4tl3GJA+NimJrvA9D
 pWKw=
X-Gm-Gg: ASbGncvxTT/H4UY3cdLdgz3M3SEDY8zIvZcDCnUjtTf6r3WlR9bwzGYsHU0UDA2ELtb
 GNEpnL8K80ObERuyj1KuIzXnK6mwxf7kd/+C5abVEuzHYoGXJqiF83WjnZnQdBzE3x397HUIITU
 6FUjriaVrmT+utC5AXnsG6tGQtPCniylACZ66FvTqbIzg9BRiO4EdImynQ1P56/jewsWRdIDKkD
 B+r66dsnX/paEyJNeWkqAKDS7kAqWAnI4HlcDC/Smu3Zmek6Zk79btJ3EBI0NwuH6t0PUE=
X-Google-Smtp-Source: AGHT+IFyIHx1c89NzUMp6ARdqwRvn9/yGgywbmJp4u3aBp8LSgMSAsOrWqqdxlxa8+x5IME5rY5eeA==
X-Received: by 2002:ac8:7c48:0:b0:466:a41a:6448 with SMTP id
 d75a77b69052e-466b359e3e1mr377061651cf.18.1733160115263; 
 Mon, 02 Dec 2024 09:21:55 -0800 (PST)
Received: from [192.168.170.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-466c4054955sm50444611cf.1.2024.12.02.09.21.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:21:55 -0800 (PST)
Message-ID: <fbbe2745-97ff-4cad-add3-6a74008c6555@linaro.org>
Date: Mon, 2 Dec 2024 11:21:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.0 29/54] target/loongarch: Use normal
 float_status in fclass_s and fclass_d helpers
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241202131347.498124-1-peter.maydell@linaro.org>
 <20241202131347.498124-30-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241202131347.498124-30-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x834.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 12/2/24 07:13, Peter Maydell wrote:
> In target/loongarch's helper_fclass_s() and helper_fclass_d() we pass
> a zero-initialized float_status struct to float32_is_quiet_nan() and
> float64_is_quiet_nan(), with the cryptic comment "for
> snan_bit_is_one".
> 
> This pattern appears to have been copied from target/riscv, where it
> is used because the functions there do not have ready access to the
> CPU state struct. The comment presumably refers to the fact that the
> main reason the is_quiet_nan() functions want the float_state is
> because they want to know about the snan_bit_is_one config.
> 
> In the loongarch helpers, though, we have the CPU state struct
> to hand. Use the usual env->fp_status here. This avoids our needing
> to track that we need to update the initializer of the local
> float_status structs when the core softfloat code adds new
> options for targets to configure their behaviour.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> It would be nice to get the riscv fclass_s etc also not to use a
> stunt float_status, but plumbing the env through would require
> fiddling with the macro magic, and in practice for the is_quiet_nan
> functions it works out OK.
> ---
>   target/loongarch/tcg/fpu_helper.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B3AE784BE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 01:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va1ma-0001iG-Pm; Sun, 28 Dec 2025 20:10:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va1mY-0001h6-Vb
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 20:10:46 -0500
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va1mX-0000Qe-FW
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 20:10:46 -0500
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-787df0d729dso70104717b3.3
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 17:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766970644; x=1767575444; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8b15nZW4qNx2CWd3twlWKF0HzGw/1t2vt/Ds9xj5ei4=;
 b=mqnocRQXPNlpwZ8iC04/1LjYq+cLuCbzfgoJUeec7dI0qgR3PwQZRmF3fwRHYJ2bEG
 2yHv0KQt6yJlgVQZETn6YtDiwCKxUyhHuaYBEyiCrgIZTEMU1IfuAtsA0l8exkNruj6m
 E9uQ7VGzYu+uD/Xlv5WIUZoihjKU7zvvfc3njU7sT4EtvYCt1mm4vw1iAk8BlriR5aBx
 f+M2x7cOfi7GmXfG7PYFuAUvGZPhneEKkqTpasVObE4by++Jm9/zecbvCmWSFp201Jn0
 7ae3SDRW64rIxAdncNM5FIS5NtFjYwN7AaI4RJ9grtq8sRR/RdOXWg5JxvsWyBm6E5py
 fhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766970644; x=1767575444;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8b15nZW4qNx2CWd3twlWKF0HzGw/1t2vt/Ds9xj5ei4=;
 b=AMesalaEVUvCeIz0UmI/cb52tz3tAX2LffLNrYLIonrzCPulcbsIxxM8sZzzWfGTKD
 Wotrfhptx6uLU5NQqVVNMSDDyumuhNeEL61wEBnQAJ6zjhf7sCBO0ntV+mVvYKeU7OaR
 v01P2p0b/VwaIWRcoJbBJ8HD2D8Utb1qBPstiHkDo9BHJ3tsCaZaftGw21ZolNhJM8rB
 TOxTlEASMe2fuVViSTKkj6UidEdpHcgiA4GCLqplhv9ndz02QTmzmYxY0Yq3e/DXaezc
 LHGLmvPC5CCNjOYuDUnQ92hBr32FOarnVsRaX2YF8CHtBKlfslWwWXKXMMz7R5LXBLA/
 tcrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhS06Gut78MYgqy7KTCFHNXBROLHDOI+IguNP/5FeHKiAebUUnpW7Rsvsame4cnKoESoJCN3fjYayX@nongnu.org
X-Gm-Message-State: AOJu0YxT7Uwx7tzwxzRkl3Ge3XsunZytxZCXEZQikOzERvqR2WJ5Bp7Z
 poQFR8wgEfA2oU5kJB5UCNJ1xAGdXozKUGHdfOzvCIC1D3SGr5blHPv4bI8KOz1zBQg=
X-Gm-Gg: AY/fxX5zJVXYRSPYxJ8DhUFqEaNsS1vVuN87HMNbG5D79ZnxXkVVF8vkwsLUsNuV+e7
 6uvaP8uT1LgTu748QbrpkXCWDk/c+n7ZvmR5O/eNyfPH2IIk/UgDP2OG/+EEDQAS2xiKxnPggLv
 eMlEBMS0QRjEWETuY/Pt6xevGoJgK9g3VhIQJwHFldZH0gS1gU8ud+AcmiqnhdK/sxC1FVJSf/w
 8my7FG9BkXSi8epQYd7BIVGbq+167FCHSzahlgwFL+5fjLyjmf8PGTL9Ka4LVXZl8K367qsYWrn
 BW1PYojAXOi8QoRsbukqG6e9yYNTMswEgU6zoDF5fb1eVsd2IZ7ybPmQPrkEoVoXvmsulfrzfgg
 IN/+aisTLWHxwRPulwZUAr6JnDg60QED2heIltXPKhKckoXOYX7GREaQcnn1SbIzzUtKMQ28kPY
 kyl9U3fh+J7TP5BxBpKVE6LyyM7eCCti/yPp11/1y8rtj4RAuepjFQUyTzUJM9rj123sMFVBgHv
 pNmNSh7
X-Google-Smtp-Source: AGHT+IHAIX95FV8obumZepBz502BA/mrjJqNlic1fDDUscIRXY+3j99cVuSMQZNG2I5y2aLQEJ3cBA==
X-Received: by 2002:a05:690c:c94:b0:78d:b1e9:8600 with SMTP id
 00721157ae682-78fb406a7c8mr258884757b3.22.1766970643931; 
 Sun, 28 Dec 2025 17:10:43 -0800 (PST)
Received: from ?IPV6:2406:2d40:40cd:310:f6a1:5e51:f9d7:f095?
 ([2406:2d40:40cd:310:f6a1:5e51:f9d7:f095])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-79032157c31sm8188727b3.40.2025.12.28.17.10.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 17:10:43 -0800 (PST)
Message-ID: <56b9abc0-9c48-46eb-ab95-a2f512cb96f8@linaro.org>
Date: Mon, 29 Dec 2025 12:07:56 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/25] system: Allow restricting the legacy
 translator_ld() 'native-endian' API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Xu
 <peterx@redhat.com>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20251224152210.87880-1-philmd@linaro.org>
 <20251224152210.87880-20-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224152210.87880-20-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1133.google.com
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

On 12/25/25 02:22, Philippe Mathieu-Daudé wrote:
> Guard the native endian APIs we want to remove by surrounding
> them with TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.
> 
> Once a target gets cleaned we'll set the definition in the
> target config, then the target won't be able to use the legacy
> API anymore.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/translator.h | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/exec/translator.h b/include/exec/translator.h
> index 3c326555696..8d343627bd9 100644
> --- a/include/exec/translator.h
> +++ b/include/exec/translator.h
> @@ -188,7 +188,8 @@ uint32_t translator_ldl_end(CPUArchState *env, DisasContextBase *db,
>   uint64_t translator_ldq_end(CPUArchState *env, DisasContextBase *db,
>                               vaddr pc, MemOp endian);
>   
> -#ifdef COMPILING_PER_TARGET
> +#if !defined(TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API) \
> +    && defined(COMPILING_PER_TARGET)
>   static inline uint16_t
>   translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
>   {
> @@ -227,7 +228,7 @@ translator_ldq_swap(CPUArchState *env, DisasContextBase *db,
>   {
>       return translator_ldq_end(env, db, pc, MO_TE ^ (do_swap * MO_BSWAP));
>   }
> -#endif /* COMPILING_PER_TARGET */
> +#endif /* !TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API && COMPILING_PER_TARGET */
>   
>   /**
>    * translator_fake_ld - fake instruction load

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


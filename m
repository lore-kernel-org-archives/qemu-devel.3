Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B87FE7718C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 20:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOjTY-00024b-PV; Fri, 20 Dec 2024 15:19:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tOjTX-00024M-Dj
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 15:19:55 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tOjTV-0006rt-TY
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 15:19:55 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-725dac69699so2184845b3a.0
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 12:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734725992; x=1735330792; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YxJeKkf6M6uZngM5K1zfd0sM5CTiaARuwtRKBq1kHQQ=;
 b=yKiSco6c53aHEAuPLErJZUAmgw88JUkXAbT/ZV5GecW0JP3i4wS1cEkjibTI1m81va
 CVbQdmuqXYbpp1MC2u+JOYO60ai9mV+mkS8Jwen1Ka8/YDzWI+iZ8P7lpoyTsyRWstcr
 AnAdzjQMNVUwpKWTnxVt/283nU4YgrTx0bIkboF822adUP47gnrbxdPwixQPr8SAdbyh
 bRkurwemf5Iau+51Q0GtaxBoOCtheT9e/cSwvwnfpmF4FiejsIL3lsnKzXp7D6sFcdRO
 2rAkXTJLNK6TE8yQHFqOQ/kZC5Bn93sFjwIQdHixDt6MBpQLRYZAAkyX+Aup1PDrnsjh
 8moQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734725992; x=1735330792;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YxJeKkf6M6uZngM5K1zfd0sM5CTiaARuwtRKBq1kHQQ=;
 b=i6SaW00fOz/6e2DNy5iNsjXw1QhqOpKCl3NW0Kh6zDeRdkJ1v0gddPCCCOhhEow2Dk
 ZPZHSOx3LOyZCfbZbjAebLTmE9pVV704Dyh1wGIjBRjR76NAa2MwHBOsQXTBdx7JXpCX
 8g8CA2O9ERwrgBlEtx+/aL92TJth3qoS0N3C7R537CHKnTp29lfRgLnMl3XP+t/kpLy/
 /tuI7EyAUNnYKudxVDasyvJbN871tpSETZSnRfslNlDdqk8m5mRmlH3b9eXbGvn72IPP
 vMudD2nh6Mmd6CJ6MTHDBlXt0UqJ4mah5Zwvoduobl/aip9YXWYa7VMLeakIZ8aqFkwf
 SxIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmyGYtEmFMqrSIfuoGoESt5AQGleqZukpw42TtgO36T3Eu5R3znkqqHuzVze0MWZsTsceKKNwaozOg@nongnu.org
X-Gm-Message-State: AOJu0Yxq1N7QLLvqQQp23fzjND0fDju61bftGwYOuNNyGOdfV+XPs3b6
 S7HZVtANkpU5BMn8Z3uyCC+g/TV/ueIhE5E8rJH8Ho6haYb6rDa9Wx2rp/NQxkoOsepFIKMLr7j
 a
X-Gm-Gg: ASbGncu/A3f7oDVKoPwMR5skproDMO+lRtbiKnxascqjUo1sqlGfO08OKqNqM7WJ8oJ
 hi9BokLlDnM6DhFa4YT+OO5sqIk47tJaiUHXlyVGcEnuyye5a8/U5e2jvTpVu5EZ8ZpC1QZrpVb
 8/9kQeWZeRKdjIYf+FD61/qhN5Gh3HEZTpx5Zkf4lSVQi42p90Ev161bTHR+3x5fsestMPspgzo
 L9NcTSyzbLNZIDmcSXTwGiOSzq5urnTlUCeO0jZUm5+ORPhHAD2ndELg60kz492eijmyg==
X-Google-Smtp-Source: AGHT+IFbwfLTGeKshHt2Hk+MlS1GDHbQXCSqtW4qcs3g7MpI9M6MoX5oF8E12Qjb4muZDuuvrHPHCQ==
X-Received: by 2002:a05:6a00:8f07:b0:725:b201:2362 with SMTP id
 d2e1a72fcca58-72abddb0bd4mr5750643b3a.11.1734725992476; 
 Fri, 20 Dec 2024 12:19:52 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad84cf91sm3496123b3a.83.2024.12.20.12.19.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Dec 2024 12:19:52 -0800 (PST)
Message-ID: <1732e317-d59c-4e26-ba8c-915c0c72f3dd@linaro.org>
Date: Fri, 20 Dec 2024 12:19:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 42/51] tcg/optimize: Simplify sign bit test in
 fold_shift
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241220041104.53105-1-richard.henderson@linaro.org>
 <20241220041104.53105-43-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241220041104.53105-43-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

On 12/19/24 20:10, Richard Henderson wrote:
> Merge the two conditions, sign != 0 && !(z_mask & sign),
> by testing ~z_mask & sign.   If sign == 0, the logical and
> will produce false.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index da48aadd12..7219415fe2 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -2590,7 +2590,7 @@ static bool fold_shift(OptContext *ctx, TCGOp *op)
>            * will not reduce the number of input sign repetitions.
>            */
>           sign = (s_mask & -s_mask) >> 1;
> -        if (sign && !(z_mask & sign)) {
> +        if (~z_mask & sign) {
>               return fold_masks_s(ctx, op, s_mask);
>           }
>           break;

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



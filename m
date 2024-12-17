Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B2B4E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 20:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNeOs-00083m-C2; Tue, 17 Dec 2024 15:42:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeOq-00083C-VV
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:42:36 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNeOj-0003po-LG
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 15:42:36 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-72739105e02so6254308b3a.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 12:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734468148; x=1735072948; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=91CuxXfX7+64YTha+E2bT2fg7UigeCMQ/Hdzaec3ju0=;
 b=P2wKgtg4MkcxyeYcf9bYBw8RBdeUg7KZ7/pbE5llwSSVJV3RaNgBnxmoYQZDEoCbL1
 69QRct8CiJRTWBzo2rHJ3hBF3pMG0YR2wkIgtz9GTMgDWZwxmuv16k03ca2hTIJBwAtt
 I2RP/UofcrTGXsJpkMuN2u/RT2zIJF6ZOeW7v8LEdNa+5ooU2zcGvC+TOMUddCh7/qlP
 fJBfyfKiClClCqROgVmT9y3ABgJYShYLA65iLYER0duO+u7anFUcKTjJsD2VLiT9dw5N
 R8pEkuKtYIRW/jsw1WSKmq7dSATvE0VjN3f/BkojIYOjgO8+Gr2m1FM5l6VM0CfeP+pI
 eVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734468148; x=1735072948;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=91CuxXfX7+64YTha+E2bT2fg7UigeCMQ/Hdzaec3ju0=;
 b=koSdxIJVwV2WKojTPearGqG7802fVk1zB6BWwkR9YjbQGZQRNPPe31Jn8wKl7ijvZB
 /RwVtLV9P90JSyuWaQ90wVcbzmDg0LexKXflcTxAbxFOe0PE7N0YPhWT/Wj2Q5HLctP1
 sG15Wl9cfnpzDBQjn9gi5A4frXJilI7Ol28fvL9qr3qx1ld9CcKf8MqKEx7QVcMrMI+A
 ex7lRihQLMCN9kl5Q/rVJLOnWedXWP47iO4vIGShNFhajVnSZlte8ML5VzJ6cQYsvp3u
 R/RDTg+pyeIHbyrT+zeytG2NtPMdNOVShNYvGq+12xW507lnrpDqJk7/tdp4FJpi7yfw
 itJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOJKBNSqgeKULjJyMr2xvp4Kt5Sdnajs+lt1xKxzDY//LMTw22E8xmHmxeAoYgL+SnAZCYIg4w+dDD@nongnu.org
X-Gm-Message-State: AOJu0YyYIc+M1uDFDtqaK2I1MqJ1TyI5Jk+MPRQK6neJVDPNbOhCnvn3
 ONRCX/D64uZ11p0kDqrWQZ8H+uuihby27MgwVVWEbatoIK61LLJTcXuukHByl7+s9EBjrTr4pqJ
 gGpnt1Q==
X-Gm-Gg: ASbGncsOrAPRDgvlGc749dzlD5tpIYlx2T5M2AFIBZnynp46J6YMqm0y3uZ91oL3OG1
 EhJx0fP5WpuWQSVvrNk+/fV8mi2C70lFtQzNCQ3djYTJ1bVa3Q0S9MgbxIHzr75vgsGweNkiIif
 yhnwOPUQUJPLS/GMWKhMn39Sw7Z9iaGXFw+2+Qmx9z947OZaQerp3srM9ysfYvTfiGlpN5cEclk
 ZZnPDtCkO3BgW+50KUKLUxz/aWz/L0K6/hA9ZcbLsIVTaHEBB0DPSkax2BELHIH6KREZw==
X-Google-Smtp-Source: AGHT+IFqAOgrkC2YPQV8CzeWhSYZ6UWYz0A5tEZouj1wFTXT7v1vuj/g3dSlVSl87nOsWi2wyUXkMg==
X-Received: by 2002:aa7:9316:0:b0:725:df1a:275 with SMTP id
 d2e1a72fcca58-72a8d2c9c99mr604912b3a.23.1734468148214; 
 Tue, 17 Dec 2024 12:42:28 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-801d5c0fe68sm6174679a12.62.2024.12.17.12.42.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 12:42:27 -0800 (PST)
Message-ID: <c802c658-7ad7-4479-b425-75645413ffc7@linaro.org>
Date: Tue, 17 Dec 2024 12:42:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 35/46] tcg/optimize: Use finish_folding in fold_cmpsel_vec
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241210152401.1823648-1-richard.henderson@linaro.org>
 <20241210152401.1823648-36-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241210152401.1823648-36-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

On 12/10/24 07:23, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 30446baabd..c99e6f79d2 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -2483,7 +2483,7 @@ static bool fold_cmpsel_vec(OptContext *ctx, TCGOp *op)
>       if (swap_commutative(op->args[0], &op->args[4], &op->args[3])) {
>           op->args[5] = tcg_invert_cond(op->args[5]);
>       }
> -    return false;
> +    return finish_folding(ctx, op);
>   }
>   
>   static bool fold_sextract(OptContext *ctx, TCGOp *op)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA70CCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 19:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7ILl-0007sS-9X; Fri, 10 Oct 2025 15:00:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7ILe-0007ka-IM
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 15:00:19 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7ILZ-0007FD-Dq
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 15:00:14 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3383ac4d130so2219879a91.2
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 12:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760122803; x=1760727603; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dII3YCMmFJfOwzgKKwUEepN+hKWg1+cSCUCN/LWBbDY=;
 b=P1qzMagL21remZSCMkwEVldh7RsgZEaZ5GMLYghBuy9rkEADhytWc5Rwl5VE8ZXQNu
 +krOpIdV6vWGUoLS1cQwQcsehNR3oR8jjX2E93xCUu4Jzn85P0DOwZy+SYobcRjhfR56
 tMb3RrIuHT5Zf+ipbOG0hVwczj+QvaNcE2PKr481nX5MCI8e4+SzMWB+0m6I/qQB5HFZ
 eZ4zGB5VBcOv4ZhLUrembaIG6wXee9kW55fGwEUTmj57RcxVlesjp2hBSR5AFMzPvp4p
 XD+vZr+EP3vma+kCAyulgQWAVAI+DYCeJLjnaukMf0hLLq2l1nfkPQ1Mra86yv/9gTds
 tDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760122803; x=1760727603;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dII3YCMmFJfOwzgKKwUEepN+hKWg1+cSCUCN/LWBbDY=;
 b=IAvbdapp1lM+5q+JvEZHPt2CtAvo/GJyAqZkkBorqqrEYPGWi82O+Ip+fqmmSH3HsO
 2+6SHF3hJjP+hUM86I9pdUOHwfijBvfDZIdEQy8tcn3eVblHhaTeULU0TrjPlu7hMgZi
 L+sno2B/3odA4wlDfl5X06FYarF7xt/1RFOLmYcUmQozjY4FVXV04ThjxY4dhy3iUG7Z
 b78gRnL91VD1gN9DphH83yJAudSMKKyD0vlTUlccpbK6nZt7IIecNIJZQomHXs6VEur0
 lhB9CH2YjcesagL+hqag5V0M6Ua2gh3LgnAQ2rAkpkfotL6NzBGpWx1WApQRHyZ4JLvV
 PQYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6MNY6apQFr4cDMWmGlnw03MLiuyZwlYP2l0K4XBYjbjmEImFbX2tTlJ9fnOOd5vSeJRihO+6wTQRX@nongnu.org
X-Gm-Message-State: AOJu0YzzKOQEVCe/WHIaiKCaCOlaN2Bn3zVh42M9K5CIygE1a0n33Tyo
 ZzSGd9QcbTzKAcHKsCNRByyr6DDHHAI6l8qQbVUMMTpJzcVGlEFMbDbr/g73ZWtjjWo=
X-Gm-Gg: ASbGncvqmzdrBUd2eDwLSsvH5VUVuviT2N2PTIaFSykZ29kaMx95esrOOlqwxhTaj8b
 r6q7AemH9WF9gK34S5XtqISxU7F+IhVr0oH3Q7s6Jb5OzyyJ2qsS5sNgXLdz8PogJk/i6R7iCIp
 gmeJg6yfs+Uj0MMyjP9M9TblT0VnnQn+olLOp9eqvt/8nMEpl9m6zBKZN3nrhqrVhK4Og2ez9Qp
 fwwgcGngH1d/X7H4hL7t2v2l6B7c4GDIcVowesl97/djErz1OVN3+OB04HoTqgdkOxvqAuH4GkC
 K7GUNmbL8nf0KgalMBWJSNX/pSfzQx3IXdAa3rotHh4wtceRYvnk7JUk2o6Ak+imtH8Lm/+D64u
 WTNX5AJ6zYO2BaQjor2zz61tXwIzoiOG7713+8f1dyG+axez3FhStLIRn3yI=
X-Google-Smtp-Source: AGHT+IG8T3y2IAHJ9wm2klPcpO8YNUinNByrbhM6YeIV1qdCJdd9TDY7o+Aao9g4sMVSV3x1h5Fv7Q==
X-Received: by 2002:a17:90b:3ec1:b0:335:2823:3683 with SMTP id
 98e67ed59e1d1-33b5111491amr17657166a91.9.1760122802995; 
 Fri, 10 Oct 2025 12:00:02 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b626e8bf5sm3680585a91.23.2025.10.10.12.00.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 12:00:02 -0700 (PDT)
Message-ID: <41bd1de3-77cf-4d3e-aa16-0c93a52b805a@linaro.org>
Date: Fri, 10 Oct 2025 12:00:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/13] target/openrisc: Replace MO_TE -> MO_BE
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Anton Johansson <anjo@rev.ng>
References: <20251010070702.51484-1-philmd@linaro.org>
 <20251010070702.51484-12-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251010070702.51484-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 10/10/25 00:06, Philippe Mathieu-Daudé wrote:
> We only build the OpenRISC targets using big endianness order:
> 
>    $ git grep TARGET_BIG_ENDIAN configs/targets/or1k-*
>    configs/targets/or1k-linux-user.mak:2:TARGET_BIG_ENDIAN=y
>    configs/targets/or1k-softmmu.mak:2:TARGET_BIG_ENDIAN=y
> 
> Therefore the MO_TE definition always expands to MO_BE. Use the
> latter to simplify.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/openrisc/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
> index 6879a0cff80..a626ffaf25b 100644
> --- a/target/openrisc/translate.c
> +++ b/target/openrisc/translate.c
> @@ -61,7 +61,7 @@ typedef struct DisasContext {
>   
>   static inline MemOp mo_endian(DisasContext *dc)
>   {
> -    return MO_TE;
> +    return MO_BE;
>   }
>   
>   static inline bool is_user(DisasContext *dc)

Add the same sort of 'little-endian enabled by SR[LEE]' comment that you did for RISC-V.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


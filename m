Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C290AC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 16:45:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk4Eu-0003Tc-7R; Mon, 17 Feb 2025 11:45:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk4El-0003Q2-HL
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 11:44:52 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk4Ej-0008ES-TK
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 11:44:51 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22104c4de96so33296705ad.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 08:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739810688; x=1740415488; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R9fy4pyXxIft5DXi119vKqA4TamTASL1q7brr+KqDvw=;
 b=tcWpS7w8aO5mV+sLFNXBMqyjrx/DIpu7aJKuh7/x2HCdt7DvPSiQo8OinVz2QwHT1s
 qrvelM4BBtyGMokH4MoMggMPjk+iVpJs8HhQ7f95W2fgoRQtMP47YNZjSVe4WKP8eYzO
 c7YkXKmrMiyhWi5qqFRRbm8DPnESgnw8Vp8X3vqbeRDToWjKC9HKOBy80/BFx6prcVdV
 EjKg17grNPa4/XLCnNsmLyQLumvQ7/XdyIGPGBJRXu7SaYmI/rz7v8vJvDslZwWAOrIi
 OajXWnxOyLhkvR+FBPAzotEoOK2g+wzfrpOmzkDXPC1jh5/rdFrDbMNki8QwuNM7wex9
 loeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739810688; x=1740415488;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R9fy4pyXxIft5DXi119vKqA4TamTASL1q7brr+KqDvw=;
 b=FFdxJqqtdYjnd35Ocy2ctxDsDAqn4dpkJkbqAK2cI0mcKkOj34u3CgwzZWp3tGWNDQ
 0hMXXnLc22+Ijh/kIboyXzE/eE3rs5gK/7utp34GBeYsvKobNV3tULwUmRhWVkWvWvcw
 c7AQapkIWT3DXzAUdCLd+TsmTWSKd2gVk7HxrJwjrMTx0vVknZw2dCcyzMd0cesfpBvD
 4iZeFTN4MOJjE62kh0XnpO6pdv+7tt2nY/OhOEDAWsf/bIi6F5eqljGrz/ZEbbXkDoHP
 q1HuRG9wDRdGTEqg2X/vIprZs6dI3eiouePsmCnx6lDA3wI+42qSPgVi06/eGLVuzAla
 6Thw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiNrYOqbZVV0xsZSseP/bWH2A0KE51Trbn1UZWfKN3/jp2LZsfw7t5hf/5Hd0Tq4ifJAqoKk4DA5RO@nongnu.org
X-Gm-Message-State: AOJu0YxClR1xwXGQPH6sjhfEjN5xFM/owsd3cWWYcaY5erVFicXlRKLl
 IK1tnBNmKHLs70NKRAjjUH3sfHqIbVX6cqjqmgwseZ44ixkQSz3ZdJCFottE/HEzdsfCguPg+5L
 I
X-Gm-Gg: ASbGncvnvILPencMNV7X4yucvZ6pmozT4EMX3x2vY4MJWZ5WwGKuGiEveW4ZanP6Z26
 3sg58kDaOBZz5vHTW0ud84MDIPq7woMDfP6oxZ0Hzo6SfaGhJjTLIUSMviiFLJy7d9r+7v6BUGA
 GlFr1WoSBsQcFvUQz83iWhwweAC9o/6d/6iTKLF+WRPJKo7m0dZfHvvrlRSYn1nR3Y+jdpWR8Wy
 qRQvQJ6QAVgV1ccytuWACIIGPigU1/rzvHOtLgX6OdHBwr+yE2I+7FoiaeGh+98aOWJ2nqsxrEQ
 NlOrNgN89MFm5YHT5VlxXOZiLoFlwX4V+sK7QlhocieE4osC9I9wrOM=
X-Google-Smtp-Source: AGHT+IG8sd8UfhZ7Zvx0tcK0xGgrFcmHGdNmdtBWHxutKj1HOv7Vmp7lm7+PWMAfIaP9ZQUHaC432Q==
X-Received: by 2002:a17:902:d502:b0:21f:3e2d:7d42 with SMTP id
 d9443c01a7336-221040620a5mr158751665ad.23.1739810688390; 
 Mon, 17 Feb 2025 08:44:48 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d556d4e3sm73763265ad.175.2025.02.17.08.44.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 08:44:48 -0800 (PST)
Message-ID: <6c2dd774-0daa-449d-8f95-9c61b43f7517@linaro.org>
Date: Mon, 17 Feb 2025 08:44:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] tcg/arm: Drop addrhi from prepare_host_addr
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250205040341.2056361-1-richard.henderson@linaro.org>
 <20250205040341.2056361-4-richard.henderson@linaro.org>
 <73389661-e759-42c5-845b-7d2a28b2a303@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <73389661-e759-42c5-845b-7d2a28b2a303@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 2/17/25 04:12, Philippe Mathieu-Daudé wrote:
> With this change:
> 
> -- >8 --
> @@ -678,8 +678,2 @@ static void tcg_out_ldrd_r(TCGContext *s, ARMCond cond, TCGReg rt,
> 
> -static void __attribute__((unused))
> -tcg_out_ldrd_rwb(TCGContext *s, ARMCond cond, TCGReg rt, TCGReg rn, TCGReg rm)
> -{
> -    tcg_out_memop_r(s, cond, INSN_LDRD_REG, rt, rn, rm, 1, 1, 1);
> -}
> -
>   static void __attribute__((unused))
> ---
> 
> squashed:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Ah, thanks.


r~
> 



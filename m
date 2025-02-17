Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CFEC021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 13:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk0yD-0000Ml-4v; Mon, 17 Feb 2025 08:15:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tk0yA-0000E4-AD
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:15:30 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tk0y8-0006Tj-By
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:15:29 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38f31f7731fso1320397f8f.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 05:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739798126; x=1740402926; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z0ziHASkzWwiVJNjfN3W/qGvRKV16KikGJiCyH9tFMs=;
 b=VVYrvzd1KQ9AD6Y5qhFdAb6sR69vRsKSTW4sTD4vgS6HPy+B5/Qx1+SR58wSOSnPDR
 QGEebNuxaahPT39SYXHD2EDJc8RiYHzR00KTXZoG20nru3khbSrsWNIOdNc7n2uBYTgU
 IiIGEs40zFj7cmTEKm5RnzKRi4BPCJVUu11IcxHwFasy4tVrETRTcohwkGV9fVYNyty1
 kYRtjqlKXzpLG5jtAe/pd3EKzXqs5jfceow62nCHAPr4n04N2Dw13LuJi7uEu7N+NNbT
 duBMfHfx2K+LjGXepqOKwkcY7y+tz86nliFL0Uoc437tRWa3vnWPzOeL/TYhnMtleO6B
 F1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739798126; x=1740402926;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z0ziHASkzWwiVJNjfN3W/qGvRKV16KikGJiCyH9tFMs=;
 b=Esk0XSouJtNax8ci/zR8UGFoNx0Ui59fABRWHfzK/vwjT3/k2WapP+3wmWw+aEBthg
 pzLSzCyaBCeiIwidDojO3nijcS654lIHRHxb6TkrhkJh5b6Ao01ckWUAvWZxi/1Lxlg7
 O0zQq5Vk6mE9XRPlIK0JwZGxdTJ4uf6vY+007HfrBuXxByn3sodLNrBi7erjhzPspE/i
 oHThqYHmVJORtOu1lcHM8s7F8uEzS/uWhwoybZR4SSEXQxrFaTmxs2q4kkjCnaVmaESn
 o892FItyLNC3rmj2SnOlrqfLfkJTuDiCGkODnAUvY6KlVeR1Po22VFls9qraRqAqoEHt
 bmrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCViPAPyfCR8Cx7tIHYZ5iIiVOJWSHIU7Wz4YI5TSbyPv1wWVSBvUMvTqajY3f24umW1Jk2qPxijz5a4@nongnu.org
X-Gm-Message-State: AOJu0YwHVJWwT5ph3p6eolH5uJSPvwY0v1eVbjMiHTuyi2lHLwrx7ZdC
 OTuSiZgzcNGppeSRf9mg3h58bDkxnrmKhZuJ0ALpyGv8qSqgm52RbkL9BLyetlfWSzm2VNiBfIB
 Bnoc=
X-Gm-Gg: ASbGncuQCOr6Xq0GJn9uwNN7qLfTJBCyBp+C92+A7jE95ZY1YK+HKVUZl8ydh24+yrl
 M1etLotDPLg6YPeYH44FfmnKhsrFCTEREEtl3bvjfvv3Vbj6GBj3eE9DzNaW9xAtl7vRUQRCwy6
 w1TU13Y9yYuzm+hB9S31RX0mw3TdvcIDeAWMAXNzvbttUDNn3rZALFxmRQ3C9/X049p8M3zmYfE
 D6CXpEdPVVTe2+FUaHbUEfLOOLRi3t5i+R/Lueyr1xBEBaoEDeh0Up3fP1/4wcioP9YDrTKG2jI
 b2/JO41e34X8fbjEEQKVJH2+j8evcTmuSCw=
X-Google-Smtp-Source: AGHT+IGdN5QhNYckwG0iCR0fuDOcIonLW6ZiVthaY7IHI1p+FZ7qrCWaiUjbiwH9eIppQZ++P58wnA==
X-Received: by 2002:a5d:6c66:0:b0:38f:2678:d790 with SMTP id
 ffacd0b85a97d-38f33f34ce1mr9387561f8f.33.1739798125759; 
 Mon, 17 Feb 2025 05:15:25 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d65dfsm12432198f8f.64.2025.02.17.05.15.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 05:15:25 -0800 (PST)
Message-ID: <1f56f9c3-8dc3-404b-b8d5-14b8676e316a@linaro.org>
Date: Mon, 17 Feb 2025 14:15:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 091/162] tcg: Rename INDEX_op_bswap64_i64 to
 INDEX_op_bswap64
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-92-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-92-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 17/2/25 00:09, Richard Henderson wrote:
> Even though bswap64 can only be used with TCG_TYPE_I64,
> rename the opcode to maintain uniformity.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    | 3 +--
>   tcg/optimize.c           | 6 +++---
>   tcg/tcg-op.c             | 4 ++--
>   tcg/tcg.c                | 6 +++---
>   tcg/tci.c                | 4 ++--
>   docs/devel/tcg-ops.rst   | 5 +++--
>   tcg/tci/tcg-target.c.inc | 2 +-
>   7 files changed, 15 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



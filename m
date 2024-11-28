Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC34CD6910A
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 13:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGec2-00041Y-JK; Thu, 28 Nov 2024 08:31:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGeba-0003sB-MD
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 08:30:50 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGebZ-0005La-97
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 08:30:50 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3ea5120dd60so425696b6e.1
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 05:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732800648; x=1733405448; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fSpYDDH9l0If/a1fpCW9mlAE23CU/TLawJ/+yG0XF0Y=;
 b=df6kNafqzjdtNuV5F7e96xREk/l0cbbx3gP7eIEjWoUq00YjsLqEMKFE+3OThzMmkV
 yYRGF0kRLNLJsbde2z28g7XwIMPYgUnGPBLP6LXKXP2Dh3G1sNr0numH4Cg1zYh1CBVO
 8T0UzvcMdoWAxK3bfpSlVn6FKHoSKn9fvJhaboKG1Bb1P0YcI4LkQJxiWR2on6ZdagzK
 G5t58d92rVtKRGEWSPRvSu3fWdBT/zluu07oRgz9zl3Y3q0gmqpCsmnPgfv64G9DKwhu
 dsyynj28j3mpEMT5c9aaDjxA4lrl8mkhhrsa4NVwetx1QnKOqLWBs2uyUjMrL5UDZ3wy
 5sUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732800648; x=1733405448;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fSpYDDH9l0If/a1fpCW9mlAE23CU/TLawJ/+yG0XF0Y=;
 b=e/P2Pg6iKZ1eQCXOx1ekZ2sKnSxkQVqwXeSqlP3wUO6OzGH/hHfSWKbjPgVO2Dvceu
 F3StZeugA/vlmSb6j/F4DW/F9+3ihC1yLGk4cwymTtj1KRHa97fOsBiByALIT+iii+g4
 HfPdbXXFQbBXpVC+TmMoxAqPsWHEVwU3/XRTzKMexsw81tnL9FSnlkPHANQruTU0oLmA
 OQugPyftsFVuFpFxltkia7vvech9GNFwPSjI9x5kKcszVDOxZOtfsvOloelQc6QfXjoM
 SZJ/7//Cd1NQ+wZQ+EuGc8bsSNk5T/yXtVWx697Q2Gd5TtP2LeUc7PlvpVe9WPNzLClq
 k+6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPw5YCgzlW+WtMkPQAHFbe9shM9OhQ3DPxGXH+iB8JPzXZoAOwnXr8jglkyHU1VETN7eb/6I6JyCuc@nongnu.org
X-Gm-Message-State: AOJu0YwtyJ7oh2byhjqtEQ3CPeFiWoPBBSPvCn97KOUNWOx3chDybBQ8
 aTGdfVp8ONhae2PDAEH9O2lShqLqxqrmVPCrxFAjbvDdIiNzTtZgnLPvfdNmxPA=
X-Gm-Gg: ASbGncuxadJr3PXh3De5Dsna8Jy5K7qPBCtUW0UfsUywuDcnimrkdN6BDL2jODlOHRU
 ewCA8OgLaS/c0JvOvYpU8xp9zdPe8sLGCQhYdRRRWK3pWAHwFBynCoK+dajsAXhEPOWqjzXkgVW
 RJl8jOgDw1LzIiZUaKMEHPin++Q/FRV/XMZd8ZXE3LWgtVzJmxFcYSlONlYZ6Jo1I7RzhhiZXQ7
 GxYLG1bfxQ4LOlkFy+1RckBu9r3ChoZIR3cawJCufFk9rP56SoaGv6wkykaJstbgebx506bXBX7
 j6diidfaowOWa0H6lQa8tnZICCoD
X-Google-Smtp-Source: AGHT+IGYbiyepWZIDi/qwsuJQLRsIbT3gYKRzgwwDm8B5abbBYt7BMSgpoqGaQQqcsBLpvftU6nBcw==
X-Received: by 2002:a05:6808:1a28:b0:3e6:777:a799 with SMTP id
 5614622812f47-3ea6dc250f8mr6185157b6e.25.1732800647839; 
 Thu, 28 Nov 2024 05:30:47 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d7255e6bfsm293088a34.31.2024.11.28.05.30.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 05:30:47 -0800 (PST)
Message-ID: <72a7a50b-b87e-403d-b27e-881c26bc5c05@linaro.org>
Date: Thu, 28 Nov 2024 07:30:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0 10/25] target/xtensa: Set FloatInfZeroNaNRule
 explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
 <20241128104310.3452934-11-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241128104310.3452934-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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

On 11/28/24 04:42, Peter Maydell wrote:
> Set the FloatInfZeroNaNRule explicitly for the xtensa target,
> so we can remove the ifdef from pickNaNMulAdd().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/xtensa/cpu.c            | 2 ++
>   fpu/softfloat-specialize.c.inc | 2 +-
>   2 files changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


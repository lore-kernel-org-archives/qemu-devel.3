Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D772AC369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 17:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAXev-0007Ze-9O; Thu, 01 May 2025 13:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAXes-0007PU-JI
 for qemu-devel@nongnu.org; Thu, 01 May 2025 13:25:14 -0400
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAXeq-0003zN-6K
 for qemu-devel@nongnu.org; Thu, 01 May 2025 13:25:14 -0400
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-85e73562577so125768139f.0
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 10:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746120311; x=1746725111; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cwNX7gxMd3bv1uIY8K6f+qvj9NpH3+qc4xOcmQ2FItc=;
 b=ysmL1rtH82cc2YlctIdbT2UknuBWkCAnEo9K/k3Ah2ku5KUnOkCr0vkNGnNCXZ2Ixg
 36fqXTKgubJerG+85Cw2aHETA9kTJxY02ZL/BZiepoRBq7WVDusNFH6QE7Ml5ZEp4TrX
 akK4seYFvgrBFhUIBHyfI0FQ5gbveV57RY1vRokbG/+ZDQJYfGLB8wvkWDRo4eWdJY88
 gCwat0p/zbBXHREjkqT/AcoQ/+tLtPdeDdsc+nTdI7KB2J0/toEuJM68Dp9qRoZ0aCkO
 LwKH5zHL2Z4BMtAgtV1Q5WcqQ1cWm17NkckPp/hx4d2RWwbVdqoSjEqkVcaOFVmTfFdb
 JrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746120311; x=1746725111;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cwNX7gxMd3bv1uIY8K6f+qvj9NpH3+qc4xOcmQ2FItc=;
 b=uIy7l71EdUTyOnLy6ZHhycxLtSA1yuDbY5w2LoO4d0sQ8T6t6i/ixemnbwAcVB1yhj
 UnHeGRwhQhinO2oG/LWY2jF1OjLGW1laGMMl6SqWZ18A8q7zzhCybwpL7PUrykl+1Bot
 4l/nhVGGRZSCZy6sp1yTwb4Cw57w5QLb+SKzgKuQ2yCJvYZXue8pv7P7H1F8VpKeZPLw
 7MfbJqTIe2+KaURvPxyBezBXbGHzoT9S/yXxlowGzjXVkGqqPnWe8RYzLxCBXh2C2G5p
 g2VFjg3Y8LDVSbwyj4NdlUhjQTvKE2sJV+xuXR3Z63MjkW2FLRv5K/Dmm12fXcmjYURH
 qdxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZymiFUjuoq16a7VYWLee+LVNzakBRsnQfNa0hv/rtBHtJEl0CT9YoKIIaKdCsAOKXunNYRIfviuq9@nongnu.org
X-Gm-Message-State: AOJu0YxpdFS5k4msUkuXCDcX44S85m50GpgOqWZAOV8V/+M5Zst/ojSo
 CTunxhdbX6IatiaBR/YvtHMZlsQSJcPlFviwMUofgKB5+eX6py5Hfwj7beaNWsatbjXitsEGyZ3
 t
X-Gm-Gg: ASbGncuT7//Dhnl1VxZxA6GeFTXi7MnNMGgQWtTWqpETHs23tD65vcIdvcBDIJt1mm4
 n2Ekkl8G/sBdV0yLqPnrPyD+aZeaMDzxLHgv/m80wl6TQk2eQ/jXv9yIWKV0rJMbcgYFo4Sz5df
 kNS5DxRk98lBFS3Pz6WMwBHLLCj3hVqGWDjDc6DoSDyhh2BCiLzuWjwE1jeTLMQHrPXc7RBau3u
 nvbvOoIEfII/zsQrP/JeSzSKRfZyjsvJZxWmbLV79sSqE+1slf1dsWjctIZZ308SuKf8jZUWHF7
 IKRP5qHEqe7mCc+o8b8/50u9KsY31rsFPydH/GESMvl5gxOnvf74q4+1Q2K4Edtqxdr7gNjJMRC
 ieh1PuNQW
X-Google-Smtp-Source: AGHT+IHCL2DAhbcPXysd8yHsWPxZzvGQPvyjny9hSc/ZjnK2DSg/vUayTB2B22tJXdo2QaJtZaBXew==
X-Received: by 2002:a05:6602:399b:b0:864:481c:41a with SMTP id
 ca18e2360f4ac-864a3468b2fmr494049639f.7.1746120310847; 
 Thu, 01 May 2025 10:25:10 -0700 (PDT)
Received: from [192.168.69.244] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2b9400sm18940739f.3.2025.05.01.10.25.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 May 2025 10:25:09 -0700 (PDT)
Message-ID: <76595f23-8da9-4646-b972-4f103878ebff@linaro.org>
Date: Thu, 1 May 2025 19:25:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] accel/tcg: Use vaddr for plugin_{load,store}_cb
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250501145520.2695073-1-richard.henderson@linaro.org>
 <20250501145520.2695073-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250501145520.2695073-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2f;
 envelope-from=philmd@linaro.org; helo=mail-io1-xd2f.google.com
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

On 1/5/25 16:55, Richard Henderson wrote:
> Avoid the use of abi_ptr within ldst_common.c.inc.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/ldst_common.c.inc | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BCACA1012
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 06:39:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uumYI-0001F5-EX; Sat, 06 Sep 2025 02:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uumYF-0001EA-Ly
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 02:37:31 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uumYC-0005G2-0a
 for qemu-devel@nongnu.org; Sat, 06 Sep 2025 02:37:31 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45dde0c8254so2499045e9.3
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 23:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757140646; x=1757745446; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IdkGHPCu72/SFfTIFR6pEkhA+zGaGPyk1P9OKTE1++Q=;
 b=ilZdve8+46Tv0m1sh8eaxrYDCcetkGT71UpkhjvgzK4NmQoOnqogE0NoaLEczXwFOS
 NtPADM/Jkh+6t0FBvCFI9luQ7QlZPLgVw83eL8WMCpR/h6eE3z/HJSHRIYZw8lGSTHDH
 vGKVqWMh2vppaXlpWDSPFM3u3FQaQb/q3OguKZ6EHgHc3bXnZDxmv6NtO9Obqsxbsvhd
 qmJTc15YcBpV3ZEyWw3AMQPlp/C2aNu6ognDGE6H606dcfVTnqxVOnVX19P6gyr7y4Hv
 vDCb1exiXxxeOKqJSAt6cxaqm2Ua9ymnPsWXTZ5jI99QkHUDpp56+4GoKfhoQ6ok+4MM
 w9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757140646; x=1757745446;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IdkGHPCu72/SFfTIFR6pEkhA+zGaGPyk1P9OKTE1++Q=;
 b=oQal67wwHPkJrRPBvn3kzZKe3KdHiy9Wl+P1KpEBJIfJ4EfsTablI1qNsMx7ldN/+F
 x91mN7LKZHv22ogNkPhY4JIHtAB0cSHkSMqSUfkbbRYJSdy/FCOc/M2o7RrbigTX5NMK
 9pufAeUgNVj8On3fVtjSa7wUVUXPGlG/dTnUkGY1qrl8mwkPF2q5Cdb5b/vVw6WKjv3U
 y3JnhRbqHOTlcGDugrNW7Xj1FWnyOGWwwZGeGHG/9UFKFpj/Nrt5npy4cYepdLrRYkh+
 ESyYdfaZ00/98uvU+7X7b3SSNhzQIe97nzmmRGS4w4vxwhJOUa2UIuyDBDoxN6JoGp4o
 oU+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsUTbJymNTDoBqaj+WYMPiALLZCaP1OEEZG+B1m7dq37mu2B9VPjZdtUCUohN1TUXTsf+zVn9d9t/U@nongnu.org
X-Gm-Message-State: AOJu0YyI7gJgfF14A9NZnHErSCIOGvGeS6KpWkk1WSoYBt5Y8h/Aa1OJ
 1kHGgBmKUufdUZdCC+oKFYf5h7R7W/KNZdQjf5Uca6zVJitu9j0wiM0vKi+HMHewPSs=
X-Gm-Gg: ASbGncsevVC1Mwu2zwYWWq5Z1vlVWnPwfP5jt0QM8RHn+I3hRz63Ke++DIJ28OqLZS2
 DpBwLowdQp9/In5siWCf5EPY5AJ7zhKHihba30DVAOZErPWfuvmQHpgCD5BgdJVOOi8bXVvjJgA
 Jb/FpRWufSi6bac3ZPs+xazsUipFcIKHwQdAsSr5xWjZIS4Vtm5bLahh6paHEBEyw0Z5YdeLDUM
 Ja+O86QMYOr0shk9Sipdp9gEjwMP3IosoZZjL4f0XgOkESPbkNoL3n07gijReOA3KbbFC8UIc5l
 pLp/uCKvKKKfzZ+fvGMve/GdGBgawx/OlZ+1UGygK5Gwl9AmJXX3RIqIF5TecDUO77vkeNvX9Y8
 qsZQHS1uM3Zli3lt0M6ugsEtC2N7S8Wzm8BgG4NAUrru51GiBiA==
X-Google-Smtp-Source: AGHT+IH9N1YayRZ09i8iCJ8uFA+4L4vCc/8k/1hBhlIra4R81IhfJCkEvyrrbQ4bNDamebIrDXKu+A==
X-Received: by 2002:a05:600c:1d2a:b0:45b:9906:e1cd with SMTP id
 5b1f17b1804b1-45dddea4ed5mr8155395e9.13.1757140646009; 
 Fri, 05 Sep 2025 23:37:26 -0700 (PDT)
Received: from [192.168.104.251] ([217.65.133.19])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d66b013b7dsm22717959f8f.28.2025.09.05.23.37.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Sep 2025 23:37:25 -0700 (PDT)
Message-ID: <034afd2b-41c3-4a91-9daf-94222ffbed74@linaro.org>
Date: Sat, 6 Sep 2025 08:34:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] accel/tcg: Remove tb_flush
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@linaro.org
References: <20250906051820.160432-1-richard.henderson@linaro.org>
 <20250906051820.160432-12-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250906051820.160432-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x335.google.com
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

On 2025-09-06 07:18, Richard Henderson wrote:
> All uses have been replaced with tb_flush__exclusive.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/tb-flush.h | 19 ++++++++-----------
>   accel/tcg/tb-maint.c    | 22 ----------------------
>   2 files changed, 8 insertions(+), 33 deletions(-)

Well done!

Would that be interesting to add a
tcg_debug_assert(!current_cpu || cpu_in_serial_context(current_cpu));
to catch potential future issues?

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


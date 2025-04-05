Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E11CC36018
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 16:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u16C0-0007oc-Hd; Sat, 05 Apr 2025 12:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u16Bg-0007PM-Rc
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:16:08 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u16Be-0005hV-Md
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:16:04 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-39c2688619bso1834155f8f.1
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 09:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743869761; x=1744474561; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7S3SOqVDVe08O3IFM4daYGVd/1fhJBaTLrmklql/8zs=;
 b=M28yda1ojbMEZWN7boNFcW5R0/6Bmx2U/+pao7esUJV4J5ixE0Bqo/1pYxXdUj4tS8
 sYPcwFfVu5ppaIqXXvX4j1z3qQZkJUTze+qkc2qnta8m7VZRhdcVE2GeaSSDPH50BPYT
 1KfBYXIQYzqBPUz8tw1/1ZywEFB/j+30nMG4LRNHH/Cj06mkYcHQIdIx/74DIvHKRUQG
 Xu4gKgyVqB9fXXLT26K3re0GDH2Q1KflP8zrkC/qmxnzxFCn7TqYGda57X0XljOtgzPZ
 UlG6tuT0dacAcZkrsvRqwQhrfQ4hi6kUDL98nCFb7EMhgAF4eicnbgyvicc0ss5BvZFW
 pNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743869761; x=1744474561;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7S3SOqVDVe08O3IFM4daYGVd/1fhJBaTLrmklql/8zs=;
 b=PAY1OcSJlFjZ9Cc2d5GuMz2rnDuUsUPJfSv/9KRQaKlxsJb0nkHs+bKREKvarPJfc4
 aNkGnWHFvNDwjCe5naM18lCwPx1SVO3Ft2krIldVNHoW4Ok/rlfVZRYK8UkRA86nVTSg
 yQ8OGazma0etg1ICtrcF9uj9b07R/W3GZVCSXRg9SNM3ZodvY7XcHZ6Y6K+m+Qix7Zlo
 ZBmW/EhhPCuzn7ugT/VK04loOWbZUfBoBpsOH6g7YiAPVXjYWLqj0XD8FdDhcW3xY7zs
 hj5ua9VQ4aUNKEvqw1QnJwWPAe/paPIY2Jd9+EA0bMDdVITPXo6/wi3lGtm/8WbneGPF
 2cig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPAuwawpLhEunWK2rdiEw89MTX1pQO3Jw9xSCLkyTwBuhkCJTAPuOfTJCVBaX1wAFFKNhcLCo8rAHq@nongnu.org
X-Gm-Message-State: AOJu0YxDEaDRFJ4IOCXbXznL5uwAak9Po3CfsbBb/dMUpYK5x+NALh0L
 D83uDYkS/2FJHdjoFwelh5+VEXPyDOycZqJhs6anhp6pAzurbNYI4CC488cD96g=
X-Gm-Gg: ASbGncsiRNNl0zQq8lHIgz1kTTHtlrpjtNpjSlBRQqgl6vTNnwOes/EvbpxmSdgiPvA
 urDbAnzVkVy7GrIShsSulorheNccaL4ptvvPGM8HFhjq5VoEkP4vN3vJ7SwZEQ8JjvwbsPD4eZu
 he0KDkonKJXCtWllIYcofkF1Gd+7x3iJkvzgJdqBSmZOpXOtFw2/MjUFYy7ihczwVbLiBgXO77H
 2WDeKdcSWLbm6HSOqv3H9wTQSbS7nE75OnEQWVCDSVeezmco0TMtpS61Eo+hdkaIqi+0KOZU+Lv
 oaRRCsYxRYEHYjMndaZqEUzOPhaFuBsEHMdpqAX4X4H6mLZldHLxzWsL3UqS3mv9C2erJ/fNZzN
 R0RxnEn8i9kRWwJWoLw==
X-Google-Smtp-Source: AGHT+IHD5pBtx4XagUgamUe56KeZjg/CM4qULhkHmMKQgK9Sdi74fTeksBafEhi9R8AcNSGu/5SZ5A==
X-Received: by 2002:a5d:5846:0:b0:391:48d4:bcf2 with SMTP id
 ffacd0b85a97d-39cb35b260amr6248915f8f.12.1743869761319; 
 Sat, 05 Apr 2025 09:16:01 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ea8d16d35sm100100645e9.0.2025.04.05.09.16.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Apr 2025 09:16:00 -0700 (PDT)
Message-ID: <d63a1d2d-f0f9-4e84-8423-e40bf63359a9@linaro.org>
Date: Sat, 5 Apr 2025 18:16:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] accel/tcg: Add CPUState argument to page_unprotect
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250405155054.967307-1-richard.henderson@linaro.org>
 <20250405155054.967307-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250405155054.967307-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 5/4/25 17:50, Richard Henderson wrote:
> In the next patch, page_unprotect will need to pass
> the CPUState to tb_invalidate_phys_page_unwind.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/user/page-protection.h | 2 +-
>   accel/tcg/user-exec.c          | 8 +++++---
>   linux-user/elfload.c           | 2 +-
>   3 files changed, 7 insertions(+), 5 deletions(-)

I was not sure this would be acceptable, but this is what we need for
heterogeneous emulation :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



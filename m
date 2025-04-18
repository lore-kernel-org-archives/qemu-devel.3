Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B4FC369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 17:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5ptv-0000p0-At; Fri, 18 Apr 2025 13:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u5pts-0000oN-Nk
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:53:16 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u5ptq-0003EN-Iq
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:53:16 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-227cf12df27so18315595ad.0
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 10:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744998793; x=1745603593; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zr5+g9i/Iwf8EnVA7O8wtxFge6VGZ5V9601A9tWSdA4=;
 b=lasW14cOmVRu+qoJI1VAxjPHj5GYBok4KYg/GZ9BXZyCW4hhfArfSklnVAITXNY4AS
 jqnBmnd9hTszthigJUowXXFn8Yjq1tZxHsao5yRumTk4KkpoMgKsD2XSAyeYMV2gkl7J
 ETehfcr1lbCl9HUzTC5/QO4VK8Jn1HtskabWcF9nfKl4GY0Jd1pBJGdw/oHP/dbDQh28
 8l9mNMHYwOC78dTP15MosK7kHGI/DnjPuk+D87+10VbFoN9y4SF4cAY9np+cM0borwoB
 mGt8R06ghyI2FLJaLjJM3fgTMRsd+sF3qqLyRwJMojlSWh35txY5TVRUPAUmAavzTwrK
 Enyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744998793; x=1745603593;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zr5+g9i/Iwf8EnVA7O8wtxFge6VGZ5V9601A9tWSdA4=;
 b=S/TsuaBdJLZ8X6wZNlYPxL3OY6YvZL6pf19FCFkNjzkHZNEoMThRTTIeYgIanDO+YZ
 RSkn5yfVk5wfBVIIEZynlW7+6ypGztfq4KhhIrt8Cy+daw4/EubnPXfsDTCwzDvWaYtw
 wlhL5qFnDHblh2zWvg7Dilpnu17M75qGlT+YcG9C5omsdVZohPgX0jMsYc/rQueEDgsj
 6fki7vnjiaL/Lq3LWcdU3JLv26HPnNIjCT34z5mK026t8T16OK7cmM0og31UHkoPAJRx
 irFGMtAh/PhQyAy+BV1fRbQGfi/icPf3+9cc4BiX8ZicdkXhDESoRiIAz4LCrZHGqyAn
 rlnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCxWIfBvOVjbJ8PZeM2vq2BKCcQqxDVVtK/BxCYFyhOd+P8nfb/nXrHEU1iYlr4Vl9xZ6ZgxLRPa4Y@nongnu.org
X-Gm-Message-State: AOJu0Yyrher8SPD4n4XytpjZUXSyPAbSxch8aKn4cm4PWIbycYIprPNv
 sE11OIulq71TQ/aa9KWJfrMC4Gs7bSjaAhyv1T4vSQXxxbUEAnLX3fo3KQ+JsVs=
X-Gm-Gg: ASbGncuQXSvjz3tKKrmguZPB/ZuS/coFPHFsOBCsw+Gk6H/s1e62JE6U98Dt2kYbENP
 OuX9pSqgVRbRuyzbWa+QSTn3b+cTUcjtv22F1GpSh8UKB32mYugxp5wWulNal9KHMQZeowbiz98
 rySNuD9HFc5SOhIR5j70Io3x2Uma4B9x1yal2/oJCclXWnyIaExpqRSAJKfxnSXaKbTa8R+3Ngd
 DpC0G1ZLbqb4QJhLfhzs7od//R5RvWCxavXoVN2soyoeMoAbHwyxrI2wOrbYrjwkB4x7uLX3E4S
 7kTPL4f+zWoTtcPNrr1Rx9HmI/okVASgnH5DBFw0V/v1Lvu8Qi25BjoQizRwAUz1XGR2ytL1EC5
 2QxOvenA=
X-Google-Smtp-Source: AGHT+IF50IvaousqvlC7S0vDhZCNUdovdttc2xYBXtCWMvLZK8EjM2fXM74BRNnHjP9WukNxUFsIhQ==
X-Received: by 2002:a17:903:3d0c:b0:220:ff82:1c60 with SMTP id
 d9443c01a7336-22c50cfa84fmr69251445ad.14.1744998793039; 
 Fri, 18 Apr 2025 10:53:13 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50ed1d63sm19501805ad.198.2025.04.18.10.53.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 10:53:12 -0700 (PDT)
Message-ID: <a9c73480-6ade-4704-8211-1c6f2a9e7c8f@linaro.org>
Date: Fri, 18 Apr 2025 10:53:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] target/mips: Check CPU endianness at runtime using
 env_is_bigendian()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250417131004.47205-1-philmd@linaro.org>
 <20250417131004.47205-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250417131004.47205-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 4/17/25 06:09, Philippe Mathieu-Daudé wrote:
> Since CPU endianness can be toggled at runtime before resetting,
> checking the endianness at build time preprocessing the
> TARGET_BIG_ENDIAN definition isn't correct. We have to call
> mips_env_is_bigendian() to get the CPU endianness at runtime.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/mips/tcg/msa_helper.c | 34 ++++++++++++++++------------------
>   1 file changed, 16 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


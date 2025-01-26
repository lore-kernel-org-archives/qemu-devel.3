Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C8BC0218F
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 19:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc8kB-0000qL-5B; Sun, 26 Jan 2025 14:56:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc8jy-0000nw-6i
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 14:56:18 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc8jw-0002qz-Qp
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 14:56:17 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21634338cfdso87814015ad.2
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 11:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737921375; x=1738526175; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oZaiNxyRumKDQ6iU0NUlyhjPpWDJhbWYeJfxDmaXxDo=;
 b=JZL6UjYCJECQDBbxNEF6jwfaHb5VToI/t67QEpU+Uwvbd8mkWlwCGfDyGVvE73/SM1
 5qMryd6hBrgRnrTasI6UPPR3M0lpgtdUMeLKQ5R6IX+Y8/JhSTnS1/RBuXyrQG93ENb6
 kWXo1H+MpexS1Ik/FnexChGBQXMB2pW/d7df/LEx2IDXvAZxJ7TY5dNnSNNNiThqlPkL
 zq5wC6phmIogafVSADYD0cXmnjj0n7qZaBmCSzDb+9N3Gmwz4iY1k6J/VKH71UY8HCwu
 WjnUIouTWukE4Lg3TjVVql+LaGsQcTcxeYlN7+/qG/T0NEs39fw2HYlsqPFHMT1EiaW5
 5h3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737921375; x=1738526175;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oZaiNxyRumKDQ6iU0NUlyhjPpWDJhbWYeJfxDmaXxDo=;
 b=iCEGK6l2wAvvFGOMvjjPNjmNRxXOn4H0HrvIQU/179rPTaPnJSzzRO2lHHPoxsIxHI
 9pzFCJXZ9J7TLuwUzeBm4dlrJKVl5JtRTggeYcz+wqy7ND+JhOO9fBIZN2U7x3q8Vrp4
 1OOUHYTTa32PNB75HJMV+M3/ZrCOelXBL8TcwgtbhIz/Tjo/5A8WOawti9eHkS3mej/7
 yQFa6sBeWhEYWod6zEiXwoaOwEVavfK+bXbcQqePS+bv+nJcwMYaocetfpo57nRNSXqI
 AQuGfuFpWfpAiy/FGxBnulBX07lkk04YBLrCWvNQISwu5hBxS+Ttruhvt614l/U3lLl3
 U2eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpC3XxBEvQlN/pyNwRjThRR+6Z88l5T/bMeTL6bxoxkVYPY1TKhxonrUlNTv5jyqlJMd0FFZaLK5Gx@nongnu.org
X-Gm-Message-State: AOJu0YyBzE9K38XXRlP1IFdQVSWJkasCvH1F/u033PILhO0yW1jPx0uY
 2strMZrPYRAImM7k07C385eIqYAkQJ+JHP9EgRpxYy5+68rRvR6/2so6Nx+lMp0=
X-Gm-Gg: ASbGnctGUEQoLwT8gcY+zvMeAkY9pSIqmGPjAgL1lrcz1ZSKHNmSYSbK2gtC18ZOz6v
 blfYddzObEWxFOhR+6SbGfpsfXjeQqCBWfEQ9jd1G+t9DqJEMA65TuVJVxINxO8w7TsYI/DgNCR
 BisEAKAR7kfsWPmTyFs8zt96qDH7+PrvLPxxB3WIrrReHh+y00fcTWaiNJjSsyo6ZPUcsGAMFbn
 ft9LnN1sAAbPyILUELOBYWQks7BI5LoO0srVOOga8cqZ7SPIjZcMQYHSLRW1eHUNzm0TC0nG5H/
 IJMertywS8tIhsoRc9XhKX7YjsknPqjHUoJYQ4yKmTPFYtU=
X-Google-Smtp-Source: AGHT+IHO4WMUbjm+0GYB5uvcZM2pATyJHyNJ2uKrCdmerCTV19qq9YWTnaUhr9U9sZ/t561e+9mUEA==
X-Received: by 2002:a17:902:e746:b0:215:97c5:52b4 with SMTP id
 d9443c01a7336-21c35631dd4mr526655615ad.39.1737921375406; 
 Sun, 26 Jan 2025 11:56:15 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da424ef28sm48976545ad.258.2025.01.26.11.56.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 11:56:14 -0800 (PST)
Message-ID: <51770df2-ecbb-47b9-b5c5-a60decf0f751@linaro.org>
Date: Sun, 26 Jan 2025 11:56:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/20] gdbstub: Check for TCG before calling tb_flush()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, xen-devel@lists.xenproject.org
References: <20250123234415.59850-1-philmd@linaro.org>
 <20250123234415.59850-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250123234415.59850-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/23/25 15:43, Philippe Mathieu-Daudé wrote:
> Use the tcg_enabled() check so the compiler can elide
> the call when TCG isn't available, allowing to remove
> the tb_flush() stub.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   accel/stubs/tcg-stub.c | 4 ----
>   gdbstub/system.c       | 5 ++++-
>   2 files changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


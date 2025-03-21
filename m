Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E33C36002
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvgjL-0002Bx-SX; Fri, 21 Mar 2025 14:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvgjC-0001wV-79
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:04:22 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvgjA-0003Xs-IM
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:04:17 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-3018f827c9bso3403413a91.0
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742580255; x=1743185055; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PL0qPEA+zXgSlNQNFSDmg2xA01GQB55ILLw+Apqjr2Q=;
 b=f61jVUc7wUXmHiXuI2fQ3on8JgHLfWRBG+eJBy6TkTJWV+QWRyIEcJ0P996u2My8rT
 d5V5E3OSaprJbGBUl2SFy3odQmI1prLuAsXtos2qfLz0Npm+VdlVT1LbdkOW4WhxfS1L
 IUaHTK/mNtImobHQCizH6N6QCQ82kTRj+kgKQm9MVEJ6zwqC98U+6/BQEhBa3K1t5SM6
 2C9c6K+92XCviNlD6c5bN/zUmhM+tr9cO9G0rMvUO9oZKCP8P75q2g2iGPUjon+zDod6
 e5WWLqrUxWgEkzRrW1BJ04RQgtj6aVaIihDmUYDtxgpIqy9ch/cdeFvG9k90n5/06iMk
 Qe5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742580255; x=1743185055;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PL0qPEA+zXgSlNQNFSDmg2xA01GQB55ILLw+Apqjr2Q=;
 b=W/Jd4HWg7mjphJ+kiLRU9BkSwu7eLiTFmEUS67oslYMukshmtKnGrMbpCxIsYhAzpW
 40KxYOMTdb2joM6rq220/CMiE640hvEewKNDaN6r/1w+i7ChWwKKQ7VYAhGwfLw168rQ
 tS1L6PXypIsaPqB67ApQ0yiclR2fDgqbCQ67utvqqOOjcqwN4UhUZbjLI44zFnNjOCk/
 VwzWGCku8lYcTtiXdaiHTBKE4T5PCZNlYL5NZpKDzNVffrXs9A1ChzCTyCaXJdQqn+PQ
 0mLIBJ8Mr0f4tJGGR13L+VlP6bSSld6E9H7AFtss5fNbu4vqWVb6IrjfbmU+Krhn0VO6
 XOdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0cECdZjjRp9Eww7YGuw3BYCMM6DvOUZpkmN6OtdUJA8WyvqBZlA9WpLPcWHGa3dZy1dF2Xwfwpym9@nongnu.org
X-Gm-Message-State: AOJu0Yy68lXKeiz5ivrf2qzkt4jG7R8DyyH0TJCScLkSC94y6Yewj9hx
 uTXKLs8RaPNWd3eedXkyB/9hMDeN69hzzmD8b/A+Gu95sQHvYgWGr91cxau833E=
X-Gm-Gg: ASbGnctJ8hF2Nlk2Ac78DEoAJgPA+zOA6zoYGtzFdrkGAdDJD7ybVw7UIoa8DMrUHWg
 KdkaWbY1AWQuECVbPiwC1TbSIeO76r2bkF4lZ6nqOgJ0JH0seVNWNRHcrHXYUwINnX87YwY4NCv
 5/fHfSuuoL0QEwbCL1pjVDK9A9PFWj3WPpXv93LYIZd5KpMOsM2o0lUPqgp2T8TDeLPcHrU+A6+
 XcyN3u3XofY2FJxHk2Y0JCXUD6c6jaHTcS0gMyFEPbhXVWS+8anaC5tRqyjceTVrsmbRVn0XCFG
 FzU26fbjUMB6L3iACTtRpjX40medTtI1omBkCIIj1i1HsRIvmKL1CCGdPK4nAEoXo/B6jK//vr8
 rFVf8MTG0
X-Google-Smtp-Source: AGHT+IHKXjEUCnE6VzHVkCLtFKWbbVt3Ake1Wt6ZXFbYB7MNgjYHbGv/cN9TbzfMXRXziM2HTCsBvw==
X-Received: by 2002:a17:90b:4c0a:b0:2ee:ee77:227c with SMTP id
 98e67ed59e1d1-3030fe72754mr4960108a91.3.1742580254676; 
 Fri, 21 Mar 2025 11:04:14 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3030f5b782esm2369450a91.2.2025.03.21.11.04.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 11:04:14 -0700 (PDT)
Message-ID: <39d4c320-1487-4bf1-8505-5a50ecb9768d@linaro.org>
Date: Fri, 21 Mar 2025 11:04:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/30] exec/cpu-all: remove this header
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-17-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250320223002.2915728-17-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 3/20/25 15:29, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   accel/tcg/tb-internal.h |  1 -
>   include/exec/cpu-all.h  | 22 ----------------------
>   include/hw/core/cpu.h   |  2 +-
>   include/qemu/bswap.h    |  2 +-
>   target/alpha/cpu.h      |  2 --
>   target/arm/cpu.h        |  2 --
>   target/avr/cpu.h        |  2 --
>   target/hexagon/cpu.h    |  2 --
>   target/hppa/cpu.h       |  2 --
>   target/i386/cpu.h       |  1 -
>   target/loongarch/cpu.h  |  2 --
>   target/m68k/cpu.h       |  2 --
>   target/microblaze/cpu.h |  2 --
>   target/mips/cpu.h       |  2 --
>   target/openrisc/cpu.h   |  2 --
>   target/ppc/cpu.h        |  2 --
>   target/riscv/cpu.h      |  2 --
>   target/rx/cpu.h         |  2 --
>   target/s390x/cpu.h      |  2 --
>   target/sh4/cpu.h        |  2 --
>   target/sparc/cpu.h      |  2 --
>   target/tricore/cpu.h    |  2 --
>   target/xtensa/cpu.h     |  2 --
>   accel/tcg/cpu-exec.c    |  1 -
>   semihosting/uaccess.c   |  1 -
>   tcg/tcg-op-ldst.c       |  2 +-
>   26 files changed, 3 insertions(+), 65 deletions(-)
>   delete mode 100644 include/exec/cpu-all.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


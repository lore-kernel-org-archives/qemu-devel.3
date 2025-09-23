Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9548CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 09:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0zWU-0001mX-4S; Tue, 23 Sep 2025 05:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0zWR-0001j6-Ks
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:41:19 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0zWI-00067W-PK
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:41:19 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45dd513f4ecso39250435e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 02:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758620464; x=1759225264; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KWoPqmvTO0S7YE+utrQnrW/HpZpS20zY8Nr9UEyJmDw=;
 b=K0LrpBtOkcXPexVhWfv65Cf7u5iwSAmzKPRJGGVG/2BGD8qq2b52GiJTVo9ahW3Ib1
 WioWXBv/Su/6+B/SxBSV6kMgEE5raAy2w1k7DAvNkECdqvNqlXF8mXTHQxSR0W+TZHZ5
 lItk9Zo0EeaB/GBY2K/cgF/3BsyGWf01856i2dPHrFTTP7P23s4UJgCQXkW9fYNHS5Pb
 MIERbDAnpTYRPtmd+YmdMzp9HYQLZtWLeKvXNbgkFlOItGrOoVWfxupfRQhRlcka8dJ3
 L636H5B8a1OSKGEiWuOe6gpCgAoq9pMyoI74Osffp8G3GVO4KnjHbjWFO4ErYNwvF1CU
 X3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758620464; x=1759225264;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KWoPqmvTO0S7YE+utrQnrW/HpZpS20zY8Nr9UEyJmDw=;
 b=ij2EFDokIciJAt1titYLpH9mbiDifrOfKt+qXa+MDPtnrvCsXQwhdr0vyErfe0DxWV
 eUJQ18eKFkvaHp9Fkry+rh805ddieHBJDajAdd2wYlWXrh1nMWYJTzbgm7G9+pQi0k0J
 LX67L5DibiLH2D2dTtrpntaH4XuZ/qzrGwQrXker4yMzPuAYgmJuafuKyF9j5SQd6h1s
 IgPGt7HjbYQBG7/U12KmmC+kyReIeR/Ily3Ls60ziuULJgOUmcjpALkeXA2Reqn7JMbs
 N4RNwClLnXg2ARh05UQb9DyyMhXpDuO9fFShZB99Pt8CNJhhHEX2TvfejSnx7UU4AioV
 DAIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF4scEVGTvnqHkd0n4R5K/wdIhF8CbUxLRgD5Y6BjCHsGWFnCUA3cXaxhMmaALm7WdlqqX4AG1Ynuw@nongnu.org
X-Gm-Message-State: AOJu0Yza4oXgKrAbq3W2NuNa8kjf/mN1TF65lNqg8ZjbHNtiRjBJ6oIH
 IBeHD+sT4l9Mcw7YuDRW1f+6IV//Igk4Fru/Xob45oDYrJ4Ix2NJ/JQ8DQDGuXbZYc4=
X-Gm-Gg: ASbGncuDI1Q8FUL4ymSVmGgk0yb77M6KIaI58amVQHFFcT4s6aj+g5/zDBiLzDeGvCL
 X4QkLFYnl3qVNeYpESliGFaiBD1NEa5xgOrNFSoKehOoHy/7W/1aYI/SX95v2ld0Gko1fxYlS/M
 WFwYnVmC+3TemH8+HOptY9B3eryqEy3N7rVLdhM8Y1DXs65djczsaOW5L0sGbX+EdG5SGboPZ9/
 jFazwVM96vgcG4OEiuz4DLTsIKMB/KDj6Yy/7cyBRaBeA7fdcdDABpvgpCQzuflkcgzV1/PP5x3
 SGTd2Xe3XOUgZxwTG6pCfaE5ffBBWIEUzD/abagO3Feb+IkA5iT28Tf3M4o3wrQWR2l80qcXqDI
 BX1ro3OLELEsworaTi3b0Mt91jobkGJF807CAjWraPGGAlhprgK1OxezBEkzLpX05X8bBw8O9UA
 xb
X-Google-Smtp-Source: AGHT+IEkUEcPdyYVal+OKD4Izind4WEqJuRPQTFwsXqzmi80QoffJSwdh6CvmgYY2o13j8oSTazK+g==
X-Received: by 2002:a05:600c:1c05:b0:45b:7ce0:fb98 with SMTP id
 5b1f17b1804b1-46e1d97493fmr22604545e9.5.1758620464329; 
 Tue, 23 Sep 2025 02:41:04 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-464f4f9f4e4sm265613865e9.13.2025.09.23.02.41.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 02:41:03 -0700 (PDT)
Message-ID: <6ebc31f0-c6cf-4e14-a87d-5b59f6c6105f@linaro.org>
Date: Tue, 23 Sep 2025 11:41:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/13] tcg: Fix error reporting on mprotect() failure
 in tcg_region_init()
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: odaki@rsg.ci.i.u-tokyo.ac.jp, marcandre.lureau@redhat.com,
 berrange@redhat.com, vsementsov@yandex-team.ru
References: <20250923091000.3180122-1-armbru@redhat.com>
 <20250923091000.3180122-3-armbru@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250923091000.3180122-3-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 23/9/25 11:09, Markus Armbruster wrote:
> tcg_region_init() calls one of qemu_mprotect_rwx(),
> qemu_mprotect_rw(), and mprotect(), then reports failure with
> error_setg_errno(&error_fatal, errno, ...).
> 
> The use of &error_fatal is undesirable.  qapi/error.h advises:
> 
>   * Please don't error_setg(&error_fatal, ...), use error_report() and
>   * exit(), because that's more obvious.
> 
> The use of errno is wrong.  qemu_mprotect_rwx() and qemu_mprotect_rw()
> wrap around qemu_mprotect__osdep().  qemu_mprotect__osdep() calls
> mprotect() on POSIX, VirtualProtect() on Windows, and reports failure
> with error_report().  VirtualProtect() doesn't set errno.  mprotect()
> does, but error_report() may clobber it.
> 
> Fix tcg_region_init() to report errors only when it calls mprotect(),
> and rely on qemu_mprotect_rwx()'s and qemu_mprotect_rw()'s error
> reporting otherwise.  Use error_report(), not error_setg().
> 
> Fixes: 22c6a9938f75 (tcg: Merge buffer protection and guard page protection)
> Fixes: 6bc144237a85 (tcg: Use Error with alloc_code_gen_buffer)
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/region.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tcg/region.c b/tcg/region.c
> index 7ea0b37a84..2181267e48 100644
> --- a/tcg/region.c
> +++ b/tcg/region.c
> @@ -832,13 +832,16 @@ void tcg_region_init(size_t tb_size, int splitwx, unsigned max_threads)
>               } else {
>   #ifdef CONFIG_POSIX
>                   rc = mprotect(start, end - start, need_prot);
> +                if (rc) {
> +                    error_report("mprotect of jit buffer: %s",
> +                                 strerror(errno));

I'm not keen on handling errors differently in the same function.

qemu_mprotect_rwx() and qemu_mprotect_rw() already print the error.

Why not add qemu_mprotect() as a simple qemu_mprotect__osdep() alias,
then call it here, also covering the non-POSIX case?
(Question for Richard, after looking at commits 22c6a9938f7 and more
  importantly 97a83753c9 -- wondering about WoA).

> +                }
>   #else
>                   g_assert_not_reached();
>   #endif
>               }
>               if (rc) {
> -                error_setg_errno(&error_fatal, errno,
> -                                 "mprotect of jit buffer");
> +                exit(1);
>               }>           }
>           if (have_prot != 0) {



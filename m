Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4B7CD342F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 20:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLRzs-0000eV-3z; Fri, 08 May 2026 16:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLRzp-0000eL-Ko
 for qemu-devel@nongnu.org; Fri, 08 May 2026 16:40:29 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLRzn-0001fv-Mb
 for qemu-devel@nongnu.org; Fri, 08 May 2026 16:40:29 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-45f053b7b90so1466823b6e.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 13:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778272826; x=1778877626; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qUdubkRHScVeWTzRucOYI/lytJpyZIKRIyWDx82e1f8=;
 b=yjtOLZi8WqybN4Twoyti075UKvUh9bqJe9KjsARgs9cLyl1Crp2N31+MnqqHwll/4k
 c1mty+UMtw2yQU5IHa8cWDclAVLDXr1K/OnfQUXYXi0wXsJXgExMjAw7pFR8e/P61at7
 2R7/uFI98MSCVe4PR2RKF25YzJqP2rL+HrQmrHIuLuJDWloCqB+zotVge4AhN0U6R+iL
 H4FlE4CB3yuomRXXlZVjq0HQdFMpM8dSuLGyqig2G3d+Me2cKwAGbHgHfIUFrMfqy3UV
 cbQgheXz9XDWT6muq7lgPN5Aoo495ZA/g6lrkRHE8xG0jxuIY6WPgUKZq7nDGdlj5ZDg
 85YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778272826; x=1778877626;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qUdubkRHScVeWTzRucOYI/lytJpyZIKRIyWDx82e1f8=;
 b=neG7twDhvyVnDQTEyaGWG/2w1eDaqBvGFx0cXOBjWoZKLJOUr3lPN/fZd31pM5JZwT
 ehtmQyMC05laXsOnAEOAnF8SekQUMkNqjYDBlB6Zu2/S7YJ5vQAGMyl7GzFYtqCy5Mbu
 7IAvwpRDg6HoPOk7XS2H7b69vWm5OmRhHdGHVpaWlsCqXKOlunFx2mXEDtExj7ALFfdQ
 OBSUbNWkwON3v5wvYVeyVDZpeOhlYkNkn9Ys1JXmbDo6MHFKGGVGlIvD8fs754w1tRQG
 ppSXkkxYOWOT/qdDTetVb/61XRxGe7HY+iI9Eo23KU/NFX+7BU58hbFw+yPjNSEy4WsC
 XuNA==
X-Gm-Message-State: AOJu0Yxm332VKYpL+pm9IjXInfhQnrv/6gHHNxNcWBHGaV4Ha1ZyUl3M
 zM37EzQqoNmZ1gKVieQjoRfsgH496r59VrZaOgXVB7+Hgv4So/T0OasonmV8BIG46xjdJpihVaC
 mDgMF
X-Gm-Gg: AeBDievrFuwvowdb0ZVr3wNCDfr090RADJIZyl1wKlpJD4TrphHVG7WQ23Ukm7FayzX
 gp8Sw27E8/tSg8udNoahPlxDyAPhBqZxjULVMUDCJ9r4m0juzHb6o7uFaDSAfIeQFhjGGsPJBoy
 CBwLI1uiF1cWdyfvQlrusExgEHyeJsjADqgsHyd6lCjAYIukpVsbu6N0T6u5sFvqXuYx46Lfs3T
 j/ZfLTbCbnESNBOW+TbQT7TI3tHjWLW5BunZW8LETZnS0C3lOkBRgvZr0O4lh42M9O5EsXs5NsO
 vPXdvGvMQHW6nCTZ/UPjqcl7d0JAyFUupXgtpd0e97sAWYKxXwn/ssvXTo6e4hDuVcETi5jvZvR
 6RX7d8zaYmQE5n0tRaHK1Ef0IKH3k6uHpeNX6dGgKr0pJsN/PLZUpAlxQuyLx3YJyy6I7uf1zBs
 k0Bv85xf+x2CPccnetvFQJcWl2MQIDlXMxD1cuplcYmOZnK6jOHvYpfqx/jmhdecygMRr/bcEXK
 0ijCgcYMDGrs2/pOA==
X-Received: by 2002:a05:6808:bc7:b0:479:e869:5424 with SMTP id
 5614622812f47-48042236082mr9244784b6e.19.1778272825913; 
 Fri, 08 May 2026 13:40:25 -0700 (PDT)
Received: from ?IPV6:2607:fb91:1a91:1de:21e3:45a9:5df:5a65?
 ([2607:fb91:1a91:1de:21e3:45a9:5df:5a65])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76400028sm15287741b6e.5.2026.05.08.13.40.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 13:40:25 -0700 (PDT)
Message-ID: <09e4e0f3-299c-4ced-85cd-8dbacfaad8b1@linaro.org>
Date: Fri, 8 May 2026 15:40:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] hw/arm/integratorcp: Use LOG_UNIMP rather than
 hw_error()
To: qemu-devel@nongnu.org
References: <20260508162013.2751001-1-peter.maydell@linaro.org>
 <20260508162013.2751001-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260508162013.2751001-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/8/26 11:20, Peter Maydell wrote:
> The integratorcp board has some onboard registers which can be used
> to raise IRQ and FIQ to the CPU; these outputs are supposed to be
> ORed together with the main ones from the PIC.  We've never
> implemented this obscure bit of functionality, and instead call
> hw_error() if the guest does try to raise an interrupt this way.
> 
> Replace the hw_error() call with the more modern way to note
> unimplemented QEMU behaviour, a LOG_UNIMP log.
> 
> Resolves:https://gitlab.com/qemu-project/qemu/-/work_items/3406
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/arm/integratorcp.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AF0C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 22:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqJSX-0003Bz-UE; Thu, 06 Mar 2025 17:12:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqJSS-0003Bd-Hw
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 17:12:51 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqJSR-0005of-1w
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 17:12:48 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22401f4d35aso22184105ad.2
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 14:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741299165; x=1741903965; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=krQRbOL278W+oJrJxxiSvtUOLHtiXoInrPgfO0rnWE4=;
 b=VKTuhV55EXYHQTA+vwapmv7C81yMtBLjayxBEIAiDODGKlGo3VuvHsWbLmp26mTUPT
 Ck6IcQPIa+JGbEu+A9WRCTKxNc+JtFEd+ipdI8WvUc+Yns9e7/hAp9/oa70RPsfUK00I
 UURe85Syxly0tzQogJSSun0OHssN+aG0FG4JZs9lYliM14zQvAXKrb6c9ngM7GaotqII
 7PtRt/3hc/dzz80TIaEd+H3OAwLEjBhYsFLJUX6LcmeRa9t2fUiQIWpAfNBEwPlUMrQ6
 G0TZMbr+zrzLAFNLJ+GCoTR6Mp1vkGQhRiowpT79WM9GrQr7hkMbetdrJiKAX2VHGe6d
 ywRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741299165; x=1741903965;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=krQRbOL278W+oJrJxxiSvtUOLHtiXoInrPgfO0rnWE4=;
 b=X+5Ijmudo+k+ia/hEiRDbHVq/dXNRjz1U8hK2GqYYD/GU5cXjE42hDZyQvqdkNNadp
 bdtSGuO+qbNzXrYzy17CuOErbJQ7WvxTpbgDkq8Lad9YoPPz4MtJomKJH6wtIe3Sn7WT
 zjdZevStQw0VxSWHx33YFTZlXlzyQdvU62OuL2m/rBFoL5OcC91/ioN8m9lf4lUjExA4
 HlVjIiE3YV2+PAn06pjUYRnsBuo77ODfW5tHa4ao3h4gitG1gA6wPiIcfH/oiA56jgdH
 QppfEUpNe9BBPyCezCJhueSKxo/u/4IZGUSfRbMvvnHvdqK++m4UVUe7+Y8mLbil3qKd
 dApw==
X-Gm-Message-State: AOJu0YyRgeSJMRiSAD+kq0XAB4/cuOtHcXMZ8xRpAF+N3HIKTT7rbDj+
 ffHUv15M/fNG7ptfM2f6o3hiPb8nzg7QeGbzlkiqk/R3SzbUSm00je457YuUGb8ssEppz/qYy08
 G
X-Gm-Gg: ASbGncvkunHe1AziEQCXJLvacBQ/GxQOTN7e8YH1EJlGMp11NtDhyveZuEol5vcYRkz
 bpcvlnnTP9M0DJ/MRof+pGyIaR/x1IzpuyJVwrqaEfz76nT0Dn++i3FdWLr7AEehkRE2rbM6K21
 VBdl7IV58XTVsYI1ncemCsAsZwL3HUc2AghLLtlX40b5xBiLGOU7lQ9DDo034WJ2mVQoYv9J0QP
 6F6wb2aWd+3D/gHxc7GDIOj2HuoNsbYAmrEg9WOkKVpkTtNXdE/JjFwBDj+6XRxoVVFRjWJo/Y8
 +dvjrwqHVSkawrmm1hXzv/DvxVvLKdin43zFdWXeuZk7SEs9eox64GtCs4HYuaEA6u7Q2dvTfL0
 c3si5mgD7
X-Google-Smtp-Source: AGHT+IH3HvKVgQy90h7Q2Mvmxjb1TOtdNQ4F+SkZ9jtodOlQq2jwgA2ZSfBYduzpyeHZ6Do8GGLIQg==
X-Received: by 2002:a17:902:f54e:b0:223:4d7e:e52c with SMTP id
 d9443c01a7336-224288695d3mr15362495ad.5.1741299165278; 
 Thu, 06 Mar 2025 14:12:45 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a9193fsm17441835ad.164.2025.03.06.14.12.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 14:12:44 -0800 (PST)
Message-ID: <300563a6-a37f-47a7-bb94-74cdcd6256b3@linaro.org>
Date: Thu, 6 Mar 2025 14:12:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] target/arm: Move arm_cpu_data_is_big_endian() etc
 to internals.h
To: qemu-devel@nongnu.org
References: <20250306163925.2940297-1-peter.maydell@linaro.org>
 <20250306163925.2940297-6-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250306163925.2940297-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 3/6/25 08:39, Peter Maydell wrote:
> The arm_cpu_data_is_big_endian() and related functions are now used
> only in target/arm; they can be moved to internals.h.
> 
> The motivation here is that we would like to move arm_current_el()
> to internals.h.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpu.h       | 48 ------------------------------------------
>   target/arm/internals.h | 48 ++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 48 insertions(+), 48 deletions(-)

Is there a good reason to keep these inline?
The expansion of arm_cpu_data_is_big_endian is really quite large, it would seem.

Either way,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



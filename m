Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855A0C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 17:44:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7HfM-0003Xp-EE; Tue, 22 Apr 2025 13:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7HfA-0003P3-O8
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:44:07 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Hf4-0000Ue-Vi
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 13:44:02 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2264aefc45dso88375515ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 10:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745343837; x=1745948637; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jJxGT4J4hFEenr66Ptf5pPowe/TkLeXl4WCz5eiwODM=;
 b=Qkl/u+fvNmHMAsInLdksYAFERpKMQugpYhoa/Ciqiax3md+L51v+Uk66gjRFeRWlVO
 iSX+219WH4ToYy/40zFN/roaA2Z6FdarE2zNy64PlNNAczrZtwF7Pmn5qAHy12u7AFFr
 r1RgBHOxUNk6TvXLcekS+PC+m/ZJNXTziIUnzcrdC4+oSk2rt9EARSEM7OGFy+3k1acZ
 A1pTMLTvzLfam7Gg7J/c9vJrymqCK4CqJdAMeFzghc4oDyQC8Rb9v6JdI7emTgEofpEy
 CEN136NtW7Ro1x6vYw/wXQT49S4cjG/jioQco08eupkNegl63xE9yMHZofZ+1NUrWO5S
 TY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745343837; x=1745948637;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jJxGT4J4hFEenr66Ptf5pPowe/TkLeXl4WCz5eiwODM=;
 b=BwdEEyHd/FxmWQj6xBGKQxZ9xucro+BWxKLa7skFE6p9qbMVX1t48gTsWQB8svA+Qq
 EnAYdhrFpT8W4J+FoTDCLaYW6d4iNS1SMYZ7/xeKngGcMBvqr3u3v+0L4kAkNSwlC+Y2
 M01CbT/7lUR3xPveBe7VwYrECVT1csdL+8c4AGdvCQt6S8cvYG/BzjJ5p5ZtEkd30AOo
 03fPhVtNNDXDSWmcGYODazrKs+sL2TsdSdbCmL+X0zvjtH5bfv1H1/jhtAanriqvsDhJ
 V9bAXjsS4I1hRvB1v91bFZfquQtGG/xPrKafxgl7R5zBlszFm847K1dBLKAHoD3VLact
 BAtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcwOPkFe0Flm0bQyO7MU4ejdj/r1GVMa6Yrf9PzdZHSZ7yA9FA1a74knG3uhYC5etTbkaCwWT+06eg@nongnu.org
X-Gm-Message-State: AOJu0YysqhBIQMMDsTmBFmVGt9Ty87pvtjX3nW7zvdZJuWxmuswT3Nda
 LTPSr97YIOK8PiZxK9jyXdastD+5/UgE3Adx6ZXTjApy7azRWh3WnIfMJ6CtyPo=
X-Gm-Gg: ASbGncun4KO/MoB7Q9WTYEionOMe+MjK6TKcZxRGXdzvjOHk7+7HVcpVYG18C8LvQcM
 h1xZkWk/faBKQt5D6/f+siUvz56NPe7F4ACYEd0IqmcFOpleO0xGd/IrpRVKaIL/m8kH4XtuuME
 AV55OFkenQLF5SFzpuZN8SJZsgVwNUOzALk5G6bH6MXygXKaNvZ82qIZJfneGkfLmaqZTp4NOPU
 mOiEfag/QPV5OsnnKug0qSuunwbHASAr4G2uQ5288vjAayNcD726jktcQmP7vlKQdq1snow3VqJ
 eZqvJF7vnJ59XURvU2QetkTOkLXrb56FggLNv+QuwxyFj8KlJDkz9P7BZp+ve6ez6iqhsOkHE45
 CbramSyQ=
X-Google-Smtp-Source: AGHT+IFo6dfUHYvJxGXIE4zVn3uIaeAMNTMO045lw1rz7G6nxpZV/gMtThrYLfapNptQTzfX85eFhw==
X-Received: by 2002:a17:903:2451:b0:224:1c41:a4bc with SMTP id
 d9443c01a7336-22c5358123dmr262701275ad.12.1745343837038; 
 Tue, 22 Apr 2025 10:43:57 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb48c8sm87645915ad.145.2025.04.22.10.43.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 10:43:56 -0700 (PDT)
Message-ID: <bb78c15c-1986-4573-a529-73944efc4373@linaro.org>
Date: Tue, 22 Apr 2025 10:43:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 10/19] hw/arm/raspi: Build objects once
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Anton Johansson <anjo@rev.ng>
References: <20250422145502.70770-1-philmd@linaro.org>
 <20250422145502.70770-11-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250422145502.70770-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 4/22/25 07:54, Philippe Mathieu-Daudé wrote:
> Now than Raspi machines can be filtered when running a
> qemu-system-arm or qemu-system-aarch64 binary, we can
> remove the TARGET_AARCH64 #ifdef'ry and compile the
> aspeed.c file once, moving it from arm_ss[] source set
> to arm_common_ss[]. Note, we expose the TYPE_BCM2837
> type to qemu-system-arm, but it is not user-creatable,
> so not an issue.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   hw/arm/bcm2836.c   | 4 ----
>   hw/arm/raspi.c     | 4 ----
>   hw/arm/meson.build | 8 ++++++--
>   3 files changed, 6 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


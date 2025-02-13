Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BC8C0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 12:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiYfA-0003TI-OH; Thu, 13 Feb 2025 07:49:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiYf8-0003T4-7E
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 07:49:51 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiYf6-0007A0-P9
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 07:49:50 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38dc73cc5acso492422f8f.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 04:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739450987; x=1740055787; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4srvB/9A8ErSDCRd1CWIjMOJLrkqosgWBXCJxU5hw34=;
 b=TSLY6q/g8LEPodlaJg+cnKEXszKt/ALeB8nXnimJbYqxKC8lLGBs6+rbO2/DWaNH5g
 9tE/jdwA7Y+4Wde8Ei32Q87zjlc12JS7N6hwDqQUD19jPyUei3kcNnECGjQAMcmPA0I1
 +a/86/P4/zTfdJ3Hzx5d5S03siR4p0TJGf37L7QkI3gtCg/QgDuWUzK8YXiYe5EwcfvX
 5DWpwh5IP2izoDbklz+OSL8c4TxTjBMknBcf2eIMzsWcu4/CWy97FDx7v8TQK50v1PGo
 /dGsx8qdcIBa266kPxLmOXp6j6FN9F8xLiodm7oHGSFLw1Hv1Zw4JIzrjc6JMtGr1ht7
 vQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739450987; x=1740055787;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4srvB/9A8ErSDCRd1CWIjMOJLrkqosgWBXCJxU5hw34=;
 b=vHjBL73rKM46CNaz1a0EF5zXLIJqeHweFrbQxX5V27tMivhpWhJtdKmZOJm89Icwh6
 i6b8jXAF7ZwJAuWhr6In+DxLAT1qUV30p0U24bXRbbd7Z7241UwY0MzwqX0PvSxP6s+r
 l6xp0VhJGO2LnG87WPyGTf0gnT6le930SXUZ5iLvib+siZ9C4IN1ysU7kuHFHV54D3vA
 B+7Ad0RYVumcbBNlfIVaa0OftoLy24aV0dmXgZkww/CM+QEJvF+psN3ArNnxL2qYJH2R
 WyKc40X07ppGkN8O5vKxwxzV+BauJUq40/S07X5k5c44op31hEGqnge7qc6SjzqZ7KCt
 Px9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdMpj3e65USDJqEheWLGXnjww88y/j74ynI0mnDhvaohTapXFYqdpPV+tISf7IA9X6j+ad83aAK/ep@nongnu.org
X-Gm-Message-State: AOJu0Yw0l08Iz/L49EHsmBNVZE8CFX0WVrBsmiqHfyCu7sPJiMkKBUTq
 K9NfrWFCj2yg8yhTQv+p0INznrxQkUstz++zlknbkcPjkDBDa7kakyw8qwR2pYc=
X-Gm-Gg: ASbGncuneaA0bO1ta7/JtZN14+NlJSctgj0X/+0Y52IOR+Iwumvyvy8MuWp1RCrYZl2
 Xg1BRkuLZx3s7iZS4KC8kr0vR0qSYIBrEDKHQfQnhjCuqLzDovIc8vjdRrg6sGSwgXWwG4T7Hzs
 xc2CxffvaQQUFlPjGHhpDfJYmiITBoIz0f+Gp3bI0ywFOSEuM7FeRFRZh1MbVXBa69ZTDWdMSte
 sdjvksAZlyfzITttt1mOHL7tu9PT9dUs81uT/c8RgRhSebQ34ESQd7D6pkV55kHUNPZkQmpzn6y
 D6cFSKl/CJQ6NthbE6u6QXyE+adbA4MZnrf/jTzjXV2UT8Y=
X-Google-Smtp-Source: AGHT+IE5eXs+nMgqFTy47DVVz7d0VrDxHbgiproB+DeSjQqapJxW+ZluYlQQ7AmbIdRYUMbS47KXYQ==
X-Received: by 2002:a05:6000:1fa7:b0:388:c61d:4415 with SMTP id
 ffacd0b85a97d-38f24f7236bmr3061992f8f.18.1739450986728; 
 Thu, 13 Feb 2025 04:49:46 -0800 (PST)
Received: from [10.223.46.213] (6.170.88.92.rev.sfr.net. [92.88.170.6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258fc7e0sm1790516f8f.48.2025.02.13.04.49.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 04:49:46 -0800 (PST)
Message-ID: <bf3d3847-1d4d-4f39-baef-408f62be0f5d@linaro.org>
Date: Thu, 13 Feb 2025 13:49:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] target/microblaze: Use TCGv_i64 for
 compute_ldst_addr_ea
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com
References: <20250212220155.1147144-1-richard.henderson@linaro.org>
 <20250212220155.1147144-6-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250212220155.1147144-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 12/2/25 23:01, Richard Henderson wrote:
> Use an explicit 64-bit type for extended addresses.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/microblaze/translate.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



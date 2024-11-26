Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6217ED3B98B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 13:52:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFvyr-00079n-FJ; Tue, 26 Nov 2024 08:51:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFvyq-00079b-1H
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:51:52 -0500
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFvyo-0003Kw-Je
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 08:51:51 -0500
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5f1e364cc22so894355eaf.2
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 05:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732629109; x=1733233909; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jrLGiDsMZ7cqnM+ZBeW1wl/kfQR8trZ0EMtaBJiARlo=;
 b=TQzVPTxWU+yVLXbokByjdg5qQ2zAmCho+2yuYbH1XLeKS/hNmI2vTVpsDCFrGoUbQb
 Jw3DOE8mTxpShsweHEzunjX9vwwAL+LenBs5gQMm4BdJ3tTvdPNpFOIc5f8QWEb5/u3a
 fGHLtbvoN8SlDyaCvJm+tfRrtX7vPRhgafjkCfVekDvgzIgqsTvATHp/v1wPVEuc2P/j
 AD+rga2FKLyWtKwFGnJ+g+6hDnBJ+5HlDuZAyBpOKYvMrM2Ghnr4H1XnjrlcY46HN3f9
 jMDQpcbPGyACvIK53R3Oy8HnY2vihO1hrz/+P+gZW53ZazCefIX1pghNU1AFRHCNmXG+
 157g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732629109; x=1733233909;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jrLGiDsMZ7cqnM+ZBeW1wl/kfQR8trZ0EMtaBJiARlo=;
 b=Wuk5mUC4ZjJV0yMR4KZ22/zA3+9ZAXau1T6SlisdaA5ccrKCXFDT5hAMsc1Wq3fp/f
 krlxPSRw8oxRA6YcYEmSjYfQ0wvdpDnljVu9yw0vzkqjcw4M75d8Opfc42zfRd+Jmy8b
 xq1IZ7oyb6ITMMnucAFBSV8uxZH1BdAcMZK1ThkUVaresvoBIYll3Mb299Bbi6spb39C
 hCqykMso4UMIAd29dkYoq7dVDY5YBsUZ89QjvWjtsBk0HT25U46g1v5f0m2HkHiYQ+6h
 yQH6tydEa6UmwIeC4uHON1wOugX91qkxmZaBnCu58L1T6/CaSoRBHiyV+1EyILWHnd+2
 qaYw==
X-Gm-Message-State: AOJu0YwxcVItbaURn7F530gbln8VYrLFTa4GI7FQ9JxRU0y2Aqr3tJ3f
 cMHAUwSZrjxZMJNINY7uiyHt6RWsXPQ4GJACco56PkyEgeZNmNXb5s88Lv0aMRuJ9Up9QpPRiPS
 q
X-Gm-Gg: ASbGnctGfvlWfiiZjZXuy6wm4JN6lNPyDKNCIhyCQxF6vFixHeJ145ayafJsRmt00ll
 URPHfcwMyFGs165Qi/IrIBu12R4WMssEJlAeBMl9HGjlISFybumqVgOXTCvjyuw/P8exy5k69UY
 +jdOLXaafDScdvY02Zs53937/+ecsAHuXPW9HoFlkKi9xNad7ofSK8Me9aH3sMOllKajTQR4sS7
 IwSx6vPgxiQToZJgkIuPeKLZJtB1vR1TQqovFZiDYEPWD4CrxzVf/HzTPwkrdM4Sg==
X-Google-Smtp-Source: AGHT+IF0Q2ljhf8mRGEjb0GMQc1lznZ6G1mTnSg1X3K9xp0lagZBp9HVQ6M58FhklydoHu10ALDIwg==
X-Received: by 2002:a05:6820:3093:b0:5eb:c72e:e29b with SMTP id
 006d021491bc7-5f06aa20e0emr12647202eaf.7.1732629109316; 
 Tue, 26 Nov 2024 05:51:49 -0800 (PST)
Received: from [10.25.0.199] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f1dd7eac6dsm1600536eaf.13.2024.11.26.05.51.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 05:51:48 -0800 (PST)
Message-ID: <d096ffb6-ad87-4543-84ee-33d72bf5608f@linaro.org>
Date: Tue, 26 Nov 2024 07:51:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] target/mips: Rename gen_move_high32() ->
 gen_move_high32_tl()
To: qemu-devel@nongnu.org
References: <20241126131546.66145-1-philmd@linaro.org>
 <20241126131546.66145-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241126131546.66145-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
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

On 11/26/24 07:15, Philippe Mathieu-Daudé wrote:
> MIPS gen_move_high32() takes a target-specific TCGv argument.
> Rename it as gen_move_high32_tl() to clarify, like other TCG
> core helpers.
> 
> Mechanical change doing:
> 
>    $ sed -i -e 's/gen_move_high32/gen_move_high32_tl/' \
>       $(git grep -l gen_move_high32)
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


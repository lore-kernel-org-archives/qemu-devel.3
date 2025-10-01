Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA77CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rMH-0001MO-Si; Wed, 01 Oct 2025 03:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3rM7-00015Z-1s
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:34:35 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3rLy-0004Vs-MM
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:34:30 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3fa528f127fso534597f8f.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 00:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759304052; x=1759908852; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H1jX1v0kE55pVH5xtZ0Hx48WSxu4mu4vGlj+7h9M5Co=;
 b=EWw7sh1t7MmTY8IKfmOBnCApCQM772eQ+tnbGnZBjkuAPA2Mq4APJYucWH6soCaT0f
 FYFvNghOPnM83QotPp83N+OHi2uiD2o2GBKwdRQjCA863XajHyZNc8NkFu956KBo0lJs
 X4dLaZqPUMtKrFotVF0J7BaHOSX6pMpvrP7NGSK9R1o7TtQKUTHqQG2xgiw+Q8vy3IVz
 S+QWewNvaEv1ZoU7H3gOA6iejvGe50d0xDruVU7RvEKZSJZk1pX7fP+ehSzs2X2ELmAx
 SNlWvqUj3flTjrMvMR5NwEo64zQ+cDQ10a8cmMVze72IIQA3fX12DZA/zj65supiyHvH
 ClyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759304052; x=1759908852;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H1jX1v0kE55pVH5xtZ0Hx48WSxu4mu4vGlj+7h9M5Co=;
 b=t5ugho11bSUend2nmxwCSLNfXdyeEKJnWu7zhWr3zof+vVPfeI1RdhvMPANe37WNPi
 zwmpLeaeNONxlchpbj03w6zVCVa5yPajMSBHM050I2zMhqnvtcg3QvFUIRTqwSwk/VYS
 LAa1/WObjGg3FnSYtuO6Lf97Al3dXtJsUDCsUnsFKrZ51zY/4eH70M8Ef2QAszFaqkGC
 WeF1TYDteaTCoADl8Vn3g74OzzqThoOOxvh5ihC10kV6lnNAFq5xvQsCD0A5OpF+5APi
 fn3Py4Y37fBzWKJiUrN/AfcilBaGF44wgbzeighpGZQvG1T5hyhT58GeUUHSUQ0rBKNL
 7HYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUf1PnlnIMFCgxgV5g2IYYYQLF3rQv5MhzL2KdJNsLtbid6QsENG1/jieSWe3rOWO5rauEJ9CO7Vl7@nongnu.org
X-Gm-Message-State: AOJu0YzUoYiXGQZ5EWqKSXjiN6EEpabXz95Pvm+Ebu94wO0VcyMFGePy
 TDgtDV0bZ/lTbhF8Y+cOYyAPc8rAnL7aw6nY6S5ymbFNSYB98zrQ+nFovsNX1/YIQoI=
X-Gm-Gg: ASbGnctu9gEBALVlwBnGVy0ya0atI+xPBAPjPfhjGg/vgwj8bfjRr/mMrDElftRvnUg
 KJq4dKIQF+TZav2IIph0ewvCHItO+cM3qns1f5x+OabBs6NSfElZXrvgBFKw4XtBaYVczzZuTpJ
 mlJKEQOTErL/i72pIHdjhg0KG3kEX+TdgQrF8cHVpkldxvBM3atRXw74o6xgZKaRVC4uSmwgZFA
 vJUxOnJDF3A4+a3uVb+bqilMIAmFiwT6kIkmACvSHiFMAa6/TtypyE85jFeb7vh0YQkpeyZJoQl
 syat1jkTovOQe/h/AU1Xja7/5+O696+CZbZyt+n+621ajK9Sb2vwkt4EMYZRz4l6kMpXSIBPoT1
 QSwDDU8lsepCODevuv49JbPZ6fmcjTOYDhNJmr3/kdtukvpvV6T4Zsd7tW++YM2yGAZcwevRc8V
 RTqhTYPkcaNEKFNg==
X-Google-Smtp-Source: AGHT+IHRkZ3Zm9MvwTAkm960GVt5/Uk1xWi1ka76tRKsAhT0rTDVyaX+XtUu/R1LCl564JI9x6qZRQ==
X-Received: by 2002:a5d:64e4:0:b0:3eb:ad27:9802 with SMTP id
 ffacd0b85a97d-4240f26156amr6148993f8f.2.1759304051884; 
 Wed, 01 Oct 2025 00:34:11 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5602eccsm27257726f8f.40.2025.10.01.00.34.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 00:34:11 -0700 (PDT)
Message-ID: <1fe86257-45c2-4fa5-8f1e-d1c4c29af70c@linaro.org>
Date: Wed, 1 Oct 2025 09:34:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/33] target/riscv: Use 32 bits for misa extensions
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-2-anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251001073306.28573-2-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 1/10/25 09:32, Anton Johansson wrote:
> uint32_t is already in use in most places storing misa extensions such
> as CPUArchState::misa_exts, RISCVCPUProfile::misa_exts,
> RISCVImpliedExtsRule::implied_misa_exts.  Additionally. the field is
> already migrated as uint32_t.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46463D4A60A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 08:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgesi-0008HJ-IV; Fri, 16 Jan 2026 03:08:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgesg-0008Ge-DO
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:08:30 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgese-0005kk-3n
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 03:08:29 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-42fbad1fa90so1567785f8f.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 00:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768550906; x=1769155706; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YFkTeaYZquD2Ymc8DTfXUC78Vj3UXbS7W0QXE7iRCwk=;
 b=UG0ZVyIWO6kM0TAKt9vijQP+dlCrcxBqH5r66/izBvEL0azSMHemE93NYrdLnrFVjW
 nbxP1mD/Gl3GOTIUICwrlHYZzpX99eXVBwwGCRtkR26ORwFRXS1lD30txykvLR4sn8wX
 l6hTuu/8fEoyu8ICawdog0yqM76rpGIQkX/8iPRnACWlrHlBEN7+89whYFhl05k9ZLt0
 DWHw5YPUxcQ28M98UcN0BCiezDMtu2C3F0/ZOafK1XQ+p+gijA/hIQGh7MdS7Su0S5Fa
 sfL9y4v6MDlLq1PKG0dxXqTe7b/KB7DCQq15EYeEkkr23cPmHDYkCVCrwulClMTW3XZn
 USaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768550906; x=1769155706;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YFkTeaYZquD2Ymc8DTfXUC78Vj3UXbS7W0QXE7iRCwk=;
 b=qPhQuzSbIcuMbYczxYDGoozf/MdnHgHW7UKNXBOPbocvlmyutDIAFDLyAlAIsNLbeQ
 dPvV/Tm+dS1Zxjy2vDk/bESChsWDWe4GQiqg3E9lGto1GlcD6S+zul928D3+EHlLHLQp
 VlnLzVx5D9lc2ca5vFOTkj4MGExd1ZYjKaxty052S7fkDhYZDVhCLzwx3mtieBEwECLU
 h7ByX8XK7AL8dN4mgm266+y5WB3WX5e0DuwEtCr8AP8F4xLCE6a2DTmnsFXsYKHqgfHc
 iiZ43WMnu1CU78DdyKcqTz+EDsEosM+2buF5bhxjQEu2lJTW6O4zOWUS0eQ94KR6KAfU
 VwCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6BMSHmjTFCGBKltNMD3f/MaI73he/P+E07bRPdsr06Ibr+MnGz6ZADlL+0z7KGI2angSN39DIVaEB@nongnu.org
X-Gm-Message-State: AOJu0Yxm0qO56bYAG0piHq8/t7OiGGwenT65sGt1+UNowrybzAD8ZP9P
 EnWVOnb7JI89u5NIifF94OfWVqphScDJwdJUXIFExHOPfUI52xQWE+s47BGbI4wxifI=
X-Gm-Gg: AY/fxX51hZqdYxiSGFHxDBgVg6ydiIUJAeGk7mB53FFpdgAN7y8pZCApaC3CmvTMimi
 g/O/hY1sA/9WNruXKp+JqTuazfe/DR6KnuuZ05XmTmFIDU3D9KicRv8gZ+w3LYqq5KP7B+LTKmV
 UXXeFqxSysYtx8irVy8j6ibWxHthKDhSd4szbb0XAodfE2ErpDqPsRhKDxgBM2kCSRS7tHet6Xs
 7SZjbPO00X32Zols86vfh9y7l/d5h8kdQVOsfzXKEVJtGrfUi7KXNZImP49DCEY+5wV2dn59Cr7
 vB9oLM37gmOhtU0WkXtxJm3Nw4oMZFDx5+wO2QAXh7w5I6Zi8Ltm5M58gYazlsw71IaE2KsKzFU
 xB+DnDElmHOoVnZCeHo1iLXieo+GeIm8y5HgAuS1+CGepaivvMtFw6YGUEqV3X8rf4Zn8iepgC3
 K/EEEVQBmPCXFIM46xjjYHFAYnNCEiKm3XcJnDfOUS2o0CvJQ6XmHYlg==
X-Received: by 2002:a5d:5f53:0:b0:432:84ef:7160 with SMTP id
 ffacd0b85a97d-4356997f4bamr2525010f8f.12.1768550905748; 
 Fri, 16 Jan 2026 00:08:25 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cecasm3425935f8f.26.2026.01.16.00.08.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 00:08:25 -0800 (PST)
Message-ID: <b51669ae-3a3e-4db0-84bf-d005f9bbc04a@linaro.org>
Date: Fri, 16 Jan 2026 09:08:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 55/58] util: Remove stats64
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com,
 pierrick.bouvier@linaro.org, thuth@redhat.com, pbonzini@redhat.com
References: <20260116033305.51162-1-richard.henderson@linaro.org>
 <20260116033305.51162-56-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260116033305.51162-56-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 16/1/26 04:33, Richard Henderson wrote:
> This API is no longer used.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/stats64.h | 199 -----------------------------------------
>   util/stats64.c         | 148 ------------------------------
>   util/meson.build       |   1 -
>   3 files changed, 348 deletions(-)
>   delete mode 100644 include/qemu/stats64.h
>   delete mode 100644 util/stats64.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


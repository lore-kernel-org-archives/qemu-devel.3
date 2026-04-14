Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E166F9D0EC
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 17:43:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wChmL-0006OZ-L5; Tue, 14 Apr 2026 13:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wChmG-0006Nn-6c
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 13:42:21 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wChmE-0004ho-Jm
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 13:42:19 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so56138625e9.0
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 10:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776188536; x=1776793336; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8mLryzvirqb7/wKMhWXyGJHFsmWtP8zgAM5xmzE8UJI=;
 b=QhXgJJjZLdd6CHjNRjIk3k6gciLhEQx4NZ3oGVRpdqFhvQZTGbxleWujCyj1bBJ82I
 Y0hpCjv3MXv+DttrZXDSqtVVeQCs9trDIM8pjhiZ8H6YXoc4qYknBg597ynjrcZnYJvK
 LLARn25Lz1tV6Y7qvW//8qaXcuCUZYXJP4wXn+VXeg1bLIsG6xfFmDgEK+xAEKpHytVb
 WRZ+L5gO1oEebVGM+BGj7Id5c1eeoi2HPnNXhBoHC7fgUbUif8xLdkv3tjFXJlw4EyJf
 slUBdiWLA2tcufrQjNSH6hFrV+OwNiA5btnAL8WtdulzfrfIDZqiBn8DrK6puYRd2Lm3
 jajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776188536; x=1776793336;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8mLryzvirqb7/wKMhWXyGJHFsmWtP8zgAM5xmzE8UJI=;
 b=BexIGfr2sLx/GVyysSXRCUFt1F00ZV9/k/AJkNkAknpdgXyCKHg1INdVo3UQx4lVBI
 4P1NGx9J1KQBcp0PJBdaA8MjiOYR2Q6w3H1RkIxCQxH1WjPig0tPOIAmMV2Jf1nRN7JI
 a3G3M0ig54ACRYQCDoj3Ux7O/9GQnn1hdODLBtHBs80X9tVis2L+++iE91VKq6LHMhYx
 CL9Mx9glyxB0DWBCu94kfXgzDTdTAoBTqQd4ODBrKzFI/XFhmRK3TQyJg4SitZF8gb7t
 najjbI6H80e4xvne8CzE1DLPPChBCgWn6fvQVtSD/j1gAXFALp97GaT9ZAfeULPW1z4V
 ZIVQ==
X-Gm-Message-State: AOJu0YwNAmcvRpzjaW0k5sdE+og8iTVqG1N4C/3A0Z0D1X3RTxy8SZta
 9vz7rLhBiq6SFbTwk6G59quyIQj36LWFXO/C8rgqAbkYKSw5/W9PJGTLCZRQ97AhKM2bCKJGRGa
 Vzvdyabc=
X-Gm-Gg: AeBDiesEmNYQ453IO0GaSKi3fNj36awyzMoFLpg5p0Z7ldxRs77BZ/4nrwAy1Iv79Ec
 Wf2vuPMoF7HLInemTwbgz+5FoSJUQ+bswcAxcZiDwWQOAE2cp3qlAU7YbuU0hV+VewbBnfnjxkC
 IA5WW4qeNjj86dLJ3IXIrzkqq6RO/dfBIgLmevwDB4v2limgHqXpO4xM7v9J8JZh+Ujigy8ALrh
 rU2S0Fx/1IWY9kKyrfQqmdkQEMboy6kxLIWAz4I9gDW0KzZ10e9asgmkrJU8XLCVkvaTqgbwLSe
 HQPGSm6P5ZsRy+ZYql5sjL/XPjb2+EXro8UOkPi8yOKUdSnoukFaOqvhhNr28InLkqHyiSi+Yg7
 iLvywafBbOwP25AzMLZoDi5NB26gnclITk/zZOshse5ExPnWxAHYKc+rZ3/wjKwZIyiu6VcLVOB
 bCDKIplfgAubCfzUl8upaIgABUlFrf0ON27vnI/hA6hOtJ2Ol/I2HB5gzJhoFalFzdFQ==
X-Received: by 2002:a05:600c:628b:b0:488:904b:f31 with SMTP id
 5b1f17b1804b1-488d68603ffmr232436635e9.22.1776188535972; 
 Tue, 14 Apr 2026 10:42:15 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d687684dsm120723255e9.31.2026.04.14.10.42.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 10:42:14 -0700 (PDT)
Message-ID: <77350176-76c6-4e9d-87bc-691bef228e6b@linaro.org>
Date: Tue, 14 Apr 2026 19:42:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] accel/tcg: Remove non-explicit endian cpu_ld*_code()
 wrappers
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260320074555.33974-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260320074555.33974-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 20/3/26 08:45, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (2):
>    target/mips: Inline cpu_ld{uw,l}_code() calls in
>      set_badinstr_registers
>    accel/tcg: Remove non-explicit endian cpu_ld*_code() wrappers

Series queued, thanks.


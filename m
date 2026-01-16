Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BAEC9830C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 23:31:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgtH1-00043o-MQ; Fri, 16 Jan 2026 18:30:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgtH0-00043U-IQ
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 18:30:34 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgtGy-00064W-T6
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 18:30:34 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-81e8b1bdf0cso1514966b3a.3
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 15:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768606231; x=1769211031; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NrTFSGulgOmjLnfIP14wqZO8TXZeLKf2h/J1V9Qr058=;
 b=Fzu47ZSWbqfl4HlwrvmA5L3qfZzCvkfbITBnaCSnuSTdCo/Qe2jNTvv0krHk61+ljB
 ecOs5U5hWLKJXhUgWC/6OmPqkJvdYpR04zr2/zueE2ouX6+zx4n6VOhziRdU5uzr6mfS
 FbjGtkGgTMrM4ren8lTNt5k0ztAeHrDRZzAUnAu2UktIDlFgIfxJLcH7kpSGdox72981
 xMRcHYDMRF6EZv0nNe+Hs7whgmaZpArrVcIyim43uc9cVyunxmSpVv8E+8y6mqB8GhuW
 JAFA8u8hyLDueddTZOgc5erF7c2zkLGo24tNpx/pQY5SJmLFgoUzHo0UAUgGaeV/GjJ4
 2PLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768606231; x=1769211031;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NrTFSGulgOmjLnfIP14wqZO8TXZeLKf2h/J1V9Qr058=;
 b=Y8NKVSyyzfwnUi9KrEE6adFTWi1Ly11uzYepWNncYhgHyzO7snztz6pOLpWrhjggyr
 QGm8G+FzUCT+5uhIM8DS0BrhJA/bDDe44bn19mGstvR5Cqk76xXAaY0sl7NLCbrw5uLl
 v8dGZbv4WXgTeO0WMQG1aPxpyC8GKtE7mgZ1+EegPjwHxhgMd6GJFbAuPLmFYn6Wkhra
 yTz5Z9i7AvodFhLMCKkbECn6K++8nObn+4jPqg/9v+ZQAXhWAZcnDVl3rUODoJQcdHz1
 /FmLZRrncEH6RAnmMBP8AOlUvNqQI2bw5iAiabBBLWTT/P3JjvnitKQNJ0DD0XejbBnj
 1GZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXX5mc/Xl1dg8x0/QTVTszxzJ8+6M6zvnVUrQoeVO7VQy/v0be8FQAgNGa/mzzZFHjgxLLx5WpTEB9E@nongnu.org
X-Gm-Message-State: AOJu0Yw97xDjZ63Iryw6mA7uFzssY7WMHfdA3/Ip/n65QgVBBvJjl47W
 oeFcEXg/CjGCd7pFKxUPvSCjARyiP0TnyjB5zjF++XtGTgiGrC7hy9sdfA7Bhohd4FY=
X-Gm-Gg: AY/fxX7vcOH0dAWAQxR/6tOvJRvEaHE+U0NZBeHhMyhxsqEe7oJozS7q1Vl5uiDb72X
 9HOJUxtNgiYG4YPkEJCJuT76Wkb0qeDz3E5p5+XHmj3Cfw2RZitUtg1J1g43UN9m3kTYrdpgl3o
 tgltX9M/ZGRUa01Ez+BaeahM26VRp33wqjwMMWziid35+yNT3ktV4Ml1xxE6oT60ss+JvxveN1B
 DJ//POyFSarllX/o0kJKK1UQziXyzFw/ijKtaDUq4PtbDkLdF8SctEY6Zguwhrh88cVVnDvZpLV
 cPXWm7WZ2SI7ZfCS8XEDFohVURiWGVH69eDoayJTcTAQB5MnjlJC7G8AhJrwb8BVVfrOcAZXhav
 Cf2EWTo3IOwxO/k0MY6Aj9xdf4OXhZd+r8lEror/68BykHwwukweS1QDooDpHTttLi98bIwb3re
 waHOHR0m+CsdGcZ97puJmYHRNBG/pYdg==
X-Received: by 2002:a05:6a00:2e20:b0:81f:45ff:48b0 with SMTP id
 d2e1a72fcca58-81f9f68f9c5mr4439898b3a.13.1768606231164; 
 Fri, 16 Jan 2026 15:30:31 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b2bb2sm2942840b3a.59.2026.01.16.15.30.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 15:30:30 -0800 (PST)
Message-ID: <1b1274a2-467b-4914-b90f-721e16bb502c@linaro.org>
Date: Sat, 17 Jan 2026 10:30:25 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/30] Accelerators patches for 2026-01-16
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20260116111807.36053-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260116111807.36053-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 1/16/26 22:17, Philippe Mathieu-Daudé wrote:
> The following changes since commit c1c58cee16380f81f88fbde6b12f247b376839e2:
> 
>    Merge tag 'pull-target-arm-20260115' ofhttps://gitlab.com/pm215/qemu into staging (2026-01-16 09:33:20 +1100)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/accel-20260116
> 
> for you to fetch changes up to 7b87e00c25bb7b792c0ea80ac02f0bb6770f5106:
> 
>    tests/functional: Require TCG to run reverse debugging tests (2026-01-16 11:17:28 +0100)
> 
> ----------------------------------------------------------------
> Accelerators patches queue
> 
> - Enable 64bit WebAssembly guests (TCI)
> - Fix migration on HVF
> - Remove a signal race with WFI on HVF (Aarch64)
> - Correct HVF guest timer frequency (Aarch64)
> - Fix NVMM build (x86)

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/11.0 as appropriate.

r~


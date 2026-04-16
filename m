Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB838F8E48F
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 23:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDVj9-0006Fz-7u; Thu, 16 Apr 2026 19:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDVj7-0006Fk-TD
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 19:02:25 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wDVj6-0003DH-42
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 19:02:25 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-82f68b3aaf7so37951b3a.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 16:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776380542; x=1776985342; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XHzPehSMbWanIMyzn59WctMaBjfdQX0WL4/H6ikzS1E=;
 b=zEgY5DcWFB0IosjiiGh57eTjG4k28phBZAVsV+FltcSKiViEOfytBf0jVJiNeCJUGt
 6dnjttf2FFkaGj65WGadaxJeeer07AyUFpQ6q5X9gwUxMbtII1PfL6q5gZgrpZntIIsl
 Xwjw2zaMvCa5TRMYYLCxMNQLUMZD01jFzzyZNs7S7ihyNbUw8jhiAL6mei9cz/mGptEP
 8QhrL2cTdJb5QXyCWifbzdAkoGAGFqu+kD8Uy3H+ahuuEoVbuvSxUbQx44SnlBSc39Ms
 GIu9L6t2RtAJORnYVgsa9jmteE67MLlkLMsPH226KWV5yr0JWR0TokXuu0D+qctG/dpP
 wAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776380542; x=1776985342;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XHzPehSMbWanIMyzn59WctMaBjfdQX0WL4/H6ikzS1E=;
 b=ZcldNz2KwnSlkxXxec/13cBIwJkmJt8yo2apltfYZhMb+pRtIfNaHJqvEmZPv4HUeG
 IjLYsJGXJjFXhpbrXwGgSEMtKFM3091bpzdlgD04S0syupbYnVz/JazeiqRMY418mcJI
 nbQfcMAcvFDt5C9+viFXwing+EugPeb7bK8IuIVOV+qQelU+wX0BSHXlgaJivii2Df00
 uiFfHhhv5En1zVFIPdgapPYkhReqX8M+Qy8b+A3Dh5rpVkbWyD3p5JN8vbx/mlwJAGXz
 10Z8FNie5WvZDbEhJNyHZjxEYEcdwHj+k89iGlw36jKAfhQgjQJ+kE9Oeaf766Aiqpc/
 Fq+A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ggOFHFPpt3aEHX9HWZNszVcLYAVCFisYlX9chZXXHgqIEp8gay0rrl/yvskCFTSqd2Qzrs4n+HPQd@nongnu.org
X-Gm-Message-State: AOJu0YxXb5bRBq/nqXJPLvoonoBFWA8oIAxouB8ccmsyq/XHE0MLzjdS
 L3f4vwCD+1rkPZ7iRbr9UnCrhy+0IpAaYaGHhpOK55dwa6jQQNk2YS32I6nPG1LLlXY=
X-Gm-Gg: AeBDievdeXG3DXjSoSYmvYQBeyN1ZB8gDfHSwRPAyXbMIPYXLqHBA6Qk15SqxkOyj2r
 4owUG5xvMXDDJ/4prlUr86LKN6dbPiq09UDa/k9LHn3lzeQA8E7q14F1HKzP5jQKokihSmlQ+gR
 7pdsMNQQfnOgiF0GVCyIreiNp4rjQ351bwaK5vmCbMAoewiWTSdLibX4MlohAbjEzRf5zEr/gFe
 B/TW5uAEQdspX136YSHBikV5FBqcmY3g6z5963ZQEeeO3xhTRzh+TLERIDJ3c2AfLwxqiahUXHo
 bVQcEj6rEO6Kqy5hIuWZC+81spw8x/7bHqU+9BQlnw4FDFDx6ErkONr8HC0Y9f+SFdX/bZJJj2y
 MGY2aBrREwepTmbNMGUYHuAbm1j4kRmDKqURZb36Dvx67mEw1A5PELvQNn1N701iR+l0CSxfiIv
 XiWTcPEUwtX6aZgbHFdUgII2pm3oj2PC8SFKh8sBG8AcBg8w6Sb85HQ3sUknlefgblgi+8abjrA
 of6j9RjbNxwc0ovTdG7YGtTdDSxtRvQfKDnCYcUcF/V/ND2PWSNb6n8HT10uWCmZw==
X-Received: by 2002:a05:6a00:4088:b0:82f:4cc9:186a with SMTP id
 d2e1a72fcca58-82f8c836a55mr193684b3a.14.1776380542000; 
 Thu, 16 Apr 2026 16:02:22 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a60a:7c34:dd75:e66c?
 (bg30dj02y68bx09myf73.ip6.superloop.au.
 [2401:d002:dc0f:2100:a60a:7c34:dd75:e66c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ca2b87dsm100037b3a.13.2026.04.16.16.02.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 16:02:21 -0700 (PDT)
Message-ID: <cd2c9d8b-0259-4eb9-977e-7d6051a7ae1d@linaro.org>
Date: Fri, 17 Apr 2026 09:02:09 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] target/mips: Pass MemOpIdx argument to Load/Store
 Multiple helpers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@gmail.com>
References: <20260416210508.30686-1-philmd@linaro.org>
 <20260416210508.30686-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260416210508.30686-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 4/17/26 07:05, Philippe Mathieu-Daudé wrote:
> In preparation of using the MemOp content in the next commit,
> pass it as MemOpIdx. Include the access size.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/mips/tcg/ldst_helper.c             | 16 ++++++++++++----
>   target/mips/tcg/micromips_translate.c.inc | 16 ++++++++++------
>   2 files changed, 22 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


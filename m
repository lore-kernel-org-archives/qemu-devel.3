Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 706C4D3B7DD
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 09:18:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSXO8-0003GU-1K; Mon, 08 Dec 2025 04:18:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSXNy-0003CI-CL
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 04:18:26 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vSXNv-0001Wa-1h
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 04:18:25 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-477563e28a3so30112615e9.1
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 01:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765185501; x=1765790301; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gGN16SaJ6iKKNztXVD04CZUnSkArFa90W3CiCxRW8tc=;
 b=TulRPakqqcRhEmJeshotFJ7If/t1mNQabsDXc4+//lI41LAJUW/BrVOc5SGe2aVzar
 7oTOzHr55xOJ1kqaIcMNdxKBdX2nkgaXEKF997OYzHxc5bH8tXYEoNIYXST+/xqOYLvl
 yC5YmdOE5WJOBw+sz9FpIL7GKs6MlZi7zdhLXINVve9cQLu7a3NqO9rvCDO6JWmXH6yo
 yjdjaIocTevYBWdmjDl9oegEcLCDlmYBOoqDByPm2buIZvptjt85tSgMEZ9I2lRhVyJj
 jE4WwTGTjc8SVUUM9omxXKZaTQ2k0D/VqOmBBjVeugg7P5cM1oRkgWGggjDLKfL/sdSc
 vrBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765185501; x=1765790301;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gGN16SaJ6iKKNztXVD04CZUnSkArFa90W3CiCxRW8tc=;
 b=JFKs0udj09FgNLaFTGNBh4m8xdGzCEUOa6wDMQrGo2zWpib+KdcLoFpYFuJBvxbMkx
 nAalYaM/y117AbOqTuSsv7bN/XSyjINhbme28iMF3wVcAerTJAQyPiWaHTs0kyWp+che
 KmCrE0ihveGjQ5pw1uPij8SF/+BCdc8kcWC7Kct8fuazEaO2CqGtsrL4C3MUPjnsisut
 rmARmnecmJr8NT3JRmMZ/WPZK+vW6Ld3CPeDekz5g7IyzH36cteOSn2w1Bsg208ddVrC
 nbV/bWsdtl+9qYA0zOpq9DSnGmenQJTNOyF9hy52UgsFPMZdyRh0aIBjR3A4iOtfbxOQ
 K1KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJqI1z4Rrsmv9ewlj1dfTBGvpcCJ3pdGCYObwXs2wecxn8jaGDh6jJwlDTAKkwAoCS1n9pM347w1lC@nongnu.org
X-Gm-Message-State: AOJu0YzMbYlZqeQsuFnXTXikynj32AR5dA+K3whGQ/NMqQqmXcRsG4lx
 27GzmP8uJwlAsE8oQ0Nt+UOoagEahMvOPfTbS/slvmfsnyWzpeuK1WszKyC5hj5E2bM=
X-Gm-Gg: ASbGnctxo1M9HmL5jEs4K7NMxTJXWpTCRckUwrSeo17e49jWbVTwl88sKR66zf+IUrw
 /MTZjRfcsc/YCExPAYFaaQGaMFNL+HQ2XpspT+mluLTKiBm7KjoSfMxnAVmiAcrVXF4I8dQE+S9
 afAsd6+3JVG/Mr91G5XSJ2wazWCEwYj/9VCYq5K7CJmMqq0bZmTQiWVhYCh3pUmCd4orrmuz6PY
 yhLfyG9wBpZnnlFUh+QdO0o/hPLBx160siFl8bKrTnV+SkwPLbollblN7esZs9k8e48rdZpSAoy
 ar14iqFFPni8SH7LK7v9AcztHBm0WBnapYNQunXn8FQagTGiVJIaKza2NFRu8BibqT32A1oxBbV
 LC4Qg8vRFIPOvF/PMrepVEPKD36O1BZFE/uqnCSsTOz2RTyKT8j5WlXSnl6QrPIBgYGL+gNa0er
 oOPz/9lE3grYYFFzLz96J/jTGllxiMHjNsAvswhR5yqCrLmWrb+MzCAg==
X-Google-Smtp-Source: AGHT+IEHykP9RngkoHTlOCIpm9+P2N9BrgJ4+zNgEOIbILOpLB6webMfTLCvUEEfatB5bp9pc/U+KA==
X-Received: by 2002:a05:600c:220c:b0:477:a53c:8ca1 with SMTP id
 5b1f17b1804b1-4792eb72df2mr113249245e9.14.1765185500833; 
 Mon, 08 Dec 2025 01:18:20 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d222491sm25626230f8f.22.2025.12.08.01.18.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Dec 2025 01:18:20 -0800 (PST)
Message-ID: <48d9d1c6-7eb3-4484-9277-e9b3f36b26f2@linaro.org>
Date: Mon, 8 Dec 2025 10:18:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 1/6] tcg: Zero extend 32-bit addresses for TCI
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20251205162007.26405-1-richard.henderson@linaro.org>
 <20251205162007.26405-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251205162007.26405-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/12/25 17:20, Richard Henderson wrote:
> For native code generation, zero-extending 32-bit addresses for
> the slow path helpers happens in tcg_out_{ld,st}_helper_args,
> but there isn't really a slow path for TCI, so that didn't happen.
> 
> Make the extension for TCI explicit in the opcode stream,
> much like we already do for plugins and atomic helpers.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 24e46e6c9d9 ("accel/tcg: Widen tcg-ldst.h addresses to uint64_t")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-op-ldst.c | 72 +++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 61 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



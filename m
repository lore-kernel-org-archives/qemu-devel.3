Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F4DBD3B7E5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 03:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va3q2-0008Mp-C3; Sun, 28 Dec 2025 22:22:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va3q0-0008Cn-5g
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 22:22:28 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va3py-0005nc-9R
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 22:22:27 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2a0b4320665so132825455ad.1
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 19:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766978545; x=1767583345; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9hvebNEv6hIoY4EHnhRhp/1GPOZO08ALG07hvQOddE4=;
 b=AXuFWhXMwA/MLkf59TWv5nyCAxvmDyIylfPKPMbN4pR03GEyFNIz/aX4vS1NcaQgld
 3l/2o1FXustS60xugiQ3hPmRs9ooYyBBuzbxOPAjaX3Qm4judR9mfSGqE00eJrXLXHr/
 6NlvXmPg5RywERETFtj/KYU8IIwSkIm4bI7VMCOZEsGCqDRT1c99PlbO8dVEY0z0mXe3
 cUKBqI6P+ER+41J/7qQeQyNUtVADlkMVAsXBJcMczC+O+crybkSdCj7fPqA4erIAC16O
 2kzDEnovWfZtm4vU+PdkWnHsc07CrQYbEjANRGEcYCL9XRisVOEIVGbhoYOxp9kP8CST
 c2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766978545; x=1767583345;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9hvebNEv6hIoY4EHnhRhp/1GPOZO08ALG07hvQOddE4=;
 b=njnCeYHvTgZ4O26FhpzyjlpUCqQ763x1OZOCQmIgk+3Cjd2Rd7ST/UIxTPAZRcKr1I
 8832Rl9sFyxd2fx6FzcJn417v7VvB/8A+gACT6rLX/mNwGzp61826unFtTA906ASWLef
 es2CYiVqwbWE5K3K58rITIyFP+dTInqJG79C6M3KWmjjq8MzJZiIDI781kLkWRo3KVB8
 NGWqQWr5nwmfFecuHkTlGaipmsRWIwD7h5in++CAXpM4blhnawLwdzEQgE0CVXT/OJYG
 3zLSdadRQV/mNCGDbFhyqjfhq7QeRFRgCMfORl8APoFHshd920949z2lJPk0lNyZ408U
 iQ8Q==
X-Gm-Message-State: AOJu0YzPa3OqzMzO1oYQK0xNPl7wztGzDDN+uov7H/0DaXIkde7LhZE+
 HNhUluYMnnOsGDwWbO+C+5AsoKPPjW2vfWr2uyrKCKaS6g5pczkuntQENrmmZaSjP4lPGn+BtVc
 LHmZzQyY=
X-Gm-Gg: AY/fxX5Nky6sZ6vTMn5XzRALUFW/0+fenItfk5nNowFiWRbNwqmO7eHMkN8YaJH1tEl
 9F/TSxsJdlk8NRlDgL802a4ZMIzZtA1S0SfQBN7wmU/PfJCanHlMC7WKK5TR4wcM1iSO9xEki6x
 5/SbFzAILTJ7tGHXQc/xyzdeHHmtEG55Pmg+ZZDt6NryYEUFyebgFfM1oVDc/dcQx7uMS9Mt9Ll
 PsDUzLYxGx50R6J7mMl3NkoBXoJPU2eROrkonWJ4JPu7QFY2z0H4nHXC6sPb731ELyKX3f4fjJ7
 IHqC41IlueeJhoxlZOqZXb9R1+L4tNSt8BTdgfotY9vJ0qPG3sKY54CP8oocCr2MRTaAuCQlLW8
 qqVAnYEwbHzQeYjDuwz31iblM37Ef3NEz45w+q2hCiI2uqfaXdCd656JZpvxqcCIm9eTmrhh4p/
 GfDkQWbV26moE+LyWB9+U38NetnA1BjNJhbX5IhCH9QkbVDAa8x+6Q/qg7U8yTl/F3QJUO3g==
X-Google-Smtp-Source: AGHT+IHn86yragrbgJgDfyW6uisGnyTGISae3OhIe0MkZ/SJca3azlPZFmEdbVvQphaQ2pfjjt1A7Q==
X-Received: by 2002:a17:902:ce89:b0:2a0:de4f:ca7 with SMTP id
 d9443c01a7336-2a2f222add8mr289157895ad.1.1766978544839; 
 Sun, 28 Dec 2025 19:22:24 -0800 (PST)
Received: from ?IPV6:2406:2d40:40cd:310:f6a1:5e51:f9d7:f095?
 ([2406:2d40:40cd:310:f6a1:5e51:f9d7:f095])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c6a80esm254657125ad.8.2025.12.28.19.22.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 19:22:24 -0800 (PST)
Message-ID: <2c71aa14-9796-4f4b-86c0-154c41f32ac8@linaro.org>
Date: Mon, 29 Dec 2025 14:22:20 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] configs/targets: Mark targets not using legacy
 ldst_phys() API
To: qemu-devel@nongnu.org
References: <20251224151351.86733-1-philmd@linaro.org>
 <20251224151351.86733-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224151351.86733-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 12/25/25 02:13, Philippe Mathieu-Daudé wrote:
> Luckily these targets don't use the legacy ldst_phys() API at
> all. Set the TARGET_NOT_USING_LEGACY_LDST_PHYS_API variable to
> hide the API to them, avoiding further API uses to creep in.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   configs/targets/avr-softmmu.mak          | 1 +
>   configs/targets/microblaze-softmmu.mak   | 1 +
>   configs/targets/microblazeel-softmmu.mak | 1 +
>   configs/targets/rx-softmmu.mak           | 1 +
>   configs/targets/tricore-softmmu.mak      | 1 +
>   5 files changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


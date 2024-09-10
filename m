Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA27ECE582
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 07:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snuvx-0005lT-Td; Tue, 10 Sep 2024 03:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snuvr-0005jo-VC
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 03:05:02 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snuvq-0008DT-A1
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 03:04:59 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a8a897bd4f1so522755166b.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 00:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725951890; x=1726556690; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jJkHD6452Zj6bKA3FeX7Fzo4GxinqR95Kc/Il0+9tBg=;
 b=pTPu2gzpn9nVIp1GfVq+Ru537nVxJNQNqAXivxAzzmTpVu+MHYONKgidLYdM9hHW+m
 YuvGGPvj1ITxHR9QdB+9GSpzu1OVkRq6D0YLXoGLXO6H6Fhmoeh8+jlLSFUBfu0v/rRH
 OpeBbBU6LSgjo90d4KiCLosy4RQvhdn1WY7DTSdxPnQ4EpQvyE/c5F/X3i367BuAPWBy
 zenPXChOIAngYCpD3uMdh0ELGsAXcPzUl0UUvXyAXzOaBC+zDNCGYMC91MpDZ0iiuf0h
 YKh/wfv1y9NP20TsNEoH0kctFAKgZFj7G1zw7DrNmci3HI73oj1NEM5UaGR30bg0LC79
 HjeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725951890; x=1726556690;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jJkHD6452Zj6bKA3FeX7Fzo4GxinqR95Kc/Il0+9tBg=;
 b=eqBrQ/6Pg5fN+ty0D1sP/qwc/IVSLvM7bJ57rYiv2XBjd2O3gAZ0LBvl0lPl7trr48
 2lJbz1lGVT/ls3L2HwH8bO8HnbotuXS4bteCTp/LwpaEMYzCahRzFji5X7d5Kn35yL0H
 wODknUFxpEpyLjNMe2AAyNBxyGKqfazfEOLMD43Ma/yVRfKozHzqS5YxPtc68x6RUKeH
 1qLcRdc7nW9NXyZwGc3eHt16X5bH7h+obrM7wGMSkFkX4RtgLfyvSCQzP2RhzwDAInzo
 hEHiCeAbR6iMU3M/f71SxuEWJnnktW5SYM1Q601UCXvciwonlpWweXIPA4VwqKLxweN/
 6ysQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNL06IGgkwiOERUWLoDGL22L2E0Q8/6pjF2VozOQdLwWflTDE4Vxri5VzfuQbv6CyTEZYS3Vub+k2L@nongnu.org
X-Gm-Message-State: AOJu0YyEDqb/IT6Lp1HJg8WI+UVKrInao2hD7ugbM/Rta1O/oeo4mWhO
 bLBEfKJhlT/euXHVWAyezsGb/tZBDHyX7XxbAr0MsUdcmhklrQNcKaBbU3ZPNVQ=
X-Google-Smtp-Source: AGHT+IERx8brtVsgOx2GjGoC4aXB3MKrwPY8xFJ7DDk0wm+SNJeT32hxpDfLDFgy5YMMb4CZqt89NA==
X-Received: by 2002:a17:907:eab:b0:a8d:1545:f48a with SMTP id
 a640c23a62f3a-a8d2494c101mr771829266b.61.1725951889558; 
 Tue, 10 Sep 2024 00:04:49 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.217.32])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d258354ecsm436327166b.8.2024.09.10.00.04.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 00:04:49 -0700 (PDT)
Message-ID: <c2e9e0a0-ad53-451b-8ea4-d6032dad97d7@linaro.org>
Date: Tue, 10 Sep 2024 09:04:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] tcg/i386: Add predicate parameters to
 tcg_out_evex_opc
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 liwei1518@gmail.com, bmeng.cn@gmail.com
References: <20240908022632.459477-1-richard.henderson@linaro.org>
 <20240908022632.459477-12-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240908022632.459477-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

On 8/9/24 04:26, Richard Henderson wrote:
> Extend tcg_out_evex_opc to handle the predicate and
> zero-merging parameters of the evex prefix.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/i386/tcg-target.c.inc | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



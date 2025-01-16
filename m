Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63487C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 17:36:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYTmM-0007LN-Qp; Thu, 16 Jan 2025 12:35:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYTmJ-0007Ku-0p
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 12:35:35 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYTmH-0003AQ-7H
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 12:35:34 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21631789fcdso30421125ad.1
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 09:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737048931; x=1737653731; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3feIizwEW2sfEq6cMYbKoNy6FtsBa0kX3AnM/8GqnUs=;
 b=cqrIAzIaz+PUK4jUQLCvZJQQ7xcb0h0IPDhEyWA7AVtlKxRI4f+Q1MJM2z7cenoFBQ
 n3ZISeb3zQA6rsLCjEZnTqTV9E0w4BDX0bpPGMYEEfdA7xKV4SwG4YiwJiGewg6Ilxog
 MkhEnU3JcoclxDBVydKlhHSkzumso4V4TUCSLf7+oH+sdWXPvUXFIxkyKbyLveEZtsgi
 qf+AmsKQYadAcqvdop4Fth5ItfTMh2S7ghZnbyCJkhz5h+FJ9VaXyEb/aYHLi0SJfO2A
 oRr7NDP2apkfKI+KYElaRuxAmQpUCgswBFz/wHvq8+iBm1NYdCUfuRHdFDdUEtRxaX+p
 LAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737048931; x=1737653731;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3feIizwEW2sfEq6cMYbKoNy6FtsBa0kX3AnM/8GqnUs=;
 b=QgAaqJ/wv09yyQLk+e0+SNw2Ff56nBBwKAb2EWv//fGvN6VeyeQWyWzO+l4mh9QHYi
 eoFCAShAU32oIx7lgsEIU7mnuJvuLX32+xEwk/tMr9OjKMkvQtxlq5cnS0M+C+8Gkn0q
 ok4wShETC8pA7vnl9v+4wRW3zTa96UIrSX0St5OjwUJPazwoFGBaUxlb8oK56MVGPXrc
 TQb/dIePyr3uzj1NbdrtVFkqIVInmVAVA37Xn8OgVNuHPzcv6k0UlVL6ml3QTzVkONY4
 fWvVVp4HPVjQUi4ruxSZaM67Hpi7+cMptcxGe/gpNysnSjeblMYTB0k1oQ6yhlw+4pAt
 kfKQ==
X-Gm-Message-State: AOJu0Yx/MMdXnEU4webD8sO9A1K22+Sji5AhUCKuYuBUve2BVBj1fSOj
 YhMrDp2luC4m36QgkazwG7eLKbrQiwcJclbhogScRK+TvF81J+DS6V+g2sEXACD9a+JXgMyXE6h
 G
X-Gm-Gg: ASbGncvOjP3P4Hybjgp9lmfrQLEfGm5g/80IC0dZulgbK25lAFkEwPKDKVuocDCJRL1
 QsJFmrrozupSjvGozX2toU7/cHzNeyi56cYU3XG3Av65HaFDRT9OXIoB8csM8q8AIUWZ+7DTXp7
 IuqOD3eG+nV+RvGUUVEx81PhetR3V/ktWk/MfChE7I8wpisb8fg7V4EEC2l9xIYofc5lTEAWaUf
 zRa1ZhLnPtDw5aeCgP3oFv88EQvKfGSe86aa+TZcO8qvF7yb3/qFtLw5dU6UX7mJ558v98IW97J
 Ng8MAgtazvG1XkMxJjVOuL0=
X-Google-Smtp-Source: AGHT+IGpszPuYbOa/D18p4KQeVIH2HFmopPWDh2oBKolmXtid9ek88MBXjiPAqNn9jD+xK4k9iMq8w==
X-Received: by 2002:a05:6a00:858a:b0:72a:83ec:b1cb with SMTP id
 d2e1a72fcca58-72d8c35e244mr12559495b3a.0.1737048931173; 
 Thu, 16 Jan 2025 09:35:31 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72dab9c8d8esm258003b3a.117.2025.01.16.09.35.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2025 09:35:30 -0800 (PST)
Message-ID: <d3d59f69-e92c-46b2-b6a5-57092b449f26@linaro.org>
Date: Thu, 16 Jan 2025 09:35:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/11] hw/mips/loongson3_virt: Invert vCPU creation
 order to remove &first_cpu
To: qemu-devel@nongnu.org
References: <20250115232952.31166-1-philmd@linaro.org>
 <20250115232952.31166-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250115232952.31166-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 1/15/25 15:29, Philippe Mathieu-Daudé wrote:
> Create vCPUs from the last one to the first one.
> No need to use the &first_cpu global since we already
> have it referenced.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/mips/loongson3_virt.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


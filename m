Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F28B9E8304A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 04:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn8Sa-0005tY-CA; Mon, 02 Feb 2026 23:56:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn8SY-0005tB-SB
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 23:56:19 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn8SX-0000Iz-Di
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 23:56:18 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-81f5381d168so5312986b3a.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 20:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770094576; x=1770699376; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i9p6ReDDnihJGmA40asJRKmC6CYY9d1zbdrWkWcv18U=;
 b=bjHFwO/ZnEME01UfNZSRD3l0RvavQwtdBiMNrkkYllHFwevSm5Y0iFflwK3U+m2zQM
 2wl5Sui2R/KcP1rBwvOPYk+pYOZd5G/0ninmM72fy71AOQZmEj4kn44VbHQ9F9DWh/Us
 KcV6xG7b+GAJWglQxiIAKdoJzHp+ik9woR1WGEnKeKsOlbAt7wIS8vHyacnI83SRw+az
 2jjay5/253AjuHc49p0xbzruUb7oW/pQQdNMpQNtBKsRSxlX69pQne0IDlN2LhMGe3JF
 zyDjhnYg4/HxCerzGiOZ8WzUz2lTSrquEBjn4GIdsv+jxytGuF15YrvyIIp/pTfhta5Z
 ZBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770094576; x=1770699376;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i9p6ReDDnihJGmA40asJRKmC6CYY9d1zbdrWkWcv18U=;
 b=HdBVokJPOqueUL1CXmQWeWZh9ffwbrQsRQB8EnsEg3qzkX24gE+/U7FAV2Bdp397DN
 7mw81LpYdB1e2hyODtUxWNSnYuAOHw63YRAfQDnoc35UsMwNwghPIXKKNmgKjdAm04QW
 ZO2gcauZ7Xi2R3p9fIz+ee2ltQfjOb/99ZQE9uuvW62iOZbOMVHHUizNPtwySaFwVEVL
 2j/O/43riARCwuQHOf6qNuQAOOinftYwf9dxBFstg5/+c5md+he4jIYGEuI8DxMqgKJk
 rgmq0cYoAy9Ni/Fd6005XHFleBVuzkzKAa9tS/xOHkr3/aR45Fwnv958Z12YlcsjhrvK
 g4Rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVisVpwSem8+LSWOrj8jV1qa6DnntIr9iLLIED89jkfAfF0GyB1YnNDn3o64iwsod+VTtN2MjME1NZM@nongnu.org
X-Gm-Message-State: AOJu0Yw/N9LQBy481oT5E8xJg4UYL9o74sOUd6pkpxCR7NFpl6mn1D90
 PIKUI9G1pT7NYRLrGIht8/MLGDGCdJjEhnEjNHaLCuxGzGlyjCY4pRJW1UcqSSqinaxjc0763W8
 yljItVITbIw==
X-Gm-Gg: AZuq6aKpO/QWVrJr0O5L9neu0ufMivOpVtvyhvGRMQdo6zvqgQcnS738mOVT07KppHM
 X2/kN2WmuJFBq/2XGweP7jE34vv6ZPQX64VvgYY0Ynuur33+kpmJ2sZ7VDy0MPnH+CapNcUeUyZ
 hPIJTtEc8mlhczs+QJ1EnDITaobKRSV+gJIhghUO+E6wIiWo5zEBRCZ/XZal7eJiU2DIUSl02T4
 pcDXChr62GF0XFi+CuQotLChOXO2wsv0YqgzUwrNWjQ3k9+lJD/xXWf8X7YTl9LaOXrfBoaLYL7
 sWdvUPjLce8d3dTmJKq1ommJoLYPnha2CnxWms4AXe+HtQw0+2jNi2jnKwY5Px6VK3XVfrl3C/r
 HdBVbsQUm1GbqppFTSeoqUCKeskJvn+Kee9Fb4ZPDeS4NoqHN1AVIm53oyHEfl8gd1zPlrFsqdv
 tyU2lj38gizbra2GzpZrDKtOeuGUeP0dHNqZG9gknro4ooklwi+Ixvejl5fo1O/0WN4VsX3RSiA
 inCd4mtUl5VkjxrQZGJrwZSuoBqsjNgBEJV3bkHqA==
X-Received: by 2002:a05:6a00:a114:b0:823:d2c:b156 with SMTP id
 d2e1a72fcca58-823ab6535ccmr12518803b3a.5.1770094575830; 
 Mon, 02 Feb 2026 20:56:15 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1047:c02f:591b:6a5c?
 (bg30dhzn7h1zhjqnvj08.ip6.superloop.au.
 [2401:d002:dc0f:2100:1047:c02f:591b:6a5c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379c56e20sm19268186b3a.65.2026.02.02.20.56.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 20:56:15 -0800 (PST)
Message-ID: <40fb5998-8711-4f9c-8328-fdbf9904405c@linaro.org>
Date: Tue, 3 Feb 2026 14:56:10 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Fix zero_bss for RX PT_LOAD segments
To: Razvan Ghiorghe <razvanghiorghe16@gmail.com>, qemu-devel@nongnu.org,
 laurent@vivier.eu
References: <20260202002615.27441-1-razvanghiorghe16@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260202002615.27441-1-razvanghiorghe16@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 2/2/26 10:24, Razvan Ghiorghe wrote:
> To validate the correctness of the modified zero_bss() implementation,
> two targeted test cases were constructed, designed to exercise the edge cases where
> the .bss segment overlaps a partially filled virtual memory page belonging to a
> R_X region. The test binaries were intentionally built without a main() function
> and instead defined a custom ELF entry-point via the _start symbol.
> This approach bypasses CRT, dynamic loader, libc initialization etc. ensuring that
> execution begins immediately after QEMU completes ELF loading and memory mapping.

It would be nice to include those test cases.


r~


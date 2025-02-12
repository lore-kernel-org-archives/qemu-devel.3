Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889E0C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 17:58:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiGzZ-0006lh-Il; Wed, 12 Feb 2025 12:57:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiGzX-0006lQ-KS
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:57:43 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tiGzW-0000du-09
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 12:57:43 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21f5660c2fdso108855035ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 09:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739383060; x=1739987860; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VjnLNVV9ZZw6ln+y6xAAcW72S1Uq2GxGzIEmGt4pqH4=;
 b=tW9Wqo+ALSD4rWSZXCGSoOCDZGO7uNBhyDGFlsH5C1F/7EClOdwK5tmlpFe6fWCNDE
 oQQrfqUvgB2fe4qdlXg7nYCzuo3Io6WCBr7N9wwmPhntY3PBjUaH6d9jrbGjNHDsCTg8
 T7o7Ji37JKTbhu4W21s8DOh6F8YUYCshjvvPfXGaKPSwGohFdqDakWPO1mspT3ZLsQvK
 Ka5TX5U+m3dbsrv5EUt8tDnFS9zUfntHr/QLZfK87xfAYOjksOFtwgarqPEd+byCsZvk
 iwNR46seTtyi30Ppculg+aSzN97rgIaSSGDZ9WkfwjG/IaayU51J7BgmJD+cf70s5U5S
 1cug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739383060; x=1739987860;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VjnLNVV9ZZw6ln+y6xAAcW72S1Uq2GxGzIEmGt4pqH4=;
 b=XhEN8bCi9fhqItI/5C1n9xRur+jqjRl8IGJxHNIyKzbnFg5IlDDXy5n3y66ZW5XFmZ
 nAInb/4xraHWXOetXYNnHuA3PoX6FgA+zCfCazpiW32bk6RUN8HsO20IXwnGgZrhlNlz
 zKVbDx9oC2YN/uBbNlRNIU0C4bKk6rjubftMQEZ4oPM0SEUF8DbLY0ED3NoRTf12/43D
 nFDj+AeBviEPRBPHgJ7DKJt4aonawJIIH5AqavtybYzxNvZ7WqkJ9JGkuOGsiPZ85Gwj
 YF7yNdaukaos6t542ztwaPSnA3d64wmAxdBbyEwjc0Tzqos+VpdXvdoFNJ8ARpLCBJn4
 ihIg==
X-Gm-Message-State: AOJu0YzXBkZNrtNhZcwl0DbhPU1oo335Bqom1SWK42CfDlEe47F0Eb3U
 iXzHCFrqMVXA9YrWtQ5SauPcnvf/lOaZvZSUiCOkPAr7EFmaXe4yBvm9WJw2goZoIeu0NazIHcE
 2
X-Gm-Gg: ASbGncuqHO0K/+NdvoYM5X00fgKtVh7SPF7X15pBx174MRdCtnU5tto4F98p7RcHoKC
 Lczg5AWz80YA6iW0eGAs7Qhs07o59/pDX2YC2r+v1GhaF4kodlg4uMbzcJsOoeMHKZTfvwdrrqa
 1FoSPlh/0Q6ZmnprzZYV+cZz/ayBHokf3BIV6OVC82edwIYmh/ac/8/IA32MaMHosGlDDPt744o
 TVUgf5APGr/JwEwfPQhR9ZDJmO7ZWW6OLxNWj0X/isLZdULBWSW4tpuco8HFr9NUVSDgTV0k6hJ
 C50LBiiYHM0BCBSozJNIlPfii3WnQXma068Rp8xJCNXp2euWJVlk+Sg=
X-Google-Smtp-Source: AGHT+IG0xK/bKJhCMiOvpHIhxha9ATGMIyeDlM03kZVuwffKOEtPO3s09/Yy0u/qCSdHvpbxPGYWIA==
X-Received: by 2002:a17:902:d548:b0:21f:658b:8ed5 with SMTP id
 d9443c01a7336-220d1ea0b52mr3011745ad.6.1739383060532; 
 Wed, 12 Feb 2025 09:57:40 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3653c997sm115353805ad.78.2025.02.12.09.57.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 09:57:40 -0800 (PST)
Message-ID: <17bc8e1b-246f-481c-aab6-53a4ebd3e43c@linaro.org>
Date: Wed, 12 Feb 2025 09:57:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] hw/arm/exynos4210: Replace magic 32 by proper
 'GIC_INTERNAL' definition
To: qemu-devel@nongnu.org
References: <20250212154333.28644-1-philmd@linaro.org>
 <20250212154333.28644-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250212154333.28644-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 2/12/25 07:43, Philippe Mathieu-Daudé wrote:
> The 32 IRQ lines skipped are the GIC internal ones.
> Use the GIC_INTERNAL definition for clarity.
> No logical change.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/arm/exynos4210.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F91C0218F
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 17:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdC17-0005HM-RD; Wed, 29 Jan 2025 12:38:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdC16-0005Gv-Mt
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 12:38:20 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdC13-0003K5-MA
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 12:38:19 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3862a921123so4930413f8f.3
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 09:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738172296; x=1738777096; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=58deHz5M+N7dZCxs5fJ0Yxoy8RrewMOdJZqC1Ay7W9M=;
 b=nUz4QbKA+8QJ0MH5VqWII0hbSnhgKvVqxHUKlnO5uHUkZ+++g84BIeX6XzgBAxO36t
 5mRvuM97Cy5iJE0yrSWRucoEOTj+wrzAsh5tnwxgHuYzSYIVozZ9zAWGJpkGZKn7XwXd
 jSxgEfI9cpf4jRlYSsDn7XWnTfo+jy/kHB0RGIibpp2tKa5tEZzXXJYMb9tA+mQbT4PB
 49hZb1PWrcVyKII7gxcFu2rf9t52hqsYsOxFppieCheOdHbtQObW1gQQtTPiMKrO+kkx
 rqFnbAwc7JpwSGcxoiAeraRHriD0YMXXqpzrPaTULnQowgzoZyD0tpzziRv6jo3A55Ex
 qq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738172296; x=1738777096;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=58deHz5M+N7dZCxs5fJ0Yxoy8RrewMOdJZqC1Ay7W9M=;
 b=D/+eHORmqqIrGayM7E3CpIik6i/iVoGRlJ5lB4RPpSxhXDNzijolv6NLUXvqxQs5d4
 DCeLXdWczv5j801DfZSToFRFg2uyeMRicV/YkIVo+TG3uTUWE0w/STTb6IbLj3R7RFPK
 4F4W/xVGalZpbjoW/y/e/WAFfG9+TQ7Z1uJi9B+ZtXcrA8ZzgAbhHzc+zRmfuAVWfCCd
 lnNrg+kAaNQsSjSkhd0UIRyk2zkX8jZ23N2P+N+RygHIuJM6nZyyv69B8OykWp+aR5RV
 ed4SnPf7IFnQokcUIxwbpjdzrxr0SaFCJ7fydxDRP3xAd4jXRXYHZBRa2XmO2OFU5UUs
 9HDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW79bNbZPSuAgH9R2exxgUuPy6NucVyeyoHG7Q6akwMO+zrfbuiTUr5f2CA7eAXe7icncN/UZRrvAxj@nongnu.org
X-Gm-Message-State: AOJu0Yyd5NNzMm0vveZHF/e3DIa5zdcQi3qOHHidcF+vN1814Y4TasIM
 y6dKyIxwLnfgHs8coPR6aVIxC+/CBPuvpyq4+64YpH2gVDXZ1mMF3VWfwXcYce8OQrcjR5GWAb2
 b9+Q=
X-Gm-Gg: ASbGncvCh4Bwcp42PyZas6OxW3Zz43PIYbYBO72metqLBDRRY+bkutkEXii2EDqFwzB
 1hnA32M0yIZRYqnihFUIBD/T+eLR/ys2JQB4hOLFA2ZL2BuNBm03y7iyGnzRCQFEFlP+/iSMWb5
 tUwOB82371mTl0HxB5D3O59hDm5wTb/4qCgv+7rDVFhdoFBe/o26reF5PBBHPdw81b14h/1uzCk
 IWEZaJbXgGPTvaLV+P+kV4BWifORNUv3DnLm/Go/8Y3SW7ztrB29jyTDLVlkrRqNPw7HuDpZSF4
 /jmxbki0K8UXnUGqenl41Fb1WnSPxHVUwbk9NHM+gYNQDEX1/RDQDEUTxnI=
X-Google-Smtp-Source: AGHT+IE7qC6xRLZSXQqnbikLGePi2BgKGoVCHZfjcD+MjDqLzSFt9LmsRUf+l6dprZQhAP3R0qdSzQ==
X-Received: by 2002:a05:6000:1565:b0:385:f220:f779 with SMTP id
 ffacd0b85a97d-38c52095991mr3843681f8f.49.1738172296072; 
 Wed, 29 Jan 2025 09:38:16 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a188a61sm17886586f8f.52.2025.01.29.09.38.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 09:38:15 -0800 (PST)
Message-ID: <32cda3a3-d29c-41bb-949e-a9c60352bc7a@linaro.org>
Date: Wed, 29 Jan 2025 18:38:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/34] target/arm: Remove fp_status_a32
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20250129013857.135256-1-richard.henderson@linaro.org>
 <20250129013857.135256-15-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250129013857.135256-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 29/1/25 02:38, Richard Henderson wrote:
> Replace with fp_status[FPST_A32].  As this was the last of the
> old structures, we can remove the anonymous union and struct.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpu.h        |  7 +------
>   target/arm/cpu.c        |  2 +-
>   target/arm/vfp_helper.c | 18 +++++++++---------
>   3 files changed, 11 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



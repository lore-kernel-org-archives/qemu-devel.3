Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5B0CCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 14:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAqdW-0004W6-9o; Mon, 20 Oct 2025 10:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAqdK-0004Rj-7S
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:13:10 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAqdG-0007Q9-5q
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:13:09 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-471076f819bso35446475e9.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 07:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760969581; x=1761574381; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mq36k2OKJTdNR8NDxUHBOvEy7wAbkaQBwP+UJ97nQZM=;
 b=VvnxKyLX6IIMbalovH+6I8qh5NdU9TOWUDIZPMZMKJmtbVzRpByGtdCheOYQ9EuTP/
 kuT7ggygRcKGCkWgf1djjGpJoVxrugnAQ0yOLUblsNGyE8e/8ieg+2g0GGe7iazAcvRX
 FAkvWts5iR2xyclFe/N7mRyWmMr9lHyQH1/OfXCRtF6UZezO8YaUC2VYtmgw9NcQtXo4
 emUnN7EbpZKZ5eKDfyotPqYj2rvNqxmpTnyFubcAT27Q5ph3nnvOaMYxm/4YxRMC2jEb
 QXhEHf4Ci+0ANFtBRUNGli/RDGjkIf/prZG3LGwL7PUDwNlOzJlkyJoEztrDzvtVARm5
 HAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760969581; x=1761574381;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mq36k2OKJTdNR8NDxUHBOvEy7wAbkaQBwP+UJ97nQZM=;
 b=YXQUX+S7hRgGSx+Ao0ZyE+YPsqY5XJg9BB9D7eVQ6QW7s6f4NY8B02AjTazwIM6HEt
 mhJaaryO4PxmQPF+SWQvHB/s80ZpqhGUvu7tpkVspHgz1KQP0gQ/SpcinHHfwaWWDCZ/
 2cIgPWVcP9Hfx5SFLZOCF1Kon+gM/DEhY/jsYrgXtpVeflmVkW2lWJVd0Ob1dbeKgdzk
 Vwm/vpL0wmxt9LjNxunI10tfWmGkFexvos2ReD5eaajg30xRM7bhhXvPfXmiclT+14yL
 /JPa5E+jWtxpSWQfHymtJZKvzYHVen+wx8nw68MipDV56zUDiqlKYG+9kzMUGT4woGq/
 O0qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/iEn1sjR4+5Frn3ABJ2CCJ7CrRDGt+BGCbgFNrqu8jy2UxcuraKBJ+HC5ZDQfAVOUw0X69pTLJEmd@nongnu.org
X-Gm-Message-State: AOJu0YyiJCvKB5PCAf3zu6SubqF/kgVwv/N579cwPBhYY4tET8brDV10
 19AfAgewcOZI5AqPztjhVndQLczjZ11qEqNBMYL9hKedIXf46SJRfQ8BkIKk/Z/F9L92pi6HI84
 m28zMNFE=
X-Gm-Gg: ASbGncvmUqAvUqX1e8SbFK/xC/kudpcRmKfobcsIKX1UyRuTN0xUYI1hVAbaLGaoqc9
 HKbqg89tLbwrGHqdfCX756BIoD22NxJbiFPDiqWnsh0I8OizKwLHZ5aoR4YFtReQHgoh78sxHV9
 6mZoagLAckj4ZrJYso22U/JnBGalwyUPElxkwSqmFUnRXFlNdxgZO9S1A8qCoGkYz8BrvomXEyz
 J0PmOJph/2WTMWoYnXXQZdbFNXsRD7uMTYxhGR4ViinZB3we4SgwqNkvGciOGGnLE9Kjnz4c3mS
 8FNeYfo2J3f3CD22VhUt1Adm+cRifm+ETvYZLtt/U6Gc2tUnp8HneOWmLYbM0e3w079I9FqA9Yo
 ZA0rDgwjOjidCntoMHWXU/2OSUP5yL/GQQDsD0bzlsaWw/NYcmYSyBWWk1N+PQjDoCdnSorLJyA
 1nqHK4gUVuxTXUaRiCJGvINIzhtaLwe9QmyiYx1+e32rL+7GVgWyIrgg==
X-Google-Smtp-Source: AGHT+IHYhRYxzAnGRc0moYXIolHOyCLQpVgm4w/eYoNtGlS/Cwa9WhswN6WQQiHwCtVUwqjikjkbnQ==
X-Received: by 2002:a05:600c:3b8d:b0:471:60c:1501 with SMTP id
 5b1f17b1804b1-47117918c0cmr112412095e9.28.1760969581217; 
 Mon, 20 Oct 2025 07:13:01 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4715257d8b2sm174622865e9.3.2025.10.20.07.13.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 07:13:00 -0700 (PDT)
Message-ID: <02925c62-1a8b-4511-9fa1-ae092feb08b8@linaro.org>
Date: Mon, 20 Oct 2025 16:12:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/37] target/arm: Split out flush_if_asid_change
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-24-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251014200718.422022-24-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 14/10/25 22:07, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper.c | 33 +++++++++++++++++++--------------
>   1 file changed, 19 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



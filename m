Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C589CFD352
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 19:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNcWI-0005g1-5u; Mon, 24 Nov 2025 14:46:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vNcW7-0005ON-5e
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 14:46:31 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vNcW5-0007iw-Oq
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 14:46:30 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3434700be69so6812980a91.1
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 11:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764013588; x=1764618388; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6qk0UAO7FnxFIkxNkPmdjUXFTrO58be3D3EnWMN+pYo=;
 b=JwKQVU9nR1K7mu6hbjnb+X5JJpmk5xDk4Btll8+zh21sDQVIc5Woey6jnwZ6QN2skQ
 EvO+s82Ci1736UKkUxdKWKT2F2pqRWIjp3Wd2uFELthiANNo1Q7WR9HX0fZDcZzxgXPD
 qkNsa/6iuYRjXMRV29Qn2VOdmX7KDJP13m/VktsY6fei+w13OMfg20PbBPVzrGQ4oEV1
 ZD600b8Ae9T0hgP+30Q/KtUa8k2zsB5eu5PyIeAv3PTLINSu4vDHxn6TmY95ZXGrj/Iw
 EC3fESzQqprU6IrIAq2NTzmclnO70Ipr1f3RAZvhze6eMSk/LQGg1McEvgI+bjkEjv0P
 XlnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764013588; x=1764618388;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6qk0UAO7FnxFIkxNkPmdjUXFTrO58be3D3EnWMN+pYo=;
 b=wuugvEkj7C/4CRxJFWa9nZBxwTdiFi+j4yla3CLHmekvEIuguGZWzdjzTyzYHvzirx
 oRH/suOsSrFsDFsb5ysq0iJN7qcJ6nOETlL/muL8/cEc+HSCEKoFHwD5l5RSFeAiv+w9
 VMEXR1gOSQzL0sCBUGFjv2jddvgxUiSAW7YByJzW5miI1CzbHPv2m70+WYCzhCMDEbym
 nilccjD8h5DeJTDD1s+YJGuqdr1PBgVTdKE6DsVLVhY+oDh/Iz/gGErwdQHlDzzYh3VZ
 Fkn2TqxQH+E+B1hWYpbhGTIIM4aQDenmOKPe7o/RLXgu4TBe3TExA9k9BzjZgMLYrsig
 R3qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZzDT2mu3KSTI1s7hBtX/GYeorqGmchF6LNN7OqGz+RWnRkd0vdDZ2BYkaR9aHnqSCXxowKZsWteto@nongnu.org
X-Gm-Message-State: AOJu0YzOkMU500YwdLhAHP5+CFFFyTbDUNDXIBWOtEw3FY6ItDyw26fs
 IJHcylJIfZ78p4g0vukBrgw6GBvcwMg9i5zsXMpCIcEtY13wNNlGnDmz/6KV3n6+twc=
X-Gm-Gg: ASbGncvYVxSGXMj7tt/1dgTuY3ie4Kjy1lAEmQaRxSWVmDavr/41tbyCnSU3l+5roIp
 C7gtZvzzlszw0tRMpt8B8nk2ddojRHY+Fg8QfJcT6GeFVpB4khE6va2n9KmVJZlkq/EXfYrKSHu
 NAnExmj/dMpc9vc/rMgiYL5o3STtHPEAkYZHDy0y4xfROP7gHD2kIYvDAIztUpHQi03VcBE8vM/
 GGdCae3YAAYjqUuu31ohfuIzVeIN4HYlwDqMja1eJyfyQSVelL0Idgm0Jg6ptOPjXDtPWEY53JL
 dFR998biCWFgIB5dPeF7cK+a80bAFurSBwrn0aeP/pqUEZnC+OksxdxwkyqhJzz78qy4ExiI5+o
 kEgjbfu4U1Yx/cA0MAbYNY/6nrbSbeKBfQPiFsOLBzNqm8DJiuXrTcasMd5LgwVuJ9XYPgrdjZM
 jSHlSuQgOkeCeoc1HStYQTBe6YS34K0B8dDRB+e54n/dfFplrXFQ==
X-Google-Smtp-Source: AGHT+IEvzFNW0UJwr5B4c6LUDnEp3Br61UJijC8NDYHGe7wcfTM7g5xPZ0WJVUk/CKBCl0z7cgaghg==
X-Received: by 2002:a17:90b:2f0c:b0:340:c179:3657 with SMTP id
 98e67ed59e1d1-3475ed6afd5mr173301a91.33.1764013587901; 
 Mon, 24 Nov 2025 11:46:27 -0800 (PST)
Received: from [192.168.0.4] (174-21-76-60.tukw.qwest.net. [174.21.76.60])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-347267a1231sm14546307a91.6.2025.11.24.11.46.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 11:46:27 -0800 (PST)
Message-ID: <6c4ba201-7548-442a-b114-0881eb376041@linaro.org>
Date: Mon, 24 Nov 2025 11:46:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/arm: Enable ASID2 for cpu_max, allow writes to
 FNG1, FNG0, A2
To: Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org
References: <20251120125833.123813-1-jim.macarthur@linaro.org>
 <20251120125833.123813-3-jim.macarthur@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251120125833.123813-3-jim.macarthur@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 11/20/25 04:54, Jim MacArthur wrote:
> This just allows read/write of three feature bits. ASID is still
> ignored. Any writes to TTBR0_EL0 and TTBR1_EL0, including changing
> the ASID, will still cause a complete flush of the TLB.
> 
> Signed-off-by: Jim MacArthur<jim.macarthur@linaro.org>
> ---
>   target/arm/cpu-features.h | 7 +++++++
>   target/arm/helper.c       | 6 ++++++
>   target/arm/tcg/cpu64.c    | 4 ++++
>   3 files changed, 17 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


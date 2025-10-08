Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BAC6CCD184
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 17:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Xzm-00050K-14; Wed, 08 Oct 2025 13:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v6Xzg-0004zx-Hl
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 13:30:30 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v6Xza-0003Cv-LI
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 13:30:28 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-78115430134so45225b3a.1
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 10:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759944615; x=1760549415; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VC+JF1M2c2xK9KG8bsGM7ffQ7M0ZXfULJetBUt8H/+g=;
 b=BKGCcbn2Qg10thUc2jfYhasBLcd0ZlNKKtPsxDOIr1Flbjj7gmvOIUR4jax/HGN580
 TAFBOJL45w56B/PWCde29mrvVvRfjM+tQ0v1BLdk1qpJXMsnatbuU+sFYvV8WayM5JOT
 Pu3I+xZoXnbntwClYPb6Vb7fk1qBomGm2MUbZSGMdDeLZsEt0wG0P6jetCuqR/Gl7G+X
 tdOMBKdkoxaUkxQu11CfARLaogEun+8UyI4fp4Fz2hUOK9JKrGkFssCVZxmyf8n4SS2I
 RfQ4e0wqCBF36AgMQV4vmBkg83TD4F8uo4tWlVMzaS/gv0nNfyYD9yqkD4ehw0g/RyRy
 eQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759944615; x=1760549415;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VC+JF1M2c2xK9KG8bsGM7ffQ7M0ZXfULJetBUt8H/+g=;
 b=TB0BlO23mNLCSx6UVT+AsPEZiP5tiBVxuIf4oUvvQOVz94ZcPQ5fIkqzoOjKjN69Mo
 LlRkQtFj05oTjbDk9ZW+TAZfZ5VqTUsw/pxxMfNQ6yiI3SFfZUCPrKR4lMJE5QAG4K9C
 dd5qMdAIBEh7PGiDwqJ4hzbXb0clLi4O4N31E+H589kZRvIm/WSZDhkSu17MMnNftmTR
 hwRuZD5VoHnypUV6QmYG1i2cancAbkzevcUgDhVZVlK2mjAN72TYSpCAmqKdXADYZj15
 OobJyVwea40TpMWOuWogoOlXSMAFDS5yQBKvDCTmUyHi7swm81pTlK++wiKp9qFkggK8
 Y33g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtwdsHq9pAZQGNzRapnM0nEWLmdQEqSKv/m2jJal05uyZZjbXaGDqYomsCZPQ25JspF8XxD702qzE6@nongnu.org
X-Gm-Message-State: AOJu0YwwsQrFc1r9EXclkGU3M1WWyXzDaE4W2D8/zEnH6idKU62jBXoT
 byPOEstVWddsJgAK8t2NZ2C9RmjYNSVrdn2gi8BxcEEhVosuKht5QV3n/C3uurzOsrE=
X-Gm-Gg: ASbGncsS3eB3CI3t1sWUPv2RP+60Vwrx/BjlFvr+GRj1RZY/svh+aLPVqI3cHCsDVxu
 lZC+AMN3F1lM58nOOtnSf/gWeNZJT8y2SPbk5cCMB/6EMYTppMYMtqZ9PIxNksYo2GxSlNIboY0
 qsVOGkEEiNZXRELV9PE5cjzA+Bk7yYRhMar+Bu/LYMjrrZv5apHgk6eXr8Gg1uPfJD63OUnpC0E
 WyRd6fXxuV4WSqfjLn/07YggQgINaRiKX3kQtu9nYDQzMwRFUtdc7AYbR4PZ74NYkZn5NvYLHBr
 PfAgB5PUUr+0gkVvbfnCtgfYr/lFIHyMh97SLvX3VjEMbuY52qC4wEOQYO0KfZ6NqY4pZzZ1AS4
 LqlRPSMFkO1s5J3ZAJfKp/Ew3Qwmu9Ey7y50zxN+S1TCO6cuF1QAO8unFDp0KOhI=
X-Google-Smtp-Source: AGHT+IGl7OvfYF/xmA/ZaBWdA0VWZfJl7gA/n4fJNF+/liQzH46XYzOdZbagRmJzGfgCRHALuicPpw==
X-Received: by 2002:a05:6a20:7d8b:b0:2f0:4f71:c478 with SMTP id
 adf61e73a8af0-32da83e5e86mr5868967637.46.1759944615666; 
 Wed, 08 Oct 2025 10:30:15 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-794d510f628sm304893b3a.29.2025.10.08.10.30.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Oct 2025 10:30:15 -0700 (PDT)
Message-ID: <89ee9c5b-7938-422b-a371-74b9a4e2df5c@linaro.org>
Date: Wed, 8 Oct 2025 10:30:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] target/microblaze: Remove target_ulong use in
 cpu_handle_mmu_fault()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20251008060129.87579-1-philmd@linaro.org>
 <20251008060129.87579-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251008060129.87579-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

On 10/7/25 11:01 PM, Philippe Mathieu-Daudé wrote:
> cpu_handle_mmu_fault() -- renamed in commit f429d607c71 -- expects
> a vaddr type for its address argument since commit 7510454e3e7
> ("cpu: Turn cpu_handle_mmu_fault() into a CPUClass hook").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/microblaze/mmu.h | 2 +-
>   target/microblaze/mmu.c | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



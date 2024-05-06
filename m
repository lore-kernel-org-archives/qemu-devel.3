Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAD0C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 12:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3xio-0004aL-JD; Mon, 06 May 2024 08:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xiB-0004Es-PA
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:44:56 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3xi9-0004o3-02
 for qemu-devel@nongnu.org; Mon, 06 May 2024 08:44:55 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-41ecffed96cso7490915e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 05:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714999489; x=1715604289; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0cFQyq3z9Cc//wNTDbtzYLuXEADksyALJBLgETHntZA=;
 b=f0fOzeCst0D78p6vyZpV6OC17YULbYL49CNe0mtSycO63hrGBMPQp2rLbgbXJX0EGs
 gHfUyMBEUxi2TV1al4ZJDnbbIEaOk7y2c86Lc+DItnOwXT1vcCfuEMRfGE1CgXAEFZqP
 8osX6F1xDNSnHd2f2REfCkJ8f1r4z+VG3DEQEOEdDPwYb4SETko9qLt9lZDDj+tFJeHc
 4FrAJX7jYsPu0OZTTTDD+3kC4++GH+4ZsX53HGVagvxogemgWjAv+mVjUPF+X8g7yA5f
 rJ/YYcldE5fcP5j/ztPhlWWg9+4tzSj7J+JfbaV+VLPLSOaV9V39NPTAVcsGaHqyOc9q
 9lPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714999489; x=1715604289;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0cFQyq3z9Cc//wNTDbtzYLuXEADksyALJBLgETHntZA=;
 b=lyxCqGok7wz0C1OpVHriX6oTQ2O6Ta+1DZZN8UUAb/TG35Dt34IrC7s+3oE10z1ySG
 C9DXlkNIKnAPWKRF4ujGREKZ5WXpWnNe/BrMscs+A9yQRkVUMAji0EaXEHKSig2XAOpv
 nTAMJX1hPzZnp6Rw3tOGKEDf1lAGiSGJagYfr3t+cqX6tG/TogcNToCbtPwkjggUgLG8
 33yMOWdPnYZVbOvlXSZsGtkZXW7KiOSxtCJvyuo3Snq67dKpmInwI1m/CInIbo7ckUtZ
 f+ouqUlxWrVlr+zw7Mnqg4HlxybBsAw4WDAaCZIemnOunjpV1rcgVcaMOlSPmlFGEP2r
 1yRQ==
X-Gm-Message-State: AOJu0YxICkZZQl+w741KqvSnazBpcXAaPMRPCbzUq8frjfztNLaYrlKo
 E3oeeRSgh5iZ1ZSdS+VnBIO4glt9Xawy48MqO3D9cYGvapNU6mlX93C5GFjC4zPguNo6WOhTliM
 E
X-Google-Smtp-Source: AGHT+IEoc2ZRYlKshhAElom43mslOBdKC5FFXMacjE6ilrgd9LLtIAfRLBThWi0Pt1y0aqr0zB8N6Q==
X-Received: by 2002:a05:600c:5122:b0:41c:ab7:fa0f with SMTP id
 o34-20020a05600c512200b0041c0ab7fa0fmr7538692wms.34.1714999488866; 
 Mon, 06 May 2024 05:44:48 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.4])
 by smtp.gmail.com with ESMTPSA id
 u4-20020adff884000000b0034db3042b28sm10557549wrp.58.2024.05.06.05.44.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 05:44:48 -0700 (PDT)
Message-ID: <409b15a0-b665-46f0-a758-4a013b493356@linaro.org>
Date: Mon, 6 May 2024 14:44:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/28] Accelerator patches for 2024-05-06
To: Richard Henderson <richard.henderson@linaro.org>
References: <20240506123728.65278-1-philmd@linaro.org>
Content-Language: en-US
Cc: qemu-devel@nongnu.org
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240506123728.65278-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 6/5/24 14:37, Philippe Mathieu-Daudé wrote:
> The following changes since commit 248f6f62df073a3b4158fd0093863ab885feabb5:
> 
>    Merge tag 'pull-axp-20240504' of https://gitlab.com/rth7680/qemu into staging (2024-05-04 08:39:46 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/accel-next-20240506

The tag is 'accel-20240506'.

> 
> for you to fetch changes up to c984d1d8916df8abac71325a5a135cd851b2106a:
> 
>    MAINTAINERS: Update my email address (2024-05-06 14:33:49 +0200)
> 
> ----------------------------------------------------------------
> Accelerator patches
> 
> - Extract page-protection definitions to page-protection.h
> - Rework in accel/tcg in preparation of extracting TCG fields from CPUState
> - More uses of get_task_state() in user emulation
> - Xen refactors in preparation for adding multiple map caches (Juergen & Edgar)
> - MAINTAINERS updates (Aleksandar and Bin)
> 
> ----------------------------------------------------------------



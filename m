Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F03CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 20:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6wsO-0007YR-Cj; Thu, 09 Oct 2025 16:04:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6wsI-0007Y4-5e
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 16:04:30 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6wsE-0005iI-Ju
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 16:04:29 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3381f041d7fso2771109a91.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 13:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760040264; x=1760645064; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e5uknRZWo3w78A/6w87IuLBWWnjLYdFRuqzzD0c64hA=;
 b=ktfmsKhPytSkCBroVrcOpzTmhip2q4+SdizJAGL1zrPasae7jKz2IFMS1SvGJ2BkyB
 TnYMVYSrjg48IEVLTl+KLGxrZYktDaIkjjhJqWkHbFT3N70GuxNRH/ZSgPygXWkw8F9A
 7v6h+lyrF2Y+n4hs6MFhRBiuITk53wQw4yokQ8AbL7VbXC8/kYDefhQrNBDkVlP4vb4R
 Sg8mHOlM440SJRxBYuVcBEiQmKLkeg/sf+qTDJ5psFPHn6nSR6DGz7mfvdt2v+4r9SRU
 SjRvVxs3G5nT7muRCBIEdQBXbgfpCSUsNezj3HrOWT218OAJolRRifAfevOi4+ktObGo
 9Unw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760040264; x=1760645064;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e5uknRZWo3w78A/6w87IuLBWWnjLYdFRuqzzD0c64hA=;
 b=A7tCX50oEGtmr3tblMmN3i7zZ2eN3TZIZ1yaIY84G0g5iugGHh3pRYFspMVFu6xJG0
 MBBSC0m/3EIb3W+rof6mo5uFtDlO7FC8gAAULPzdBiGpvl4nPy1orn41TI0yLt8l1tua
 vmPxZw2eYLkikvR7BCPH9AMksycWtXQ+9coYnVrOUSYPR6X6SGceGrnTScDMvmiR90Dq
 /3oSy9XTcP9hXgcOvaCBajPbvvXohTBS3n6SLsU3UzQCZiDnkecNcrZj0sRVnenR51qs
 maF9okxWCZ9oaMgTlZOePUyHd2px2L4K/OmuZo1Y6WABu/pLTIzK373HrTBZhqWT0gia
 Wr2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvYdEvL8SC5/Kg6mnxXB269KNU9zZ4tu4NYf3heBqm4QAaOFldUXmLrBQTWs92U7okeqTmfd1mGRTI@nongnu.org
X-Gm-Message-State: AOJu0YxFG6CEyFS0nEUyCf6QotfLk0azLNrKuu/0mXMkxOJ7DyfyqnTY
 miqpQI+EJiFzH2uFKcy324MQz++ceEGfDx+nOPeBTYMfCH3clLYMRzCY1GYxK4BKGNfMOywAeff
 FWj24VV4=
X-Gm-Gg: ASbGnctgLPV+Ij4HJ7eGnO6AKncmWGxuc7ZgPSDGkElfH1xaazXiPG+S6Ay8g+0CXIF
 qAmLEtJexfT2Uq1eBww73FuBkgbvG4yN0ipj2f1KWL2qohJuGApGBUwoO5ysN5hfreE9zfiI+r8
 Aq5j0ir+vDz/26iaKUcQjnPPXpRkyHJno5xaCtGAov58gvk4MYNpl0VoZZ4vm3PALyIv/HXaA9Z
 qjF46eBrEP5M/io6zj5vtKKC6CnMqD5fKYj3yEk4gNPRP2py3D1Jv9e43a1ps6jPE6hxol9pWog
 ttslWvi7NUKatjammJ6hVMdprd+MREM5GNpsn5MnA6L0+hX0EOtpTy9WPQugjB0QYVTCgLEqTO7
 dxZnTNP/0Qg10MAGJFuh7+zFzbLTpkXhQi257xytCZpo/dc8cVDibG7W3I24jWY/G
X-Google-Smtp-Source: AGHT+IFY3nYbNKYvy1+KbO6X1xZs1p17R516biun+pen1ebHvxk/21EBnpj1AWJZzc6oOmmpQnGAlQ==
X-Received: by 2002:a17:90b:38cb:b0:32d:e027:9b26 with SMTP id
 98e67ed59e1d1-33b5171967emr10239100a91.13.1760040263927; 
 Thu, 09 Oct 2025 13:04:23 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b61ac8d7fsm701020a91.21.2025.10.09.13.04.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 13:04:23 -0700 (PDT)
Message-ID: <3e6801af-04af-4ef3-b17e-8db4b28796d5@linaro.org>
Date: Thu, 9 Oct 2025 13:04:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/rx: Un-inline various helpers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>
References: <20251009200012.33650-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251009200012.33650-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 10/9/25 13:00, Philippe Mathieu-Daudé wrote:
> Rely on the linker to optimize at linking time.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20251009151607.26278-1-philmd@linaro.org>
> ---
>   target/rx/translate.c | 48 +++++++++++++++++++++----------------------
>   1 file changed, 24 insertions(+), 24 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


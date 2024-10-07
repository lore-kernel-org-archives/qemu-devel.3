Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5CDCED240
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 21:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxvBn-0007j4-Lu; Mon, 07 Oct 2024 17:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxvBi-0007KG-60
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 17:22:42 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxvBg-0001ns-Jf
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 17:22:41 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20b86298710so41369385ad.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 14:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728336159; x=1728940959; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s60O5wYAf6jx00TtsFTa4DP5HnU2LyNHVb304Id2ieA=;
 b=XoHe7K8fHRJ9HKcX7MVsRUAMcqLB+aP4+CZGrs9qCOYP3Qg6hvDm1a9RHj0PEOCMan
 K4lNXS9mnhvMAe9Dy4F9GUmdL2QiMDHj15CFBYiYJWNOGOFPwCJP3T1LLj1ba7E5vD7m
 2+x97+k2VS0EQL4mw64XqtIf4gG4jL/hajzzYsMEPTlI7Br+X0nr9yMXGZoXy5KsKPkv
 c/QXPqthTeCu1fhr3zB1wahvcYPm7j1ZYtk7WcQnjG6U+q/tLPGWvRgoQwUYqM75r5EU
 v/GH7fXE5crCdoRdK8wRkOtMmoymUbXVTBqIhat5g6vI5pkECjRjIzzynJVFzidxsOeq
 G7ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728336159; x=1728940959;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s60O5wYAf6jx00TtsFTa4DP5HnU2LyNHVb304Id2ieA=;
 b=ZjjLeO8pFnZe6lo6ao5DSXcpmT+CTXenekWNWavmCfW/F7tmsZIXcuYF7aRTz6C+MR
 ukR0v2ZIoEIgcTvWeBOXY/Xef1zFVeY0IFCF81ctVy4L7iSXT3bUCFzr+J+OBarV1ZcW
 hWvDaIWSF0WLebCMtarlz7LSBgiSGH8vhnkdFJXmwmNMZJ0IjBGNuRsbmAS6ynqBGlQ4
 t5IxdEQblmEg/dwGrMhQBUJVlNvxgXGMb+VOq3FGy+BPdW/3lIKPhGRWpHVvnYd0LuJd
 9wiCs/c0AkZL05RVJ28Xvpe3E6IeudvVPVA5/zOfUCisrQNUY6ha2PJuvfQe5z8REZ6u
 mlvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRIlRzRU4wk09kzSRk8h4opCJLGeA0Lzy0lV0+kMWUZnINEvSp83I09fQyRmd1xEq7TxUAi7PzH2dc@nongnu.org
X-Gm-Message-State: AOJu0Yx32Onui5NBhYqF+WYTxKGvQ9SFKA7YRcWbw1545OJxuzJLCjKd
 1vXoSxmfdSdlBO3X28lhccGIE5g4deRrvgQKm0OCqtt3xRmORcnuCY/NuzK6eyXYXSuZ5Ec0/m3
 2
X-Google-Smtp-Source: AGHT+IEuq2X2j5M3Rc8qtgH0NBoziNfV19PVaUHfklTp3hTM6YD1W+hXeAgxThlOsil8iCd1VXi+Ww==
X-Received: by 2002:a17:902:db0e:b0:20b:a5b5:b89 with SMTP id
 d9443c01a7336-20bfe495d34mr188077105ad.35.1728336159124; 
 Mon, 07 Oct 2024 14:22:39 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.163])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c528540a0sm693765ad.93.2024.10.07.14.22.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 14:22:38 -0700 (PDT)
Message-ID: <819fda22-2258-4d7d-9015-99ce43a7e7c1@linaro.org>
Date: Mon, 7 Oct 2024 18:22:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/20] target/arm: Pass MemOp through
 get_phys_addr_twostage
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
References: <20241005152551.307923-1-richard.henderson@linaro.org>
 <20241005152551.307923-18-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241005152551.307923-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62f.google.com
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

On 5/10/24 12:25, Richard Henderson wrote:
> Pass memop through get_phys_addr_twostage with its
> recursion with get_phys_addr_nogpc.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/ptw.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



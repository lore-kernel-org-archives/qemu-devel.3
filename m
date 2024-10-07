Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E26CED241
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 21:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxvEZ-0004n9-Cp; Mon, 07 Oct 2024 17:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxvEU-0004mo-KT
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 17:25:34 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxvET-0002Dt-4K
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 17:25:34 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-71dfccba177so1455174b3a.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 14:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728336332; x=1728941132; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bvhNWuTmiXbiPL4r4jbXllO3aWtcbM0XDS1GCHGzoYA=;
 b=BBb4ZOzKXEyk3vjxeikWbz9QqyEHzmr06OraViOSEz8ynWCTYA5aKkhmJS7KZs/prm
 F5Eui6Nr2OFNo/pertSOWByr1pSLMNkE7L9DIF8zs0YPRH8uMcnkt5b/n11K/HWbhT8M
 nKw/vBAH74nKWvGgEPIEMLaAf3+1tsjw7/5GDvv+yj8wJOwN5KDn3dfVdC7QQ+Fsarje
 gLhFwrUeoS1V6DXcnWJX+FEPZcJa1sOrXuxG3RgDibr1z2B2PegQVmudekLfN4/ZdCeT
 WU0vZzIMZh5loIrvxrEq2yQ5LWo9MRFDzFUuTvsfXcENPT/sohmZIoUhKZVotI1S+DC0
 xQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728336332; x=1728941132;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bvhNWuTmiXbiPL4r4jbXllO3aWtcbM0XDS1GCHGzoYA=;
 b=GX2kemc8Lubbc1xTjp2m/eu23fOoW/h0QrCJEKXOGg8QhfC8nL4JoH+tUoArq+zono
 SguPY6wMe/8WR0yurg+2w0m1sbm/pG/H5SwZMUAa5TGnA6vfchQ/cDeB68w0Zm5hEiJw
 NdbrJiSbPbHrBWTWHfLsFLYk1A3V0+I8boFeOg/MlefFh9TvKGkzrj/puFqAfr64qT1k
 QA1jyE9i4whN2K6JFPXshDPxbXxViBhMJ9yX6kJzE6kpggvg9QJ2Sg5bm9oKEuRuW4B3
 WqYGgAuzYiPovohmUgrCWUrqdpXYBK72Dq686U/6gxGLow6MJEuI2dqiTvKEKOxT5pwC
 0muQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOu3zBk6i8C9P+Jd7QYIIMAk+Umb/fnYQFJ8M7z6MHOog7iIrhogPkq0w18EClsuK1BOlvJCTsBLyx@nongnu.org
X-Gm-Message-State: AOJu0Yxzq0Ov1gOphc9m3zx4+B2h2g9plw8JrkHEoikxFAMRn4Qnh+O+
 ZVqOV2D1P35WWWUMtqGniqJPIU64wput623uXlYOJvz1Bgs84EKqtlTkuhIyPEU=
X-Google-Smtp-Source: AGHT+IHXPDbu9GiUdYV8Znqu/vftPYbbTENCnUoX5/c+cqoS+dsr+OnFvCnpTsrCSioOJE4B3/ulTw==
X-Received: by 2002:a05:6a00:9289:b0:71e:fd5:4efe with SMTP id
 d2e1a72fcca58-71e104cc6cfmr1595660b3a.6.1728336331634; 
 Mon, 07 Oct 2024 14:25:31 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.163])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0cbbac6sm4842201b3a.39.2024.10.07.14.25.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 14:25:31 -0700 (PDT)
Message-ID: <96f27a23-fe87-4f83-ab6e-9e314addaf4c@linaro.org>
Date: Mon, 7 Oct 2024 18:25:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/20] target/hppa: Fix priority of T, D, and B page faults
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
References: <20241005152551.307923-1-richard.henderson@linaro.org>
 <20241005152551.307923-11-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241005152551.307923-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Drop the 'else' so that ret is overridden with the
> highest priority fault.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hppa/mem_helper.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)

Fixes: d8bc1381250 ("target/hppa: Implement PSW_X")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



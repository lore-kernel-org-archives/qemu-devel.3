Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1029FE77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 14:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVtp3-0003hQ-P9; Thu, 09 Jan 2025 09:47:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVtp0-0003h0-1C
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 09:47:42 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVtow-00088V-Ve
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 09:47:41 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43618283dedso10647925e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 06:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736434057; x=1737038857; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m6FQo5JO15y2HjqzZF2V4fu4tFCP1Ym9MxDRDNvrAZ8=;
 b=CSUhOkxzZD34n/lvqnA7zP0rQ+eJuZC5lhYfjvAn6xiW3GCOAQJi3mHswvEpvMzbXQ
 7PBT5YpzFbXt9sJow2vwqFjDqcWiw1rgQh0Rx5xfgpROmhuyyNb7DzOAsmz5lNyVnSuK
 vfB1iZxIdOB+Y8zuUmSUzed1Dm2kpU6lHu4Ed1B7GvGifgpfwhUZciaKuCYNqeqtzctA
 j3O6uG4Dv3wZdyjoVXQaHtawVNn3Vwqia1z9NJ9+6UyaG0MtyWj7cHCV8slnwfCjdjI4
 yVydEdDdWLDgPE4d/n4r7pCpHKRfNhruRmkgBY6Lm55hpLHiU2ngnAHa3ozuWp1UnunG
 zMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736434057; x=1737038857;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m6FQo5JO15y2HjqzZF2V4fu4tFCP1Ym9MxDRDNvrAZ8=;
 b=t8k2NYluLsY1/jyXVPOitHBOnFDh/t0AxGa7DfukAUaOORIcd+3kM9ntwtZZw3VhEC
 DRZlbjZivnajWeNMjACJYGycJP9BVQhXqRN9rHGZBgfYHmE/6wsrhjbPG8amF0adxFzM
 U1lCEmGD01TXGwxrKMDvEPs14IUmdT0tABqiOK/aw1x0T+4EFZMGeQ2KFAWZmibBcaZ+
 Wyc3PJ41KA1/CBgFshNqDDfCthG3OasBvPj1vCCeXePNvH0mqPUlZQyhwV/miLEjpA5V
 2QK8BcxL329rYueb6K9ROYjdtqPGglUYuKhRcGRbUe4ci2+K56ckqKffup4iMCOTQRyl
 p3IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjYBcEtCoxkE45b46G9d/p2HsC5vQH2dlM2UKANOM/YpSBHdAgqtlEo/MMAl/41uGdu2NDQMaur4D+@nongnu.org
X-Gm-Message-State: AOJu0YzK3S60sqf1lL4jYtpWHmObmyx/aBilKezgz89H3ZZoGVAzkNvl
 OLoazthnBpIas9x/iktXnqXwRxO/l2CHURXSzYnJ6qH5QAIvJoeDEsMKO0P+RwU=
X-Gm-Gg: ASbGncvUWf8VudK+r20sZZqoU23tmHALNI++LRmbLbOjBra9QrlYeSvwUDaNtnFxyHa
 hEYUpXUpY9zjxpaUho5e/Xs99RRbEJApwJbAr7YUVIZe3rEX8WWk/veAkAPj+5V7JZ0P4NcUwdr
 sgg6q++wiVWBzvCjAWwDhSqA2s95cO9NLX+sWHmjhfsOgbDiJYux6H99gfAFqlsux8udYIA75/8
 23xLItxq55+bylOYeaI0tohJFS7uiMYhBM+k/hpLaYcyMyw20W1Q8cmukToTdflh1giK2N1aLd4
 n856FKY6rNeUNVXZzdZdqIfDC/I=
X-Google-Smtp-Source: AGHT+IEyA/I0BX6UCKKLbYqrMyNAyYZVEwdescIdx6smRfhe/w2gxOPZddXyla0ks3htd+22/cmFcg==
X-Received: by 2002:a5d:5f95:0:b0:385:fb8d:8658 with SMTP id
 ffacd0b85a97d-38a8730fa6emr6435711f8f.40.1736434057271; 
 Thu, 09 Jan 2025 06:47:37 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e383882sm2022278f8f.34.2025.01.09.06.47.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 06:47:36 -0800 (PST)
Message-ID: <4a6188f6-2155-42d4-b9c3-897ef434c24e@linaro.org>
Date: Thu, 9 Jan 2025 15:47:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add me as the maintainer for ivshmem-flat
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20250107015639.27648-1-gustavo.romero@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107015639.27648-1-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 7/1/25 02:56, Gustavo Romero wrote:
> Add me as the maintainer for the ivshmem-flat device.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   MAINTAINERS | 7 +++++++
>   1 file changed, 7 insertions(+)

Patch queued, thanks.


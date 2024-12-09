Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D57E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 16:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKgJT-0004gt-0G; Mon, 09 Dec 2024 11:08:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKgJK-0004ZP-Q7
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 11:08:40 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tKgJI-0001B8-SL
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 11:08:38 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-385dece873cso2149128f8f.0
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 08:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733760515; x=1734365315; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YMzV7S005vAURmFsnCKWT18BZg/v0lBLtk9jGBTNycE=;
 b=VLfIJ7hiw2CsjHaO4kdrxZtJWLTHRlIhzCrfuJrqH+ar4X4PPJi4N+mlgCazYmc93Y
 IOh/b/v5LM92B9hDl4DnPvzPiZH0aKdpSLDvWSY/s2yY+x3yJ/w+MUEumzauArfOMIl8
 FraOWnB8A2+tzLHgyclEulu0DGExB6tT2Y98rSDJTnvSo3pBb/6XlGPO7C7ibTo6fq+r
 qxK+O+hBF5EyW/M546z9EWmDmoS+RSbDybdbe/dehtFmGY7SZ/wLR6XO76xpVCDeq8YQ
 Pa632UOu/D6DZpvoDDRBOAleICf6Rop9nlG6uVeVH57b8orqcwC+4MTL3+HHeDAG+pZx
 3CtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733760515; x=1734365315;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YMzV7S005vAURmFsnCKWT18BZg/v0lBLtk9jGBTNycE=;
 b=DtipRrr0+c1qmqt5FgL+8fCHr45QNFLiTsi6uw253lUCg45t1rMxKQqssU5OFYo7Rz
 1uR6JgRPBCtO2LFxeoLbppfiGv/Ktjby3HLnQGN6yaomINmQWruXZUpSlclTCGroqy/i
 A2+jxLCEUEH+CyJNnNEm6si67ANkXFdgbh1qAADX4XlIvzzpQO5VW1CdN9w2amZiLjaO
 iTL6T+cMAzb2u4yYuAFQ/RqtJ+KDCCj1z/ERQFCP9IVWI14jTPzjs1KBJQttyDXU3WUH
 wkTbJo0Awz1NKFdOgLXRlvx2Dz9o3M/WaO3zN/3JkBvxmbLVrQz8tFQUEUZ84go1F1ca
 S0XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCItXVJD8a1+3JPL5UN4AfMRDaoYIoNxWZHs7FRGVDn/KTJxnU0H2aTDE3jUw2pNQP5CWyqD8hM8aj@nongnu.org
X-Gm-Message-State: AOJu0YxXuIETZ4nidCmDzLyajSkjy2aVQQP108hzKmThtjnBK3i8MJDF
 7nKjIONsnigsxlggetbsJ53WjccS73HMoPqKJ/72qeMbjis3MfhuKPzQRNqR3HY=
X-Gm-Gg: ASbGncvqWXskg+rw6UQJLUGN3fEXaP/Vog4nGo2g0gvUJ+73Pc0CLGtfzMKQI6a1Wb+
 I/5I01bjxITOsGMQADZ9mXLcEejkBMi+WaDv+4HhNRmifG2fGcQoquJ4JwGy8tMOEsEXEFN2xgV
 SNrXnzv9thjU2P1VKypzhiIJvL+nzcYWV/3m6yq/hdgLtB4VgJqVvhdt//8OwjeFQLodFA5g67e
 qY47u8QoRCtskETshgaPXwULXbpyEyRWlVCQoUCCRp8ijz9/ZW/zMyxr/FzLYecWohB+FE047Tx
 qv+Q7oKMpPUneCxlWURCXRuskDtpMGkR
X-Google-Smtp-Source: AGHT+IH1BkkxhCaZjLiyDWTfkTadq5xrywA8fnENUb+yP05sl2CbzYWuDL6mFIbNPe6O7qjnVq5aJw==
X-Received: by 2002:a5d:6c69:0:b0:385:e0d6:fb48 with SMTP id
 ffacd0b85a97d-3862b33f30fmr8784289f8f.7.1733760513816; 
 Mon, 09 Dec 2024 08:08:33 -0800 (PST)
Received: from [192.168.1.17] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-386367f7c71sm7804627f8f.41.2024.12.09.08.08.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 08:08:33 -0800 (PST)
Message-ID: <3f7fa22e-8101-436d-9d7e-2060f093c66c@linaro.org>
Date: Mon, 9 Dec 2024 17:08:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/17] softfloat: Remove float_muladd_halve_result
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: bcain@oss.qualcomm.com, peter.maydell@linaro.org,
 mark.cave-ayland@ilande.co.uk
References: <20241208224844.570491-1-richard.henderson@linaro.org>
 <20241208224844.570491-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241208224844.570491-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 8/12/24 23:48, Richard Henderson wrote:
> All uses have been convered to float*_muladd_scalbn.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/fpu/softfloat.h   | 3 ---
>   fpu/softfloat.c           | 6 ------
>   fpu/softfloat-parts.c.inc | 4 ----
>   3 files changed, 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



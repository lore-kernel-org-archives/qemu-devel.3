Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1477AC36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 18:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvgi9-00008F-El; Fri, 21 Mar 2025 14:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvghe-0008Gs-Q1
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:02:45 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvghd-00037L-80
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 14:02:42 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22398e09e39so49533075ad.3
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 11:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742580160; x=1743184960; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZQx1MYwR5XGQhoOob8K5fBrwsUBCr9fmoIlVhl+BMyI=;
 b=zjL1isdA77BLanLVrgwJiE82AsEx+Lr2fdYz93d8iiGum2EAzLN38wuIhCBblZYfyl
 PHZWL2CTuBqxJK99k200rYGPqAN95d+LvN43wzif5MboLYPcti7YtOYscN6PGI2N19EQ
 GZXN9wNRUG204GIHsrhbgWoyWVlg8gM+ssC+Y71cHMvG/gI4yIUexvJS5FDZduji/mmI
 hN4WkFbK8SSqyLXDRmgEeARh82t+yURQwkn2dpPIQg3BKyWYHorCzaylTw3QeRi7HS4R
 3qIpFLKk+60wOzl+QbK+GmdN/097qz7fnvmN1j5p+QWikFc+lVNNHcRMFeTQtdxvzTgJ
 fV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742580160; x=1743184960;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZQx1MYwR5XGQhoOob8K5fBrwsUBCr9fmoIlVhl+BMyI=;
 b=iHcSZA3nsu9XeMjGl8JPCyntudxidVdCnTW2ZcclF8ncjGJLfiSkMYQq+zxMYGadH1
 K6W2R6gZpbU5oAKWIqv61nyBL/17Y8j69o1JgdqcX7nb3W5w/OOi/ueozm8mbnVA0O4F
 5oAwSYPKhn/aNDWLUL68rzfIBWLKfRPySYzA6Hy+oZyG2zloocDQ6Ygco8+YNtSUyTAR
 laCq6e+pRVzFyHwZRLoIHjub1S7IVfMOu+DSqMvFkHYmn4AejerITgxm12VXiHxfz8aP
 H1YIkSlARsheDGO45M0Q+BMFI7eSTSbuhZralr10GhLOifwT/Fq6nbJIsSQSHCoHXMRo
 7iEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW66qMZgB41wVrJJRjGiFkV8VIuFsRtOwZ8ciX9gwLSfpTp72Yf9hzp3k0fXAdIG8xHkzgRgNwXpUj7@nongnu.org
X-Gm-Message-State: AOJu0YzEexGgp1IPcNjSS+W7MO9Vz7FQpf3uB9CpSEH5zij6YOecV4yf
 efJlO39/qQJt1qO/5gH29CndGb3KPa5PzC8/dd6TTk2vEmVqblvSY+2YVeJ7zTc=
X-Gm-Gg: ASbGncvkhCUa4tKvzRM5jKRaVRG4o4JXFRbnKP+eR7NlTqFeVTtewuTBbVppFyZa6X1
 9Z3Qxc/G0Rebs6cRsAW3e2CoRd/x1aI1K8LFTV2V74nPLKm+V01dFmcb+NLEJIJztgyexLcgTQJ
 PXir/9OJ0vclAcorxHQmPvjfp0PKSGBha8gBCqWw68pYRAjT6bg9fe5ctGzp5GzmFklA/yXsNM5
 x1gH/XiBCcBbvhJwvJYQv2EwuGZyp/ok0w2kGihfISNfbFSU7/354E77xSiAxhClZKAUl4s+ztW
 0sXqTMAl+iESa1+/vKfLP6nE8lDvgd0m9/CHmNdiV9uWwtJFxXz0L5QKQuj1Y1uyPr6ik5YbHP0
 TOKkQEECV
X-Google-Smtp-Source: AGHT+IHeHBnqsyQDfPVC5c6M9WveDyjBqtnNjS+sN49PBUiT/Etyamb3XA0J7Wn3GsZAAWnCbxJzNw==
X-Received: by 2002:a17:903:228c:b0:224:1ec0:8a16 with SMTP id
 d9443c01a7336-22780d81298mr74015835ad.21.1742580159551; 
 Fri, 21 Mar 2025 11:02:39 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811da561sm20161365ad.185.2025.03.21.11.02.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 11:02:39 -0700 (PDT)
Message-ID: <5d76ef18-f284-443c-b7ec-468246fd2a79@linaro.org>
Date: Fri, 21 Mar 2025 11:02:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/30] exec/cpu-all: remove cpu include
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-15-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250320223002.2915728-15-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 3/20/25 15:29, Pierrick Bouvier wrote:
> Now we made sure important defines are included using their direct
> path, we can remove cpu.h from cpu-all.h.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/exec/cpu-all.h | 2 --
>   accel/tcg/cpu-exec.c   | 1 +
>   2 files changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E37E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 18:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL4sc-0004Mu-G7; Tue, 10 Dec 2024 13:22:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL4sb-0004MZ-Kx
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 13:22:41 -0500
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL4sa-0003zK-3G
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 13:22:41 -0500
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6d8f99cb0d9so27578546d6.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 10:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733854959; x=1734459759; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FVQfMfw911ejGcdInlotjcLA0LafySIBdJl9PX6SzLE=;
 b=FhyDWdAkYguUqsm/5JHa3SbUMuvVBn3UyerDs+zohZKXiH1LMvvwXJIBSXNG/HRtUE
 28ckXrx07L8p1Mgq3MC4m1KD5qyUUcWSuNTRToFMtRmKEPKrpna7A58XbOKyRCrDLrEc
 BBXzdWYxMqK7PtjU56ns74Ai77JAALwdVREdZjZCVJzCXOwPkEKSCVyMXX4SL0Qsc5aB
 xeCI/pwIyQQohOMvaej0pMLNaPi4y1rS/ylFoXPmlIGcAze4FlwAMnllLOA4bISNLaRY
 4I2gBfdzWaG8zWERVMUR6auRqxgYuRn22Gcf5i1GIzYaTYq+3jBiNEN7lwKti4KSQQnW
 irjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733854959; x=1734459759;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FVQfMfw911ejGcdInlotjcLA0LafySIBdJl9PX6SzLE=;
 b=G2rEEZFYn3cdUVVBBK51B7wARJRs0DX0x1LdcuzS2+HHNkv8gepeq6dBu4Y44stO8k
 DGxIQ/z1BAEgmlwV1HiLK/KwxrhSPMhBaZgdvqwI45p/5V/B5b4dlViQO3u7vRJVvz4R
 upGXNsGuHbhy+7a9pZruobtBE69O7b7IUIxmLkp8tLPoe/ypycYZetxMRMD1UcSqsvw6
 cKoD+9Gl0EkbHyZGkw9qDSHhyGBxQhWsS1acivgLNFiwedIZPSHG50MLEpMAfHC9INot
 DNc4keOgOedch4KX0GoStCFkevmYTTaNKBbogCBhb6NHbkOBc6Z5fD23Wv+87jl335t2
 zs1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCkPcgX9LJ48fJCpMYoDqF/aOzHCN3b11rlZrLotG1sF8Kkw+CypD6in4g5ApXGse5ho6+lvcQS66X@nongnu.org
X-Gm-Message-State: AOJu0Yy6nI1oYka2WwiPc4VcklOWIiWNZdChGttzUQwGE2ZK0U+ZW5CT
 JMfj91ArFfehU25jRECicWY1PTrdTP/N+IPyHS1Pj/kyq7HgVCF6hHznBoCTFdi2GKx8M85VjUg
 tDqJ5zYdS
X-Gm-Gg: ASbGnct3aJlZOX7ILcus8gciiry3IS3Fm3NLj17adMm18fhCUUJLcUO/gdRMKWJmKDO
 /25Hr/BOQIKdTKJ5pldeQpeLDNVQXhb2knPpF4BipIn8y/OQVIF8A1caOqGjI42gt7dH7IYSm9J
 KziIZS0Qf2/7oEJXf9b6a8cGfX34WE3HFa2mafN0washI5RzrN8bI5uMfyWsBJdwVE2aHqLs9eN
 x+OkIMsHRislD+wMFL9IQzKwFlGT8fpPbYzfJxcUmolnQlkbz1iRhL6vOWrUpbNgl4lU2E=
X-Google-Smtp-Source: AGHT+IH/a+fhkSinuqk1Eyz7Y08aGksf8hKlOjdGAFQhS9/AujDj/LdBueB381ctpIxPx2xoEKyVkw==
X-Received: by 2002:a05:6214:5191:b0:6d8:8a01:64e2 with SMTP id
 6a1803df08f44-6d91e4429d0mr84815866d6.43.1733854958727; 
 Tue, 10 Dec 2024 10:22:38 -0800 (PST)
Received: from [172.20.4.119] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d92e0ca97asm5885716d6.14.2024.12.10.10.22.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Dec 2024 10:22:38 -0800 (PST)
Message-ID: <1388f3f9-364c-43e4-9cfe-917825876010@linaro.org>
Date: Tue, 10 Dec 2024 12:22:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] target/arm: Move RME TLB insns to tlb-insns.c
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20241210160452.2427965-1-peter.maydell@linaro.org>
 <20241210160452.2427965-10-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241210160452.2427965-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf31.google.com
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

On 12/10/24 10:04, Peter Maydell wrote:
> Move the FEAT_RME specific TLB insns across to tlb-insns.c.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/helper.c        | 38 --------------------------------
>   target/arm/tcg/tlb-insns.c | 45 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 45 insertions(+), 38 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


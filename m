Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C867AC43327
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 21:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfOqq-000477-MV; Thu, 02 Jul 2026 17:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOqo-000467-Fh
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 17:21:38 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfOqm-0004t2-Up
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 17:21:38 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-37df416c44bso1802772a91.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 14:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783027295; x=1783632095; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qw2u2aoX7yLk46MpxjnKP4c8r1Cg2ufj6OikpLjiGqQ=;
 b=XZpSZp/4Nb2nDUz3UdaZ31K14a0Uwp/D9f3A8iUfDZgaq6mMdCIIHCG/bNu4dyqDXZ
 Sr2H6YAahkn0K/tqxv+WqOYph7t5oJ9Uuj6ylCiO7E0T4ZtNDO8MoEnULRUtLzHOoCHe
 TdCmtnzmwvrGmLo8PD79dVlvE4EXd0aXWgDBeSCsloFya0l0gFzUDEWEGclyqOrXg1rX
 QabJGJEP25fdUZwfiOEUMOqIru0mvGU3EFfvnSDCB5z9MDlexTIBxH+dCE/I3xrbadKj
 JMZmg9YkahYgzFThno8DxJT23dPE3KawqyXhCJ4bkQM9T2SoaBr4ftZM4ks2GbKmTxQL
 JaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783027295; x=1783632095;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qw2u2aoX7yLk46MpxjnKP4c8r1Cg2ufj6OikpLjiGqQ=;
 b=IrHWzWfAGc5kLS3FPvzbjXe3mwoApk0tcju+BATPnmtLm3iW9RHrr8YVDCbbFU4K0Q
 3Z5hZ4N2ih4YzoJrZKXhT9qjd5HGDvz0oDK8g8ORJMCQOQbRyUX29xtdmDY7Up3oSVJn
 H/bvIHsHOrKSGXTGTI+k1CLjY2Dl4cHUhA3nLyJv5OM9Anz6JY7uzmSHWqW5sdoDR2Eq
 Q3uhg6qCO20BHuryKTU2Q+2H+e8NRXZeJQ9ddBoTwnH8AxIxsp8zD8U7dk+FA5DhegMH
 alcsvYnzU4invNOJiimA1iumcWpBKjIwJIPiCpvUWBZwjPqYb4cUO97olg1o413KzBjw
 IZ/g==
X-Gm-Message-State: AOJu0YxahMi1SqS1eb6+iC6wwhDGdxCovn+Yu5mviu8ioFOcSI1fUZzv
 5MacrLFiT3S/+z+/CvBOytQ2Ki7AVTmkXkHBEYM8NfykHFebXW4E/6h9m4ofOWurKsSYDWhyckI
 240Fd
X-Gm-Gg: AfdE7cnpjsXB3REMvbl6dwokIPNektWnwybjCaGTn5h2+E/LirAJSAIy3e4hRqEHrDW
 SBCMgR/VfAY1QICqLvXpBJkRdrlLCuozexT8W1frFFVsFhSYpu6yWCfTxx8csOWwcKK/w90E2aA
 hrU2xcOTaktBuf0ohcGsbDizOsRZNVfsRa00G/HnRn7vI1zhCTUElu97cppORYOgPeUKaaDH6qo
 yh1JTSlN2LD4H9S5kEWbj1QLbrnNWAYUFaoUw1qWp+MQhQgGI1SJdUsI44PhMY+tVzTLOc6sUoR
 0IR9s9mLQMNFfafO3cHEXxOOme7BZ8w7mSdOMowyOxKIa4qNL7UoUs5NAj7pEiGYFoa1uKg84cN
 uEOmakrCZgIrDLLC6KqLXsQCBCoPFkUVvm0za9ahCRDEP+yg+wsBcM77Mz1FX8AzRnkXcI5brsE
 UU3BQTzEY/DiDKGUuhqjQo77kUPTiJ1prhMKRPVG4xXrFy2wE57SasWXHERw==
X-Received: by 2002:a17:90a:ec86:b0:37f:9cdf:f037 with SMTP id
 98e67ed59e1d1-380baaaa765mr6941560a91.26.1783027294269; 
 Thu, 02 Jul 2026 14:21:34 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-381148a4363sm423589a91.1.2026.07.02.14.21.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 14:21:33 -0700 (PDT)
Message-ID: <0f59d1a1-986d-4a0f-b865-699c4674589c@linaro.org>
Date: Thu, 2 Jul 2026 14:21:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] target/arm: Add new feature
 ARM_FEATURE_NO_NEON_TRAPS
To: qemu-devel@nongnu.org
References: <20260702184019.3431139-1-peter.maydell@linaro.org>
 <20260702184019.3431139-9-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260702184019.3431139-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/2/26 11:40, Peter Maydell wrote:
> +            } else if (!arm_feature(env, ARM_FEATURE_NO_NEON_TRAPS)) {

Is the double negative really worth being able to limit the addition of the new feature to 
cortex-a8?

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


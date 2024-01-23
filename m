Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FEAC47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 22:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSPbr-0002bm-HG; Tue, 23 Jan 2024 17:51:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSPbq-0002bY-2g
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 17:51:10 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSPbi-0004qq-VB
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 17:51:09 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-55a90b2b554so3626352a12.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 14:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706050261; x=1706655061; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s1GQ6gQkNHmdyIztcc/OZaeE+FdOD5+FKIj80DpHp+c=;
 b=k4v8MumuC2Id8LuRUEcinJiVAnCioh6c8ocmvWKB2zMHhyWuYmuCIWFyjJJxT4gPVv
 rs8ITVKu+R1cPGtcZppUSdS0pmXkcbGIrt7Z9hVYHcJkfuXD+b1P/SJrwTy/QzIRfw6t
 6W8U852U+HYlklcNSRvLUcqrthh2MrvYqJUZ1CuUB1Bow1bDEe76liGr+0S5PXDAb8rX
 Z5vcO2n5nfQ9CfpXrV+onmMNUuAar8Qk8Pl2cKuB1ZjxRVxzV3C4FLJCPxqT48+F/ekW
 w1kvjxumncU4Hlv5dulm1f8cUAKxvGn8JdunLocl8mZ31Dvt3PsoC03WNSKQ9IN0C6vs
 nPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706050261; x=1706655061;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s1GQ6gQkNHmdyIztcc/OZaeE+FdOD5+FKIj80DpHp+c=;
 b=I1CwzmYTgPG6sSzWVbf56ez5lYFdK54oNOg47Y+sWfA23I02QpBPIpMR+dDnOnfB5m
 nbxYSoNP5JK+MUU/q/dXxmzafmT5m9Uws/2fzDQSov6scoJVuv4hooMDLdxrCPVd/pWP
 QP6AMAKd4AUpa//eHdmnya8wqml9LDDQjPwAdvV4RVetsGqshp3ESCCYMDfRkUUKtyqY
 kYgiAK6i5X9gbuVTsHRZ/T5XxZHqnNwZyfpv/VIDuTfId2JeUwObnaNMNHqIJwNLZptv
 vBO+hPUa4iRWBxVgrMkqeOGFKYcZKpzxf2Pkf+ogwk1n6djnfDNhyKiQYtawojWz34DA
 zE3A==
X-Gm-Message-State: AOJu0YzPLgRh3cgaHxNzZ29X++9vgM7Dxt0CqhwlCiRu4UyOJsER3FHs
 XTrJFz9gG75qPkKuA5BBM8FpjPei3K7GyinEU/aAwtqNG43eSD6CLoo7M+wmEANjn2MtGNvsDwF
 X
X-Google-Smtp-Source: AGHT+IHGuHvs2ZAcJHS4IHmAWSyTGqWRBSyXRs4atMJCkmR3qtpaUlTP2sHPoQaRFJuZNoLVmgEMow==
X-Received: by 2002:a17:906:5387:b0:a29:3c2b:c911 with SMTP id
 g7-20020a170906538700b00a293c2bc911mr288361ejo.63.1706050261030; 
 Tue, 23 Jan 2024 14:51:01 -0800 (PST)
Received: from [192.168.69.100] ([176.187.194.78])
 by smtp.gmail.com with ESMTPSA id
 o17-20020a17090608d100b00a27c463fbdesm14786608eje.211.2024.01.23.14.51.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 14:51:00 -0800 (PST)
Message-ID: <f45b4746-99f7-4cd5-a806-f9a9aa269d08@linaro.org>
Date: Tue, 23 Jan 2024 23:50:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] hw/arm/aspeed: Check for CPU types in
 machine_run_board_init()
Content-Language: en-US
To: qemu-devel@nongnu.org, Gavin Shan <gshan@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20240123224842.18485-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240123224842.18485-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

+Gavin

On 23/1/24 23:48, Philippe Mathieu-Daudé wrote:
> Since v1:
> - Follow suggestions from Cédric from [*]
> 
> [*] https://lore.kernel.org/qemu-devel/e13c655b-7904-4e47-a673-4efd13c26b3d@kaod.org/
> 
> Based-on: <20240123222508.13826-1-philmd@linaro.org>
> 
> Philippe Mathieu-Daudé (5):
>    hw/arm/aspeed: Remove dead code
>    hw/arm/aspeed: Set default CPU count using aspeed_soc_num_cpus()
>    hw/arm/aspeed: Init CPU defaults in a common helper
>    hw/arm/aspeed: Introduce aspeed_soc_cpu_type() helper
>    hw/arm/aspeed: Check for CPU types in machine_run_board_init()
> 
>   include/hw/arm/aspeed_soc.h |  4 ++-
>   hw/arm/aspeed.c             | 70 +++++++++++++++----------------------
>   hw/arm/aspeed_ast10x0.c     |  8 +++--
>   hw/arm/aspeed_ast2400.c     | 15 ++++++--
>   hw/arm/aspeed_ast2600.c     |  9 +++--
>   hw/arm/aspeed_soc_common.c  |  8 +++++
>   6 files changed, 65 insertions(+), 49 deletions(-)
> 



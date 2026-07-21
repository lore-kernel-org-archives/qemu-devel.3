Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2533C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 16:02:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmCvR-0004Or-Fs; Tue, 21 Jul 2026 12:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmCv9-0004GE-6L
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 12:02:15 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wmCv7-0005Uo-Fq
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 12:02:14 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2cc97653887so125766705ad.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 09:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784649732; x=1785254532; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=U2ZQ9DJS9qNf8FD2TLAj2kuUKlFDI/4J910M6JGMW6A=;
 b=E9tOZ0DoCDwYDh7aQCQO8bL6kV9/SAXcam7IryoOY5pFJeN7YXc35a20D4pBuu0+ho
 RVPb0F9LoXQgEwMq1qPaG9HB01Sw4SAWtfODlIqReLvVYH6tPcY3zL2psWbz8Gg9/5MB
 BG14yByFORJ5v1/6P4vEzoGhI08SyNmroM1sbxLzKDn/xPSxSf+JxSKkfb1DvsLtFTuY
 /ogNU8k2YLPR3VWPLnm2T5aFyh71Xz4O//pluGmg3mDagt+qDmQia8xact0+k/GnM/No
 hkrsAAqqzzcbX9xr/4di5dOeqnoklmOmjLal1/6d2oKHdraLiSwCuA7F60j9pcbIJgCz
 pOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784649732; x=1785254532;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U2ZQ9DJS9qNf8FD2TLAj2kuUKlFDI/4J910M6JGMW6A=;
 b=cDogC7boO/C/+/pjQ10BiJSXN3EhLftAejC89U/MrKxtXjgBBm19FM3RzMN+2w3U34
 oM8VHgRur/I3GEVCsvEZOHPxhVXPO+urpa2tW8tbh93B3d0Xh7O9UIAGuxSqIgii5n2G
 Fzr21+L2EnOHPTLZRm72FBkER1mW50n52uzGI7EYQ9WTpediCbmav+x9l0NFaw8Hbd+W
 blrcF24RpwdVjmwRPjAhKiImrHWAxazAMIKlvtN7XCUswql7zTk+bFgHNCicByE7SrQE
 OIT3qo9qdfI1i/j4vAo4BygFa7FQzZfQfWm7cphWnLFiq6qDAeZpM1v6OB/D8ZDJzNvS
 Wgsw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr1fyZCjU7fBJ1QVeVkcYWMLlpH3bFLXd8cZ5KWKCTiYuJdwjGYqfc/+9fhLWOv0Fza0i28D1jqc7pD@nongnu.org
X-Gm-Message-State: AOJu0YweK0BzsvuaJSnvAopwL4fE8C1mvwL2DL2aSWKWxUg5No6KwCtZ
 BZCC88fOGsmwSM0V0R67KUM55xAT7bHpIQviXoj0w3zNYsp79hYubk5oP27AI5d/ba8=
X-Gm-Gg: AR+sD13LrZ7R23TLjIh79Ww0FUUtB51W5uzij+bz/ZUs2OyNGVi9bXS2eJ+8jX5zZQC
 MouFBhCaEaY/em0ruFyojCGEUkMavzYVpxBw4ALX/7/a6Il9bUtmFtzbXAXINzaw2hXOH/HBY18
 aemjOd+gJiNA0KUnAJ5UYtchtt2TzduOzuYzq/mtpjlbSBiy0VfilCJAVpcNL+b9vs8siHvPWPH
 V5RzR5+IcV1RaJzi7VdYd/a5tUz1navFlt4Y5awwLdZetworxIR76jmlvtQ3XCxNGyFHhvD03qo
 ZQOW3wmEmDJKexogzaNx707baKDUl2PYfS5NNKoywBeiXvFUBGML8qIgKlFpj9VMubAt9aTS/CM
 O3mYBNEbl17B+OX03gULABxK4cTRofN1Ot5v8lvwXJ27o4mgRKCeg+E+rkb2o/REpOByeHFgokY
 IzCwZsh1XfGP4ukpg=
X-Received: by 2002:a17:903:8d0:b0:2c9:97a8:afe8 with SMTP id
 d9443c01a7336-2cf34a05d61mr206119985ad.43.1784649731743; 
 Tue, 21 Jul 2026 09:02:11 -0700 (PDT)
Received: from [172.20.2.34] ([32.140.233.50])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf3448db72sm80697505ad.1.2026.07.21.09.02.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 09:02:10 -0700 (PDT)
Message-ID: <ecba4c75-c1d4-48bf-b8c3-2bc7cb8823be@linaro.org>
Date: Tue, 21 Jul 2026 09:02:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] target/arm: Build fixes related to GICv3/v5 and hw
 accelerators
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260721122135.6288-1-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260721122135.6288-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 7/21/26 05:21, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (4):
>    hw/intc/arm_gicv3: Fix ARM_GICV3 dependency for KVM / WHPX
>    target/arm: Add stub for define_gicv5_cpuif_regs()
>    target/arm: Only compile gicv5-cpuif.c when GICv5 is selected
>    target/arm: Build TCG stubs as stub library

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


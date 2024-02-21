Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BFC3C5478A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 20:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctWQ-0007Bw-VW; Wed, 21 Feb 2024 15:48:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rctWP-0007BO-9U
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 15:48:53 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rctWN-00042b-6N
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 15:48:53 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6e22e63abf1so3255862b3a.3
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 12:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708548529; x=1709153329; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AHtrZR+We7Ro4+ZIuOyCYbuhvRB4K4yyX2R7ilByOWk=;
 b=zS2YzDi6ld+n5TQ6gHo24qvh7PStYcCYuD9bfdVt0cXQtZEwOiNmUp2y7WJ7xQPPcw
 wneuZkA+Klxs6m3dAutFyFuuVdUboy7VpI5mBg76XCjmUEP60hUjXfIjfBBsKNrGQIGi
 1YbCIfaQzYj+t24yLJBw+46OuGT21ILCzEvGHTG29WyjFn3trze2B6bKhl+2FKV5XW+Z
 tTc3xMw9NcbzjFHSeKJ7Er13C6DQcwopwjTq+bz1pzmcjDNBWaTMs4fXGDt6WtsjR5e5
 076de2i5hRuRpKW1o60io4MkA1qdKJOlpPKXlNbH0AY/7i3kuusQSyr+ryguL3NNa/0J
 jGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708548529; x=1709153329;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AHtrZR+We7Ro4+ZIuOyCYbuhvRB4K4yyX2R7ilByOWk=;
 b=YWdszO1tIAO3abrJzxWlDddmG4of7LHGeTV9jpesna+0MmFKt375qOTfK+fjJ1caXW
 EwJB4jHybtKnvaF+o8cCAK3gWd4J5OjBbzNTEXtehQbvuMSjYt+r5bolRqiYP9uG3J3r
 hqcoRcPlZKSJ+ZPeE+pHUzGHPtYiIPVcn7oYOUp2ozc11XtACzgJUZYTkwsBogzSjN1q
 XmQ4HlwgVsjs3WgeAI69Uq3sXvcYj+HW+qTuRO22NSV3D6omH7ZskRh9DZUiJ/z5HOZo
 V7suNXc9Xt0byJ/B8W/b6YyKcDF+LnK8uqkkYl5eFc8YxNCjacWR3bM8M6aRTaXZwPra
 NBBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1LEpMcI70uA1p2Ldz9agNSOoi5S+Gw0qhfmLyPCgQpZ3wEw8gUlYdBiJMsdy/qjx+0mNJidRlOKXRLvfHQN76OEBu7MU=
X-Gm-Message-State: AOJu0YyuuVSVrVFZfc1SHBA1cMaiSQV91oxCT+6a0b8lhI09/W0KwOWH
 aBCL/8uV6suMD4gO+wNlwvTATNgNiGs7H4kdXM1NPfmapXKeXIPyHWFc//M1+gY=
X-Google-Smtp-Source: AGHT+IEAIhjEXL2uuGEfasIKf6c2morFmb1zFYf5qZ5CC1PMDhCB/+rZ76Zf18Fd2DmOafTjAzXAKw==
X-Received: by 2002:a05:6a00:2d89:b0:6e4:8d1d:7770 with SMTP id
 fb9-20020a056a002d8900b006e48d1d7770mr4064930pfb.3.1708548529611; 
 Wed, 21 Feb 2024 12:48:49 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 r12-20020aa78b8c000000b006e3a9bdeb99sm8139133pfd.40.2024.02.21.12.48.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 12:48:49 -0800 (PST)
Message-ID: <6f6969ae-a98d-4215-9893-f9a1e3152963@linaro.org>
Date: Wed, 21 Feb 2024 10:48:45 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 15/22] hw/intc/arm_gicv3_redist: Implement
 GICR_INMIR0
Content-Language: en-US
To: Jinjie Ruan <ruanjinjie@huawei.com>, peter.maydell@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20240221130823.677762-1-ruanjinjie@huawei.com>
 <20240221130823.677762-16-ruanjinjie@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240221130823.677762-16-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 2/21/24 03:08, Jinjie Ruan via wrote:
> +        gicr_write_bitmap_reg(cs, attrs, &cs->gicr_isuperprio, value);

Where is gicr_isuperprio defined?
Ah, incorrect patch splitting and ordering -- introduced in patch 19.


r~


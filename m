Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E50E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuUN-0006aD-ME; Wed, 18 Dec 2024 08:53:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNuUE-0006US-0k
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:53:15 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNuUC-0000Le-HU
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:53:13 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-385f06d0c8eso3358951f8f.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734529990; x=1735134790; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rgYXvUecZM+Py6NjO1tKQt0hkpSQ+EMRzVvsnCAoock=;
 b=vXqlPotSXMscJvkrCZ3E4biEtLHZ0DAOUzHltnP6/QoLtzL+qv1O0nOVix2wPQ3wKD
 vk5pYRSQfFb7yD08IvWBYHOfJcfpk7AFyr8Tf37XmHD+4EivngvUWZ9sxHsRmZ8wLMzm
 TFTKWF6GwvwUwAK8igzRDPXS/ZZKsLk0ASHPhV8E2P5hkaGf1rTl/tFuh8Xk1Kk+76xt
 9yNvCt6B5Eh5szHlGxHyQu0kswzr/Mxuo17+diDhc5tFXV6YvnTy7ZqPSUznWNpwmttu
 9yvC2840nnKEbvTHb7JVAU8ZwGbl+xI4oo/1gylybJMqOsMgU0KHhJruKH90W7QQ8NRs
 OMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529990; x=1735134790;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rgYXvUecZM+Py6NjO1tKQt0hkpSQ+EMRzVvsnCAoock=;
 b=JTXgJ2cL+z3Mws+r6my+AP/hLIeKp8Yo9rPiY0y2vh+V/SXwnQGKXOc2mu0RSwTC3J
 DSZZ90EnnlPDOJQ+bRZmRwXn8JMARcEguIYfrC0+gTBR0u+wyMs9fNQqI3IFvYOkBjku
 ygX5RvXpAq+6w5gXs8uKoqQZh8Vv8FWFJAv5DxR4DeCzQxycvB074pTmqll/KzpaDf0i
 7tHTSXaycebFf3dN3xy5qpUT7rixpyDID7yjeE/Wpb6U0sPzitfJoposq3A9qgBo3NwY
 dfq4jCPaAh5bscZa/NFyXcR0kiPmJsDX/PItHvAJ+EnyXaAVMpNlF+G6IldMY8ExqQaX
 EF3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBZIvr3GpTTnMhscMOnslQO8anDzETekd853pd53FHwB3txLkQzmFKrYMNAGSbeD//xP8fHd/K0rPz@nongnu.org
X-Gm-Message-State: AOJu0YyR5/Yz6Wc1EftNMbFEPHNwF95yBrUiqkrhMC4v98YJlKnQgCYN
 I4J90L39nzamdGoV/Hzclsv51B7gSWExl4QYa7/1CMSNxxqNmLo67LR8d8lim54=
X-Gm-Gg: ASbGncsHSDKKIBX13/JZG3JVnymnec/zkpId/bhn6S4WgsHpxhaXXj5TGjc/WiCoOVD
 pQnwYvgBanS8HikxCZ4SZSUp4b7urEx00m8Uwm0rvyL7ITI2BP3dbtl4VfLF1csla3q2tAej8aR
 J77Lr3GwR2z8ENsj2HQF+wN0+Yhex+R724naK1IXYEgQzDxeln4PTNKWLJavTLaboSIuYw7Tdtt
 oFyJfBWYLxu1qVtQWin0H/lAbh+8OeFsUIfuv5rEMy9SHD7Uzx61g9gLOiPPR7KGKC9EQNP
X-Google-Smtp-Source: AGHT+IHXVCjTjMYsSSA8v5V8lPNrMi+YYPbxaL5G+ew3qpzapHZgRuyGcjOXWX2dVYef+9nkTGWfXw==
X-Received: by 2002:a5d:64eb:0:b0:385:e5d6:130c with SMTP id
 ffacd0b85a97d-388e4db7edamr3197035f8f.51.1734529989887; 
 Wed, 18 Dec 2024 05:53:09 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8060862sm13931153f8f.100.2024.12.18.05.53.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 05:53:09 -0800 (PST)
Message-ID: <884e01d5-f32e-4995-832d-546c21e04463@linaro.org>
Date: Wed, 18 Dec 2024 14:53:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/24] hw/core/qdev-properties: Constify Property
 argument to PropertyInfo.print
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20241218134251.4724-1-richard.henderson@linaro.org>
 <20241218134251.4724-24-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241218134251.4724-24-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 18/12/24 14:42, Richard Henderson wrote:
> This logically should have accompanied d36f165d952 which
> allowed const Property to be registered.
> 
> There is exactly one instance of this method: print_pci_devfn.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/qdev-properties.h     | 2 +-
>   hw/core/qdev-properties-system.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



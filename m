Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CAF3C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 02:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpeUD-0000uU-Je; Tue, 04 Mar 2025 21:27:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tpeUB-0000oy-FC
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 21:27:51 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tpeU9-0000MR-E1
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 21:27:50 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2235189adaeso6772415ad.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 18:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741141666; x=1741746466; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x6qzhv1QG/pHgenmeZm3BgPjzHstBT+EOkqJHPZ7+Js=;
 b=eHIXPXvoBfgLPmKytIV1D1sLlUHWGLELq/nLQG92Da04LInxbxcg4ROrASmH0PH/SG
 U7B9EGaSXhXV+SosT2cDf3WlL+z7sgcubLoStZLZQnmjv7vgu2oqJUWc4I+M90eCCDeD
 O3q8158dS8pxOghTTnk+fk2HBP2NSnoD0PEePdaJN0yqOKdIheG+OIbZR5pAU6HCmsgF
 0Y4SLYbmkAnzvNjo8KHem00ubZd/Y7BLumxQMcurEO2AafM6ucuGLw+HJGR3MHnYt7m0
 pYcXYGaowy4cddEL0Yp2RuyGTG54gkkBbDbBAWvlAV2+cZnmCxnomYioOWQ9gOhzmY4y
 L7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741141666; x=1741746466;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x6qzhv1QG/pHgenmeZm3BgPjzHstBT+EOkqJHPZ7+Js=;
 b=B3eiZOpHfkPH+wdznaEEtTx9wwmXr7SSCm3penXc9iH/H27/V+7F0uKzGUAB/pRvjq
 2mtp/LuZdJh8DuvWCd/c52/WCOaxVKrOCVtPSrFGM4/Gw8wOyxEB2FeBjAbCP0qU/Nns
 35LpXfFrFeEp5duCJW9axRYvaQO5DG0XncJaH7m8vMvZirERujxjMeFVV/SyMhcBrMmJ
 uFzmeVL0P553dJCjTKowsW/H0E3QV708G50DddxguJ0/g3NDVpXDE5zCnqUFAt/A851m
 2nhDU10qcCDAiRZJqguvF5MJsuERCpT4CG2GZli/2viQ84MyGKUSCagvLoJc7/KZxY6o
 kFcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgfMHnDZh62ooO4DDt+Apri2HlkL6v9TbwB0bKviChj/9ohSJexEyuB03CDZGb5xjeSFW44kQiBGnK@nongnu.org
X-Gm-Message-State: AOJu0YyQIUg2bSRklNynAO/C1SDSkR/T00K9+apO3ShrrMTMlLY3+wOX
 mLqKeZtJw7VIoDCD8eKeBzs0t/2tOV2i82SpLMYkiEL20b+J6Q0BkraHO0S7Qn4=
X-Gm-Gg: ASbGnctv2HoVuGOvbcZeB/k7vxLAqpOax6D8+4SZABxOen/Gc1rv6JT+mRxqDfMHwfZ
 oGfOCUKW7c2BKS1Foxo6sRzz892uodmkpFpOF1FIFyNOu7crH2c1DXpkiM+GoPd3u24ubMcm5v1
 n3mYDC2m86KX4mC8nSuU6RASRRqAmOLgUCZ+uold1fmZdpLI9eeSrzmHvcuQmbGpFwgXFpvbuY0
 caLozuPqirl2NKZZmhipwjMoeE4RRRWK2jv6SWXU/mWfaBW9ycV1guBemTOQWrzCbm/rrsjfepb
 vZD+C0Kc+IkFw7ffA4ttVCd6GfpreSAFfPVv5miMV7nEKaZS20Ut3n4rM/BwcsthvsgsR05Khml
 XV+lxFhzp
X-Google-Smtp-Source: AGHT+IGrgKtm3xwGRJH+VWHJ9AJGDCmEMSE/zJKwg24sgcNTf7NMAsz7dDwdt+eP8kdGOqZBeUQJAQ==
X-Received: by 2002:a17:902:d485:b0:223:3eed:f680 with SMTP id
 d9443c01a7336-223d978ef21mr87499235ad.18.1741141660484; 
 Tue, 04 Mar 2025 18:27:40 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4d457cd0sm176424a91.0.2025.03.04.18.27.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 18:27:40 -0800 (PST)
Message-ID: <3ed35539-db92-41e2-8ec6-dbae613cd377@linaro.org>
Date: Tue, 4 Mar 2025 18:27:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/11] system: Introduce QemuArchBit enum
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250305005225.95051-1-philmd@linaro.org>
 <20250305005225.95051-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250305005225.95051-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 3/4/25 16:52, Philippe Mathieu-Daudé wrote:
> Declare QEMU_ARCH_BIT_$target as QemuArchBit enum.
> Use them to declare QEMU_ARCH_$target bitmasks.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   meson.build                |  4 +--
>   include/system/arch_init.h | 65 +++++++++++++++++++++++++-------------
>   system/arch_init.c         |  2 +-
>   3 files changed, 46 insertions(+), 25 deletions(-)

If we ignore the array index in patch 10, is there any other reason for this?


r~


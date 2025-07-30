Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C30AC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 05:55:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugzm0-0006Mp-B7; Wed, 30 Jul 2025 01:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugzls-0006Iw-CN
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 01:54:36 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ugzlp-0005i3-Ht
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 01:54:35 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-74b27c1481bso331464b3a.2
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 22:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753854872; x=1754459672; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GhWcelKHFcFIW7nydpsEUwcO0pd8gUHpkm2J9XecMxQ=;
 b=vwyALeNu2mc2/6WshFnFzjUEts9GLPCRbMaU/XtOWh4kyj+zZACPt4aBnAamEHftuA
 chJyRqPF8xsYAijq1qq2k9HIaqvjQIsatwnXBZ5v0Rp3VVuRz1l4ppZDMRB6Nr0t4jsk
 nthhw9Q5xxKQ6v07yaLiwe+K2epqncOOaM80SiZ8ECCenzmy4lV0C9flsnIrVwBPFOIO
 W1PdGSqb+7kLgUs/0Cp5SOrnYCxHXqBwb7zdkD4H4TwmV4Zx6M7/k4Uj1sx840xcYgrp
 BTmqXi278ftzW58g3EPC5iv7wGH0NcNwMFSP1laOJ6HJw4tX9k/LTfuz1Jpo8DbIHv1G
 mZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753854872; x=1754459672;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GhWcelKHFcFIW7nydpsEUwcO0pd8gUHpkm2J9XecMxQ=;
 b=stC31es/lfNfBi3KSRS4UcTOG3/0K+3gWbF1/+GRXTlDuyocqL58tyN7jNa06F1ckp
 frcabtr0ZzQSR5Oeon8zKudHGuljffYZVfN5JoKjx2c1bS4XQMHsKIKnsSalr9xh+eI0
 1gJsq81NPJxtvBKw4r5Vogv7gX9B0Ie53f6K5ZIYwACre5i2vTcdlcpeaJAb9550a0wn
 8OEsXwxArVKH5MmPBodIjzdF5J7nzaCoNv3rIUmjtjBgWkL64rwBg8sBbop+R4G2V91E
 rqGQok07gMQoCO/bXdY/Gcxf/lOdUV7VZn/sIZoIBXYPZpR8ZYyA7pVSLE/7vLYL7Lck
 et4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk1NJOcx3XWjuQ0pKcBO9xmwOIGLU1QRiYKB5dA/kE3UU03ErrUOAffytgMsIQWEngce4xwyGMIx5R@nongnu.org
X-Gm-Message-State: AOJu0YxMEpKaP6hYP8yxzresbm9KB7HX6TavqURJHt5HGDjvQjF/uk1O
 lXUaMl9+YeOuJ0RmYB6w8fMGIOtk9HVx/ce6HiInpMRRNYGtiC67JG4p72rpvTDukTw=
X-Gm-Gg: ASbGnctc2D7Tiv/haYrz6RuOHEMiByIII+IGiF4pPfR0q3meiFR9Ae8n5RGtLtO7wF5
 kaiyoCe/ndB02TySOaqlqElNoP+dhB9xwshf2VGDCcb4qLbcWH2vqH4DfJhhqv7e1ulpL312wQH
 C2GCp4SZ//88hcPgX8U1yHKLhUZz6B6XHM75nli9X7RPfN2BDqzhYveQbVSLNz3W9y/QCiuV025
 wcSVd0Ma/Kr6OmDbam3jm+kEz6vYFxh18tE+JC+lBgMC6q0TOSU99nqfSezroUz9/LHm8/Zv8gc
 wloEJfsHXAcvgtrRDKwimVUAifo7qteC0VwkFMNKxz0Rz1cAUJtqVKKxey7sumd3ChzGkKZq2Fa
 yOU3atsm9xOjtCC1PvoypGdWSk2/pXNTIVgKFU08XIhJFMMD4x/XUBzpG/RfKAAHFzCoeo7QCA6
 Y9FQ==
X-Google-Smtp-Source: AGHT+IFiNetCn2bH/t10PZngwTpkTJAiG97WzJyM6vCYkQqXcl+h/R4yKeCysJcwYIWPIDLaBgUO+Q==
X-Received: by 2002:a05:6a20:12d1:b0:21f:a6c9:34d with SMTP id
 adf61e73a8af0-23dc0cf620fmr3101206637.1.1753854871451; 
 Tue, 29 Jul 2025 22:54:31 -0700 (PDT)
Received: from [192.168.4.112] (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640adfe5f3sm9629002b3a.78.2025.07.29.22.54.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 22:54:30 -0700 (PDT)
Message-ID: <dcb76043-a59a-4e2b-b960-2c0541241bfe@linaro.org>
Date: Tue, 29 Jul 2025 19:54:28 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/19] target/loongarch: Use MMUAccessType in
 loongarch_map_tlb_entry()
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250730030202.3425934-1-maobibo@loongson.cn>
 <20250730030202.3425934-8-maobibo@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250730030202.3425934-8-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 7/29/25 17:01, Bibo Mao wrote:
> Enum type MMUAccessType is used in function loongarch_map_tlb_entry()
> rather than int type, and keep consistent with its caller function.
> 
> Signed-off-by: Bibo Mao<maobibo@loongson.cn>
> ---
>   target/loongarch/tcg/tlb_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


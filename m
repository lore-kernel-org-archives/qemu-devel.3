Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A02FC3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 18:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC0y2-00067K-Ul; Mon, 05 May 2025 14:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC0y0-00065h-Mo
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:55:04 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC0xy-0007Vy-QQ
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:55:04 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2241053582dso72186145ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 11:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746471301; x=1747076101; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2tArViPRB1GJjy/q5BtW0DqhJ4z03XY+HqCT81/fRSs=;
 b=GJYvEK6FO7v6b7MrwwOcHdqpGaXJT+beloEJHVN+znCiNCYXORhyWKCiKQrAmyjWhn
 ZfnAh01OiPrxcxm0TP5/Kv2lnhiI1ICE3afy6NlfYAOn4JvOPsQBC2NFkPQTmNPJCYS5
 oPJb21T7OFj2Jk2CUL5Y0MLKFa+vMqKscbbO7CvSvJ037+L3uGm9s45wDWNxOk2rI1x7
 Vy6xcvPucpNbmrzdZ01X6RbHEnEqSW3IM1lIUWDGhYXAYcq0farGMSjMLWVmRDrwUmnz
 Yu1zZvdloVJiN0Lr8knhdi3Ox23uwYBFZLtU5Gs98IIhNb2KZsxGJDpQgkYS6Ke3Ybci
 vYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746471301; x=1747076101;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2tArViPRB1GJjy/q5BtW0DqhJ4z03XY+HqCT81/fRSs=;
 b=fnO3FFH40lXAnJqygVPIXh48z6pXp4Jh7aaVQQ3ifyVcCmrIiyZnN4FYxUsC87aLYa
 jtp+vjyqYpI0fEzkQLLP//b0eh+d/Gp9QSd6cicWjO+nPJEWsTpufVVC7ECln5cjw4hp
 c1zuHPfdyqeRD9fMYFyjpiQ69d+shiWDrd3Z9w9c9MtglJ/OcRj0jISk6JIE/78w1b/k
 0BaFBGZldNM0a8w6CKjAIqHPTuFwBejHqvMiuDTeWE6uMVofpbBPbo3jLAD8g1kgk/oi
 5iUu37PAk3KFuHaPLcV3udej/1KnQCV6eLktSZMxzBAskTsdJatX55QtfldLBLoQdlkk
 lYDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0OQZUHH2d4pd+dndXfNgeenWS5zv9RJFRrUbwyClPDkylV3GjsVVin4Rc/IWIMU5xZkMhVQJ8iq54@nongnu.org
X-Gm-Message-State: AOJu0YzP7YLdExSS+9IyO33iPL9vdgtOa/cDVKuZuLJJiKX18u9MV68D
 TUq5eamCrvfgKyeNjZNIT+/aUShbT06lCuBpQ2XX2jpK+NKMDZORJm+J5pKxzPU=
X-Gm-Gg: ASbGnctLO/ddgcsia7XcJKGPSjYDruVokniCNhWD53jXyl2DQ6vQDqKF8CtpdCBB+Up
 OgWyypjKSt+zQeKbi77IQn8WZlKlm84Eo71vSLxPbtNSY++YK7ajtEqiU0dETOboVgKNVXoauDN
 cjUrqEllmYFU1GMnPgG5ja8jL0pu/1yEFfGLTwKArDFGW6bOpZfg2ZyS/f7/FZ5+cnVcRSgEve/
 5CJDxNSxcaKt0IXVvliZMvwH0+DNI9cnrAEGM0deDZFB836bWyBTdfUl7y433JElTcy1HRq6ZUA
 WYHdvNypvNLITaXxNz2Q5ig2pcSuuXEM8V7gNloz/MZALuum2JsguWl80vmadLq8uyJv47mgNCw
 u4CFR5FQ=
X-Google-Smtp-Source: AGHT+IG4lDQTWqhb76vcNURL+Gt2usSacxFfYEmKrIk9koaQo2PtFh9GptOwkZFky9BYmlZUsaJOCQ==
X-Received: by 2002:a17:902:f64c:b0:21f:f3d:d533 with SMTP id
 d9443c01a7336-22e328a0c59mr7282395ad.2.1746471301306; 
 Mon, 05 May 2025 11:55:01 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522911bsm58473495ad.191.2025.05.05.11.55.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 11:55:00 -0700 (PDT)
Message-ID: <e8eee40f-3785-4816-b96a-af022b3031b1@linaro.org>
Date: Mon, 5 May 2025 11:54:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 47/48] target/arm/tcg/arith_helper: compile file twice
 (system, user)
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
 <20250505015223.3895275-48-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250505015223.3895275-48-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 5/4/25 18:52, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/arith_helper.c | 4 +++-
>   target/arm/tcg/meson.build    | 3 ++-
>   2 files changed, 5 insertions(+), 2 deletions(-)

This one doesn't use CPUARMState, so we can probably drop the cpu.h include, and thus 
always build once.

r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D36AC83F26
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 20:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhDjF-0001SP-GR; Wed, 30 Jul 2025 16:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDON-0003ap-KS
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:27:15 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhDOL-00046V-Vb
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 16:27:15 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-313154270bbso312532a91.2
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 13:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753907232; x=1754512032; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ydqOzYMSiTHrp0lzxlkXWJp5kp4/hOFIM1kFanwyZso=;
 b=LPV61eS4GJWJfJ1YICn/K3ggjCsBgSmuoVvExrBS+QzAbeCVfwe+JoRUDi7XhU5d6c
 fvIEOKbj09HOH5IwpgEoHNSCrkFxz1RUXD7drh0PNx3KEDe+ibw4aMZ3WtnGj7c9fQbr
 ElxP2nbxn2XToUj8BKmz5baiMZwHdu+aHhCG8oFkDlSG28+FweVfqhRwMogwlBCf/0ba
 fzbrHOUQysyVLsR9dOScCOBzgkUIGh3ygbf/0klAUiWRJTP1JFasawL4xqqRh1yFtQ+z
 BRmwlmDGWUXwzAwnrZIqv9NXs2xz3oSBaCUaRmLMN5ClkyVpb5oo9MAmY46HXFqoo6B0
 msIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753907232; x=1754512032;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ydqOzYMSiTHrp0lzxlkXWJp5kp4/hOFIM1kFanwyZso=;
 b=smA8QESNOZGWMFhyPhxiJVyduGHhIAmuzuUSKUElRvYh5xSFFmLiriTMn4SSCjhjfc
 Qaore2XCEYnQSdehzHJvmZeBN7YTGgHUIf5wfgjqFSdptlY1KlZSjPSdLaIKBX8VIOej
 rrJAY5Y0gWi8vtXRlK942KKDAFY3R2btncP+bGsZR1fQdg3QVTaPJ+nSMATg8q4xYWG4
 Q3hpgGZSQOXIQNCtMJeNr+tLwxRzSccJxWbXFNqSxSq6VphL2+j+2kbjDUBrBgND4fww
 aOMExleW93UEtJy1xoUEtv3VrpZT9KxLUVcKcsyJKJqPFxlDbsDkLPzsxJlGORUGK/g8
 fogg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRNPwAsH3e5zVay67u1Z4TwEkMcDKwCt+L0cydQqlZvhwg8iB52oIa37js19jOf2+3JTjQq4EgvtJS@nongnu.org
X-Gm-Message-State: AOJu0YxbLuKO3ghcUZAhDhgQYFM49IgcfhWAep6EdRZFXiU+Zu/WC63l
 JtKh8ZEp6sCnGN3zYgEitIN2Y58R4DTage9+1BT2MuobwKJ7GJx5iFO7Mv1XxbJvhMQ=
X-Gm-Gg: ASbGnctoGd6POvD/iT184LtAnG2xTFn3WB10t9tS9un9u2klYmjwTF3tPa2wan5JIp1
 OaXmEC5LjZ271/tNEN4PrfBTTQKzn/R9M2MwuHJZ1UTyGzIEqV404CsAWROozg3RTJZhhzhEWR1
 9d7gIB+mkmM/mfThcpPi6sW0Iteq4FEBARrlw17nOtt9XO+h2AfmtI9vJeukWOmxSjmDugOrSLg
 qO5jNeHczHMbupfHtxlOVWw/wQAlOsIZKsf4PTlJSVsx3vWlJ5fjY3k4B+YsFWW/l7hEXDfm4XP
 CreB+WCFqWLj3FX9nZd0Zw4rsPhhU+T0TxhpwFQL+HnKTdv+MyjxG3/CySgUfVLP38EJLPIJb/W
 Nkp1flfP5SnTTeefCTpPSp5KmpQHdk5MI3nc=
X-Google-Smtp-Source: AGHT+IFHWGyAfmwFkwcWa01z05pk4zj6sQJlEBLGOegfOMd58w/BdPtC8nsuNPYB+iv6U/nRLYaP/w==
X-Received: by 2002:a17:90a:dfc6:b0:313:1e60:584e with SMTP id
 98e67ed59e1d1-31f5dde8749mr6024408a91.9.1753907232251; 
 Wed, 30 Jul 2025 13:27:12 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3207eca6e9asm27898a91.18.2025.07.30.13.27.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jul 2025 13:27:11 -0700 (PDT)
Message-ID: <68054553-a60e-4e10-a32e-322395691201@linaro.org>
Date: Wed, 30 Jul 2025 13:27:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/82] target/arm: Add prot_check parameter to
 pmsav8_mpu_lookup
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-2-richard.henderson@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
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

On 7/27/25 1:01 AM, Richard Henderson wrote:
> Separate the access_type from the protection check.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/internals.h    |  5 +++--
>   target/arm/ptw.c          | 11 ++++++-----
>   target/arm/tcg/m_helper.c |  4 ++--
>   3 files changed, 11 insertions(+), 9 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>



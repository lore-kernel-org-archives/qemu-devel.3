Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A023AC83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 17:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZuwZ-0006Bf-W5; Thu, 10 Jul 2025 13:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZuXM-0003zN-HR
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:54:23 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uZuXK-0004mB-Tj
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 12:54:20 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4067ac8f6cdso750260b6e.2
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 09:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752166457; x=1752771257; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hJa+dfx0FhCZ0oSO3ILPk/P2Hx7kikYQEZnDI/5C/6w=;
 b=Z6XQVsz29z7+QttO6vj7Xez3mCKtKSPvQvyR1weGsgGFwyLFDHUiq7UsZEcBz2tiBI
 EzioCfvlB9p5nDIRfL5txsk28QHtDw6tbIHVdm3m9jC2Yhc7eAMJ5FMl+8FdXcm2rZEu
 c8D6fhvnAGXCtTfLudOpRFKeX5tzy+rfHKzYa0h0AT25RPxPMQWMbKq+WFdTB03GH6bp
 D3M+XAtbVomjxjeUZnuf4NiqUolpGLJ4jdlsjJerIF3acPps8kdPYdgwVKqX6UCR8akx
 iUQoCH4sN3uLOLykMPpKi3HynCJAkfLEI2ph9WUDmHKK1Q2Ctlj4uc7uPztuoamtmyUJ
 zQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752166457; x=1752771257;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hJa+dfx0FhCZ0oSO3ILPk/P2Hx7kikYQEZnDI/5C/6w=;
 b=wcLnxgZS6dLhAK9tWF1LECfmlPrThgClxVos+48zgoSdW8//iEEZavC5HKRxcyOGKK
 1wpILHS51SijpSEEumQuE/VMTMK2t4tfOBshmF2JmGKuaAV8fD/9UKbDaonl3g75wJ7d
 ZyebHc3i2pUTNVrWgqH7ULAwheUh6AbC5bGFJrY0K/lQSUeiYezsFTg8i2iE0Leut7cJ
 v4EZdO2ao7Zjs3K2+0iplrd4p500tVPTE6v6aW/u/qbtf48dnV6q6cq195n+RmIrQlx8
 YWo/f3TDer+3aNLiM+xDMloGsHtPzLs/uV1L4/2vBzavrvps+qwjEOO3bTX+yzv+8UCY
 IdCQ==
X-Gm-Message-State: AOJu0YyLjs6xoxWczVh5hUd9W/arIo5fWbtEp+9Fn97Tdj9XGXuHcZ6+
 AL1uJo2uxvbZ51ThItafv1kARsvXokisFIV4Y1TP3F738mMRuBkj7WCE2Ny0HoHtTlU=
X-Gm-Gg: ASbGnctB/MKAeYly/Y2NkeeoDZ8UbW5Hdl5WHujkl0m6yagvmBcjnKnU1cE1WdTqKvM
 I4RcnDRsgEJnhutKVi/NRriQzSqfhbybV4F53xS2ZokJlWd9Z92TRpAIShKQ6fOPyk7yA8ABO3v
 ANkPOcuUHlwh9j3qKZRJVLnw6ugMgBVKUWg9lm9gIok1kRNjC4dO3gZUX8yQ7zp/ogl71fyEbon
 hZGBnB2zkZkwTO8MZQDwt8UJ3I8nVQCqtPaZTVAxtutYT12g+Z0M1UJ9dm7QMXd/ZFvTFCQuvUl
 I3UhY0180WRL/68Cz0/BZpGDSZ165hwCzIjWSt/dv0zp0RNsx98OP5drfX6vHRlKUzchzix1uUA
 8T4g=
X-Google-Smtp-Source: AGHT+IG/rDNo150/OnH8Lgrpk1OGHt9kqb9g390KBeXMR75v4V2KtEntlBQB95XYWmIRx8UzbzVOzg==
X-Received: by 2002:a05:6808:300f:b0:40a:52f5:f2ad with SMTP id
 5614622812f47-4150d749172mr241663b6e.8.1752166456799; 
 Thu, 10 Jul 2025 09:54:16 -0700 (PDT)
Received: from [172.20.0.130] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-414197c52a6sm256407b6e.19.2025.07.10.09.54.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Jul 2025 09:54:16 -0700 (PDT)
Message-ID: <f256b198-6150-48a3-a97b-5f0c2cc072ce@linaro.org>
Date: Thu, 10 Jul 2025 10:54:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] target/arm: Implement FEAT_MEC cache instructions
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org
References: <20250710163858.1094780-1-gustavo.romero@linaro.org>
 <20250710163858.1094780-6-gustavo.romero@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250710163858.1094780-6-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22e.google.com
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

On 7/10/25 10:38, Gustavo Romero wrote:
> This commit implements the two cache maintenance instructions introduced
> by FEAT_MEC, DC CIPAE and DC CIGDPAE.
> 
> Because QEMU does not model the cache topology, all cache maintenance
> instructions are implemented as NOPs, hence these new instructions are
> implemented as NOPs too.
> 
> Signed-off-by: Gustavo Romero<gustavo.romero@linaro.org>
> ---
>   target/arm/helper.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


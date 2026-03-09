Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 641D3FCA16A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:52:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzem8-0005ts-UP; Mon, 09 Mar 2026 13:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzelj-0005Z5-M8
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:51:53 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzelh-0003d8-BX
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:51:50 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-439b73f4ab4so8532329f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 10:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773078706; x=1773683506; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WFm/ouylL9EFt+S8dJda/dTOGa2NJRjLHJRcJZiZz5Q=;
 b=M6jlR13zvxKBEyURI9Hd69We/+/REKd5WnCSHWBVxTo/4wenFvzKf9tYcO8vvQZHQK
 PTPCEpuHyuIWolWumK8T6aunLSsUViZhYbjbaai1fu64fXJpMLALwOCtUDfjTEtyjikv
 Hs9VLI+0xucpPsKVAgGD2n80EPy8jeWQ3Qvzh9YWRnYgSTDLLPILI1j84Vw8HMtK4eWn
 IVjHhFllknb6jcgrF40q12kvr+piXIUNxo+M4f0M4LynFrsQywUbv8WbyaTA/jXycWBN
 VfLywR1nJzgJOgChLytUoV7Jsn9P2NrM7OHP1eZX/57lEd1vgyYiZoFDeRRcSgJmoJYG
 Kplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773078706; x=1773683506;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WFm/ouylL9EFt+S8dJda/dTOGa2NJRjLHJRcJZiZz5Q=;
 b=djC+JinzHTsQNfZ75B1WJVC8zR1RwWBHCuIJwhVEooiVDtSjG/p48Nw6W7s5sv7UXn
 48lGcFWJzvMYedqRgDMnSmPcnkEHf7EEZmsNL0FNOiQMAxeFkhk+yVYCBOi6/4S50gZM
 0Xsk7Jual5CmX/rUALBbNbsIyb6I+gkwYY4k8+fPlsjlXER26vlLdIXtnJ40baWIZwcX
 BBR+kTFBzltLchdnkEjg4/OGxFg8+NEN+SAqWkiEyhi8j/dhNYGqqukr/wbANGVsx5GB
 FQJFQ0oK5pJmdna+agcbHVKBSUz/3UC98Mubt0+XwkNhvd1YDD03ZBEPfpk3WAjMO69b
 fw1g==
X-Gm-Message-State: AOJu0Yzuof0Ws0IaFC+sC8rf7S8GiSS1lR8f1hbkGcEGihU/5aavG4F1
 iU90B4hynoVogmr4o6ETQ4EfQr1W0Fsbh0iCt/pYbCaXEo6AJXZwwPdsKMPnaWFVT2DUTMZHAMn
 8YHSdRS4=
X-Gm-Gg: ATEYQzwuKGAty2rdDOXlUkOHkHbaN5DK89rZNOelC3c5ZhYEQIGP/M93fB6+ZsZ/YtL
 ri6OMbmUe7R6kEmve9M4PjQ5Rshpqbo+kVQfRCj7o5eH7fnLSCnZhIpqXBFV1xrZiZWJh44V8x5
 vbDI8rFM/byRhGCOX5gedFPKp8HSc+TJ3Qz2oJqu8rwJ0fW2IXfC0+aCz5PPwJNhnWvIpVFEz3H
 dDz3/TdXFfILmKRrq786/BWWdxs9rEj6V1+XElTBTilWBNyw/Bex5AEZiGw9QVtduOA88L5zohq
 5MSH5DyhtXVccwxKqr7j046RR+6XJ3e3+8zUv4NUiG5zZpPI2FrCo1ILvJuPTRIwTlp4/ImqTrJ
 hzTr6lwu11L1S5tF6JVoYIpVVhBMsACuu/YKs52HQ/EE/y6siVsOmeISgV/oWu0iGxo6sUI3t85
 JPyXtFVbwwZw3AoYeX5KNApvLrFdqpR+N9l2emrXPYmPle28cBOWg8ofdNBMN4tm3FMA==
X-Received: by 2002:a05:6000:2881:b0:437:711c:8754 with SMTP id
 ffacd0b85a97d-439da55541cmr22138690f8f.7.1773078706035; 
 Mon, 09 Mar 2026 10:51:46 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae2b9fbsm28995130f8f.23.2026.03.09.10.51.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 10:51:45 -0700 (PDT)
Message-ID: <da603699-30e2-44e9-b117-ffbf0ae7833a@linaro.org>
Date: Mon, 9 Mar 2026 18:51:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/qtest: Build once as common object
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260225053408.18426-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260225053408.18426-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 25/2/26 06:34, Philippe Mathieu-Daudé wrote:
> No code within qtest.c uses target-specific knowledge:
> build it once as target-agnostic common unit.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   meson.build             | 3 ---
>   accel/qtest/meson.build | 5 ++++-
>   2 files changed, 4 insertions(+), 4 deletions(-)

Patch queued, thanks.


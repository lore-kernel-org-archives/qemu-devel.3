Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F14CC48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rafqw-0001iU-Ki; Thu, 15 Feb 2024 12:48:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rafqu-0001hs-EV
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:48:52 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rafqt-0007ih-2R
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:48:52 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-411e5f21c0bso9989915e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708019329; x=1708624129; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1tJGkLJajediyBQXb+bJ7Hi0C5Iq9zq2K/zAa04jujo=;
 b=wHWjFaaETSUxvosupmor1SEhNaBc5blBWpnLqzspPR4oGI7mB3yss0m++vk6x3fzbh
 +6Cp98PbKntZLrzbAKgmNsUdNTmEpS6rKe2lWldbEGSPFnDg+Mx9b7zNCUK8UK+PPLYk
 u3DsFl+g3rzGybdq3FeAvRXwFXQ6Vn3dDc6WypgBBnFE8wuNZLEB4j0Nq+5xBE8ScoNd
 YAsEddNh5NmcG88qEVPukmXeXJmldRYY7mE0TCsweAh7NqhKfgk3HfuZStXPZFH6Qegi
 CU3BKfzmfJqPe3BpENj+E1F2QfJcM8eddhM5HgPw9wKjl1T08LwsH8z/28qDetAXCdsg
 MCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708019329; x=1708624129;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1tJGkLJajediyBQXb+bJ7Hi0C5Iq9zq2K/zAa04jujo=;
 b=N3KuGtPhiiYFIkpPaaSgjQlgPZ3JUk9VqRbPs61mHF3uVJDgLGNphun8pns0cfyI0G
 D98dRLLR7CERnIACyDbj2i3Dn7DFrlQYba7YI6eNk5pYFzEQV1ypRZnjcVU6emjxAa9X
 6hKqyBEfhIzPiIdDVbRYww9Z21+0gmfYmMlIqkv42BGbUUkGhw+85jV2PkT2C3qZsWQZ
 UJxc4B4dtNYvjLh49tdKi6j1cpr0HtMITE9IKsTZPqOSg2b9j0s39ByBlZok4m7xJKQ1
 bFPdoVO10HkiZ470dyVkxoVJFSTnAAjyv1DvHgABV8vd/Rj03uydYqLsLBOrlenkrvkG
 t/fw==
X-Gm-Message-State: AOJu0YwI1kAp4HtVYNeskgKf9RBh5wvcOJCsZSou4+a9AahZrBzSD+Bi
 kJQscYs5KwtO767fOHVCK5n5dJeUZTB0oaDWt8j3nAjGnps0PoZfOje5ajNVuQe3dQdqz8v+xfg
 l0fI=
X-Google-Smtp-Source: AGHT+IHkYRtwkXanbR55lom50MOCCXbhjyEcsP10EkPsA6FwV5FPaP6+B1+dtSUAS19ekcqA47TQsA==
X-Received: by 2002:a5d:6a08:0:b0:33c:d5a7:4fc with SMTP id
 m8-20020a5d6a08000000b0033cd5a704fcmr1854170wru.16.1708019329221; 
 Thu, 15 Feb 2024 09:48:49 -0800 (PST)
Received: from [192.168.69.100] ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 ex7-20020a056000248700b0033b8305ffe2sm2546489wrb.87.2024.02.15.09.48.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 09:48:48 -0800 (PST)
Message-ID: <5fe70a78-2ac9-485a-bf25-c8a1be7dfe51@linaro.org>
Date: Thu, 15 Feb 2024 18:48:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] hw/sparc/leon3: Strengthen SysBus & QBus API
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20240215144623.76233-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240215144623.76233-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 15/2/24 15:46, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (3):
>    hw/sparc/leon3: Pass DeviceState opaque argument to leon3_set_pil_in()
>    hw/sparc/leon3: Pass DeviceState opaque argument to leon3_start_cpu()
>    hw/sparc/leon3: Initialize GPIO before realizing CPU devices

Thanks, series queued.


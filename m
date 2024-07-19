Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBC0C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 13:07:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUnJh-0004HJ-Ai; Fri, 19 Jul 2024 09:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUnJf-0004AF-Qs
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 09:06:31 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUnJc-0002gS-62
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 09:06:31 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4279ca8af51so12707475e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 06:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721394386; x=1721999186; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EQ9NrS5uvl6hxfJV7Mcnt+ZMhNb7UVI+j7+b20P37lQ=;
 b=JUbbNefwHBr9rLM1atB0jmSoeW/d8kdnXwmmLLQkgJ/Lp8Z4xEoqAQCC592nJtYf9F
 KzwxFO2G8j81VmLGy7Rr9tQsosGLroxPrA3Yyt6PVkpHoyApvkEE+7DyI/1zcisc9XLr
 gtdKmvs0OFEO12b9Z5r8WcV6CNs0+kzmVal+9IIZE6trY0Ey/qVcek7agom7lp2wO8BW
 URV6SSR0W28znBNQ038sfopE6YzbZSn01rkx76jBn/lpe97iPJzbBLfzhtE5bP3ap+QA
 8V5c7WoRSmcwMfDiOPXAptTxuEn9In1E2Epw6jPnzuxypVEbSIaMIczv3NGkhhOCHciK
 jTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721394386; x=1721999186;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EQ9NrS5uvl6hxfJV7Mcnt+ZMhNb7UVI+j7+b20P37lQ=;
 b=m6WvOFlCt8ASHS+cWwPBxpS9S4xzqa+gyxxTu/pZo8KCHGztg62YWgHRRYor0sKfco
 UEFZhVMosWikPSPoijD9hig9eEhRuhD73pLjylMQHy60pYeq/EakPMANyz1PoGP9Br6y
 Knlj/rCAp2ADrHt+M+70xkz99R+gjzZ0AjFbVDSJxVaCw3UfetVbSiZ/8AD0IOkzJ/jB
 Li+PSKuPCYpM0U939Q3DqkfZqMT8BIcfjqGFPRgLvLq1da1LYk+wTcbiOU81gBWXmDQo
 9lv26zPAebxGJewfVZVE3atpr831niq/KNWXrrNxGK/6huNJ/2tnoYPTtxGOixH3Uj77
 vt2w==
X-Gm-Message-State: AOJu0YwgUN00xanmbsnsa5LToT5RlTWU8FuQL4FryWk874wMuaKnba0Y
 HCQoKnJ7nulVDE2tXv3Taxl+8osVpGG8uGT1+T6MuFN2/kMsG8+PcczlmadaOFg=
X-Google-Smtp-Source: AGHT+IEGFn5FDEEr74akEl5y8Q+NdWA8czQkz7K5yNvH8HWqmGll2UJBnaEE5zdOQtHibXX/BYB1vA==
X-Received: by 2002:a05:600c:3152:b0:426:6e86:f82 with SMTP id
 5b1f17b1804b1-427c2ce7bedmr54385575e9.22.1721394386388; 
 Fri, 19 Jul 2024 06:06:26 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a721b7sm49917835e9.27.2024.07.19.06.06.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jul 2024 06:06:25 -0700 (PDT)
Message-ID: <92cb9c6b-a3bf-42c1-aa4d-b49b78379666@linaro.org>
Date: Fri, 19 Jul 2024 15:06:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] docs/interop/firmware.json: scripts/qapi-gen.py
 compatibility
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>
References: <20240719-qapi-firmware-json-v6-0-c2e3de390b58@linutronix.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240719-qapi-firmware-json-v6-0-c2e3de390b58@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 19/7/24 09:37, Thomas Weißschuh wrote:

> Thomas Weißschuh (4):
>        docs/interop/firmware.json: add new enum FirmwareFormat
>        docs/interop/firmware.json: add new enum FirmwareArchitecture
>        docs/interop/firmware.json: convert "Example" section
>        docs: add test for firmware.json QAPI

Thanks, series queued!



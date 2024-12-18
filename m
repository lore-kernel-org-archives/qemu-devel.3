Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52E2E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 14:50:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNvN1-0007qQ-U6; Wed, 18 Dec 2024 09:49:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNvMg-0007iw-Hv
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 09:49:32 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNvMd-0002CG-Tq
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 09:49:30 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso63832525e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 06:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734533366; x=1735138166; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4kV0TrM5vXEjLmE4aVQ534+ohvFmNs1MBI0iT9dxc1g=;
 b=KXib3GcuspfWVrF8xmZQ5uXk27fjo+5iPTzqNzAaIwK4g6g2cgSoh5behhkh7nQDIn
 TOgjYp/EuC8NrHpOpbQn3kfSzCUhRxDe2IUXAGsBZSZjKobH5beQI76aJi5RQazLgUIq
 EPnGqyPtURLOa9Gp8N3hROPN+EQemUM6BLcYnVfpJxrXuB5Lop9ceCZzZtiux6ZRSWSv
 iaShFjOfkmVa8eDAVvD0qj0ipnxqAbYWpXqGIpNuRZUjmQFtpduZcMzRM3XUC2GDyBDM
 5GVtiiq9mYkkHtyAF01L4dNCejt3iJjXMf0coXDi+EuL1acTkwQqqxUHfMjZkxDyyslB
 C0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734533366; x=1735138166;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4kV0TrM5vXEjLmE4aVQ534+ohvFmNs1MBI0iT9dxc1g=;
 b=WYjz/0f+XOcKJpdvHUkmiXSAXG4j/JUUaqwhz5NOdVQTGSNf7zP46cnmKm3Cu+3UTf
 +7K3l/FWqBblYRF5Y4NFolDWQtPNZ+rK9xfX5CIMMsFSEtu0x7jMUaEYF8gbpnwKI9Do
 qFyrZUV9GVPKPQYG81xBbK4OxppHmqftBmDQ/aEClrDILTMek4jKp1HSB0fobCdSoQqG
 H6eoySqfoL3shY2XjbZoEwGzqdirUQ27YhJjdYtYtPh6h9OuS/c9yl6jxVZbk+vAjTx6
 WaRuUoVrwxGEI3OZ1XskT8fjrnmMQCDTdDiLzWiuAqyoC1bKr1XohEvaIHXHe6UOEfU0
 AIxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLGZ+yc6k3Dct++QRXPanSFQQn0eRqslJpkwf537O4A/KrMQ384qPbpdZ/WxG3D1Flwg30xyMBybHE@nongnu.org
X-Gm-Message-State: AOJu0YyI2igJWoaKORWAbv7QPfkFnoXY32D7KldiV/5hVQNML7IqSenA
 XCfe9bwgJC/1XracYXqnCTgv7F5GYurCcU0Rfbpj1EUTcEaSxjt5cCMd+TL5hVU=
X-Gm-Gg: ASbGnctUiYfVzL6lJA0ZsHvpuO3GUeU77S2oT3L/cvPx2/2ZwQ4mmQjUprW7nKk3O3I
 OB+iFTagFgZqOQzaVd71zS2N5N9jV0xdP2OX3jntz2mBIEDmZTpG3sXYY4VejzNtLg/oCW6geoA
 8Qj2vMv5/jjAyEPbFeUZdkimp5QqcHsU/gPZhDFLxRV4lIqTapto1z2nfX9gWl2x5IpXK3WeAAL
 mmBAvGXUH/AZoJ2sjBApZ40n9mLntQXYJTfu9b4J7TTumGKO7YBxjosc5dCq3oc338BG9uy
X-Google-Smtp-Source: AGHT+IFBRx4+vK2c46DM8pfUlmCHwxs107An27sJpE1PzAPVZFQ/oBHa3UqMV2jIqh+6YYWfDxMD9w==
X-Received: by 2002:a05:6000:1843:b0:37d:4647:154e with SMTP id
 ffacd0b85a97d-388e4d2f463mr3138723f8f.9.1734533366007; 
 Wed, 18 Dec 2024 06:49:26 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b11495sm22577465e9.19.2024.12.18.06.49.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 06:49:25 -0800 (PST)
Message-ID: <10443a91-8329-4501-96a7-9f40d9045ae8@linaro.org>
Date: Wed, 18 Dec 2024 15:49:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] rust: pl011: fix break errors and definition of Data
 struct
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
References: <20241212172209.533779-1-pbonzini@redhat.com>
 <20241212172209.533779-5-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241212172209.533779-5-pbonzini@redhat.com>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/12/24 18:22, Paolo Bonzini wrote:
> The Data struct is wrong, and does not show how bits 8-15 of DR
> are the receive status.  Fix it, and use it to fix break
> errors ("c >> 8" in the C code does not translate to
> "c.to_be_bytes()[3]").
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   rust/hw/char/pl011/src/device.rs | 15 ++++++------
>   rust/hw/char/pl011/src/lib.rs    | 41 ++++++++++++++++++++++----------
>   2 files changed, 36 insertions(+), 20 deletions(-)


>       impl ReceiveStatusErrorClear {
> +        pub fn set_from_data(&mut self, data: Data) {
> +            self.set_errors(data.errors());

It took me some time to understand where is 'c >> 8'.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +        }
> +



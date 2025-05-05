Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B953CD5BD0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 15:25:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTLYK-0004KQ-Rp; Sat, 30 May 2026 11:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTLY2-0004Gx-RQ
 for qemu-devel@nongnu.org; Sat, 30 May 2026 11:24:27 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wTLY0-0004xr-TT
 for qemu-devel@nongnu.org; Sat, 30 May 2026 11:24:26 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-45fe59255beso14615f8f.1
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 08:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780154656; x=1780759456; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0hqgiRMBKGtlNdV4BJds8dgSspVGSRdXfb8rAv6leL0=;
 b=H5BMwk4OgexdR2KlxKhCSYvWQa7ytRllv7ql3H7kBZja9aBLpL/aJToxQS8qGRqPwu
 7HzRQuyfkrmMKeHeCzJQToPdaS8slUJUIePeFRpTL0pGjyv1sdTmLBi+2pvUnJOPGara
 fz8/aX//J+zwFbG6uQ25yz6fOxyMcFsVIMQzy+og6v8i53EYe/FWIs5nxG7ThaWvDDg2
 HFa7eqIys7LR+0InKzVmWsFaopbTshY3uTT6n2DuQK1CUv8fv5YlmgdWYPmD6kv4gUko
 i5Je0eKgPoxSBTurDW/gZEaQV6nN8AEj83ZJDiWembFgHBJHYGFu0hsHTLPDH4ShHUh2
 OFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780154656; x=1780759456;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0hqgiRMBKGtlNdV4BJds8dgSspVGSRdXfb8rAv6leL0=;
 b=AspEh4tyXxx85X1uoY2Rj+phvKb8LY0er+JK3laC3X6wRuhqtz4jLxuk/ambLXHLeV
 /tQVcr9TEI3T8kWzKyI+gu+Pqbii74bkxhHMkZuJrol0zh+l2sbcgsMvJLpWNrWn5A+D
 zgkSjOyUEqk0xzRoYs8DGApoMml3A1BbaDUR8+RlLQTM1NLbXivkMmYi3Dt1l+1TGwao
 fJsNa6cOJhlpawSjmjEuomXEjTkrtUAl7+oCza5FigHnrBWYl4mcYHTD6UqN4bUhnlwe
 3qbuffIzcs+PhMY8DPUOk+rIlBkcygrQtMYi12AAKpnELOMFWEevZiNaQ8GV29vGBt15
 uMPQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ++N3VRXPRtZlwOjP1Y2cyHoi70chruousgBvrHXu1QZoujmb2kVx1oc5wKbLsSi+Dkj8Q5BtwXyLIY@nongnu.org
X-Gm-Message-State: AOJu0Ywd9aHa8BV5DNP90c8gOhqaWoTcDfRyKHUvSG4neV65z9w607XJ
 QsqfG5VYOywCLPxy6hMmdoj9ZrG6P1ntyHpCycWQ067ZjmS60rbRVZJkCXOmk+9wLZ8=
X-Gm-Gg: Acq92OExMzPBouubyWP1clr7rTfDopMniZAs2oX1x2vNMvkkhroUPng1x90CID4oXhY
 PSgwb8wJ/Djx56Y4+zMQUujQuHxhJ10wD0K7AhQkz6crjXIVWZMJwoTKyUMF3GFw7xrTH7hoR8G
 VO1FxgHrpHDCyT3ely+and9JYG6YzFRiY1q6owU5WarCUg19toHvT0szlHx6o4D0mLetzG5SSTT
 BYA2zHNXxFsdE1F8FZ2FwCURCfxORls9Bjeg4oY78R4WIMR7rCa75eC+4XQNA1QT+9Oj/X+ijIm
 UVbV8U3qPjleEXpBqBnyTgg3uq7S1KL211De6GRiUlB4wawV6V6CspOTCC3XdkJ/2D20icP0s/K
 bKX8n4VR3NkfJObnZhGguTmtTUC3MD4UlsJCkGjbqR1/45u16sppcVSsiCGp5QkmAIj8IOkXI/I
 dhmNfJm+jzG00M/uO+sb9pztTRqPUQ7JXrcGCPNyK4qh7g26gwMmD4BsNHSIkP/BqGdFqRAcno/
 920
X-Received: by 2002:a5d:6e11:0:b0:45e:f28e:a00d with SMTP id
 ffacd0b85a97d-45ef6b3aa6cmr5930135f8f.16.1780154656193; 
 Sat, 30 May 2026 08:24:16 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef34b47eesm12638888f8f.9.2026.05.30.08.24.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 May 2026 08:24:15 -0700 (PDT)
Message-ID: <69baf1f7-417b-4a57-bc72-177c7e1d85c9@linaro.org>
Date: Mon, 5 May 2025 08:49:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/acpi-build: Fix typo in function name
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, alex.bennee@linaro.org
References: <20250504215639.54860-8-gustavo.romero@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250504215639.54860-8-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 4/5/25 23:56, Gustavo Romero wrote:
> Fix missing "i" in the name of the function responsible for adding the call to
> the PCI notification method (PCNT) in the ACPI table.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   hw/i386/acpi-build.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



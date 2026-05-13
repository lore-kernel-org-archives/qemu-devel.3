Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1839FCD37B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 05:48:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN2S9-0005jm-Jh; Wed, 13 May 2026 01:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN2S7-0005jM-KA
 for qemu-devel@nongnu.org; Wed, 13 May 2026 01:48:15 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN2S6-0000kF-3e
 for qemu-devel@nongnu.org; Wed, 13 May 2026 01:48:15 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488ba840146so56411345e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 22:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778651292; x=1779256092; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wlispc1oboK7y6WJIGfibqpXoLh6mBLRTP6xZs2dQco=;
 b=T0l9Fkg9f36f52TsQJ9Dk5c7t2JixrYCEhnr32K4+LcdlqYUiuCK9c5DvfRfVA7wA/
 wXLvEeaDYcmk/dGRQMqnr7aPAIUOds6gRN9h57r3I0NuLVHxNeZFVI3Jfw3XOfV7adoI
 Tm17jUKulgY93mV5bPyp6Ci7er6DPKZ4ePUtf2ypbRX8Bx1XUm0VBev1thF16IfxYbc/
 NVL5zmNUYA3m65VNbuaOf8vE5rcEoqOHAF/arSEYhq2gxUVl9usP7qmnJrSKfMAN/I/5
 bSaPKlXRGpVtQPUShHlTVy3Cs7P0YQAgtKBbmmUNjEFaEGHj3F/08HdlIx0VjCrsXIb9
 +cyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778651292; x=1779256092;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wlispc1oboK7y6WJIGfibqpXoLh6mBLRTP6xZs2dQco=;
 b=NAZ8E6hCZRNowLCkdXBDAiFAL/wRzFcUhzzRRrtHdBhipGgvC2i0e+MwG6+QTpRrMG
 uJMit4U4kExuYl4CfXgA2o25ajlF/Uwg6WRnOiNgP8BqALehfzJ1knn6rys987/ms30E
 v0xus7x/N8ybQSUNzjyXsUNbduFnYxmsofav9cq6Q98IvWV98AJwS7GCIuH5Llyy+EX3
 iWSdMrf+IX90WkyhaqtO0KqgGlzmcSTRV0p3ErGmP+HUajy1FIxAKkyPqluyVCTxWZLc
 APB2sLozZRvi1u4RBQeXTT/iLLFRyn9avVRL1b8ai5IuSvfXD1cOQJswK7RFcRErXP2G
 DuIA==
X-Forwarded-Encrypted: i=1;
 AFNElJ94rrYb1ajhhuVDmHSTwqY1CE+kerqyUCJF1j5GnK7HE1GNQXx+1+GIG8WMtQikFxycYH8IlzzO0UBv@nongnu.org
X-Gm-Message-State: AOJu0YzfrHmwewHjee5dcC1TMUMWosK5Zp1q0HRuIpqbCRw2Pv2NMUtV
 /qcbY+4vrGGKho1VlX+AXCqRAyS3if11LTyVQAnYlNVvdjZOYa+qVdN01RJR78iHSEM=
X-Gm-Gg: Acq92OE/qMQu9HJRNe1Gn/jwlobS2e8Od8xkrhhDscUVqrSogqe3vd7iilxtuhUe7k9
 GTIIsAmJoTnlsIuA11mtSGw3Kvncyge8RzdKKPA2XCIIo2YQQD/Hk6ICkExMXLVYicghsJnHU+A
 lMsD/m1O0nPmwtbMi4XSwax2RTERglZCsRf3gbIb1+/B20zhxvTfrOEgPPn8Pykzdc18XnDMXpk
 hnd5J4KD76e9hOz//H1VPtQxL5kiTHBlX5QRLlCG6LvF4POLJLoKWq9+VLTDWjzDsOjhBOrpByK
 yPIJJAHkm1ASYAxQx3hRQ7wMHVE34Et66p+CQ91GsYjDvPSnouEs5JhOqLTEkplReQD8rZrCU7d
 jLVsy86rM8VPQuwRlE/omMWOmTBSONW/KKTo3h0baghv0x4kSJmQiOseeadZEfQ8G3ZM2CASpR6
 oJOv6fVuJA33gXAqsiPwQ3EPs/4rHFzS/Bp+kuR/4TAV5cQIcGd4QruwftvaIuOXhBL4G7AImhT
 M5w
X-Received: by 2002:a05:600c:a48:b0:485:3ff1:d5ed with SMTP id
 5b1f17b1804b1-48fc9a02522mr23102395e9.1.1778651292357; 
 Tue, 12 May 2026 22:48:12 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f40e340sm50035725e9.6.2026.05.12.22.48.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 22:48:11 -0700 (PDT)
Message-ID: <5b91b1c1-ba41-45fa-949b-564cdb3e5e07@linaro.org>
Date: Wed, 13 May 2026 07:48:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] hw/arm/omap: Remove unused wakeup irq
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260512203414.3633237-1-peter.maydell@linaro.org>
 <20260512203414.3633237-7-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260512203414.3633237-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 12/5/26 22:34, Peter Maydell wrote:
> The OMAP code creates a qemu_irq whose set function is
> omap_mpu_wakeup(), and passes that irq into omap_mpuio_init(), which
> saves it in its omap_mpuio_s::wakeup field.  However nothing ever
> touches that qemu_irq again, so omap_mpu_wakeup() is never called.
> 
> Remove all this as dead code.  This lets us remove a direct call to
> cpu_interrupt(cpu, CPU_INTERRUPT_EXITTB) from within board/SoC code,
> which is pretty ugly and might not even do the right thing these
> days.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/omap1.c        | 18 ++----------------
>   include/hw/arm/omap.h |  2 --
>   2 files changed, 2 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


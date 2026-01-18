Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 655D3D4A5F4
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 18:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhXQj-0006O2-Sa; Sun, 18 Jan 2026 13:23:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhXQi-0006N4-HE
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 13:23:17 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vhXQh-0000Bv-1Z
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 13:23:16 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47ff94b46afso23290235e9.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 10:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768760593; x=1769365393; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XEsuZ2C9AXD2j/4UoVjq8Dd5rAdmuTsgzxDGxkYkryU=;
 b=Dy6eJlDdsQhIw4HlfuXJWDTFsM6K6cEikA+87vCcmdd7wqsfOj4rK1NdnTiVR+vep3
 JzbmtekAb9j/wbZ8Rc4Gmgtx8nN0Xd+sC1EpjwjuNkPM6HJNwmuhrEjW8ShKW3xibq4e
 eE8CU9tyPeuqKrv2N0pDJVGTCV4pSPPHF+k8TGF5wdAnZQt6jXiOLhsgAQ2fmYK9JKIK
 GNZDNr/ohx4XRO5vked4Tp2r/4OIAk92hALBKb2vEZXQvr+TPeuYtmlciqpCm+wRvYep
 duUE13hU4F+KjlqM5HqtOZBSl9NO7myCfr7b8/VlR2Cg43BKCER6U1bP+jMMQMmL6Pxz
 Cyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768760593; x=1769365393;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XEsuZ2C9AXD2j/4UoVjq8Dd5rAdmuTsgzxDGxkYkryU=;
 b=iEVtdBaZihl7bpb2z13KTIZ9s8DGU2vNAKJFyy7ptKodoyqsTpLvWNC43NtzWeyz2p
 ZQoq/v+t0Y19rR0+Zo70Kf2zUrtdDcXd3roknENqtHm+XB0xnAMd15nsySPvicbMLdS7
 /sULfbJdP/KNvQCroqSjsGZo1OB2K1qi7+/O8mq0fQz06k+m44UXp2KSCC+tAMzzx+Zw
 GVNnBJuxTWm/WMrdczjlTQYFTtDObnHB/e/ngA7lcY13u4jWYZU3Ozj+MjIv8Ba63ggQ
 uhCgPI9GLQ0YYy2aTOeF2bUJdd7aisbdnnr2PSAAcxNwDM0f4R6xilfQ88zOly+WgaD/
 Yqgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2J9q9rcHGu4bvkArB85usR/jBqNAfHHHKCz8fPfF0cIky9BpVuW7R1UWe6IQlwg2myNKt9JtF8kOE@nongnu.org
X-Gm-Message-State: AOJu0YzzVyeFZ1cz1/tAa0f9ymJx/RVbBslrF+Q7++75Hhg1QZ7OAYJn
 938URGMasNY172Swfx00w7rE2gHacoBLBvlsmXHaR6VOx4kTCh+dq6igV+ABhVj8WqE=
X-Gm-Gg: AY/fxX42HkqDBcuj1agtIOlqDymwyeSMKMXmBb4akJxRaI4Yi/w0ScTzhdaqe6ks/qa
 T3ebgAKnV/ntsb0SNSkkNrbzPF2mX0EH5p4oZxnuv89meOS2Jw5PhVlD2gMZ3RxN+c+tBJ3IaWM
 XHcZs2TpmoxTOaM1fZQ/CO0HmunB367U7RpUN+pPBJvWcSWfkdwxdiVtjPWHI5GqoafzItGsSO4
 4uHRYnTU21Hvdvcrll+nGjmbTU/7B50yrtIxqUN4pC6w0axAKbwMZmOTugeW163qZeYhUmFF7Ph
 DL0cw5MfuZm1ioHDpAmZ9U69DpkbnJa+dwP6hZTTDrLqtAih7lrOEeAhuUEpSVOEon29VHGI/IL
 nFFJZda+EjSwLwy+2OxeLDzRmXgyoMdbOtWY+bNXeg/o9+lfAYx1bCabDzRTe6Bnm2RWnm7M+8G
 OGTkwTkH9D+kr4SPbqWhajFnK9cTRLWRn8DQ3GMhHRqr4zeXFVz1YG9A==
X-Received: by 2002:a05:600c:470d:b0:477:9e0c:f59 with SMTP id
 5b1f17b1804b1-4801e530e35mr106376595e9.2.1768760593177; 
 Sun, 18 Jan 2026 10:23:13 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f4b26764fsm208083585e9.12.2026.01.18.10.23.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jan 2026 10:23:12 -0800 (PST)
Message-ID: <4add79fa-6cee-4795-96e9-033ae98c472e@linaro.org>
Date: Sun, 18 Jan 2026 19:23:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] Freescale SDHCI Fixes
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>, Bin Meng <bmeng.cn@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org
References: <20260112145418.220506-1-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260112145418.220506-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

> Bernhard Beschow (14):
>    hw/sd/sdhci: Fix TYPE_IMX_USDHC to implement sd-spec-version 3 by
>      default
>    hw/arm/fsl-imx6: Remove now redundant setting of "sd-spec-version"
>      property
>    hw/arm/fsl-imx6: Fix naming of SDHCI related constants and attributes
>    hw/arm/fsl-imx25: Apply missing reset quirk
>    Revert "hw/sd/sdhci: Rename ESDHC_* defines to USDHC_*"
>    hw/sd/sdhci: Consolidate eSDHC constants
>    hw/sd/sdhci: Rename usdhc_ functions
>    hw/sd/sdhci: Add TYPE_FSL_ESDHC_BE
>    hw/ppc/e500: Use TYPE_FSL_ESDHC_BE
>    hw/arm/fsl-imx25: Extract TYPE_FSL_ESDHC_LE
>    hw/sd/sdhci: Remove endianness property
>    hw/sd/sdhci: Add uSDHC-specific quirk
>    hw/sd/sdhci: Remove vendor property
>    hw/sd/trace-events: Remove redundant "SWITCH " command name

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

and queued, thanks!


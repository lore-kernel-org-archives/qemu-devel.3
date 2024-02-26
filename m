Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 047C7C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 13:08:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reahP-0003gG-Pi; Mon, 26 Feb 2024 08:07:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reahO-0003fJ-9O
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 08:07:14 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reahJ-0006ZD-Hh
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 08:07:14 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5129e5b8cecso3705262e87.3
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 05:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708952827; x=1709557627; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0KSovtxxq26NMA/JJuvDuQdjPjKl/QOetO0RoqWPi4A=;
 b=Z/UFV1o7NKYL1CGVZIIKDSliy6oOwa2vbpKi5SBX2Rc45dGBmM7GYr/2BGsNnps1xA
 523zaQtuwzXSho+UHEA/uB9FHnaCY/cuVfLk/of5nkuNlEHK5T3xm1TWvvLPXtom9Tt8
 xP5HLbLScMpwrWfYWA6RHz9KfmcxcvkSjdKr4j3eyB8g4j09KO4Co7cCA7GvZLZqWAXQ
 gjkwW8DzE1cXLxMK4sqxJuFA6w1C4fnklibkbw7ayqt9J95SZoCPx9Z00xssLZUSLskj
 tfZI13mM/irvrWbpl8SBv+Vwx7NO20uxmI+lFL8RCNzjk+F0NwxooYrA/VIt1zCutttp
 n3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708952827; x=1709557627;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0KSovtxxq26NMA/JJuvDuQdjPjKl/QOetO0RoqWPi4A=;
 b=YizeD4M8rxoxfyIVZaAkIrRnMz4JOb4kUi1+SkgePg1l9ELIEjervHjl1xa/u0OVaH
 3IxCbtVxotet9JP+J5DsKp1YwSUUuxlcm9lsKa2T2MCc5MR/KMWqVsZBV21BPIRDboU2
 CimwDpvLZcDtanUvS0cLZc+Kv7x3cPXk37X7YtRpRFe3gE1ZtqbzNSL9yl7e0PdKnZcI
 AYsD8OY4Ki34KchsZCmqoci83mDi6BR74vgUbPAVZgiLEtvADOoo9b5em4+fm3TgTiyx
 v3Fd/1OHxtLcXVe5W3viYQEz2vemPzy2KG/JOebxrbwzqlueE6sxB1QDerLddCveDpEI
 GzUQ==
X-Gm-Message-State: AOJu0YwNgSiwhSfPc0AvXg3QIgfiUhvhZSGDyU+dM8pO2fuW2CpjPqp3
 Tp4KGmb0pFkLqXFkK8LNiPvl5sjKYXs50UCGLB8M656BJlvLJLZuYoWVcFBOVpb6ETFEuFDRx9t
 l
X-Google-Smtp-Source: AGHT+IHXQdIc4a4mlgcuUMg4Vj7QSLIdixN15Tfktp54m8c6yothKLLne5dr/WkXsa6Occmwjxk2yQ==
X-Received: by 2002:a05:6512:407:b0:512:c508:b8c8 with SMTP id
 u7-20020a056512040700b00512c508b8c8mr3887455lfk.4.1708952827051; 
 Mon, 26 Feb 2024 05:07:07 -0800 (PST)
Received: from [192.168.69.100] ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 y25-20020ac24219000000b005114a0c56afsm838526lfh.279.2024.02.26.05.07.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 05:07:06 -0800 (PST)
Message-ID: <d26a5c6c-146c-433c-a625-052549eb4247@linaro.org>
Date: Mon, 26 Feb 2024 14:07:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/15] hw/southbridge: Extract ICH9 QOM container model
Content-Language: en-US
To: qemu-devel@nongnu.org, Bernhard Beschow <shentey@gmail.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Ani Sinha <anisinha@redhat.com>,
 qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20240226111416.39217-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240226111416.39217-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 26/2/24 12:13, Philippe Mathieu-Daudé wrote:

> Here we introduce the ICH9 'southbridge' as a QOM container.
> Since the chipset comes as a whole, we shouldn't instantiate
> its components separately. However in order to maintain old
> code we expose some properties to configure the container and
> not introduce any change for the Q35 machine. There is no
> migration change, only QOM objects moved around.

> Philippe Mathieu-Daudé (15):
>    MAINTAINERS: Add 'ICH9 South Bridge' section
>    hw/i386/q35: Add local 'lpc_obj' variable
>    hw/acpi/ich9: Restrict definitions from 'hw/southbridge/ich9.h'
>    hw/acpi/ich9_tco: Include 'ich9' in names
>    hw/acpi/ich9_tco: Restrict ich9_generate_smi() declaration
>    hw/ide: Rename ich.c -> ich9_ahci.c
>    hw/i2c/smbus: Extract QOM ICH9 definitions to 'ich9_smbus.h'
>    hw/pci-bridge: Extract QOM ICH definitions to 'ich9_dmi.h'
>    hw/southbridge/ich9: Introduce TYPE_ICH9_SOUTHBRIDGE stub
>    hw/southbridge/ich9: Add the DMI-to-PCI bridge
>    hw/southbridge/ich9: Add a AHCI function
>    hw/southbridge/ich9: Add the SMBus function
>    hw/southbridge/ich9: Add the USB EHCI/UHCI functions
>    hw/southbridge/ich9: Extract LPC definitions to 'hw/isa/ich9_lpc.h'
>    hw/southbridge/ich9: Add the LPC / ISA bridge function

Branch available here:
https://gitlab.com/philmd/qemu/-/commits/ich9_qom-v2/



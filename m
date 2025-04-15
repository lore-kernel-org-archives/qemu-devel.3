Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84605C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 08:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4bWR-0007yM-0I; Tue, 15 Apr 2025 04:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4bWD-0007HB-KJ
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 04:19:47 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4bWB-0002go-Qs
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 04:19:45 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-39c1ee0fd43so5055511f8f.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 01:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744705181; x=1745309981; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wrlECfOkXHMaaj6i63srLhSlG43tNPbqR/Fa5b49eDw=;
 b=a/MD3Y/CgMpqa6CybebvsQn3j0yCYrTSoXhi1waPQ5A9t8HqjJeEqlq4/SiqNoWqmt
 RQk+d0MgQoX63LdTUOC67pZWXHxxaqt5c3mSLg2b672xnK/JOGbCdHKph9nLISrzgvRl
 jNei2CFYweWB5kN5ZkpQOJkjyK9RMqKI6w+wtjult/6eBE1e+gIfQKc6OYiPNctdGYaN
 0Lpr8P9OyaoXUMNS3MUrZvJMVjZ8rR5zQVOS1bfFCOlQJZFrAcK1ZpB5CF6FH4x6T+DT
 DF/Jaj0ntRqJ3R73IrF0x0rDAvkrmbcTppMSpXaPZzX2iHwUZ800o4JYt4JMWmaHdybu
 hDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744705181; x=1745309981;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wrlECfOkXHMaaj6i63srLhSlG43tNPbqR/Fa5b49eDw=;
 b=ghXkj1Uf4+VsJAgdswyYyGppWOSJ8RdpBLwTy0LnHdRHrSP5zHqrmxGSLPKTuPLWQI
 R2lvyzkM4/Y+yfHRTXzY70SGodHg6jLSstFb8d+SfxUNb329mOYD8L2Jca3W5jOLHMIx
 gYlMZplP3XhYoPB0GrE4Bh+XnS7cvJddQxnrVWvYva1BIWc+75vegiaOfNvIXjjV0RJS
 JK4KcbfRcwC/gy/uY5i+IMSixug61OJQm2j8wRx5ZInYvTrjUBZxjmn+1jDS80UiqfQC
 BSFtSSeui83k0OL+VlXsOuVYxNNiWGLUrVt16fN5nVVjSpfuzxnBFoKyfc0q0dh50QpN
 PCPw==
X-Gm-Message-State: AOJu0YzJlLb3dZ/aFXSOwKb+90aSP3+VloVB8fzjx9fSyBRMsMFW2heP
 uLde97owHdj25mmkY3AGG2z79zhlkehp6ZD3PiRI+OBWS6bCxuPBfDDmfdGVxkU=
X-Gm-Gg: ASbGncs8QojvSQiwGI4VUXiewLyrHB7s3BpQpSrCMMA6aP/BB96AaliA+o9tiUzjkDc
 hgiLOWvYnR5wYvYMZ+i4NIUn/MyGEEjbYh1ImPc4U4CxQ7BwSj+hRKzsoYY8Mr/3Zo4xUEyfsMG
 idUWmpUYVj/XTddgaRjMd2v1Dw342eO9umFAMYJZup5BZRXQqP+I/MRS/M2kbYnCPIBuKnvapZ/
 tR24ajfBnsRg8pCkeFYbkO/6xLXTgkagC7yPjAqAUHXfOg024bfoTVuEka1sG6nKx7slJXZ2k5h
 skHVY/TkhWMvItvcAlP+zMNxxQoI3RgvJIPXRoeuj4Sy26B9UQ2/8VS9AHuWkURZ2jXRiqxv6qo
 MhHbpcr8wdngb+g==
X-Google-Smtp-Source: AGHT+IE6OWyjF2GH738pAscFKvG5FNa13uUiUulMeavFpSkpfChhlEcxTxvS5JKui0LgswChyPbjgA==
X-Received: by 2002:a5d:64e6:0:b0:391:2d76:baaa with SMTP id
 ffacd0b85a97d-39eaaec75cbmr13133082f8f.46.1744705181512; 
 Tue, 15 Apr 2025 01:19:41 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae96c184sm13625655f8f.30.2025.04.15.01.19.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 01:19:40 -0700 (PDT)
Message-ID: <b26000c7-f72d-49cc-8f7d-2ce3458c47b2@linaro.org>
Date: Tue, 15 Apr 2025 10:19:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v3 0/9] hw/arm: GIC ITS=off ACPI tables fixes
To: Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Andrew Jones <ajones@ventanamicro.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Udo Steinberg <udo@hypervisor.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>
References: <20250403204029.47958-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250403204029.47958-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Hi Gustavo,

Could you take over this series? You seem better suited
with ACPI and testing with Aarch64 virt machine :)

Thanks,

Phil.

On 3/4/25 22:40, Philippe Mathieu-Daudé wrote:
> 
> Fix ACPI tables for '-M its=off' CLI option.
> 
> Regards,
> 
> Phil.
> 
> Philippe Mathieu-Daudé (9):
>    hw/arm/virt: Remove pointless VirtMachineState::tcg_its field
>    hw/intc/gicv3_its: Do not check its_class_name() for NULL
>    hw/arm/virt: Simplify create_its()
>    hw/arm/virt-acpi: Factor its_enabled() helper out
>    qtest/bios-tables-test: Add test for -M virt,its=off
>    qtest/bios-tables-test: Whitelist aarch64/virt 'its_off' variant blobs
>    hw/arm/virt-acpi: Always build IORT table (even with GIC ITS disabled)
>    hw/arm/virt-acpi: Do not advertise disabled GIC ITS
>    qtest/bios-tables-test: Update aarch64/virt 'its_off' variant blobs


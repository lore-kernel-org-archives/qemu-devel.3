Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2705DCFA47B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 07:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMLsP-00054t-RW; Fri, 21 Nov 2025 02:48:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMLsF-00053G-6l
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 02:48:09 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMLsC-0006ho-A9
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 02:48:05 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6419e6dab7fso2428385a12.2
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 23:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763711282; x=1764316082; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2QHlCaGfSMKRdwqtRWgbF8anpHq+SdRcUndJ2C6EJpk=;
 b=CfBA4gzSub0Sqb5BOeI4vc6XaVwCmJJrdPtbcfeYo85lxjyFJ/UU9ImPbN+MSCmf8R
 qiI0WnsanD4hZaR5dPw2TLCF9sF9K3G1SwyM2hDGqHJs3+vMJhw1949Mu4nfq0Gz+vyH
 Vk+tFmZq39vVnKx2VhskEycqzVQg+4Knmr2Tyq/Je8KfAbwwUNBdydpglQkbw54WjFyA
 hWOwclvXBYpZp8KRIPZhXQATUXKn/c21T5UUj3MeMj8UjZ23SIzZvR8Jsxp1eJdSDo8y
 DSld0sHfmSBAnI4DuRcxTgKB4XMD0pfN69T+KAiLXTe6OujCbKpUgkwY/gboKSTDBxXQ
 fjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763711282; x=1764316082;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2QHlCaGfSMKRdwqtRWgbF8anpHq+SdRcUndJ2C6EJpk=;
 b=CGMmSbXN4q2PKgqmdCs43Bnjgl1Jk6bo1LaGDAXNlMMQuvm/zeW/aer5asDir9RSVy
 3wpNvZuwOToePMA2L4NIkVC3awIyLhmSKRzkbnb580UvXoV5Ly8FdlpfdXauGniCYlBe
 4MU1LzPcSrqdpSokajTjYlWc2TLyPknm1OhvYbs9q0RSL2NWz3QLACkBmJP8lTd/Yd8h
 epc8nU2gxyo/YoGv/6gosEIhLNWiyDzhcxQ+U0GQ6E9hAe73dxHnoTYq2kF0pmxLPWIF
 ocscToQ4epKmzsnR8nJzjeGEue7kTRcI2EPP6QcjA98rsEttD9kUKZskr2LNtcdZpHBX
 Ek5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1XaDsaK6b0x1c+3iWoYnOHPRdjpMV7dkjQJdgBxmNqhRddFUO3LqDJK2p0yGxP/czBFGUe/IusLNj@nongnu.org
X-Gm-Message-State: AOJu0Yxh8fFhpj2jKvvGt9gOxDMoONxN6KeFsoPrYN9kBaKQzcNNoxHb
 GIuRUYe+pCE1kY7WfP/k80iMZNr2/njfANQ+NcvM4ktbf8qrjF7bqSzgl3mGlyKnP1WLTDW39cC
 VzPAoWjUwNw==
X-Gm-Gg: ASbGncsK5T/QPycD2M2iUy3jCN5t+wcQhwpKvhmwguIA+kLrSQ92TH0ruVRXz1JdDf9
 VEucD4wkcCnKZhdmYBUx5MfmInZiLRfS3LUPmY9PRbVdwYTF7wx/Dx8iz5GcFSYhoiqb+IAfyjD
 k5VpIbqqN/54dX0Maw3eo5if7yvcSy7pcp6F86w5T5+53Q0gv+9IfIOpzYp2y3R6ZI8vjZcZh9w
 ezuweBoFdQbVu7g9qwx4/xfGnXaiZl+X8NQWSDOzopnaxP3Tx686FzcbYvNS+KT2C1ymbgBxd9S
 5MZRTrOmfHOwtS2qoraNmP3bquDxOXmO4GpadB3dyKNMCcOpyEeeOaW3Ju94OcTki3YP8hP6Xge
 1qFPE61opVFKUEwwY7+jGvAc7GTqYQ371ubeHGXSzpZBmhdYXVJqRSmRC1rJF99Z/OTKjAByV1Q
 L/XtCvUpvhfFq7hlM6FUoBOFXrFwNiuPZTi5EBDa0CyjsQxfBrMBLdRg==
X-Google-Smtp-Source: AGHT+IHbIcyPgqBOGCDqMzARZWb0patayV39xvk+WMlc/IycWV9IUh/g4u/yzx5vG2abqsAAp1p1aw==
X-Received: by 2002:a05:600c:354f:b0:477:641a:1402 with SMTP id
 5b1f17b1804b1-477c016e74bmr11772745e9.4.1763708788613; 
 Thu, 20 Nov 2025 23:06:28 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a9739964sm82685845e9.1.2025.11.20.23.06.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 23:06:28 -0800 (PST)
Message-ID: <f5892baf-cb8d-4026-9c1c-c8761889729a@linaro.org>
Date: Fri, 21 Nov 2025 08:06:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] hw/pci-host/aspeed_pcie: Update ASPEED PCIe Root
 Port capabilities and enable MSI to support hotplug
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, nabihestefan@google.com
References: <20251121050108.3407445-1-jamin_lin@aspeedtech.com>
 <20251121050108.3407445-2-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251121050108.3407445-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

On 21/11/25 06:01, Jamin Lin via wrote:
> This patch updates the ASPEED PCIe Root Port capability layout and interrupt
> handling to match the hardware-defined capability structure as documented in
> the PCI Express Controller (PCIE) chapter of the ASPEED SoC datasheet.
> 
> The following capability offsets and fields are now aligned with the actual
> hardware implementation (validated using EVB config-space dumps via
> 'lspci -s <bdf> -vvv'):
> 
> - Added MSI capability at offset 0x50 and enabled 1-vector MSI support
> - Added PCI Express Capability structure at offset 0x80
> - Added Secondary Subsystem Vendor ID (SSVID) at offset 0xC0
> - Added AER capability at offset 0x100
> - Implemented aer_vector() callback and MSI init/uninit hooks
> - Updated Root Port SSID to 0x1150 to reflect the platform default
> 
> Enabling MSI is required for proper PCIe Hotplug event signaling. This change
> improves correctness and ensures QEMU Root Port behavior matches the behavior
> of ASPEED hardware and downstream kernel expectations.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/pci-host/aspeed_pcie.c | 40 ++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 39 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



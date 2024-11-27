Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A545D609C1
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 09:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGEU2-0004eI-FZ; Wed, 27 Nov 2024 04:37:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGETz-0004cQ-PW
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 04:37:15 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tGETy-0003fJ-1k
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 04:37:15 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-53de79c2be4so3034600e87.2
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 01:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732700231; x=1733305031; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p5t1nm3lrboc04MW5xLqPV5c3uzCGvTHQy7ci+25SCc=;
 b=I1aqNsUmreOdK3Djahrh73uvBKMfu1IiyBZYB3SngX2Ec267DM6dt3FUBiOQyNCV1n
 FcVzyfRo27+IwlWzghaBGrB9I37KVtZCA8qc/yJijMd2qc+bPMB4OerREx+O0VGVOEOO
 n4h8XwxZ57NXDe+kfwE7OKRTxZfK+aHefn0s/TbQxpBfhmkQbqBjmkEca0+3/ykeA92f
 rXI8aUZeQBcS4qZVVXHgwsWpZC18SafDc7fsO+dxUi4J9yetJ1Msc7wHD5Kfzu5rVidu
 aMZJ3PVYcX1sBgZxhs6+l57YvO0NgZnNz2y8AzKlZ4dAxV0f4RBe3OGKkRtaH2xwhayb
 yVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732700231; x=1733305031;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p5t1nm3lrboc04MW5xLqPV5c3uzCGvTHQy7ci+25SCc=;
 b=OYwIhCpzI19T50LPs6FCOzVXq0KEbqOrFt/ZyjYBIE5s5V7OnCe1pSgHaRjQpvudVE
 Tbg7Nn0V2xzQYTDyx7D+z3BNigqvZKxiwJKfMqLg/UGasxHSGKYn6q43jRCfc4zE9Dab
 Iz2F4KcqAiAoSRkwhR+vThkrkYO9uNjFSxhqUu46JHYfXIL8zdKOTvQypZL7KaC7Vmoz
 VUgm2v/rbeHplfd8opnO5cLuwN4Z6BwulrqIzme64dWVgynXY1PlHGP5D9vr1DBGTIIa
 3jIRmFTQ0AxCg3iQFtKhJKEb5IpFhGDFcYz28NmA+KBG1pdxwIb5WNKh8xhTDy9GFHb+
 Cg6Q==
X-Gm-Message-State: AOJu0YzfEVnzn2rkpPhZ4WjUCdwwjaPJXgkHMuyMCBiuIFW/IhcH5WuW
 AuOrjj6lnNCZJ39vLC1aXK8lM2fHB57HedipkkKSZffDRB9f5t2oGdMjLfd4xC4J2XSHoB3eufD
 K
X-Gm-Gg: ASbGnct4e2PVGJTiMIr/useI0KGed7mzVlgAfJ19yla1RmtTvHpuu8b0DhYbl9aUvkq
 DECDkibbc5N3ELEqFNAvWGjBYfpmHeNGPprzuiRsobx0TkHC71p2cn51ftWrjZVoOCrz5CnYgy2
 Ht8XBnukCrpcH5LJNYp15yIv8rZRjMvQjPnbEhBvNEEQmLgKGsJMPQV/96VT2bBsXJ6R2M3ar39
 X1tm9OnkaNuKN6S4Y7iqm6E7FgsWvwjjxPEV0+/zhpQ168rtM32ER1TmjE1GFbLLjjMXTCBh4zt
 YDbuFqpazJsw/mI0dW/eT3XFr32QdvuDqqIE
X-Google-Smtp-Source: AGHT+IG4f977coozbW5zHgicomRliegYjHEXIkyX+tsY5O+P6yjTYt5Ccv18C2xPjt7J0WfZ9076aQ==
X-Received: by 2002:a05:6512:3b12:b0:53d:a4d7:1a8b with SMTP id
 2adb3069b0e04-53df00d3db0mr1249244e87.24.1732700230736; 
 Wed, 27 Nov 2024 01:37:10 -0800 (PST)
Received: from [192.168.69.146] (plb95-h02-176-184-14-96.dsl.sta.abo.bbox.fr.
 [176.184.14.96]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbc38afsm15730751f8f.67.2024.11.27.01.37.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 01:37:09 -0800 (PST)
Message-ID: <ab884d96-6648-4888-962c-35a6b1d90857@linaro.org>
Date: Wed, 27 Nov 2024 10:37:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.0 v2 01/13] hw/pci: Do not declare PCIBus::flags
 mask as enum
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Thomas Huth
 <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-riscv@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241126112212.64524-1-philmd@linaro.org>
 <20241126112212.64524-2-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241126112212.64524-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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

On 26/11/24 12:22, Philippe Mathieu-Daudé wrote:
> We use PCIBus::flags to mask various flags. It is not
> an enum, and doing so confuses static analyzers. Rename
> the enum as singular. Use a generic unsigned type for
> the mask.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/pci/pci_bus.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
> index 22613125462..6ecfe2e06d5 100644
> --- a/include/hw/pci/pci_bus.h
> +++ b/include/hw/pci/pci_bus.h
> @@ -19,7 +19,7 @@ struct PCIBusClass {
>       uint16_t (*numa_node)(PCIBus *bus);
>   };
>   
> -enum PCIBusFlags {
> +enum PCIBusFlag {
>       /* This bus is the root of a PCI domain */
>       PCI_BUS_IS_ROOT                                         = 0x0001,
>       /* PCIe extended configuration space is accessible on this bus */

(more diff context:)

         PCI_BUS_EXTENDED_CONFIG_SPACE                           = 0x0002,
        /* This is a CXL Type BUS */
        PCI_BUS_CXL                                          = 0x0004,

Enum would be the [0, 1, 2] bits. Since we define bitmask and use
bitmask arguments in the code, shouldn't we simply replace that
enum by #define?

> @@ -32,7 +32,7 @@ enum PCIBusFlags {
>   
>   struct PCIBus {
>       BusState qbus;
> -    enum PCIBusFlags flags;
> +    unsigned flags;
>       const PCIIOMMUOps *iommu_ops;
>       void *iommu_opaque;
>       uint8_t devfn_min;



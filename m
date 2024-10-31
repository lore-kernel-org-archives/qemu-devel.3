Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABADE68974
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 11:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6T4c-0004w4-Po; Thu, 31 Oct 2024 07:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1t6T4U-0004u1-Li
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 07:10:36 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1t6T4R-0003SP-85
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 07:10:34 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-539ee1acb86so821662e87.0
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 04:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730373028; x=1730977828; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=rETJV9+KIqR5YA/MkCI+vDownHRPVSloNnbyhKq0WnU=;
 b=wVyTltky1w7N7G+N8Xq0w/G5Mbf9XCLtYQJTEbZzYxKpkNUe/DkbsFa8GrxH8+iOwR
 8Q2wns7PAhVZDw8sms5dX3W9PwjvcPh8na/2kxamy7aJLB4O/5Jtsrs9RayxAY6LDbIH
 rciFoCOgDEY7bk9YyqTz2+rOp+7g9jmYepkn0UAFZBx+4nSfc6AQ6c/ciD2T8chjAMKw
 j8eG/4NNVaGhv1YBGZjv6k5O4WHz9C2YRdTManr1aqF8H7i+wcwTPfxABt4Jc85vvgO0
 RRjqWczq2PiRHzCDXcBOof4f1FMDXNhznRi/The9Acvr0G9oBfd4a5LswSaobZb+bEZV
 wVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730373028; x=1730977828;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rETJV9+KIqR5YA/MkCI+vDownHRPVSloNnbyhKq0WnU=;
 b=MpkiTi2Mx5ptkYJ6q5kRrg+/Kkcsy6mOgNAl7J+Vt+BFzO7ch2/31/bYYkkimgx2vs
 OmrK+xYU3Gk3eq7uWjcQXKRVzhAyi1Y1JlE84qcvw4TJbuv8z30FPRRYeEsU0kkzZQOy
 BbsaqP83sB94JkswVzbDyguIvJxZ0CaLXhjCKYqK5DqlpzHzlgzRo9xLau40rIu7kCKH
 zyPCQ9dZLgk28KJYgANXTyrmKBGiU7LtF6TZbMz5acjUcHnF1F7YjqvIERdr9KUageBR
 TvsLvx21+R9FAomFtZsHnoO6iucdgqorvgXB3FFLM20bDNffHnH3t64q75FIum0pxnPp
 mnUQ==
X-Gm-Message-State: AOJu0Ywec6bJxgIB/yflgpHs6Ujbewkxqgeqo+jQ8nAY7XeJjO5s60YF
 CUBnmoq5/OA6afQhgUfjigGOiICaZXnunFTBUq66RmLbPUHSomAqGRe0zjYjzAsNMvzB+QZcta/
 S
X-Google-Smtp-Source: AGHT+IGzuxrub5SE/fpi4fkWiG3D0BBzaAhKW5moBsYYOxKKA8S+ymXKX+d/xAn1GSjjbgFZ3aEoCw==
X-Received: by 2002:a05:6512:e99:b0:536:a583:2777 with SMTP id
 2adb3069b0e04-53b348c0e4emr9136980e87.9.1730373027766; 
 Thu, 31 Oct 2024 04:10:27 -0700 (PDT)
Received: from [192.168.210.26] (83.11.19.101.ipv4.supernova.orange.pl.
 [83.11.19.101]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53c7bc958cbsm169073e87.52.2024.10.31.04.10.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Oct 2024 04:10:27 -0700 (PDT)
Message-ID: <0a77763b-94b0-42de-96a3-5fc6882be06c@linaro.org>
Date: Thu, 31 Oct 2024 12:10:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] pcie: enable Extended tag field support
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20241023113820.486017-1-marcin.juszkiewicz@linaro.org>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB
Organization: Linaro
In-Reply-To: <20241023113820.486017-1-marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lf1-x136.google.com
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

W dniu 23.10.2024 o 13:38, Marcin Juszkiewicz pisze:
>  From what I read PCI has 32 transactions, PCI Express devices can handle
> 256 with Extended tag enabled (spec mentions also larger values but I
> lack PCIe knowledge).

Ping?


> QEMU leaves 'Extended tag field' with 0 as value:
> 
> Capabilities: [e0] Express (v1) Root Complex Integrated Endpoint, IntMsgNum 0
>          DevCap: MaxPayload 128 bytes, PhantFunc 0
>                  ExtTag- RBE+ FLReset- TEE-IO-
> 
> SBSA ACS has test 824 which checks for PCIe device capabilities. BSA
> specification [1] (SBSA is on top of BSA) in section F.3.2 lists
> expected values for Device Capabilities Register:
> 
> Device Capabilities Register     Requirement
> Role based error reporting       RCEC and RCiEP: Hardwired to 1
> Endpoint L0s acceptable latency  RCEC and RCiEP: Hardwired to 0
> L1 acceptable latency            RCEC and RCiEP: Hardwired to 0
> Captured slot power limit scale  RCEC and RCiEP: Hardwired to 0
> Captured slot power limit value  RCEC and RCiEP: Hardwired to 0
> Max payload size                 value must be compliant with PCIe spec
> Phantom functions                RCEC and RCiEP: Recommendation is to
>                                   hardwire this bit to 0.
> Extended tag field               Hardwired to 1
> 
> 1. https://developer.arm.com/documentation/den0094/c/
> 
> This change enables Extended tag field. All versioned platforms should
> have it disabled for older versions (tested with Arm/virt).
> 
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>   hw/core/machine.c    | 4 +++-
>   hw/pci/pci.c         | 2 ++
>   hw/pci/pcie.c        | 8 +++++++-
>   include/hw/pci/pci.h | 2 ++
>   4 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index adaba17eba..8ccc74067a 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -34,7 +34,9 @@
>   #include "hw/virtio/virtio-iommu.h"
>   #include "audio/audio.h"
>   
> -GlobalProperty hw_compat_9_1[] = {};
> +GlobalProperty hw_compat_9_1[] = {
> +    { TYPE_PCI_DEVICE, "x-pcie-ext-tag", "false" },
> +};
>   const size_t hw_compat_9_1_len = G_N_ELEMENTS(hw_compat_9_1);
>   
>   GlobalProperty hw_compat_9_0[] = {
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 87da35ca9b..9a3b0e4a43 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -87,6 +87,8 @@ static Property pci_props[] = {
>                       QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
>       DEFINE_PROP_SIZE32("x-max-bounce-buffer-size", PCIDevice,
>                        max_bounce_buffer_size, DEFAULT_MAX_BOUNCE_BUFFER_SIZE),
> +    DEFINE_PROP_BIT("x-pcie-ext-tag", PCIDevice, cap_present,
> +                    QEMU_PCIE_EXT_TAG_BITNR, true),
>       DEFINE_PROP_END_OF_LIST()
>   };
>   
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 4b2f0805c6..9f369c2b6c 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -86,7 +86,13 @@ pcie_cap_v1_fill(PCIDevice *dev, uint8_t port, uint8_t type, uint8_t version)
>        * Specification, Revision 1.1., or subsequent PCI Express Base
>        * Specification revisions.
>        */
> -    pci_set_long(exp_cap + PCI_EXP_DEVCAP, PCI_EXP_DEVCAP_RBER);
> +    uint32_t devcap = PCI_EXP_DEVCAP_RBER;
> +
> +    if (dev->cap_present & QEMU_PCIE_EXT_TAG) {
> +        devcap = PCI_EXP_DEVCAP_RBER | PCI_EXP_DEVCAP_EXT_TAG;
> +    }
> +
> +    pci_set_long(exp_cap + PCI_EXP_DEVCAP, devcap);
>   
>       pci_set_long(exp_cap + PCI_EXP_LNKCAP,
>                    (port << PCI_EXP_LNKCAP_PN_SHIFT) |
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index eb26cac810..5b14f9d375 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -213,6 +213,8 @@ enum {
>       QEMU_PCIE_ERR_UNC_MASK = (1 << QEMU_PCIE_ERR_UNC_MASK_BITNR),
>   #define QEMU_PCIE_ARI_NEXTFN_1_BITNR 12
>       QEMU_PCIE_ARI_NEXTFN_1 = (1 << QEMU_PCIE_ARI_NEXTFN_1_BITNR),
> +#define QEMU_PCIE_EXT_TAG_BITNR 13
> +    QEMU_PCIE_EXT_TAG = (1 << QEMU_PCIE_EXT_TAG_BITNR),
>   };
>   
>   typedef struct PCIINTxRoute {



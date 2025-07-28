Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C67C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 10:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugLFD-0007N3-Cx; Mon, 28 Jul 2025 06:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugKt2-0004KH-8v
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 06:15:17 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugKt0-0001fo-0r
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 06:15:15 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-55628eaec6cso3862239e87.0
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 03:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753697712; x=1754302512; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6V+9MMgmN1CgSom+NdWeavu/cTY5nASudBnUlKLSGYo=;
 b=fhSbgIWscGwtPCV8MG5C5p+lCH1cHFEyux5lBK7Xm1RPHpeCO5Z2R3C0mx9gRsApf0
 qw8PXY/nR8K98/24VX4wZNjk4ZluvoI+zvrDKiZY6b1mqnBSIi6u4QXR0yajS8imbvVP
 LSaZniAVbaUYCoOyw8lq++pwg16nez82RtqdM9Tbx/qcd2O/SU8aPsDJgfZcoFb81Fpy
 l1FmtmVVe8GCziACppe70rpoQkLsZM+a0Rs4qvtz1w1QBbAz7iN3RsnFZL/BewErhaf7
 ZxgVYGssQ5Vx4tzlvDn/QyYa94X4Mf8erswVBE84jFwiyxsCLKlDNptbW01EXslBIJ2a
 Qtkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753697712; x=1754302512;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6V+9MMgmN1CgSom+NdWeavu/cTY5nASudBnUlKLSGYo=;
 b=FUM/A6ubqiLUs+zDwYLDvd+2goT/48N7n993s50dCLR2uGM3y/b950rXV9lKpKO1Uc
 dJShg8a71L03GrY2uKeCKyD6TGBFteo+Lm+WAwVSP3zJifXEQ9VB8oLWxAKjfJO8uiXV
 4KDowLYwHHyWbi8QkxfZKBwscVxRohJBzKEYJTL0U7g5OvLx+KR0i/PQXG3jcCRkhbfq
 n+qzhjpLOtZgS6k+9dZZJI8Za0qf+/bfe6RPIfuvhrpI29F2acWW7IPx8ZD+ULa1wMS9
 10btROWm+wDF+SBIDN5pYZHs8ywjpLoIS88sxD4RbDKV4gkCl2RRMNnIQBJ+Fp7Mv+ZL
 SNzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBKKYDy9LP5/FGSD8mCyY1+lDTrimZ82jAQB8n5Z7CU5OgLAd01MWNebATvagsqF1XqBfXvQ+rF/ma@nongnu.org
X-Gm-Message-State: AOJu0YwOISKe//gITeUzUm16f3yAmpob+OGKWLOW0Owb4V579VbwTYvx
 4anxPscFSksG4RZhFt0v72thW6+YYR9yYRJZZcBHIIMyMo0BC0q5NdiUWjtpK7lguZAKbxF8/Rs
 7lf0B
X-Gm-Gg: ASbGncubbMA2tX0O5y9+La6EaR7U1oaz0Hq5t2XYyY3tjIl83O6KJbAVwSswoSzP9T4
 BPMQVJLXbnRHjsa016zgZUVXsEsCBZ/9bzOjKBuvHTBmzOGxnDoUXhrPzHYytI7YR+TErZGnaaX
 JTGfillvW3yckY1iXH6TOR5ZQh19447aS3NXsgaldZkzNyTm6C/r2vvNqz/kE91wVNrEV1ggqrM
 S517aX6p+9MnyMV9vow9xiSxTZMBrWqRG4+YK45uGhOFuMau8588u7vpCRvtkXo7vGvPv106XlJ
 a7KuRfGaytS8vGt5gpkCCM8GboXfIzjN8U/tQQx6OYqdhZLl5bHFDZGimXJyokcatCQVdUexfvJ
 D4cBCJEsZSvqZjskPzkiz1xGOzBaqa0G3RK0cdGrJJOuR2Dnnacer5fqe+5AuldXmrA==
X-Google-Smtp-Source: AGHT+IGTzQ7vBLQ6QPQLe/H3Hss6bkIewrpg9dTstCsHzQfWi09clLgt4SDIealDCHQ/N3ugfQSXTg==
X-Received: by 2002:a05:600c:4449:b0:456:2000:2f3f with SMTP id
 5b1f17b1804b1-4587655a77emr75236075e9.23.1753697376542; 
 Mon, 28 Jul 2025 03:09:36 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587abc2804sm92396535e9.5.2025.07.28.03.09.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 03:09:36 -0700 (PDT)
Message-ID: <0e122e2a-898f-46ca-b484-291b0091d928@linaro.org>
Date: Mon, 28 Jul 2025 12:09:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1? v2] pcie_sriov: Fix configuration and state
 synchronization
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>, qemu-stable@nongnu.org,
 Corentin BAYET <corentin.bayet@reversetactics.com>
References: <20250727-wmask-v2-1-394910b1c0b6@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250727-wmask-v2-1-394910b1c0b6@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Akihiko, Michael,

On 27/7/25 08:50, Akihiko Odaki wrote:
> Fix issues in PCIe SR-IOV configuration register handling that caused
> inconsistent internal state due to improper write mask handling and
> incorrect migration behavior.
> 
> Two main problems were identified:
> 
> 1. VF Enable bit write mask handling:
>     pcie_sriov_config_write() incorrectly assumed that its val parameter
>     was already masked, causing it to ignore the actual write mask.
>     This led to the VF Enable bit being processed even when masked,
>     resulting in incorrect VF registration/unregistration. It is
>     identified as CVE-2025-54567.
> 
> 2. Migration state inconsistency:
>     pcie_sriov_pf_post_load() unconditionally called register_vfs()
>     regardless of the VF Enable bit state, creating inconsistent
>     internal state when VFs should not be enabled. Additionally,
>     it failed to properly update the NumVFs write mask based on
>     the current configuration. It is identified as CVE-2025-54566.
> 
> Root cause analysis revealed that both functions relied on incorrect
> special-case assumptions instead of properly reading and consuming
> the actual configuration values. This change introduces a unified
> consume_config() function that reads actual configuration values and
> synchronize the internal state without special-case assumptions.
> 
> The solution only adds register read overhead in non-hot-path code
> while ensuring correct SR-IOV state management across configuration
> writes and migration scenarios.
> 
> Fixes: 5e7dd17e4348 ("pcie_sriov: Remove num_vfs from PCIESriovPF")
> Fixes: f9efcd47110d ("pcie_sriov: Register VFs after migration")
> Fixes: CVE-2025-54566
> Fixes: CVE-2025-54567
> Cc: qemu-stable@nongnu.org
> Reported-by: Corentin BAYET <corentin.bayet@reversetactics.com>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
> Changes in v2:
> - Changed to perform the VFEnable write mask update only when the bit is
>    cleared. It clarifies the intention is to prevent setting the bit
>    (i.e., the bit is currently cleared) when the NumVF holds an invalid
>    value. The code execution when the bit is set will be also a bit
>    shorter.
> - Added references to the relevant CVEs.
> - Link to v1: https://lore.kernel.org/qemu-devel/20250713-wmask-v1-1-4c744cdb32c0@rsg.ci.i.u-tokyo.ac.jp
> ---
>   hw/pci/pcie_sriov.c | 42 +++++++++++++++++++++++-------------------
>   1 file changed, 23 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
> index 3ad18744f4a8ed2b35144fafcdc8e7e00fec3672..8a4bf0d6f7c0c6e9ec30df2e9bc55967e48cf6c3 100644
> --- a/hw/pci/pcie_sriov.c
> +++ b/hw/pci/pcie_sriov.c
> @@ -64,6 +64,27 @@ static void unregister_vfs(PCIDevice *dev)
>       pci_set_word(dev->wmask + dev->exp.sriov_cap + PCI_SRIOV_NUM_VF, 0xffff);
>   }
>   
> +static void consume_config(PCIDevice *dev)
> +{
> +    uint8_t *cfg = dev->config + dev->exp.sriov_cap;
> +
> +    if (pci_get_word(cfg + PCI_SRIOV_CTRL) & PCI_SRIOV_CTRL_VFE) {
> +        register_vfs(dev);
> +    } else {
> +        uint8_t *wmask = dev->wmask + dev->exp.sriov_cap;
> +        uint16_t num_vfs = pci_get_word(cfg + PCI_SRIOV_NUM_VF);
> +        uint16_t wmask_val = PCI_SRIOV_CTRL_MSE | PCI_SRIOV_CTRL_ARI;
> +
> +        unregister_vfs(dev);
> +
> +        if (num_vfs <= pci_get_word(cfg + PCI_SRIOV_TOTAL_VF)) {
> +            wmask_val |= PCI_SRIOV_CTRL_VFE;
> +        }
> +
> +        pci_set_word(wmask + PCI_SRIOV_CTRL, wmask_val);
> +    }
> +}
> +
>   static bool pcie_sriov_pf_init_common(PCIDevice *dev, uint16_t offset,
>                                         uint16_t vf_dev_id, uint16_t init_vfs,
>                                         uint16_t total_vfs, uint16_t vf_offset,
> @@ -416,30 +437,13 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
>       trace_sriov_config_write(dev->name, PCI_SLOT(dev->devfn),
>                                PCI_FUNC(dev->devfn), off, val, len);
>   
> -    if (range_covers_byte(off, len, PCI_SRIOV_CTRL)) {
> -        if (val & PCI_SRIOV_CTRL_VFE) {
> -            register_vfs(dev);
> -        } else {
> -            unregister_vfs(dev);
> -        }
> -    } else if (range_covers_byte(off, len, PCI_SRIOV_NUM_VF)) {
> -        uint8_t *cfg = dev->config + sriov_cap;
> -        uint8_t *wmask = dev->wmask + sriov_cap;
> -        uint16_t num_vfs = pci_get_word(cfg + PCI_SRIOV_NUM_VF);
> -        uint16_t wmask_val = PCI_SRIOV_CTRL_MSE | PCI_SRIOV_CTRL_ARI;
> -
> -        if (num_vfs <= pci_get_word(cfg + PCI_SRIOV_TOTAL_VF)) {
> -            wmask_val |= PCI_SRIOV_CTRL_VFE;
> -        }
> -
> -        pci_set_word(wmask + PCI_SRIOV_CTRL, wmask_val);
> -    }
> +    consume_config(dev);

As usual, this would be simpler to review extracting consume_config() in
a preliminary patch, then the real fix.

>   }
>   
>   void pcie_sriov_pf_post_load(PCIDevice *dev)
>   {
>       if (dev->exp.sriov_cap) {
> -        register_vfs(dev);
> +        consume_config(dev);
>       }
>   }

Michael, do we want this for the 10.1 release?

Regards,

Phil.


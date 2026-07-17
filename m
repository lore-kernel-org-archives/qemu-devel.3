Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB46BC4451C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wki83-0007Wu-GI; Fri, 17 Jul 2026 08:57:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wki7x-0007UX-NL
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 08:57:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wki7v-0003ie-TM
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 08:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784293034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=a9IY3YgrRTYN+mgRtMaw7rnAQ58rgSUQeqr3lpeuCOE=;
 b=Mnp/O9oVZXOtczTRSGeMhkf3MxlkJj8pPF7MdynXIfrGrr182tvQqovu5qRT2jOiNilBFM
 xDxChFeUa1eJM17Mjs5+0Q4X9q4h/5ymdFJN3NTGKgbJLHXx+HbedTgaAaLx+8OvxSRCfl
 HwwL8kqCLkU+qH55n/S8iozd8vpqFtI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-1ZKL9pmaO6qkMazmXrA8sA-1; Fri, 17 Jul 2026 08:57:13 -0400
X-MC-Unique: 1ZKL9pmaO6qkMazmXrA8sA-1
X-Mimecast-MFC-AGG-ID: 1ZKL9pmaO6qkMazmXrA8sA_1784293032
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4740be00302so3796670f8f.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2026 05:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784293032; x=1784897832; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=a9IY3YgrRTYN+mgRtMaw7rnAQ58rgSUQeqr3lpeuCOE=;
 b=D4mHW6w2O/YvJTDoxmZ89/UjAikh08QJ6TDK17aCGaNCKOlOgsYejXPa/ulJJm1ztF
 /8NoJlP7F7P7G8GDr5deiceIvTZhs2j0iJd1jcqliPBiD2FzU6FNMjb179gGWYyYf4MG
 VgUX8pyCrA+6aQBx90JaUa4x0+FWh7lQXK2/eAgOshGn7reK0a9wWpIrOklvHY9Oh/Jm
 BbRBaXfPDKL1+KwqoyAlOzE3sBEHCRlBbRfVw9nA2HRosztg/TLAlI5YYh4o339NZHiW
 P4MU2gSwlfSjJXjLKpVSZ4orxURKp7K7WCyOagONFgTuHN72eRwmpPrl4TKJkOhuoK+Q
 9EgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784293032; x=1784897832;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=a9IY3YgrRTYN+mgRtMaw7rnAQ58rgSUQeqr3lpeuCOE=;
 b=MYS5cX/5EhOwz1VoFt2L35OEP63xRdqh7fMBCAVzrce1YxVyJUe8XQ8eFc8PCv5TIe
 3e6sSC+379KltV+tHy7SJac5ZvsWH8ZsKFBA7/kp323zaM9CFNKONW8TFN1qiYQU3HR2
 Rk5ZYcEQBy7lpd65HZWFSmBilV+Yvo9Kkxb/wGu8ehF0d6ZeQfNK4i/dTbBEuj1Sqhh3
 RV1/0g+vWxe345jyU9v+vgzSAPh5sY/Qi+SGJKEvmvz0lb+I8suSqzpLiSfjvINM5vrq
 IQsZAz4JZxiF4sWmJaO3KKp4p2xPLFCa/smLvY+Jv0ne/KLtguVSO35HxbAuCSzKPEji
 8L+Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp65ckpbuHA2qOCWzFYcCfo6jrkoe1FCcoxsB4I51fv/MGXmkfWkC+PymSCuoM9IM5aO8svz5FIsgqj@nongnu.org
X-Gm-Message-State: AOJu0Yx9q2vZQh7Fmmqa0T6XIA1RW8CNDp1PFkrs8G9NzEzaaoNUl2J/
 06rdY5JoVJAE9q/ln/6OzxctVguhg1ypZCIFr6WNxQ+ZqDvPyW7/BD/zf+OVB4TQ7ks3lTl1sYY
 iE9MPcT9HHT7rCPi0WknnzGwF2hBuJAsgj0CMCU/lXE45LrEs/BKgBI1y
X-Gm-Gg: AfdE7ckcavO/qWVC9a2Wdytd6JnYghlVWkWfn69Tdxu4FImTaDxbMwMmthYEslBjahh
 9b7H5jmsbKdYd9XbVCAMCoWWMJ+Jybx7BZYwVB3vGLzLRA0ghxho3uj+lgvgGyEo+dfDlC++T1W
 n4W/LGKI2Qu+y3qD9w3eW9PDC0e+yod9LkfHtWSngPgftUoa334BCrZqFik80fwYpkx4ZQ0SG3B
 MNHUOIbetWvh4z4Z9WEuMPPBEG8MaAzT6R6j2JfqRxWWdTaq/uvU242bp8MfVOrkPQEKECFUp3G
 duPAjdfAY/QYz/thuooBfn25WBT2FXmfAjcl0vUvl2claxHSc4wY/oZPFAtHIJmQXtYJ8MVhu11
 mPwsU+p3pOB8CK5Y8zUY9wr9XsvW9qdKkTn1xV4Y=
X-Received: by 2002:a05:6000:4a17:b0:46f:558:a42a with SMTP id
 ffacd0b85a97d-47f6231c3afmr3340568f8f.34.1784293032065; 
 Fri, 17 Jul 2026 05:57:12 -0700 (PDT)
X-Received: by 2002:a05:6000:4a17:b0:46f:558:a42a with SMTP id
 ffacd0b85a97d-47f6231c3afmr3340533f8f.34.1784293031576; 
 Fri, 17 Jul 2026 05:57:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63eeece9sm3801473f8f.37.2026.07.17.05.57.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2026 05:57:11 -0700 (PDT)
Message-ID: <c0936bce-6c63-431e-a4d4-cd58fb5a87d0@redhat.com>
Date: Fri, 17 Jul 2026 14:57:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] vfio/pci: don't narrow a failed config read to a
 plausible value
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>
References: <20260715191735.2454719-1-den@openvz.org>
 <20260717122232.468955-2-den@openvz.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260717122232.468955-2-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On 7/17/26 14:22, Denis V. Lunev wrote:
> vfio_pci_read_config() signals a failed host-side read by returning
> (uint32_t)-1, regardless of the requested length. vfio_intx_enable()
> and vfio_pci_pre_reset() both narrowed that return value straight
> into a uint8_t/uint16_t local before checking anything, which
> truncates -1 into 0xff or 0xffff - values a real 1- or 2-byte
> register read can legitimately produce. From that point on, a
> failed read and real all-ones content are indistinguishable.
> 
> Keep the full uint32_t result and check it against (uint32_t)-1
> before narrowing. In vfio_pci_pre_reset(), skip the corresponding
> write-back on a failed read instead of writing back constructed
> garbage to the device.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Alex Williamson <alex@shazbot.org>
> CC: "Cédric Le Goater" <clg@redhat.com>


Coverity CID: 1663688, 1663684

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

> ---
> 
>   hw/vfio/pci.c | 32 +++++++++++++++++++++++++-------
>   1 file changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index c204706e63..8b8e8b6379 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -323,10 +323,16 @@ static void vfio_irqchip_change(Notifier *notify, void *data)
>   static bool vfio_intx_enable(VFIOPCIDevice *vdev, Error **errp)
>   {
>       PCIDevice *pdev = PCI_DEVICE(vdev);
> -    uint8_t pin = vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1);
> +    uint32_t val = vfio_pci_read_config(pdev, PCI_INTERRUPT_PIN, 1);
> +    uint8_t pin;
>       Error *err = NULL;
>       int32_t fd;
>   
> +    if (val == (uint32_t)-1) {
> +        error_setg(errp, "failed to read PCI_INTERRUPT_PIN");
> +        return false;
> +    }
> +    pin = val;
>   
>       if (!pin) {
>           return true;
> @@ -2764,6 +2770,7 @@ bool vfio_pci_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
>   void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
>   {
>       PCIDevice *pdev = PCI_DEVICE(vdev);
> +    uint32_t val;
>       uint16_t cmd;
>   
>       vfio_disable_interrupts(vdev);
> @@ -2772,23 +2779,34 @@ void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
>        * Stop any ongoing DMA by disconnecting I/O, MMIO, and bus master.
>        * Also put INTx Disable in known state.
>        */
> -    cmd = vfio_pci_read_config(pdev, PCI_COMMAND, 2);
> -    cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
> -             PCI_COMMAND_INTX_DISABLE);
> -    vfio_pci_write_config(pdev, PCI_COMMAND, cmd, 2);
> +    val = vfio_pci_read_config(pdev, PCI_COMMAND, 2);
> +    if (val != (uint32_t)-1) {
> +        cmd = val;
> +        cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
> +                 PCI_COMMAND_INTX_DISABLE);
> +        vfio_pci_write_config(pdev, PCI_COMMAND, cmd, 2);
> +    }
>   
>       /* Make sure the device is in D0 */
>       if (pdev->pm_cap) {
>           uint16_t pmcsr;
>           uint8_t state;
>   
> -        pmcsr = vfio_pci_read_config(pdev, pdev->pm_cap + PCI_PM_CTRL, 2);
> +        val = vfio_pci_read_config(pdev, pdev->pm_cap + PCI_PM_CTRL, 2);
> +        if (val == (uint32_t)-1) {
> +            return;
> +        }
> +        pmcsr = val;
>           state = pmcsr & PCI_PM_CTRL_STATE_MASK;
>           if (state) {
>               pmcsr &= ~PCI_PM_CTRL_STATE_MASK;
>               vfio_pci_write_config(pdev, pdev->pm_cap + PCI_PM_CTRL, pmcsr, 2);
>               /* vfio handles the necessary delay here */
> -            pmcsr = vfio_pci_read_config(pdev, pdev->pm_cap + PCI_PM_CTRL, 2);
> +            val = vfio_pci_read_config(pdev, pdev->pm_cap + PCI_PM_CTRL, 2);
> +            if (val == (uint32_t)-1) {
> +                return;
> +            }
> +            pmcsr = val;
>               state = pmcsr & PCI_PM_CTRL_STATE_MASK;
>               if (state) {
>                   error_report("vfio: Unable to power on device, stuck in D%d",



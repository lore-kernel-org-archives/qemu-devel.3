Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50708D7878F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 15:46:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWcgB-0006lB-T6; Fri, 19 Dec 2025 10:46:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vWcfq-0006iT-OT
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 10:45:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vWcfo-0005cN-Q7
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 10:45:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766159143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S15MReASdqQYIGrpCHotzgNPgx3L7V+5u5KVs5yBDWo=;
 b=YHLN/XnRDZt8T4cPG1F6+8O6bmADRAulp1I/LmnRT46b2xf9nmuFbHEiDLCOMfZc4U2A2N
 Ye3li0ykrPeNMAn80wsLsQhEt04OR3pPU/VlKlrBrvIzsg2ycL+nmJceVNHUY6Xi/640n1
 cilXHhhrr9C7bInn2TM0IWiQBFNEYGM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-JmRiy_yJO0OzOUdmbEfnPg-1; Fri, 19 Dec 2025 10:45:42 -0500
X-MC-Unique: JmRiy_yJO0OzOUdmbEfnPg-1
X-Mimecast-MFC-AGG-ID: JmRiy_yJO0OzOUdmbEfnPg_1766159140
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-430fc83f58dso1055203f8f.2
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 07:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766159140; x=1766763940; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=S15MReASdqQYIGrpCHotzgNPgx3L7V+5u5KVs5yBDWo=;
 b=pFJuATjCGCHwilktD66paTPiAU9ceyMDtB903nYrnUFZ/Tg3ROhxnxMVLg648zH0bY
 Cu80gYoqj+zplIjLMYD6IZiQtqodxUu3s+T8A+v3c2oW43/oMNtnKxURHcw/3/1mBo//
 zS8qKE5MHT9+jveZpxjqoR4kBKXdega+qdBnb2i2qfK3Y5BvwdaiStBWyzbWYl7G+jut
 UTdCzpf2jEuQAa54sLg+JXaOUobCIxia0M8z/glFPZ3fAsh1vf+20RHx14gnIEVsf3uX
 BAWjMWNWHR1Q2+7bmoh1kKaRbW8xmhwFn5yyYD2Z1LZAr2IWlr8VAvShCpX1v1isbLg1
 kvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766159140; x=1766763940;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S15MReASdqQYIGrpCHotzgNPgx3L7V+5u5KVs5yBDWo=;
 b=YaSyJ5OUvYT5STGclOjsCtVRweclOk97HZobOCV82iRwMatKqjEiaq1Hw3BjsSocj4
 PMumG71h8vYM6zC2CxUyA5h0lNdM94XbxeHIMBKoheLKWQlcwNPjX2z5YbwcTEG+P921
 b1yQ3ZlMJn2R+oyZ43buj6jWGyNYyQi3d1Tl6JjzyFfy0dy+w/t0ukTDEi0UYraf8g2L
 kPUpTjaN0gK3gf0YhOoKRALoug1JE0M5gNagffD9zScbV0QT62xRG68xgQqlQjZ0S9F+
 A5nON2duHgNXyDTSq93VHq17b2ODG08TyPSoCDVgEaSY2OWizcU1qzN6F8jsjF1QKyht
 3hiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwpBxetywu/U64/BC/m65CfTWnIpNlg+C0b65Ge6C7/ShWC5UM++zG8B933OWRYUsNnRY78zaz9L61@nongnu.org
X-Gm-Message-State: AOJu0Yz7XffkyoMtL4qpXsBuxS33bqgqlhqJQ/jwqMtBHQY3ui38qH7z
 r2Wzs13jWHbx2Ywyyr0zZqipGpjiclCI9gpfo+K8KjVGdSI2WEGsEUPfPZCMpc4GkfX7xuO3ump
 YeIikFX5QpOFA2KkgTxa62vEhF02Z8hTP4UO+qVv1jPHyZed2wa3MRmsS
X-Gm-Gg: AY/fxX4J4xA56QdTJznXUeIHLPVJ7Z9pcN7/PZ/t4OfGzYZxzGAV11tlz52Z9xHa+Z3
 Xo6Bal+Iv5aojP6Bfxg1Yj3mqHCxohubOgUOwZQE69ww1ULnBw3MqERBrCLyl2nh1SC4kPl/ENq
 sYEnotDXy7NNpv0Ni2JUpbrxbWvH28U6sFhsMTabMDv71AUy2QGe5Gj+b3J8BUpfpu2hSPOf5A4
 PUqfbp2PV59I2fd7z+iuCYdYfsJtTGbNy2ikN2X/5uLaEy8dJ5dQXBzbToIh5nUiQuhjumdCFCL
 Mwcw9wBKlRQnQ4A+0vDUyOEyt/oiGMiOBMK20w1IKQ9hpsVgxt8ejbA9tpBawlDXCGSf9WzXcM+
 idDXYeo91HB/v5zz2LafEotyfQzSZCan5zzuYzBWgLbZU48Cr
X-Received: by 2002:a05:6000:2601:b0:430:fd84:3174 with SMTP id
 ffacd0b85a97d-4324e50a4b5mr4074419f8f.46.1766159140071; 
 Fri, 19 Dec 2025 07:45:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOrcwX4MoiXbesezGWMlzu8kEuZ+Lx19EJ8c96iZv8UpIFI88NrmBw77DMWL2DOiXyDIM66A==
X-Received: by 2002:a05:6000:2601:b0:430:fd84:3174 with SMTP id
 ffacd0b85a97d-4324e50a4b5mr4074396f8f.46.1766159139623; 
 Fri, 19 Dec 2025 07:45:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa08d9sm5910195f8f.30.2025.12.19.07.45.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Dec 2025 07:45:39 -0800 (PST)
Message-ID: <d5ee55ae-edc5-4289-958b-a8bd9075574b@redhat.com>
Date: Fri, 19 Dec 2025 16:45:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/pci: Do not clear PCI_COMMAND_INTX_DISABLE in
 pre_reset
To: Victor Zhao <Victor.Zhao@amd.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, qemu-stable@nongnu.org
References: <20251219092634.3176885-1-Victor.Zhao@amd.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251219092634.3176885-1-Victor.Zhao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hello,

On 12/19/25 10:26, Victor Zhao wrote:
> When vfio_pci_pre_reset() disables MSI/MSI-X, the device may fall back
> to INTx mode. The code then clears PCI_COMMAND_INTX_DISABLE, allowing
> the device to assert INTx. Since interrupt handlers have already been
> removed, this causes unhandled interrupts and kernel "nobody cared"
> warnings.

Could you tell us which device you are using ?

> Fix by not clearing PCI_COMMAND_INTX_DISABLE. The device reset will
> restore it to default state.

INTx disable is a complex topic. It is checked and set in different
places in the kernel too to avoid spurious interrupts. The DisINTx
default value should be 0, like for IO, MEM and MASTER  though.

But some device have broken support: commit 450744051d20 ("vfio/pci:
Hide broken INTx support from user") and routine
pci_intx_mask_supported(). I lack the historical background.


Alex,

What's your opinion ?

Thanks,

C.


> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
> ---
>   hw/vfio/pci.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index b46b1305a7..1681134cf2 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -2616,13 +2616,9 @@ void vfio_pci_pre_reset(VFIOPCIDevice *vdev)
>   
>       vfio_disable_interrupts(vdev);
>   
> -    /*
> -     * Stop any ongoing DMA by disconnecting I/O, MMIO, and bus master.
> -     * Also put INTx Disable in known state.
> -     */
> +    /* Stop any ongoing DMA by disconnecting I/O, MMIO, and bus master. */
>       cmd = vfio_pci_read_config(pdev, PCI_COMMAND, 2);
> -    cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
> -             PCI_COMMAND_INTX_DISABLE);
> +    cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
>       vfio_pci_write_config(pdev, PCI_COMMAND, cmd, 2);
>   
>       /* Make sure the device is in D0 */



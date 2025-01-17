Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262F8C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 09:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYiXp-0000P9-Og; Fri, 17 Jan 2025 04:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYiXo-0000Ol-2x
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:21:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tYiXi-0002qe-CI
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 04:21:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737105688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2fxYTY/g725bdpD1044BU6gPrRrHEVbmN4GqY2KzCBY=;
 b=BFpqdp2oCMwaqE3hjmL9eote2Ze6VOq8LT6GIZU8V0aD5wOlZGP/Bs1PSnylYL1XUTQ69f
 tNjRJdQyUCIu0XxlosIy/Q/NL6v8FWDAu+0dqQnP+6h6MzCjec5yGSGwhHi5fFrxYojMcj
 li+NaqKyHjUFOlgPBZoHh4ONGRfaOtM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-pG4XQI9xPbC5QUoEmo8Nxw-1; Fri, 17 Jan 2025 04:21:26 -0500
X-MC-Unique: pG4XQI9xPbC5QUoEmo8Nxw-1
X-Mimecast-MFC-AGG-ID: pG4XQI9xPbC5QUoEmo8Nxw
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-385e2579507so875505f8f.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 01:21:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737105686; x=1737710486;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2fxYTY/g725bdpD1044BU6gPrRrHEVbmN4GqY2KzCBY=;
 b=u5V2sYki0spUooaVm/B5cVjLL8TsY3Qj6I6WaAxxqviaPzSgDT3CEF32FARRhLQ+pF
 yjLzBim2Nww3e1lbKg7zXowlCxKvk58C8YG20tceq78qP9lO8c/wXGW1IJU/5ED7F82m
 OTWDFniB6C8mBBiARPDu3b2bRe1AQfU5eE+2ZNATFm1upO9P9KTTKksV7e+ktw1jvaMF
 3zBYxC82LThwqPCeGyDoHcP4wEfE8zGK8WwvKsAG5aehpnC2lrpr2r1L8ZGg3CagZAkG
 fsKgUlJww2aEZ2i/M1Vb7X/s0e3PAGSbs+56dAPkT32h/S+RT5d/5LLeFPRLGgavZtTL
 GIAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGVlBxQxUZhuMihuwRIpoTR/NbQdRkC7J9cM5NyboiwYnb2CNbXK5nhBSmVPJqFHYLcAFVnOzN3Gbt@nongnu.org
X-Gm-Message-State: AOJu0YyR3j/FFCS7D/h84plx5bDBzv7dId0G3R/48Zr/p+0lYTNrbwgb
 nkopGNRN3KhyVGaZ4hGqhB5VUrNnaBqgvp8rGdxL+uKv9KVaryF2JFU7buQwVxQbg+JPPFE6Adr
 +m6zjSZOCbdVf8q5PDdQaVSHkmB0NvfknUbpremWa4zT8TzZZzinO
X-Gm-Gg: ASbGncsFq/sJqY4jruRDlFYOuSslcukbg2mK/daImpYSrLvXQmS3eJ7SwYpjbQkf2RO
 JNjursX1W3zrwJysxKPR3nhXB9NAmQl9UIq1+1IiO4+qGwR8mP1F/N83U76wbO2O+kjk//hedst
 1syaBYPjOXnBWaWPwmN46hZieJiCJ56naSuSM5Exs/NkJYNpcTISCszwev9O7tk9xNlX5rkw4Zv
 1Dg+r55gfYUOTyk3BglS5LQyRyMNT7ZqX7CQfFmwCmDKTRZxWfO5LqzGo+xsOSXbBwzqxWpJ6aB
 UCAIZLMJ1oPS
X-Received: by 2002:a5d:52c2:0:b0:386:3b93:6cc6 with SMTP id
 ffacd0b85a97d-38bf566351emr1508468f8f.15.1737105685794; 
 Fri, 17 Jan 2025 01:21:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSXgXMPq43lQBzVRIC0ToVcFWhNnDHorYcGWS+qaAlZ7+CYQ7rhOVsAmJBLroq8rBNrJgTfw==
X-Received: by 2002:a5d:52c2:0:b0:386:3b93:6cc6 with SMTP id
 ffacd0b85a97d-38bf566351emr1508425f8f.15.1737105685462; 
 Fri, 17 Jan 2025 01:21:25 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-119.web.vodafone.de.
 [109.42.51.119]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43890468869sm26425935e9.35.2025.01.17.01.21.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2025 01:21:25 -0800 (PST)
Message-ID: <774d37cb-0dca-4a38-9285-16e180dc0c24@redhat.com>
Date: Fri, 17 Jan 2025 10:21:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/21] hw/scsi/vmw_pvscsi: Remove
 PVSCSI_COMPAT_DISABLE_PCIE_BIT definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
References: <20250115232247.30364-1-philmd@linaro.org>
 <20250115232247.30364-18-philmd@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250115232247.30364-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.093,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 16/01/2025 00.22, Philippe Mathieu-Daudé wrote:
> PVSCSI_COMPAT_DISABLE_PCIE_BIT was only used by the
> hw_compat_2_5[] array, via the 'x-disable-pcie=on' property.
> We removed all machines using that array, lets remove all the
> code around PVSCSI_COMPAT_DISABLE_PCIE_BIT.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/scsi/vmw_pvscsi.c | 44 ++++++++------------------------------------
>   1 file changed, 8 insertions(+), 36 deletions(-)
> 
> diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
> index 8c793b4188d..4c95794ba1e 100644
> --- a/hw/scsi/vmw_pvscsi.c
> +++ b/hw/scsi/vmw_pvscsi.c
> @@ -68,11 +68,6 @@ struct PVSCSIClass {
>   OBJECT_DECLARE_TYPE(PVSCSIState, PVSCSIClass, PVSCSI)
>   
>   
> -/* Compatibility flags for migration */
> -#define PVSCSI_COMPAT_DISABLE_PCIE_BIT 1
> -#define PVSCSI_COMPAT_DISABLE_PCIE \
> -    (1 << PVSCSI_COMPAT_DISABLE_PCIE_BIT)
> -
>   #define PVSCSI_MSI_OFFSET    (0x7c)
>   #define PVSCSI_EXP_EP_OFFSET (0x40)
>   
> @@ -1152,15 +1147,11 @@ pvscsi_realizefn(PCIDevice *pci_dev, Error **errp)
>       trace_pvscsi_state("init");
>   
>       /* PCI subsystem ID, subsystem vendor ID, revision */
> -    if (PVSCSI_USE_OLD_PCI_CONFIGURATION(s)) {
> -        pci_set_word(pci_dev->config + PCI_SUBSYSTEM_ID, 0x1000);
> -    } else {
> -        pci_set_word(pci_dev->config + PCI_SUBSYSTEM_VENDOR_ID,
> -                     PCI_VENDOR_ID_VMWARE);
> -        pci_set_word(pci_dev->config + PCI_SUBSYSTEM_ID,
> -                     PCI_DEVICE_ID_VMWARE_PVSCSI);
> -        pci_config_set_revision(pci_dev->config, 0x2);
> -    }
> +    pci_set_word(pci_dev->config + PCI_SUBSYSTEM_VENDOR_ID,
> +                 PCI_VENDOR_ID_VMWARE);
> +    pci_set_word(pci_dev->config + PCI_SUBSYSTEM_ID,
> +                 PCI_DEVICE_ID_VMWARE_PVSCSI);
> +    pci_config_set_revision(pci_dev->config, 0x2);

Ah, here it is. This should go into the previous patch instead.

>       /* PCI latency timer = 255 */
>       pci_dev->config[PCI_LATENCY_TIMER] = 0xff;
> @@ -1228,21 +1219,8 @@ pvscsi_post_load(void *opaque, int version_id)
>       return 0;
>   }
>   
> -static bool pvscsi_vmstate_need_pcie_device(void *opaque)
> -{
> -    PVSCSIState *s = PVSCSI(opaque);
> -
> -    return !(s->compat_flags & PVSCSI_COMPAT_DISABLE_PCIE);
> -}
> -
> -static bool pvscsi_vmstate_test_pci_device(void *opaque, int version_id)
> -{
> -    return !pvscsi_vmstate_need_pcie_device(opaque);
> -}
> -
>   static const VMStateDescription vmstate_pvscsi_pcie_device = {
>       .name = "pvscsi/pcie",
> -    .needed = pvscsi_vmstate_need_pcie_device,
>       .fields = (const VMStateField[]) {
>           VMSTATE_PCI_DEVICE(parent_obj, PVSCSIState),
>           VMSTATE_END_OF_LIST()
> @@ -1256,9 +1234,8 @@ static const VMStateDescription vmstate_pvscsi = {
>       .pre_save = pvscsi_pre_save,
>       .post_load = pvscsi_post_load,
>       .fields = (const VMStateField[]) {
> -        VMSTATE_STRUCT_TEST(parent_obj, PVSCSIState,
> -                            pvscsi_vmstate_test_pci_device, 0,
> -                            vmstate_pci_device, PCIDevice),
> +        VMSTATE_STRUCT(parent_obj, PVSCSIState, 0,
> +                       vmstate_pci_device, PCIDevice),

I think this is wrong, too. pvscsi_vmstate_test_pci_device() should return 
false for modern machines, so this should be removed instead?

  Thomas




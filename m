Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CED8C44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 11:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm8Pf-0002OI-KE; Tue, 21 Jul 2026 07:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wm8PU-0002MC-Md
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 07:13:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wm8PT-0000Ba-0W
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 07:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784632394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rQ9kRaJLjO2WGiPc5CjouYXuLHNO9uZo5SjulZ7K2IA=;
 b=DXNtkUwNaCPgwji38eaB40cxeIutTNt131UmlF6KT0n4B32rAs/7fgDNqhp3DJhVrI7DHM
 W3WXu60mIgJUnMje4xWrtW3P1SOqglOovbAHIxriS/wJ9F/t2BQU4qjw12dFp+iAR0zTOM
 C06cgGRt+h60Oc3vUzusn6L7QSoDu/I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-OTi54nEfOny-uNBwAC_Luw-1; Tue, 21 Jul 2026 07:13:12 -0400
X-MC-Unique: OTi54nEfOny-uNBwAC_Luw-1
X-Mimecast-MFC-AGG-ID: OTi54nEfOny-uNBwAC_Luw_1784632392
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47407691804so7831930f8f.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 04:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784632391; x=1785237191; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rQ9kRaJLjO2WGiPc5CjouYXuLHNO9uZo5SjulZ7K2IA=;
 b=A1E6/r2uN0aaM79HaVwDRVYlpybLSL7c+uxpXbcL08HXkOlVSlyXr18LIRIpHcORTw
 YLrOWoW5pFk106FNH14b3/VECW52NSh438ukKeuz7Jnq82sfj5zMUoXwOLg+sv/+2C8j
 nQuwiQqv+rpdAEdj1qLGNHW0zBId3LUFNLWsAgh3s6tUN34Evqjl6q/bdyVl39xN/WZd
 Tqp8MA1LHoGCSa+zs310Rgb91qFvO+wk/7/6pNE4oS8j7VWBIosJ9Ti/+9zweGozLxhd
 GOLDSEw91fcGr6G8x6q2doNkAgEG21gmfg1WTPCAMHPLsoW4GLQ+POqeQEuOR0APf2s8
 fWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784632391; x=1785237191;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rQ9kRaJLjO2WGiPc5CjouYXuLHNO9uZo5SjulZ7K2IA=;
 b=SDQTTvtksXNHPwC3zfsO2mb1fGG+CaKqG1iJAeELJqkzEc1N/QdG6ZDIaHJ3vCqyjU
 H1wSkgFn6SJm0GnEw3A3pUn+20Ev8Yq9rcTZtEDPijo/gnRHCvbACZhdqmxGLj7Uenma
 u2gmWCH22P62g7hlWtFS2tHSoKb2RYEquRbXI/RyzDLprNzxtI/OUuK1zAVUzu/+KbpI
 5H0kBhF6QVkLqmZIzkGQInApTs8inH8L6f4of3hdnq14+/Ork6c6Y2TZQJl96DSROnl6
 WvqS/z3TWK9e3bCrsFUgksfZgfbo2TQsQ4Lb77sPIHiypqHYLJRf74gc4bPQdoXeCjb4
 246g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqkiUwTdFdFzKE5nV3S63U4jSIVHqdXx0qAazfNJwsTtxD4j/1X2zb8shRXR8NnxSHRf578z/Hb5KwU@nongnu.org
X-Gm-Message-State: AOJu0YxpFz6UxCdBklbjooJU7AsDSJWRjn+ON81UTjiw6pdVG7iFGpwe
 KhvcsrtkY+pzWEQ8aE4+nZNz12ENgAPB00K6jJAL7hsL5gHMg53UtDtUCKKdiM8LNHVUweuWjnn
 tu2hAJLTiq0GFNNbOLQVmE8ApDvT3bOeCaKUTXBBLQvAjpoUqDnXpBrQs
X-Gm-Gg: AR+sD116MUIsDDzG4WTkPJ5yOfSXmpPLybgG5b/BeTeoAaAvjNLdGi0vemm0TOv1oXk
 +AzZnAmiO23YlZ+yihkMKsOGxqQCGh+53jBYACbAI2AVSO9feaiu69w9Koct09u8zSbJeOGI9ZG
 aody2baIkefouHNu4x46LU8fawhrDkWEmUosyqb9VxtsRgxiIWdZT+m/RgkWZrW9CVKKO0MGkfQ
 TSOHCv7l+7JRSXBe+vaEd0IzKaVQXzXgukEAWV8ysaMmgVibiQJeuwB1H6+SOx6KIklWvEjARbC
 UeVnYxqBxyuOLKUckmj16m+SGnXA9MINXnf/vyC6CltK1+59H/0oOu9ArrZAJxKFJBz4feAPd+W
 PtHt+UflmluDUhvmkbHIS+//svBV5Vzarcxv479M=
X-Received: by 2002:a05:6000:4b0e:b0:47f:5371:1b15 with SMTP id
 ffacd0b85a97d-47f623173c1mr20617126f8f.26.1784632391560; 
 Tue, 21 Jul 2026 04:13:11 -0700 (PDT)
X-Received: by 2002:a05:6000:4b0e:b0:47f:5371:1b15 with SMTP id
 ffacd0b85a97d-47f623173c1mr20617088f8f.26.1784632391076; 
 Tue, 21 Jul 2026 04:13:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ed244bsm2023759f8f.20.2026.07.21.04.13.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 04:13:10 -0700 (PDT)
Message-ID: <bf33df32-94bd-41c1-9554-5c6b85742820@redhat.com>
Date: Tue, 21 Jul 2026 13:13:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/pci: Guard accel_irqchip_begin_route_changes() calls
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
References: <20260721105026.3932297-1-clg@redhat.com>
 <ade146fa-58cf-4ebc-90a8-259d8bf1c137@oss.qualcomm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <ade146fa-58cf-4ebc-90a8-259d8bf1c137@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On 7/21/26 13:04, Philippe Mathieu-Daudé wrote:
> On 21/7/26 12:50, CÃ©dric Le Goater wrote:
>> Since commit 49b2dcbd2422 ("accel/accel-irq: add generic
>> begin_route_changes"), accel_irqchip_begin_route_changes() aborts when
>> no accelerator irqchip is available. This causes a fatal error when
>> running VFIO passthrough devices under TCG emulation:
>>
>>    qemu-system-aarch64: can't initiate route change, no accel irqchip available
>>
>> The previous kvm_irqchip_begin_route_changes() was a simple inline
>> that did not have a fatal path. The VFIO code already handles the
>> absence of KVM MSI routing gracefully by falling back to userspace
>> handling, but the new generic function aborts before that fallback
>> can take effect.
>>
>> Guard the call sites in hw/vfio/pci.c with
>> accel_msi_via_irqfd_enabled() so that route changes are only
>> initiated when an accelerator irqchip is actually present.
>>
>> Fixes: 49b2dcbd2422 ("accel/accel-irq: add generic begin_route_changes")
>> Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   hw/vfio/pci.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 380dd8c15f8d5bb98b725075978eef2e4e1e6c2d..a3147d28665abd29fd804bd08bdffc3c7440033c 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -699,7 +699,7 @@ static int vfio_msix_vector_do_use(PCIDevice *pdev, unsigned int nr,
>>           if (msg) {
>>               if (vdev->defer_kvm_irq_routing) {
>>                   vfio_pci_add_kvm_msi_virq(vdev, vector, nr, true);
>> -            } else {
>> +            } else if (accel_msi_via_irqfd_enabled()) {
>>                   vfio_route_change = accel_irqchip_begin_route_changes();
> 
> Pre-existing, either we use the accel_*() API which is agnostic to the
> host hw accelerator implementation (KVM, MSHV), 
> or we directly use the hw API.

That would be a partial revert. I am fine with that.

C.

> 
>>                   vfio_pci_add_kvm_msi_virq(vdev, vector, nr, true);
> 
> Here there is an implicit KVM dependency, so I'm not sure why we have
> these accel_* calls. Maybe "system/accel-irq.h" is incomplete in that
> regard.
> 
>>                   accel_irqchip_commit_route_changes(&vfio_route_change);
>> @@ -801,7 +801,9 @@ void vfio_pci_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
>>   {
>>       assert(!vdev->defer_kvm_irq_routing);
>>       vdev->defer_kvm_irq_routing = true;
>> -    vfio_route_change = accel_irqchip_begin_route_changes();
>> +    if (accel_msi_via_irqfd_enabled()) {
> 
> (IOW here I'd rather a kvm_msi_via_irqfd_enabled() call)
> 
>> +        vfio_route_change = accel_irqchip_begin_route_changes();
>> +    }
>>   }
>>   void vfio_pci_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev)
> 



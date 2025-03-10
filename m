Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA10FC28B2E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 07:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trXit-0004Di-KB; Mon, 10 Mar 2025 03:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trXie-00045k-9C
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 03:38:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trXic-0005B3-4l
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 03:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741592312;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GVlHPqi6khAgp4NROThPCeWZ+Jjizn4nCkjDIbu+9os=;
 b=h7CsP0ausl+sYjEqpENXr9v/mlbFACydGb9swqdoiOhGW9N2LizLLMo7/cSePJFr4ZNCW0
 +FMFaNtC5xnA5V3+ETteslKPz059RVrKrb1aE2O+YY5bHRRQaHxHZkDxiU7btVOPsK4Gtu
 Q6xgIORM+nYLpLxIbywBjfccoFZWpSU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-exjvroqsMLW8Pu_LEa_Jkg-1; Mon, 10 Mar 2025 03:38:31 -0400
X-MC-Unique: exjvroqsMLW8Pu_LEa_Jkg-1
X-Mimecast-MFC-AGG-ID: exjvroqsMLW8Pu_LEa_Jkg_1741592310
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cf172ff63so4093095e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 00:38:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741592310; x=1742197110;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GVlHPqi6khAgp4NROThPCeWZ+Jjizn4nCkjDIbu+9os=;
 b=jMZDNOk3RkJFKq/y2INbGB2ZoFKXM7QvTvp6vXWsIbmOuH5TxKJC4bxFlm7GOAlwqH
 tQbMuHU/PFkVfP+8jRrnZj/nlNjAGjlHA5sq/wk0g9ncVb7aTmgmdmSXr+UYG0VVX44+
 UGln3v9r9rICKml+ml6+hVyUoASxUtrxdyJUp83Km4+XWM5tHEF6CaqB3v7Mm3ij7vpL
 6mIduEAEwYg00oEXmFJXKljNr5dgfUiY51X/KVjecePS5viVKCrfo6GDPoNWsgGmg2oj
 jO13yNtIXgzkPJ6wcQGSG8rltIk6U9KsNppg0Ih4hhEyUprxbQilCnGKm0fICXyp9TSU
 c7Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXk9x1RAVK7PI4XPmtxOZNVnTp0F9/TYaC9DodhPTS82RhLCz+4StcMWj8SgLL+zOVri/cuPRsP8YM5@nongnu.org
X-Gm-Message-State: AOJu0YwGOLSw/nqs8kTLH5pSEh+kEf6hXCjjQBCYwk/72zKSk0Qhcrxl
 umHq0GP0NdiNbeaNkW7QL+q9DV/IH/vvRDJ+3qibEXWgtuF4qOl+EEDIGbV6Vftzsw+S1xpKZZC
 uuafFwJ7A+nsNrMTl8EVhIMy6Kz+OjxvL0VIczFKP9zb4xUSSZKVijh/KevpV5VQ=
X-Gm-Gg: ASbGncsJdKKiN5b7Y9TPzSiV+T2euqw8Uzhu4IIDorVnfo8RjrRe57BGfx3MY6muGb/
 CKznAbRj0w6Yp5wlmnmIabCa8Ypr9T4LmaKDLFn3SXAfie2BT75dUHgxrZ4iivOzUbaox7dtZqO
 Vy7op2DOKvuEcedoBI3Fmy/1TL7oEex0xVijfSzzBKMdCHWSdR5nUKBk45a4yxAlE8XDE9E21mB
 ds8x1sRS7ZxfI7TwDlKpc0Vd39KJP4ruiFbLI8nPhBKcutaKByIsFwdJImod/xPaOzTQar4kEB0
 MRBgmuE38sjvnAq8uqTPNEWXN1Eg3bM5yHM+KJNfWlmHKnqwszIdaw==
X-Received: by 2002:a05:6000:18af:b0:391:3b1b:f3b7 with SMTP id
 ffacd0b85a97d-3913b1bf54amr3942326f8f.28.1741592310033; 
 Mon, 10 Mar 2025 00:38:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiahtuiON9qB1ZPT4rXfJHltu8gWbLn4mRq/nAUaKEk5h5U+ZW+r1nn9PUl4zpjFgM9R7lmA==
X-Received: by 2002:a05:6000:18af:b0:391:3b1b:f3b7 with SMTP id
 ffacd0b85a97d-3913b1bf54amr3942313f8f.28.1741592309669; 
 Mon, 10 Mar 2025 00:38:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43cf86b1d80sm25719405e9.9.2025.03.10.00.38.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 00:38:29 -0700 (PDT)
Message-ID: <1446fd11-c5fe-44b6-afad-3483bea22325@redhat.com>
Date: Mon, 10 Mar 2025 08:38:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/21] hw/vfio/igd: Define TYPE_VFIO_PCI_IGD_LPC_BRIDGE
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Tomita Moeko
 <tomitamoeko@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-s390x@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
 <20250308230917.18907-12-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250308230917.18907-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/9/25 00:09, Philippe Mathieu-Daudé wrote:
> Define TYPE_VFIO_PCI_IGD_LPC_BRIDGE once to help
> following where the QOM type is used in the code.
> We'll use it once more in the next commit.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/pci-quirks.h | 2 ++
>   hw/vfio/igd.c        | 4 ++--
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/pci-quirks.h b/hw/vfio/pci-quirks.h
> index d1532e379b1..fdaa81f00aa 100644
> --- a/hw/vfio/pci-quirks.h
> +++ b/hw/vfio/pci-quirks.h
> @@ -69,4 +69,6 @@ typedef struct VFIOConfigMirrorQuirk {
>   
>   extern const MemoryRegionOps vfio_generic_mirror_quirk;
>   
> +#define TYPE_VFIO_PCI_IGD_LPC_BRIDGE "vfio-pci-igd-lpc-bridge"
> +
>   #endif /* HW_VFIO_VFIO_PCI_QUIRKS_H */
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index b1a237edd66..1fd3c4ef1d0 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -262,7 +262,7 @@ static void vfio_pci_igd_lpc_bridge_class_init(ObjectClass *klass, void *data)
>   }
>   
>   static const TypeInfo vfio_pci_igd_lpc_bridge_info = {
> -    .name = "vfio-pci-igd-lpc-bridge",
> +    .name = TYPE_VFIO_PCI_IGD_LPC_BRIDGE,
>       .parent = TYPE_PCI_DEVICE,
>       .class_init = vfio_pci_igd_lpc_bridge_class_init,
>       .interfaces = (InterfaceInfo[]) {
> @@ -524,7 +524,7 @@ void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
>       lpc_bridge = pci_find_device(pci_device_root_bus(&vdev->pdev),
>                                    0, PCI_DEVFN(0x1f, 0));
>       if (lpc_bridge && !object_dynamic_cast(OBJECT(lpc_bridge),
> -                                           "vfio-pci-igd-lpc-bridge")) {
> +                                           TYPE_VFIO_PCI_IGD_LPC_BRIDGE)) {
>           error_report("IGD device %s cannot support legacy mode due to existing "
>                        "devices at address 1f.0", vdev->vbasedev.name);
>           return;



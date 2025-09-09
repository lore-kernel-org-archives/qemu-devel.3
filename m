Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B717CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 09:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvuxl-0006pC-Lk; Tue, 09 Sep 2025 05:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvuxk-0006od-DX
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 05:48:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvuxg-0002c5-NA
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 05:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757411305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=4m3VrIT4UXudgFWquh/W82XRbXvppGT1+CdRs3MqVt4=;
 b=SLIds2+UpOA8e+n9c2XFAq85YbpggROcrzoPuj92r2S06toptVTj3o43+dDP2O1+TkwEDN
 2Nzl7g5ri0jt8/8xvb4Hi5xfJdOycYjmdLveZCs4HhWzY2sPh+NDOGNwfVYflFsFwNc7MU
 FOIhkpPB/f/7mlOp/vizzgqJ0bfQlMc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-TmtUGcDdOQuvT2jVDuou_g-1; Tue, 09 Sep 2025 05:48:24 -0400
X-MC-Unique: TmtUGcDdOQuvT2jVDuou_g-1
X-Mimecast-MFC-AGG-ID: TmtUGcDdOQuvT2jVDuou_g_1757411303
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3e38ae5394aso3261972f8f.3
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 02:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757411303; x=1758016103;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4m3VrIT4UXudgFWquh/W82XRbXvppGT1+CdRs3MqVt4=;
 b=inRUkbWYFO8X8HXrBRHpzEcViSSJNtd70Jtx8Rbqfb3mMJTwA9bjVPypazttBsqELW
 lL5QFG4zQb5eZ+l1ywG5E1eHgKpiExCNW/04yJbLEVP7YsR5TsT/D6XjlzAfuZm0uFLM
 OnKauC3apzMYHSPMEWUP0u/xNcjtT1ODMuPnnwNN0UaScuwTmLGa4sF2o89EUmbsdQ4j
 J3AGJtb2eTrmCkuTWHRqTGx9D+rl2fXrZ1T104IH7IjuC+3tk3pk3wvYoeNTAZrndWYM
 HlmKfGi6BkdtIee/0Ef6yaetPwSz8cgO8OiKCkor0wDxCJkkiy3XI/ShgvJmubejZRTH
 RRJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/62Zhh98TxxsG+u8Jylcqt7Fx9ZW5iRsg6b4BSaQXEO4hOaSMmic/WoaW/u3UxNuLQvPb/4cTuAbQ@nongnu.org
X-Gm-Message-State: AOJu0YxsD0/NQ0Tt8MU+UYeuyL5p7/Hg/tjwjwas54InvyDEUezDZCOH
 4uRHy5VhUKrMFOLAdjSAahFFDkgQ3MRrwKlRPO2XabpeqOGjkEi6g12erYBJEh1WGWnpyvx72Hd
 WSkgD75A+YrqVfNrzT6S6NNyhiIaIathPm1v+Mm0upAXNydFXZoNnhrJ5
X-Gm-Gg: ASbGncvALSe7GvndKXAdLXhWsm6xHtgXE2MweVmQOGcrLTrLzUl7F20E4UKtQeQXnri
 udk4VWwYReKh4hdnC67H+j72L/JnzTzzdV2v2wM7xLJ6hGnOZa29+GeJh05QmEDswyiWIaRk/6B
 CUtyPUQM6V1mXvlDJy9o7s6bYfTlGJpaTtN4xUnapXc7mYcT1IxdeiCCqUUixynU5EMla+cVvUE
 t7wh3YhLGDXiaPvhOJM4OcSFP7G58941HvpIBWHdWEozqDVxelONRhDWN/VvItoj2zyJYawCcMZ
 vV1c2oLruWA6qGC2uljAFb/pgN0RQpKoIpFz8p1cxFabPp1BewznG6kqb3yAGdyKGf+Cvgw8nWD
 uJI81XQ==
X-Received: by 2002:a5d:5f82:0:b0:3e7:4244:bff5 with SMTP id
 ffacd0b85a97d-3e74244c4fdmr6084246f8f.8.1757411302749; 
 Tue, 09 Sep 2025 02:48:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn6hwD9odY5mnElUW67kAcoAKl3/ktt+HOwCsonoaLSVKf9xmO4jqzGNNcTP393dwCicL9lQ==
X-Received: by 2002:a5d:5f82:0:b0:3e7:4244:bff5 with SMTP id
 ffacd0b85a97d-3e74244c4fdmr6084217f8f.8.1757411302251; 
 Tue, 09 Sep 2025 02:48:22 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-183.pools.arcor-ip.net.
 [47.64.113.183]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e7522562d1sm1873563f8f.63.2025.09.09.02.48.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Sep 2025 02:48:21 -0700 (PDT)
Message-ID: <a55814af-3792-43e2-8cc8-2b2688786183@redhat.com>
Date: Tue, 9 Sep 2025 11:48:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/22] sun4m: Fix AddressSpace exposure timing
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20250906-use-v1-0-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
 <20250906-use-v1-8-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250906-use-v1-8-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 06/09/2025 04.11, Akihiko Odaki wrote:
> sun4m-iommu is not hotpluggable but its instance can still be created
> and finalized when processing the device-list-properties QMP command.
> Exposing such a temporary instance to AddressSpace should be
> avoided because it leaks the instance.
> 
> Expose instances to the AddressSpace at their realization time so that
> it won't happen for the temporary instances.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   hw/sparc/sun4m_iommu.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/sparc/sun4m_iommu.c b/hw/sparc/sun4m_iommu.c
> index a7ff36ee78c1d6295efea6499dffc2a481022167..0997f29ccb97d3dec4e3d34db49f2e51b6807a1a 100644
> --- a/hw/sparc/sun4m_iommu.c
> +++ b/hw/sparc/sun4m_iommu.c
> @@ -359,7 +359,6 @@ static void iommu_init(Object *obj)
>       memory_region_init_iommu(&s->iommu, sizeof(s->iommu),
>                                TYPE_SUN4M_IOMMU_MEMORY_REGION, OBJECT(dev),
>                                "iommu-sun4m", UINT64_MAX);
> -    address_space_init(&s->iommu_as, MEMORY_REGION(&s->iommu), "iommu-as");
>   
>       sysbus_init_irq(dev, &s->irq);
>   
> @@ -368,6 +367,13 @@ static void iommu_init(Object *obj)
>       sysbus_init_mmio(dev, &s->iomem);
>   }
>   
> +static void iommu_realize(DeviceState *dev, Error **errp)
> +{
> +    IOMMUState *s = SUN4M_IOMMU(dev);
> +
> +    address_space_init(&s->iommu_as, MEMORY_REGION(&s->iommu), "iommu-as");
> +}
> +
>   static const Property iommu_properties[] = {
>       DEFINE_PROP_UINT32("version", IOMMUState, version, 0),
>   };
> @@ -377,6 +383,7 @@ static void iommu_class_init(ObjectClass *klass, const void *data)
>       DeviceClass *dc = DEVICE_CLASS(klass);
>   
>       device_class_set_legacy_reset(dc, iommu_reset);
> +    dc->realize = iommu_realize;
>       dc->vmsd = &vmstate_iommu;
>       device_class_set_props(dc, iommu_properties);
>   }

Reviewed-by: Thomas Huth <thuth@redhat.com>



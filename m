Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2546CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 08:42:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0yao-0000n3-1K; Tue, 23 Sep 2025 04:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0yah-0000lk-KN
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 04:41:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0yaE-0004VT-TZ
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 04:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758616867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/y3uiOEjFgaZ68ELaVL1FQHuWTc0uLeeqz6c5M3zFCU=;
 b=SSAzlrCZfiLyue+WzM/dNM99CDfGjkCQvEn7ZN8cbMLaZ9evE0YFAeTraDIsQQf274UBed
 ZbgnNciIYnVQyaA2K7nHbRn2KTLoaKq10Gt+e5esA6T0anH9Paaxiox086546qPARJ7dyF
 KCPKShSbUM8cDjwPot9uZigbbhoQ080=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-yHw40JLEPce5ZUFFE3a-uQ-1; Tue, 23 Sep 2025 04:41:05 -0400
X-MC-Unique: yHw40JLEPce5ZUFFE3a-uQ-1
X-Mimecast-MFC-AGG-ID: yHw40JLEPce5ZUFFE3a-uQ_1758616865
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b044a42959dso713137266b.1
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 01:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758616864; x=1759221664;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/y3uiOEjFgaZ68ELaVL1FQHuWTc0uLeeqz6c5M3zFCU=;
 b=LuYX12dWmQFn8WWipYcZqZJkH3E2NQHTJG39SHtFT/x3RlUPsUbrmDsxeyWNXbUbc5
 uETiGZOB4r4r3LGlbaKcJ3zJm0btbyHoGdXL1un/6o8gxITqAkhovmretECdLdlUB18l
 tDaFtBho7fdItyDQlWgzXftaAUl48FC3JGZIuHF1BVW7ZRTSrQVnbgt/A+wkbxEfMufs
 QMDeAhGbH4SRfkOV4OdnlRQvQp47sBAKLwMqSIYWwJI1Xbw3sXlBlB36qoJvTBaOY+/a
 oQD1gZcY+UBuxS1V3KwM7/z3lt1hiwOpQ2JDXjbOLz9XQbUkGd10nGi/yQy9z2XcZXvq
 lApQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXR/jK+J5iEk6j06QOgvsQaImD51gVBE94Q3G5LEsWvYW2F6fSMLHY/m2PW0rnZO6nrNY93Mc7eiRrC@nongnu.org
X-Gm-Message-State: AOJu0YzdMEkcbOSeePV0HX39d4TYTeD/HfWXTmqWCkzi5+msi31nHfuv
 s14QU++y3ajP/4pVjQc5hGcDxebOlUXu9fbmJDiM7E/2s47mg0A37WQFVx/jhtCjfWTC5x5Zetf
 Dl0GPPmELrB0dKK3NlLlDKNorPq0zON9oDUECbpoDL1xNX8IkQqKmtS+E0Dhxq2/M
X-Gm-Gg: ASbGncsM+F7+4813Nr/Sse3Ofc+TaVDTecuPwc3EcaJuLwFBsN32Q+rVMkKhNzJ/I+K
 FAPi0HioT9I99FIGTRDucrLfP5WEr5XpHDCu760ZlrWOxtpGU68xMl28JG5za3oL4Wi+dkSHyZk
 3gPZy7KG1qxYRGZqqLGn3K7pXbkvbWmq3sv9MEN+ScHFkHv2tXOzrk/ot/U04CWSbDqJPbPaIbf
 O0SdhFIlZewPpjVbn1U4HkdUfBzuCxEtdm3BIBxPNMLeBL+MyOJg3ZA9atcPWr80UC2Ghg4UbkU
 0UrtR90H82+DkuLV2ijBW6aPSzJDXCxkuOwsCIDkCbI4VxYEYHt2yNRM7Z4Gd3ubDzwbmhU+L+P
 ztzP0qHkXLRrsOO/86OwFmmnMwDyAaKe6vse3XX+uPp22zg==
X-Received: by 2002:a17:907:928e:b0:b2e:34f1:9dbb with SMTP id
 a640c23a62f3a-b30263b88e7mr170386666b.5.1758616864259; 
 Tue, 23 Sep 2025 01:41:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxi2aYa9OD+TV273DnjkyUIyudEMUT8qLEnh47RmQd7qXGtakupbwFpr/ZvIyJZfsq/K7DUA==
X-Received: by 2002:a17:907:928e:b0:b2e:34f1:9dbb with SMTP id
 a640c23a62f3a-b30263b88e7mr170384166b.5.1758616863728; 
 Tue, 23 Sep 2025 01:41:03 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-b261bdfe871sm950907166b.61.2025.09.23.01.41.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 01:41:02 -0700 (PDT)
Message-ID: <4d26bd5e-8631-4fb3-845f-2027320ed29c@redhat.com>
Date: Tue, 23 Sep 2025 10:41:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] memory: Stop piggybacking on memory region owners
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20250906-mr-v2-0-2820f5a3d282@rsg.ci.i.u-tokyo.ac.jp>
 <20250906-mr-v2-3-2820f5a3d282@rsg.ci.i.u-tokyo.ac.jp>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250906-mr-v2-3-2820f5a3d282@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 9/6/25 04:39, Akihiko Odaki wrote:
> +static int collect_memory_region(Object *child, void *opaque)
> +{
> +    if (object_dynamic_cast(child, TYPE_MEMORY_REGION)) {
> +        g_array_append_val(opaque, child);
> +    }
> +
> +    return 0;
> +}
> +
>   static void device_unparent(Object *obj)
>   {
> +    g_autoptr(GArray) array = g_array_new(FALSE, FALSE, sizeof(Object *));

We can use GPtrArray too, instead.

>       DeviceState *dev = DEVICE(obj);
>       BusState *bus;
>   
> @@ -735,6 +745,12 @@ static void device_unparent(Object *obj)
>           object_unref(OBJECT(dev->parent_bus));
>           dev->parent_bus = NULL;
>       }
> +
> +    object_child_foreach(OBJECT(dev), collect_memory_region, array);
> +
> +    for (gsize i = 0; i < array->len; i++) {
> +        object_unparent(g_array_index(array, Object *, i));
> +    }
>   }
>   
>   static char *

Very good idea!  The purpose of unparent is basically to break the 
circular references, and it's a bit weird to use object_child_foreach 
but it makes a lot of sense.

> diff --git a/hw/display/virtio-gpu-virgl.c b/hw/display/virtio-gpu-virgl.c
> index f5cba8a7fa66..7afcaa4bfe2e 100644
> --- a/hw/display/virtio-gpu-virgl.c
> +++ b/hw/display/virtio-gpu-virgl.c
> @@ -203,6 +203,7 @@ virtio_gpu_virgl_unmap_resource_blob(VirtIOGPU *g,
>           /* memory region owns self res->mr object and frees it by itself */
>           memory_region_set_enabled(mr, false);
>           memory_region_del_subregion(&b->hostmem, mr);
> +        object_unparent(OBJECT(mr));
>           object_unparent(OBJECT(vmr));
>       }g
>   

Can you do this in vmr's unparent callback?  Even the 
memory_region_set_enabled and del_subregion calls could belong there.

> +static void memory_region_unparent(Object *obj)
> +{
> +    MemoryRegion *mr = MEMORY_REGION(obj);
> +
> +    object_ref(mr->owner);
> +}
> +

This probably should assert that OBJECT(mr)->free == memory_region_free. 
  This provides safety, and also clarifies where the matching unref is.

Paolo



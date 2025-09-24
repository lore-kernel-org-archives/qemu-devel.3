Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B7FCAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 15:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1RBK-0003GC-DM; Wed, 24 Sep 2025 11:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1RBE-0003B9-2b
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 11:13:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1RB5-0003SB-AB
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 11:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758726784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+zBj3z5LfvDZj7N3KVZk4nLe2ZU5k4JS+bm1Nb81WWU=;
 b=ghi09Ao10vX3HqDSjmj+Cfjkql/9hXPCPK4pa6s+rmtaJ6OZjj31uy0ZJ1+fhSYW71ggJs
 xm07sxjPp3wBuflpvOe15cTL6ZQJ7y3wBIg0OrQClJB/6GUs70MAk1NpGayFWtkosDGnQO
 BROQkHBX9WaYn8GbKqU5fxNmMfkebSc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-_djSVyZCMWGwDqEkE9YvlQ-1; Wed, 24 Sep 2025 11:13:03 -0400
X-MC-Unique: _djSVyZCMWGwDqEkE9YvlQ-1
X-Mimecast-MFC-AGG-ID: _djSVyZCMWGwDqEkE9YvlQ_1758726782
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46b15e6f227so18343225e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 08:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758726782; x=1759331582;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+zBj3z5LfvDZj7N3KVZk4nLe2ZU5k4JS+bm1Nb81WWU=;
 b=bGoyW5L187KetFyRapsg3mjfJt+w11IzFbFb/4CsNF7EIOmk4iAcuRcLZ02FTb+Axm
 aJ4Mzix4WEn4PPvsZ+fJ+olJKbD8JdLC+19o3Vjl/9HAmcOSzsNuOKoI7cmkY0MNdxPb
 uh0AOclGQGBOUIZX+CHp6GrIYPdwvcFj7Wqrji6qAjzjQvopr3ESmOof4ViWHfr5yeT7
 H4sS3lVuECYfuBFoX3TnwB0+454gypEOK85R0vETCpkk+nqY56UOo5VvH3kTc8LV3A9u
 jFRoheILS+pmmvJ4xp34DWpZ4mmgO3KolEijWYtrScRclMUCAIhjz8t3XgVgGLOkdj6H
 6F7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXaeBBDb1Uifrring05Bn6/WWC5pVeB0L/VVyRP9UxfJiuBVdHQWxAmBLJKvYXExGorIPGA1VOE4gW@nongnu.org
X-Gm-Message-State: AOJu0YytYm+nt3Mw9rx/5vkGEaUTIYAA6KmBu28pooEN6jimRFcXBmW2
 TqCvLcWqfZdrl9pzm/HDBCElJfHPqMSrdbC4I+4VxSKE7+sA35e32J9RBjrJ94zew/vAo2DGD1W
 w/WSP+oubK3FCwdiS/fvYwuiBn1Sjc6qfwW6XLH5gVyVfe2X6vphUuGC1
X-Gm-Gg: ASbGncu4hK5gGYhEkb5ptROqAPgHEhMnwimgO0eEHeP85BULbDKQMyyEYyrce8MDv77
 M9xGgHH/egquPQGK7dq2DJcNJRKElDGYNaXiAeZnG/9R2HA3skezW4dO/+9ZRzOiEMfisjgyd0a
 cxi/1/nBUiLgAf76ujrgZLlVfuaxiuRY05yuiBQEmcTUxokBqHYQsLFNgDi9Zx/RezyhBse/WuR
 0T7IPnIeqM4M9O2GvyeLv29XjrxV0G0k3b0AIrz4QxOf85vZOc8IbZGYRHN5gZLBfhWuc9tlcce
 hY9q4HJbudT8pKY2XCn5Ug4kF+IaPl5p5pwjHfGlVJ0JhI/ZnoD0CBM+kZeRvjgm7IuBKHcEmqQ
 /DF0=
X-Received: by 2002:a05:600c:c168:b0:45d:f897:fbe1 with SMTP id
 5b1f17b1804b1-46e32a0de18mr2212475e9.32.1758726781979; 
 Wed, 24 Sep 2025 08:13:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGu4MYmL26xBxnPZ5rx4H8jppkuAZ4HYn+QOuMInyHbr1D2WIHvTUQ+vUrJe+Yofwzt5fgmA==
X-Received: by 2002:a05:600c:c168:b0:45d:f897:fbe1 with SMTP id
 5b1f17b1804b1-46e32a0de18mr2212115e9.32.1758726781538; 
 Wed, 24 Sep 2025 08:13:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2a9be025sm36127545e9.11.2025.09.24.08.13.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 08:13:01 -0700 (PDT)
Message-ID: <a0d0a1e4-d43f-449f-bc4f-a3e501750a02@redhat.com>
Date: Wed, 24 Sep 2025 17:13:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/27] vfio/pci.c: rename
 vfio_pci_dev_nohotplug_properties[] to vfio_pci_nohotplug_properties[]
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, npiggin@gmail.com,
 harshpb@linux.ibm.com, mjrosato@linux.ibm.com, farman@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, iii@linux.ibm.com,
 john.levon@nutanix.com, thanos.makatos@nutanix.com,
 alex.williamson@redhat.com, steven.sistare@oracle.com, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20250923135352.1157250-1-mark.caveayland@nutanix.com>
 <20250923135352.1157250-21-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250923135352.1157250-21-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 9/23/25 15:53, Mark Cave-Ayland wrote:
> This changes the prefix to match the name of the QOM type.
> 
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/vfio/pci.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 839b5af339..a32a507059 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3924,7 +3924,7 @@ static const TypeInfo vfio_pci_info = {
>       .instance_finalize = vfio_pci_finalize,
>   };
>   
> -static const Property vfio_pci_dev_nohotplug_properties[] = {
> +static const Property vfio_pci_nohotplug_properties[] = {
>       DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
>       DEFINE_PROP_BOOL("use-legacy-x86-rom", VFIOPCIDevice,
>                        use_legacy_x86_rom, false),
> @@ -3937,7 +3937,7 @@ static void vfio_pci_nohotplug_dev_class_init(ObjectClass *klass,
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
>   
> -    device_class_set_props(dc, vfio_pci_dev_nohotplug_properties);
> +    device_class_set_props(dc, vfio_pci_nohotplug_properties);
>       dc->hotpluggable = false;
>   
>       object_class_property_set_description(klass, /* 3.1 */


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.




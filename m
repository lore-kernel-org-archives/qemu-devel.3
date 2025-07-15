Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 237C0C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 05:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubYb7-0004IP-IC; Tue, 15 Jul 2025 01:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubYaz-0004Eu-Mv
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 01:52:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ubYaw-0005gJ-W9
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 01:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752558770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pnNc1URRzn2V1cZZTOxV0Y823iKjSkXvDR7vxYl4e2s=;
 b=iD3ByBJsEIK3r/oMdkVq0ZuyfBld7wW0swHl0HMbMfqpU5XIYdDEPC/9OirPoH76xXe/nn
 ApLMzZjwauxDWxIYslEYCOK3NjH3jOrNMUaExOlhLbiMi1B3HJoQyjxScLXN4fITW2PBdM
 qBw7eV3vjLetrHyznTnQ4J3t60EyUtg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-UV4INdDjMLiXYdpeslQo8g-1; Tue, 15 Jul 2025 01:52:47 -0400
X-MC-Unique: UV4INdDjMLiXYdpeslQo8g-1
X-Mimecast-MFC-AGG-ID: UV4INdDjMLiXYdpeslQo8g_1752558766
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4fac7fa27so1836169f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 22:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752558766; x=1753163566;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pnNc1URRzn2V1cZZTOxV0Y823iKjSkXvDR7vxYl4e2s=;
 b=kbHL2P3//R845b9aio4iMdAaTmNgKvg0JO8lpf195/NQTC9bul5TuNSD82jnv3WrsP
 gO+lsSk9ZaHQ5KX1tnVtZJxcunD0vUj7AQX0pMcmvgY5mJC8GtsitRtu8vk7BfDaQch+
 h9bv7Ha+vO3zmjL/ukrVPGrkKPTi4Eqmo1C0IbPIJeUgod3Wm2WkoXRJmehoEyRFQMHY
 PCKTDUc2bxzOePeIin4ty/0Q6F3Kzb+YF2fi4cIvThlFGWzaIVNO2RuJJEbdqEusOOdQ
 CewNeA+3oijaI3L4cJAlphQltPovQcmBZpyT8eQg5LtOqZE9JEy0EyuKhyS/dAgbg3RB
 uBkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPC69w4PHJa+zYjyrCHNHaGlAKc5oi/6UHC5G29+Tuo/pLGDWR2EFhLIz+c+/rmyZiJY2nNdVotBVQ@nongnu.org
X-Gm-Message-State: AOJu0YyAm/Ne3ARQaikZfmOl8bZFHIFUPCFNi4BfEgiUF/3h9SGMNUpa
 SBC6sJzBpRAw5uk82E91jJQoK+1h5ZhmXcX4a9ed2cJ+ezBGuW7/j7JEXgZudL4T7ku8WoYcXIg
 PV6ScuQP4ahcx5U3perJc1lRR/BbqGhoGzaxWDlU5u8eWGRyRmhtfmwQU
X-Gm-Gg: ASbGnctMfmu2NxS07fuvaXoGr7kNEWOiT/BjdP5xjJzCK3qEwq1I2xW9ZLhBuIkXhke
 Lm3tKyX3rcrmNHxRWzqwbNhc0vK0RPb+YEdvtBDtC0BsTHGemWyea7v3hnqM1uRP0cW3+4FC0C/
 Ox9bE6rKRn2cVBIgzmizY6tryq3hY8uOuM4jdXE4hzwVNNZMAmUucLKYEfRq0vP+iwV6tR/4w0p
 hSNg0Z6pJVzHjlL0obPHg7XXxhZIrsfMmEgEuePnWdmrs+3xQnox5WPY5joqeG2Ft2ezNQK+abg
 Ucgdox/BKdrYKPwPs0bRoMxLs3O8ymmOb0YfEm9UOa3Jes/YXv3SYNh4nP6ovyh6axvKvJ3oXaM
 =
X-Received: by 2002:a05:6000:2085:b0:3a4:f900:21c4 with SMTP id
 ffacd0b85a97d-3b5f2dd4e12mr12676222f8f.26.1752558766384; 
 Mon, 14 Jul 2025 22:52:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1rWqRJlqbxOC7aCL9G50sXnUeZexjRyFItRm3079mO7m6Tr135YEJeCGtws0A5yDUKVJgrg==
X-Received: by 2002:a05:6000:2085:b0:3a4:f900:21c4 with SMTP id
 ffacd0b85a97d-3b5f2dd4e12mr12676207f8f.26.1752558765979; 
 Mon, 14 Jul 2025 22:52:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:266c:b13b:afd7:40fd?
 ([2a01:e0a:165:d60:266c:b13b:afd7:40fd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d70csm14432082f8f.62.2025.07.14.22.52.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 22:52:45 -0700 (PDT)
Message-ID: <205c69d8-468e-4984-b27a-4a5fd619f4c6@redhat.com>
Date: Tue, 15 Jul 2025 07:52:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/vfio: fix region fd initialization
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>
References: <20250710154842.1267253-1-john.levon@nutanix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250710154842.1267253-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/10/25 17:48, John Levon wrote:
> We were not initializing the region fd array to -1, so we would
> accidentally try to close(0) on cleanup for any region that is not
> referenced.
> 
> Fixes: 95cdb024 ("vfio: add region info cache")
> Signed-off-by: John Levon <john.levon@nutanix.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/vfio/device.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 96cf21462c..52a1996dc4 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -463,6 +463,8 @@ void vfio_device_detach(VFIODevice *vbasedev)
>   void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
>                            struct vfio_device_info *info)
>   {
> +    int i;
> +
>       vbasedev->num_irqs = info->num_irqs;
>       vbasedev->num_regions = info->num_regions;
>       vbasedev->flags = info->flags;
> @@ -477,6 +479,9 @@ void vfio_device_prepare(VFIODevice *vbasedev, VFIOContainerBase *bcontainer,
>                                  vbasedev->num_regions);
>       if (vbasedev->use_region_fds) {
>           vbasedev->region_fds = g_new0(int, vbasedev->num_regions);
> +        for (i = 0; i < vbasedev->num_regions; i++) {
> +            vbasedev->region_fds[i] = -1;
> +        }
>       }
>   }
>   
> @@ -489,7 +494,6 @@ void vfio_device_unprepare(VFIODevice *vbasedev)
>           if (vbasedev->region_fds != NULL && vbasedev->region_fds[i] != -1) {
>               close(vbasedev->region_fds[i]);
>           }
> -
>       }
>   
>       g_clear_pointer(&vbasedev->reginfo, g_free);



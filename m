Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC208C19F32
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 16:41:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tngw1-00085z-SW; Thu, 27 Feb 2025 11:40:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tngvW-0007kv-P4
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 11:39:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tngvT-0006Pf-OL
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 11:39:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740674392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GZbmYDegWRpErtZfsLgO/o3dDOMudEBcocApZQoF+4Y=;
 b=gGrZo5cv6oIp5iqmUd4cRR+jUEct+0dmE8IF9/z8vFoB62dTRTai80lXYnLj+vaFO4Ywwm
 JFdPBfnyeGF80t8wD+4jr06VPMrN0Uy6WgW2OudK1GFv/EC4hitqgeQu0QxSuq2lxmB2UD
 Ex6kLaCQGCRHoX5ZRJqhJ8a0DFo191Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-qyLxTOQFN1K8fYlGJXthKA-1; Thu, 27 Feb 2025 11:39:49 -0500
X-MC-Unique: qyLxTOQFN1K8fYlGJXthKA-1
X-Mimecast-MFC-AGG-ID: qyLxTOQFN1K8fYlGJXthKA_1740674388
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4394040fea1so6568455e9.0
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 08:39:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740674388; x=1741279188;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GZbmYDegWRpErtZfsLgO/o3dDOMudEBcocApZQoF+4Y=;
 b=f1BTALVLO5GlG1DzhsL40H74P+gggrwjAwExNOBg6LS6LUu7CoPmdqPOnbRPIdIQIS
 j7itxLJ10PFTkFWLnqp0+Wg9pxIWL50QYpqiPDbv+z0e3SoWCFGrkHIurBCe3dsy1KPH
 6uyFezIHKKSLcODTe8sR+b+xj/8DRzykLk8r9dLQaXk+dD293ua6+qKoCVGif8EMH5EM
 u0qYTXRSTnsa19NrZdiz+p1iKJPxxAx4SBdUxYr63qqfBE8pAjqoJ0WNwmbeekyserB6
 1hxf7n1MQR+ogk2Si3B2L0EEHHuKgKO3uXQ1kq15Ygp58uGgkg8fv38uRn8O5RnhccAb
 Z6FQ==
X-Gm-Message-State: AOJu0YzQanQBTV1XZKbE7tUvWwCIMHCfV7Agy/bd7gAPTYgmFoXRKDQt
 y37fdDbPIZtZQJtGIHBHgXWrZacLmyylY8lIrDSw0Wn/j4PPFA6MVpjawls50AxsH0k7IB6B7q4
 V0zHB2kNflN0YBB7lrSaeGKQb3sSDlkq0mcyU26Cveai2giRVFROP
X-Gm-Gg: ASbGncsBRXHjBmlsloSkaCBCVbuxu9pFnAHl2Wd266Jop4gDnO/EFv2q38AtK0vAAjn
 ajigDs3Z1lEc8lW2tay+9q/SLbS8EQaZDeWi8W/JUc7jOqKo42iTKBCPO1rrnGM6TLqksCl8ano
 YTXbF10EysqkxByrqj1SdXeUguih1Ji8Nq33aALIc+/OCNPlIlcQUuXfhxoSAaTkYdypBB7C22M
 Xc9q06EDavh+tVgVikvd3HxolA4flZzUOKB1Wpc114A1B4EJ1tbUVC2lgosfQU2ZcfvwDhA5w4d
 Y9mDWcbDpLMA2K3zYlYEHe4tTHemC3o2D3XUBK6KS/+Ld2UBcGJEawD/hKM=
X-Received: by 2002:a05:600c:1c9f:b0:434:9e17:190c with SMTP id
 5b1f17b1804b1-43ba6188e94mr1765725e9.0.1740674387940; 
 Thu, 27 Feb 2025 08:39:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0CP0q69MhOU1f+nfanciRhH5QNMYMs+TkmCe+GX+G+tEKGmjq8T36RrZioUjO5W1mbrajrA==
X-Received: by 2002:a05:600c:1c9f:b0:434:9e17:190c with SMTP id
 5b1f17b1804b1-43ba6188e94mr1765555e9.0.1740674387595; 
 Thu, 27 Feb 2025 08:39:47 -0800 (PST)
Received: from ?IPV6:2a01:cb19:9004:d500:a732:5611:7f59:8bb3?
 ([2a01:cb19:9004:d500:a732:5611:7f59:8bb3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba58720esm61445125e9.40.2025.02.27.08.39.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 08:39:47 -0800 (PST)
Message-ID: <3280d104-b191-49d3-83ab-483eceac47b6@redhat.com>
Date: Thu, 27 Feb 2025 17:39:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add myself as vfio-igd maintainer
To: Tomita Moeko <tomitamoeko@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250227162741.9860-1-tomitamoeko@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250227162741.9860-1-tomitamoeko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

On 2/27/25 17:27, Tomita Moeko wrote:
> As suggested by Cédric, I'm glad to be a maintainer of vfio-igd.
> 
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   MAINTAINERS | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1911949526..c6ed2f46f0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2176,10 +2176,17 @@ M: Cédric Le Goater <clg@redhat.com>
>   S: Supported
>   F: hw/vfio/*
>   F: include/hw/vfio/
> -F: docs/igd-assign.txt
>   F: docs/devel/migration/vfio.rst
>   F: qapi/vfio.json
>   
> +vfio-igd
> +M: Alex Williamson <alex.williamson@redhat.com>
> +M: Cédric Le Goater <clg@redhat.com>
> +M: Tomita Moeko <tomitamoeko@gmail.com>
> +S: Supported
> +F: hw/vfio/igd.c
> +F: docs/igd-assign.txt
> +
>   vfio-ccw
>   M: Eric Farman <farman@linux.ibm.com>
>   M: Matthew Rosato <mjrosato@linux.ibm.com>



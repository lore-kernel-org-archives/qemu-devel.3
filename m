Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A3EC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 13:23:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwMIu-0001iA-Uo; Mon, 15 Apr 2024 09:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rwMIt-0001gq-Gs
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 09:23:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rwMIl-0001dc-HR
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 09:23:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713187394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LaiPyFEsA6l0xEcZ/pFjzVgI0/LNQnmKiy+blNKj0VY=;
 b=W/aEAzqZiGPDRfGbvkEu2F68+xCFV0PgNY8GiGm6wuXYJQsio+ZxLKWdtnL3/vw0OYoiVs
 WrF4LQdvMBQbLtiYpCKbZy3Lnuih2iRPb0FrGRZ8F4sd6oMAJVJSKQFOjWUjBggy739hXU
 DsgDEtBFQfX/60WMZsqRjrGoxq+TC4A=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-zmm2DBEoOpCIEb4Oearxlg-1; Mon, 15 Apr 2024 09:23:12 -0400
X-MC-Unique: zmm2DBEoOpCIEb4Oearxlg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-78e13eddaf3so555486485a.0
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 06:23:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713187392; x=1713792192;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LaiPyFEsA6l0xEcZ/pFjzVgI0/LNQnmKiy+blNKj0VY=;
 b=vNjkvGwAbf3448VQXkfDPs60dr3XMejmKX8mQImAzcgXHpBFE5/1k/axgeb4Xno+cQ
 gh6vDYJc3WIwezKK4u1he+2rOpgbwK8UghWvovZTqq/2ONjtTmjG6kG/BObMk69geVBt
 WaNKqiX+683x1OvTgY1oLRnXimNQSCImkecs6NHWO2y1Qk/XU/QKfYivOjdtt1h3QEId
 uP7zb+XTtC764DQkMdpaNLU5vNytBvign5C58MAEEIqoA2yiU5ZuGoXlxh75kt6x/993
 15mfVWFpsDAh5lsmL2K0dvOPM+bCLo9VUzqst/mrUCqnPtoCxv+4DBhuWDWQz/4c4/0h
 CfVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8YpjhrrC8MTSrk7nFEl1u65mC4ZjH3Gdw+z7TQA3VTNJovnPJBesQeMkccOWj6M2xCf0esm/gwKATUBGuec3QvZTH1S8=
X-Gm-Message-State: AOJu0Yyko+hiYFljKhtBCxGkxwftVF1mJ+DKi5X3QYU+NmeSsmQmUCdJ
 h3XlmYV4KYCZ5l9+YeDwAlycSOV+ZVQJuEeRByL97LnVHO6m0Zz0fb4FQfQiTRa/xQ5AnSmpHm7
 FNX9ZaqkDjHaJMkc0jdsqQ+syDbOUhpMCPS4amtV8gYYv0bk8u7z8
X-Received: by 2002:a05:620a:1a8c:b0:78e:ee2d:5643 with SMTP id
 bl12-20020a05620a1a8c00b0078eee2d5643mr2019035qkb.8.1713187391734; 
 Mon, 15 Apr 2024 06:23:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxe8B68Om8TG+ctyugEdqyOBXUNvyIpuTjiZYZVfMTnVLwlOkDFe/y6ODBnDYS2HDL5ISa9A==
X-Received: by 2002:a05:620a:1a8c:b0:78e:ee2d:5643 with SMTP id
 bl12-20020a05620a1a8c00b0078eee2d5643mr2019014qkb.8.1713187391460; 
 Mon, 15 Apr 2024 06:23:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae?
 ([2a01:e0a:9e2:9000:d55d:ba01:adf2:d3ae])
 by smtp.gmail.com with ESMTPSA id
 bp6-20020a05620a458600b0078ec0e6188asm6326998qkb.89.2024.04.15.06.23.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 06:23:11 -0700 (PDT)
Message-ID: <bc974ba1-a4fe-47d7-9de7-7bc8a6229d86@redhat.com>
Date: Mon, 15 Apr 2024 15:23:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/10] backends/iommufd: Implement
 get_host_iommu_info() callback
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, peterx@redhat.com,
 jasowang@redhat.com, mst@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 joao.m.martins@oracle.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20240408081230.1030078-1-zhenzhong.duan@intel.com>
 <20240408081230.1030078-8-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240408081230.1030078-8-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 4/8/24 10:12, Zhenzhong Duan wrote:
> It calls iommufd_backend_get_device_info() to get host IOMMU
> related information.
> 
> Define a common structure HIOD_IOMMUFD_INFO to describe the info
> returned from kernel. Currently only vtd, but easy to add arm smmu
> when kernel supports.

I think you can merge the previous patch and this one.
  

> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/sysemu/iommufd.h |  7 +++++++
>   backends/iommufd.c       | 17 +++++++++++++++++
>   2 files changed, 24 insertions(+)
> 
> diff --git a/include/sysemu/iommufd.h b/include/sysemu/iommufd.h
> index fa1a866237..44ec1335b2 100644
> --- a/include/sysemu/iommufd.h
> +++ b/include/sysemu/iommufd.h

I just noticed that include/sysemu/iommufd.h lacks a header.  Could you fix
that please ?

> @@ -39,6 +39,13 @@ int iommufd_backend_get_device_info(IOMMUFDBackend *be, uint32_t devid,
>                                       enum iommu_hw_info_type *type,
>                                       void *data, uint32_t len, Error **errp);
>   
> +typedef struct HIOD_IOMMUFD_INFO {

Please use CamelCase names.


Thanks,

C.


> +    enum iommu_hw_info_type type;
> +    union {
> +        struct iommu_hw_info_vtd vtd;
> +    } data;
> +} HIOD_IOMMUFD_INFO;
> +
>   #define TYPE_HIOD_IOMMUFD TYPE_HOST_IOMMU_DEVICE "-iommufd"
>   OBJECT_DECLARE_TYPE(HIODIOMMUFD, HIODIOMMUFDClass, HIOD_IOMMUFD)
>   
> diff --git a/backends/iommufd.c b/backends/iommufd.c
> index 559affa9ec..1e9c469e65 100644
> --- a/backends/iommufd.c
> +++ b/backends/iommufd.c
> @@ -240,8 +240,25 @@ void hiod_iommufd_init(HIODIOMMUFD *idev, IOMMUFDBackend *iommufd,
>       idev->devid = devid;
>   }
>   
> +static int hiod_iommufd_get_host_iommu_info(HostIOMMUDevice *hiod,
> +                                            void *data, uint32_t len,
> +                                            Error **errp)
> +{
> +    HIODIOMMUFD *idev = HIOD_IOMMUFD(hiod);
> +    HIOD_IOMMUFD_INFO *info = data;
> +
> +    assert(sizeof(HIOD_IOMMUFD_INFO) <= len);
> +
> +    return iommufd_backend_get_device_info(idev->iommufd, idev->devid,
> +                                           &info->type, &info->data,
> +                                           sizeof(info->data), errp);
> +}
> +
>   static void hiod_iommufd_class_init(ObjectClass *oc, void *data)
>   {
> +    HostIOMMUDeviceClass *hiodc = HOST_IOMMU_DEVICE_CLASS(oc);
> +
> +    hiodc->get_host_iommu_info = hiod_iommufd_get_host_iommu_info;
>   }
>   
>   static const TypeInfo types[] = {



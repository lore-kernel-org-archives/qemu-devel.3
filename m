Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 996F1CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 13:29:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGH5S-0006jG-Rt; Tue, 04 Nov 2025 08:28:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vGH5P-0006iY-4N
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 08:28:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vGH5L-0006Vj-2G
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 08:28:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762262907;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PMvpD8RG5IOLUwsScffHHMVrs1zIFbBwA3oGpgyCADo=;
 b=AOxfDWBT+SXf3Sy+OfkzZu+u7CIDDfBFdN8JVnpF7y/igzR+J4mCemcON3+NNVnOss3d3D
 dFWP6Jfsm1gTaxdozlbLSoiy3JhBmdCctCIvhwRAMnqDQCb8bHUm+WW/xgoiIXh3vu1lBF
 36qbDrg0j9Glx5It88gcnCyTuQC6/X8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-AhlhH-_6NP2Hj9sXCeVK_A-1; Tue, 04 Nov 2025 08:28:26 -0500
X-MC-Unique: AhlhH-_6NP2Hj9sXCeVK_A-1
X-Mimecast-MFC-AGG-ID: AhlhH-_6NP2Hj9sXCeVK_A_1762262905
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-476b8c02445so44715285e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 05:28:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762262905; x=1762867705;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PMvpD8RG5IOLUwsScffHHMVrs1zIFbBwA3oGpgyCADo=;
 b=eGGg7+SWiKhUIrVleAanqSE0NVjJKHGwVk5RkcTArG0JvytG6hkE8F/ZFOqV4DuIGw
 TVAdk2zJ9qGwamET6iVQl7EUFOcuP8vFHO/HPCD9FOi8Cx24KCZaoRqN5qoq8C8mLjff
 vnQ27bee+Cvh2ThyLQr/sgKNEleNeK/jGKJAYTa9emEiThNCDc4LeS5vKSVsP2UbtwMJ
 /MsbEkU+3SiH+Ronc0VV70AXOrauUeqxanHkyeBdGaYETzozwOxLu+YngTZJ0Q/bh/ye
 lDybhqQXY2/hF65SgEIigDneHwd5AShPQmx0UeWHwdHSBy2ldLc7+MdE+SYAVMYG5gka
 0+KQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0KraWwRZ6dFDg4ZQPXhCKrDybnNa6RaGFNZEofzVMUxUKEuf1qRDBaumevJ1uHX9GZx/kSanF9K9X@nongnu.org
X-Gm-Message-State: AOJu0YykfJme67UFkQhIaW3THt8uq+ugiDBKWSmI7R71EVwdPFpv2WaH
 fcultn4K6CrqvQ1iFmUDFquZE/np+8oiHFvGPztUiplEURC7NlaVK8S+qgUKzd6keJMTryyuwmY
 ZZ3Fguy4U2MOQPDOk1btTOMdksVLx7BUHsEQ3Iwm60+1Qp5y7lUnM+jkl
X-Gm-Gg: ASbGncucxi1NnrTn54kXugg///o2MqhrY/rHa0M180SF+CFPKmiW5htsyVyre8ZqPD2
 UezsZifjDaZD/x99MfWpsLSD9iH8UY8SvmS2WEuLEhT4xc7YWImgYsdUxHWl+XnlA3wIBT/e6jS
 H+9qDaz1d2GFydJPkM5tHhoyUJt32+BYw5O94Zf0Jed8e2Pc8L1jfjPbAgqoBMMg/QAJ+ACxqDk
 jwZAQOgAg4WLOPw/1sJ7euc+oKA+yJR801DYr407o6QPI/J/wmkCkN91Je1mH0Pjpe1gdODxAn8
 4ttT4RVBeJJzi6GKJxXiOBZGu5phicppFM/df7QPs2zialT4QYHPUXyloKC9SZwcABFZwgxWUSs
 nHRi0x64sxKjRqcuO7E7CFtIifel3MzGf2ovSeoJBD2vl7A==
X-Received: by 2002:a05:600c:190e:b0:477:557b:6917 with SMTP id
 5b1f17b1804b1-477557b7939mr21697075e9.18.1762262905160; 
 Tue, 04 Nov 2025 05:28:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqEdJPWOAbE4tEpkHuv7cnvFks1VMz/3iqI/nSU52vM2RuJvBCe2V199bCve1l2I19fZAKtw==
X-Received: by 2002:a05:600c:190e:b0:477:557b:6917 with SMTP id
 5b1f17b1804b1-477557b7939mr21696765e9.18.1762262904716; 
 Tue, 04 Nov 2025 05:28:24 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4775592226fsm17725095e9.11.2025.11.04.05.28.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 05:28:24 -0800 (PST)
Message-ID: <21bcd8a4-53ad-4b00-baa4-98bccd08f2f2@redhat.com>
Date: Tue, 4 Nov 2025 14:28:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/32] hw/arm/smmuv3-accel: Install SMMUv3 GBPA based
 hwpt
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 kjaju@nvidia.com
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-15-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251031105005.24618-15-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shameer,

On 10/31/25 11:49 AM, Shameer Kolothum wrote:
> When the Guest reboots or updates the GBPA we need to attach a nested HWPT
> based on the GBPA register values.
In practice you only take into account GPBA.ABORT bit. Also reminds what
this latter does, ie.
"attach a nested HWPT based on the new GPBA.ABORT bit which either
aborts all incoming transactions or bypass them"
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  hw/arm/smmuv3-accel.h |  8 ++++++++
>  hw/arm/smmuv3.c       |  2 ++
>  3 files changed, 52 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index c74e95a0ea..0573ae3772 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -479,6 +479,48 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
>      .unset_iommu_device = smmuv3_accel_unset_iommu_device,
>  };
>  
> +
> +/* Based on SMUUv3 GBPA configuration, attach a corresponding HWPT */
> +void smmuv3_accel_gbpa_update(SMMUv3State *s)
> +{
> +    SMMUv3AccelDevice *accel_dev;
> +    Error *local_err = NULL;
> +    SMMUViommu *vsmmu;
> +    uint32_t hwpt_id;
> +
> +    if (!s->accel || !s->s_accel->vsmmu) {
> +        return;
> +    }
> +
> +    vsmmu = s->s_accel->vsmmu;
> +    /*
> +     * The Linux kernel does not allow configuring GBPA MemAttr, MTCFG,
> +     * ALLOCCFG, SHCFG, PRIVCFG, or INSTCFG fields for a vSTE. Host kernel
I think in general we shall avoid doing any assumptions about linux
kernel capability.
> +     * has final control over these parameters. Hence, use one of the
It seems to be contradictory to the above statement.
> +     * pre-allocated HWPTs depending on GBPA.ABORT value.
I would remove the comment
> +     */
> +    if (s->gbpa & SMMU_GBPA_ABORT) {
> +        hwpt_id = vsmmu->abort_hwpt_id;
> +    } else {
> +        hwpt_id = vsmmu->bypass_hwpt_id;
> +    }
> +
> +    QLIST_FOREACH(accel_dev, &vsmmu->device_list, next) {
> +        if (!host_iommu_device_iommufd_attach_hwpt(accel_dev->idev, hwpt_id,
> +                                                   &local_err)) {
> +            error_append_hint(&local_err, "Failed to attach GBPA hwpt id %u "
> +                              "for dev id %u", hwpt_id, accel_dev->idev->devid);
> +            error_report_err(local_err);
> +        }
> +    }
> +}
> +
> +void smmuv3_accel_reset(SMMUv3State *s)
> +{
> +     /* Attach a HWPT based on GBPA reset value */
> +     smmuv3_accel_gbpa_update(s);
> +}
> +
>  static void smmuv3_accel_as_init(SMMUv3State *s)
>  {
>  
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index 73b44cd7be..8931e83dc5 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -51,6 +51,8 @@ bool smmuv3_accel_install_nested_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
>                                       Error **errp);
>  bool smmuv3_accel_install_nested_ste_range(SMMUv3State *s, SMMUSIDRange *range,
>                                             Error **errp);
> +void smmuv3_accel_gbpa_update(SMMUv3State *s);
> +void smmuv3_accel_reset(SMMUv3State *s);
>  #else
>  static inline void smmuv3_accel_init(SMMUv3State *s)
>  {
> @@ -67,6 +69,12 @@ smmuv3_accel_install_nested_ste_range(SMMUv3State *s, SMMUSIDRange *range,
>  {
>      return true;
>  }
> +static inline void smmuv3_accel_gbpa_update(SMMUv3State *s)
> +{
> +}
> +static inline void smmuv3_accel_reset(SMMUv3State *s)
> +{
> +}
>  #endif
>  
>  #endif /* HW_ARM_SMMUV3_ACCEL_H */
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 1fd8aaa0c7..cc32b618ed 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1603,6 +1603,7 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>          if (data & R_GBPA_UPDATE_MASK) {
>              /* Ignore update bit as write is synchronous. */
>              s->gbpa = data & ~R_GBPA_UPDATE_MASK;
> +            smmuv3_accel_gbpa_update(s);
>          }
>          return MEMTX_OK;
>      case A_STRTAB_BASE: /* 64b */
> @@ -1885,6 +1886,7 @@ static void smmu_reset_exit(Object *obj, ResetType type)
>      }
>  
>      smmuv3_init_regs(s);
> +    smmuv3_accel_reset(s);
>  }
>  
>  static void smmu_realize(DeviceState *d, Error **errp)
Besides

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric



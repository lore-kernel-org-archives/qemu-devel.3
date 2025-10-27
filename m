Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE01BCCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 10:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDKEt-0005OJ-Kr; Mon, 27 Oct 2025 06:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDKEo-0005Nf-4g
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 06:14:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDKEh-0004WV-8j
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 06:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761560031;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JSHHfliy6qHRJosNd2kP2URfDNrRmYLqA9ukDVE2wUI=;
 b=AegybdhTBVSO3A1fkKRHsbQWRq5ZZenrCkvH+g6og1Vka1nYDVVj6ZMNbTcT/TD/dDgz2o
 zYe3TMJSfuO6msrRHvuQDvIHuSxuW5DcVCOU7YUai9dBFm8Cyx2WKRR05h4V42m8PSUqmO
 5y+Z4H2PNrFH3d4f46PFSCU9Bd0GYlE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-guR56mtnPwqdagkzRYEhbQ-1; Mon, 27 Oct 2025 06:13:49 -0400
X-MC-Unique: guR56mtnPwqdagkzRYEhbQ-1
X-Mimecast-MFC-AGG-ID: guR56mtnPwqdagkzRYEhbQ_1761560029
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4770e0910a1so5597155e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 03:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761560028; x=1762164828;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JSHHfliy6qHRJosNd2kP2URfDNrRmYLqA9ukDVE2wUI=;
 b=JUqsBYnwWR9M5n3Ec9D5zJ59eCsrjkNealcM+ZLgV3BafowDVfXdhtD4UFGz9g5F8x
 tD9B4C4NvB4REavJicyYO3vXUclTuVtZua6sKzBfhkm3LoNQpoPLU8GErDs6yKKAPUNJ
 rXgF6Xxy32dV/ZFj7VYLDxQrig+twtGvNP1c51ZgA9ut+xe6TJ7ZEZ+Qg7xR5Gwn5lqq
 Se6VXNw4+xUvfkgqL4aUmfQnkI8VaKxXaqydzKySFxgJVa8cqTZ4TymM16qFqHY3QDNx
 GF1asd1CAc/pWCMD74IDzR7ZStU1lPHyi08Xs6mAfVaQZJXXrl5TamFVbJZD0jdeKxrH
 5cMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp5NekkvFDhM/nL8oYHXoY2g3HsCbVF9EeCfDOnixOUb6fzlUbkupsDypZlBlC1cgWZEdsyDhSpt/q@nongnu.org
X-Gm-Message-State: AOJu0YxDWwuY581BrPAIEY63r16JKfegbn933K3/jB40hlSAKIOywcxO
 j3JPC67k+bk/JmdNrUvlZxTCBPlqwKLN0NqH3ZcR1DmULcDIxRJ8OV2lkIv3hmUEXlBi+lUiujl
 heqetudBelIasT1Vdq0rl+Ev36zfFcfIch+Z3IvxySc286JzQxCwBfZhH
X-Gm-Gg: ASbGnctYKW2kGHmYhH1e7D33Sma3kkLwVlYRcSHDFUnTGPzTVreVPC9mUaWS94q7FLl
 z0J2Ox6C15jn1djAA18fgrHp4Achu10389550TGtJZMvY8hyVSV+tXs0kuYKcBNYzgbgDed0P8B
 GbAY11366SfRxW40FE2F5oZc7Wh2HHEbVt186+y89jleggurEAlzz1wsNaOk3o9UEro4NR/Py3v
 GvWbabH1/2tiw5Hu3+xAKVgyU0ttGiA3hJXSMPdE7Z7tDEUr0lX6/Oiet8FdtpgxP7lQZBWHVJR
 ID0g3osaUZLS4lQQsGRSPwRfk7po5fbPRi93XVXLxrZ2V/xYMx3k+uLo1KWJBndRpe4qhQFrdMU
 zlFisDv32TchLFyf1WlWBcQckuqPg4ljVhsdxmhPpPb91oQ==
X-Received: by 2002:a05:600d:41cf:b0:471:c72:c7f8 with SMTP id
 5b1f17b1804b1-475d2ec5554mr80052995e9.21.1761560028446; 
 Mon, 27 Oct 2025 03:13:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjmXPzJYixWjtTS6tg3e2B3uDL8bltdFaMnMFK1dDFx+1tzg90gyQbrjLTNq04y0TnLG1J/g==
X-Received: by 2002:a05:600d:41cf:b0:471:c72:c7f8 with SMTP id
 5b1f17b1804b1-475d2ec5554mr80052645e9.21.1761560027969; 
 Mon, 27 Oct 2025 03:13:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd37467esm131984925e9.10.2025.10.27.03.13.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 03:13:47 -0700 (PDT)
Message-ID: <ae832b8b-5f37-41d1-b259-5bff0843eac0@redhat.com>
Date: Mon, 27 Oct 2025 11:13:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/27] hw/arm/smmuv3-accel: Add support to issue
 invalidation cmd to host
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 shameerkolothum@gmail.com
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-14-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250929133643.38961-14-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Shameer,

On 9/29/25 3:36 PM, Shameer Kolothum wrote:
> Provide a helper and use that to issue the invalidation cmd to host SMMUv3.
> We only issue one cmd at a time for now.
>
> Support for batching of commands will be added later after analysing the
> impact.
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c | 38 ++++++++++++++++++++++++++++++++++++++
>  hw/arm/smmuv3-accel.h |  8 ++++++++
>  hw/arm/smmuv3.c       | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 76 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index f4e01fba6d..9ad8595ce2 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -218,6 +218,44 @@ bool smmuv3_accel_install_nested_ste_range(SMMUv3State *s, SMMUSIDRange *range,
>      return true;
>  }
>  
> +/*
> + * This issues the invalidation cmd to the host SMMUv3.
> + * Note: sdev can be NULL for certain invalidation commands
> + * e.g., SMMU_CMD_TLBI_NH_ASID, SMMU_CMD_TLBI_NH_VA etc.
> + */
> +bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
> +                                Error **errp)
> +{
> +    SMMUv3State *s = ARM_SMMUV3(bs);
> +    SMMUv3AccelState *s_accel = s->s_accel;
> +    IOMMUFDViommu *viommu_core;
> +    uint32_t entry_num = 1;
> +
> +    if (!s->accel || !s_accel->viommu) {
Can you explain/document why !s_accel->viommu is handled as no error?
> +        return true;
> +    }
> +
> +   /*
> +    * We may end up here for any emulated PCI bridge or root port type devices.
> +    * However, passing invalidation commands with sid (eg: CFGI_CD) to host
> +    * SMMUv3 only matters for vfio-pci endpoint devices. Hence check that if
> +    * sdev is valid.
Only propagate errors to host if the SDEV matches a VFIO devices?
> +    */
> +    if (sdev) {
> +        SMMUv3AccelDevice *accel_dev = container_of(sdev, SMMUv3AccelDevice,
> +                                                    sdev);
> +        if (!accel_dev->vdev) {
> +            return true;
> +        }
> +    }
> +
> +    viommu_core = &s_accel->viommu->core;

> +    return iommufd_backend_invalidate_cache(
> +                   viommu_core->iommufd, viommu_core->viommu_id,
> +                   IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3,
> +                   sizeof(Cmd), &entry_num, cmd, errp);
what shall we do if iommufd_backend_invalidate_cache() succeeds with
output entry_num is different from onput one? In current case we have
entry_num = 1 so maybe this is not possible but we might leave a comment
at least?
> +}
> +
>  static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
>                                                 PCIBus *bus, int devfn)
>  {
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index 6242614c00..3bdba47616 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -46,6 +46,8 @@ bool smmuv3_accel_install_nested_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
>                                       Error **errp);
>  bool smmuv3_accel_install_nested_ste_range(SMMUv3State *s, SMMUSIDRange *range,
>                                             Error **errp);
> +bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
> +                                Error **errp);
>  #else
>  static inline void smmuv3_accel_init(SMMUv3State *s)
>  {
> @@ -62,6 +64,12 @@ smmuv3_accel_install_nested_ste_range(SMMUv3State *s, SMMUSIDRange *range,
>  {
>      return true;
>  }
> +static inline bool
> +smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
> +                           Error **errp)
> +{
> +    return true;
> +}
>  #endif
>  
>  #endif /* HW_ARM_SMMUV3_ACCEL_H */
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 1fd8aaa0c7..3963bdc87f 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1381,6 +1381,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>          {
>              uint32_t sid = CMD_SID(&cmd);
>              SMMUDevice *sdev = smmu_find_sdev(bs, sid);
> +            Error *local_err = NULL;
>  
>              if (CMD_SSEC(&cmd)) {
>                  cmd_error = SMMU_CERROR_ILL;
> @@ -1393,11 +1394,17 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>  
>              trace_smmuv3_cmdq_cfgi_cd(sid);
>              smmuv3_flush_config(sdev);
> +            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, sdev, &local_err)) {
> +                error_report_err(local_err);
> +                cmd_error = SMMU_CERROR_ILL;
> +                break;
> +            }
>              break;
>          }
>          case SMMU_CMD_TLBI_NH_ASID:
>          {
>              int asid = CMD_ASID(&cmd);
> +            Error *local_err = NULL;
>              int vmid = -1;
>  
>              if (!STAGE1_SUPPORTED(s)) {
> @@ -1416,6 +1423,11 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>              trace_smmuv3_cmdq_tlbi_nh_asid(asid);
>              smmu_inv_notifiers_all(&s->smmu_state);
>              smmu_iotlb_inv_asid_vmid(bs, asid, vmid);
> +            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, &local_err)) {
> +                error_report_err(local_err);
> +                cmd_error = SMMU_CERROR_ILL;
> +                break;
> +            }
>              break;
>          }
>          case SMMU_CMD_TLBI_NH_ALL:
do we check somewhere that accel mode only applies to stage=1?

Thanks

Eric
> @@ -1440,18 +1452,36 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>              QEMU_FALLTHROUGH;
>          }
>          case SMMU_CMD_TLBI_NSNH_ALL:
> +        {
> +            Error *local_err = NULL;
> +
>              trace_smmuv3_cmdq_tlbi_nsnh();
>              smmu_inv_notifiers_all(&s->smmu_state);
>              smmu_iotlb_inv_all(bs);
> +            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, &local_err)) {
> +                error_report_err(local_err);
> +                cmd_error = SMMU_CERROR_ILL;
> +                break;
> +            }
>              break;
> +        }
>          case SMMU_CMD_TLBI_NH_VAA:
>          case SMMU_CMD_TLBI_NH_VA:
> +        {
> +            Error *local_err = NULL;
> +
>              if (!STAGE1_SUPPORTED(s)) {
>                  cmd_error = SMMU_CERROR_ILL;
>                  break;
>              }
>              smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1);
> +            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, &local_err)) {
> +                error_report_err(local_err);
> +                cmd_error = SMMU_CERROR_ILL;
> +                break;
> +            }
>              break;
> +        }
>          case SMMU_CMD_TLBI_S12_VMALL:
>          {
>              int vmid = CMD_VMID(&cmd);



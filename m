Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98681CCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 17:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFy6P-0002Vs-Lp; Mon, 03 Nov 2025 12:12:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFy5o-0002Dv-EJ
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 12:11:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFy5i-0001NB-5V
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 12:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762189886;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SJ+XS2sHCI1PLpY2+jnvvaeaHzZnyp8ybozpBVWfPxw=;
 b=VVQkritPPaWNKKbEIjU9pgGbsTdXo1kqLIgGRRZztQZxW/4yKvWBEdSkzw4gFy6J8u9pQh
 kQyAyoujFedQcfqGTi2XPt3sgaIggNEl/8DJZQAbaH3cuR9j/Mrv2quW6dI3q9IT1iYpKM
 QWQzubhDBuD11GebYZT6o+bieO56jzo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-jooE7hqbO-2Hz4Avw0jfdw-1; Mon, 03 Nov 2025 12:11:25 -0500
X-MC-Unique: jooE7hqbO-2Hz4Avw0jfdw-1
X-Mimecast-MFC-AGG-ID: jooE7hqbO-2Hz4Avw0jfdw_1762189883
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-475c422fd70so35011615e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 09:11:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762189883; x=1762794683;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SJ+XS2sHCI1PLpY2+jnvvaeaHzZnyp8ybozpBVWfPxw=;
 b=vKJPxAa+tLEr+hq4K4aMzQPXVAXYORBagKsprDENmj8Rjtv81tkKdvNJmdlQtJTxs6
 evahiuxBmReTB7I4j4QCYWeNoOVpmEAZSKAY2/Z2Iy3hCuZH9wSeF/npf2V1TATVDXkw
 uCa/Q8rfap7b58rthX9q8M8QjeYc7MU/bqIW+PttpRjlcy7RcCjD90I5xx0/mAAD18su
 9Z3Fsl8udGQuRayV7+SGMjKHZKfRWBQO8U/MdIzlki6Qcld9LqNM4/gAO6ZHGm1Z6kI6
 g+NCM8DAxzmngCKC5GxTnMBtm2PuWZEHQoZLdEdlx4xkrjwGh9K8PNlm3GQ55lFwe1TZ
 /DgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXftlJ70CtNh9P0LlQzJ76ud2vavN4vsB6drThNra7Aq2QqBuFuvTYQ1C/mIzqMzBxFioR9J0urEiE2@nongnu.org
X-Gm-Message-State: AOJu0YwnqB/bC0OJUWNUOWAFcsSdxOTNCQG8dxjcoaHHw1EaFz5QorJt
 yY7LaadCMvm0Qdbni7MwXkXdjl69Q4oxKApZV+ItruQlwScVEnR6ilYhcdOP1HmPEWcG2xZfvrY
 OCoSuicgEkoH4UWl3/JktpSLgPQp4BCkDcmsWXwqo7FwGvRNEF5tyObHF
X-Gm-Gg: ASbGncu+rhbPmnbiKYIovCh6wAEtylQNr8CAZZpRO+Rxq7qzCf8IA7vk/jZSuma/EI/
 Zum3V0yxQtfI2b37K8pj12WZ8KB6Qd4Umq3ZS1KATA7RoeKT2NEM/m29gegqWpf9oT2icH24aTO
 SWHz+pXortuaP1wE9SBXLl0ZLgcdnLp2lkNC5fjp4JtsoHlBZ82Y9DCQwsBTMpqBR3HJZq6SerC
 m2elb7EbAPbfOzeQghhoMcLsSYpF7yCsazVrZX6DQmjmvXvh9iNjseDi4hI41wkmg2d9RSw0zp/
 o5CuJKcqvCBi0xqUDhjC25LWckLcTMvFjSAl1Wocp7eQLMFNMKaIwwvlEHGiHD5kPycGpT4vNJm
 0WVyMrcYd/ITK59u0G6MsGWqKXNRU6mmC7Kofaks5JEh5fA==
X-Received: by 2002:a05:600c:3e8f:b0:475:dac3:699f with SMTP id
 5b1f17b1804b1-477307c1470mr120241855e9.9.1762189882614; 
 Mon, 03 Nov 2025 09:11:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGedabXDEnfFByUbQXEj3t81LICHvjKbHh7ECKYK0pv1JUbO1t9JHHxVXai0KKMyphARJ9aww==
X-Received: by 2002:a05:600c:3e8f:b0:475:dac3:699f with SMTP id
 5b1f17b1804b1-477307c1470mr120241495e9.9.1762189882135; 
 Mon, 03 Nov 2025 09:11:22 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c8910c42sm15640484f8f.7.2025.11.03.09.11.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 09:11:21 -0800 (PST)
Message-ID: <8bacc738-72f2-4771-964e-771c45693d4c@redhat.com>
Date: Mon, 3 Nov 2025 18:11:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/32] hw/arm/smmuv3-accel: Add support to issue
 invalidation cmd to host
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
 <20251031105005.24618-18-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251031105005.24618-18-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 10/31/25 11:49 AM, Shameer Kolothum wrote:
> Provide a helper and use that to issue the invalidation cmd to host SMMUv3.
> We only issue one cmd at a time for now.
>
> Support for batching of commands will be added later after analysing the
> impact.
>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/smmuv3-accel.c | 35 +++++++++++++++++++++++++++++++++++
>  hw/arm/smmuv3-accel.h |  8 ++++++++
>  hw/arm/smmuv3.c       | 30 ++++++++++++++++++++++++++++++
>  3 files changed, 73 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 395c8175da..a2deda3c32 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -213,6 +213,41 @@ bool smmuv3_accel_install_nested_ste_range(SMMUv3State *s, SMMUSIDRange *range,
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
> +    IOMMUFDViommu *viommu;
> +    uint32_t entry_num = 1;
> +
> +    /* No vIOMMU means no VFIO/IOMMUFD devices, nothing to invalidate. */
> +    if (!s_accel || !s_accel->vsmmu) {
> +        return true;
> +    }
> +
> +    /*
> +     * Called for emulated bridges or root ports, but SID-based
> +     * invalidations (e.g. CFGI_CD) apply only to vfio-pci endpoints
> +     * with a valid vIOMMU vdev.
> +     */
> +    if (sdev && !container_of(sdev, SMMUv3AccelDevice, sdev)->vdev) {
> +        return true;
> +    }
> +
> +    viommu = &s_accel->vsmmu->viommu;
> +    /* Single command (entry_num = 1); no need to check returned entry_num */
> +    return iommufd_backend_invalidate_cache(
> +                   viommu->iommufd, viommu->viommu_id,
> +                   IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3,
> +                   sizeof(Cmd), &entry_num, cmd, errp);
> +}
> +
>  static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
>                                                 PCIBus *bus, int devfn)
>  {
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index 8931e83dc5..ee79548370 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -51,6 +51,8 @@ bool smmuv3_accel_install_nested_ste(SMMUv3State *s, SMMUDevice *sdev, int sid,
>                                       Error **errp);
>  bool smmuv3_accel_install_nested_ste_range(SMMUv3State *s, SMMUSIDRange *range,
>                                             Error **errp);
> +bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
> +                                Error **errp);
>  void smmuv3_accel_gbpa_update(SMMUv3State *s);
>  void smmuv3_accel_reset(SMMUv3State *s);
>  #else
> @@ -69,6 +71,12 @@ smmuv3_accel_install_nested_ste_range(SMMUv3State *s, SMMUSIDRange *range,
>  {
>      return true;
>  }
> +static inline bool
> +smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
> +                           Error **errp)
> +{
> +    return true;
> +}
>  static inline void smmuv3_accel_gbpa_update(SMMUv3State *s)
>  {
>  }
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index cc32b618ed..15173ddc9c 100644
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



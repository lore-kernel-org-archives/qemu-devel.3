Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78F0CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 14:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDNrD-0000Yu-8e; Mon, 27 Oct 2025 10:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDNqw-0000X6-7b
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 10:05:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDNqj-0002BQ-Ji
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 10:05:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761573926;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WSQRCj4KaPGs7uorAnGS8HDOdi8ZFHjPriteS/dBpXA=;
 b=YKkwVS2qGityKx1gH2DAJvVaRZD8+W1RAwRDy0G7D92RtlZ+TWlKTxeo3jiaKYP5Ze5igI
 n54WMsqPb3gHOajRhwPvdfVM0zEU+GVO3DafMMKuZPCtxG8D7Qn4lShUFtiwcSORli/f8z
 Sgdusf9UvLbTkkjrGYJKIPdBPeOiFuM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-SqZZbl29NMWys3XtvN2Ajw-1; Mon, 27 Oct 2025 10:05:22 -0400
X-MC-Unique: SqZZbl29NMWys3XtvN2Ajw-1
X-Mimecast-MFC-AGG-ID: SqZZbl29NMWys3XtvN2Ajw_1761573920
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-470fd92ad57so57376965e9.3
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 07:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761573920; x=1762178720;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WSQRCj4KaPGs7uorAnGS8HDOdi8ZFHjPriteS/dBpXA=;
 b=sIgYMRGJN0vkMkZY9NqDVrJaqLC++1RFuGOoaOzFnBWfdyHn5D1WtxlP9zjOjmjpZh
 7N2nXayF7xaAdPjshYZ9PgKts6e3oj6x0m+JW+3KEkjYFlGG/mLgZyYAxzq1gnNy2IXK
 EgaME4po4i8YvmmfDlIEIuL76uewGZloEknVbXUFPZGhFgPSx9P8Nl7ZoMIwJzNiUQeG
 h3mzh0Gq45OFoKPKAObKm0FxRZOA2HfchJcsCt79rrFQ7dxUKYmPTlPHPbL7dGwnzrvq
 CFOYTiEGHAPcETXHrkKZJkGDG8IJzccgJWbehp+Wy+SWxEj3SPqFeYh90cHbm9dw+P84
 Bxpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLZEq34QmV8cI6zgso4SiOZoMuSzzZ9o5hHTmB+w1JHYKm9q3Frd7QKUAqAcWCt8VGYUxoBFLJhFqm@nongnu.org
X-Gm-Message-State: AOJu0Yzp2ggEVu40HRM1maH2Ek881kAnIGGwevvNnb45AIuaqx1MZdDW
 VV1g4wRb02QZjgMDqJye4c2U5Axp6ncMIRN60bCDBRnx32W00/QOyEi49fVrOMFXdfS+6c1snJ4
 YBwRAyOc3+ZwCi0xzFY0nXfP2TRd5ZymqTAQa8/FuuijkbPVYDAM0Ic6p
X-Gm-Gg: ASbGncv1lreuVrXUOBUP62MCl2AXsORtOOZnn6A3bLFLel5PZfNJTvK1ZL6SL0/W3os
 +fZVQddv2Uv9B6Z0/bnG3sdnaYqlNz7b487/ivJHXi9GTS6MVaPc/gzukgk30t3mGHfvjTDxgO2
 z3yfHpt29+Qv+WvKpW38VcobGc53QU9SN+XcDqtLPzPE0RdXVrWn0i7sOV91/+x5tJsh435Mc/Z
 4olBxEnLc49rvmUb2WpqMQiZ86PDrMGpfdylds084wii7Tdda67ksq54bWxBnfvWoGPARMYjfk9
 DMM6JhGLNQLycFrykF4QteADRa2nj/qKDcbh5ajPn8UVKRWh6AwQspUIFVDgqlLclVAkIhZVrac
 MU3ISMEITFP6IvQrhsyb4pL7xjZmx+JCJa9GXTTORF3SPDg==
X-Received: by 2002:a05:600c:6214:b0:475:dd59:d8da with SMTP id
 5b1f17b1804b1-475dd59dbe1mr68252685e9.40.1761573918597; 
 Mon, 27 Oct 2025 07:05:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9+2VRwhH/3TdstVIqcPufqMlAxK3spqj7uQpKTBIhGFCV4h3E6kq24MpsEiBBtufe0lrDIw==
X-Received: by 2002:a05:600c:6214:b0:475:dd59:d8da with SMTP id
 5b1f17b1804b1-475dd59dbe1mr68251375e9.40.1761573916637; 
 Mon, 27 Oct 2025 07:05:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475ddad455fsm70328895e9.2.2025.10.27.07.05.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 07:05:16 -0700 (PDT)
Message-ID: <1dff400c-f338-4223-871c-3fd9abd51a26@redhat.com>
Date: Mon, 27 Oct 2025 15:05:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/27] hw/arm/smmuv3-accel: Add support to issue
 invalidation cmd to host
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, Nathan Chen
 <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-14-skolothumtho@nvidia.com>
 <ae832b8b-5f37-41d1-b259-5bff0843eac0@redhat.com>
 <IA0PR12MB7555A43B79F8C8B2B7ED18E1ABFCA@IA0PR12MB7555.namprd12.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <IA0PR12MB7555A43B79F8C8B2B7ED18E1ABFCA@IA0PR12MB7555.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



On 10/27/25 1:20 PM, Shameer Kolothum wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 27 October 2025 10:14
>> To: Shameer Kolothum <skolothumtho@nvidia.com>; qemu-
>> arm@nongnu.org; qemu-devel@nongnu.org
>> Cc: peter.maydell@linaro.org; Jason Gunthorpe <jgg@nvidia.com>; Nicolin
>> Chen <nicolinc@nvidia.com>; ddutile@redhat.com; berrange@redhat.com;
>> Nathan Chen <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
>> smostafa@google.com; wangzhou1@hisilicon.com;
>> jiangkunkun@huawei.com; jonathan.cameron@huawei.com;
>> zhangfei.gao@linaro.org; zhenzhong.duan@intel.com; yi.l.liu@intel.com;
>> shameerkolothum@gmail.com
>> Subject: Re: [PATCH v4 13/27] hw/arm/smmuv3-accel: Add support to issue
>> invalidation cmd to host
>>
>> External email: Use caution opening links or attachments
>>
>>
>> Hi Shameer,
>>
>> On 9/29/25 3:36 PM, Shameer Kolothum wrote:
>>> Provide a helper and use that to issue the invalidation cmd to host SMMUv3.
>>> We only issue one cmd at a time for now.
>>>
>>> Support for batching of commands will be added later after analysing
>>> the impact.
>>>
>>> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
>>> ---
>>>  hw/arm/smmuv3-accel.c | 38
>> ++++++++++++++++++++++++++++++++++++++
>>>  hw/arm/smmuv3-accel.h |  8 ++++++++
>>>  hw/arm/smmuv3.c       | 30 ++++++++++++++++++++++++++++++
>>>  3 files changed, 76 insertions(+)
>>>
>>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c index
>>> f4e01fba6d..9ad8595ce2 100644
>>> --- a/hw/arm/smmuv3-accel.c
>>> +++ b/hw/arm/smmuv3-accel.c
>>> @@ -218,6 +218,44 @@ bool
>> smmuv3_accel_install_nested_ste_range(SMMUv3State *s, SMMUSIDRange
>> *range,
>>>      return true;
>>>  }
>>>
>>> +/*
>>> + * This issues the invalidation cmd to the host SMMUv3.
>>> + * Note: sdev can be NULL for certain invalidation commands
>>> + * e.g., SMMU_CMD_TLBI_NH_ASID, SMMU_CMD_TLBI_NH_VA etc.
>>> + */
>>> +bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd,
>> SMMUDevice *sdev,
>>> +                                Error **errp) {
>>> +    SMMUv3State *s = ARM_SMMUV3(bs);
>>> +    SMMUv3AccelState *s_accel = s->s_accel;
>>> +    IOMMUFDViommu *viommu_core;
>>> +    uint32_t entry_num = 1;
>>> +
>>> +    if (!s->accel || !s_accel->viommu) {
>> Can you explain/document why !s_accel->viommu is handled as no error?
> !s_accel->viommu basically means there are no vfio-pci devices with iommufd 
> backend.  I will add a comment.
>
>>> +        return true;
>>> +    }
>>> +
>>> +   /*
>>> +    * We may end up here for any emulated PCI bridge or root port type
>> devices.
>>> +    * However, passing invalidation commands with sid (eg: CFGI_CD) to host
>>> +    * SMMUv3 only matters for vfio-pci endpoint devices. Hence check that if
>>> +    * sdev is valid.
>> Only propagate errors to host if the SDEV matches a VFIO devices?
> The vdev is only allocated for a valid idev device. The below !accel_dev->vdev
> checks that.
yes. I was suggesting a rephrasing
>
>>> +    */
>>> +    if (sdev) {
>>> +        SMMUv3AccelDevice *accel_dev = container_of(sdev,
>> SMMUv3AccelDevice,
>>> +                                                    sdev);
>>> +        if (!accel_dev->vdev) {
>>> +            return true;
>>> +        }
>>> +    }
>>> +
>>> +    viommu_core = &s_accel->viommu->core;
>>> +    return iommufd_backend_invalidate_cache(
>>> +                   viommu_core->iommufd, viommu_core->viommu_id,
>>> +                   IOMMU_VIOMMU_INVALIDATE_DATA_ARM_SMMUV3,
>>> +                   sizeof(Cmd), &entry_num, cmd, errp);
>> what shall we do if iommufd_backend_invalidate_cache() succeeds with
>> output entry_num is different from onput one? In current case we have
>> entry_num = 1 so maybe this is not possible but we might leave a comment at
>> least?
> Ok. I will add that to comment.
>
>>> +}
>>> +
>>>  static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs,
>> SMMUPciBus *sbus,
>>>                                                 PCIBus *bus, int
>>> devfn)  { diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
>>> index 6242614c00..3bdba47616 100644
>>> --- a/hw/arm/smmuv3-accel.h
>>> +++ b/hw/arm/smmuv3-accel.h
>>> @@ -46,6 +46,8 @@ bool smmuv3_accel_install_nested_ste(SMMUv3State
>> *s, SMMUDevice *sdev, int sid,
>>>                                       Error **errp);  bool
>>> smmuv3_accel_install_nested_ste_range(SMMUv3State *s,
>> SMMUSIDRange *range,
>>>                                             Error **errp);
>>> +bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd,
>> SMMUDevice *sdev,
>>> +                                Error **errp);
>>>  #else
>>>  static inline void smmuv3_accel_init(SMMUv3State *s)  { @@ -62,6
>>> +64,12 @@ smmuv3_accel_install_nested_ste_range(SMMUv3State *s,
>>> SMMUSIDRange *range,  {
>>>      return true;
>>>  }
>>> +static inline bool
>>> +smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice
>> *sdev,
>>> +                           Error **errp) {
>>> +    return true;
>>> +}
>>>  #endif
>>>
>>>  #endif /* HW_ARM_SMMUV3_ACCEL_H */
>>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c index
>>> 1fd8aaa0c7..3963bdc87f 100644
>>> --- a/hw/arm/smmuv3.c
>>> +++ b/hw/arm/smmuv3.c
>>> @@ -1381,6 +1381,7 @@ static int
>> smmuv3_cmdq_consume(SMMUv3State *s)
>>>          {
>>>              uint32_t sid = CMD_SID(&cmd);
>>>              SMMUDevice *sdev = smmu_find_sdev(bs, sid);
>>> +            Error *local_err = NULL;
>>>
>>>              if (CMD_SSEC(&cmd)) {
>>>                  cmd_error = SMMU_CERROR_ILL; @@ -1393,11 +1394,17 @@
>>> static int smmuv3_cmdq_consume(SMMUv3State *s)
>>>
>>>              trace_smmuv3_cmdq_cfgi_cd(sid);
>>>              smmuv3_flush_config(sdev);
>>> +            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, sdev, &local_err)) {
>>> +                error_report_err(local_err);
>>> +                cmd_error = SMMU_CERROR_ILL;
>>> +                break;
>>> +            }
>>>              break;
>>>          }
>>>          case SMMU_CMD_TLBI_NH_ASID:
>>>          {
>>>              int asid = CMD_ASID(&cmd);
>>> +            Error *local_err = NULL;
>>>              int vmid = -1;
>>>
>>>              if (!STAGE1_SUPPORTED(s)) { @@ -1416,6 +1423,11 @@ static
>>> int smmuv3_cmdq_consume(SMMUv3State *s)
>>>              trace_smmuv3_cmdq_tlbi_nh_asid(asid);
>>>              smmu_inv_notifiers_all(&s->smmu_state);
>>>              smmu_iotlb_inv_asid_vmid(bs, asid, vmid);
>>> +            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, NULL, &local_err)) {
>>> +                error_report_err(local_err);
>>> +                cmd_error = SMMU_CERROR_ILL;
>>> +                break;
>>> +            }
>>>              break;
>>>          }
>>>          case SMMU_CMD_TLBI_NH_ALL:
>> do we check somewhere that accel mode only applies to stage=1?
> See patch #7. We mandate stage-1 for accel=on case.
Yes. I noticed that later on. thanks

Eric
>
> Thanks,
> Shameer
>



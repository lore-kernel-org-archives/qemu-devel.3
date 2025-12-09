Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9962AD3B7FF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 16:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT0H5-0007mJ-R4; Tue, 09 Dec 2025 11:09:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vT0Gn-0007lY-QK
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:08:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vT0Gm-0006Lq-1N
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765296535;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1g41inXIlucCSAeLOyhD8KeeGH7HWy6ghOsq6rMsvVw=;
 b=TD/YqrAlMA+2kH5gzkY+K6nnZXLuRyI0sPfkZ9oY0QNDnh9x5DYSEx4cyUFtiPohM3euVz
 1Jy2dHWUyVnRfnldylzcKWC59zZfpnB4qw7FK3dWqhJXGQb6kCHAkbk6FrZiAvj7lOiX8/
 p+fcORmIIG7UYLTOcdRf3gsXGedLU6o=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-oq4PCM07M6qPAak23yrgNw-1; Tue, 09 Dec 2025 11:08:51 -0500
X-MC-Unique: oq4PCM07M6qPAak23yrgNw-1
X-Mimecast-MFC-AGG-ID: oq4PCM07M6qPAak23yrgNw_1765296531
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8b2ea3d12fcso1265256185a.0
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 08:08:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765296531; x=1765901331;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1g41inXIlucCSAeLOyhD8KeeGH7HWy6ghOsq6rMsvVw=;
 b=qLgmpZcKhGZadFkGKOjEShfYDBLGON3F6hgoS3V8x6FD3wEUfjqsbqMhiyW5O0ANCW
 KadVM0SJd0fQzNHa0bMqneiqVIaMvD+QSSuhS/WWhHvzG8tqGljj+QGa8Q4I17HDUI0E
 p8ppCpVbniZmpVnNpyAC9hUiK8YtNVuP5RFXn7AAp3tTcBJRrL1QUpskPRNqNbq47e7H
 kYQKDjnJ8O9NdLPz6hWdOvBzXV7vJ9wv6hBZfxqzzxMh6ZjObInLNFbhBNppmF0n7L71
 QFzyZmsNQBfcmKoIh3xIREphi87bQigxtWxzybY9NgAOPxjR6UxpfRK6QXTq/xf8E3yu
 U3ZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUr9MRk236uhanP0h/cAfWc0lmphHLpcbCTcUhxDo6AFQxvzZHg1WZPb+ubXyuHvFb3UO7d6eX/HMbX@nongnu.org
X-Gm-Message-State: AOJu0YwJU2N48k7ZliVU+pD8ztagykX3/CInKo2dfYEwD9I9iYs6Zl81
 UptrBHlW8CX7+EX5MiYFInnnX9mdU/VRMv9yacrofZLH/+Y6pxizpthlqTIWMZseTH3AVTJ7Fpw
 pT/gLfJ5bGS68Oy3Ha4U0D9SomxXJ9zu+EG7LKGUnZ/DpGvEYCfIUDP1Z
X-Gm-Gg: ASbGncvaEI9zwFB+x2veFbqZ8KSk40xOJ73boaxINufHeFEpeQPUxwmEnrG9qqmuLmp
 eOQeNfUsheYNsWXdGXwFSba4p3DLT++hz7z5A5i1ncaJI/NNr7oCm+uVpbb4RpZGljbcfQzqTVO
 cOF1ITK3OMUlmEqoDP4NYgkYD8TRrCxDBTMK5OXwr0JV/b9moOKj2fCQ7s2zDTZBQ2D4cN1avQ8
 BS00pyp/2gftn5rwnoRtE2qd/7fB8yDPi0Ol01z8UpDTcjRmS210xGbz0LLtaRMasg+ARI8Jv77
 Js5x+Zatg0p7/I7uqaUrw/APnGmjY2WxsZUvvodCtp8OmthkDGo5NLXDpih0Zmd8qlhiIgnbkME
 +udk2UMLtpir2GGezppeQY/WK4SM+jxcEkk4og6faM0Jv5qm7mhvqo/xGlA==
X-Received: by 2002:a05:620a:1a9d:b0:89f:db05:1643 with SMTP id
 af79cd13be357-8b6a23f8a7cmr1686748485a.89.1765296531257; 
 Tue, 09 Dec 2025 08:08:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBc6C9M//PYF3Nlh/NFirwmz1Fjva8biSu4TTTkEQ4JFpmzzbulftdlcArHJEaaMDyEk9DYw==
X-Received: by 2002:a05:620a:1a9d:b0:89f:db05:1643 with SMTP id
 af79cd13be357-8b6a23f8a7cmr1686743185a.89.1765296530787; 
 Tue, 09 Dec 2025 08:08:50 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b627a8824csm1320061185a.39.2025.12.09.08.08.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 08:08:50 -0800 (PST)
Message-ID: <8a2675a8-4ab6-4775-86d9-e1e15ff0f50b@redhat.com>
Date: Tue, 9 Dec 2025 17:08:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] hw/arm/smmuv3-accel: Allocate vEVENTQ for
 accelerated SMMUv3 devices
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nicolinc@nvidia.com, nathanc@nvidia.com,
 mochs@nvidia.com, jgg@nvidia.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, kjaju@nvidia.com
References: <20251204092245.5157-1-skolothumtho@nvidia.com>
 <20251204092245.5157-3-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251204092245.5157-3-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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



On 12/4/25 10:22 AM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> When the guest enables the Event Queue and a vIOMMU is present, allocate a
> vEVENTQ object so that host-side events related to the vIOMMU can be
> received and propagated back to the guest.
>
> For cold-plugged devices using SMMUv3 acceleration, the vIOMMU is created
> before the guest boots. In this case, the vEVENTQ is allocated when the
> guest writes to SMMU_CR0 and sets EVENTQEN = 1.
>
> If no cold-plugged device exists at boot (i.e. no vIOMMU initially), the
> vEVENTQ is allocated when a vIOMMU is created, i.e. during the first
> device hot-plug.
>
> Event read and propagation will be added in a later patch.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c | 62 ++++++++++++++++++++++++++++++++++++++++++-
>  hw/arm/smmuv3-accel.h |  6 +++++
>  hw/arm/smmuv3.c       |  4 +++
>  3 files changed, 71 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index dc0f61e841..74f0be3731 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -378,6 +378,58 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
>                     sizeof(Cmd), &entry_num, cmd, errp);
>  }
>  
> +static void smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
> +{
> +    IOMMUFDVeventq *veventq = accel->veventq;
> +
> +    if (!veventq) {
> +        return;
> +    }
> +    iommufd_backend_free_id(accel->viommu.iommufd, veventq->veventq_id);
> +    g_free(veventq);
> +    accel->veventq = NULL;
> +}
> +
> +bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
> +{
> +    SMMUv3AccelState *accel = s->s_accel;
> +    IOMMUFDVeventq *veventq;
> +    uint32_t veventq_id;
> +    uint32_t veventq_fd;
> +
> +    if (!accel) {
> +        return true;
> +    }
> +
> +    if (accel->veventq) {
> +        return true;
> +    }
> +
> +    /*
> +     * Check whether the Guest has enabled the Event Queue. The queue enabled
> +     * means EVENTQ_BASE has been programmed with a valid base address and size.
> +     * If it’s not yet configured, return and retry later.
The comment does not match the code nor the spec:

static inline bool smmuv3_eventq_enabled(SMMUv3State *s) 
{
    return FIELD_EX32(s->cr[0], CR0, EVENTQEN);
}

and in 7.2.1

Events are delivered into an Event queue if the queue is “writable”. The
Event queue is writable when all of the following are true: • The queue
is enabled, through SMMU_(*_)CR0.EVENTQEN for the Security state of the
queue. • The queue is not full (see section 7.4 Event queue overflow
regarding overflow). • No unacknowledged GERROR.EVENTQ_ABT_ERR condition
exists for the queue


> +     */
> +    if (!smmuv3_eventq_enabled(s)) {
> +        return true;
> +    }
> +
> +    if (!iommufd_backend_alloc_veventq(accel->viommu.iommufd,
> +                                       accel->viommu.viommu_id,
> +                                       IOMMU_VEVENTQ_TYPE_ARM_SMMUV3,
> +                                       1 << s->eventq.log2size, &veventq_id,
> +                                       &veventq_fd, errp)) {
> +        return false;
> +    }
> +
> +    veventq = g_new(IOMMUFDVeventq, 1);
> +    veventq->veventq_id = veventq_id;
> +    veventq->veventq_fd = veventq_fd;
> +    veventq->viommu = &accel->viommu;
> +    accel->veventq = veventq;
> +    return true;
> +}
> +
>  static bool
>  smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>                            Error **errp)
> @@ -421,14 +473,21 @@ smmuv3_accel_alloc_viommu(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
>          goto free_abort_hwpt;
>      }
>  
> +    /* Allocate a vEVENTQ if guest has enabled event queue */
> +    if (!smmuv3_accel_alloc_veventq(s, errp)) {
> +        goto free_bypass_hwpt;
> +    }
Then why don't we do it always upon the SMMU_(*_)CR0.EVENTQEN write?
same question for the deallocation?
> +
>      /* Attach a HWPT based on SMMUv3 GBPA.ABORT value */
>      hwpt_id = smmuv3_accel_gbpa_hwpt(s, accel);
>      if (!host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp)) {
> -        goto free_bypass_hwpt;
> +        goto free_veventq;
>      }
>      s->s_accel = accel;
>      return true;
>  
> +free_veventq:
> +    smmuv3_accel_free_veventq(accel);
>  free_bypass_hwpt:
>      iommufd_backend_free_id(idev->iommufd, accel->bypass_hwpt_id);
>  free_abort_hwpt:
> @@ -537,6 +596,7 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
>      trace_smmuv3_accel_unset_iommu_device(devfn, idev->devid);
>  
>      if (QLIST_EMPTY(&accel->device_list)) {
> +        smmuv3_accel_free_veventq(accel);
>          iommufd_backend_free_id(accel->viommu.iommufd, accel->bypass_hwpt_id);
>          iommufd_backend_free_id(accel->viommu.iommufd, accel->abort_hwpt_id);
>          iommufd_backend_free_id(accel->viommu.iommufd, accel->viommu.viommu_id);
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index 2f2904d86b..7b0f585769 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -20,6 +20,7 @@
>   */
>  typedef struct SMMUv3AccelState {
>      IOMMUFDViommu viommu;
> +    IOMMUFDVeventq *veventq;
>      uint32_t bypass_hwpt_id;
>      uint32_t abort_hwpt_id;
>      QLIST_HEAD(, SMMUv3AccelDevice) device_list;
> @@ -48,6 +49,7 @@ bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s, Error **errp);
>  bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
>                                  Error **errp);
>  void smmuv3_accel_idr_override(SMMUv3State *s);
> +bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp);
>  void smmuv3_accel_reset(SMMUv3State *s);
>  #else
>  static inline void smmuv3_accel_init(SMMUv3State *s)
> @@ -78,6 +80,10 @@ smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
>  static inline void smmuv3_accel_idr_override(SMMUv3State *s)
>  {
>  }
> +bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
> +{
> +    return true;
> +}
>  static inline void smmuv3_accel_reset(SMMUv3State *s)
>  {
>  }
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 763f069a35..ac60ca0ce7 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1602,6 +1602,10 @@ static MemTxResult smmu_writel(SMMUv3State *s, hwaddr offset,
>          s->cr0ack = data & ~SMMU_CR0_RESERVED;
>          /* in case the command queue has been enabled */
>          smmuv3_cmdq_consume(s, &local_err);
> +        /* Allocate vEVENTQ if guest enables EventQ and vIOMMU is ready */
> +        if (local_err == NULL) {
> +            smmuv3_accel_alloc_veventq(s, &local_err);
> +        }
>          break;
>      case A_CR1:
>          s->cr[1] = data;
Thanks

Eric



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F3BCCF9EA
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 14:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDO7J-0005qK-8b; Mon, 27 Oct 2025 10:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDO7I-0005pW-CC
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 10:22:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDO77-0005Ah-Q8
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 10:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761574940;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kCn5fTk8j5o5UyvD80qrdTGvWogk90Z1sWaEUZxvpfM=;
 b=ENLoWYLRtv1vPmX3BOD5yOp5wYx9lxZVsp1nPpBUp8RtI1O9OXgYNKASrPv/fAccyFjSNG
 F9Rhd1qWbik2wx+S4YnD1y2hzMTOIbiSul/K2AqOctjDidbiyf7ufDbDbXAt0ye0VYLdMk
 uaXhLBYb1vKieFQlp8/ucKKneGlj8z8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-V1LqSsXjOf272MFliVDG2Q-1; Mon, 27 Oct 2025 10:22:18 -0400
X-MC-Unique: V1LqSsXjOf272MFliVDG2Q-1
X-Mimecast-MFC-AGG-ID: V1LqSsXjOf272MFliVDG2Q_1761574937
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4770e0910e4so10573925e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 07:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761574937; x=1762179737;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kCn5fTk8j5o5UyvD80qrdTGvWogk90Z1sWaEUZxvpfM=;
 b=plsVEThPkc9VrRg9+68Hbdw/ZB115yjutorXb5dZBcih3QbE7H1E6yBFinywu/L7qI
 I1jVwZIH2H5X9dbD1DLgpWpfPvIztr5pTi9lmCW6Wr8oQbAmzVF7JYXodyp70oX3a8uI
 F+fhKriwUtb2ZarqlKsstyjmWNQqhQFh5WWgSDmD8UF2rMI9J/EZ3OvgTUZe5uPqQFwJ
 TkdKSLVvIBp2s1bnx3riS/cedMAT4yuV6plt5hjV0KIsjbMG6Ns/llxSt0VDFWBWJR19
 b1t2GFx64lFi8w55g0cgDy2baH7crcRiSP3P0Wy4wSXpBjTWxIJr86U8GLW7C/aOPnnn
 kSGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVP3wqVvdeb4NgvbJZ0Qdi33oKDkxmXSqODPts2t6jMfaJC+Om2TcAmQ10BmD7wqwrlapcwgQ/cZy3i@nongnu.org
X-Gm-Message-State: AOJu0Ywz7HF2+EbKjI8UIFUUX9dsVdCcTCZPJmInADi2G1biPbzOZdjj
 zHxWSuHPOd6QY1M0WIucSSrtBkK1Bjxw2KjjiHTDB+KggM3Rb+DkxcQaXO+WEDXGwpPmdyVCWs1
 hmXGONN9udhSp1BIt+QnoMG2L0LKmazcklm1SnE1nBchpHq6RUjMu18ZY
X-Gm-Gg: ASbGncuB9elpS/tx4cD0FHwfi2dioxdPFDolziwEscslVZcuivMOOnW4A3dSnJWzRMo
 fE77ob1qnKkZ3l2VqbGCZrTEbkZLXEZbHQxCsODdQaj1hUjnuj7AcHLhgTNn55liiX0hU1eoTZt
 zrYvhqfcyADiNuj4FHsBQMs8T4xtQruXL/Jo3X1S6FQ1Wd9wLDw946qcKapUWH3wf8iyuj600ef
 eXyNnJ7tVlv+YbGdynK2jA79bA0LCoCZhPgfMbqhjrqqGRXoA/8NuWxbnbO8AumWix4Ko5B3aZg
 /CTWiWMDPt7o8mfr47WiDiLQa7ZKjgjG9SGbNzDpixs2dPbYBG2voW/0U0UGGpLRZghkiA1RM9L
 9xw6F5ijQ3WGGNE9wMqMt1cuAFq2J1p+91x2JcfesU4YKRQ==
X-Received: by 2002:a05:600c:1554:b0:46e:206a:78cc with SMTP id
 5b1f17b1804b1-475cb044e25mr135969505e9.28.1761574937427; 
 Mon, 27 Oct 2025 07:22:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9NR8N/kkzVkTzHwK9+gpJ85QYrb0POD8JDOYoVpBTaXTdRShQRJoF5z94p4FfHYH2GlrqKA==
X-Received: by 2002:a05:600c:1554:b0:46e:206a:78cc with SMTP id
 5b1f17b1804b1-475cb044e25mr135969155e9.28.1761574936986; 
 Mon, 27 Oct 2025 07:22:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd477d0esm135158165e9.0.2025.10.27.07.22.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 07:22:16 -0700 (PDT)
Message-ID: <34131356-6c93-4f52-8f2e-21339ea3c5a8@redhat.com>
Date: Mon, 27 Oct 2025 15:22:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/27] hw/arm/smmuv3-accel: Install S1 bypass hwpt on
 reset
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
 <20250929133643.38961-20-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250929133643.38961-20-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 9/29/25 3:36 PM, Shameer Kolothum wrote:
> When the guest reboots with devices in nested mode (S1 + S2), any QEMU/UEFI
> access to those devices can fail because S1 translation is not valid during
> the reboot. For example, a passthrough NVMe device may hold GRUB boot info
> that UEFI tries to read during the reboot.
>
> Set S1 to bypass mode during reset to avoid such failures.
>
> Reported-by: Matthew R. Ochs <mochs@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c | 29 +++++++++++++++++++++++++++++
>  hw/arm/smmuv3-accel.h |  4 ++++
>  hw/arm/smmuv3.c       |  1 +
>  3 files changed, 34 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index defeddbd8c..8396053a6c 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -634,6 +634,35 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
>      .get_msi_address_space = smmuv3_accel_find_msi_as,
>  };
>  
> +/*
> + * If the guest reboots and devices are configured for S1+S2, Stage1 must
> + * be switched to bypass. Otherwise, QEMU/UEFI may fail when accessing a
> + * device, e.g. when UEFI retrieves boot partition information from an
> + * assigned vfio-pci NVMe device.
> + */
> +void smmuv3_accel_attach_bypass_hwpt(SMMUv3State *s)
> +{
> +    SMMUv3AccelDevice *accel_dev;
> +    SMMUViommu *viommu;
> +
> +    if (!s->accel || !s->s_accel->viommu) {
> +        return;
> +    }
> +
> +    viommu = s->s_accel->viommu;
> +    QLIST_FOREACH(accel_dev, &viommu->device_list, next) {
> +        if (!accel_dev->vdev) {
> +            continue;
> +        }
> +        if (!host_iommu_device_iommufd_attach_hwpt(accel_dev->idev,
> +                                                   viommu->bypass_hwpt_id,
> +                                                   NULL)) {
I would prefer we pass a proper local_err, add the hint below and then
report the concatenated error.

Eric
> +            error_report("Failed to install bypass hwpt id %u for dev id %u",
> +                          viommu->bypass_hwpt_id, accel_dev->idev->devid);
> +        }
> +    }
> +}
> +
>  void smmuv3_accel_init(SMMUv3State *s)
>  {
>      SMMUState *bs = ARM_SMMU(s);
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index 3bdba47616..75f858e34a 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -48,6 +48,7 @@ bool smmuv3_accel_install_nested_ste_range(SMMUv3State *s, SMMUSIDRange *range,
>                                             Error **errp);
>  bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
>                                  Error **errp);
> +void smmuv3_accel_attach_bypass_hwpt(SMMUv3State *s);
>  #else
>  static inline void smmuv3_accel_init(SMMUv3State *s)
>  {
> @@ -70,6 +71,9 @@ smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
>  {
>      return true;
>  }
> +static inline void smmuv3_accel_attach_bypass_hwpt(SMMUv3State *s)
> +{
> +}
>  #endif
>  
>  #endif /* HW_ARM_SMMUV3_ACCEL_H */
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 5830cf5a03..94b2bbc374 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1913,6 +1913,7 @@ static void smmu_reset_exit(Object *obj, ResetType type)
>      if (c->parent_phases.exit) {
>          c->parent_phases.exit(obj, type);
>      }
> +    smmuv3_accel_attach_bypass_hwpt(s);
>  }
>  
>  static void smmu_realize(DeviceState *d, Error **errp)



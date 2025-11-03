Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8331CCFA06
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 15:12:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFwDL-00064q-FO; Mon, 03 Nov 2025 10:11:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFwDI-00063e-US
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 10:11:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFwDD-0002QS-Af
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 10:11:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762182671;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OiXT+1LcmFDYjb4JSCsI4XzEaf+dcwuyHljVA3/mfc0=;
 b=RcHKJxxJNDCKVsiwlVGOTb0UAjngcWJUzeKvC7PsJ8S+J8JG6M/sAp/WtSJuzROjTlJitz
 fh9JX4dqPARqU7QIilGlwFqMikU0pvBkPrHkdn544YBmTey+SfupcVDpPEm3xkU3q9nyJB
 CLae5U82AIg+1NdEKwYbo7oWMSlbN9g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-gH4XV_QjMfO_Ar9guz49PA-1; Mon, 03 Nov 2025 10:11:10 -0500
X-MC-Unique: gH4XV_QjMfO_Ar9guz49PA-1
X-Mimecast-MFC-AGG-ID: gH4XV_QjMfO_Ar9guz49PA_1762182669
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47106a388cfso36116255e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 07:11:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762182669; x=1762787469;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OiXT+1LcmFDYjb4JSCsI4XzEaf+dcwuyHljVA3/mfc0=;
 b=ElJ5PrPd0NlpID91qRkB95x92nIMj4lsbr9TnUlDCnilKe4edYL1Thc323AHkKNmJH
 JutMMrfohL6VYh2/U30Z1R7AFDYQDtrX80NtkEudS9VPPeEisQCTLDdXBKbuSoQbpZaP
 XuMA41ivJvotejHtLPuIm9X21OnD840NOULG/6hUdr8pGbO+QViXdpZN4Xx+jaa+H/Oy
 hmW+D8zS/nd5Al1iHLGkEUQkJUo5RfNEBREpxdXl9c617hSZPuW/ybQY1B4lNqQI/2uq
 p0hWK7NO3fF8ybZXYVfZ5JwWaCvtM4vNeR2OHIkDhv5zivdmTzKyG+K2UxV0LYePQqWk
 x4OQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXzEuajN9BJ3jff30RRziDy8GkKrJU2DKSeoFWK2l+NsUlqiYfwOFGSP1cRuV4vnlm3Fu5tG82E/HF@nongnu.org
X-Gm-Message-State: AOJu0YwizjKWTgcDWOjFSxMYc9ijmz77EMzixrYMQmSp2gP0G0Md2WkN
 8ohTQic8v+IrN/PL93KLZOo3HUqxAbmWhnj+GTanQ7+OcLm5UpazRsoLkcDpL0Josz71h2aUwhu
 VPjoOVXLOTREVJ7T0JSSGtXqHeZH3BvZQXNId3vmnj5JS69Ck9xcKW6t+
X-Gm-Gg: ASbGnctOrK8ABXjfJ6Drpfryx/RKzgLGLwPM8NiUc192fBGa9Yiu1cHLjpLC0A0l4Xy
 5+GL7s1+UvW/A9Zlo1vR3eLqNrvdREv+SffyDVqkCpaSligA3EDNLns4KZSZ7ajKVgXeut+3WAG
 208/Mx2DeDThVODSITH+8YDBtSJZMGP2peyJ6MxEv9sUvMwGzqZ/punPGDAKOH8QaJvHyG2atal
 wq2kxZaIHJjaq/0WRl5PEoDZN/88/Yp2LWnXr9bZhLWJ/W0JbCIB9lV/kGwS5OZcVoGcYy9yJAo
 GMhT6KJE+tm1r5MroqwZroH3n3gFOMixHvo6FWH8xyWj2CSsiWVW8DtR9D7VQsTBuZnwDSqlZcq
 DdLSlN2C9BjMlZJQijcH+HkGghF57949WjezEnfWfbkellA==
X-Received: by 2002:a05:600c:3e06:b0:475:dc58:39e5 with SMTP id
 5b1f17b1804b1-4773089b541mr111808625e9.27.1762182668975; 
 Mon, 03 Nov 2025 07:11:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCibhjevzlRlgR9c+Ecu80WuapdvoBYi+UITaqvOZNyilJAQNcxN+Psd1vc0RiPwGxFSvZZQ==
X-Received: by 2002:a05:600c:3e06:b0:475:dc58:39e5 with SMTP id
 5b1f17b1804b1-4773089b541mr111808065e9.27.1762182668471; 
 Mon, 03 Nov 2025 07:11:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c4af7c7sm164204505e9.7.2025.11.03.07.11.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 07:11:08 -0800 (PST)
Message-ID: <92e84127-e513-40b0-a896-921e22ae9f47@redhat.com>
Date: Mon, 3 Nov 2025 16:11:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 18/32] hw/arm/smmuv3: Initialize ID registers early
 during realize()
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
 <20251031105005.24618-19-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251031105005.24618-19-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
> Factor out ID register init into smmuv3_init_id_regs() and call it from
> realize(). This ensures ID registers are initialized early for use in the
> accelerated SMMUv3 path and will be utilized in subsequent patch.
>
> Other registers remain initialized in smmuv3_reset().
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/smmuv3.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 15173ddc9c..fae545f35c 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -258,7 +258,12 @@ void smmuv3_record_event(SMMUv3State *s, SMMUEventInfo *info)
>      info->recorded = true;
>  }
>  
> -static void smmuv3_init_regs(SMMUv3State *s)
> +/*
> + * Called during realize(), as the ID registers will be accessed early in the
> + * SMMUv3 accel path for feature compatibility checks. The remaining registers
> + * are initialized later in smmuv3_reset().
> + */
> +static void smmuv3_init_id_regs(SMMUv3State *s)
>  {
>      /* Based on sys property, the stages supported in smmu will be advertised.*/
>      if (s->stage && !strcmp("2", s->stage)) {
> @@ -298,7 +303,11 @@ static void smmuv3_init_regs(SMMUv3State *s)
>      s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, 1);
>      s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, 1);
>      s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN64K, 1);
> +    s->aidr = 0x1;
> +}
>  
> +static void smmuv3_reset(SMMUv3State *s)
> +{
>      s->cmdq.base = deposit64(s->cmdq.base, 0, 5, SMMU_CMDQS);
>      s->cmdq.prod = 0;
>      s->cmdq.cons = 0;
> @@ -310,7 +319,6 @@ static void smmuv3_init_regs(SMMUv3State *s)
>  
>      s->features = 0;
>      s->sid_split = 0;
> -    s->aidr = 0x1;
>      s->cr[0] = 0;
>      s->cr0ack = 0;
>      s->irq_ctrl = 0;
> @@ -1915,7 +1923,7 @@ static void smmu_reset_exit(Object *obj, ResetType type)
>          c->parent_phases.exit(obj, type);
>      }
>  
> -    smmuv3_init_regs(s);
> +    smmuv3_reset(s);
>      smmuv3_accel_reset(s);
>  }
>  
> @@ -1947,6 +1955,7 @@ static void smmu_realize(DeviceState *d, Error **errp)
>      sysbus_init_mmio(dev, &sys->iomem);
>  
>      smmu_init_irq(s, dev);
> +    smmuv3_init_id_regs(s);
>  }
>  
>  static const VMStateDescription vmstate_smmuv3_queue = {



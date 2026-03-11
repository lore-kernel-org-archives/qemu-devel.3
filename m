Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E0B112583A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 14:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0KwB-0007GP-En; Wed, 11 Mar 2026 10:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w0Kvs-0006uA-PL
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 10:53:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w0Kvq-0000jS-Hy
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 10:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773240784;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5jMW9wdMx4IyjB42JCXFmV+TsOW3/sq5YgwMkQmofxw=;
 b=go9RYcQ8MONAXKG4L+gzUqdePBYk0z2mVF1TjuT0syZ2ChZ5j1FUkfJRd6A8h0HmnUo8m3
 BPRv1tQ+zAA4etLt3wjT+BE+UMcHtKEKmwCz50Mf5BsqnCnfEchs07WCBwv7iRNi8IN5Lm
 WXDjUsJE9cibk7X33OhdRaz3IAtVLPA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-xO8KYBAnOSGNXLn5tY3xdg-1; Wed, 11 Mar 2026 10:53:01 -0400
X-MC-Unique: xO8KYBAnOSGNXLn5tY3xdg-1
X-Mimecast-MFC-AGG-ID: xO8KYBAnOSGNXLn5tY3xdg_1773240780
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-439b5511d5aso9399928f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 07:53:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773240780; x=1773845580;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5jMW9wdMx4IyjB42JCXFmV+TsOW3/sq5YgwMkQmofxw=;
 b=sTvyYKaBcSySVQXNb80uwMeOn4j391YWAsJQR5pYGOoxO8k9ecweDae1hoGb1a836u
 /jxNPIAFqMLcBk264+mufrFGyw/k4zl2Hnv8+hyaZ4qzNKGm/aIxiIZCjSKemhkTwSwC
 AF6pZ3ARg0Pp7UYqO/r0OCHYre6ltmsyhZ0jyTRn+ruXjHCIHbe5Dq3wrqd55vGGxYG6
 RMY5rt7fjfYSX+Muo8tcBAQcsqS7hltsErFeSp5Qy6ATikEDA6IskWPe4ZdIYK7TuMjv
 gofarXBE+TrKPQVRQCmDRPbeqVC+aHktfmmAc7fmaeykHAY5JY7TYzhbL6I6q6ER6450
 2n+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAinh5tI9OvwvesMrubRDtpREEE5fILlMhnd0tBBJVChIUXsfpzbfufpt6h7/HArkPfAiPaXbcHxlz@nongnu.org
X-Gm-Message-State: AOJu0Yyl10ydvi5AnnZa60ExmxUOKyfdvq8uzX8fDLnHQhNsDZza5R11
 JEmG+9Vn46wxds66pt7jyVTrsO2g6Yy18X3CuCqHTbUVr7BZHhMDigFGRbcOTSrffF98XbRsNMq
 2jd6UBw1KurWRpBqU0x2TyDwvc2h4PWrt/ZQ3kknAhhJ8H8RQ0zZM8jLi
X-Gm-Gg: ATEYQzx4QrySq8wD79CsgPf7DU8deoEkdpwwPgJBD3Szwq0at8wAgSHzQNV6pwLtANf
 9S9QJ6e3rENi6xhXKR6ljh1BKz02xIDANY/DrEjVHJd+rqdJI7rBhX/dxL+AUuX0vyw/KLkbb7v
 g0pGxhSK/1U9n5f9oFIE6PHbDpOKxBWi1nk+vTstadLPup8QkVF/zSoQvbVuoD0SHYpivgerMTe
 dsb9JM+iz5MyqDZ4Q960ol+5Yij8bFJbHBvVsE8NWhVbLMJh6AvLj3372s7UjPf0sxG3r8DIPQm
 NQ3R+Wq/L/sGSDk+Zbrz3ZDkSE3d1ITIxnpxT7MVIr9KgainjVmN6AVt4maiWxKUX5VoRBuKgKs
 A9vNEFIaxhIeV+NmOALlcad9FT9VaUqfylNE9V6upgQSOMVBHkltRmhkaJlPCwlz2YedMpg==
X-Received: by 2002:a05:6000:40c8:b0:439:c5a5:c1fb with SMTP id
 ffacd0b85a97d-439f81b6666mr5598491f8f.4.1773240779876; 
 Wed, 11 Mar 2026 07:52:59 -0700 (PDT)
X-Received: by 2002:a05:6000:40c8:b0:439:c5a5:c1fb with SMTP id
 ffacd0b85a97d-439f81b6666mr5598421f8f.4.1773240779374; 
 Wed, 11 Mar 2026 07:52:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439f818d4c8sm7969639f8f.7.2026.03.11.07.52.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 07:52:58 -0700 (PDT)
Message-ID: <f4267f2a-4fe7-4c87-ad11-9632a33a5d3b@redhat.com>
Date: Wed, 11 Mar 2026 15:52:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 20/32] hw/arm/tegra241-cmdqv: Use mmap'ed VINTF page0
 as VCMDQ backing
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, kjaju@nvidia.com, phrdina@redhat.com
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <20260226105056.897-21-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260226105056.897-21-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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



On 2/26/26 11:50 AM, Shameer Kolothum wrote:
> When a VCMDQ is allocated and VINTF page0 has been mmap'ed from the
> kernel, access the VCMDQ registers directly through the VINTF page0
> backing instead of using QEMU's cached register state.
>
> VINTF page0 provides the backing memory region for VCMDQ registers
> once a hardware queue is created. In that case, reads and writes
> should reflect the live backing state.
>
> If a VCMDQ is not allocated, or if VINTF page0 is not available,
> continue to use the cached register values maintained by QEMU.
But if both coexist shouldn't you also sync emulated/mmaped VINTF CMDQV.
Somehow this means that you have 3 states of the same CMDQV: the
global/direct one, the emulated VI CMDQV and the mmapped VI CMDQV (host
backed).
Is this understanding correct?

Thanks

Eric
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/tegra241-cmdqv.c | 47 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 46 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> index 002dde50fc..17b9552906 100644
> --- a/hw/arm/tegra241-cmdqv.c
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -14,17 +14,44 @@
>  #include "smmuv3-accel.h"
>  #include "tegra241-cmdqv.h"
>  
> +static inline uint32_t *tegra241_cmdqv_vintf_ptr(Tegra241CMDQV *cmdqv,
> +                                                 int index, hwaddr offset0)
> +{
> +    if (!cmdqv->vcmdq[index] || !cmdqv->vintf_page0) {
> +        return NULL;
> +    }
> +
> +    return (uint32_t *)(cmdqv->vintf_page0 + (index * 0x80) +
> +                        (offset0 - 0x10000));
> +}
>  /*
>   * Read a VCMDQ register using VCMDQ0_* offsets.
>   *
>   * The caller normalizes the MMIO offset such that @offset0 always refers
>   * to a VCMDQ0_* register, while @index selects the VCMDQ instance.
>   *
> - * All VCMDQ accesses return cached registers.
> + * If the VCMDQ is allocated and VINTF page0 is mmap'ed, read directly
> + * from the VINTF page0 backing. Otherwise, fall back to cached state.
>   */
>  static uint64_t tegra241_cmdqv_read_vcmdq(Tegra241CMDQV *cmdqv, hwaddr offset0,
>                                            int index)
>  {
> +    uint32_t *ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, offset0);
> +
> +    if (ptr) {
> +        switch (offset0) {
> +        case A_VCMDQ0_CONS_INDX:
> +        case A_VCMDQ0_PROD_INDX:
> +        case A_VCMDQ0_CONFIG:
> +        case A_VCMDQ0_STATUS:
> +        case A_VCMDQ0_GERROR:
> +        case A_VCMDQ0_GERRORN:
> +            return *ptr;
> +        default:
> +            break;
> +        }
> +    }
> +
>      switch (offset0) {
>      case A_VCMDQ0_CONS_INDX:
>          return cmdqv->vcmdq_cons_indx[index];
> @@ -250,11 +277,29 @@ static bool tegra241_cmdqv_mmap_vintf_page0(Tegra241CMDQV *cmdqv, Error **errp)
>   *
>   * The caller normalizes the MMIO offset such that @offset0 always refers
>   * to a VCMDQ0_* register, while @index selects the VCMDQ instance.
> + *
> + * If the VCMDQ is allocated and VINTF page0 is mmap'ed, write directly
> + * to the VINTF page0 backing. Otherwise, update cached state.
>   */
>  static void
>  tegra241_cmdqv_write_vcmdq(Tegra241CMDQV *cmdqv, hwaddr offset0, int index,
>                             uint64_t value, unsigned size, Error **errp)
>  {
> +    uint32_t *ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, offset0);
> +
> +    if (ptr) {
> +        switch (offset0) {
> +        case A_VCMDQ0_CONS_INDX:
> +        case A_VCMDQ0_PROD_INDX:
> +        case A_VCMDQ0_CONFIG:
> +        case A_VCMDQ0_GERRORN:
> +            *ptr = (uint32_t)value;
> +            return;
> +        default:
> +            break;
> +        }
> +    }
> +
>      switch (offset0) {
>      case A_VCMDQ0_CONS_INDX:
>          cmdqv->vcmdq_cons_indx[index] = value;



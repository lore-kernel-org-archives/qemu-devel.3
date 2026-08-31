Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B133C61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:52:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0xja-0004Ng-7R; Mon, 31 Aug 2026 04:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x0xjZ-0004N1-0b
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 04:51:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x0xjT-00077H-Hu
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 04:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788166269;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TyCdRYLMLl9yasEb58mydwTENTFf1HbteKBA9G3Sxxw=;
 b=dvEmf/BrneIUNrDMQM8weSb59V9QiUZ3/rNsASGqJ5uWCrxrAhksk6+9oOB8CvQkoZ+sma
 zLzlvJGktir91Z7rGo6gQD0ZnruEz6ori6dXyM7tYv9zZxGROaCsxukh3WG+Hi0zIiF8S0
 Dv+uKpzOFgvcosD44kH6WwQ3Ghrh1ko=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-V5GLLUJxPQOHSNH7daEQvQ-1; Mon, 31 Aug 2026 04:51:05 -0400
X-MC-Unique: V5GLLUJxPQOHSNH7daEQvQ-1
X-Mimecast-MFC-AGG-ID: V5GLLUJxPQOHSNH7daEQvQ_1788166264
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49564d4b849so10441125e9.3
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 01:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788166264; x=1788771064;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TyCdRYLMLl9yasEb58mydwTENTFf1HbteKBA9G3Sxxw=;
 b=D5U5UJAWUbVy666Kvk8lGerrvOvq3azhbSY6Tk8VzXfJj346O5FWHanI6Hs4rDccqA
 s220PEoWf4U06KhWT5RMwB2P+Ccxige3CAK16pElNwvUaASg9Aj4htCocIxpeEaMMq5h
 lmKmytgIB1/rr/Uv8PMIHww4BLEMwbXaCqmSvqUa6xCqnUy+cOIlcRa0DnX3RanAfl4z
 U+mWuEyMjpaVpfTbeeJ6HVcUQynGr/VK6cpOO10ktOhWZV2mHekJjVfwT0PEGu/FTJsf
 UFZ36f8hurlt5nr3kuUifrCa4X1MdhKJL8quaj7lsCWB6ZT07wHppAVxS5Jw6aQEsvAy
 uNRQ==
X-Gm-Message-State: AFuF++ndOvaXMxQsQWBM986GNkvFNA1KoCrxEJcrI8WoF2yu2USsPtyZ
 LwHktqgUBY39Q2ABxHBRR95fi0nuleeCO5Z3hxiom+kZBkBBm4AsGG+zJZ1STXkWq0KqkYHSEzN
 GSDuRE7t5q/KrmAJCrG37MkE0DcC+SvO+mKaupEm+GKe03qizdXeJcPJ9
X-Gm-Gg: AR+sD12X4lix36ZeDY26h5x09Xu73f7+3hHlq15KmGR+84UxUyBbXaaFDihOf5dG14j
 UGZGEMKOCd5C0WBYmQZ7tCpFLl1I5y/qd2NE+wySZiuzD0PN+TLVCfBBT6VwBlYVrjByZ0XOs7L
 QILKj3dLbywqg3EQLpKj0COZJWacywVlI0Ewwg6X2Q2cm3RHFW4xBOtcDOYgqxTwovZO8aMFAQj
 Z3QMRSi40HbrRmGIt/o/EXCd38TkjdbHPRFkGKnzHcTUUEPjutoB1jwbpSHfoZnfj8UJhKYAJcz
 Cxb/0MmPI4MqhOhkYzQeTVmRpjGg9/kI9Qz+7nQV38UGWf5wT9nQ8XL8tAlwITiT+D4s14bOJAa
 7ODo1HzbPpUFuVBQv7S8uRjIFsRCNkvP2iw+3gpcdCOqRsH/E
X-Received: by 2002:a05:600c:1c0a:b0:493:bd2a:93be with SMTP id
 5b1f17b1804b1-49b91c276efmr397523775e9.6.1788166263710; 
 Mon, 31 Aug 2026 01:51:03 -0700 (PDT)
X-Received: by 2002:a05:600c:1c0a:b0:493:bd2a:93be with SMTP id
 5b1f17b1804b1-49b91c276efmr397522905e9.6.1788166263272; 
 Mon, 31 Aug 2026 01:51:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b9266be71sm575736225e9.2.2026.08.31.01.51.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 01:51:02 -0700 (PDT)
Message-ID: <f0dc00d6-c49b-4dc1-b6de-706142856089@redhat.com>
Date: Mon, 31 Aug 2026 10:51:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 27/28] hw/arm/smmuv3: Add secure bank migration and
 secure-impl property
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu@processmission.com>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260813161515.2788900-1-tangtao1634@phytium.com.cn>
 <20260813162644.2810021-1-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260813162644.2810021-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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


Hi Tao,
On 8/13/26 6:26 PM, Tao Tang wrote:
> Add a secure-impl device property and advertise it through
> S_IDR1.SECURE_IMPL. Reject secure-impl=on unless Secure memory is available
> and stage-1 translation is supported.
please document why the auto mode is needed (dependency on virt secure
option)

May make sense to document it in system/arm/virt.rst too as it has a
dependency on the secure setup of the machine
>
> Usage:
>     -M virt,secure=on,iommu=smmuv3 \
>     -global arm-smmuv3.secure-impl=on
does it work with arm-smmuv3 device too?
>
> Add the smmuv3/bank_s migration subsection for the secure register bank.
> Serialize secure bank state including GBPA, IRQ config, stream table and
> queue state.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  hw/arm/smmuv3.c         | 93 +++++++++++++++++++++++++++++++++++++++++
>  include/hw/arm/smmuv3.h |  2 +
>  2 files changed, 95 insertions(+)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 7e7376c65e2..8e1de94fd17 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -348,6 +348,8 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
>  
>      sbank->idr[1] = FIELD_DP32(sbank->idr[1], S_IDR1, S_SIDSIZE,
>                                 SMMU_IDR1_SIDSIZE);
> +    sbank->idr[1] = FIELD_DP32(sbank->idr[1], S_IDR1, SECURE_IMPL,
> +                               s->secure_impl == ON_OFF_AUTO_ON);
>      smmuv3_accel_idr_override(s);
>  }
>  
> @@ -2752,6 +2754,37 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>      return true;
>  }
>  
> +static bool smmuv3_resolve_secure_impl(SMMUv3State *s, Error **errp)
> +{
> +    SMMUState *bs = ARM_SMMU(s);
> +    bool secure_as_available = bs->secure_memory &&
> +                               bs->secure_memory_as.root != NULL;
> +
> +    if (s->secure_impl == ON_OFF_AUTO_AUTO) {
> +        s->secure_impl = secure_as_available ? ON_OFF_AUTO_ON
> +                                             : ON_OFF_AUTO_OFF;
> +    }
> +
> +    if (s->secure_impl == ON_OFF_AUTO_ON && !secure_as_available) {
> +        error_setg(errp,
> +                   "secure-impl=on requires a secure-memory address space");
> +        return false;
> +    }
> +
> +    /*
> +     * When SECURE_IMPL == 1, stage 1 must be supported according to
> +     * (IHI 0070G.b) 6.3.53 SMMU_S_IDR1, Page 442.
> +     */
> +    if (s->secure_impl == ON_OFF_AUTO_ON &&
> +        s->stage && !strcmp(s->stage, "2")) {
we already have smmu_validate_property(). Would be better located there
if possible. Otherwise please justify it.

Please split this patch into 2. The migration support on one end, which
only depends on OnOffAuto secure_impl;
and the rest
> +        error_setg(errp,
> +                    "secure-impl=on requires stage=1 or stage=nested");
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>  static void smmu_realize(DeviceState *d, Error **errp)
>  {
>      SMMUState *sys = ARM_SMMU(d);
> @@ -2781,6 +2814,10 @@ static void smmu_realize(DeviceState *d, Error **errp)
>          return;
>      }
>  
> +    if (!smmuv3_resolve_secure_impl(s, errp)) {
> +        return;
> +    }
> +
>      qemu_mutex_init(&s->mutex);
>  
>      memory_region_init_io(&sys->iomem, OBJECT(s),
> @@ -2807,6 +2844,54 @@ static const VMStateDescription vmstate_smmuv3_queue = {
>      },
>  };
>  
> +static const VMStateDescription vmstate_smmuv3_secure_bank = {
> +    .name = "smmuv3_secure_bank",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_UINT32(features, SMMUv3RegBank),
> +        VMSTATE_UINT8(sid_split, SMMUv3RegBank),
> +        VMSTATE_UINT32_ARRAY(cr, SMMUv3RegBank, 3),
> +        VMSTATE_UINT32(cr0ack, SMMUv3RegBank),
> +        VMSTATE_UINT32(gbpa, SMMUv3RegBank),
> +        VMSTATE_UINT32(irq_ctrl, SMMUv3RegBank),
> +        VMSTATE_UINT32(gerror, SMMUv3RegBank),
> +        VMSTATE_UINT32(gerrorn, SMMUv3RegBank),
> +        VMSTATE_UINT64(gerror_irq_cfg0, SMMUv3RegBank),
> +        VMSTATE_UINT32(gerror_irq_cfg1, SMMUv3RegBank),
> +        VMSTATE_UINT32(gerror_irq_cfg2, SMMUv3RegBank),
> +        VMSTATE_UINT64(strtab_base, SMMUv3RegBank),
> +        VMSTATE_UINT32(strtab_base_cfg, SMMUv3RegBank),
> +        VMSTATE_UINT64(eventq_irq_cfg0, SMMUv3RegBank),
> +        VMSTATE_UINT32(eventq_irq_cfg1, SMMUv3RegBank),
> +        VMSTATE_UINT32(eventq_irq_cfg2, SMMUv3RegBank),
> +        VMSTATE_STRUCT(cmdq, SMMUv3RegBank, 0,
> +                       vmstate_smmuv3_queue, SMMUQueue),
> +        VMSTATE_STRUCT(eventq, SMMUv3RegBank, 0,
> +                       vmstate_smmuv3_queue, SMMUQueue),
> +        VMSTATE_END_OF_LIST(),
> +    },
> +};
> +
> +static bool smmuv3_secure_bank_needed(void *opaque)
> +{
> +    SMMUv3State *s = opaque;
> +
> +    return s->secure_impl == ON_OFF_AUTO_ON;
> +}
> +
> +static const VMStateDescription vmstate_smmuv3_bank_s = {
> +    .name = "smmuv3/bank_s",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
> +    .needed = smmuv3_secure_bank_needed,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_STRUCT(bank[SMMU_SEC_SID_S], SMMUv3State, 0,
> +                       vmstate_smmuv3_secure_bank, SMMUv3RegBank),
> +        VMSTATE_END_OF_LIST(),
> +    },
> +};
> +
>  static bool smmuv3_gbpa_needed(void *opaque)
>  {
>      SMMUv3State *s = opaque;
> @@ -2861,6 +2946,7 @@ static const VMStateDescription vmstate_smmuv3 = {
>      },
>      .subsections = (const VMStateDescription * const []) {
>          &vmstate_gbpa,
> +        &vmstate_smmuv3_bank_s,
>          NULL
>      }
>  };
> @@ -2893,6 +2979,13 @@ static const Property smmuv3_properties[] = {
>      DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
>                                SSID_SIZE_MODE_AUTO),
>      DEFINE_PROP_ON_OFF_AUTO("cmdqv", SMMUv3State, cmdqv, ON_OFF_AUTO_AUTO),
> +    /*
> +     * SECURE_IMPL field in S_IDR1 register.
> +     * Indicates whether secure state is implemented.
> +     * Defaults to auto.
> +     */
> +    DEFINE_PROP_ON_OFF_AUTO("secure-impl", SMMUv3State, secure_impl,
> +                            ON_OFF_AUTO_AUTO),
>  };
>  
>  static void smmuv3_instance_init(Object *obj)
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index 8cd2edc3412..9b533b9a99b 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -81,6 +81,8 @@ struct SMMUv3State {
>      OnOffAuto ats;
>      OasMode oas;
>      SsidSizeMode ssidsize;
> +    OnOffAuto secure_impl;
> +
>      /* SMMU CMDQV extension */
>      OnOffAuto cmdqv;
>  
Thanks

Eric



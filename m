Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F81BCAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3FtI-0006IM-2F; Mon, 29 Sep 2025 11:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v3FtG-0006Gh-0c
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:34:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v3Ft8-00036F-8k
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:34:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759160042;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=14psK+iUfLpnaY+LCKEv88oY0lMmeBrJhKfx2kpR4xg=;
 b=UCqmdDn2XbKbdwEc71BXp8DzlWrZbtkG7pus4mE7cfLbjE1oTQzDawyYXOc1U9FyjM25RD
 RQb5mwXKltVM36+I/J0u7OJWD1yitYziBPhh76GMJEaENj0AnJtzefYNSrpn9LXQjTxabL
 0d03ELaE3m1QabGj7Near80gUmTcJXY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-lp8kZVs3NcmfXAxA1IJZhg-1; Mon, 29 Sep 2025 11:34:01 -0400
X-MC-Unique: lp8kZVs3NcmfXAxA1IJZhg-1
X-Mimecast-MFC-AGG-ID: lp8kZVs3NcmfXAxA1IJZhg_1759160037
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46e4cb3e4deso3920565e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:33:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759160036; x=1759764836;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=14psK+iUfLpnaY+LCKEv88oY0lMmeBrJhKfx2kpR4xg=;
 b=sN891J1H1X2IahdCwHfHvQh34C2u6BkA/URlzYtJvXLfsCya495uaEPt/mpKbwC9NZ
 6kDBF9vD298EGbnPP78lUhnr9X9p/3sytYOV4w8N9Vmfg2FRSszPYmiV6Nkn875zA1kU
 2oNY9ucW9ckVKclg4QevHr5dfXa3Z3lyJiUKfxbLZWM9Daifq3lGnwXFPg9cccX3QrZI
 VJpRihyfUzGpT9TBQvD9ZQvBesWqtlVsX3idNQHd5RCJo8PSeJi7+msluez+XAo9+VIr
 ATzsXSs+bCJZTBtaItM0J/Gl2Hjt7MVLTg0Ie3oACZupvO8JjjTsc4Kn0gZ8sFXTlNrV
 Er1w==
X-Gm-Message-State: AOJu0YyYb0VesPiTI7nkNW85Ur1rhkiftk5xiCQUTVKXJQVs5OLgd8nQ
 xvHqjAXlNLqN/MbakJa+s4QNRExiT7bpxxjypWF6EVQQgni98/xIstyi83X5SCvrSTMsBg3KMLF
 oxOVKRhmKgOrgyTigJzhleQPSPnHKl08+JHkjxx1iJd0vITOoupLChM5aHWDh1YEu
X-Gm-Gg: ASbGncsVeWt8DMc0wk4qWKQY6J+129QOOadWlzQMmYWmEZIoT++LkdQLk7hiqKhPKuJ
 ed4I43aWS8Hq//409czZR5I80yoPoZK7sxcyhr5q0u9jNS3DbD11i+tlZd6RQKrSUTTYw3J/lrj
 9OxmxC6CvzsMSOSpzGQOaBCkLaBwD1cHZoXPafgnJNPXnS/IxvrUxlzhaecFuz99PINHCikgLd3
 83+wQZgjrjDGRY+ZiffCE8FSCYvXs/xw4AjOEIzs4++QneH6RxPkoLcSy4yM6mPmnKNHiJAgBFA
 04OPGdTjYD6mluIwg4Z5ncvoEK8Y8bDo/+q5VyhkAM/tw1D7spWWVw219Gt1fILquoF+E9GR/qn
 gsoxxA6CEEY0=
X-Received: by 2002:a05:600c:4815:b0:45f:2b0e:b835 with SMTP id
 5b1f17b1804b1-46e58ce0e22mr6758565e9.10.1759160036274; 
 Mon, 29 Sep 2025 08:33:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAtdBHi+XHMAAtjN1wwMCp+J8q/hj/yTCEfn3FrDQ2quEmMfE0pgB+c87aoGyVJUig7sCqqg==
X-Received: by 2002:a05:600c:4815:b0:45f:2b0e:b835 with SMTP id
 5b1f17b1804b1-46e58ce0e22mr6758285e9.10.1759160035806; 
 Mon, 29 Sep 2025 08:33:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb72fb71esm18717552f8f.1.2025.09.29.08.33.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 08:33:55 -0700 (PDT)
Message-ID: <39446b6c-d7dd-4aeb-a2ee-96db03997e4a@redhat.com>
Date: Mon, 29 Sep 2025 17:33:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/14] hw/arm/smmuv3: Use iommu_index to represent the
 security context
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
References: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
 <20250926030831.1067440-1-tangtao1634@phytium.com.cn>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250926030831.1067440-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 9/26/25 5:08 AM, Tao Tang wrote:
> Resending patches 12–14/14 that were missing due to a send issue. Sorry
> for the noise.
>
> The Arm SMMUv3 architecture uses a SEC_SID (Secure StreamID) to select
> the programming interface. To support future extensions like RME, which
> defines four security states (Non-secure, Secure, Realm, and Root), the
> QEMU model must cleanly separate these contexts for all operations.
>
> This commit leverages the generic iommu_index to represent this
> security context. The core IOMMU layer now uses the SMMU's .attrs_to_index
> callback to map a transaction's ARMSecuritySpace attribute to the
> corresponding iommu_index.
>
> This index is then passed down to smmuv3_translate and used throughout
> the model to select the correct register bank and processing logic. This
> makes the iommu_index the clear QEMU equivalent of the architectural
> SEC_SID, cleanly separating the contexts for all subsequent lookups.
>
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>  hw/arm/smmuv3.c | 37 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index eec36d5fd2..c92cc0f06a 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1099,6 +1099,38 @@ static void smmuv3_fixup_event(SMMUEventInfo *event, hwaddr iova)
>      }
>  }
>
> +static SMMUSecurityIndex smmuv3_attrs_to_security_index(MemTxAttrs attrs)
> +{
> +    switch (attrs.space) {
> +    case ARMSS_Secure:
> +        return SMMU_SEC_IDX_S;
> +    case ARMSS_NonSecure:
> +    default:
> +        return SMMU_SEC_IDX_NS;
> +    }
> +}
> +
> +/*
> + * ARM SMMU IOMMU index mapping (implements SEC_SID from ARM SMMU):
> + * iommu_idx = 0: Non-secure transactions
> + * iommu_idx = 1: Secure transactions
> + *
> + * The iommu_idx parameter effectively implements the SEC_SID
> + * (Security Stream ID) attribute from the ARM SMMU architecture
> + * specification, which allows the SMMU to differentiate between
> + * secure and non-secure transactions at the hardware level.
> + */
> +static int smmuv3_attrs_to_index(IOMMUMemoryRegion *iommu, MemTxAttrs attrs)
> +{
> +    return smmuv3_attrs_to_security_index(attrs);
> +}
> +
> +static int smmuv3_num_indexes(IOMMUMemoryRegion *iommu)
> +{
> +    /* Support 2 IOMMU indexes for now: NS/S */
> +    return SMMU_SEC_IDX_NUM;
> +}
> +
>  /* Entry point to SMMU, does everything. */
>  static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>                                        IOMMUAccessFlags flag, int iommu_idx)
> @@ -1111,7 +1143,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>                             .inval_ste_allowed = false};
>      SMMUTranslationStatus status;
>      SMMUTransCfg *cfg = NULL;
> -    SMMUSecurityIndex sec_idx = SMMU_SEC_IDX_NS;
> +    SMMUSecurityIndex sec_idx = iommu_idx;
>      IOMMUTLBEntry entry = {
>          .target_as = &address_space_memory,
>          .iova = addr,
> @@ -1155,6 +1187,7 @@ epilogue:
>          entry.perm = cached_entry->entry.perm;
>          entry.translated_addr = CACHED_ENTRY_TO_ADDR(cached_entry, addr);
>          entry.addr_mask = cached_entry->entry.addr_mask;
> +        entry.target_as = cached_entry->entry.target_as;
this change looks unrelated to the commit desc.

Eric
>          trace_smmuv3_translate_success(mr->parent_obj.name, sid, addr,
>                                         entry.translated_addr, entry.perm,
>                                         cfg->stage);
> @@ -2534,6 +2567,8 @@ static void smmuv3_iommu_memory_region_class_init(ObjectClass *klass,
>
>      imrc->translate = smmuv3_translate;
>      imrc->notify_flag_changed = smmuv3_notify_flag_changed;
> +    imrc->attrs_to_index = smmuv3_attrs_to_index;
> +    imrc->num_indexes = smmuv3_num_indexes;
>  }
>
>  static const TypeInfo smmuv3_type_info = {
> --
> 2.34.1
>



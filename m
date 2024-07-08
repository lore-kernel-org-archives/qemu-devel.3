Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A171EC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 14:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQplB-0008Pk-7w; Mon, 08 Jul 2024 10:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sQpl9-0008P6-Sm
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 10:54:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sQpl7-0007nG-6k
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 10:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720450468;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sg8+8766n93D5CQYroTiWz8haOuix0dD1fEDslQOa7g=;
 b=KJ6oxp8zXIABzsj/Rym2kaR6a+R+DzckkD0Si1C0LAo9vyLfn0dBFGPc/u1PQ+QcsC2frV
 R7XoJOc2GXoQM0JmP0puLjrMFfZXPRwA3+gZ1Y4dqf6vk3+x38PtmYh/lMsvRQx8endsGM
 oS/jhHQ1+v8LzN65rjaISsBM8/SR/PA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-GtZZ1tu9N0CdNi_1FHEw3g-1; Mon, 08 Jul 2024 10:54:26 -0400
X-MC-Unique: GtZZ1tu9N0CdNi_1FHEw3g-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-52e994d8e26so4286907e87.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 07:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720450465; x=1721055265;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sg8+8766n93D5CQYroTiWz8haOuix0dD1fEDslQOa7g=;
 b=Ag3XMZDd+cJhGXZgsKqlne4m78ImllnNATBgdLUr07Y/+UkTLuSV9VI5fltb2ua9Kv
 TkgYuJ59E+GroKWulGrF5KN7fRf6A/5yFCShVDt7aKUn0enQseAl8gIOR5FUq7gqWkY/
 IXHkr/xZhOf5V3j/4igvJSp0Iv9C3dvKiDWCMQyubIPOqM/k7bB7uMK1x0BrhYZI9iGq
 zrX/EjeuiNvIbyWRRij4rTKj0ThKmRJC0UM9wTHUrHb9i2wIe19VVWV8UfFJaTVF/IkN
 BPEfGv8ELgmuO/gf+uacXav9uLxP2t/vbgNFb2oV6Ndbnc5YFDJrnnEg8IPFaVnoPfXY
 tBeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhTN2sysEyzKIttqhMfoVZVySBQIbszlvetH/3IY1lIIAV4UaL8mDlR8v2zVOikjSjcXh5XgWkBB336Hd39Prz6e1YGbI=
X-Gm-Message-State: AOJu0Yxo2VXA7sTDrzk4dmKkeDoE2ENhk5YSS7cOJ7PsD6Sk3fTYCwdg
 7K38LnXik3d1ZBUARJ4wSQY8fLTo31VmwaFOP5o8AEsX6xL/v8R4Fn13nsMnPGMht7VSSa4Z3p4
 gCuqxtU80PLwkTMysM0G7MT9RXinttnl6QkwbPI7IBwLGIhlrtezV
X-Received: by 2002:a19:ca19:0:b0:52e:9ad2:a311 with SMTP id
 2adb3069b0e04-52ea0628a8dmr8032902e87.19.1720450465304; 
 Mon, 08 Jul 2024 07:54:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj94FsIbN8n7FWsnUoTo8mYG6hYarIzJoQBvUElPcmBqaNK5nSjvxkMSzb7bsSBMqOrgrNPQ==
X-Received: by 2002:a19:ca19:0:b0:52e:9ad2:a311 with SMTP id
 2adb3069b0e04-52ea0628a8dmr8032886e87.19.1720450464781; 
 Mon, 08 Jul 2024 07:54:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a2fc8bcsm168762625e9.44.2024.07.08.07.54.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jul 2024 07:54:24 -0700 (PDT)
Message-ID: <d2beb3a7-5190-4808-bd7e-ca9d13c55514@redhat.com>
Date: Mon, 8 Jul 2024 16:54:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/19] hw/arm/smmuv3: Translate CD and TT using stage-2
 table
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, maz@kernel.org, nicolinc@nvidia.com, julien@xen.org,
 richard.henderson@linaro.org, marcin.juszkiewicz@linaro.org
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-9-smostafa@google.com>
 <20240704180843.GE1693268@myrica>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240704180843.GE1693268@myrica>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 7/4/24 20:08, Jean-Philippe Brucker wrote:
> On Mon, Jul 01, 2024 at 11:02:30AM +0000, Mostafa Saleh wrote:
>> According to ARM SMMU architecture specification (ARM IHI 0070 F.b),
>> In "5.2 Stream Table Entry":
>>  [51:6] S1ContextPtr
>>  If Config[1] == 1 (stage 2 enabled), this pointer is an IPA translated by
>>  stage 2 and the programmed value must be within the range of the IAS.
>>
>> In "5.4.1 CD notes":
>>  The translation table walks performed from TTB0 or TTB1 are always performed
>>  in IPA space if stage 2 translations are enabled.
>>
>> This patch implements translation of the S1 context descriptor pointer and
>> TTBx base addresses through the S2 stage (IPA -> PA)
>>
>> smmuv3_do_translate() is updated to have one arg which is translation
>> class, this is useful to:
>>  - Decide wether a translation is stage-2 only or use the STE config.
>>  - Populate the class in case of faults, WALK_EABT is left unchanged,
>>    as it is always triggered from TT access so no need to use the
>>    input class.
>>
>> In case for stage-2 only translation, used in the context of nested
>> translation, the stage and asid are saved and restored before and
>> after calling smmu_translate().
>>
>> Translating CD or TTBx can fail for the following reasons:
>> 1) Large address size: This is described in
>>    (3.4.3 Address sizes of SMMU-originated accesses)
>>    - For CD ptr larger than IAS, for SMMUv3.1, it can trigger either
>>      C_BAD_STE or Translation fault, we implement the latter as it
>>      requires no extra code.
>>    - For TTBx, if larger than the effective stage 1 output address size, it
>>      triggers C_BAD_CD.
>>
>> 2) Faults from PTWs (7.3 Event records)
>>    - F_ADDR_SIZE: large address size after first level causes stage 2 Address
>>      Size fault (Also in 3.4.3 Address sizes of SMMU-originated accesses)
>>    - F_PERMISSION: Same as an address translation. However, when
>>      CLASS == CD, the access is implicitly Data and a read.
>>    - F_ACCESS: Same as an address translation.
>>    - F_TRANSLATION: Same as an address translation.
>>    - F_WALK_EABT: Same as an address translation.
>>   These are already implemented in the PTW logic, so no extra handling
>>   required.
>>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>> Signed-off-by: Mostafa Saleh <smostafa@google.com>
>> ---
>>  hw/arm/smmuv3.c | 91 +++++++++++++++++++++++++++++++++++++++++++------
>>  1 file changed, 80 insertions(+), 11 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 229b3c388c..86f95c1e40 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -337,14 +337,35 @@ static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
>>  
>>  }
>>  
>> +static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>> +                                                 SMMUTransCfg *cfg,
>> +                                                 SMMUEventInfo *event,
>> +                                                 IOMMUAccessFlags flag,
>> +                                                 SMMUTLBEntry **out_entry,
>> +                                                 SMMUTranslationClass class);
>>  /* @ssid > 0 not supported yet */
>> -static int smmu_get_cd(SMMUv3State *s, STE *ste, uint32_t ssid,
>> -                       CD *buf, SMMUEventInfo *event)
>> +static int smmu_get_cd(SMMUv3State *s, STE *ste, SMMUTransCfg *cfg,
>> +                       uint32_t ssid, CD *buf, SMMUEventInfo *event)
>>  {
>>      dma_addr_t addr = STE_CTXPTR(ste);
>>      int ret, i;
>> +    SMMUTranslationStatus status;
>> +    SMMUTLBEntry *entry;
>>  
>>      trace_smmuv3_get_cd(addr);
>> +
>> +    if (cfg->stage == SMMU_NESTED) {
>> +        status = smmuv3_do_translate(s, addr, cfg, event,
>> +                                     IOMMU_RO, &entry, SMMU_CLASS_CD);
>> +
>> +        /* Same PTW faults are reported but with CLASS = CD. */
>> +        if (status != SMMU_TRANS_SUCCESS) {
> In this case I think we're reporting InputAddr as the CD address, but it
> should be the IOVA
you're right. the InputAddr is defined as
The 64-bit address input to the SMMU for the transaction that led to the
event.
Unfortunately we don't have an easy access to the IOVA in those
functions. This suggest that we need to rework structs or calls.

>
>> +            return -EINVAL;
>> +        }
>> +
>> +        addr = CACHED_ENTRY_TO_ADDR(entry, addr);
>> +    }
>> +
>>      /* TODO: guarantee 64-bit single-copy atomicity */
>>      ret = dma_memory_read(&address_space_memory, addr, buf, sizeof(*buf),
>>                            MEMTXATTRS_UNSPECIFIED);
>> @@ -659,10 +680,13 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
>>      return 0;
>>  }
>>  
>> -static int decode_cd(SMMUTransCfg *cfg, CD *cd, SMMUEventInfo *event)
>> +static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
>> +                     CD *cd, SMMUEventInfo *event)
>>  {
>>      int ret = -EINVAL;
>>      int i;
>> +    SMMUTranslationStatus status;
>> +    SMMUTLBEntry *entry;
>>  
>>      if (!CD_VALID(cd) || !CD_AARCH64(cd)) {
>>          goto bad_cd;
>> @@ -713,9 +737,26 @@ static int decode_cd(SMMUTransCfg *cfg, CD *cd, SMMUEventInfo *event)
>>  
>>          tt->tsz = tsz;
>>          tt->ttb = CD_TTB(cd, i);
>> +
>>          if (tt->ttb & ~(MAKE_64BIT_MASK(0, cfg->oas))) {
>>              goto bad_cd;
>>          }
>> +
>> +        /* Translate the TTBx, from IPA to PA if nesting is enabled. */
>> +        if (cfg->stage == SMMU_NESTED) {
>> +            status = smmuv3_do_translate(s, tt->ttb, cfg, event, IOMMU_RO,
>> +                                         &entry, SMMU_CLASS_TT);
>> +            /*
>> +             * Same PTW faults are reported but with CLASS = TT.
>> +             * If TTBx is larger than the effective stage 1 output addres
>> +             * size, it reports C_BAD_CD, which is handled by the above case.
>> +             */
>> +            if (status != SMMU_TRANS_SUCCESS) {
> Here too, we should report InputAddr as the IOVA
>
>> +                return -EINVAL;
>> +            }
>> +            tt->ttb = CACHED_ENTRY_TO_ADDR(entry, tt->ttb);
>> +        }
>> +
>>          tt->had = CD_HAD(cd, i);
>>          trace_smmuv3_decode_cd_tt(i, tt->tsz, tt->ttb, tt->granule_sz, tt->had);
>>      }
>> @@ -767,12 +808,12 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
>>          return 0;
>>      }
>>  
>> -    ret = smmu_get_cd(s, &ste, 0 /* ssid */, &cd, event);
>> +    ret = smmu_get_cd(s, &ste, cfg, 0 /* ssid */, &cd, event);
>>      if (ret) {
>>          return ret;
>>      }
>>  
>> -    return decode_cd(cfg, &cd, event);
>> +    return decode_cd(s, cfg, &cd, event);
>>  }
>>  
>>  /**
>> @@ -832,13 +873,40 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>>                                                   SMMUTransCfg *cfg,
>>                                                   SMMUEventInfo *event,
>>                                                   IOMMUAccessFlags flag,
>> -                                                 SMMUTLBEntry **out_entry)
>> +                                                 SMMUTLBEntry **out_entry,
>> +                                                 SMMUTranslationClass class)
>>  {
>>      SMMUPTWEventInfo ptw_info = {};
>>      SMMUState *bs = ARM_SMMU(s);
>>      SMMUTLBEntry *cached_entry = NULL;
>> +    int asid, stage;
>> +    bool S2_only = class != SMMU_CLASS_IN;
>> +
>> +    /*
>> +     * The function uses the argument class to indentify which stage is used:
> identify
>
>> +     * - CLASS = IN: Means an input translation, determine the stage from STE.
>> +     * - CLASS = CD: Means the addr is an IPA of the CD, and it would be
>> +     *   tranlsated using the stage-2.
> translated
>
>> +     * - CLASS = TT: Means the addr is an IPA of the stage-1 translation table
>> +     *   and it would be tranlsated using the stage-2.
> translated
>
>> +     * For the last 2 cases instead of having intrusive changes in the common
>> +     * logic, we modify the cfg to be a stage-2 translation only in case of
>> +     * nested, and then restore it after.
>> +     */
>> +    if (S2_only) {
> "S2_only" seems a bit confusing because in the spec "stage 2-only" means
> absence of nesting, which is the opposite of what we're handling here.
> I don't have a good alternative though, maybe "desc_s2_translation"
In 7.3.13 F_WALK_EABT, "S2 descriptor fetch" terminology is used.

Thanks

Eric
>
> Thanks,
> Jean
>
>> +        asid = cfg->asid;
>> +        stage = cfg->stage;
>> +        cfg->asid = -1;
>> +        cfg->stage = SMMU_STAGE_2;
>> +    }
>>  
>>      cached_entry = smmu_translate(bs, cfg, addr, flag, &ptw_info);
>> +
>> +    if (S2_only) {
>> +        cfg->asid = asid;
>> +        cfg->stage = stage;
>> +    }
>> +
>>      if (!cached_entry) {
>>          /* All faults from PTW has S2 field. */
>>          event->u.f_walk_eabt.s2 = (ptw_info.stage == SMMU_STAGE_2);
>> @@ -855,7 +923,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>>                  event->type = SMMU_EVT_F_TRANSLATION;
>>                  event->u.f_translation.addr = addr;
>>                  event->u.f_translation.addr2 = ptw_info.addr;
>> -                event->u.f_translation.class = SMMU_CLASS_IN;
>> +                event->u.f_translation.class = class;
>>                  event->u.f_translation.rnw = flag & 0x1;
>>              }
>>              break;
>> @@ -864,7 +932,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>>                  event->type = SMMU_EVT_F_ADDR_SIZE;
>>                  event->u.f_addr_size.addr = addr;
>>                  event->u.f_addr_size.addr2 = ptw_info.addr;
>> -                event->u.f_addr_size.class = SMMU_CLASS_IN;
>> +                event->u.f_addr_size.class = class;
>>                  event->u.f_addr_size.rnw = flag & 0x1;
>>              }
>>              break;
>> @@ -873,7 +941,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>>                  event->type = SMMU_EVT_F_ACCESS;
>>                  event->u.f_access.addr = addr;
>>                  event->u.f_access.addr2 = ptw_info.addr;
>> -                event->u.f_access.class = SMMU_CLASS_IN;
>> +                event->u.f_access.class = class;
>>                  event->u.f_access.rnw = flag & 0x1;
>>              }
>>              break;
>> @@ -882,7 +950,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>>                  event->type = SMMU_EVT_F_PERMISSION;
>>                  event->u.f_permission.addr = addr;
>>                  event->u.f_permission.addr2 = ptw_info.addr;
>> -                event->u.f_permission.class = SMMU_CLASS_IN;
>> +                event->u.f_permission.class = class;
>>                  event->u.f_permission.rnw = flag & 0x1;
>>              }
>>              break;
>> @@ -943,7 +1011,8 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>>          goto epilogue;
>>      }
>>  
>> -    status = smmuv3_do_translate(s, addr, cfg, &event, flag, &cached_entry);
>> +    status = smmuv3_do_translate(s, addr, cfg, &event, flag,
>> +                                 &cached_entry, SMMU_CLASS_IN);
>>  
>>  epilogue:
>>      qemu_mutex_unlock(&s->mutex);
>> -- 
>> 2.45.2.803.g4e1b14247a-goog
>>



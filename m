Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2074C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 16:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQquf-00019S-VB; Mon, 08 Jul 2024 12:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sQquc-0000xK-QB
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 12:08:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sQquZ-0008Ky-Qc
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 12:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720454899;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nym5FvWMwH5SD/Y1P9XfQzH0qtlU4H2/FGUuCATe+Fw=;
 b=DX3BJzuhig6/6RW4CHnrM9vpJ2eX+ROaa2x/kuSrXDf0GKSykrM/HwoEjQ4dEvbcwBAYh4
 mMHC/4hwuOy/BVMP7xFqDqiNJIuSxbl/Mhmy7c+8DssBXi1YhgoeahSjqbZkSA9zo0+c2b
 eSnnff9ZG7Dxs47/9d0CPWl2Fb7kU7c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-xZObQWRuMnewaJ5lNwRYkw-1; Mon, 08 Jul 2024 12:08:15 -0400
X-MC-Unique: xZObQWRuMnewaJ5lNwRYkw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-367990b4beeso2913918f8f.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 09:08:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720454894; x=1721059694;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nym5FvWMwH5SD/Y1P9XfQzH0qtlU4H2/FGUuCATe+Fw=;
 b=pKUI8INtyTzR56P9MTJ/yq7x53jluCh8SWgFFOcTXmfj9csJlsSxalFOxTNeqvuLDA
 VrFIzzR9mDzFNraY0utpOGJ0NN56AkmNWJwdFPR7rbnRHiv4bOLneCpUKCDZVFY3QtCt
 7tT8AvUwWnBVtKuX0A3OokXYJ61k9KrRsGmkgIwhlmnbEB3oTZUh0GHU2llO6Jl6Njgu
 sFaa8h8NFRBa+0JJrs9tIEVBYn0WhlbkllEkcP04MXGYqMtHfy4kqgLlqcPf/mpipdhe
 LMZhBkDfPtIw7kY0HqK4uBiQAZut58/uw/QGwHOXN9FEhLoR5dfgos2Syxs6IALEdII/
 zF0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnS8OxJtTlh7TQbmI3a4f63sPHPmjLA5uVXdotp+cQjJxc5hb6BDJeLSPpSsUVlhccf4OmQiITBT1Wmbw52GyhzOBXN/c=
X-Gm-Message-State: AOJu0YyYmO1LoaNNPnqiadu8Qglu91AFxyYehCjYyd3XQ4U3RHbSMpAq
 HxHlXlh3stgT9E/BTujrxh7LyLhoOIloauMG67Qz8vJ7/TBW8XbUtZnUZ0Ba7jVCGS9O1oIYbet
 +pSAOcHLqTY5FNtxMOHzp1x3XCSQb8ErZQGk4OpDtZTZ66lpg0vHr
X-Received: by 2002:adf:e947:0:b0:367:8f81:fa09 with SMTP id
 ffacd0b85a97d-367ceaca8b0mr18992f8f.47.1720454893879; 
 Mon, 08 Jul 2024 09:08:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHH2JFirkySth8g68eTcl9WWuxrxyf5BmaPxP3ellA19w0K7M52Oi6gVB7I3aCeL9m0Y239Eg==
X-Received: by 2002:adf:e947:0:b0:367:8f81:fa09 with SMTP id
 ffacd0b85a97d-367ceaca8b0mr18976f8f.47.1720454893452; 
 Mon, 08 Jul 2024 09:08:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde7e1b3sm163587f8f.20.2024.07.08.09.08.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jul 2024 09:08:13 -0700 (PDT)
Message-ID: <4ab5d46c-ac4d-461f-a571-4f0d33554f26@redhat.com>
Date: Mon, 8 Jul 2024 18:08:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/19] hw/arm/smmu: Introduce smmu_iotlb_inv_asid_vmid
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, maz@kernel.org, nicolinc@nvidia.com, julien@xen.org,
 richard.henderson@linaro.org, marcin.juszkiewicz@linaro.org
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-14-smostafa@google.com>
 <20240704183312.GJ1693268@myrica>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240704183312.GJ1693268@myrica>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
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



On 7/4/24 20:33, Jean-Philippe Brucker wrote:
> On Mon, Jul 01, 2024 at 11:02:35AM +0000, Mostafa Saleh wrote:
>> Soon, Instead of doing TLB invalidation by ASID only, VMID will be
>> also required.
>> Add smmu_iotlb_inv_asid_vmid() which invalidates by both ASID and VMID.
>>
>> However, at the moment this function is only used in SMMU_CMD_TLBI_NH_ASID
>> which is a stage-1 command, so passing VMID = -1 keeps the original
>> behaviour.
>>
>> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> One small issue: the change to hw/arm/trace-events for
> trace_smmu_iotlb_inv_asid_vmid() should be in patch 13 rather than 14,
> otherwise the series isn't bisectable.
>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
With Jean's comment addressed
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
>
>> ---
>>  hw/arm/smmu-common.c         | 20 +++++++++++++-------
>>  hw/arm/smmuv3.c              |  2 +-
>>  include/hw/arm/smmu-common.h |  2 +-
>>  3 files changed, 15 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>> index 5bf9eadeff..d0309a95b2 100644
>> --- a/hw/arm/smmu-common.c
>> +++ b/hw/arm/smmu-common.c
>> @@ -159,13 +159,14 @@ void smmu_iotlb_inv_all(SMMUState *s)
>>      g_hash_table_remove_all(s->iotlb);
>>  }
>>  
>> -static gboolean smmu_hash_remove_by_asid(gpointer key, gpointer value,
>> -                                         gpointer user_data)
>> +static gboolean smmu_hash_remove_by_asid_vmid(gpointer key, gpointer value,
>> +                                              gpointer user_data)
>>  {
>> -    int asid = *(int *)user_data;
>> +    SMMUIOTLBPageInvInfo *info = (SMMUIOTLBPageInvInfo *)user_data;
>>      SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
>>  
>> -    return SMMU_IOTLB_ASID(*iotlb_key) == asid;
>> +    return (SMMU_IOTLB_ASID(*iotlb_key) == info->asid) &&
>> +           (SMMU_IOTLB_VMID(*iotlb_key) == info->vmid);
>>  }
>>  
>>  static gboolean smmu_hash_remove_by_vmid(gpointer key, gpointer value,
>> @@ -270,10 +271,15 @@ void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
>>                                  &info);
>>  }
>>  
>> -void smmu_iotlb_inv_asid(SMMUState *s, int asid)
>> +void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid)
>>  {
>> -    trace_smmu_iotlb_inv_asid(asid);
>> -    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid, &asid);
>> +    SMMUIOTLBPageInvInfo info = {
>> +        .asid = asid,
>> +        .vmid = vmid,
>> +    };
>> +
>> +    trace_smmu_iotlb_inv_asid_vmid(asid, vmid);
>> +    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid_vmid, &info);
>>  }
>>  
>>  void smmu_iotlb_inv_vmid(SMMUState *s, int vmid)
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index e5ecd93258..928f125523 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -1329,7 +1329,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>>  
>>              trace_smmuv3_cmdq_tlbi_nh_asid(asid);
>>              smmu_inv_notifiers_all(&s->smmu_state);
>> -            smmu_iotlb_inv_asid(bs, asid);
>> +            smmu_iotlb_inv_asid_vmid(bs, asid, -1);
>>              break;
>>          }
>>          case SMMU_CMD_TLBI_NH_ALL:
>> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
>> index de032fdfd1..2bc9a03d47 100644
>> --- a/include/hw/arm/smmu-common.h
>> +++ b/include/hw/arm/smmu-common.h
>> @@ -212,7 +212,7 @@ void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
>>  SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
>>                                  uint8_t tg, uint8_t level);
>>  void smmu_iotlb_inv_all(SMMUState *s);
>> -void smmu_iotlb_inv_asid(SMMUState *s, int asid);
>> +void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid);
>>  void smmu_iotlb_inv_vmid(SMMUState *s, int vmid);
>>  void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
>>                           uint8_t tg, uint64_t num_pages, uint8_t ttl);
>> -- 
>> 2.45.2.803.g4e1b14247a-goog
>>



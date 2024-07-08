Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA95BC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 13:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQoPL-0001xA-T1; Mon, 08 Jul 2024 09:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sQoPK-0001rD-CI
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 09:27:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sQoPE-0004qL-Pd
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 09:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720445265;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GBg8DTmpRCRORQjVbZrwngCucqavvFsZaznshBr/qow=;
 b=HdqPnQVY19vOaCD7dPkYnv3CvK8uJx653u8Sy30LFXwkmZ+CiwdnaOAm8mOlwYEfQZMW7W
 apSektmF66rNUcZ45d5uo51DsUq5/pWsnhJIKcqAW/j2xf3YsNiCIae9PIJiefZkRrfUBD
 P5kkBbXqiAWcCOENxjJGU71trtnwoa8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-uGV_R0z9NoqsA3RxlSzHng-1; Mon, 08 Jul 2024 09:27:43 -0400
X-MC-Unique: uGV_R0z9NoqsA3RxlSzHng-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42666785d74so6815175e9.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 06:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720445262; x=1721050062;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GBg8DTmpRCRORQjVbZrwngCucqavvFsZaznshBr/qow=;
 b=gVi2OOPdOo9po4ezkaqQTI18H4ohbmOLMlg3Y4d1RHC0H8Qy03M0XKY/m48pb6Z8Mi
 PlN6zVYF7rp7Ak1GBXRRtAEMmFYK6w4nh6nFWi9M0ds6YxZmOaYr2YH2h1gmdnxINDm3
 WzdKI/kR0JEOHg2+9vk2Xllr+kvVR55oxU5WbZ0iUN9RKu3WwhCeN3VhV9LH9GetRgm0
 WGwHa1NitfGwZxmK/0EyrxIFOAs+o3Hb6X5y361dTuI12VZSoFAi1CpROMnZ17bNVuCx
 G32zhLisPk74GuoSB7aP6GZcD6mlPb6bWuOuK8ewAEjfjg7Sk5wIMMLP2FIMxnH716Sn
 YloQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF3OOYYDwQIHDG41TYPf8G6s5V0aKdxBDtBPdAvSNaM2Uqfz57sQAhr/18eIRZYYBlBXsCwjjEt3QPBWRdl8Qca4msYls=
X-Gm-Message-State: AOJu0Yy/1349TAVtKsRKe2zV9bPFHx/D0IZ2QMwpH+NUEakHKqwPZKM3
 mWT/+6fm6dSStWN8MNPMEpdELmfBD4qgzJeWALarA3njHIwTF3jYBWpNH6ynRUsr8PLf5az2S1q
 IZdy3HZ4seSMoqDtwAAIYDBTYFJwpNxu881TWVCGyJ1pCgXIZOaHV
X-Received: by 2002:a05:600c:18a6:b0:426:5e32:4857 with SMTP id
 5b1f17b1804b1-4265e324bf4mr57943455e9.0.1720445262527; 
 Mon, 08 Jul 2024 06:27:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBgTGkiDFwmSxtRUibcAU1uyNGdOna1nFKk4zkBlwuDdHmp6LNrGSvx9qeNRf9Wz+H6zLa9w==
X-Received: by 2002:a05:600c:18a6:b0:426:5e32:4857 with SMTP id
 5b1f17b1804b1-4265e324bf4mr57943215e9.0.1720445262194; 
 Mon, 08 Jul 2024 06:27:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1d169dsm167318375e9.5.2024.07.08.06.27.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jul 2024 06:27:41 -0700 (PDT)
Message-ID: <2e9dd97d-6e67-41f1-a8a2-71c90b163c56@redhat.com>
Date: Mon, 8 Jul 2024 15:27:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/19] hw/arm/smmu: Introduce CACHED_ENTRY_TO_ADDR
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, maz@kernel.org, nicolinc@nvidia.com, julien@xen.org,
 richard.henderson@linaro.org, marcin.juszkiewicz@linaro.org
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-8-smostafa@google.com>
 <20240704180438.GD1693268@myrica>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240704180438.GD1693268@myrica>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Mostafa,

On 7/4/24 20:04, Jean-Philippe Brucker wrote:
> On Mon, Jul 01, 2024 at 11:02:29AM +0000, Mostafa Saleh wrote:
>> Soon, smmuv3_do_translate() will be used to translate the CD and the
>> TTBx, instead of re-writting the same logic to convert the returned
>> cached entry to an address, add a new macro CACHED_ENTRY_TO_ADDR.
>>
>> Signed-off-by: Mostafa Saleh <smostafa@google.com>
>> ---
>>  hw/arm/smmuv3.c              | 3 +--
>>  include/hw/arm/smmu-common.h | 3 +++
>>  2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index cc61708160..229b3c388c 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -950,8 +950,7 @@ epilogue:
>>      switch (status) {
>>      case SMMU_TRANS_SUCCESS:
>>          entry.perm = cached_entry->entry.perm;
>> -        entry.translated_addr = cached_entry->entry.translated_addr +
>> -                                    (addr & cached_entry->entry.addr_mask);
>> +        entry.translated_addr = CACHED_ENTRY_TO_ADDR(cached_entry, addr);
>>          entry.addr_mask = cached_entry->entry.addr_mask;
>>          trace_smmuv3_translate_success(mr->parent_obj.name, sid, addr,
>>                                         entry.translated_addr, entry.perm,
>> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
>> index 96eb017e50..09d3b9e734 100644
>> --- a/include/hw/arm/smmu-common.h
>> +++ b/include/hw/arm/smmu-common.h
>> @@ -37,6 +37,9 @@
>>  #define VMSA_IDXMSK(isz, strd, lvl)         ((1ULL << \
>>                                               VMSA_BIT_LVL(isz, strd, lvl)) - 1)
>>  
>> +#define CACHED_ENTRY_TO_ADDR(ent, addr)      (ent)->entry.translated_addr + \
>> +                                             ((addr) & (ent)->entry.addr_mask);
> nit: maybe wrap this in parenthesis to avoid future usage mistakes and
> drop the semicolon 
With Jean's comments taken into account,
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
>
> Thanks,
> Jean
>
>> +
>>  /*
>>   * Page table walk error types
>>   */
>> -- 
>> 2.45.2.803.g4e1b14247a-goog
>>



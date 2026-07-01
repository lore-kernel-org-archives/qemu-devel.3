Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 461F7C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weuTL-00016g-Po; Wed, 01 Jul 2026 08:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1weuTG-00015v-DT
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 08:55:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1weuTE-0000iC-MS
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 08:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782910514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=T9Rntc1eFU0fnBp/y55lYm9L4cf523oC1ftAIkxhkS8=;
 b=KBvwtwfMa4pFSLnq/hJa4MmmhvcV6rOIKE5B8G1PmFkfKQRhu+gwew+6SOoR9QBMi5h9Td
 NN15GXg2L4nLUrgs0jy3ZEUb3+U6zkPzkG4TEYRQxTnN+Yg8HCxTyWYA1y4km2aIMEkjd3
 oqcnb/w3hZD3OXW5Vai4+g0UwwGVxyI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-kRVPnC-_Pt6krBZUWodvdg-1; Wed, 01 Jul 2026 08:55:13 -0400
X-MC-Unique: kRVPnC-_Pt6krBZUWodvdg-1
X-Mimecast-MFC-AGG-ID: kRVPnC-_Pt6krBZUWodvdg_1782910512
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490a767b782so6800235e9.2
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 05:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782910512; x=1783515312; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=T9Rntc1eFU0fnBp/y55lYm9L4cf523oC1ftAIkxhkS8=;
 b=hCa7hTwvQRZFKQMud+PEq6WqeGusT1fzgG7Btj9Ls4gBPoge4Xm4hx5YjBfj61s3mu
 fBAe0WB+Tj2QlK9fvcxXBnGBRizORX90hckd2kaGmLGI2PPLHd6wg7I/LuFEBoyq8Jzs
 xWFYuA48PcS0piqzwUVfApX10L+a6ngaJqA53bRG0k5NvYNHOEmQi4Tf1a9fW07niX4H
 fq4FGMwypmjy6tlilsnm5eN4Vt8kYIE757DPQHqdckn09RFwGESzK//fTlkB00F/pj4O
 4qh5AaapOoQ8uRsaT3BGLdkS+XzqgRg+6FwQ3g3R6pPjspkURuI6e1Gde2k3VIqKJZ2y
 AFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782910512; x=1783515312;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T9Rntc1eFU0fnBp/y55lYm9L4cf523oC1ftAIkxhkS8=;
 b=pYY2e5RyfQVLtAmk8lxcL7f6hkYRzUpEIWLMzBAEyvrHOZ3T8OeeRfYNzLibe828Hw
 p/mawmvA8V5zUauyhRZXLbYDah0dRFoETvPJ5TQvTp92aaqGPi6ja6UyO9I3uvY33Yzk
 rkj3Jvqvp9sp2O6spf/pP2kWbnV1NLc1rgyJKAfI6oVtFJPPVPVjmNYYx0486ym+zHox
 JAjSN8B79Kv1xX+bc3sqgP2y9MEmsxZDyWQcBQx3rKygL9D/LI1w8BrZoj7Ht6umFGBu
 Bh3Udww/5corCg2R5caGfzFvnvbpGmQCpZcQBYhz0ttYNfC5QeBJDmHf24B5GyHKyn4E
 Rcew==
X-Gm-Message-State: AOJu0YxjqKLLleefwan5Xdb6ys7Dk3f/kfA/XlZ9LzVGksFs4hrMsnUE
 VBicccaBgrqqr38jg0YlCrsEK+3dvYwkua5NNlsv+3X9f3e0yxPIjcKPyps+m/4/YCxDR6/7sq6
 it5tztnTg+Z1O9YfNKB36olQK14e6601TVWVMx7iWl9ByFQiuUTqHmFLH
X-Gm-Gg: AfdE7cn1yYT4j9mRrwwIpLQ3293qSAm0WUmlxj+MUuu4W0kMdu4OiIodfaKE659o87X
 DAPT4eYosVjLbUqAbLvcPeyK71Qx0V0azVn/cnR8Ug/kkjk6QptoCkYOm+1GdR7ATwqOQgPk+QI
 z+KleuC5HpBRKvCzLx0LGzytUOer6xXcRlCr6sdXjBp90TSs2M16MvG9qNF+TYl7Bw8nWu//u1r
 epoO42EauXPfoGVSQLF+jAU/2WM6L4VezFOv6aQQ3zhX+A5YLQf2+dFQYBrOLNSki+nmtRfVkch
 JldpXwUb4Vi1StCOXbiycRC+z0JalHTKDpXkKMe55bghjG29JkeE/miBkRLdimeWPKBA0VuPurh
 m1+zEgAbylBdNjlFQcB1qY0uWMay0d7VdHDj0t5Bxe8tB+T3kag==
X-Received: by 2002:a05:600c:3484:b0:492:3237:ddf with SMTP id
 5b1f17b1804b1-493c3cfafd0mr7137135e9.28.1782910512122; 
 Wed, 01 Jul 2026 05:55:12 -0700 (PDT)
X-Received: by 2002:a05:600c:3484:b0:492:3237:ddf with SMTP id
 5b1f17b1804b1-493c3cfafd0mr7136655e9.28.1782910511714; 
 Wed, 01 Jul 2026 05:55:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bef11338sm57193725e9.1.2026.07.01.05.55.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jul 2026 05:55:11 -0700 (PDT)
Message-ID: <27911e71-9073-476b-beb2-8b6a508228c6@redhat.com>
Date: Wed, 1 Jul 2026 14:55:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/listener: Extend safe misalignment check to tpm-ppi
 region
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Alex Williamson <alex@shazbot.org>, Eric Auger <eric.auger@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
References: <20260701080843.2418461-1-clg@redhat.com>
 <CAFEAcA-QHJ=HaBc5WSLLap8NdDw+tty4EFfGt6cmmNOK6e_m7w@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <CAFEAcA-QHJ=HaBc5WSLLap8NdDw+tty4EFfGt6cmmNOK6e_m7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/1/26 12:26, Peter Maydell wrote:
> On Wed, 1 Jul 2026 at 09:09, Cédric Le Goater <clg@redhat.com> wrote:
>>
>> On aarch64 hosts with 64K pages, the platform bus MMIO allocator can
>> allocate the 1KB "tpm-ppi" region at offsets not aligned to the host
>> page size, triggering a noisy VFIO IOMMU warning at VM startup:
>>
>>    vfio_listener_valid_section received unaligned region tpm-ppi
>>      iova=0xc005000 offset_within_region=0x0
>>      qemu_real_host_page_size=0x10000
>>
>> Commit 851d6d1a0ff2 ("vfio/common: remove spurious tpm-crb-cmd
>> misalignment warning") suppressed this for TPM CRB devices via a
>> TPM_IS_CRB(owner) check. However, this misses "tpm-ppi" regions owned
>> by other TPM types like SysBus/ISA tpm-tis devices.
>>
>> Avoid enumerating every TPM device type by matching the "tpm-ppi"
>> memory region name directly in vfio_known_safe_misalignment().
>>
>> Signed-off-by: Cedric Le Goater <clg@redhat.com>
>> ---
>>   hw/vfio/listener.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
>> index c19600e980a8d02217b5d9df4aca8f879ab2c5d5..c76ba285ddb7ef4f93bb081e67de47b3aecbe212 100644
>> --- a/hw/vfio/listener.c
>> +++ b/hw/vfio/listener.c
>> @@ -355,8 +355,10 @@ static void vfio_ram_discard_unregister_listener(VFIOContainer *bcontainer,
>>   static bool vfio_known_safe_misalignment(MemoryRegionSection *section)
>>   {
>>       MemoryRegion *mr = section->mr;
>> +    const char *name = memory_region_name(mr);
>>
>> -    if (!TPM_IS_CRB(mr->owner)) {
>> +    if (!TPM_IS_CRB(mr->owner) &&
>> +        !(name && strcmp(name, "tpm-ppi") == 0)) {
>>           return false;
>>       }
> 
> I think this is the wrong approach, see my comments on the
> other email thread. vfio should not be building up some kind
> of whitelist of "this specific not-page-aligned RAM is OK",
> because a not-page-aligned RAM backed MMIO region is in general
> a normal thing to have.

We should warn for only VFIO-owned regions. I agree.

Forget this patch. It's minor anyway. I will see how the listener
can be improved to remove vfio_known_safe_misalignment()

Thanks,

C.



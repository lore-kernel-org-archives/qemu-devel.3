Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C7ECCF9EE
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 17:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDRAs-0003mO-9Q; Mon, 27 Oct 2025 13:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDRAl-0003lc-Ne
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 13:38:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vDRAf-00075i-Cg
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 13:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761586693;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x7ljtdk6QTU3Cuz3gyrAiBhi8Funmosax55z7rWz2uQ=;
 b=LV1glGeMR/uJ9Anmpuv9O7HsoTELyt62vDyaIroRDKjUin21GrhfQb254gT2kMCSYr8br0
 y2VjSLiSJ8gjbgNiqJG310VS6eY3hiKlVnkKrvfHNXUuS7WB7MraFmckvkARgTde/SS2QZ
 QakRukKvYKoLe1o2jrH3XCeO0tEAXQU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-1exDUhEaMNWOv5pwXysDFA-1; Mon, 27 Oct 2025 13:38:12 -0400
X-MC-Unique: 1exDUhEaMNWOv5pwXysDFA-1
X-Mimecast-MFC-AGG-ID: 1exDUhEaMNWOv5pwXysDFA_1761586691
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-40cfb98eddbso3322714f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 10:38:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761586691; x=1762191491;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x7ljtdk6QTU3Cuz3gyrAiBhi8Funmosax55z7rWz2uQ=;
 b=A0QalaRnWZSbyFelb3MKGIgT5a2bS+Gc68mj+KM3fmY43QGokKaMrCHm7Nq/ndAv6j
 Eya2dH/iDggp7cQzAdtITla2ThqIfyzCmYK5ZHv0zP4edEryaZXHN1Toi8TG9qC4Kuq5
 VmatnQOzvpGTRZnGU7VYhvyGK17/FEAhWpAs5xdHIDXbMrxJLhKZVEszhsCG+qGt2H0+
 g6N7a5s1oKmI1gcWtIeEz7C8ljE9TeK4F99ajjlDtEsME4k/5pekph/8uXwBKSuEWpmI
 GJhfT/Qy2OFZfqUlbsThlpC9kgifYGl10kM0CUiMWf5yJo0ZxQdZsXA+sridF95VQk3f
 UVCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdUvOYVizkPrR/5s/OfDLGXCXEYHCl05hXB97rFmZrLEXQL8DO60DIE/HlFezamvplhuLlWhQmsA+W@nongnu.org
X-Gm-Message-State: AOJu0YxCPPUfREMJtpFESjgRZ1SLoETdwaPddgAZtIqZDbw2B7wYnGUA
 DcA9RR5KRLBv3opAVpZUsxRUfHtJxU508kaCLqhPxDB2PQAx4I0qslmVuezOi/yRo4sUkKP7lnQ
 GsIGeaAg0DMwDVzuqI1Mr2WokD+iUiYpyOkFO9L0TwQDcOxVz2mNArPpV
X-Gm-Gg: ASbGnct/vDai7Fep5lVfKZvYaKv4zrez4Sf/GUL94L5NEtrWe39R1dXVHCXEni0MZ0U
 GZa0juzwrumHqeKgXrbIzfbKKuLvioeHxrnEwMTNVaeMyfT/6r4xWBv+MZ3HW5II36Zap3j+viY
 O0byAIlpjlBZS9z46pwVcc7pvN3zKA4N73IsmMj9yNkcVQTjyy1jLv81Ef0PG6BsmstVcXT7GZN
 FVlo31xZwBhqr+pglXJxv1oCFR4xzk2Su1RdlvFKpie+Oi8tWlJLy/dYH3OQDcrMsK9fYKl/U/O
 Oz3sAXPMS8lVez5EoVohEtOF0QegZj53XBF6aADnBI4swduojJY3KtZut+amJinIZZf72xVE1BY
 T2vVXvvOWzy2q5g3+MzdGNh7cXFsh7hawVyqYF5vVkE5Y9w==
X-Received: by 2002:a05:6000:4021:b0:411:3c14:3ad9 with SMTP id
 ffacd0b85a97d-429a81c3e34mr325734f8f.21.1761586691049; 
 Mon, 27 Oct 2025 10:38:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbvlTRZt7VPRuhOMxtoSO3lpojw9R9eWb+Wpc8TeWzgrwqJsZgm+cDvZywMwLBZ0Jajp3nsQ==
X-Received: by 2002:a05:6000:4021:b0:411:3c14:3ad9 with SMTP id
 ffacd0b85a97d-429a81c3e34mr325722f8f.21.1761586690655; 
 Mon, 27 Oct 2025 10:38:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952e2e06sm15436900f8f.46.2025.10.27.10.38.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 10:38:10 -0700 (PDT)
Message-ID: <25d22f06-69e2-4954-9bd9-f73f899fc114@redhat.com>
Date: Mon, 27 Oct 2025 18:38:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 22/27] hw/arm/smmuv3-accel: Add support for ATS
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, peter.maydell@linaro.org, jgg@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 shameerkolothum@gmail.com
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-23-skolothumtho@nvidia.com>
 <26f4d9b2-75be-4913-bb60-01e647a7ec83@redhat.com>
 <aP+oRLu/BYNaAPHG@Asurada-Nvidia>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <aP+oRLu/BYNaAPHG@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 10/27/25 6:13 PM, Nicolin Chen wrote:
> Hi Eric,
>
> On Mon, Oct 27, 2025 at 05:59:13PM +0100, Eric Auger wrote:
>> On 9/29/25 3:36 PM, Shameer Kolothum wrote:
>>> QEMU SMMUv3 does not enable ATS (Address Translation Services) by default.
>>> When accelerated mode is enabled and the host SMMUv3 supports ATS, it can
>>> be useful to report ATS capability to the guest so it can take advantage
>>> of it if the device also supports ATS.
>>>
>>> Note: ATS support cannot be reliably detected from the host SMMUv3 IDR
>>> registers alone, as firmware ACPI IORT tables may override them. The
>>> user must therefore ensure the support before enabling it.
>> This looks incomplete to me. ATS is a big topic in itself. I would
>> prefer we do not advertise it until we do not have full support for it
>> (including emulation). Comparing to
>> c049bf5bb9dd ("intel_iommu: Add support for ATS") which was recently
>> contributed we miss at least translation request implementations
>> (PCIIOMMUOps ats_request_translation callback implementation).
>>
>> See:
>> https://lore.kernel.org/all/20250628180226.133285-11-clement.mathieu--drif@eviden.com/#r
> In accelerated SMMUv3 case, ATS translation and invalidation are
> done by the physical SMMU. Wondering why do we need this?

in 06/27 you still can have emulated EPs hotplugged in the loop, no?

I remember some discussions with Peter who was also reluctant in general
to introduce some partial feature support. I think in general this is a
good policy to have features emulated and then accelerated. That's also
good for testing in case we can bring up some test env.

Thanks

Eric
>
> IIRC, intel is mixing their emulated translation and accelerated
> one, and their pasid table is not integrated like SMMU's CD table
> that we already passed entirely via the STE.
>
>> Also in SMMU spec I see other stuff like STE.EATS, ATS skipping stage 1,
>> ... Here I only see  SMMU_CMD_ATC_INV and this is only implemented for
>> accel. I think I would rather stick to the minimum in this series, ie.
>> reject in case of ATS mismatch (for testing purpose you will just need a
>> small hack until we get ATS support), work on ATS enablement in parallel
> That SMMU_CMD_ATC_INV seems to be the only thing we need for ATS..
>
> Thanks
> Nicolin
>



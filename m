Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846E1CCD1BF
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 05:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDzAG-00039j-02; Wed, 29 Oct 2025 01:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vDzAA-00037I-Fh
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 01:56:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vDz9w-0004hZ-3G
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 01:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761717344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1o1n3zkkomerIivcCOpA8hDMEzivep5yr5QizrlN9zw=;
 b=ALkCvQBLBRTPbj1KcK0w6hHT4qHUgxiikbPwK2LvHHW03+7hWoC0IWm1hUdU9MvNblNJby
 MKfLNTtVQoMoZq69woCyCHDr15NO+NzKNp/0R9Vrsib6Zj2AjExTH7GM0vDD9DsOzGo7ab
 oMynFAvqUi7H8H7jpETE22oeuTFKqG4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-hgG2OD2kPqihcmCiqh_wOQ-1; Wed, 29 Oct 2025 01:55:42 -0400
X-MC-Unique: hgG2OD2kPqihcmCiqh_wOQ-1
X-Mimecast-MFC-AGG-ID: hgG2OD2kPqihcmCiqh_wOQ_1761717341
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b704635310aso21613466b.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 22:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761717341; x=1762322141;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1o1n3zkkomerIivcCOpA8hDMEzivep5yr5QizrlN9zw=;
 b=ngXyX1HTXAvHhIJnbJV9QUUXad4xAwWSmjhTNoj9XusAKLBPniXr/7jHByn4p/Icw6
 iq0g6xqt1Aewkj4daNm2rtJFakE274Um+HZ0msr80XGX8qrp5hiE84EE+/0YVCeESWHu
 3UUJtRcSV/1YvKA+wdySwdjAyHVc3fIVBpPbkbOS48vZ5F+XEukMR/8z+GwYg7SopS+2
 GVamrFycDSDtDMq9FEA34LHEfaS7hvkQIh5gIvN2T22Kanj/dJl7aJkOBwsZyLt7cKmt
 ZKOmmQz+0TGziXXqtmO+OySWhWwQmZKraDru+1niBRKtB2d3xTmOjm1gFanh1C0vo+m3
 mkbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUElwO5wHolG8f9JpneDJrrGaPFBDqsoAvXrI/pN2e3dJorTV80YVG+GIXEPm6czWOaL79+LuGgVyk@nongnu.org
X-Gm-Message-State: AOJu0YwtqYKs8pN1Spr4WKsNDuBzXKLCylc3zS8ZzI+yES7P2Y2RK2ES
 qHueE3I3HpXHrTqriPsCHf2IKgNNFk1mku00JNbfw7bqK92PxEFyM2CbnUi+y0cQRTliUkfnTE/
 V9ZGu4SbO4PrUQLrx1uY/KU/SeYKYSgwsGcoSIBWWfgL5G1cqPXgnKGaR
X-Gm-Gg: ASbGncsnQNwYF5bg2l+W+nRyYxKfFkIgK0gMAGW9xldTlOwg7/fUcdRi10bLPRDqJ0w
 P3+tOt1yTrrE78SalRIiKP2F9x0TvPi5FwKy0r5bi+Uw0x0s9rW4THfgdzfPPjdLc2OUO1iDdyV
 GshG8Cr5g1e6UVZS/R4pX7ZKoTaL4IQh+DbmttXH99estEBAT9GP+VOzj/HfWX7ncMKRNY49xA5
 ZFRrUP4z6TEwoDBXTb0NWkrVWXyjV4O6Mi6Ey4J1SnA4kmd8Ao9uC7ENli4DevYAePvFLVvRFY9
 uypbi8IL5gIH5IxSHcx8W53Wy6OISOV9qR4fUoiKft6WwkhWxPYy+2/O+VD5M0xKNx9blkY=
X-Received: by 2002:a17:907:3d0d:b0:b3e:6091:2c7d with SMTP id
 a640c23a62f3a-b703d3ccd97mr179648366b.27.1761717340896; 
 Tue, 28 Oct 2025 22:55:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiPU+C6AuaDOTUjd8ldoDv6qA4GnjKQUW+hfwEDTJEc1Rp6aVJFGS7iqPK8vF1ViI3lCG0PQ==
X-Received: by 2002:a17:907:3d0d:b0:b3e:6091:2c7d with SMTP id
 a640c23a62f3a-b703d3ccd97mr179645566b.27.1761717340513; 
 Tue, 28 Oct 2025 22:55:40 -0700 (PDT)
Received: from [192.168.0.7] ([47.64.112.33]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d85309074sm1307010066b.2.2025.10.28.22.55.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 22:55:40 -0700 (PDT)
Message-ID: <32efa600-0faf-481e-a98e-31a83d298b52@redhat.com>
Date: Wed, 29 Oct 2025 06:55:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/25] hw/s390x: Use memory_region_get_address()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
References: <20251028181300.41475-1-philmd@linaro.org>
 <20251028181300.41475-17-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251028181300.41475-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 28/10/2025 19.12, Philippe Mathieu-Daudé wrote:
> MemoryRegion::addr is private data of MemoryRegion, use
> memory_region_get_address() to access it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/s390x/s390-pci-inst.c | 21 ++++++++++++++-------
>   1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> index 5841dfc4fec..d4adf782ca1 100644
> --- a/hw/s390x/s390-pci-inst.c
> +++ b/hw/s390x/s390-pci-inst.c
> @@ -394,11 +394,14 @@ static MemoryRegion *s390_get_subregion(MemoryRegion *mr, uint64_t offset,
>   {
>       MemoryRegion *subregion;
>       uint64_t subregion_size;
> +    hwaddr subregion_addr;
>   
>       QTAILQ_FOREACH(subregion, &mr->subregions, subregions_link) {
>           subregion_size = memory_region_size(subregion);
> -        if ((offset >= subregion->addr) &&
> -            (offset + len) <= (subregion->addr + subregion_size)) {
> +        subregion_addr = memory_region_get_address(subregion);
> +
> +        if ((offset >= subregion_addr) &&
> +            (offset + len) <= (subregion_addr + subregion_size)) {

While you're at it, you could also drop the superfluous parentheses here.

Anyway:
Reviewed-by: Thomas Huth <thuth@redhat.com>



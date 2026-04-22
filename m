Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1EF5F9B61A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 10:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFVG6-0003PF-Gz; Wed, 22 Apr 2026 06:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wFVG4-0003Oo-Aa
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:56:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wFVG1-0007Bf-HB
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 06:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776855396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MpRRRI/7Q+3Jy7LH1bV8jknOmEeoebCV+6XCk0I0G+I=;
 b=Zvyoz2PwDCkV3vPh9QokHZb7umonIR2+eCnmtnQT1ptJ7iT0mcJQScypTCA8cU+5JSb992
 6JXOYpGVlQK23RSWNBH5kxc+sAXcG6l2/7XAD03M+nZQ8G4DdEpn+mlfZSoGgxJS/sSOu5
 JtDiKDS2bMtacXh+s2Q2I97MP4RdF9Q=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-SMlbkNH7M5e9rhuhe2eCrw-1; Wed, 22 Apr 2026 06:56:35 -0400
X-MC-Unique: SMlbkNH7M5e9rhuhe2eCrw-1
X-Mimecast-MFC-AGG-ID: SMlbkNH7M5e9rhuhe2eCrw_1776855394
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5a1154f41fdso2857188e87.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 03:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776855393; x=1777460193; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=MpRRRI/7Q+3Jy7LH1bV8jknOmEeoebCV+6XCk0I0G+I=;
 b=mvGgAAZrlg5vS7BW3v4d28/mxKyB8whG6TJ+VwDYEuFWna42lAz3zcWe8EgwBQOxYu
 2blZ3RqGQu2dRn0wofocgnGbbKorJja2h1Pme17mr4uXKovlq29U9qDB3GF3ZEl3/tjA
 8ZeILRYLNmTIzV9Y5TlZp8k7J4Q65EhCSi4vC1vwsUINdcAOtmAdEZIyzvcojP81O75o
 OVlFC+xldM7Jq3zwc0Y1HhNZyHKDXiiHzEZihghtKpwsUel5iXwvdYlVgbJouF397VBF
 d+Q9cWHVpDYL2I/s3L2p1pl+Jnz8i3ozpGxM7bLVy9jYNo+m74xXW+MMf7khXaQOy4LD
 faZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776855393; x=1777460193;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MpRRRI/7Q+3Jy7LH1bV8jknOmEeoebCV+6XCk0I0G+I=;
 b=K4vs/pkdXQQRn8hSndp8c3hb9R7KsYjzP87m5Epj3rFqwpP6x7K0IQi/ZPe1WJXwIC
 a4UkLEOcwi78a0haNUdJJescau60UbmTw11s7PlSo4VyF35G1Gd1HPaTQUqdLxdYLR7S
 srvdFCn6RTA/NdnAgNjktma9R8OlfLPNpy/xmTaP7aTVIQaTzgEGGBnX4NqtlhvyKf5O
 ZXnYd1msixaEj4Xv1e+NEcEdbN7jp2+s982+ceRcAWVudFcMd+X02qFiL4rYT/eNeU57
 QtCDzy8FwdayAruSsO7aM9keuMQuVe2lHGNbptIrR7m3cA+zp0vagCxvBJVCLMEz0699
 qgMw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/SDElTdWSdGunUOWU8cJsTHT14BhOBEz/HztMG5CVGbcgkXQhGGb//l3O4ut6nZ+rcLrP1L//WEljE@nongnu.org
X-Gm-Message-State: AOJu0YxosrVrLMPaztqLtJv1k7HdN3T0WHaEnsh0OI9XiMwhfJwwBW4R
 r/86/sTfHnuYG7Zk2LwPZUTKhUUk9S0zd7gbDfuibB9UL8Lq7RQA6C5qh3T6ZXupVi7aGQ//WTL
 54P4riy+M2ghx99VPdTzNSlbV1VJD7Tp7ra5svyNY4E0Z+s8p4qiOYgl2
X-Gm-Gg: AeBDiesACAzuQ8t9Ki2Dv9roI34c70GyXuyo/SuAJjPyVxk5WSqcLrdiB3ja3c3FuMV
 lXkQ1ieU7NKKoURKJ1wQprzuesVEUhQRtd8W47nl1fVVBvgstKbbNjmPRYN2BmzVDmf+8nKjw9/
 1sTYBj0ZvpHrU2NBwH3zZd+xzra7rFBpwi+lZTwhJVIBR9DtrJtVHbYK81Ud+864vr953zen87o
 yZRTa8LY9QWT5J8ax+a3jcuPbtb4h2qXA1MF2t5VqiyXVzaoEhC9Ypm0rCWg/Mfh3GuE/sDEukM
 y+qdM3nD+u42p5o+/GGI/GVvUlkKXB042h+Z+V3Kl2Z/N3naiVgbejcZJO73MobK2+6YezumsLX
 zEoim+KRz1+j06BnTiEywFeWBQt6GaA==
X-Received: by 2002:a05:6512:b89:b0:5a2:7b74:3c60 with SMTP id
 2adb3069b0e04-5a4172ddc33mr7754958e87.33.1776855393384; 
 Wed, 22 Apr 2026 03:56:33 -0700 (PDT)
X-Received: by 2002:a05:6512:b89:b0:5a2:7b74:3c60 with SMTP id
 2adb3069b0e04-5a4172ddc33mr7754945e87.33.1776855392809; 
 Wed, 22 Apr 2026 03:56:32 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.147])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185ad11fsm4293552e87.14.2026.04.22.03.56.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 03:56:32 -0700 (PDT)
Message-ID: <86c40a92-76d0-4121-9347-929cfcd32f2a@redhat.com>
Date: Wed, 22 Apr 2026 12:56:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] hw/core/register: add the REGISTER_ARRAY type
To: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20251017161809.235740-1-luc.michel@amd.com>
 <20251017161809.235740-3-luc.michel@amd.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251017161809.235740-3-luc.michel@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 17/10/2025 18.18, Luc Michel wrote:
> Introduce the REGISTER_ARRAY QOM type. This type reuses the existing
> RegisterInfoArray struct. When `register_init_block' is called, it creates
> a REGISTER_ARRAY object and parents it to the calling device. This way
> it gets finalized when the device is. The memory region is parented to
> the REGISTER_ARRAY object to ensure correct finalizing order.
> 
> The finalize function of the REGISTER_ARRAY type performs the necessary
> cleaning that used to be done by `register_finalize_block'. The latter
> is left empty and will be removed when all the register API users have
> been refactored.
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> ---
>   include/hw/register.h |  4 ++++
>   hw/core/register.c    | 26 ++++++++++++++++++++++----
>   2 files changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/include/hw/register.h b/include/hw/register.h
> index 4d13ea183c7..65c82600e06 100644
> --- a/include/hw/register.h
> +++ b/include/hw/register.h
> @@ -81,10 +81,12 @@ struct RegisterInfo {
>       const RegisterAccessInfo *access;
>   
>       void *opaque;
>   };
>   
> +#define TYPE_REGISTER_ARRAY "qemu-register-array"
> +OBJECT_DECLARE_SIMPLE_TYPE(RegisterInfoArray, REGISTER_ARRAY)
>   
>   /**
>    * This structure is used to group all of the individual registers which are
>    * modeled using the RegisterInfo structure.
>    *
> @@ -94,10 +96,12 @@ struct RegisterInfo {
>    *
>    * @mem: optional Memory region for the register
>    */
>   
>   struct RegisterInfoArray {
> +    Object parent_obj;
> +
>       MemoryRegion mem;
>   
>       int num_elements;
>       RegisterInfo **r;
>   
> diff --git a/hw/core/register.c b/hw/core/register.c
> index 2553cb15aba..1612ad174f9 100644
> --- a/hw/core/register.c
> +++ b/hw/core/register.c
> @@ -243,14 +243,20 @@ static RegisterInfoArray *register_init_block(DeviceState *owner,
>                                                 bool debug_enabled,
>                                                 uint64_t memory_size,
>                                                 size_t data_size_bits)
>   {
>       const char *device_prefix = object_get_typename(OBJECT(owner));
> -    RegisterInfoArray *r_array = g_new0(RegisterInfoArray, 1);
> +    Object *obj;
> +    RegisterInfoArray *r_array;
>       int data_size = data_size_bits >> 3;
>       int i;
>   
> +    obj = object_new(TYPE_REGISTER_ARRAY);
> +    object_property_add_child(OBJECT(owner), "reg-array[*]", obj);
> +    object_unref(obj);
> +
> +    r_array = REGISTER_ARRAY(obj);
>       r_array->r = g_new0(RegisterInfo *, num);
>       r_array->num_elements = num;
>       r_array->debug = debug_enabled;
>       r_array->prefix = device_prefix;
>   
> @@ -265,11 +271,11 @@ static RegisterInfoArray *register_init_block(DeviceState *owner,
>           r->opaque = owner;
>   
>           r_array->r[i] = r;
>       }
>   
> -    memory_region_init_io(&r_array->mem, OBJECT(owner), ops, r_array,
> +    memory_region_init_io(&r_array->mem, OBJECT(r_array), ops, r_array,
>                             device_prefix, memory_size);

  Hi,

this likely broke the xlnx-versal-ospi device, see:

  https://gitlab.com/qemu-project/qemu/-/work_items/3422

Could you please have a look?

  Thanks,
   Thomas



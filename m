Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5057FC36012
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 17:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txUPB-0000Xl-IK; Wed, 26 Mar 2025 13:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1txUPA-0000XN-AK
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 13:19:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1txUP5-0002b6-Ke
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 13:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743009537;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7XQvP7jLQwf9arWb8bPTYpUe/xSLVt/wBVX3CSaM1Wc=;
 b=CK8EuMh/RT10Qf7qUD9Udrf7I/TFGP6hlTieA2+LRiV+NFilkKOUzNogABsd3ZpmjI43yQ
 PbAEkfsDwGqVKt/IQf7S1vZMyzj9VIZAzWVcrEeBIK98XtbYhUgItlaumhK+tYsBF3G1pf
 SU+eU4oDt1628bS4G8szL3SEuCLQISs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-DvuXCjk9NQOjPplh42F93g-1; Wed, 26 Mar 2025 13:18:54 -0400
X-MC-Unique: DvuXCjk9NQOjPplh42F93g-1
X-Mimecast-MFC-AGG-ID: DvuXCjk9NQOjPplh42F93g_1743009533
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43ab5baf62cso791825e9.0
 for <qemu-devel@nongnu.org>; Wed, 26 Mar 2025 10:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743009533; x=1743614333;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7XQvP7jLQwf9arWb8bPTYpUe/xSLVt/wBVX3CSaM1Wc=;
 b=r/SEHZVpOmvsx2cbXxWap4G7ixDeGFuynRrBYqHvZJbqbhwN+M3Y5z3S7V/MuV5MtB
 v4KfDwTE+gco+X4vgYPlTmGrb+6SenG5USQFNQ0kWmYw8mxayAxSB/4Fs5BWQzR8iOMN
 JJoUJ1a3xLk5SsdUIkqkjkbi+I8zixV/m/9gqX9uGmu3Pn5r2rPnUV9rIAtvh1RhfbT7
 hmfQs29O4jiUC5Ml1VrQ8paTHwbBQB3qKzWsX7RAzmcDNOmrzt/+Z0p10tQ1+YQ96tVw
 G+L/D1hp2rpe+bfTBE96wQzSKim4s3ZcyQ5gb/5dGPdsqyhC7Nez1/VEyYVHWdRwrkpP
 rE4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIit/BzfhUZs+FzBpjNqNNqCchiJOsSAr1FStNaxs987aYPNVXlBrwZqDIETegBRmIBEGTcP57xpWe@nongnu.org
X-Gm-Message-State: AOJu0YwCOXvnb75Pqm41kG5DxfMTnBNJ31+7LG0EbUqxQuyRFjq9vqU/
 rjqttmLysN1ekjrJqT0y244ICOW6Xo98i0+r0SKiZXiIEGLnh8Z7dE41vgXgxg2ou1S1q4Uml16
 HAQhToTyiIJG1BEap/RJwGJFjHDx/H8AuKNi7eNzecUwwCFa5cs2f
X-Gm-Gg: ASbGncv4nP91iQLtBO6+lfvEqeAnGC9LNA2loOQujxOQUUJRi6PuXjQavKmLAlrRb19
 wcGBrA+Db5BQ8SrSNKRQlCGrrMCqkts1Vz4667TCb52V5liDjwYZzqqZ/wpYewyba28SUazaOpr
 bA82wTRr/NtU16HQf3GZVOoLydv5CwSmIdlkokxow84x1hLvnUd3fbfxdFX1uhAROa/OPObk8X3
 0UFG8QzcEqJsNteEUDi8Ir7TDfo6B72iZ2zn7bAtej6C4YOnRt5xaIms12KWPVkoNVXfk268EyJ
 wmkTHTbMTeAmbZ5yLTf1RFWNFeWi+dAdYQK7iQ5WGjnMtzVG0O4Z78zrRC2BVYk=
X-Received: by 2002:a05:600c:4f56:b0:43c:fe15:41c9 with SMTP id
 5b1f17b1804b1-43d84f94798mr2689035e9.9.1743009532626; 
 Wed, 26 Mar 2025 10:18:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7AWOJlvqligANqNT+aCFxsNQ8/WYmoaOhSyaAqkoctn2o8WLS7AsnUxnPtUd+I4Ae6b3iaw==
X-Received: by 2002:a05:600c:4f56:b0:43c:fe15:41c9 with SMTP id
 5b1f17b1804b1-43d84f94798mr2688675e9.9.1743009532124; 
 Wed, 26 Mar 2025 10:18:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39abfc2115asm11386319f8f.4.2025.03.26.10.18.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Mar 2025 10:18:51 -0700 (PDT)
Message-ID: <477323cb-12d3-484c-8ad9-61229ede3efe@redhat.com>
Date: Wed, 26 Mar 2025 18:18:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 17/20] hw/arm/smmuv3: Check idr registers for
 STE_S1CDMAX and STE_S1STALLD
Content-Language: en-US
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, linuxarm@huawei.com,
 wangzhou1@hisilicon.com, jiangkunkun@huawei.com,
 jonathan.cameron@huawei.com, zhangfei.gao@linaro.org
References: <20250311141045.66620-1-shameerali.kolothum.thodi@huawei.com>
 <20250311141045.66620-18-shameerali.kolothum.thodi@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250311141045.66620-18-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hi,

On 3/11/25 3:10 PM, Shameer Kolothum wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
>
> With nested translation, the underlying HW could support those two fields.
> Allow them according to the updated idr registers after the hw_info ioctl.
s/idr/IDR
>
> When substreams are enabled (S1CDMax != 0), S1DSS field determines
> the behavior of a transaction.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/smmuv3-internal.h |  1 +
>  hw/arm/smmuv3.c          | 15 +++++++++++++--
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index 546f8faac0..530284a9c0 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -612,6 +612,7 @@ static inline void smmuv3_accel_install_nested_ste(SMMUDevice *sdev, int sid)
>  
>  #define STE_S1FMT(x)       extract32((x)->word[0], 4 , 2)
>  #define STE_S1CDMAX(x)     extract32((x)->word[1], 27, 5)
> +#define STE_S1DSS(x)       extract32((x)->word[2], 0,  2)
>  #define STE_S1STALLD(x)    extract32((x)->word[2], 27, 1)
>  #define STE_EATS(x)        extract32((x)->word[2], 28, 2)
>  #define STE_STRW(x)        extract32((x)->word[2], 30, 2)
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index e0f225d0df..e8a6c50056 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -561,6 +561,16 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
>  
>      decode_ste_config(cfg, config);
>  
> +      /* S1DSS.Terminate is same as Config.abort for default stream */

S1DSS. Termination

> +    if (STE_CFG_S1_ENABLED(config) && STE_S1DSS(ste) == 0) {
> +        cfg->aborted = true;
The spec says:
"
When substreams are enabled (STE.S1CDMax != 0), this field determines
the behavior of a transaction or
translation request that arrives without an associated substream:
"
So I understand you should also check STE.S1CDMax. Also how do we check
that the incoming transacrion arrives without a substream?

In general shouldn't we add the support of subtreams in the emulated
code too?

the spec also says that in that case you should record a
F_STREAM_DISABLED event.

> +    }
> +
> +    /* S1DSS.Bypass is same as Config.bypass for default stream */
S1DSS. Bypass
> +    if (STE_CFG_S1_ENABLED(config) && STE_S1DSS(ste) == 0x1) {
> +        cfg->bypassed = true;
> +    }
> +
>      if (cfg->aborted || cfg->bypassed) {
>          return 0;
>      }
> @@ -598,13 +608,14 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
>          }
>      }
>  
> -    if (STE_S1CDMAX(ste) != 0) {
> +    if (!FIELD_EX32(s->idr[1], IDR1, SSIDSIZE) && STE_S1CDMAX(ste) != 0) {
>          qemu_log_mask(LOG_UNIMP,
>                        "SMMUv3 does not support multiple context descriptors yet\n");
the log message should be different because it becomes a guest error:
qemu_log_mask(LOG_GUEST_ERROR, "invalid S1CDMAX as SSIDSIZE==0") or
something alike

>          goto bad_ste;
>      }
>  
> -    if (STE_S1STALLD(ste)) {
> +    /* STALL_MODEL being 0b01 means "stall is not supported" */
> +    if ((FIELD_EX32(s->idr[0], IDR0, STALL_MODEL) & 0x1) && STE_S1STALLD(ste)) {
>          qemu_log_mask(LOG_UNIMP,
>                        "SMMUv3 S1 stalling fault model not allowed yet\n");
same here.

Again I think we need to understand the consequence of having a more
comprehensive support of SSID. This also holds with old the IDR fields
that may be inherited from the HW and we don't support yet in the
emulation code

Thanks

Eric
>          goto bad_ste;



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BDAC36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 13:43:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3EfO-00048c-TD; Fri, 11 Apr 2025 09:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u3EfK-00046F-1m
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 09:43:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u3EfI-0002HL-Ft
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 09:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744379007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dK81+TiYVwH2G+zz+INgbGiCfBcAN6mEIpKy0vNeM+w=;
 b=D0qT2KchjyciMxAuMQyitKh9UctcKtSuNepiR3o4is3TXQxotzPUA9cDPGX08rpy5oAlw+
 37pUUVJ7N0mbI8xVOaPkBnnCkDtAyTRjLs7xs+XWZz/EW09TtHacV1DkV3l8kB8D8+ylW2
 MTKXfNBzqnsnjE6e+JRbn42zyHxORJo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-0Mla_FfFNnOsLKvLmkT9EQ-1; Fri, 11 Apr 2025 09:43:26 -0400
X-MC-Unique: 0Mla_FfFNnOsLKvLmkT9EQ-1
X-Mimecast-MFC-AGG-ID: 0Mla_FfFNnOsLKvLmkT9EQ_1744379005
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39979ad285bso1157700f8f.2
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 06:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744379005; x=1744983805;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dK81+TiYVwH2G+zz+INgbGiCfBcAN6mEIpKy0vNeM+w=;
 b=tynQRsC9dORZ4FSFVp79qPnPLpvFebkmcOKbAOZsO1vRZvGEXcTpyXzOzdK0x7NqT4
 2W85hn6hCW9OUEbGCCOMDWvQGIJgMLHYNZDR0oIaNDRa7C4UwUoBoqeyX7xuXmF5jrQH
 k0dr8MlWnNUnEGrjhO24xM2kGrmQ8OMwJ0BMDHtk9qoSjM9RGJaG7URIHafPT7GU1540
 v9vpEU/gjduun1zovwMlGqxssjz6dWWl3kA7KB/o8p91Xs/i9K6/0tVHnyt2AfHtcnLi
 6/qbEcyooemXZhQ3tp3yYU5hSEdUdaL9qVVkTqTXsvVROOV+7xSkeoWjzhKxfP1qvXgB
 TO5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnc3L+JsAaD79YELT2+lW9HmxwgHKitYHj+Z6rmKSr1i0/rimpt0bDBdfjAF5YIrixlHEuzJ3KeGHO@nongnu.org
X-Gm-Message-State: AOJu0YxpGYRZlAnSu1qSUNIIGl0bJXvWpzSTLZ2xsNom0vgKXodd4si0
 hUHdaR1nqa9ufMl+IgTlSM+rn2y2BI8pvExAI1tFcoKTLC4MhlVU5D2NkruN6azK/lRp/J/W5WF
 AkKaJpzafAxrUjI5y30WZc/u4uT9KcDDZiI5VlmkCILBfM8E6Jyl/
X-Gm-Gg: ASbGncui+ZUjoREOjjYADGmWLx+odZxwaXNl1S6Z8Xc24cGpJSrncMPJGwPSdTELtHf
 5d7mwELRuLGQUPVF+qmSvVtATlyWDu3YFleiER3GSxVw8CSJzWfpkcCzgV3jINwAQHM4vJIRWQ3
 YEAW9JHwd1QOVBV9Fca2XT5YU5+k1hbFCLzvVoP2EFEj62S9JIxp29FP/J3bywlAabUSSBIvpMb
 v5LMyszEp6Ovgyhj9bxk0OwhxPBsmCM6O4Y/xi3AyMKjTfaV0ceR6M2e2YPjDVCcjfo6Y3B3zoH
 LXI5+avwZzKZ91ZCN3kCljBJAXKX6rSciXK8Zq1ke9U=
X-Received: by 2002:a5d:6d8e:0:b0:391:4889:5045 with SMTP id
 ffacd0b85a97d-39eaaebdf06mr1997401f8f.36.1744379004985; 
 Fri, 11 Apr 2025 06:43:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwJkAR5f4pNDIJTkQgO2LkI4IM66g56/CsA4xv1th+8Ouz6EWQ9F/o2cJ7dkmPoiWjRuqpyA==
X-Received: by 2002:a5d:6d8e:0:b0:391:4889:5045 with SMTP id
 ffacd0b85a97d-39eaaebdf06mr1997377f8f.36.1744379004587; 
 Fri, 11 Apr 2025 06:43:24 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-221.web.vodafone.de.
 [109.42.49.221]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f204c500bsm91217725e9.0.2025.04.11.06.43.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 06:43:24 -0700 (PDT)
Message-ID: <e0839e81-eab8-48cf-b55b-64d83f7633a3@redhat.com>
Date: Fri, 11 Apr 2025 15:43:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/24] s390x/diag: Introduce DIAG 320 for certificate
 store facility
To: Zhuoying Cai <zycai@linux.ibm.com>, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250408155527.123341-1-zycai@linux.ibm.com>
 <20250408155527.123341-5-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250408155527.123341-5-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.681,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 08/04/2025 17.55, Zhuoying Cai wrote:
> From: Collin Walling <walling@linux.ibm.com>
...
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>

So the patch is from Collin, but S-o-b only by you? Looks weird, this should 
either have an additional S-o-b by Collin, too, or not have that "From:" 
line at all?

...
> diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag320.h
> new file mode 100644
> index 0000000000..d6f70c65df
> --- /dev/null
> +++ b/include/hw/s390x/ipl/diag320.h
> @@ -0,0 +1,19 @@
> +/*
> + * S/390 DIAGNOSE 320 definitions and structures
> + *
> + * Copyright 2025 IBM Corp.
> + * Author(s): Zhuoying Cai <zycai@linux.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at
> + * your option) any later version. See the COPYING file in the top-level
> + * directory.

By the way, new files need a SPDX-License-Identifier nowadays to make 
scripts/checkpatch.pl happy.

> + */
> +
> +#ifndef S390X_DIAG320_H
> +#define S390X_DIAG320_H
> +
> +#define DIAG_320_SUBC_QUERY_ISM     0
> +
> +#define DIAG_320_RC_OK              0x0001
> +
> +#endif
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index da44b0133e..cb840e4b97 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -192,3 +192,39 @@ out:
>           break;
>       }
>   }
> +
> +void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
> +{
> +    S390CPU *cpu = env_archcpu(env);
> +    uint64_t subcode = env->regs[r3];
> +    uint64_t addr = env->regs[r1];
> +    int rc;

Do we also need a s390_has_feat(S390_FEAT_DIAG_320) check here?

> +    if (env->psw.mask & PSW_MASK_PSTATE) {
> +        s390_program_interrupt(env, PGM_PRIVILEGED, ra);
> +        return;
> +    }
> +
> +    if (r1 & 1) {
> +        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +        return;
> +    }
> +
> +    switch (subcode) {
> +    case DIAG_320_SUBC_QUERY_ISM:
> +        uint64_t ism =  0;
> +
> +        if (s390_cpu_virt_mem_write(cpu, addr, (uint8_t)r1, &ism,

I think you could drop the (uint8_t) here?

> +                                    be64_to_cpu(sizeof(ism)))) {

be64_to_cpu() looks very wrong here!

  Thomas



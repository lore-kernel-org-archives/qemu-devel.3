Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81F0CCA471
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 13:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5lgx-0000qK-4I; Mon, 06 Oct 2025 09:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v5lgv-0000po-R0
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 09:55:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v5lgp-0008NM-5C
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 09:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759758938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3F/rDX/y4HSq6wn/No1jCmAMP5Ia7dVuDObbI9FqtZY=;
 b=ACDdEiWmQnBMd/uXzQxDO0ruskC2extsrQXEeDfvtEUwfoZTpo/vvDXgVHC7FfdHPxp8yq
 xWV+R8VS1/GhhnwjKuUoF/ojALpUZBh6mTEDLvNY1rM3PFD53WiCDIRhxwp0Q0ha3r8i0U
 2maoZcQC91OYchWTrD5TgQIXV/m9kK4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-ZCFbmvUrM5Wae5QKUrjFNg-1; Mon, 06 Oct 2025 09:55:36 -0400
X-MC-Unique: ZCFbmvUrM5Wae5QKUrjFNg-1
X-Mimecast-MFC-AGG-ID: ZCFbmvUrM5Wae5QKUrjFNg_1759758936
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e3a049abaso26470185e9.0
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 06:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759758935; x=1760363735;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3F/rDX/y4HSq6wn/No1jCmAMP5Ia7dVuDObbI9FqtZY=;
 b=wR4SP0kaGeSYKSTK+Y6tgtAqgg9pMH0r2smgOZxPT66b2jVT2sMmt+AecVrbBAsrwe
 pMZs/+YoZx7Gk3qB2cN5drViWltmuhQZBL8VPMyW2U9k32RiP1NpaYqKi7Lv+FPJRGMd
 viM2vfTKKauAWIOcMYreMx2/zebmKiWCP5yZ/8dXJ5k3Xcd2Zv4MmjbFVLM9SOiwKai3
 cHhZvIeI2d2NDlurWiQ9rC2PFdyLw6i0+3+FgbHWhhapTLFxRIF3SCRdUSHbwmdKvk9l
 KXFIIpeMpBnp2ZuSuELVnKdNsKhecARC36yuxVh/lnj92DhZ3pSrbmCyYC6W0CsjRR3I
 txvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWploXIkrkx8+XpBgTf32oi2D8dOZanwz9ezLkB6jLxgKJfapDM3WUiUE1z3v2mw647/SRSi9h2KLTP@nongnu.org
X-Gm-Message-State: AOJu0YyrAAq/Hmgq0ODtM3EQ424rYVY8PMdQTyyJ6s3GF3Z+FrWy4Koq
 LQNjkRCsgVU2zsOrSH9AYFd81KEUR0CLdHUFQ7ZJ/VBhZ9pKs5ZvuXOHQRsMxBpn/CYw+Qyfk03
 sUEGFrATuQ9D5LEihaT9NwGdElBtcUl+pESW92QxfAlLfJT3sgS91RvRU
X-Gm-Gg: ASbGnctYOVjiVJquigOxVhAAdj6DYHOxT1AHJpyYZkN3jfn7QSDuilpNSIdQWWHFsy9
 Z6oVwWD3vQtY/Io9MXtZpOJVidaVMZAfGv+URB8EtCpu9TkOi3HUeWXdi3ipafTwilw81kEo0Wb
 Tr3rjv2Nws5YHeHEkfQuQwJCkSzEYEA8OFbzSZHp4WzwH3pt7FFikRQ6BxmDjLzY3Qrwez0/lWr
 AVt8VF9HpsiKPiHbVUf2C4dQcutniJdYlpBYcyuSDI9m9s1SxR/7u2HQ8BKN0cu9+0TUnu4rKcY
 +cZvlHNVcvpt41Xv2ZkaRZn4fSJqCN1RSKIzBojwnUabPCZM/vVhWRnr413b+/TRiTYmy9Pv5W3
 XkpdwlaxIEg==
X-Received: by 2002:a05:600c:4688:b0:46e:384f:bd86 with SMTP id
 5b1f17b1804b1-46e71101aa8mr97253535e9.5.1759758935638; 
 Mon, 06 Oct 2025 06:55:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPgJjQPREpjUekErTVa2AxhHtpRDq7cXUre5qKiio9ItUzd1tV1i281ljcZQBfokqP3WLIEA==
X-Received: by 2002:a05:600c:4688:b0:46e:384f:bd86 with SMTP id
 5b1f17b1804b1-46e71101aa8mr97253265e9.5.1759758935183; 
 Mon, 06 Oct 2025 06:55:35 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-056.pools.arcor-ip.net.
 [47.64.114.56]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e72374ac5sm179137785e9.18.2025.10.06.06.55.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 06:55:34 -0700 (PDT)
Message-ID: <eb377f20-721e-426a-81dc-7d0982d3b667@redhat.com>
Date: Mon, 6 Oct 2025 15:55:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] target/s390x: Factor diag_iplb_write() out
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>
References: <20251002091132.65703-1-philmd@linaro.org>
 <20251002091132.65703-2-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251002091132.65703-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 02/10/2025 11.11, Philippe Mathieu-Daudé wrote:

Can you please provide some reasoning in the patch description?
The code is only used in one place, so I fail to see the reason at the first 
glance.

  Thanks,
   Thomas


> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/diag.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index da44b0133ed..ed320fc0c1f 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -73,6 +73,17 @@ static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t addr,
>       return 0;
>   }
>   
> +static void diag_iplb_write(IplParameterBlock *iplb, S390CPU *cpu, uint64_t addr)
> +{
> +    const size_t iplb_len = be32_to_cpu(iplb->len);
> +
> +    if (s390_is_pv()) {
> +        s390_cpu_pv_mem_write(cpu, 0, iplb, iplb_len);
> +    } else {
> +        cpu_physical_memory_write(addr, iplb, iplb_len);
> +    }
> +}
> +
>   void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>   {
>       bool valid;
> @@ -164,11 +175,7 @@ out:
>               return;
>           }
>   
> -        if (!s390_is_pv()) {
> -            cpu_physical_memory_write(addr, iplb, be32_to_cpu(iplb->len));
> -        } else {
> -            s390_cpu_pv_mem_write(cpu, 0, iplb, be32_to_cpu(iplb->len));
> -        }
> +        diag_iplb_write(iplb, cpu, addr);
>           env->regs[r1 + 1] = DIAG_308_RC_OK;
>           return;
>       case DIAG308_PV_START:



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A91C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 13:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Eta-00041U-U4; Fri, 11 Apr 2025 09:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u3Et5-0003p5-Ds
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 09:57:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u3Et2-00045s-I8
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 09:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744379859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JjoMKRc/uTyQqIy47Y1GS0rD5EGZA4R+4g/N6XgBemw=;
 b=fF9XS/pb7GBY85y9O4AK4o2sqCCfGHBFilLCPvqszyb5wgFk85Q38zZDGTEkUQwa4oAYOu
 Pb/uS+6veG2QBNAG8qj4vIpSrjS/eQI/X2UcVKLu/aSEKi8q1/7FkrcR2q/Ptij8tW3W7A
 aBcuMqlrJr8m+y/J57k/YDXKkcY2YRw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-mXQiIReBPWKGNfKq1Cmh8w-1; Fri, 11 Apr 2025 09:57:36 -0400
X-MC-Unique: mXQiIReBPWKGNfKq1Cmh8w-1
X-Mimecast-MFC-AGG-ID: mXQiIReBPWKGNfKq1Cmh8w_1744379855
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3912d9848a7so1607334f8f.0
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 06:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744379855; x=1744984655;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JjoMKRc/uTyQqIy47Y1GS0rD5EGZA4R+4g/N6XgBemw=;
 b=dhKUbGAnYHuGEnXWdLQt/1bUImYsc7dQX98LNbc0vjd4KxR5OV/OJOou5qWMTnfrBA
 oyAcA4eyaIGTl9VREY8/OyzkYg0Km1rxdM08dvSVgLvP9BKmCY2GUq/tPdprt4lixhTM
 zZr7AVrHGbv+WIz9MVp4PMbrmp52rJzRp7+88/vVu9hzHxSugLq9VXz0f/z4lPaSWR3L
 JT6MkN65uepAjS9dEHsGBGrOHz+3cZGZNIZNyYF7nirVQ11mxHrEJa6iRiyW8FB3NDLn
 r6ceMwp2vo8mAAs0P6X+XE0evwEVhLUlXZcXSjbFEOr754UqBmsK8gfx8X6Fs5fL0jLO
 wP1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUwiriDb7u6nQKHFwD9n2HPJ7h/un8PX/8s5RQ2WTK4Q/Sfvm16Jkt/UT81o2z/j533XjfwapRcljV@nongnu.org
X-Gm-Message-State: AOJu0YzCqDGYXjVdGaOvfIJBhWdYetG8xmUCPp34xXoT46/iAGGRYn9O
 rWcxt7Uxj2pLm3cnDnxZDbWWGw+elFkeARTA3pyvprOgCLDSs7o4ANJdiSPjNTMTxGB1lrqRqDK
 B+GCyLNYx8anHzCPUyeEuKxUbsACOlQgQrrGGzri7vGKRFv7D9zYh
X-Gm-Gg: ASbGnctf5UQWOHQCiuxjKrK91vymonI+oKQJe/EQLHcpUvH2gQW6C+pZ6C6c3HmJtOU
 3KBTdSdC/JMTv8dvDL7gjzjv5HUGtOvgEgfR5rGHtSe9jgcSkbbNzaVwE2HOqGjtA5OwKor/NVs
 +lUTUeKkqfu0uajWqMP6GLSNcghTKr80uXty6G/MPTarbIiX73yRitwrjQz5ijJ/+kqFx1RgHcj
 Uku7tbznq0iyQpavFJJV3QKcmUYq1Nq5BEpzi6q40oL3hgX7i6SSceA7M1c7FpftRCnHQKjW9oM
 ocqa6hEsCdCGYcwtIkCq3OHEoude9BewynQ95QZA8e8=
X-Received: by 2002:a5d:64c8:0:b0:38d:ba8e:7327 with SMTP id
 ffacd0b85a97d-39e6e48c131mr2746121f8f.8.1744379855140; 
 Fri, 11 Apr 2025 06:57:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO3rex3FB9UZuv8QNyUfCFYDlSzmIY/xt7NLpGyUK8EEyDCMXnZFPKZRusjy5eJinQK5VT/w==
X-Received: by 2002:a5d:64c8:0:b0:38d:ba8e:7327 with SMTP id
 ffacd0b85a97d-39e6e48c131mr2746089f8f.8.1744379854782; 
 Fri, 11 Apr 2025 06:57:34 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-221.web.vodafone.de.
 [109.42.49.221]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf4458a8sm2140772f8f.99.2025.04.11.06.57.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 06:57:34 -0700 (PDT)
Message-ID: <bddc01e1-056a-454a-b1f1-165d1604deef@redhat.com>
Date: Fri, 11 Apr 2025 15:57:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 06/24] s390x/diag: Implement DIAG 320 subcode 1
To: Zhuoying Cai <zycai@linux.ibm.com>, richard.henderson@linaro.org,
 david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250408155527.123341-1-zycai@linux.ibm.com>
 <20250408155527.123341-7-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250408155527.123341-7-zycai@linux.ibm.com>
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
> DIAG 320 subcode 1 provides information needed to determine
> the amount of storage to store one or more certificates.
> 
> The subcode value is denoted by setting the left-most bit
> of an 8-byte field.
> 
> The verification-certificate-storage-size block (VCSSB) contains
> the output data when the operation completes successfully.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   include/hw/s390x/ipl/diag320.h | 25 ++++++++++++++++++++++
>   target/s390x/diag.c            | 39 +++++++++++++++++++++++++++++++++-
>   2 files changed, 63 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/s390x/ipl/diag320.h b/include/hw/s390x/ipl/diag320.h
> index d6f70c65df..ded336df25 100644
> --- a/include/hw/s390x/ipl/diag320.h
> +++ b/include/hw/s390x/ipl/diag320.h
> @@ -13,7 +13,32 @@
>   #define S390X_DIAG320_H
>   
>   #define DIAG_320_SUBC_QUERY_ISM     0
> +#define DIAG_320_SUBC_QUERY_VCSI    1
>   
>   #define DIAG_320_RC_OK              0x0001
> +#define DIAG_320_RC_NOMEM           0x0202
> +
> +#define VCSSB_MAX_LEN   128
> +#define VCE_HEADER_LEN  128
> +#define VCB_HEADER_LEN  64
> +
> +#define DIAG_320_ISM_QUERY_VCSI     0x4000000000000000
> +
> +struct VerificationCertificateStorageSizeBlock {
> +    uint32_t length;
> +    uint8_t reserved0[3];
> +    uint8_t version;
> +    uint32_t reserved1[6];
> +    uint16_t totalvc;
> +    uint16_t maxvc;
> +    uint32_t reserved3[7];
> +    uint32_t maxvcelen;
> +    uint32_t reserved4[3];
> +    uint32_t largestvcblen;
> +    uint32_t totalvcblen;
> +    uint32_t reserved5[10];
> +} QEMU_PACKED;
> +typedef struct VerificationCertificateStorageSizeBlock \
> +VerificationCertificateStorageSizeBlock;

That's quite a long name, maybe shorten to VerificationCertStorageBlock or 
something similar?

>   
>   #endif
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index c64b935c87..cc639819ec 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -194,6 +194,7 @@ out:
>   void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>   {
>       S390CPU *cpu = env_archcpu(env);
> +    S390IPLCertificateStore *qcs = s390_ipl_get_certificate_store();
>       uint64_t subcode = env->regs[r3];
>       uint64_t addr = env->regs[r1];
>       int rc;
> @@ -210,7 +211,7 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>   
>       switch (subcode) {
>       case DIAG_320_SUBC_QUERY_ISM:
> -        uint64_t ism =  0;
> +        uint64_t ism = DIAG_320_ISM_QUERY_VCSI;

That likely should be a cpu_to_be64(DIAG_320_ISM_QUERY_VCSI) instead.

>   
>           if (s390_cpu_virt_mem_write(cpu, addr, (uint8_t)r1, &ism,
>                                       be64_to_cpu(sizeof(ism)))) {
> @@ -218,6 +219,42 @@ void handle_diag_320(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
>               return;
>           }
>   
> +        rc = DIAG_320_RC_OK;
> +        break;
> +    case DIAG_320_SUBC_QUERY_VCSI:
> +        VerificationCertificateStorageSizeBlock vcssb;
> +
> +        if (!diag_parm_addr_valid(addr, sizeof(VerificationCertificateStorageSizeBlock),
> +                                  true)) {
> +            s390_program_interrupt(env, PGM_ADDRESSING, ra);
> +            return;
> +        }
> +
> +        if (!qcs || !qcs->count) {
> +            vcssb.length = 4;
> +        } else {
> +            vcssb.length = VCSSB_MAX_LEN;
> +            vcssb.version = 0;
> +            vcssb.totalvc = qcs->count;
> +            vcssb.maxvc = MAX_CERTIFICATES;
> +            vcssb.maxvcelen = VCE_HEADER_LEN + qcs->max_cert_size;
> +            vcssb.largestvcblen = VCB_HEADER_LEN + vcssb.maxvcelen;
> +            vcssb.totalvcblen = VCB_HEADER_LEN + qcs->count * VCE_HEADER_LEN +
> +                                qcs->total_bytes;

You also need cpu_to_beXX() for these values here, too.

> +        }
> +
> +        if (vcssb.length < 128) {
> +            rc = DIAG_320_RC_NOMEM;
> +            break;
> +        }
> +
> +        if (s390_cpu_virt_mem_write(cpu, addr, (uint8_t)r1, &vcssb,
> +                                    be64_to_cpu(

And that be64_to_cpu() is wrong here.

  Thomas

> +                                        sizeof(VerificationCertificateStorageSizeBlock)
> +                                    ))) {
> +            s390_cpu_virt_mem_handle_exc(cpu, ra);
> +            return;
> +        }
>           rc = DIAG_320_RC_OK;
>           break;
>       default:



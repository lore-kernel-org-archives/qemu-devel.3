Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FDBCD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 16:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZAFs-0005qQ-Kf; Mon, 15 Jun 2026 12:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wZAFr-0005pp-4e
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 12:33:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wZAFp-0001Uk-8Y
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 12:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781541219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y6w9lFh6PZ26UiIsyxaCt4t34MU6PXSASefpv0F91Ac=;
 b=HkCV8ayRsaZ4FVu2fa14jeCOn6qEecqL/BW8f+nlGwkU6GoAzGZMxVmFVnANn3IYVQgWWy
 lKdHVB57/7fdtaW9f1YMRCPZXYRws6D4kD/rktoZx9qv5/OBiqV931QaLrYMxZMweiTMBV
 MGY5ACXgJXkP3Ww4fk0OQz+Lo2Qvl48=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-lgAdFXlHMquEMpUvKNesmw-1; Mon, 15 Jun 2026 12:33:37 -0400
X-MC-Unique: lgAdFXlHMquEMpUvKNesmw-1
X-Mimecast-MFC-AGG-ID: lgAdFXlHMquEMpUvKNesmw_1781541216
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2c40358e114so41900375ad.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 09:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781541216; x=1782146016; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y6w9lFh6PZ26UiIsyxaCt4t34MU6PXSASefpv0F91Ac=;
 b=onnFZV8JuivxA5RVSdEAnjBQALNEjqRRUYTbzk2XU+DXJKbgAvy+Ieo/TEgRpgHaY3
 xKkdndmW23jsRAZnq7pDq1ZEsyiMhEOyx+kGuMBPbyXa2yEi+Yejer6uHjEaKwTQb++N
 5hTdxUc0xhSLWiXqe2yUTLXTjKSKRlwe3WvZ8tINgZUPj2Y/esk4WZAHX9TTbnrKQPYe
 P7Uming/FozqNDJ6+KSyn2zSauHSiIvjPorxLbm1jOiZ6eyO3kc33SITvEt4u7qNGLOy
 5hh7bxJcAtdSCh+ZmGqJEO62NVgOICB99FtBS1oSVak6uHGM/cJmUr7Riu2G0ALfGWZn
 aB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781541216; x=1782146016;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y6w9lFh6PZ26UiIsyxaCt4t34MU6PXSASefpv0F91Ac=;
 b=cACPIMwqOinWCp29CDtRs5YFbkaJMsover+E4P7WVqWZ0BLmWP0pX+MKNH1eI5865c
 BX5Nk1Xj2bwwAFanAm0JlS7rR4zCdcCb3Hva2kFDJyEbd7CvzTkj5LdTQ5zGuCprWV6p
 jfza1vLkMaQf2daDC39NC0VCvhU7ybAggU+pFyuwWfO2NdPJG+Z5mcw21exR+Unmt7mG
 H6MnPj3Z3omO8Xd6klt0INKcYXNbNtHOdL8FEJDo8AA3xpm7bmYugCbxH91pe93wFX15
 elIP8ha0DmnK4UW+NXT+ExAL7yD3uep1szVgNRKbTT+4IlfzqbPPDnjMIN8GZpPCp6/z
 oUXw==
X-Gm-Message-State: AOJu0YxxD1oVHQSfPruEzyGMxbSH5FRpquS9gGNJzqumX4cKdNN7D861
 uqJ3zREo/+7cvKEZHPIEOk4XkvGzBpSZsd/1/VSxu3xktzwZlGdaAKIbEyeVq5RgG0+yr6BhjDU
 342oDElqWBPkqLPcvNoPVpPbr3yNenoX+xemAt0yQF7cDceKXdVnMtFfd
X-Gm-Gg: Acq92OFelm4pRKRdvhkg1zC0wSV1WbaurQlEptT6bJY5FJguYXXdfZCPWnoDItCTVuY
 FtqvuWam7lxTYcPpNpHeMbfWe0YbLLUvuXqANZ0xdjVgjKjyFjCYFKLb6MqdjqW4qk8WHveMs3U
 25bliOTYAcmbM3N3q60k2DvXoiCazfvu+++CEHJc9rvLRqbB8nkGDxJsOZK/Z2zuue1HBZJt3EX
 rpyrkNGlEyYhOe9zvxp4zw5KaR05Spulj57XA23w43BZuZaXdlUUbQzQFItTMfNsYd0PrY46t1I
 SJySIECU6kxJh/gZcMtlaErH+hqUI2JQJDTsHP1cw5T8rPcBjDoJsUeQJZk+JsU/vRO3LWwB2FN
 iWHqYbLVr6PVLbflrt4ws62tbzZR8Sz6tackU1qIqdowqhNx0LPZbyRhcwGjq+bzB
X-Received: by 2002:a17:902:e80c:b0:2c1:f262:4962 with SMTP id
 d9443c01a7336-2c664242d9emr138012835ad.20.1781541216172; 
 Mon, 15 Jun 2026 09:33:36 -0700 (PDT)
X-Received: by 2002:a17:902:e80c:b0:2c1:f262:4962 with SMTP id
 d9443c01a7336-2c664242d9emr138012425ad.20.1781541215722; 
 Mon, 15 Jun 2026 09:33:35 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c4327ac794sm106755965ad.46.2026.06.15.09.33.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 09:33:34 -0700 (PDT)
Message-ID: <d0d18a5b-1178-416d-81aa-d6d5f56ae3a7@redhat.com>
Date: Tue, 16 Jun 2026 02:33:26 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
To: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, mst@redhat.com, peterx@redhat.com,
 alex@shazbot.org, peter.maydell@linaro.org, berrange@redhat.com,
 philmd@oss.qualcomm.com, philmd@mailo.com, david@kernel.org, clg@redhat.com,
 pbonzini@redhat.com, phrdina@redhat.com, jugraham@redhat.com,
 liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn, shan.gavin@gmail.com
References: <20260615100200.266968-1-gshan@redhat.com>
 <20260615100200.266968-2-gshan@redhat.com>
 <93fb3b41-1543-4e3b-922b-043b774f57bf@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <93fb3b41-1543-4e3b-922b-043b774f57bf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/16/26 1:17 AM, Richard Henderson wrote:
> On 6/15/26 03:01, Gavin Shan wrote:
>> +void qemu_ram_copy(void *dest, const void *src, size_t n)
>> +{
>> +    if (HOST_UNALIGNED_MMIO_OK) {
>> +        switch (n) {
>> +        case 1:
>> +            __builtin_memcpy(dest, src, 1);
>> +            break;
>> +        case 2:
>> +            __builtin_memcpy(dest, src, 2);
>> +            break;
>> +        case 4:
>> +            __builtin_memcpy(dest, src, 4);
>> +            break;
>> +        case 8:
>> +            __builtin_memcpy(dest, src, 8);
>> +            break;
>> +        default:
>> +            memcpy(dest, src, n);
>> +        }
>> +    } else {
>> +        uintptr_t test, lsb;
>> +
>> +        do {
>> +            test = (uintptr_t)dest | n;
>> +            lsb = test & -test;
>> +            switch (lsb) {
> 
> Either assert n != 0 to start, or use while not do/while.
> Because the body of the loop won't handle n == 0 correctly.
> 

I will change this to "while (n > 0)" since we're not expecting
"n < 0" either.

>> +            case 1:
>> +                *(uint8_t *)dest = *(uint8_t *)src;
>> +                src += 1;
>> +                dest += 1;
>> +                n -= 1;
>> +                break;
>> +            case 2:
>> +                *(uint16_t *)dest = *(uint16_t *)src;
>> +                src += 2;
>> +                dest += 2;
>> +                n -= 2;
>> +                break;
>> +            case 4:
>> +                *(uint32_t *)dest = *(uint32_t *)src;
>> +                src += 4;
>> +                dest += 4;
>> +                n -= 4;
>> +                break;
>> +            default:
>> +                *(uint64_t *)dest = *(uint64_t *)src;
>> +                src += 8;
>> +                dest += 8;
>> +                n -= 8;
> 
> Use qatomic_set for the stores.
> 

Could you confirm which stores need qatomic_set()? There are two sets
of stores as below. I guess you're asking have qatomic_set() for (a)?
Could you explain a bit why qatomic_set() is needed?

     // (a)
     *(uint64_t *)dest = *(uint64_t *)src;


     // (b)
     src += 8;
     dest += 8;
     n -= 8;

> src is not aligned, so except for case 1, you need ld{uw,l,q}_he_p.
> 

Yeah, I realized this after this patch was sent. ldub_p() will be
used for case 1 either.

Another unrelated question: why 'int' value is returned from ldub_p()
and ld{uw, l}_he_p() in bswap.h? They would return 'uint{8, 16, 32}_t'
values?

static inline int ldub_p(const void *ptr)
static inline int lduw_he_p(const void *ptr)
static inline int ldl_he_p(const void *ptr)
static inline uint64_t ldq_he_p(const void *ptr)   // return uint64_t

>> +void qemu_ram_move(void *dest, const void *src, size_t n)
>> +{
>> +    if (HOST_UNALIGNED_MMIO_OK) {
>> +        switch (n) {
>> +        case 1:
>> +            __builtin_memmove(dest, src, 1);
>> +            break;
>> +        case 2:
>> +            __builtin_memmove(dest, src, 2);
>> +            break;
>> +        case 4:
>> +            __builtin_memmove(dest, src, 4);
>> +            break;
>> +        case 8:
>> +            __builtin_memmove(dest, src, 8);
>> +            break;
>> +        default:
>> +            memmove(dest, src, n);
>> +        }
>> +    } else {
>> +        qemu_ram_copy(dest, src, n);
>> +    }
>> +}
> 
> The qemu_ram_copy implementation above does not work with overlapping blocks.
> 

Yeah, it's something I need to figure out for next revision. Thanks for your
review and comments.

> 
> r~
> 

Thanks,
Gavin



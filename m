Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F98FCA0EE8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 06:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uylWz-0004jw-Gf; Wed, 17 Sep 2025 02:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uylWv-0004iz-JX
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 02:20:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uylWt-0006Nv-C8
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 02:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758090032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=+5Xjm0d3DCXRRNN0WbtIhjFPOyDJklpN5gFbIGudPag=;
 b=TxB+9mm5QDxWaIkAi3LH/JxRPwnT56shsgpVR6UZoIMGEiLgDNMM29BFQN7oJhQWqVKSfS
 tuVrbXCdRKnOw679ggd1VoWF2xq+2K+O9GqH8mx7KeVOkIXtHQGkFnwcG68w/ikS3f23na
 GBPoTCBuYwMD0Y0Q07Zwm9fJ4klqXhY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-t7dtDdvDOfCi6CZYHyxM1g-1; Wed, 17 Sep 2025 02:20:30 -0400
X-MC-Unique: t7dtDdvDOfCi6CZYHyxM1g-1
X-Mimecast-MFC-AGG-ID: t7dtDdvDOfCi6CZYHyxM1g_1758090029
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3ccd58af2bbso176159f8f.0
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 23:20:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758090029; x=1758694829;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+5Xjm0d3DCXRRNN0WbtIhjFPOyDJklpN5gFbIGudPag=;
 b=P9J9FuwAqzh8qNST9ZDu/Ub56nDN4uxA2hQbvr8vLyBcIgKxA6GSf/JBkwZ33EcyFF
 WtxIzR+QjcziGOMIKuzb4CbmWX/J9FcnMnofCaXYK4IV7DK70vAOentV+vYfN0X4mWRP
 bffqfHnua19yWD2DFOt4wK0ndnonXCiXhjT7xmjf9DXs/pIR441OkNXnOMQ2TPunDbpC
 V2zthhoTbBZ+3QW1w5hIRs11J3vSY/BkicK2LXosjmHTnnGMd3UKGWhCyxMSnvfuJt0B
 qi7bgTTWhuv1MSg/oZwVmyHDgq4VeMXCfyH6RcnDuzRkTel5zxXJfI1EJnWT8w5k729Y
 yZgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXo7fwR7eq93UtaT/ZxBp1KdcGTkqlJGDetTk+3tgN0FjRokQkMkuxyei5svjTXeNwH82BHu9MOHVMs@nongnu.org
X-Gm-Message-State: AOJu0YwSmqwC9crIrPqXp5J8OgTeESqmtRMMP0x0h+aL39CrazxbDV8J
 9PeHQZOq8o22FJNrnezuDlICrmHMEToX7jTzl94G/QuFbmnhmIimhoqjkrqgxbl5+VCwKpcpsqN
 Jj7Uf0cMgzRQMTLUd1Wc1aGAv9UqgZbxm+lfQ4opooZMoYbyaxFS+IdPf
X-Gm-Gg: ASbGnctlciSXE9/BlCTCkUl44jfgpr7KTlGz79NImqcAgBYzGleIUPlIN2iM81PjQdn
 BtooaFuE9CnuH0veslGQwukbOS/rI5np+HjBlNyCaz7sXNFBPRb/hUtckCpy0ejakUgCXHQgDHp
 kABLQ3YRQGG7oCxArMjXb02brhK5OZoxrTfNME0cCqtqa9jw7+FZN68I5pZdoAsbe2Q3v+0Vp5Q
 EFNhVA7dcjLnbLHnw12zzuSeI/wTZC9ShTbbWLeo+APaIb+4L0VPS7I/lQ0rR5TwEn25j6XiKCp
 4F7diBgEX/v1sd04CR1A0KR5H9qI6qlZQ+fGNxWaO+WMO7sZE/AZ5HsPdF8Lu2YY0oboMj+Vxp6
 r5WTnRQ==
X-Received: by 2002:a05:6000:178e:b0:3d3:b30:4cf2 with SMTP id
 ffacd0b85a97d-3ecdfa9ad85mr658851f8f.19.1758090029301; 
 Tue, 16 Sep 2025 23:20:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFvhJTRAFqHGdTT+HFCFIFcdvg/0CKGk4PMg0lsSpqSvOHp4SqWw5YAK6kyGRzBAu9H+zdfg==
X-Received: by 2002:a05:6000:178e:b0:3d3:b30:4cf2 with SMTP id
 ffacd0b85a97d-3ecdfa9ad85mr658822f8f.19.1758090028740; 
 Tue, 16 Sep 2025 23:20:28 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-218.pools.arcor-ip.net.
 [47.64.113.218]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e95b111b68sm14662371f8f.32.2025.09.16.23.20.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Sep 2025 23:20:28 -0700 (PDT)
Message-ID: <db99b84a-4d7c-49af-8185-97db09843006@redhat.com>
Date: Wed, 17 Sep 2025 08:20:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] target/ppc: Add IBM PPE42 special instructions
To: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@redhat.com, npiggin@gmail.com,
 rathc@linux.ibm.com, richard.henderson@linaro.org
References: <20250912164808.371944-1-milesg@linux.ibm.com>
 <20250912164808.371944-7-milesg@linux.ibm.com>
 <a419ef55-d0d5-4d88-8302-ebcc9a8c4bab@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <a419ef55-d0d5-4d88-8302-ebcc9a8c4bab@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 17/09/2025 06.57, Harsh Prateek Bora wrote:
> 
> 
> On 9/12/25 22:17, Glenn Miles wrote:
>> Adds the following instructions exclusively for
>> IBM PPE42 processors:
>>
>>    LSKU
>>    LCXU
>>    STSKU
>>    STCXU
>>    LVD
>>    LVDU
>>    LVDX
>>    STVD
>>    STVDU
>>    STVDX
>>    SLVD
>>    SRVD
>>    CMPWBC
>>    CMPLWBC
>>    CMPWIBC
>>    BNBWI
>>    BNBW
>>    CLRBWIBC
>>    CLRWBC
>>    DCBQ
>>    RLDICL
>>    RLDICR
>>    RLDIMI
>>
>> A PPE42 GCC compiler is available here:
>> https://github.com/open-power/ppe42-gcc
>>
>> For more information on the PPE42 processors please visit:
>> https://wiki.raptorcs.com/w/images/a/a3/PPE_42X_Core_Users_Manual.pdf
>>
>> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
>> ---
>> Changes from v3:
>>    - Removed copy of CHECK_VDR
>>    - Refactored ld/st instructions
>>
>>   target/ppc/insn32.decode            |  66 ++-
>>   target/ppc/translate.c              |  29 +-
>>   target/ppc/translate/ppe-impl.c.inc | 665 ++++++++++++++++++++++++++++
>>   3 files changed, 750 insertions(+), 10 deletions(-)
>>   create mode 100644 target/ppc/translate/ppe-impl.c.inc
>>
> 
> <snip>
> 
>> diff --git a/target/ppc/translate/ppe-impl.c.inc b/target/ppc/translate/ 
>> ppe-impl.c.inc
>> new file mode 100644
>> index 0000000000..792103d7c2
>> --- /dev/null
>> +++ b/target/ppc/translate/ppe-impl.c.inc
>> @@ -0,0 +1,665 @@
>> +/*
>> + * IBM PPE Instructions
>> + *
>> + * Copyright (c) 2025, IBM Corporation.
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +
>> +#if !defined(TARGET_PPC64)
>> +static bool vdr_is_valid(uint32_t vdr)
>> +{
>> +    const uint32_t valid_bitmap = 0xf00003ff;
>> +    return !!((1ul << (vdr & 0x1f)) & valid_bitmap);
>> +}
>> +
>> +static bool ppe_gpr_is_valid(uint32_t reg)
>> +{
>> +    const uint32_t valid_bitmap = 0xf00027ff;
>> +    return !!((1ul << (reg & 0x1f)) & valid_bitmap);
>> +}
>> +#endif
>> +
>> +#define CHECK_VDR(CTX, VDR)                             \
>> +    do {                                                \
>> +        if (unlikely(!vdr_is_valid(VDR))) {             \
>> +            gen_invalid(CTX);                           \
>> +            return true;                                \
>> +        }                                               \
>> +    } while (0)
>> +
>> +#define CHECK_PPE_GPR(CTX, REG)                         \
>> +    do {                                                \
>> +        if (unlikely(!ppe_gpr_is_valid(REG))) {         \
>> +            gen_invalid(CTX);                           \
>> +            return true;                                \
>> +        }                                               \
>> +    } while (0)
>> +
>> +#define VDR_PAIR_REG(VDR) (((VDR) + 1) & 0x1f)
>> +
>> +#define CHECK_PPE_LEVEL(CTX, LVL)                       \
>> +    do {                                                \
>> +        if (unlikely(!((CTX)->insns_flags2 & (LVL)))) { \
>> +            gen_invalid(CTX);                           \
>> +            return true;                                \
>> +        }                                               \
>> +    } while (0)
>> +
>> +static bool trans_LCXU(DisasContext *ctx, arg_LCXU *a)
>> +{
>> +#if defined(TARGET_PPC64)
>> +    return false;
>> +#else
> 
> If we are building the PPE42 instructions only for !TARGET_PPC64, does
> it still make it usable with qemu-system-ppc64?

As explained in an earlier thread already, qemu-system-ppc64 is a superset 
of qemu-system-ppc. Thus the ppe42 stuff should work in qemu-system-ppc64, too.

  Thomas



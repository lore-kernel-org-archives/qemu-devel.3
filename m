Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D107CA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 09:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upO0t-0005L3-UA; Fri, 22 Aug 2025 05:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1upO0s-0005K5-5k
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 05:24:46 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1upO0o-0006rU-HW
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 05:24:45 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-244582738b5so16808515ad.3
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 02:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755854679; x=1756459479; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DnsvRTA2N4VrjCyG181NCO74B2dC1T05V8l2irChUrc=;
 b=dAPja6WzuTvOUshoOMVuWPWE9H6dwRXY60iGX34WsmfZcod1V94gIL7DWFGOotfPLo
 9UfNCaN679q9rySUBV+q7DxwxKrQcy2O250uzAeRRaZzYAewKUTWBV9hyYwgAWSplwaR
 ljYmmyS4k8PLVmmV2SwUEl44HyGa+FMSev7q+i7Op16LRxZGi27rAkjJubrvfZhWQ8nI
 5LkUVqibR0lw4cifbigHR0RrZvMTDzzMmT3F7l8ktXcq/RpVkKztlKJ9G80OSIwpw+Ba
 SN9KL27S7I1TI1bGGunJiI3ppJp6C4/We4NBhl1jVqPkKXoZ/1GT5kHn1svMIr1Ihwzv
 MbRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755854679; x=1756459479;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DnsvRTA2N4VrjCyG181NCO74B2dC1T05V8l2irChUrc=;
 b=GooN8Y0/nIrMkzctX5k5hDEErt91xJmAQ4m5rIZyoPhhNm7mw7kLSgC1oczzHDmCUL
 kAuV85qoPRd7JBK95MhEiIsgQ9H+Opp8RhMMP8VLAoOS7hOqeCGaLPvp5DSrLDtfV74m
 aVsoiQTRmqZL6gZ/g81d4kymq+8rkA+MZPyNNLNUmNvpZ2KmhNabgH9GZmCaS24XR/jc
 hMzRIh4xFPfxemkQbMoKx6WQQcjDYZmlLTu1zZJmSTKl56TSUfbvqisgn1VqSXetlkbe
 mLPP9qf2Iw/rF2TtrEoCzalXQXr6Qi9atwyoQksV4xXs0s3cpsiXWtBUWSZnU02YAgRQ
 zz5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTQjx1Nasw1DMk6mVYk4yZdjNyY62EbEupy5O/0YiOl1UcDLXRUuddmbNrelyD7MbufYRIO945HU2v@nongnu.org
X-Gm-Message-State: AOJu0YzOzm1P9d8tl5wF0fr8F8F2/UF2LqZ2K/mPoepY/hU6PXaxbY3N
 RYaymfgnpDWDGW99wKWQiMGVB1GWZIlKSKSQkDMe92cRJ4tOIjx1vJUgLhzkWDts4iw=
X-Gm-Gg: ASbGncv3SLdrlywuH0bvU1D9Nf2sJEXZRm9oUEvCBj/Ua0lPAVWnCDw2C1djEGSNlcj
 RCkSNHaC0jDgzV2RD5tBb0XroPLqqdd2mn5uAOhPUGAaFMglFsKRyBvt6nYAEpHFuzU635JPrRS
 UF9yC/cIrA+rnVeHsOb5I0F2VW1Lreh+RtVNd26X4EE9cDxSO4KCGbaSQDx3KPd1ceDSaDozPnG
 BhTp+1DhtLVbNaunIxbWqXcArV748hTycErVJdtPPjfAtV/4tUVWlqftlX1qA28blUakYKlei3C
 NCQl0og77GmuOcki4kEj/Zm0kTGciZFJALAb/S3ePCployLqKCKSoT+Eze3w6QTQYPXxPns97Q2
 bYtA6WuldV5Az9GuoUcEcr8IzPj2+NgncWb60A+YFWlK1Z1PGB3AsPFOi2v5rWRx0NfaaaOB1co
 i4ck4d
X-Google-Smtp-Source: AGHT+IHW7Rv7qlWB+JAiKyKv+JqXAnZCGWGZIUN8mRYaOibj2i4/XegEkgm2MdqYTvz0fd8TJjO4OQ==
X-Received: by 2002:a17:902:ec91:b0:240:71ad:a442 with SMTP id
 d9443c01a7336-2462eded8fbmr25936465ad.9.1755854678926; 
 Fri, 22 Aug 2025 02:24:38 -0700 (PDT)
Received: from ?IPV6:2405:6e00:640:7cf2:733f:651e:e790:3bf3?
 ([2405:6e00:640:7cf2:733f:651e:e790:3bf3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33b4c2sm78197955ad.25.2025.08.22.02.24.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Aug 2025 02:24:38 -0700 (PDT)
Message-ID: <35a78a36-989e-425a-b99e-bda52da8d20c@linaro.org>
Date: Fri, 22 Aug 2025 19:24:30 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] accel/tcg: Unify big- and little- endian atomic ops
To: Danila Zhebryakov <d.zhebryakov@yandex.ru>, qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Riku Voipio <riku.voipio@iki.fi>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>
References: <20250821113348.91339-1-d.zhebryakov@yandex.ru>
 <20250821113348.91339-2-d.zhebryakov@yandex.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250821113348.91339-2-d.zhebryakov@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 8/21/25 21:33, Danila Zhebryakov wrote:
> @@ -1894,6 +1894,14 @@ static void *atomic_mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
>           notdirty_write(cpu, addr, size, full, retaddr);
>       }
>   
> +    if (unlikely(tlb_addr & TLB_BSWAP)) {
> +        assert(!( (  full->slow_flags[MMU_DATA_STORE]
> +            ^ full->slow_flags[MMU_DATA_LOAD ])
> +            & TLB_BSWAP));
> +
> +        *need_bswap = !need_bswap;
> +    }
> +

How is this supposed to work?

(!) TLB_BSWAP is a slow-flags bit, so it will never be set in tlb_addr.
(2) Both MMU_DATA_STORE and MMU_DATA_LOAD will have the same value for TLB_BSWAP: X ^ X == 
0, so sure, that assert can't fire.


r~




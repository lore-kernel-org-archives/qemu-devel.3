Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64406C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 20:15:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyxY2-0006kO-H1; Tue, 25 Aug 2026 16:15:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wyxY1-0006k4-EE
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 16:15:05 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wyxXz-0004ET-M0
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 16:15:05 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3965d3d9ab8so247796a91.3
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 13:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787688902; x=1788293702; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ugNX3aPO3hzzkSRS5grUAoY0+WikWGOwI/3WCfj1N3c=;
 b=ndr+xBT+dEF/NqGmUMacfwP1C5C/pO57RKHqjlOUsXNzzg5PGBt99WBTbjcNlkicUL
 q6fPcf8TKM86auDi5GnwufgVCoxOiWMVaT0loWKtADI8Yoi4mPAK32ooTWkFPIBny9iQ
 7tE0jVUXmuWN4+rKmuYmwIofBcGf4E/LCshKMNdNiQqxgYiU818WAMBPvml1SSeJ7LBP
 7/UI0aN8WIy5FbsSCb4IrJu9vYtLqggUudr9IPs/PcUClQLI2vC9BAmACENMrSFBOTxF
 UpM1/WYlpl3RWcIdugMkOw9n0JTJxvB4v3Se3Ebxrad5nKLcKM5smf5rz9Lse0mSKyf9
 qaug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787688902; x=1788293702;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ugNX3aPO3hzzkSRS5grUAoY0+WikWGOwI/3WCfj1N3c=;
 b=rrDKXELVtd2tS5ZhyLJP+rxgWHKxjhVLuikyVHr03SnyLwvmnOJ5t+EY5umeuSUUJY
 ZsyMRNzBi+iFeRoulPR8OWu11xT27WuntO48J4PWljECmOkAg1/SrTpVp4/wX1F7e5Uz
 WlRIMsH9E8ehtt7Q/RIVlZVD/LVisdhZc2r5wTPER3p+17k02EnHw1nT/T1jvHwxEwFc
 3shZa94iNgycTBoIK1mUPr/W6RklIQKA/BNe/+k5l8cUAUTvD1e7mZr2t19R6mAjT7m1
 aCczttoLBV8zh661Qjbpm5KikgOBEHqfHD2uNzF3XYt7mZdeZpOKpsCrzsPrUhqS4mZ0
 UgxQ==
X-Gm-Message-State: AFuF++lKnIcpc+T8HPbbtVf98+0IuXlD5mfGP+Gr48ZTdzAPHHk9/J1d
 cFOMcLd8JeltzekIARRPsdKrFT8ovae8tLoGLFhMifw4mIS6+23DbKhK8H+KnRNzIBs=
X-Gm-Gg: AR+sD10bl0jAyXZBmLZge5+IAQC80p0IhG5bn/1EknIc2gQzx//5S03DMO4X6MM3q/R
 oDpP2AS+mLLxUhdXMO3FlFOtJ2I2SwX0Mm43agKWBR4Ogk1lgqzVsPknl8m7Kq0uCR/GVWI6I7f
 +4k3cjO5rc7t76/m2x/WXIePsm2Y+vJ9ww03S7mQZ+UURdBhKs4UmFnjn73L+ve/g3y6+8UfBNV
 yIW4PUB9uTPhfN1gvaCC7Ihb9M3bhSRisJVF1sWUk+H9YQXgLt1DheQSI7jFFgq+SliFgt81/Mo
 jiMo4oAM/CMDJ5DGXDa+VfuKHEJR6rZ6TrYBriBg7P1lr0c/BvBr+pdGxbL/x/QQEf7YQ3hPeaJ
 Jjd8ca7Vx9gmvWnsRSRlzK2JFLTDVNEDu4sgV9OidOLD1Cv9xzarYYIThD2mOg7PRn9jQCktZRv
 /H0e37uQH/Z08MIIWWxJmP/mjxhRKsP4e3KaOlInJpqdnDiTZtdeJz0N81q1adXcVOkj3UJQBwN
 +9684E0WFoHSwiKWzcTDDb+RJwY1X45MGGvYEMU
X-Received: by 2002:a17:90b:1809:b0:38f:7f60:ba35 with SMTP id
 98e67ed59e1d1-3966d199247mr3113659a91.5.1787688902153; 
 Tue, 25 Aug 2026 13:15:02 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39668a57396sm1008701a91.13.2026.08.25.13.15.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 13:15:01 -0700 (PDT)
Message-ID: <2db8ac0a-1b37-450d-8c11-2c5da46ca97a@linaro.org>
Date: Tue, 25 Aug 2026 13:15:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/23] target/riscv: Rewrite vext_ldff
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, frank.chang@sifive.com, qemu-riscv@nongnu.org
References: <20260815194549.1377505-1-richard.henderson@linaro.org>
 <20260815194549.1377505-12-richard.henderson@linaro.org>
 <ao3JcPyrC7cZaCgp@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <ao3JcPyrC7cZaCgp@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/25/26 10:58, Max Chou wrote:

> On 2026-08-15 12:45, Richard Henderson wrote:
>> Do not call probe_pages for every active element.
>> We can make do with no more than 2 such calls for
>> the two pages the insn might reference.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> +    /*
>> +     * Test whether the first page is accessible.
>> +     * If the first element is active, it must succeed.
>> +     */
>> +    flags = probe_access_flags(env, adjust_addr(env, addr),
>> +                               MIN(last, last_in_page) - addr + 1,
>> +                               MMU_DATA_LOAD, mmu_index, !first_active,
>> +                               &host, ra);
>>   
> Hi Richard,
>
> This probe traverses every byte from the initial active element to the
> end of the page, not just the bytes of active elements. In the masked
> case, the range may encompass a masked-off element, and masked-off body
> elements do not perform memory accesses.
> I think it may causes unexpected vl.
>
>> +    /* Get number of complete elements in the first page. */
>> +    elems = MIN(page_split / msize, vl - i);
>> +
>> +    /* Load complete elements from the first page. */
>> +    if (likely(elems)) {
>> +        uint32_t page_evl = i + elems;
>> +
>> +        if (flags == 0) {
> ...
>> +        } else {
>> +            /*
>> +             * If the first element is active, it must succeed.
>> +             * This will load from MMIO or fault from INVALID.
>> +             */
>> +            if (first_active) {
>> +                vext_ldst_nf_tlb(env, vd, addr, 0, nf, esz,
>> +                                 max_elems, ldst_tlb, ra);
>> +                i = 1;
>> +                addr += msize;
>> +            }
>> +
>> +            /* Stop if invalid (unmapped) or mmio (transaction may fail). */
>> +            if (flags & (TLB_INVALID_MASK | TLB_MMIO)) {
>> +                env->vl = i;
>> +                goto tail;
>> +            }
>> +
> For an example, assume
> - vl = 3
> - vstart = 0
> - the mask be [1, 0, 1]
> - assume element 0 and element 2 be readable, but deny the byte at element 1
> - all three elements are in the same target page.
>
> In theory, the element 1 is masked off and doesn’t perform any memory
> access, so the value of vl remains 3.
>
> But the previous probe covers element 1 to 2 and the flags will be non
> zero due to the denied masked-off element 2. Then the vl will set to 1
> here.
>
> Maybe we could switch to per element prob when vm is 0 and flags is not 0?

How are you going to deny the byte at element 1 to be unreadable?  Are 
you expecting this to be some PMP thing, with a 1 byte range?

How I expect things to work is that:

  (1) We scan forward for the first active element, set vstart.

  (2) Probe the page for that element.  If that faults, vstart is 
visible to the trap handler.

  (3) Discounting MMIO, all following elements in the same page cannot 
fault, and we can process them immediately.  Obviously inactive elements 
get vma handling not loads.

I'm not sure I'm understanding your question properly...


r~



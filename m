Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6427C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 17:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuYoC-0005ai-5V; Thu, 13 Aug 2026 13:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuYoA-0005aR-If
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 13:01:34 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuYo8-00084D-Uk
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 13:01:34 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-cbedbaba5fdso54449a12.0
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 10:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786640491; x=1787245291; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DLfpUBMP/6htYTpWi7cMeNlaRu5yNDjLu/vsvmKG3tI=;
 b=KFN2ElWrmbGIkml/JZS8wyWlta2AkyfGOCggRWUehoBnmjqk6hbOsI/Kfl54hEmixF
 WaVRb7ftxtohLwPIDpOtTG8fbSB8DJbS+0HbozfE2td90b2Eu4zedcPdBzLQKrtaZXAW
 +rFDFCaoxoBD+2yCYrP4Mk/i6Khz/XkxSUXsZO5/5wo/wBpCHNQDYUZiAScphLJ2+ebN
 LsTMtXs5qzHRmQd5ie5wXex8jVf31e8/EIC3B2Ml6+h4/+/7vpmh4hY1whTKQ8d2RLUg
 4Do9LSTQyxSpqSnPwQB4g+lDHU6tPoFdupd1CtZd9fb1ExoGdDfnGxK4VWJwNVyCdw9r
 D/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786640491; x=1787245291;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DLfpUBMP/6htYTpWi7cMeNlaRu5yNDjLu/vsvmKG3tI=;
 b=sJQKoOMK6wMqxgCXm06DH4LpnKXl3/GUVuMk+wW3bHItQFosUp5S5dP/qWcuP1prST
 R+0D6Ts0GmwbM4y3qI5TcN1BFeBbrJH567/qYAWvneUcBK4vkvBHPMswxMfz4ELuOYHD
 X/DbDgyxOZxIGwRQF5VEu0jLGa9HOvDDahvDuYg4++Pt1qVJcD+r/Ha39oBAY72pv1jV
 0oDcxjNOWMplj1938hSwiEoajvgj0D9yIInKcP/FF6RqUd05wvEYo5x17PfN44MixAwk
 ISyhPncABVXKb58rkRpPlBs7xvNLpOmYiz7cWYvBM0WNNud7XjC4hqycM+X3NU0PHQGA
 HbqQ==
X-Gm-Message-State: AOJu0Yy2pE/sY25BvwRr4KrAUs60CHDMr1T5ISRkEQhD7DDoeaC5vS58
 t+DMZT70jymAhbWOWNJD9TB0jOfuE4R2VuB6jHrt5lUF8bwp6/nDr7IGm/B6MpIHsrg=
X-Gm-Gg: AR+sD12SuSnK8WQd6rEBJRA+3dchFtzdpUY4JWxuw2epsXG4DxrzFChGLdBi7tUwxR6
 judccdM6aSKaFQhXohZRzXqROrSTCIzMk3qJUfxWxdJNLIBP3xQRRLH60C3FVO5/RRCCcTOgqoi
 jtu4x5hlOYIcGGi09f20W9gZxTFSLbUSmxsYaZZzVdjwBV8M/EicEudh8nC1O4tCM3kREjZfZZt
 UpRFlHrPcrq9fvVzqAm0+3A1y3WZOxkyadge470VKJPJ1lxqmPh/1ggehXzoqPDUApeh/at3IlB
 gJbT72hFR5fRmX//W07RBUPqtWBbPeAKDagEWh1eDAYZq1V3Pcz+zeyx/SlqMJKBSADks3MP50J
 wmYKGgeCRrAV2d7BAWM5r5LWJXyVClKuBNCXCiFPRXaXOMspuDezeIBJAURMg2PYVEgrllugk+i
 /vGLjNr1diU2Kco6iWkf79aiD3EWD+5SoxzduPVfGfuBIA4r8TcJo1P/Yqj60qpHGtjl/bsR3qW
 oSbZJXFKIObKFrHxrLUmrx9UYtm
X-Received: by 2002:a05:6a21:4c85:b0:3c3:9c4e:de3a with SMTP id
 adf61e73a8af0-3cc54f42b93mr10451913637.6.1786640491153; 
 Thu, 13 Aug 2026 10:01:31 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef7217132sm1385488a12.23.2026.08.13.10.01.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 10:01:30 -0700 (PDT)
Message-ID: <ce3a48b5-9847-4cc4-a02f-86db497c91ae@linaro.org>
Date: Thu, 13 Aug 2026 10:01:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/17] target/arm: Raise alignment fault for DC_ZVA on
 Device memory
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260717232306.378988-1-richard.henderson@linaro.org>
 <20260717232306.378988-6-richard.henderson@linaro.org>
 <CAFEAcA9gNvMD5YVTy2Zj51riyY9j+eCurQpH8M-ymb4yaf4-Kw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA9gNvMD5YVTy2Zj51riyY9j+eCurQpH8M-ymb4yaf4-Kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

On 7/28/26 07:21, Peter Maydell wrote:
>> +    flags = probe_access_full(env, addr, 0, MMU_DATA_STORE, mmu_idx,
>> +                              false, &mem, &full, ra);
> 
> Is 0 really the right size to pass in here? Looking at
> probe_access_full(), if you pass in a 0 size then it will
> call notdirty_write() with a dirtysize parameter of 1,
> which will then not invalidate or set the VGA/migration
> dirty bits on the full range of memory we're about to clear.
> This would be OK if we then went through the slowpath and
> did a set of byte accesses, but probe_access_full() will
> clear TLB_NOTDIRTY from the flags it returns to us if it
> called notdirty_write(), so we will take the fastpath if
> that was the only flag set.
> 
> Maybe probe_access_full(), probe_access_full_mmu() and
> probe_access_flags() should not call notdirty_write() and
> clear TLB_NOTDIRTY from the flags they return if the passed
> in size is 0 ?
> 
> The notdirty_write() API also wants the base address of the
> DC ZVA block (since that's where we will be writing from),
> not the address from the guest.
> 
> (We may be getting away with some of this because of various
> functions rounding up/down to full page addresses, but none
> of these functions seem to document that, so we shouldn't
> rely on it.)

That's exactly what's happening: physical_memory_set_dirty_range takes a range, but then 
widens it to the surrounding page boundaries as does tb_invalidate_phys_range_fast.

I'm certainly open to rearranging the (entire) API here, but it's not immediately clear 
what form that should take.

Perhaps instead of the (addr, size) pair, we should have (addr, first, last) triple, where

     first <= addr <= last

Normally, addr == first.  But for these cases like DC_ZVA, addr would be what is reported 
to when faulting, but the surrounding [first, last] would be used for 
watchpoints/notdirty, etc.  With this api, the rather confusing size == 0 is not a thing.

Hmm, if we remove size, what to do when passing size down to tlb_fill?  Do we need to 
expand that API too for the benefit of the range-based protection mechanisms (Arm PMSA, 
RISC-V PMP).

Thoughts?


r~


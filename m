Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5175DC43211
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd8XC-0004jC-9s; Fri, 26 Jun 2026 11:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wd8XA-0004i5-6o
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 11:32:00 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wd8X8-0002T9-Oo
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 11:31:59 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-845c92bc464so520831b3a.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 08:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782487917; x=1783092717; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SIwa7oCaPMrO6inDR3f78bRtgOOwmwY26YIu8SifTbQ=;
 b=IGrB6nUcM1BU/oar9/U/NXCKfw4uMh5/W7heViuTTiMU1yMo1o70LJJyAV7fAl9xS4
 hs3M8TlE/PQjRUosPJIZ2gIjvF6v7RgIwIWu1YUQkHHytuqt9hbdV9/h7yJB0T6q9TKx
 meJn4jJ8WrfkfjPP4oTI7SNWC6/8TKC6X0PVwCDQ8s6hazrBvHTLjkF3IZ5N+FPhnafB
 RPhssfOZ6PWfJgL8Hkziexw9+6sCpTJV9Fl5Bd3/bSUjXhu99adMg1Ucl6hgfYKL0H5C
 CgH+B9PvapG2WOzkP7XXmZj8Q9B/biahixgbn0yegPzEESdG2U5ceozLxpVUAEQh3Ll5
 bvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782487917; x=1783092717;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SIwa7oCaPMrO6inDR3f78bRtgOOwmwY26YIu8SifTbQ=;
 b=Uf2rRSaDwOVyQiDTRUky0Ys8ZzepItfgNrwMBcT2LV3zJ/RFXsNmw0/+HnvF8iUN2o
 7iOwwvDY3/W7ACC28JT+DCiTIGw2S3hg7TxkK/6yr0Wl9wQQYKJmgrOF3+IA4FxixvK+
 benN+sNSZz2npECleYTxl0Sun/sZQTgd5pOZjswbUQHjQ7oadpGym9vuhKQ6GxvRpLQq
 2TWRgnHYcZwa1geGEKqtmbkX1g1xurFmGZMVRhjP5U/wC9eg08iIs8TnPc71+PpNWXeb
 UOC06+TFbYeB0gobYHlVAvgShHeKn1+q50Uxg4pQOygav1Y75v14yR1PsfoMBw0E9plE
 +N/Q==
X-Gm-Message-State: AOJu0YwMI74rDttzO7wT/RgRfpL8OLh6EGJjk1A2MEP4qX/ZFUjTAXfa
 0i9reJJzPK3frCHvho6OovddJXruAXA9JkpjcWaYbj4H8L94+Xsr32Q19f+l8Bg0a+0=
X-Gm-Gg: AfdE7ckI/xIvQm78e3aAAnUX5IkZqF95OwvkL57sAyq3nOdKEglee5x7ttBst4deefm
 6Jl432aDK9+HqIn/iOzyIeqTjatfPjvYKVLA/KcG5iaezdDgBX/2D31zQ0uqS+clgg+jqF45dpp
 97TM0itwrF5v7SA2Nol38dgxDfwZ+9YNV3cv8a2wI3sRVPNi3uYbGNQCsEuuvA+fHMyebsTZ11u
 r0peW32XH5UNQIOHSM37m5hAZo89s/rEkyWGTRIaKimWQWO9H6mPyIYIqdOEmP9kneIhanPt4pf
 I3+VQ1wGaijrUYlkm63RFqf1ZwWDibASGB4/Iym6c1dF2GZh9XCe8fwdxJy9sh2TMREeYzFdbdt
 vFIo2bleEBx4huV8CUaXfBgNTmsdbvaXjKRALfeEV/rTq4XjMaIaQ7udlCtBDnA3uYhzNarBGsd
 qw4hqtZlU4/lr7bdqDUoOk/SJ6ZMgRl6wzGMfy26h6zZDMnLY2o2HcK3it+Q==
X-Received: by 2002:a05:6a00:181d:b0:842:21f0:5113 with SMTP id
 d2e1a72fcca58-845b3b8e2ebmr8206397b3a.24.1782487916725; 
 Fri, 26 Jun 2026 08:31:56 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845a3ec0ec9sm6900385b3a.0.2026.06.26.08.31.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2026 08:31:56 -0700 (PDT)
Message-ID: <9d819962-caf2-4ebd-a72c-84c83c68b7e5@linaro.org>
Date: Fri, 26 Jun 2026 08:31:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Implement and enable FEAT_SSVE_FEXPA for -cpu
 max
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260625224723.766270-1-richard.henderson@linaro.org>
 <CAFEAcA_LE9O0Ax0AKnsJi-7FAxfmcLxxSYrOTUU-VYmgJEaKEA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA_LE9O0Ax0AKnsJi-7FAxfmcLxxSYrOTUU-VYmgJEaKEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 6/26/26 02:31, Peter Maydell wrote:
> On Thu, 25 Jun 2026 at 23:48, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
>> --- a/target/arm/tcg/translate-sve.c
>> +++ b/target/arm/tcg/translate-sve.c
>> @@ -1373,7 +1373,7 @@ static gen_helper_gvec_2 * const fexpa_fns[4] = {
>>       NULL,                   gen_helper_sve_fexpa_h,
>>       gen_helper_sve_fexpa_s, gen_helper_sve_fexpa_d,
>>   };
>> -TRANS_FEAT_NONSTREAMING(FEXPA, aa64_sve, gen_gvec_ool_zz,
>> +TRANS_FEAT_STREAMING_IF(FEXPA, aa64_sve, aa64_ssve_fexpa, gen_gvec_ool_zz,
>>                           fexpa_fns[a->esz], a->rd, a->rn, s->fpcr_ah)
> 
> The FEXPA feature gate also changes to FEAT_SVE || FEAT_SSVE_FEXPA,
> so I think we need the second argument to be a new feature
> check function aa64_sve_or_ssve_fexpa.

Oh, right, for the !SVE case.  Thanks.


r~


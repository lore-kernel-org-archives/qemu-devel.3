Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34FF9CD98F6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 15:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waEIH-0006Nf-0k; Thu, 18 Jun 2026 11:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waEIF-0006N5-9R
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 11:04:35 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1waEID-0005MZ-ED
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 11:04:35 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-8419ab3a297so540361b3a.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 08:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781795070; x=1782399870; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ynw5GC9X+lD2FA7opH+nuZTWCvvSpjKPtuDQc6GDCEU=;
 b=LSnj3qZS/ar9vmpp5GkBkjKgeRNNxnOvulbvmBpupJYcDdOfkRRm2Hh9vMgHSTr/VV
 ODOoim7SgFxwWDXqZBQuAKyye9R/xmi1nA72AXLI1j1Xpte6Kk2xAjYWVPfr1aUgJfgu
 RRE4RX9LUVCx3GfUehRL9E2XaAj2u/PH0qcp1/ifXOfK+jxph+LH3Cbh8wPC9I315J6Z
 hemcJp3vQG2tT1c/3r04I9JfYZapQ/Bo8TrizfmKS9riTBVNbAV1/TGjPpXJ5co3Pe2C
 npTDS9MCwsVuJNT+2EEs5JzVhcyslCpaGrvTEmvRPKn4YNRJ7eutkjhSKYkRqVr92DVk
 Tdog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781795070; x=1782399870;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ynw5GC9X+lD2FA7opH+nuZTWCvvSpjKPtuDQc6GDCEU=;
 b=DtuzateD3PfMlGFSzDgcNYPKN4il+qK/YxKPBn281c5MWRifBIPPbG1DxwNK1byV/h
 cC3tDcdunLeA0eqrY0hcHqEckG60mz2YV39X3UsRBO+MQ0xFi0nvmi3Kok1DkBHKk8xH
 aXjTba8FOO3s0xX+9vkwD8iXtXK1dzE6fX1m/lqBF2xIeHJ51rsPXYDHBix6JMxEh/Dc
 92aOA+RkDjDYzam0ilwpxC5thwx0dFDiynRX09BUJ4/PmozbnlNjSVGYFdvS2YlXzwuO
 nVLcL+a9YMWiKSIOM0dS+b+V6eDlShNp0D2J+Qad6uKauEOP/oaQjLSVDtqGIkQZN3v7
 045A==
X-Gm-Message-State: AOJu0YwJRPRbfdYJxKbp8yePhMOCzTJaOn8RluDsmDQPPxW3C/E5J5v+
 6f2WSkJhdatdi4+FKyxcXI+PibbcaPxVF/aR5I6JRDsloq7VO26r4j6WNiH5rFnONrUtBtjckV2
 fG+AH
X-Gm-Gg: AfdE7clZuR43pEMsr6F6mnCmtbBGHr8ABG3dqcOfRzzdPx/1z5lyH3Jt97K24VAPT8t
 ZzxGf53LpJ0lzATGvW8Jv9s/tKNosDQL3HHJHagr9hFqImrrZenkrNtWooJ/KY1yGGyTu5q8C/+
 B2UW7u0di+xU0BptGfwwJg+0Z/99TYgxlSUZ/aZ44vgOhyOfhW6tP89wYiswGnudMkAXSDLN2RW
 PAJo7PbcA10a0b8mkyJG7pFCvlNTg5ItsZ79oJ+7TvxXjb3yASMczjr9JxlF8Tr/fWAbJJ4Inz8
 uN1zPwWag7KO7faPdOdPzUJZik59DrJOUDzLEJlpti8og/3v/TXyik4tZc0clhLBvQIEdV6xcsw
 WcAqg42yy7C2v9SKv4AIjw2WuipZ+hBfYp0rQ5DXGDPuUKu5LuIm1p0uw/prFzrb8rqIEC/MvyN
 cd/aRE96RzKPh0obOU0UQ90ZpcN9s7E/hnJ4E1Et4kZmSnIV9PfomTwiL1XQ==
X-Received: by 2002:a05:6300:6702:b0:3b7:b328:4c8f with SMTP id
 adf61e73a8af0-3b8b582e3c6mr10449230637.8.1781795069759; 
 Thu, 18 Jun 2026 08:04:29 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c889356266dsm4620341a12.6.2026.06.18.08.04.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 08:04:28 -0700 (PDT)
Message-ID: <16d97ff2-7e12-49ee-be1f-315f1387ba71@linaro.org>
Date: Thu, 18 Jun 2026 08:04:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] tests/tcg/arm: Tests for new FPRCVT instructions
To: qemu-devel@nongnu.org
References: <20260618-jmac-fprcvt-v1-0-1b4475bacf51@linaro.org>
 <20260618-jmac-fprcvt-v1-2-1b4475bacf51@linaro.org>
 <878q8cgeux.fsf@draig.linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <878q8cgeux.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 6/18/26 06:25, Alex Bennée wrote:
> Jim MacArthur <jim.macarthur@linaro.org> writes:
> 
>> We autodetect the presence of FPRCVT in the test cross compiler,
>> which is a recent feature in GCC and not supported by many distros
>> yet. If this is in place, add extra tests; these just use FMOV to
>> move to/from general registers and use the existing test cases.
>>
>> The existing [US]CVTF instructions do not have a test, so no new
>> tests are added for the SIMD versions. They have been tested manually
>> to check the new SIMD versions produce the same numerical results as
>> the existing versions.
>>
>> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
>> ---
>>   tests/tcg/aarch64/Makefile.target |   25 +-
>>   tests/tcg/aarch64/fcvt-fprcvt.ref | 3331 +++++++++++++++++++++++++++++++++++++
>>   tests/tcg/arm/fcvt.c              |   26 +
>>   3 files changed, 3376 insertions(+), 6 deletions(-)
>>
>> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
>> index 6203ac9b51..fb68fb4810 100644
>> --- a/tests/tcg/aarch64/Makefile.target
>> +++ b/tests/tcg/aarch64/Makefile.target
>> @@ -12,11 +12,6 @@ VPATH 		+= $(AARCH64_SRC)
>>   AARCH64_TESTS=fcvt pcalign-a64 lse2-fault
>>   AARCH64_TESTS += test-2248 test-2150
>>   
>> -fcvt: LDFLAGS+=-lm
>> -
>> -run-fcvt: fcvt
>> -	$(call run-test,$<,$(QEMU) $<)
>> -	$(call diff-out,$<,$(AARCH64_SRC)/fcvt.ref)
>>   
>>   config-cc.mak: Makefile
>>   	$(quiet-@)( \
>> @@ -28,9 +23,20 @@ config-cc.mak: Makefile
>>   	    $(call cc-option,-march=armv8.5-a,              CROSS_CC_HAS_ARMV8_5); \
>>   	    $(call cc-option,-mbranch-protection=standard,  CROSS_CC_HAS_ARMV8_BTI); \
>>   	    $(call cc-option,-march=armv8.5-a+memtag,       CROSS_CC_HAS_ARMV8_MTE); \
>> -	    $(call cc-option,-Wa$(COMMA)-march=armv9-a+sme $$fnia, CROSS_AS_HAS_ARMV9_SME)) 3> config-cc.mak
>> +	    $(call cc-option,-Wa$(COMMA)-march=armv9-a+sme $$fnia, CROSS_AS_HAS_ARMV9_SME); \
>> +	    $(call cc-option,-march=armv9-a+fprcvt,         CROSS_CC_HAS_ARMV9_FPRCVT)) 3> config-cc.mak
>>   -include config-cc.mak
>>   
>> +ifneq ($(CROSS_CC_HAS_ARMV9_FPRCVT),)
>> +run-fcvt: fcvt
>> +	$(call run-test,$<,$(QEMU) $<)
>> +	$(call diff-out,$<,$(AARCH64_SRC)/fcvt-fprcvt.ref)
>> +else
>> +run-fcvt: fcvt
>> +	$(call run-test,$<,$(QEMU) $<)
>> +	$(call diff-out,$<,$(AARCH64_SRC)/fcvt.ref)
>> +endif
>> +
> 
> I'm not sure about this as now we have one test with two modes. Can we
> not just create a new binary (fcvt-fprcvt) and keep running the original
> test either way.
> 
> See how we do that for the sha512 and it's various vector variants.

You certainly don't want to be duplicating the reference file.

Perhaps test the v8.0 convert insn output vs the FEAT_FPRCVT insn output directly?

Also, this patch is ordered incorrectly.  With the instruction feature test properly in 
place, it will fail without the final patch to enable the feature.


r~


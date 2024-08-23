Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D88C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 13:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shU5x-00039P-P2; Fri, 23 Aug 2024 09:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1shU5k-0002r8-AR
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 09:12:39 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1shU5g-0008LF-6B
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 09:12:34 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-367990aaef3so889600f8f.0
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 06:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724418750; x=1725023550; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kZm4PfibtpRGpn3IqWPXC9c8VGc1XvHxPnunSXDU2ZY=;
 b=lgsIobfLfCKC6gwbDGRdofLlj2VSBw6qvMoRgd2SbtC2e2u7QrF6s7w+snxRoJD1H5
 E/YJocLji+azrjAzwpM6+d9aHTAUwfi2KFpfUUOQl/kk4W4trUOPeW5QHznnuufUfJlS
 Dm+UqkI0izhpfmZSzglpG3v1SNTnzz+hWWudau+W+dx98HNP0GJZ0WGA4lFry7yPfMTP
 E5N00P6aXp0yGXcPKA6AfhAsPouehoQsMEMzQw/IrgJOskU1+OmnyKPfbyfUKXwSNxos
 o3CkaPUr+H7e5h/PmVcXNj/ULO2j5V2SchLe2vPNgGYge7tBXAyn/51TY9zhrpvX7Ksq
 nk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724418750; x=1725023550;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kZm4PfibtpRGpn3IqWPXC9c8VGc1XvHxPnunSXDU2ZY=;
 b=HCOrN81qXrL1+Nl5pzT5k/F16+S12g46njG+7l8YUzM5nSzqgasfRMxhN3S8wrrDWw
 3VmXTTtvwNdjYxxoxauxt9kUv/VEL0QZKnoRXItX26dDzfLxHs6/OUxzcDGplBTamKsm
 fEO5nifOypFq5TidgzGQ5Abmy8QKqISkG7bMR5j4NBgNv7EySlz5GXx2DDKHBSVkB1XU
 oKvLYm0qJ+kaV7eX05RyyaGGHoMJNVzzFYXixsw7YOeCJwFogvs3QLGugCA7GrkY5XnW
 eYH3ZDE/LdeaazJ85JV8FdC8jCwZyuJkroiskWxPGkysNVBrAIJp/Fp+NQbKB8NRHHxu
 jLaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXTGYP9WMjBU9Jp67TDHpSNcpCzjkMnSbIxjfs1uF4n/3BUX6BkNsjWFe4fvLL39M43KJwfpl3Mtoh@nongnu.org
X-Gm-Message-State: AOJu0Yw3R4kkLQS9EfnC8b+ccylAIVmD1O3xRbXuYp4fQQ6b8/YRlk+y
 sw9/nvCZtF/wosiWrYZNzTvVgOVJBjag5JJTG5Fh7NA30c3/1RaKPDE4LCcjrh4=
X-Google-Smtp-Source: AGHT+IGFZiS3VdT6X3XPJSuDOeopJTX1xfG1IFNtSaJnSaFflgTw7YDE0Hc16p4rnPejEqd/LD68/Q==
X-Received: by 2002:adf:e50c:0:b0:368:6598:131e with SMTP id
 ffacd0b85a97d-373118d228amr1447664f8f.38.1724418750287; 
 Fri, 23 Aug 2024 06:12:30 -0700 (PDT)
Received: from [192.168.69.100] (plb95-h02-176-184-14-228.dsl.sta.abo.bbox.fr.
 [176.184.14.228]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3730810fb76sm4181812f8f.8.2024.08.23.06.12.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Aug 2024 06:12:29 -0700 (PDT)
Message-ID: <51146942-7414-42a6-95cd-2b9a9e197bd0@linaro.org>
Date: Fri, 23 Aug 2024 15:12:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional: Convert Aarch64 SBSA-Ref avocado
 tests
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240822114146.86838-1-philmd@linaro.org>
 <d8c744cf-0da1-42fc-92cc-f8bec8ca00e1@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d8c744cf-0da1-42fc-92cc-f8bec8ca00e1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 22/8/24 16:06, Marcin Juszkiewicz wrote:
> On 22.08.2024 13:41, Philippe Mathieu-Daudé wrote:
>>   # Timeouts for individual tests that can be slow e.g. with debugging 
>> enabled
>>   test_timeouts = {
>> +  'aarch64_sbsaref' : 180,
> 
> What kind of machine is able to run those tests in 180s? I bumped them 
> to 2400s and got timeout (Macbook with M1 Pro).

Indeed with Avocado this timeout was per test function, now it is
per test class. Having 11 test functions, for a 1-1 change we'd
need 180 * 11 = 1980 seconds.

I made a comment on Thomas/Daniel's series this patch is based on:
https://lore.kernel.org/qemu-devel/4b4018c6-4a2b-4250-bb53-be9cc5df7cb4@linaro.org/

I could run all the tests in <300sec but for safety, should I keep
Avocado equivalent and use 2000s?

▶ 1/5 
test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_alpine_linux_max 
              OK
▶ 1/5 
test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_alpine_linux_max_pauth_impdef 
OK
▶ 1/5 
test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_alpine_linux_max_pauth_off 
    OK
▶ 1/5 
test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_alpine_linux_neoverse_n1 
      OK
▶ 1/5 
test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_edk2_firmware 
              OK
▶ 1/5 
test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_openbsd73_cortex_a57 
          OK
▶ 1/5 
test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_openbsd73_max 
              OK
▶ 1/5 
test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_openbsd73_max_pauth_impdef 
    OK
▶ 1/5 
test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_openbsd73_max_pauth_off 
       OK
▶ 1/5 
test_aarch64_sbsaref.Aarch64SbsarefMachine.test_sbsaref_openbsd73_neoverse_n1 
         OK
1/5 qemu:func-thorough+func-aarch64-thorough+thorough / 
func-aarch64-aarch64_sbsaref        OK             241.79s   11 subtests 
passed

> "make check-avocado" (with some AVOCADO_* vars to limit list of tests) 
> shown me which test is run and pass/fail for each.
> 
> "make check-functional-aarch64 V=1" shows me "1/4 
> qemu:func-thorough+func-aarch64-thorough+thorough / 
> func-aarch64-aarch64_sbsaref" and timeouts without information which 
> tests pass, which fail.
> 
> Maybe for QEMU project this is a progress. For me it is moving tests 
> from working ones to "sorry, timeout, find out why" ones.



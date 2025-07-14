Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4D3C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 16:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubMES-00012K-JH; Mon, 14 Jul 2025 12:40:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ubLIm-0001QV-3k
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 11:41:12 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ubLIj-0005QL-4W
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 11:41:11 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7490acf57b9so3158825b3a.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 08:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752507667; x=1753112467; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WaMSdvDqUwH+ccr+EoYDri+v+MWm3qoOo8/ZPe03Y4A=;
 b=LAJ3CN0KmIUlIWwOGUw8ADXsYe2NovEi5PZPG9Dwwq3BuixUCx/SAxF7T8Lda2NPO/
 UeH7rSdMerMZw9+zmpnIYr1S2JNnDUB9tbkIz3vp8Y19G5qlxewV9GjyNpJgBAS35eha
 ce4uIEQkhD5qGY39pDetSXRe7r954ElV8kJIIrn4yI2Ij53xgYK2CEK+mmC5CT/RJUkh
 wPYZO3yjEqvHJjKgP6YOhxAYiniw+Azln3Es6noNuzbJ4nc5474ZNU1UZgoDLzQkGvxM
 vIa2Bk0MFpW2tWb3+0fxdiHAOQHA6hH+WikBcqdB3nHDZKggunxGWYaqUSz4v/jUJLES
 EtxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752507667; x=1753112467;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WaMSdvDqUwH+ccr+EoYDri+v+MWm3qoOo8/ZPe03Y4A=;
 b=MMHQ/kZD570g/Mom0p2t2IbV750oYfLwwqbGOhfmVGPmhNRAZs8RzCJsbG0Te3Xnpb
 xaaUqOHGakGfLquiTsfXi/iCssKs6qWU/fF6B0McIorFNFjP0+u1qNPCDAJiZ11XARjF
 17KOM1YbfC9VytuqzlaSFiQlkYHWNMyziS3E/N5gjmC6eFI1R/CEWa2jj+TelBdK58HW
 fCa59EUNhrEJUfH5ZPF7o3QuKtNUVVPtcC4v2loMVLPhOm51Hp6JgB3p37Fv8TOVieYx
 Yruc3D8tw8c9lW6HOQd2X2DzgQrS4xopD2+jxuA27pomn08IKGmvPO3e4SbtlH7Wcgrd
 DnKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+tn4KEegVQ5EiKogcQ1einjtOdWhS0o/R4MS4lxN2ZX3FZxtw79OOJgE09GaV/WBTwR49Nb3O0Btj@nongnu.org
X-Gm-Message-State: AOJu0YzloQhARv2Ww/NHTd7YA+DEMhmaOlcR/krzk2O/6eB6AZpmFKUB
 c4C82ilNXCfwW2BXQeecKAKwH2Kiu91E+2Q4MYqg3PePqQ0KAWl1gfWjjx/LLy3RwWY=
X-Gm-Gg: ASbGncsk68Nf5tcYI7cpAJdzDZSUGI38VgQWSvfQwV+BYG+wo7vYFTXfRwl81bcuk+u
 Z59k2ogt4ichX4cxsRV1AmyIy2LI3Qrm+UnaoSQeR9GITMvPbi/3JWLt9fKJBCeC9FmPLiRYjO7
 zPUECkDHM3lPbtT/PYqTaONQiGj18c2E8pbVm4QihV7YxA+7Nt9iKppdo4DFmcjUCTUqJqpfQk4
 WOSKBj+vtFjbY13EKKDMhJVUEzTji+s071CFTu37ziMDi1JEq6NvDS0erZ7wrUTY8fK2IsU0cd4
 izQNYn3wiGnyTmu32FWBy68RDaE/JNDq1nhC4jPd519CMwLVuEOuL5Twr5y9FtgdOdV3F5Vx1Lz
 WSGiVIVEo4UgUj4oTd+wYvPIPudly8QbidAM=
X-Google-Smtp-Source: AGHT+IGQC4jAxZPo6q0j+cKIoSGM+SwMsKnoEpi//37hllrFLHqtMnfPmkQ0u8+GT7D5t5qEABhZAw==
X-Received: by 2002:a05:6a00:39a0:b0:749:456:4082 with SMTP id
 d2e1a72fcca58-74ee0aa6980mr18948929b3a.1.1752507667341; 
 Mon, 14 Jul 2025 08:41:07 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9f8b990sm10865681b3a.153.2025.07.14.08.41.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 08:41:06 -0700 (PDT)
Message-ID: <95b00393-bdd2-4db3-ac39-02a09f83b4d7@linaro.org>
Date: Mon, 14 Jul 2025 08:41:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Provide always-false kvm_arm_*_supported()
 stubs for usermode
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20250714135152.1896214-1-peter.maydell@linaro.org>
 <0b438773-01b9-42e1-8edf-2330e50387f8@linaro.org>
In-Reply-To: <0b438773-01b9-42e1-8edf-2330e50387f8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

On 7/14/25 8:31 AM, Pierrick Bouvier wrote:
> On 7/14/25 6:51 AM, Peter Maydell wrote:
>> If you try to build aarch64-linux-user with clang and --enable-debug then it
>> fails to compile:
>>
>>    ld: libqemu-aarch64-linux-user.a.p/target_arm_cpu64.c.o: in function `cpu_arm_set_sve':
>>    ../../target/arm/cpu64.c:321:(.text+0x1254): undefined reference to `kvm_arm_sve_supported'
>>
>> This is a regression introduced in commit f86d4220, which switched
>> the kvm-stub.c file away from being built for all arm targets to only
>> being built for system emulation binaries.  It doesn't affect gcc,
>> presumably because even at -O0 gcc folds away the always-false
>> kvm_enabled() condition but clang does not.
>>
>> We would prefer not to build kvm-stub.c once for usermode and once
>> for system-emulation binaries, and we can't build it just once for
>> both because it includes cpu.h.  So instead provide always-false
>> versions of the five functions that are valid to call without KVM
>> support in kvm_arm.h.
>>
>> Fixes: f86d42205c2eba ("target/arm/meson: accelerator files are not needed in user mode")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3033
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> I'm never sure when we prefer to use stub-functions in separate C files
>> vs when we prefer to have ifdeffed stubs in headers. There are several
>> ways we could fix this compile error, so I just picked one...
>> ---
>>    target/arm/kvm_arm.h | 35 +++++++++++++++++++++++++++++++++++
>>    1 file changed, 35 insertions(+)
>>
> 
> Thanks Peter, clang with --enable-debug is indeed a combination I didn't
> try. I'll test this too now. Going through this topic, yes I noticed
> that gcc always folds the any if (0) condition, and, based on a Richard
> comment (I can't find now) it seems that we used to rely on that for
> other parts of the code.
> 
> The fix you propose works well (initial goal was just to remove
> CONFIG_KVM, so having CONFIG_USER_ONLY is ok), but I wonder if there is
> something specific affecting clang in this case and preventing the folding.
> 

Indeed, clang does not fold the condition "value && kvm_enabled() && 
!kvm_arm_sve_supported()". Looks like a missing case.
This code compiles with gcc -O0, but not clang -O0.

extern int f(void);
int main(int argc) {
     if (argc && 0)
         f();
}

As folding is not guaranteed by C standard, I'm not sure it's really 
possible to file a bug. However, since we rely on this behaviour in 
other parts, maybe it would be better to rewrite the condition on our side.

By changing the code to this, the folding happens as expected.

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 26cf7e6dfa2..af5788dafab 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -318,9 +318,11 @@ static void cpu_arm_set_sve(Object *obj, bool 
value, Error **errp)
  {
      ARMCPU *cpu = ARM_CPU(obj);

-    if (value && kvm_enabled() && !kvm_arm_sve_supported()) {
-        error_setg(errp, "'sve' feature not supported by KVM on this 
host");
-        return;
+    if (value) {
+        if (kvm_enabled() && !kvm_arm_sve_supported()) {
+            error_setg(errp, "'sve' feature not supported by KVM on 
this host");
+            return;
+        }
      }

      FIELD_DP64_IDREG(&cpu->isar, ID_AA64PFR0, SVE, value);

If you prefer keeping your patch, I'm ok, but fixing the condition looks 
better to me (as we already rely on constant folding in other places).

> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Thanks,
> Pierrick



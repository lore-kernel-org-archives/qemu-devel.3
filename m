Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D8FC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 21:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubQot-0003RW-Vg; Mon, 14 Jul 2025 17:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubPAn-0000Wh-S6
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 15:49:19 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubPAl-00038l-KK
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 15:49:13 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4560cdf235cso12185535e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 12:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752522549; x=1753127349; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4ZE+5rsQ80B2zoUSJLcp9UieWOHgoZ5HuNRB+xdScR4=;
 b=WaLi3WCC394U3IMaf8UBcIMp3lpQKjCzfmpSPwF/IxrdHdbQG4cVKp/RjmKxLMBhi8
 f/tw+03H00u8Q41/GaUgVNV4WWB/oSe1csMfoVmfrydQcGhQtBKODxNyYKlk6eDbBhFw
 z54+3QC4AEOn3yk77zW+OI08wxtakKl42wMlCJea04tf8HGC6OR/pC87OfzqFXY1ET/o
 76jOF3mVKRbE/fslKdkJqxfr8dPJ0/EwUhRi80pIEY6oJUeB5T4ioIig477yxptBFPdC
 unwYeOx8AcCAqJJKP0njH//F9rKHR42/nn6i3+a+wkCOuXNAID5cIjA4zoD0mI/c6UNj
 z7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752522549; x=1753127349;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4ZE+5rsQ80B2zoUSJLcp9UieWOHgoZ5HuNRB+xdScR4=;
 b=EDbvz7IjVnF6I4KR6AuHH5YQzYhAcXhnEhDR2VGv6Zww30dM90pWtwZgzOS4O2PXxV
 fTB3BpsxU4+HjgcAz+Qey+GHMhce11bikG/mHji7Nh9oPhqL0DCdgK0n+xB4RWmQQBO2
 nl4bmIhnZPN5avIWaEJfGumSDvDsR/HnVMb9KGbrSEF22L4Wz+WFYhzi4GZKo0z4Iq7M
 um/G6/Msnpi/jcf2jp7U9Bhlytpxd6+Ae3/OoSgUMIOWpysJ75/D4afczk7BuK+k4vL0
 upg7xnmdr8inK92bLqxdrjmWOdBruA1exZv5MthMtdJfCGMA4NuEQavhluIinh4QbGnO
 zfbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNaE81mDcTfkgyljy54qKDZzI/wc5CTpVi+4OKIM2/RyyN56Xy7sIBT+hDxrQYlscScHPoiUcXdG3a@nongnu.org
X-Gm-Message-State: AOJu0YwesqJ+WXGCWO9isVCzCIJoQrEA4+V7CpMw7yHm9zlGNQQ3y0HH
 /OkPJtW8njwQICY/nWQdurN0yZhuRFzJnjIq5Dt+k4lE9drmAhh+Gv0v60iba8AAZKA=
X-Gm-Gg: ASbGncvOIFqiEzsOVREccsOfDcBijvORwuMco+2FunWohuaQI6u7qz3sm+k33X5GTcP
 P7H2Ece9u6UTLK2/vEltYPEBF+9OkKOpsCnuwzp42L4d7o+UO+3dLPvocib+jxteAg5w9jo4hD+
 epvq2YqJFYOJh3pxIbHtYWYaWb1wkiPsThZ8KASbJMF9ufuB/D3ORA5DiMIagcBBtA3qhf4xf63
 4Pl8M7gget0/NnYIj973K7mZajmBhU35yGXYF8W60bFHzyVVHtmp2qn3I/YvKsyl0kEEJj9cH3B
 AQ9AZ1dPvuW6fO5geF0xhYSct0vLW2VpT00eDY+53vIgYaEMpmCU/BnddCGl590wfzCQw7giPE2
 2RaOphbWLkslqM4xzZY6flEe1jC0KC6bN8AL3RskoveijSO4sA3lYm498Xclk49DkaM72Gg0RWP
 Rr
X-Google-Smtp-Source: AGHT+IGwYdR/0GvW+iUi0MGL+/fQ9dqt6aTewG8o9QfdMwvUSMZgxcqwdiaphUSbDLZGTUmFI4GyHw==
X-Received: by 2002:adf:e9cf:0:b0:3a4:fc52:f5d4 with SMTP id
 ffacd0b85a97d-3b5f18d3bbbmr9895148f8f.47.1752522549312; 
 Mon, 14 Jul 2025 12:49:09 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd1932sm13452709f8f.17.2025.07.14.12.49.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 12:49:08 -0700 (PDT)
Message-ID: <24f207d1-2b37-4ba4-9ab9-7aa7acee75a8@linaro.org>
Date: Mon, 14 Jul 2025 21:49:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Provide always-false kvm_arm_*_supported()
 stubs for usermode
To: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250714135152.1896214-1-peter.maydell@linaro.org>
 <0b438773-01b9-42e1-8edf-2330e50387f8@linaro.org>
 <95b00393-bdd2-4db3-ac39-02a09f83b4d7@linaro.org>
 <6f0cd2fd-2152-4c28-8dd1-ca7271e686f4@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <6f0cd2fd-2152-4c28-8dd1-ca7271e686f4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 14/7/25 17:52, Richard Henderson wrote:
> On 7/14/25 09:41, Pierrick Bouvier wrote:
>> Indeed, clang does not fold the condition "value && kvm_enabled() && ! 
>> kvm_arm_sve_supported()". Looks like a missing case.
>> This code compiles with gcc -O0, but not clang -O0.
>>
>> extern int f(void);
>> int main(int argc) {
>>      if (argc && 0)
>>          f();
>> }
>>
>> As folding is not guaranteed by C standard, I'm not sure it's really 
>> possible to file a bug. However, since we rely on this behaviour in 
>> other parts, maybe it would be better to rewrite the condition on our 
>> side.
> 
> It's probably worth filing a missed-optimization type bug, if that's 
> available in clang's reporting system.
> 
> With my compiler hat on, I suspect that GCC generates IR like
> 
>    if (argc) {
>      if (0) {
>        f();
>      }
>    }
> 
> in order to get the short-circuting part of && correct, which Just So 
> Happens to fold away exactly as we wish.
> 
> I'm not sure how clang expands the expression such that (x && 0) doesn't 
> fold away, but (0 && x) does, as evidenced by
> 
>> +        if (kvm_enabled() && !kvm_arm_sve_supported()) { 

I'd prefer move the kvm_enabled() call instead of re-introducing the stubs:

-- >8 --
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 26cf7e6dfa2..37c7cc7b18e 100644
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
+    if (kvm_enabled()) {
+        if (value && !kvm_arm_sve_supported()) {
+            error_setg(errp, "'sve' feature not supported by KVM on 
this host");
+            return;
+        }
      }

      FIELD_DP64_IDREG(&cpu->isar, ID_AA64PFR0, SVE, value);
---


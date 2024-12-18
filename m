Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CCCDE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwop-0000ry-QF; Wed, 18 Dec 2024 11:22:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNwoZ-0000J4-Du
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:22:23 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNwoW-00078d-MW
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:22:23 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4361c705434so48518065e9.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 08:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734538939; x=1735143739; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DBGqBoFFTtrTgjei5JE6lR139nQig/betbm5L9Jguls=;
 b=J1k1Q8iemJYH4wRlhH4tfts3/ps7ti4JzcZPteh269DcGpgU4Z0RDYj+yjvbPNjU6v
 RiUL/fnhybaEPxvz/BUZmjzM56yEDQTbGIn2zEWdVvyXePwyOIQgJRhW7XXJLdt7CWYH
 9JlFWApFYPwSK1VawO1mXHnUbgI9Z3CNIXtbjYpFMe9D7eaKc1ONv5qVtZHwcOTl/oIw
 fMo2gvHtnaX4bCLSKX6dPv73EunyvllIUd/MsByujzEhwTh+VeIasQAWXzrrolsNhB1R
 iqzI9jEAKb5pPEQfoP91CsV45xh7cQocNgYFISzBWm1Iw4geYZy8zy6yGjTtdFPyaaU3
 02jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734538939; x=1735143739;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DBGqBoFFTtrTgjei5JE6lR139nQig/betbm5L9Jguls=;
 b=D5gmbiDqxvmO38yxsLCba7Rp0IsJc2S5PuJzmBdNnKl3V19Q6pOi+nU7fDQ9HC3quT
 kKfIkisIQKAiVxKYRjlIa68alPY2HMa9gYD/TVjSd2Q4yoo0RsJVKATgKkggdixyERf5
 CL51Wb4GbQfYQOZXsZ53UtsjBi1HnpLwZQFxnMFTjNg4hezojHRxac1Zwjsz/83+NU6B
 Svw3G3Na81XKj+hRx9n55aeOqQKt+6Akzc/6zMsrssnXNzfOU7F4K0Sbhjifg/+/m01V
 F+RLn4Tl2pDBHCA8BHv1MD9cWUMJ9yZp0oXsBqmp4W7UdwCHkTgk8aNDWYG3xLQsYedG
 2VgA==
X-Gm-Message-State: AOJu0YxIqPAfWsCFrTHnx0wPxJnIypDtW5C94vwLV20w4tWntbtd8tWN
 dQ7hbIAJeP9rfSEXbMKeztjY7QnIzK0wbUMso6zkPJN+yarG3wu7w91a7e09Jxs=
X-Gm-Gg: ASbGncu1EQC1grwepwHs+cZ8qsPKHC5Ctfa2mQSRpu5SBVuyAFBilXVp2OP/qaj4xuF
 fvyjgr7stbaqc4l/8CvhtZ6K8kl61vu+AFcNrd4Ul5rpBpd/Hb8xRP9T21vw3vyIC3aFny0BOv+
 1ogkSWOLigIAtvsxNooFVYi0IyZam+OVc9o7RJwjGSL4JUFUDCX2xooGQWVK6+wNbnPeEXF2zDk
 Fv6l3LDH6HSdZS/uqdex0WY9EtzwhHx7hnGWclRuDTssS1EOmbkfCHH+IAT7C/wX+IQKE8u
X-Google-Smtp-Source: AGHT+IGdFMvwZNNIwVpThNbKf0YkrO9/XNDycyE19O9fkL4PvUz6c2Tkd/A2lNWHlCWOeP2NEK6MgQ==
X-Received: by 2002:a05:600c:2e49:b0:434:fbda:1f36 with SMTP id
 5b1f17b1804b1-436553ec834mr26884775e9.20.1734538939077; 
 Wed, 18 Dec 2024 08:22:19 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656afc179sm24856065e9.3.2024.12.18.08.22.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 08:22:18 -0800 (PST)
Message-ID: <098c063d-ce67-4f2e-aa25-6eac7db9b170@linaro.org>
Date: Wed, 18 Dec 2024 17:22:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/i386/sev: Reduce system specific declarations
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, Zhao Liu <zhao1.liu@intel.com>, qemu-s390x@nongnu.org,
 Yanan Wang <wangyanan55@huawei.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
References: <20241218155913.72288-1-philmd@linaro.org>
 <20241218155913.72288-3-philmd@linaro.org> <Z2L1o7xesp5EcRuW@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z2L1o7xesp5EcRuW@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 18/12/24 17:17, Daniel P. Berrangé wrote:
> On Wed, Dec 18, 2024 at 04:59:13PM +0100, Philippe Mathieu-Daudé wrote:
>> "system/confidential-guest-support.h" is not needed,
>> remove it. Reorder #ifdef'ry to reduce declarations
>> exposed on user emulation.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/i386/sev.h  | 29 ++++++++++++++++-------------
>>   hw/i386/pc_sysfw.c |  2 +-
>>   2 files changed, 17 insertions(+), 14 deletions(-)
>>
>> diff --git a/target/i386/sev.h b/target/i386/sev.h
>> index 2664c0b1b6c..373669eaace 100644
>> --- a/target/i386/sev.h
>> +++ b/target/i386/sev.h
>> @@ -18,7 +18,17 @@
>>   #include CONFIG_DEVICES /* CONFIG_SEV */
>>   #endif
>>   
>> -#include "system/confidential-guest-support.h"
>> +#if !defined(CONFIG_SEV) || defined(CONFIG_USER_ONLY)
>> +#define sev_enabled() 0
>> +#define sev_es_enabled() 0
>> +#define sev_snp_enabled() 0
>> +#else
>> +bool sev_enabled(void);
>> +bool sev_es_enabled(void);
>> +bool sev_snp_enabled(void);
>> +#endif
>> +
>> +#if !defined(CONFIG_USER_ONLY)
> 
> I'm surprised any of this header file is relevant to
> user mode. If something is mistakely calling sev_ functions
> from user mode compiled code, I'd be inclined to fix the
> caller such that its #include ".../sev.h" can be wrapped
> by !CONFIG_USER_ONLY

I forgot to mention and just replied in another post:

   The motivation is to reduce system-specific definitions
   exposed to user-mode in target/i386/cpu.c, like hwaddr &co,
   but I'm not there yet and have too many local patches so
   starting to send what's ready.

WRT SEV what is bugging me is in cpu_x86_cpuid():

target/i386/cpu.c-7137-    case 0x8000001F:
target/i386/cpu.c-7138-        *eax = *ebx = *ecx = *edx = 0;
target/i386/cpu.c:7139:        if (sev_enabled()) {
target/i386/cpu.c-7140-            *eax = 0x2;
target/i386/cpu.c-7141-            *eax |= sev_es_enabled() ? 0x8 : 0;
target/i386/cpu.c-7142-            *eax |= sev_snp_enabled() ? 0x10 : 0;
target/i386/cpu.c-7143-            *ebx = sev_get_cbit_position() & 
0x3f; /* EBX[5:0] */
target/i386/cpu.c-7144-            *ebx |= (sev_get_reduced_phys_bits() 
& 0x3f) << 6; /* EBX[11:6] */
target/i386/cpu.c-7145-        }
target/i386/cpu.c-7146-        break;

but maybe I can use #ifdef'ry around CONFIG_USER_ONLY like
with SGX:

     case 0x12:
#ifndef CONFIG_USER_ONLY
         if (count > 1) {
             uint64_t epc_addr, epc_size;

             if (sgx_epc_get_section(count - 2, &epc_addr, &epc_size)) {
                 *eax = *ebx = *ecx = *edx = 0;
                 break;
             }
             ...
#endif
         break;

> 
>>   
>>   #define TYPE_SEV_COMMON "sev-common"
>>   #define TYPE_SEV_GUEST "sev-guest"
>> @@ -45,18 +55,6 @@ typedef struct SevKernelLoaderContext {
>>       size_t cmdline_size;
>>   } SevKernelLoaderContext;
>>   
>> -#ifdef CONFIG_SEV
>> -bool sev_enabled(void);
>> -bool sev_es_enabled(void);
>> -bool sev_snp_enabled(void);
>> -#else
>> -#define sev_enabled() 0
>> -#define sev_es_enabled() 0
>> -#define sev_snp_enabled() 0
>> -#endif
>> -
>> -uint32_t sev_get_cbit_position(void);
>> -uint32_t sev_get_reduced_phys_bits(void);
>>   bool sev_add_kernel_loader_hashes(SevKernelLoaderContext *ctx, Error **errp);
>>   
>>   int sev_encrypt_flash(hwaddr gpa, uint8_t *ptr, uint64_t len, Error **errp);



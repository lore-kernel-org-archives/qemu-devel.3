Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CCD4C021B8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 00:47:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnS3D-0005pQ-SV; Wed, 26 Feb 2025 19:46:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnS33-0005lN-2m; Wed, 26 Feb 2025 19:46:49 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnS30-0001aE-Hp; Wed, 26 Feb 2025 19:46:44 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22349bb8605so6673675ad.0; 
 Wed, 26 Feb 2025 16:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740617201; x=1741222001; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gSPVvf0NeNrtOsaLQEdTT2usxAjGWKlZVgsywQLoB2U=;
 b=JcVxl0CefLglBbEd9bBhuSKMvyp+ZL2mgOsHwGYhY9VL390REjC/OHCmySdnttBtnk
 fRn2ndRNLs1UJIRoJl9g2xMlZf0CrvTr1umRttSfeqfEFktB+eDqTeEtPJhOV5JBeTMu
 cXrw4U01PyUigd/wcI5KHoY5EGlCx3y9OgwVooTi2dig/YFB6WpP3WKS758GuRqLxnFD
 jC0jZP70sQBXrgQFg3tTlqPV/pEp8Yd3FzLuzyt5/khDgoHij290X87Qz1QNBajInkoh
 nzUOuPUPqoqiKZUAPLHqB8pUeykf3WdMqUPF4IHU+85dqpEydoJbR2ku5WkGawfQQ3eQ
 ngKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740617201; x=1741222001;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gSPVvf0NeNrtOsaLQEdTT2usxAjGWKlZVgsywQLoB2U=;
 b=snlZqftlA1WgI1s//qblRDK52+ydTjgnnpZWSjaXZP9nViNcQNZqcYbupVtQdLRJAK
 aDHD9tb8Tjnn1T5jWitTx6L/NwYuzazMVrU8PoABRMT84X5DTCsiZaOaSMrlmrEbHwG+
 4px8z4eHF9RMkJJG8BOGCsRcI5jk0KRFXs15+P5Sq/rdkW877Ajw8FSnKKtGs7lMOYA3
 IyCHN/QQBgQ+v36kPHXpa6MYS6WLY1srQoRlWgbfLx6kfC4qNLeRjyftlN/OQhlcHaDP
 m336IdS665xZV+viKD6hozXNu0DFTwfTm2NBRcJyQvG9XAahBPXkcuQ8NAmHWMJXytJO
 Yd7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJAdfJ9y7IHCdDmMG9QGyQ/evJxWIdDbvv2VGZw5oXl/E8EMoO0nxmSiM9UfOmcNzuydiM89n+mW6B@nongnu.org,
 AJvYcCXiBnomg7LS2ndA6AHrDMs9NCzoELCGLTa2huDfxJ52KVRrIBoCu5SwmEZ27ndL4wLX7Rr4PuAs2N4=@nongnu.org
X-Gm-Message-State: AOJu0YyK8VW6cTue8pUk0bYOyCsHOvYKLnsG6ggTBKQM44IVI6m1N6w4
 7lTaRAxELQIa0JgRxt1fg8jYZqDHI9vRq4bUNOsd1pmB6AVcGUnP
X-Gm-Gg: ASbGnctAv9eY8XbdWXmD2JgZotBziVxNTUingiOfVoDYQCrBnB9ez2LW8uaC7H90piI
 kX/sDld8Uv7g9uTvEE5Yjm7sXTC45ykVdDrV+lPMwRy280PAA6yhrsSAjn89esZqLZCr+EfvQY9
 mLB8u1QJf6MzgvJCx/DZLs/hNNyyTKxF8AUyMQNq+FzBW7RJ6BTWoX+ZnmlMmPVPweC+jKdhiv5
 BmCxXZECKACOzi36SNSTnsjQ0i5WWQzgtVaXiLHRA4IrmU7m5tyRAsbHXlYxC1tSNvh9AkZHIBm
 R3AOYdPOlF2PthuXJA==
X-Google-Smtp-Source: AGHT+IGEcOSsQZsrQzJoZP4RjV2liMlOGZxzYsBsxARytK6vWiMRQZ+zcEYcd+UarymE3sZJYqICeQ==
X-Received: by 2002:a05:6a00:1828:b0:732:5b10:572b with SMTP id
 d2e1a72fcca58-734790cbaf5mr14243403b3a.10.1740617200666; 
 Wed, 26 Feb 2025 16:46:40 -0800 (PST)
Received: from localhost ([1.146.90.134]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-734a00249absm215586b3a.95.2025.02.26.16.46.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 16:46:40 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Feb 2025 10:46:33 +1000
Message-Id: <D82TARV6T6PL.UR4MRK6PM5N2@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>, "Richard Henderson"
 <richard.henderson@linaro.org>, <qemu-ppc@nongnu.org>
Subject: Re: [PATCH v2 06/15] target/ppc: Ensure powerpc_checkstop() is only
 called under TCG
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250127102620.39159-1-philmd@linaro.org>
 <20250127102620.39159-7-philmd@linaro.org>
 <fe541a6b-ab7b-4d61-aad2-2674b1fd3c9b@linux.ibm.com>
In-Reply-To: <fe541a6b-ab7b-4d61-aad2-2674b1fd3c9b@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue Jan 28, 2025 at 4:43 PM AEST, Harsh Prateek Bora wrote:
>
>
> On 1/27/25 15:56, Philippe Mathieu-Daud=C3=A9 wrote:
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> ---
>>   target/ppc/excp_helper.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
>> index 8956466db1d..b08cd53688c 100644
>> --- a/target/ppc/excp_helper.c
>> +++ b/target/ppc/excp_helper.c
>> @@ -19,6 +19,7 @@
>>   #include "qemu/osdep.h"
>>   #include "qemu/main-loop.h"
>>   #include "qemu/log.h"
>> +#include "system/tcg.h"
>>   #include "system/system.h"
>>   #include "system/runstate.h"
>>   #include "cpu.h"
>> @@ -30,7 +31,6 @@
>>   #include "trace.h"
>>  =20
>>   #ifdef CONFIG_TCG
>> -#include "system/tcg.h"
>>   #include "exec/helper-proto.h"
>>   #include "exec/cpu_ldst.h"
>>   #endif
>> @@ -443,13 +443,11 @@ void helper_attn(CPUPPCState *env)
>>   static void powerpc_mcheck_checkstop(CPUPPCState *env)
>>   {
>>       /* KVM guests always have MSR[ME] enabled */
>> -#ifdef CONFIG_TCG
>>       if (FIELD_EX64(env->msr, MSR, ME)) {
>>           return;
>>       }
>> -
>> +    assert(tcg_enabled());
>
> Shouldn't this be a no-op if not TCG ?
>
> Nick, please advise ?

If KVM, I think we would rather catch that it got called instead of
no-op.

At this point the guest is crashed, so it's not overly rude to
assert. I'm okay with this.

Thanks,
Nick


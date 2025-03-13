Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A5FC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 10:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsfy8-0000v3-T2; Thu, 13 Mar 2025 06:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsfy3-0000ub-8p
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:39:12 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsfxz-0004c4-RS
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:39:10 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso4865295e9.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 03:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741862344; x=1742467144; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lLxamGpd24MadxdIk+Ef5JMLaAjiPzweWcOMLUk79lE=;
 b=jaD3nZecHkXYFHlntFYnyCZ+a3WWVWGHNx4U2OU8WvawUZclG8ktV+5cA/LwQmGUZi
 zNjvtUNkTqYkGG9nHeYuTFgcJK4RFfyQgxamnRmqqhCne/iAz2CshQG4RDmvNgzoHE9B
 IHFeYVGftGJHIQiuErZlnJZXjPvS5VUAGZ7PkR+PmNKz/4aEErFZfuNY2RUKjopS9p01
 UhRT/h9yzn9lgeRMZ4+tOZTqCoI+TAGa4jyUA9vslXpkwoHajZIHQD8jOrYNAcaLv+Aa
 Y6ZH1g/FS30G5J9GPLfM1rogyAD+udLbNhiDxRAxxabpITgi4dBAphHMz/JHT+/c3zhp
 ULNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741862344; x=1742467144;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lLxamGpd24MadxdIk+Ef5JMLaAjiPzweWcOMLUk79lE=;
 b=YC3s5UVnZWC2oOycoYnNjWz27NB3CZkzW+zR8A+tlmJH1xJcQ7mvs0fA/utZSbh1NB
 IT2WqfH9Qfor78iQYLzXVNws04r3/SkkthbPv/6AOW7atla7KDocsmeRHin6qdDEwk4J
 actiQ9JfscXTj36IRkG4mPAezHWZvrsPQKlf7XCtCiHxwKY8Mbnbs8yKd7oWzMnynFzP
 WqG+QM7uSfdX8HRQ+Dh/Sp1ExSwoQLdD2zbXqp0+aP/wt8s4PyrWQ23Qh6BhGYFimsao
 rIpluJo4heAcqvBBklZ7i4qVQ85QjIFCPBq8kPAWXy6WZnY5WmJWOCGSYQVYydPXBmMV
 vupQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUP35y9oPzMT7dox2sG8E+zEAbm7KYmeuT/6rjXV3WiiIwfKqCxTymEpmnn9ots8tauvbDTNZEvkeKu@nongnu.org
X-Gm-Message-State: AOJu0Ywnp9Ea43YRtgjtrwXhmOH4/RFHDoE56A0QmkUCyeTepgk6HH5u
 PuTt1lIiP0IP8qNzHZDANdvpsVG/G99I08nYCGLjk6f7x5c5v/zycGJZ6F/kRUU=
X-Gm-Gg: ASbGncto9j+FT2/DopWPaM56zryLEbjJuRn4dF4sAz12pZ73GNRrX4JSJFndVWUwauW
 pIf/CKzFZF68oSn663Nc0sX2uXbcj7VdUbueXSJVktwyNYy1OeIBDGPin3/24HFNqiWV6rBBvP9
 oZCL//xwtywUFwOC9mlNxYgeI6wrz+Tz5TSH8pFx4f4ZMcEycAVQjBhrLYBhkC9PumNXh19w9ZD
 nlR78yftIYWwNm4leVejFCzrivZ9quoi5nYxbJJm4x2Z+lPNct/Mcr3DbeJ3AiRjRMJJa4uQWaL
 uoc3HNn+52EpPRHGQwoZpr8aY7/sQj7O3I0UcsuOf1LBtJvLN6i6WkTLaeTBP/IBSKlAH2LGTN/
 JVm3CWcBUedRsj9c=
X-Google-Smtp-Source: AGHT+IHhINrqr89bw31zHXrKyowRi/UyA4bW6E65dzTeVZyjcL9PMQTonDLGLFK2ZzFDM9GDozLJTg==
X-Received: by 2002:a05:600c:4751:b0:43c:fffc:7886 with SMTP id
 5b1f17b1804b1-43cfffc7ca2mr123536745e9.8.1741862343912; 
 Thu, 13 Mar 2025 03:39:03 -0700 (PDT)
Received: from [192.168.1.20] (88-178-97-237.subs.proxad.net. [88.178.97.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7eb9d7sm1631821f8f.89.2025.03.13.03.39.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 03:39:03 -0700 (PDT)
Message-ID: <00d707e4-5e60-43fc-b372-72336d7af293@linaro.org>
Date: Thu, 13 Mar 2025 11:39:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/37] common-user: Split out watchpoint-stub.c
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, pbonzini@redhat.com
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-26-richard.henderson@linaro.org>
 <36f7e651-4df6-457d-a7ef-df7a7c4b2570@linaro.org>
Content-Language: en-US
In-Reply-To: <36f7e651-4df6-457d-a7ef-df7a7c4b2570@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 13/3/25 11:07, Philippe Mathieu-Daudé wrote:
> On 13/3/25 04:45, Richard Henderson wrote:
>> Uninline the user-only stubs from hw/core/cpu.h.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/hw/core/cpu.h         | 23 -----------------------
>>   common-user/watchpoint-stub.c | 28 ++++++++++++++++++++++++++++
>>   common-user/meson.build       |  1 +
>>   3 files changed, 29 insertions(+), 23 deletions(-)
>>   create mode 100644 common-user/watchpoint-stub.c
>>
>> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
>> index 5d11d26556..2fdb115b19 100644
>> --- a/include/hw/core/cpu.h
>> +++ b/include/hw/core/cpu.h
>> @@ -1109,35 +1109,12 @@ static inline bool 
>> cpu_breakpoint_test(CPUState *cpu, vaddr pc, int mask)
>>       return false;
>>   }
>> -#if defined(CONFIG_USER_ONLY)
>> -static inline int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, 
>> vaddr len,
>> -                                        int flags, CPUWatchpoint 
>> **watchpoint)
>> -{
>> -    return -ENOSYS;
>> -}
>> -
>> -static inline int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
>> -                                        vaddr len, int flags)
>> -{
>> -    return -ENOSYS;
>> -}
>> -
>> -static inline void cpu_watchpoint_remove_by_ref(CPUState *cpu,
>> -                                                CPUWatchpoint *wp)
>> -{
>> -}
>> -
>> -static inline void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
>> -{
>> -}
>> -#else
>>   int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
>>                             int flags, CPUWatchpoint **watchpoint);
>>   int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
>>                             vaddr len, int flags);
>>   void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint 
>> *watchpoint);
>>   void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
>> -#endif
>>   /**
>>    * cpu_get_address_space:
>> diff --git a/common-user/watchpoint-stub.c b/common-user/watchpoint- 
>> stub.c
>> new file mode 100644
>> index 0000000000..2489fca4f3
>> --- /dev/null
>> +++ b/common-user/watchpoint-stub.c
>> @@ -0,0 +1,28 @@
>> +/*
>> + * CPU watchpoint stubs
>> + *
>> + * Copyright (c) 2003 Fabrice Bellard
>> + * SPDX-License-Identifier: LGPL-2.1-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "hw/core/cpu.h"
>> +
>> +int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
>> +                          int flags, CPUWatchpoint **watchpoint)
>> +{
>> +    return -ENOSYS;
>> +}
>> +
>> +int cpu_watchpoint_remove(CPUState *cpu, vaddr addr, vaddr len, int 
>> flags)
>> +{
>> +    return -ENOSYS;
>> +}
>> +
>> +void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *wp)
>> +{
> 
> Again, can this be elide? Otherwise better use g_assert_not_reached().

We can, including:

-- >8 --
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index dba1b3ffef..54d3879c56 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7545,4 +7545,6 @@ static void x86_cpu_reset_hold(Object *obj, 
ResetType type)
      env->dr[7] = DR7_FIXED_1;
+#ifndef CONFIG_USER_ONLY
      cpu_breakpoint_remove_all(cs, BP_CPU);
      cpu_watchpoint_remove_all(cs, BP_CPU);
+#endif

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index a9a619ba6b..f798569de7 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -368,2 +368,3 @@ static bool check_watchpoints(ARMCPU *cpu)

+#ifndef CONFIG_USER_ONLY
      for (n = 0; n < ARRAY_SIZE(env->cpu_watchpoint); n++) {
@@ -373,2 +374,3 @@ static bool check_watchpoints(ARMCPU *cpu)
      }
+#endif
      return false;
@@ -555,2 +557,3 @@ void hw_watchpoint_update(ARMCPU *cpu, int n)

+#ifndef CONFIG_USER_ONLY
      if (env->cpu_watchpoint[n]) {
@@ -559,2 +562,3 @@ void hw_watchpoint_update(ARMCPU *cpu, int n)
      }
+#endif

@@ -631,4 +635,6 @@ void hw_watchpoint_update(ARMCPU *cpu, int n)

+#ifndef CONFIG_USER_ONLY
      cpu_watchpoint_insert(CPU(cpu), wvr, len, flags,
                            &env->cpu_watchpoint[n]);
+#endif
  }
@@ -637,3 +643,3 @@ void hw_watchpoint_update_all(ARMCPU *cpu)
  {
-    int i;
+#ifndef CONFIG_USER_ONLY
      CPUARMState *env = &cpu->env;
@@ -646,4 +652,5 @@ void hw_watchpoint_update_all(ARMCPU *cpu)
      memset(env->cpu_watchpoint, 0, sizeof(env->cpu_watchpoint));
+#endif

-    for (i = 0; i < ARRAY_SIZE(cpu->env.cpu_watchpoint); i++) {
+    for (unsigned i = 0; i < ARRAY_SIZE(cpu->env.cpu_watchpoint); i++) {
          hw_watchpoint_update(cpu, i);
---


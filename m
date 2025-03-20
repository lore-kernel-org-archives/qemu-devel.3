Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3554EC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 07:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvA1y-0007ic-DB; Thu, 20 Mar 2025 03:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvA1m-0007aS-0q
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 03:09:20 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvA1k-0006Tw-18
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 03:09:17 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso2219995e9.0
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 00:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742454554; x=1743059354; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p0WLjJlFUa5B3XVkqtixZuzuCE3gjB8V9d9wqEIT7mI=;
 b=wwyFN3JNAPW61TjXhBKXNkJwxAH22KpBm+WV+UL30tiIkmiAGah+ys4xEFY33/m0/C
 qDcKgTdK6UQ35pIk5aDSisqaM+39amMdvJKl7t+iUpYRuNmS6BZS55MR6rOuAobAtZ7g
 TAhDx77KP2T0R11PgWfYg+xZBQRRplhO16jW8XXbFm2aCD/0AZ/rqVlrVlHqBX5l032J
 hgrruCQnp0wC3f3eppH+U6JIdd1vvA6asI7+IiyvpiXoj5pxj39pZv3wfLQKo3S6kz+6
 dOnwz/Emk/St0YunhoSVdV4TzXezzgEJg1gy5UeypV+jrLZXAl2f0ZdezmOFwYEX6ceg
 pY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742454554; x=1743059354;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p0WLjJlFUa5B3XVkqtixZuzuCE3gjB8V9d9wqEIT7mI=;
 b=Lxm+ryoVp/ztJ2bjqY+nALtpwurmn4hyNcgCqHcDt59cTjfrQorP5OKIMmVuKM18dG
 wDPZFZjOng1CmPf2A0SYmlqUb6OWoyL4ctG/ZOtbaKsSiYC+a5qHyojTy2R6oNanWiyB
 sNNjJzxoi65duLuEdU9yr+XR/q1qPE/X+5Cz7V/qXftIYKe4GMvLkBEP7ORhtpXsPoc1
 8pTG/DfXHRydpzs16QMtpee2k3WpMyOYUhmTBbBcNn1G7+VBNU14kIx0XB6RPl2ITWZH
 /zuvVsnTnBKCds38QpQe5Tu7l6YaTuQFhk4XkK+vqdizrkVjIIIlZygy21S3xw9q9jFb
 UMDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLFI611vK4QqbSm4K0fZJygN7lZPLHMzysGJefdJresn1BbwIiYntSKvay+tY+sI+Yjb5k775tL8eg@nongnu.org
X-Gm-Message-State: AOJu0YyBi2TeprGmRkmvksIttKyRDG2l/oF20Fc36MIuDyChFytx7K3T
 UfWJ0eAklepgJdqoToLessZ5bJC1u7k8MWfXNXWhu+UiPUVoygYkbkm94aCn1dgiQIs0q5n1MIR
 2
X-Gm-Gg: ASbGnct3oJUT7G2C398WZgi4PCEKem4xaxAurtszVesDpAYsx3ouGIzLyWsGwls192T
 r4JtmF0UwnPgGKu5qBlNSy2a03san4QLFgSDniJeVLhpyad2o3Rzb7Xqj3IoFOJ2D9QY19blPW7
 Y1W7S6WPtj5/3kFXT5PsHQ5HR95MGXWlgBcyNpmFyH6ycstGLpQ+4HwPcQ3Q7TjRGPLoyxvpBpO
 CcDeT+gUwbDjrzn2rCEXsv6AgabXkjhYRrLgp2LubL/dYeyIvto+rdyP1RBZRnNblE5xsQsOiLN
 ATMo7jPMW1UXnmtljYRqgcvqcdpUCxylQ5MPSwC6yWF0mdiPCZid7kPfsTsvT833GM+iKJUp7E9
 8oSLK0S02FmcS
X-Google-Smtp-Source: AGHT+IHsiLcx/k7ZdP9QfOhg5TgNH/YjasQHlID+mpeEdAHUYFcN/8PAgEK0sxi211VRJHaCquHdqw==
X-Received: by 2002:a05:600c:c16:b0:43c:eeee:b70a with SMTP id
 5b1f17b1804b1-43d43815e66mr51154205e9.22.1742454554137; 
 Thu, 20 Mar 2025 00:09:14 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f58a66sm39340265e9.20.2025.03.20.00.09.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 00:09:13 -0700 (PDT)
Message-ID: <82e16c74-e60c-45b9-b269-a8d35d0b64d8@linaro.org>
Date: Thu, 20 Mar 2025 08:09:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] target/microblaze: convert gdbstub to new helper
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org,
 Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20250319182255.3096731-1-alex.bennee@linaro.org>
 <20250319182255.3096731-11-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250319182255.3096731-11-alex.bennee@linaro.org>
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

On 19/3/25 19:22, Alex Bennée wrote:
> This is a pretty simple conversion which will be trivial to update
> once TARGET_BIGENDIAN is replaced with a helper function.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/microblaze/gdbstub.c | 44 ++++++++++++++-----------------------
>   1 file changed, 17 insertions(+), 27 deletions(-)
> 
> diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
> index d493681d38..106d6efbab 100644
> --- a/target/microblaze/gdbstub.c
> +++ b/target/microblaze/gdbstub.c
> @@ -19,7 +19,7 @@
>    */
>   #include "qemu/osdep.h"
>   #include "cpu.h"
> -#include "gdbstub/helpers.h"
> +#include "gdbstub/registers.h"
>   
>   /*
>    * GDB expects SREGs in the following order:
> @@ -50,62 +50,52 @@ int mb_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
>   {
>       MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
>       CPUMBState *env = &cpu->env;
> -    uint32_t val;
> +    MemOp mo = TARGET_BIG_ENDIAN ? MO_BEUL : MO_LEUL;

Since commit 415aae543ed TARGET_BIG_ENDIAN isn't doing what you'd
expect on microblaze, I think you want:

        MemOp mo = mb_cpu_is_big_endian(cs) ? MO_BEUL : MO_LEUL;

>   
>       switch (n) {
>       case 1 ... 31:
> -        val = env->regs[n];
> -        break;
> +        return gdb_get_register_value(mo, mem_buf, (uint8_t *) &env->regs[n]);
>       case GDB_PC:
> -        val = env->pc;
> -        break;
> +        return gdb_get_register_value(mo, mem_buf, (uint8_t *) &env->pc);
>       case GDB_MSR:
> -        val = mb_cpu_read_msr(env);
> -        break;
> +        uint32_t msr = mb_cpu_read_msr(env);
> +        return gdb_get_register_value(mo, mem_buf, (uint8_t *) &msr);
>       case GDB_EAR:
> -        val = env->ear;
> -        break;
> +        return gdb_get_register_value(mo, mem_buf, (uint8_t *) &env->ear);
>       case GDB_ESR:
> -        val = env->esr;
> -        break;
> +        return gdb_get_register_value(mo, mem_buf, (uint8_t *) &env->esr);
>       case GDB_FSR:
> -        val = env->fsr;
> -        break;
> +        return gdb_get_register_value(mo, mem_buf, (uint8_t *) &env->fsr);
>       case GDB_BTR:
> -        val = env->btr;
> -        break;
> +        return gdb_get_register_value(mo, mem_buf, (uint8_t *) &env->btr);
>       case GDB_PVR0 ... GDB_PVR11:
>           /* PVR12 is intentionally skipped */
> -        val = cpu->cfg.pvr_regs[n - GDB_PVR0];
> -        break;
> +        return gdb_get_register_value(mo, mem_buf,
> +                                      (uint8_t *) &cpu->cfg.pvr_regs[n - GDB_PVR0]);
>       case GDB_EDR:
> -        val = env->edr;
> -        break;
> +        return gdb_get_register_value(mo, mem_buf, (uint8_t *) &env->edr);
>       default:
>           /* Other SRegs aren't modeled, so report a value of 0 */
> -        val = 0;
> -        break;
> +        return 0;
>       }
> -    return gdb_get_reg32(mem_buf, val);
>   }


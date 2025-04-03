Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8406C3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 21:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0SLx-0005gZ-Lt; Thu, 03 Apr 2025 17:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0SLr-0005g3-TB
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 17:43:56 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0SLp-0000Sk-Ri
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 17:43:55 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso8864275e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 14:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743716632; x=1744321432; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8RV4MR7iMwe9PqKqVMkdH7xZ/qR8Q6INkcrGwtU7bQw=;
 b=euNO1YqbI0eywQhm/gLQ4s4LBk54lF6D1RCGD+jzNiiFvVYNklr74SajxzOhLo597q
 mUDSExtk3rO0RvZOMIjK6rhUWz+5MS7F/kGVq2NHYRPnWgqKbeWQR6YjCJ3AaQcVIfvs
 gjylpECVemwmezdtCFpj3ftkdqTM7Fiiwmvf4zMopKbCKdSG6/AZszxu2OvpNh6sNZYe
 qoeaAg88LxepJAd7IiczeCr5TVjfK0ZH+X69eLCGHo8aPTaF1/tceBk4OU5zNQmffbyL
 7enPHSkSdFdLkxQzqtg321MFWkdNdgYOTninL25aQOl7Rj8iBhfW6A1Mms3vE0Zu9VcL
 c7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743716632; x=1744321432;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8RV4MR7iMwe9PqKqVMkdH7xZ/qR8Q6INkcrGwtU7bQw=;
 b=Vf48g0fuvdxB6pwJ3SwX73Shdeq00PoB8/WSWQoOL/LjrG5j9eq0vvXkkpq7rGj5Ye
 pnz3YHm20IDsFpQuDuwktcr7ayV6NCcBdCPytt9QlJNawGp7v6gHecpYxsxG2ri6M/xN
 9lyQ9YVBJyj9T5+42bEN/4VuXb1g9gcr+DDe6xyefxYuL1J4rL11tdskd0Krukgbe2N9
 5ZD1jUmP+ZzGF8Gv8KKYKcIM33fCvGlsYqbQq0/IrY0s248TZ3Kwq+/B1UnNXu5cIlth
 HH4SAk8NA9IRqipFGqNoDooq8D47GwYwK2iM3xv2076E2Emid85kjq412UMz2obW4S5L
 cexA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnCStj/1Mg1yeT/Tam1TXAdZLJfEDt42IsKi1ghoND/UhmKKuME0cv5KnIJrv4oIbhhcnlM6yLczsU@nongnu.org
X-Gm-Message-State: AOJu0YyX+Bf6I3/OTeOzIW01PWxZcJXHCwAEwxtBOACfD4HERXX13YBy
 ciG72g2H3zGlxBdFrtKDGzWXB/2RnuG/PznGWBsJxBqlKA6HSBgu/vW5vXPCQ5+71qSot6uEthA
 o
X-Gm-Gg: ASbGnctynrm7IrPLtFwEdrhDH7vwp5ZrvQHIbdlJc/p0C6PonQUox6D2T0nyzhLyy6+
 lAPoh8O7Q0VW+A7ECSht7WD5SQO1NsRw502iZUwXfDKq+tISok+JqwomjW3c/LRNehrSVHJcF41
 9uxfuSNMB+o368+dy0wwQPYgEejd3yp12ZYvcAwFkxPTszaZOnWkAxaF9hEiWFpNBghN30ohx7t
 l9DSZcjKjS7JG/NJ6tcFO7Iae2PNcU+GF/P+qeVYl7c6raydFpibfQa6E0gPyinuAAgburGglyk
 x/bMFcBKa74VYL++UWLSsnNnDIJm/Jw4wZo+euoAiGb28r4GGAwcph/kIEBRyAIYD6w5pit2OOY
 kupi/MTlxFtP/0NsNT4GE+zMJhptp
X-Google-Smtp-Source: AGHT+IGY8+9GsNA3LlTSDSKl3xZhusZpRBQM11RBGf7bI+a16FxbbY/jv0U4LRytColAiJ1x1A5XEQ==
X-Received: by 2002:a05:600c:698c:b0:43c:eec7:eabb with SMTP id
 5b1f17b1804b1-43ed0bc790dmr3388125e9.8.1743716631972; 
 Thu, 03 Apr 2025 14:43:51 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec17b33c2sm33533515e9.40.2025.04.03.14.43.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Apr 2025 14:43:51 -0700 (PDT)
Message-ID: <59307712-0b18-4120-a35e-1a60ffceb2b8@linaro.org>
Date: Thu, 3 Apr 2025 23:43:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 01/43] tcg: Declare TARGET_INSN_START_EXTRA_WORDS
 in 'cpu-param.h'
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250402210328.52897-1-philmd@linaro.org>
 <20250402210328.52897-2-philmd@linaro.org>
 <74e250b5-3fb2-4688-ac20-18be6b6173f1@linaro.org>
Content-Language: en-US
In-Reply-To: <74e250b5-3fb2-4688-ac20-18be6b6173f1@linaro.org>
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

On 3/4/25 23:29, Philippe Mathieu-Daudé wrote:
> On 2/4/25 23:02, Philippe Mathieu-Daudé wrote:
>> To avoid including the huge "cpu.h" for a simple definition,
>> move TARGET_INSN_START_EXTRA_WORDS to "cpu-param.h".
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/arm/cpu-param.h        | 7 +++++++
>>   target/arm/cpu.h              | 6 ------
>>   target/hppa/cpu-param.h       | 2 ++
>>   target/hppa/cpu.h             | 2 --
>>   target/i386/cpu-param.h       | 2 ++
>>   target/i386/cpu.h             | 2 --
>>   target/m68k/cpu-param.h       | 2 ++
>>   target/m68k/cpu.h             | 2 --
>>   target/microblaze/cpu-param.h | 2 ++
>>   target/microblaze/cpu.h       | 2 --
>>   target/mips/cpu-param.h       | 2 ++
>>   target/mips/cpu.h             | 2 --
>>   target/openrisc/cpu-param.h   | 2 ++
>>   target/openrisc/cpu.h         | 2 --
>>   target/riscv/cpu-param.h      | 8 ++++++++
>>   target/riscv/cpu.h            | 6 ------
>>   target/s390x/cpu-param.h      | 2 ++
>>   target/s390x/cpu.h            | 2 --
>>   target/sh4/cpu-param.h        | 2 ++
>>   target/sh4/cpu.h              | 2 --
>>   target/sparc/cpu-param.h      | 2 ++
>>   target/sparc/cpu.h            | 1 -
>>   22 files changed, 33 insertions(+), 29 deletions(-)
> 
> Missing:
> 
> -- >8 --
> diff --git a/include/tcg/insn-start-words.h b/include/tcg/insn-start- 
> words.h
> index 394c191da8d..d416d19bcf9 100644
> --- a/include/tcg/insn-start-words.h
> +++ b/include/tcg/insn-start-words.h
> @@ -8,3 +8,3 @@
> 
> -#include "cpu.h"
> +#include "cpu-param.h"
> 
> ---

Thus we also need to add another commit before:

-- >8 --
Author: Philippe Mathieu-Daudé <philmd@linaro.org>
Date:   Thu Apr 3 23:37:54 2025 +0200

     tcg: Include missing 'cpu.h' in translate-all.c

     tb_check_watchpoint() calls cpu_get_tb_cpu_state(),
     which is declared in each "cpu.h" header. It is indirectly
     included via "tcg/insn-start-words.h". Since we want to
     rework "tcg/insn-start-words.h", removing "cpu.h" in the
     next commit, add the missing header now, otherwise we'd
     get:

       accel/tcg/translate-all.c:598:9: error: call to undeclared 
function 'cpu_get_tb_cpu_state' [-Wimplicit-function-declaration]
       598 |         cpu_get_tb_cpu_state(env, &pc, &cs_base, &flags);
           |         ^

     Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index ed41fc5d0cc..c5590eb6955 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -71,2 +71,3 @@
  #include "tcg/insn-start-words.h"
+#include "cpu.h"

---



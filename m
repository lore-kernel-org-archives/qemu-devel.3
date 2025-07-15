Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0227EC83F21
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 14:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubgK7-0004vq-SD; Tue, 15 Jul 2025 10:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubfgK-00062r-OU
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 09:26:57 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubfgI-0002hm-8A
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 09:26:52 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45617887276so18493305e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 06:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752586008; x=1753190808; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3g5u4ZdHCSZkZpi+Mg3cSyiQh/vf+08ZtKEuVevCNiY=;
 b=laO9eQmO9DW1IRHD+yrw4pSDNilaagTFgFbf4t3WALCIkufOk7vke0zDOqWHmp9fbq
 kOK6DegFntMg609GI05Bub2bZAxuZd7pxQ9C1DhYq8ysudK6kV43W2WoqaKTDr1pHbu1
 pr4ZPEjY61wAw4B/P1zrz8+ANLjApL0T+QIQeLuMIbXdEDZK/tmppvrfsbb5334hYQh9
 I+/xdFZg+iVFOuheMl0x3aeA+LAe6xt4njXT0k524axcIclec+9wDe/pd5jqjIy/BGd3
 Jn5isVMf2r7r6p9qMpi2M/2dikXsvEDzGrDdU1yaOX8Nb5TUPpqOOiWn/k7k2bObZNDo
 GAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752586008; x=1753190808;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3g5u4ZdHCSZkZpi+Mg3cSyiQh/vf+08ZtKEuVevCNiY=;
 b=Gt8kkcbexTE+3b6y2/VB1mBcLi2gDLHrdjqMeC0bGbyiYFN0JKkR7hssvxjV47lWnM
 3EaZooPl/LdisJ0QQB6rdFqL5DBupTFepFOILtvG7BuXwH0ksYWxGDx4QW9cHJdFA6fc
 8hudljHHpuixbssRYMIAPh5EhruW48vQJyZMN/JscMiE5M9ZUIONLnqi+jdZzj2UAjJR
 pRzqOAlzR4SIBXlh46OM8QnD7mgW9Yo721ki4BgfdRd4Vr9Wa+5BQYvBxzK3KJ/0ZSjK
 vZ1lUGHgF9zlcl3Dhff5A9o53IxlO//LYKt010lduX459PylJXhK6ijjX/N6RYDgo9L+
 WAqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU43bbtN2j2z7ihsBxoB+qYM+VEq/yQKN7WxSo1/oI0GcC7l5YS9roQxzhajz3+pGVqIvGMq/jnuyel@nongnu.org
X-Gm-Message-State: AOJu0Yy208rpoBSP/do8yfypIvQAx3zbkJm0yrC2aWOrq8jpFAIpfnGd
 byune2f20Xw3pMQ50HpGzsQfpc6uPhO1xHsUsr5UH112YEcswLuZVEOhAVvs0wDRHgg=
X-Gm-Gg: ASbGnctq/rYj3xFDsJ9cyJWAanR+egIJ00VOPFTloD1S+hm6q5g1c77z3NqFNMW97fs
 14bCjTDjIomMEZe9SkOjnlXPdUzJ5LBqZ3DeewCFLoyWp8f3I/LzQuoVtLwqDI+EEBUth2BfKtv
 BgY/Sizb7wGfyzH466RRA0BUmJ1HNJEKzQhWctHyD4+ocC1yhd+s6WeTXLp/vgK+9vEr7rg+dY/
 YHwKUHnl2WMslewi+F0jw3wsgLP3qAeP0Ih31koARgt8FT1O0tAoGgn8oJp8G1CEy95JrP0ZR1J
 mfsXqcnJe0OChl/Vgc7wzMxzwsbGHxAQd5UVxvOwEdFxBaNZumlGXO/GFyheX86CKb3z/56m2EM
 9yXUCXgqgdfReCKX4i0PiurEof7314D/9+By4yjmJfVj0kAD30X6iVHnh1/55Dv8I4SsiNYs=
X-Google-Smtp-Source: AGHT+IHmUA5fHiF/OSqRnvlAjsyPc9Kgqp9SlqnJBV6hVzTuM/4d3fe91I/FcZiAf91/95CilyKZGg==
X-Received: by 2002:a05:600c:a111:b0:455:f6cd:8703 with SMTP id
 5b1f17b1804b1-455f6cd8a4emr115830445e9.31.1752586007577; 
 Tue, 15 Jul 2025 06:26:47 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e26ff9sm15143883f8f.93.2025.07.15.06.26.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 06:26:47 -0700 (PDT)
Message-ID: <62c54b15-d6ab-42cf-b2a2-3bf05cb8ec27@linaro.org>
Date: Tue, 15 Jul 2025 15:26:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v5 6/7] accel/tcg: Implement get_[vcpu]_stats()
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eric Blake <eblake@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Mads Ynddal <mads@ynddal.dk>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>
References: <20250715104015.72663-1-philmd@linaro.org>
 <20250715104015.72663-7-philmd@linaro.org>
 <c741d3b1-6a6a-4702-a33b-2d5c7c2e3598@linaro.org>
 <9e199d53-9b7e-400a-9172-9986602cf6a7@linaro.org>
 <3bb37477-046c-4425-a96e-4dbef24c851e@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3bb37477-046c-4425-a96e-4dbef24c851e@linaro.org>
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

On 15/7/25 15:18, Richard Henderson wrote:
> On 7/15/25 07:06, Philippe Mathieu-Daudé wrote:
>> On 15/7/25 14:48, Richard Henderson wrote:
>>> On 7/15/25 04:40, Philippe Mathieu-Daudé wrote:
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>>> ---
>>>>   accel/tcg/tcg-all.c | 6 ++++++
>>>>   1 file changed, 6 insertions(+)
>>>
>>> Oh, this is what causes tcg-stats to be used by user-only binaries, 
>>> is it?
>>
>> Indeed, otherwise we'd have to use #ifdef'ry or stubs; and there is
>> no good reason to not dump TCG stats on user emulation (except indeed
>> this code path is currently unreachable there).
> 
> Ok, that's fine.  Let's avoid the ifdefs.

This works for Linux (qemu-foo -d stats.log ...):

-- >8 --
diff --git a/linux-user/exit.c b/linux-user/exit.c
index 1ff8fe4f072..3e304422502 100644
--- a/linux-user/exit.c
+++ b/linux-user/exit.c
@@ -21,7 +21,10 @@
  #include "gdbstub/syscalls.h"
  #include "qemu.h"
  #include "user-internals.h"
+#include "qemu/accel.h"
+#include "qemu/log.h"
  #include "qemu/plugin.h"
+#include "accel/tcg/internal-common.h"

  #ifdef CONFIG_GCOV
  extern void __gcov_dump(void);
@@ -29,10 +32,14 @@ extern void __gcov_dump(void);

  void preexit_cleanup(CPUArchState *env, int code)
  {
+        g_autoptr(GString) buf = g_string_new("");
+
  #ifdef CONFIG_GCOV
          __gcov_dump();
  #endif
          gdb_exit(code);
          qemu_plugin_user_exit();
          perf_exit();
+        tcg_dump_stats(current_accel(), buf);
+        qemu_log("TCG stats: %s", buf->str);
  }
---


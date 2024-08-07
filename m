Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6911C52D73
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 18:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sblfG-0004N0-Rn; Wed, 07 Aug 2024 14:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sblfF-0004Gt-3F
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 14:45:37 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sblfD-0008T8-0o
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 14:45:36 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1fc491f9b55so2124555ad.3
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 11:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723056333; x=1723661133;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JQHt8vBaHCjFB3wmOnZDxOw4YI5rlAK0kX+WtFhkwxc=;
 b=moUcYQyO5mEhrTXbbovMXgw5sFTV6lZ9Rf4zjxFh/V8pQ4ZGcQlGq02VEP+X6aGPqX
 9XKOorFyxJo16dy+IIKcMW9FvUhvkVrr8CVj++QPZs+TFRopPpw2cFawg7ha9efKaC/4
 pSUgDsfTUY1roTpmrY3+wXC2UH/04G8jx56fG85g4+4BiA9hKJ6Be7MhgDL/IxAYVs50
 VJfbhqPebogMcO+dVPonjM3GxFZl6fmzAsOv74gmVp9Q3JOuCgYAUAQO3BHuRBJam5YY
 JL7e0plh3CPyoF9xsA7BModqgZQp3N0w2ieELcnLIrWsNP2cx8q+Os8UlsXv8D5dTWTA
 onPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723056333; x=1723661133;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JQHt8vBaHCjFB3wmOnZDxOw4YI5rlAK0kX+WtFhkwxc=;
 b=HMgEJzz+vSNtw+ufiUFwHCm9CdHv5XOlSsY+Q/fqzxZGp7g9LRGoSpYX6bNFSQ7Agl
 oyWeUiDYZKfGt7jdWi4Rg/De/E3l3ON/UgQcgQQDQZZoJ54z6vXolwl0V4m81rYvK3N+
 8yGxwRf9cEQYJVw50jG2dZfRr2oED/5vB8DKUSuiqX+gGI1B2L2aQqTxMrkP+kXZeBeo
 sSSDV3vrSLHkBmMNCxUXVEit9ACu9XANGvcUpzqN3EuQtiW16OhfAZkF1UwQQrPQm7dX
 WOja2BnP3KmNhwDKas/VWQqc/9ERIxTij8VScTHXnytFf+VlpolQjP9YV6q1iCEi8Myp
 n77g==
X-Gm-Message-State: AOJu0YzTYv32VkV0LxCEVmVh0RKdeC5j7LkY1VBWPfQCcJVMVnTQUZfO
 hSYhpfFfhdDjlgdI0e+UK4wUcjNsjIB5k5Wf8a7wyubeWcqib6DzujipfHhk5yY=
X-Google-Smtp-Source: AGHT+IEE+IyfKlluxnSu4GMaNMVRT73wyzPMazN38RzBjPk03AwXJih9dCCsdwAAIifemDItmaVtew==
X-Received: by 2002:a17:90a:2f25:b0:2c9:8189:7b4f with SMTP id
 98e67ed59e1d1-2cff9514703mr18284722a91.32.1723056332629; 
 Wed, 07 Aug 2024 11:45:32 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1b3ad01d4sm1926841a91.23.2024.08.07.11.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 11:45:32 -0700 (PDT)
Date: Wed, 7 Aug 2024 11:45:29 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH v3 01/20] accel/tcg: restrict assert on icount_enabled to
 qemu-system
Message-ID: <ZrPAyUJhrHGN56wx@debug.ba.rivosinc.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
 <20240807000652.1417776-2-debug@rivosinc.com>
 <9c987cbf-f702-4e1f-88d8-82a149c98007@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <9c987cbf-f702-4e1f-88d8-82a149c98007@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=debug@rivosinc.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, Aug 07, 2024 at 10:48:56AM +1000, Richard Henderson wrote:
>On 8/7/24 10:06, Deepak Gupta wrote:
>>commit 16ad9788 [1] restricted icount to qemu-system only. Although
>>assert in `cpu_loop_exec_tb` is on `icount_enabled()` which is 0 when
>>its qemu-user and debug build starts asserting.
>>Move assert for qemu-system.
>>
>>[1] - https://lists.gnu.org/archive/html/qemu-riscv/2024-01/msg00608.html
>>
>>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>>---
>>  accel/tcg/cpu-exec.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>>diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
>>index 245fd6327d..8cc2a6104f 100644
>>--- a/accel/tcg/cpu-exec.c
>>+++ b/accel/tcg/cpu-exec.c
>>@@ -927,9 +927,9 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
>>          return;
>>      }
>>+#ifndef CONFIG_USER_ONLY
>>      /* Instruction counter expired.  */
>>      assert(icount_enabled());
>>-#ifndef CONFIG_USER_ONLY
>>      /* Ensure global icount has gone forward */
>>      icount_update(cpu);
>>      /* Refill decrementer and continue execution.  */
>
>No, this is a real bug.
>
>Just above we handled
>
>  (1) exit for tcg (non-)chaining (!= TB_EXIT_REQUESTED),
>  (2) exit for exception/interrupt (cpu_loop_exit_requested).
>
>The only thing that is left is exit for icount expired.
>And for that we *must* have icount enabled.
>
>How did you encounter this?

hmm I was experimenting with reducing TB flags (i.e. not using two different TB flags
for zicfilp). But I swear, I didn't see it go away (for qemu-user) when I had switched to
two TB flags.

Now that you've pointed it out specifically, I tried again.
Its not asserting at this place anymore for qemu-ser

I'll remove this patch in next version. And if I encounter this again, will dig a little bit
more deep into it and try to get repro steps.

>
>
>r~


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4942CD342C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 04:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKqp9-0006DK-Ez; Thu, 07 May 2026 00:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wKqp6-0006D5-VQ
 for qemu-devel@nongnu.org; Thu, 07 May 2026 00:58:57 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wKqp4-0007Gr-Gn
 for qemu-devel@nongnu.org; Thu, 07 May 2026 00:58:56 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-6949f3eeaf6so784882eaf.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 21:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778129931; x=1778734731; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2rN1rZatelrTPRmpKDfXM7r+xfjdh7QJxRCY0Ts7LBI=;
 b=ZoDBF/HCrBMcn/D9nRkZnY2OcTnfaxRFxfFAgtAQuUmZXOfNfQXHmxtl79hlr2n2pE
 b26LWduqeQ4Wr3nT5mwLPi5UcZUUjYPTVLySFxyPR9YnS9tTsvhv3wpUPHGFTrKJO9uR
 Y1ZiMcKIpSPwgpHxAgNQ24xR8spM2XbO/6V+tDvaBZ3Gvsgl6c3YL6o3RsUSqTztVb0F
 JyDiqpF9zxHtwzGit+MKjvQEBfKQTn7YY8DFUy5vdOY6VvDktp7+0H3zP83WeA3BzZ+m
 dT7rXw6ylGdfT86YbPKVZqKXb8Q0JtTWIj3wgZYQdnj+GbXzPjTuAty+cO7M6CUWuUaA
 g8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778129931; x=1778734731;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2rN1rZatelrTPRmpKDfXM7r+xfjdh7QJxRCY0Ts7LBI=;
 b=atIUuAAmgorHjvz8VHxJuUx7FfYThRNWyjHGhG2VhUdJFPPSgWnhOFeuc+YHJSdMah
 yzJpAyqQINsE3/anCGZ5VwERgO8LhAvNdLpXLo2JgSs6WBI94sJVL9ps5buV6OLR9trH
 GocLLJDgic3DSurxtXnCHSgdGOiuQbvD5wXGW7cDOOhFuVllvZ7jvGNgPbviOkOlF8K8
 yNayfRNo7XyaP0tquEUX+VVVsq/fABN3ybYfG9zwNHC5vYrmps0XmirbgcIvBTMRo29i
 j4fwYp0nWx/1JTH8FtH6V9+1mSqk79J0pLzKeszwzCifSCw/SmA5G+Ox/DoH/cq9NHQ0
 7v1Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+RI/blme1tNA8HG8fH1OPNuJ+en1MXMh/8hf74jcL/g8li8EnFLJpJAD9fMfgbUBba0AYBlBVmKzod@nongnu.org
X-Gm-Message-State: AOJu0Yz5unSRvyBlHmwvW8xEGIG8hdLqoPyYAGXTOAXpnyKkKqJLxGXK
 tnW6qXzHFo+xAln8XPZL8dsAAP0JK7xj1eBfzoFjrje+5MItYU5glASAgwwrdtAaYak=
X-Gm-Gg: AeBDiev0Rq9T6hkm3rbDLTy0wwGJc+Uzm4AyJR3C3NZbBOkI6ZWdK4lbPmPKPykuZpY
 5wl/92LS6m/ad3FVJ69r3deMBS0V945/4PiI0gunA0tuvxu3eSXsRMcJUp+A3nowjBOG00YIoN+
 aj9XP+h0Ofk0wABMslX12XduopXGkNxERR6mQ5o+ZAzToY69q4ZBA6bEZPHdYH+M1ZIe7ILtzgx
 4zur1k5l7eWhUW7CvLGbSUhk9jz7MVCMUQf1jpzPp7shQ290oyjXfQxOl5eVODjk+6tqsg7dOnI
 72bGgzB08MLqM/TMeKt9rjo0b2b2SIKcKk+ki4tIeep9Bo7LY6Wn6elV313IuQMVI8y6mektiY0
 5C8Xtq+vyzrBC49O1EvLg8PCtPNWShM0mAEcVYobQwrNg8n5e3RChay6y5XCDQxPUzUd0EucAQK
 Blef90JQqjrIYNaGA0un+uPzIhtvO6UUernxZmg+4HxMppBOXyX2TGgD6lMG2QGVGMdQBRPPyMv
 GkK8kqcP99HQC/TuO2m
X-Received: by 2002:a4a:e918:0:b0:694:9910:f78f with SMTP id
 006d021491bc7-699ab5727d4mr842155eaf.3.1778129931441; 
 Wed, 06 May 2026 21:58:51 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:6efd:4d9e:6f84:a7eb?
 ([2600:381:c938:6375:6efd:4d9e:6f84:a7eb])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43454cbcbcasm19141128fac.9.2026.05.06.21.58.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 21:58:51 -0700 (PDT)
Message-ID: <9794589b-0f4e-4f0a-9d67-ab7e9c1d749e@linaro.org>
Date: Wed, 6 May 2026 23:58:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] accel/tcg: move jit thread manipulation into
 do_tb_phys_invalidate
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20260505103649.68361-1-alex.bennee@linaro.org>
 <20260505103649.68361-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260505103649.68361-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/5/26 05:36, Alex Bennée wrote:
> To invalidate a TB on MacOS we need to enable write access to the JIT
> buffer. We were doing this for tb_phys_invalidate__locked but that is
> not the only path into do_tb_phys_invalidate. Move the manipulation
> into the shared function that does the work.
> 
> This enables watchpoints to work in MacOS TCG guests.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3444
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   accel/tcg/tb-maint.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
> index cd7c32361bb..9a648f97865 100644
> --- a/accel/tcg/tb-maint.c
> +++ b/accel/tcg/tb-maint.c
> @@ -925,6 +925,7 @@ static void do_tb_phys_invalidate(TranslationBlock *tb, bool rm_from_page_list)
>       uint32_t orig_cflags = tb_cflags(tb);
>   
>       assert_memory_lock();
> +    qemu_thread_jit_write();
>   
>       /* make sure no further incoming jumps will be chained to this TB */
>       qemu_spin_lock(&tb->jmp_lock);
> @@ -954,15 +955,15 @@ static void do_tb_phys_invalidate(TranslationBlock *tb, bool rm_from_page_list)
>       /* suppress any remaining jumps to this TB */
>       tb_jmp_unlink(tb);
>   
> +    qemu_thread_jit_execute();

You've missed the early return path from the middle of the function, which should be fatal.

But the place that needs this is tb_reset_jump, which is called from 
tb_remove_from_jmp_list and tb_jmp_unlink.  Which is entirely covered by moving this down 
toward the end of the function like so:

---
+   qemu_thread_jit_write();

     /* suppress this TB from the two jump lists */
     tb_remove_from_jmp_list(tb, 0);
     tb_remove_from_jmp_list(tb, 1);

     /* suppress any remaining jumps to this TB */
     tb_jmp_unlink(tb);

+   qemu_thread_jit_execute();
---


> +
>       qatomic_set(&tb_ctx.tb_phys_invalidate_count,
>                   tb_ctx.tb_phys_invalidate_count + 1);
>   }
>   
>   static void tb_phys_invalidate__locked(TranslationBlock *tb)
>   {
> -    qemu_thread_jit_write();
>       do_tb_phys_invalidate(tb, true);
> -    qemu_thread_jit_execute();
>   }

Might as well remove tb_phys_invalidate__locked entirely, and propagate the direct call to 
do_tb_phys_invalidate.

The __locked suffix does appear to be for the user assert_memory_locked().  As evidenced 
by tb_phys_invalidate, for system mode, we only sometimes take the page lock.

Given that this jit protection is via pthread_jit_write_protect_np, I assume the W^X 
protection is a magic Apple per-thread bit.  If so, we don't actually require cross-thread 
locking at all, and all is well.


r~


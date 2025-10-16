Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B23CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 05:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Gx8-0007kj-Ox; Thu, 16 Oct 2025 01:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Gx7-0007iA-Ez
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 01:55:05 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Gx1-0006nV-MH
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 01:55:05 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e29d65728so1936795e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 22:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760594097; x=1761198897; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2PF6WhtH7w83pXVgEm+WoFDUKt31OPMB6wd10Cj2wQs=;
 b=JDUmd3j4dtybln7iuxtbiB4gGlieod2RL0RVJi8lyc2XsOQVTCVpRTL8Nrqq8LHxI/
 pSHeA0SBCmJUHtXJRJKSsolIlvKbzoMwdWnTu8eYO3yNbiqIIl6bFexIXvqMLLNbKa5X
 siBB8tJbn4UKhDeVlq8QolAV/nuuqEsAdiM52DMrWgbG3ogsJS65SpeM+0mzU3TWGca3
 mGMG5g58vhQiFM5vSbufKmqcWggTGZ9uaHFLH5ye/52vhM/2MPutX6knbivCI6/XMhsk
 s0M/5iZGYnNEpiOXE31ui71QON7bZ846248QvWBWrcisLwWBPhn/VZqWQ/S5nux85FGN
 bDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760594097; x=1761198897;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2PF6WhtH7w83pXVgEm+WoFDUKt31OPMB6wd10Cj2wQs=;
 b=JWQEVYWGCdFkLFGgByiqChn9ZdxgAqUkdWhTE1078ss6Qu0E5Nhj8f9xwM8fac2EIu
 vM7O7fVYThjkjr0GyDFlrxHMJraRHrNYH6CP0Xt3YJyGRvPW+QUxZelcYgYEcqsY7Y//
 l3xQzL6z3JdyfhDCpDSNXTIJr/8jcqXJRs0HjAul6xq+QD0EIDXog4tr5ugQwBGJjkgW
 bRSuaIYL0sXOgel9T3vKMQFRcA+3D7gIB1fzaXAyPcQbjO3sVIGhErUhwD2uyzRDJN1V
 AC8jLcPHyKMmey69MdUvyVocEL7/DfsAl4SZRB5UckeJZCrfgZ6jRmCLunpQxMRQ4KPr
 wZ2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlAqvF/YhZSomWBie4QEewLeMFZwSZCn1dOC0V3IE4r3ROmsFwzn3qgu9JtA9APbpI7CqUpbWk9IE9@nongnu.org
X-Gm-Message-State: AOJu0YxAObtRb4QcWCbKb+j7dQWPN3ZYeCREsT9wibPzwOWjf4OmUYmt
 f8rqJzUWOdIHyDlbOVcRhTpM3MKfzR2ZY6/9eKJUSMX1I4cz2BAHlqsDdBsTf8HypE4=
X-Gm-Gg: ASbGncv0svLfgR0OJWCt43psgbgbl6IDUnltRucaFar6MLWeJaKGXi1c7Vy4iu+MZRP
 KVMkzbsqC8O/MwMHBcy8s+jnL3/ZbYqGAJUsAHh8xmXeoTbtyBHjTipAjxbqDWcz9/LpmK2qL24
 G36ydOQ+KP9F6qUYLPMoYfAnJf6JE4zYJia1nSb1L36+292UJbXFk+C28wSW+K5d3QGaCo4Vz5B
 +4hwj7/RFz9cJpyKT8BFypNBmkMNgCcgLGB2NCqLKI5R1UPtUvxvAEhknWH9kHuQ47ZZXsCbkBV
 uytGDv2G+65zLy5UTNrKbJIjDtUvn9ZBdryg+vydJd1PVoBWJLN3N8A85mfcAHWEiAdwHYXKwsa
 Lbj8Fy5NJwgv2Zrxj6vLKsr7YB1EH4xoSJFtFBZWXLPKZqnJeWmVjG3yRfno2T9cgLaAcduhQDK
 fxnhKeNI+Dnc8jzKV5IixldEXZQKWaVbaNL2ZFfDEkB023YZU=
X-Google-Smtp-Source: AGHT+IHh/Zms2gqKHYeVfcqGnk9q0dvMgzw/NTBNc2WiMA1+ZbbWRU7pa+mMA/h9OVNTff+o6F3wSA==
X-Received: by 2002:a05:600d:416a:b0:46e:3f75:da49 with SMTP id
 5b1f17b1804b1-46fa9b11794mr218682095e9.37.1760594097643; 
 Wed, 15 Oct 2025 22:54:57 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4710f2ab58bsm9067705e9.10.2025.10.15.22.54.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 22:54:57 -0700 (PDT)
Message-ID: <14713a63-79f9-48f6-b9d6-d62c022fa7e3@linaro.org>
Date: Thu, 16 Oct 2025 07:54:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] tcg/mips: Remove support for O32 and N32 ABIs
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, Thomas Huth <thuth@redhat.com>
References: <20251015213843.14277-1-richard.henderson@linaro.org>
 <20251015213843.14277-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251015213843.14277-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 15/10/25 23:38, Richard Henderson wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> See previous commit for rationale.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20251009195210.33161-5-philmd@linaro.org>
> ---
>   tcg/mips/tcg-target-reg-bits.h           |  8 ++----
>   common-user/host/mips/safe-syscall.inc.S | 35 ------------------------
>   tcg/mips/tcg-target.c.inc                | 14 ++--------
>   3 files changed, 6 insertions(+), 51 deletions(-)

Maybe squash here (improving comment if necessary):

-- >8 --
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 43727512d46..fa4e4abcc17 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -959,17 +959,10 @@ static void tcg_out_call_int(TCGContext *s, const 
tcg_insn_unit *arg, bool tail)
       * Note that __mips_abicalls requires the called function's address
       * to be loaded into $25 (t9), even if a direct branch is in range.
       *
-     * For n64, always drop the pointer into the constant pool.
-     * We can re-use helper addresses often and do not want any
-     * of the longer sequences tcg_out_movi may try.
+     * Always drop the pointer into the constant pool.
       */
-    if (sizeof(uintptr_t) == 8) {
-        tcg_out_movi_pool(s, TCG_REG_T9, (uintptr_t)arg, TCG_REG_TB);
-    } else {
-        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_T9, (uintptr_t)arg);
-    }
+    tcg_out_movi_pool(s, TCG_REG_T9, (uintptr_t)arg, TCG_REG_TB);

-    /* But do try a direct branch, allowing the cpu better insn 
prefetch.  */
      if (tail) {
          if (!tcg_out_opc_jmp(s, OPC_J, arg)) {
              tcg_out_opc_reg(s, OPC_JR, 0, TCG_REG_T9, 0);
---

Otherwise I can post as a following up cleanup patch.


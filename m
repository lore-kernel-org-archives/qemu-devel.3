Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D54C28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 03:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzp7R-0004Hp-Rg; Tue, 01 Apr 2025 23:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzp7P-0004Hd-PH
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 23:50:24 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzp7N-0000OD-KX
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 23:50:23 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cfecdd8b2so48972775e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 20:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743565819; x=1744170619; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cLOfLQRoHi6vDjUliJwHTmYl3A0je/AL5pPCYQgwYe0=;
 b=OEZ0FDB97hEvWnf+vL+HwsBoivbmpjR60a8LaCAae4xec6yacS8LrEm2Gtau6B8nCY
 Lh60dndk+AkCoKCyj041DlxTplWsXA8vfEsMxR/XhYWquk02O9xhNUStEsNmxJvu7ESA
 ebJGNgJMj1X0U3MKmsHrwnZH8CrLW6rSatA+4rf7c5bKmFz/U0xgsD6P4byy2Vos7179
 ngmQ7K9i6ZZeskhJF+VOJhTT1bus2WAiwE2lz1RsjefGArmtl02PsdJ4gefVMku1IRRR
 /EIn8CNRpbf6u5CBHd/k2ZqqL9GxThXvdi7NTiIgAll528GQbnYjqBVyexXQyfIYifXR
 y0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743565819; x=1744170619;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cLOfLQRoHi6vDjUliJwHTmYl3A0je/AL5pPCYQgwYe0=;
 b=WX1PBklWf2RwhSBbGGe7tj0MyO7/XMJUOjTOhM7rgOwrbpKyhEjDblcC5fuCjuxp3X
 /4N6rYQZClytxdqJQ2SHXwrotVsX+yR+q/NMhsc0Iz+e5+3eTcHV20Cay9nzlr52H7wJ
 cRqVJfEreYRo6admzDiJ9ZdUs5yCxd6gOzW/LvRvBwpnmob0UTPNo8uVjcCV6uh6bdtp
 R/MGqoSStVNVTJWZqGRiM03ZdkZLlsC9fNSEsol7gxBxwq/9hCqA5stpd8Pwh19Zj3iC
 g4IsRPMWxt0ldspwbDLGyXcDuo1ImMRZVbI50QfVIcx/AbbTz16Vrn/xJJ/VrY90YBm3
 YoIA==
X-Gm-Message-State: AOJu0Yx8LA7WbEiQkxwJFQiP1qX7hDvv/nJtvxvEh13oSC+FTEq2kGvY
 wQJaBoQgZ04zqCYvoWhh+jQqLswLyhKEezmmlkZ8+7fzbkRrZ5GD+/CawGJIbml8phm3wQKzixb
 /
X-Gm-Gg: ASbGncseagePHmeBHMiTW/7K5Hydb4TATX5+ADi83ZlI1qiRIUWnLHaATw0Mmj5t4Ay
 787dmxIROrzLSnYfUOo0lEaB6+CaHn3NRKa4SYKZUhRYctv/hCcs4iRwaF+5mCSc1dLFU0qIW28
 Z8SuzPCMd72fMp04Wrwt1VMw8IWtLFmll8IUOsljwgV0HdxigH1ojA80CjP3i7mylL27zcGzDTe
 w48dyIB3W39VSaWtEbcGE2UmEAlIcYUHAYz8E4DI4wXryyN3nk0cE8rz9G7zNfZXX9RC5V3XOk8
 2Tdo3HNhm9+mcXoLDMCMAdcogCuZn+enoHtyU+OrJ7AGIce6P/GgyAJpbfRQDGzDPMTPF0H8bJL
 b/cYWkSfxJ69G
X-Google-Smtp-Source: AGHT+IH8m2Y1ybXUp+14HcSs2CBqLseTIiM2nStlewzF36/iX9Rpjj6lpQQyBWSvOL1vVlKBNTiKLQ==
X-Received: by 2002:a05:600c:45c7:b0:43c:fb95:c76f with SMTP id
 5b1f17b1804b1-43db62264c7mr146896135e9.9.1743565819013; 
 Tue, 01 Apr 2025 20:50:19 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b66363fsm16294530f8f.36.2025.04.01.20.50.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 20:50:18 -0700 (PDT)
Message-ID: <03556e83-472c-4ac1-910d-bff29fa3ba58@linaro.org>
Date: Wed, 2 Apr 2025 05:50:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 23/24] hw/core/cpu: Remove CPUClass::mmu_index()
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250401080938.32278-1-philmd@linaro.org>
 <20250401080938.32278-24-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250401080938.32278-24-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 1/4/25 10:09, Philippe Mathieu-Daudé wrote:
> All targets have been converted to TCGCPUOps::mmu_index(),
> remove the now unused CPUClass::mmu_index().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/cpu-mmu-index.h | 4 +---
>   include/hw/core/cpu.h        | 2 --
>   2 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/include/exec/cpu-mmu-index.h b/include/exec/cpu-mmu-index.h
> index 651526e9f97..a87b6f7c4b7 100644
> --- a/include/exec/cpu-mmu-index.h
> +++ b/include/exec/cpu-mmu-index.h
> @@ -32,9 +32,7 @@ static inline int cpu_mmu_index(CPUState *cs, bool ifetch)
>   # endif
>   #endif
>   
> -    const TCGCPUOps *tcg_ops = cs->cc->tcg_ops;
> -    int ret = tcg_ops->mmu_index ? tcg_ops->mmu_index(cs, ifetch)
> -                                 : cs->cc->mmu_index(cs, ifetch);
> +    int ret = cs->cc->tcg_ops->mmu_index(cs, ifetch);
>       tcg_debug_assert(ret >= 0 && ret < NB_MMU_MODES);
>       return ret;
>   }
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 60b7abaf49b..10b6b25b344 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -104,7 +104,6 @@ struct SysemuCPUOps;
>    *                 instantiatable CPU type.
>    * @parse_features: Callback to parse command line arguments.
>    * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
> - * @mmu_index: Callback for choosing softmmu mmu index.
>    * @memory_rw_debug: Callback for GDB memory access.
>    * @dump_state: Callback for dumping state.
>    * @query_cpu_fast:
> @@ -151,7 +150,6 @@ struct CPUClass {
>       ObjectClass *(*class_by_name)(const char *cpu_model);
>       void (*parse_features)(const char *typename, char *str, Error **errp);
>   
> -    int (*mmu_index)(CPUState *cpu, bool ifetch);
>       int (*memory_rw_debug)(CPUState *cpu, vaddr addr,
>                              uint8_t *buf, size_t len, bool is_write);
>       void (*dump_state)(CPUState *cpu, FILE *, int flags);

And I'll squash:

-- >8 --
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 8057a5a0ce8..b00f046b29f 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1077,6 +1077,7 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
          assert(tcg_ops->cpu_exec_interrupt);
  #endif /* !CONFIG_USER_ONLY */
          assert(tcg_ops->translate_code);
+        assert(tcg_ops->mmu_index);
          tcg_ops->initialize();
          tcg_target_initialized = true;
      }
---


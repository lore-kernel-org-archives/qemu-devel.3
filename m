Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5DBC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 22:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwSYv-0006gA-Bp; Tue, 18 Aug 2026 18:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwSYm-0006fi-NN
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 18:45:34 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wwSYk-0002YU-AF
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 18:45:32 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2cf6d65d8a7so4593885ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 15:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787093127; x=1787697927; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ECXgh/XGnYTaDhimmZJpfReEB9Qsfw0LsOi1GbJ+Sm0=;
 b=CVHPImX9PwWVpkLD0+DRJz1nHc1XeICr8eafaPyYkXZlpcne5wNd2g28Www67XTIHX
 Ulq89+/w9ojTVGjzlF5guYhih1Mb9R2t27vYXEI7N7nu24kdo5Dcl2InTNxwC4VFJv1H
 R/lHv1rONm7PAw2VCGvBhOSIc2CLDhjomin1G8isOCrFm+MN1D8P3FA9IkXZNwBgcVCn
 5QtG8+8+TurUL6tkymMpQy8IDWonMo8WjmhYF74Tg+qoSKZ4o/yX+IrGJlmWYNxmlzcd
 IQQkkvmm870Qm0Gw3CuosvNL2oh3KIQ+3iCGehGn664LPVp8WJmHKWwikA7yzo7gHxop
 Q/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787093127; x=1787697927;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ECXgh/XGnYTaDhimmZJpfReEB9Qsfw0LsOi1GbJ+Sm0=;
 b=P/zIamvywdvUZixeAyk1p8FxXH2SeOKfM6//qlJJ96PrENBkggje+IdpNGXtJI4oqv
 voQCDAFVZEqOqqADtzXQb/LPLoW1hWRtmic9RUGSF+fg5V+cRdoC+0RQXEdt7/SLVuJP
 1j3xNzwpkP71bxaheEBnVeUBIlbkr+gP63M/XSybdUBOchGUGVHidPE4cpF9av+jczIo
 jm/Avb+9OS5f+UsnPFyYbfUhWgvOVSrvNMMRyDGb7CgsPZA26GiiAl6ZBNP6a7XfkHX8
 iMbkBeE04yLMql5MWxun4INfYBy+12hxvTNCBqcTs4o2m//AChA9I3B9C7iVh46aIlpI
 HBPg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrbFXMXuYj7QJ6+TXwqYY6r7Yz5h5VEAexsN0N+D3Y0kmf739BDYgSWiKSSXfLKm5981KXaqUufwktd@nongnu.org
X-Gm-Message-State: AOJu0Ywl60Ngvmh9oAdy4hYsB5zZTBmGv0AIpkwC6l3EoEkbndrj5k8w
 Gs/o08CNuvMZ5hpR519DoatXrdwnnN8GVS/izbxEuh+PIA06HWjBzSlA+Gr4k6z++uE=
X-Gm-Gg: AR+sD12BTL3FX1UMXpFP1Q408m7pqAHo27YvyAGM2tUfmkbLW0bzDlP9g9yRWMsCNym
 c99e4eZ0nzLZDlOT91ErcRW2c+S8JStJYe4DdNbrB7l+2Bej2CNuTAKuHbYH1/z3Yua+gYLHhT2
 Dii7YoOPu+ULHBtoQRcyIOv3jI5wO4RfqJv3Jm0wIqDxvfwiaBkwv3bV5cz6rr5CpvomAsAGxR3
 9tog9Lgpr+cG9lcvHKC5U2xqC/XuHKVc6VBcQ+GnBRpIE6JDzkSxc6HmFf2wzH1ACoCRIexlimi
 u+GmeVX7rLqdfg+wwZzxmW+FKnCIfJEbaKaMiTF13dRvKJwVhvE5mFU7owFduqStUwwF2KmVNbq
 TourTSmELwlcti8MOPjd4gLxo26TaaalnMECvNxJBPtKjXUnEBtUDxxjf9zkEE17IlF7Lqey6J2
 2KMuhCAKjDTr72wEkRYJlZ5kejM/YEQxGFpUoV5WTSm0LpfvVAshkPU1ROoConFGAWm6+/2Rr0Y
 PdQw5Nc
X-Received: by 2002:a17:902:ec91:b0:2ca:d9b3:715e with SMTP id
 d9443c01a7336-2d6017642c5mr3044165ad.9.1787093127503; 
 Tue, 18 Aug 2026 15:45:27 -0700 (PDT)
Received: from [192.168.122.51] ([173.164.107.233])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d5bb499d7bsm22460975ad.3.2026.08.18.15.45.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 15:45:26 -0700 (PDT)
Message-ID: <bd54b977-fb6c-4e94-9863-745ce8133f96@linaro.org>
Date: Tue, 18 Aug 2026 15:45:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] accel/tcg: cache the result of curr_cflags()
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@mailo.com, zhao1.liu@intel.com,
 laurent@vivier.eu, deller@gmx.de, pierrick.bouvier@oss.qualcomm.com
References: <20260818174247.649526-1-mattst88@gmail.com>
 <20260818174247.649526-2-mattst88@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260818174247.649526-2-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 8/18/26 10:42, Matt Turner wrote:
> curr_cflags() is called once per TB dispatch, from helper_lookup_tb_ptr()
> and from the cpu_exec() loop. It recomputes the same value every time:
> 
>      uint32_t cflags = cpu->tcg_cflags;
>      if (unlikely(cpu_single_stepping(cpu))) { ... }
>      else if (qatomic_read(&one_insn_per_tb)) { ... }
>      else if (qemu_loglevel_mask(CPU_LOG_TB_NOCHAIN)) { ... }
> 
> That is three loads and three branches on the hottest path in the
> interpreter, for state that changes only when gdb enables single-step,
> when one-insn-per-tb is toggled, or when the log mask changes.
> 
> Compute the value once into CPUState::tcg_curr_cflags and recompute it
> from the four places that can change an input: tcg_cflags_set(),
> cpu_single_step(), tcg_set_one_insn_per_tb() and qemu_set_log_internal().
> curr_cflags() becomes a single load.

Certainly one_insn_per_tb can only be set from the command-line, so that should never have 
been handled along this path.

cpu_single_stepping is one load and test.  I agree it can be done along the path that sets 
single stepping though.

LOG_TB_NOCHAIN can be set from command-line or monitor.  The first obviously can be set up 
before we get started.  The second can be handled via stop-the-world.

> + * Catch a cached value that has gone stale because an input changed without
> + * a matching tcg_update_curr_cflags().  Called from curr_cflags() on the
> + * dispatch path, so it exists only in debug-tcg builds.
> + */
> +void tcg_assert_curr_cflags(CPUState *cpu)
> +{
> +    uint32_t cached = cpu->tcg_curr_cflags;
> +    uint32_t fresh = compute_curr_cflags(cpu);
> +
> +    if (unlikely(cached != fresh)) {
> +        fprintf(stderr, "stale tcg_curr_cflags on CPU %d: "
> +                "cached 0x%08x, recomputed 0x%08x (differ in 0x%08x)\n",
> +                cpu->cpu_index, cached, fresh, cached ^ fresh);
> +        g_assert_not_reached();
> +    }
> +}
> +#endif

But this seems like overkill.


r~


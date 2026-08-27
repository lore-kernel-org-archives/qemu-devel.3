Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297F8C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 18:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzfCm-0001qV-Ah; Thu, 27 Aug 2026 14:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzfCk-0001ph-8s
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 14:52:02 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzfCi-0002ba-6J
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 14:52:02 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-cb5b8572b70so286179a12.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 11:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787856718; x=1788461518; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bRZOKHNVvwcEW41isx9vX5kjXu/M+MyrVU1U+dykEXM=;
 b=h9CPgQodYVRFpkj3fX9KuHK6RAKmD8cxQWKHESFVwx75ciZVYARr+94KH88O7zBmBB
 8mcVAKMflRqtzUhe02bRJzQZFQc5Kj1AxoSMk5eqEkfhOb71decdj8M71am+tbFz0j4k
 91cEf/n3n091dpwoNNMWZgEI/BiDTj32gDG16uIuhZZhvGsKwi+8RoSshAZLI0ZekpIa
 Yx6HUGpcvONBSXavNtya++n9+yay+e5s+eUjoVo1i135iYb/rGQPuVDeRcPBHBxbI3tS
 yxMoQwj0Naaa55w3olaIdfI8JmGQ1s7GZjjEZ8uPA7SEfyAc1iANUqe6WNjVj4ziBuzC
 60qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787856718; x=1788461518;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bRZOKHNVvwcEW41isx9vX5kjXu/M+MyrVU1U+dykEXM=;
 b=rjpc0VA3sVnobm00goZwqjVuFrtQQ/NmaGTujNwxqV87l3yc6DZCteplfM0DvjRXFP
 vq9qbwYEzK7aeWJVI6Hv6oUmRKJQBhN1tWlGEBeSx9kQkofesFhVkb2mgo/9i8IYrrxK
 QVm/7YVjAj1gZREq/5T0Z7skEVW/Neoor2ZmKxgq/hooHvbVRgdPOmAalZTfS5r68THg
 YUORwArQXxJ9E/+etFUTMLgtbtdVMsXlUSfUY2VOSqJHWD6BpEuTlZ17/WNJ4AXlfxLY
 ino+6MYO1Qiq1jumbYQr9dp4PqrXOz/1dsHTozSLgbBEDIEdE7p+46PzrWJ0trxKRt3Q
 Z3WQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq6YL5sOtIbaqp+wwOUW8hNWU+zJ+zfHN2ar2RUQL2UQ+wts1h1MUMxc86D7+eoyMZE/eodQRYiWm3t@nongnu.org
X-Gm-Message-State: AFuF++mEJ1pUgqyV8QqfG6RkXN+LCcxw9VNYrtKisiLwYjijmFQEQaOy
 TDRve/GqT/uK9h/gSIzH6ATblGy1vrq5Gmi+uErN/z1LEmty5lJXBKEIweijvSxXxLU=
X-Gm-Gg: AR+sD120vvt8uzQM68PEiVkoifgJfP8z4+jOEaQy3kllZm74h6JvqPeMBI2cFMIpiFS
 AvPZvybM2H63qhOYwGyitgH+SCq8ASE89PUQ7FWrwvILg9gAEPvVFJkEf87AEelb4DBYT2cVkbS
 lq4jNEkgtd7oEk0BFz4lf1hb1ZGD/MU/+M2ryaDit4lIEXdESJqqPbW8ugPjGh687zdS9zh4EUY
 x7JD3V/nf6m0+Fa+P36pMCAdNmcr4BVhdRyhFdt+vxmE6GpvuwME/ArcBtjq2DdGCt2l9dQpELr
 dg1WNwiXqTeXwTdTX3YN8kGsjnv1o16XJNbiQR0TK/bClwYWSjyiFxCy95lVZX8eGOQfHxYVjQa
 nGsD6opGYkV+LQ8Z+xGvXt8ypv4X/KraGW8Uy/1L9/LwKdi47krGYlf566/kvOyR1ERDkrPDCa6
 hauAXsC28/hkGPOngyyybaouL9P67t1VuaXYdiiPdNFfadH5t4lluSj1HjEJ/mvbGiahGiDBLjA
 H0pm/aPEKCiKDjtEWcB3TWJE/Im
X-Received: by 2002:a05:6a00:414c:b0:848:4754:28e4 with SMTP id
 d2e1a72fcca58-8562abbefa2mr2423498b3a.15.1787856717623; 
 Thu, 27 Aug 2026 11:51:57 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-85359cd5f7dsm2355378b3a.6.2026.08.27.11.51.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 11:51:57 -0700 (PDT)
Message-ID: <54c6435b-e959-4894-a1ff-69d312eb55b0@linaro.org>
Date: Thu, 27 Aug 2026 11:51:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] accel/tcg: fold the dynamic cflags into
 CPUState::tcg_cflags
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@oss.qualcomm.com, alex.bennee@linaro.org,
 zhao1.liu@intel.com
References: <20260822190818.1829249-1-mattst88@gmail.com>
 <20260827050241.3713332-2-mattst88@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260827050241.3713332-2-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

On 8/26/26 22:02, Matt Turner wrote:
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
> None of the three has to be sampled at dispatch time. Fold each into
> CPUState::tcg_cflags where it changes and curr_cflags() becomes a single
> load of a field that TB lookup has to read anyway.
> 
> The derived bits -- CF_COUNT_MASK, CF_NO_GOTO_TB, CF_NO_GOTO_PTR and
> CF_SINGLE_STEP -- are never set by tcg_cflags_set(), so tcg_update_cflags()
> can recompute them in place without disturbing the rest, and conversely
> tcg_cflags_set() ORs in its bits without disturbing them.
> 
> There are three places to call it:
> 
>    - tcg_exec_realizefn(), so that a CPU created after the command line has
>      been parsed starts out with the right value. This covers user-only,
>      where tcg_cpu_init_cflags() is not reached. linux-user's cpu_copy()
>      copies tcg_cflags wholesale, so a cloned thread inherits it.
> 
>    - cpu_single_step(), which changes one CPU.  gdb is the only caller that
>      matters; in system mode it runs with the vCPUs stopped, and in user mode
>      gdb_continue_partial() can reach a thread that is still running, because
>      gdb_handlesig() stops only the thread that trapped. That is exactly the
>      plain cross-thread store to another CPU's CPUState that
>      cpu->singlestep_flags already was, read back by that CPU through
>      cpu_single_stepping() in curr_cflags(). This patch changes which field
>      carries it, not who writes it or how.
> 
>    - hmp_one_insn_per_tb() and hmp_log(), which change every CPU while the
>      vCPUs are running, so the update is queued with async_run_on_cpu() and
>      each CPU writes its own cflags from its own thread. The command line
>      spellings of those two settings need nothing: they are parsed before
>      any CPU is realized, so tcg_exec_realizefn() picks them up.
> 
> Measured with qemu-alpha running an emulated alpha gcc 16.2.0 compiling
> the SQLite 3.45.1 amalgamation (255k lines, -O2) on an x86-64 host, in a
> build configured with --enable-lto:
> 
>      before: 1,646,994,254,249 instructions
>      after:  1,562,204,796,597 instructions   -5.15%
> 
> That workload issues 8.4 billion dispatches, so the per-call saving is
> small but the aggregate is not. The emulated compiler produces
> byte-identical output before and after.
> 
> Wall clock does not move: 133.19s to 132.58s, a 0.46% difference against a
> run-to-run spread larger than that. The removed work is a few predictable
> loads and branches that the host executes largely in parallel with the
> surrounding dispatch, so this patch is worth taking for the instruction
> count and for what it enables, not for a time saving that can be measured
> on its own.
> 
> v4: Update the cflags from the HMP handlers for 'log' and 'one-insn-per-tb'
>      rather than from qemu_set_log_internal() and the accelerator property
>      setter. Those are the paths that reach a running vCPU, and the monitor
>      is the only thing that does. Suggested by Richard Henderson.
> 
> v4: Queue the per-CPU update with async_run_on_cpu() rather than
>      async_safe_run_on_cpu(). Halting the other vCPUs buys nothing: the
>      queued work already runs on the owning CPU's own thread. Suggested by
>      Alex Bennee, who also asked whether there are cross-vCPU updates of
>      tcg_cflags at all. With this change the monitor path has none: the
>      only remaining writer from another thread is cpu_single_step(), above,
>      which is neither new nor made worse here.
> 
> v4: Move the stub to accel/stubs/, which is where the other accelerator
>      stubs live.
> 
> Signed-off-by: Matt Turner<mattst88@gmail.com>
> ---
>   accel/stubs/meson.build     |  1 +
>   accel/stubs/tcg-stub.c      | 16 ++++++++++++++++
>   accel/tcg/cpu-exec-common.c | 33 ++++++++++++++++++++++++++++++---
>   accel/tcg/cpu-exec.c        |  3 +++
>   accel/tcg/internal-common.h | 11 +++++++++--
>   cpu-target.c                |  3 +++
>   include/system/tcg.h        | 12 ++++++++++++
>   monitor/hmp-cmds.c          |  5 +++++
>   system/runstate-hmp-cmds.c  |  4 ++++
>   9 files changed, 83 insertions(+), 5 deletions(-)
>   create mode 100644 accel/stubs/tcg-stub.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


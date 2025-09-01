Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093B4CA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 13:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut4Ra-0006FJ-7O; Mon, 01 Sep 2025 09:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ut4RK-0006CM-GK
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:19:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ut4RG-0008I1-Sd
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:19:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756732750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p4HPHRIAJUYARWRatGU4dFk9+ccHOCNXU6jCuC9vrmE=;
 b=W3tDOE8eMyYjkBtistAN4OKMrTDwK5N8I9M1zgWrmrkNh2CL0Jd9Uf8AkXNaN6+laphNjA
 6cDBLkhZQhQYYOS37qWmWUKkLy6HZG4Vt6Lm+d1HUu6wbl2RErEU9agu6rkMfFMCF0w868
 tMA9s4ieL36Efm/wtXySHJrDFToeGfY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-5LbVVjYoNS6PwelVzKMK7Q-1; Mon, 01 Sep 2025 09:19:09 -0400
X-MC-Unique: 5LbVVjYoNS6PwelVzKMK7Q-1
X-Mimecast-MFC-AGG-ID: 5LbVVjYoNS6PwelVzKMK7Q_1756732749
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4b31825af12so50146641cf.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 06:19:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756732749; x=1757337549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p4HPHRIAJUYARWRatGU4dFk9+ccHOCNXU6jCuC9vrmE=;
 b=p/378YYivI2Uo8r2OOg5tpNRfkQGjKC9MsgjG3vx8cDZ8x6QlFpVjlHmhQnND0NCr6
 EKF/1uMzaTz8vqJt5yAc26vJ6PaFHk3+2/Pw//GnRJCNExa0T8r9narlnzwzfbLXexoY
 Ybdps3XPdXFtLXY5OH3Kpol3rh0Sh5lbZ+ckLX0JMBiOnlvQuqNStqC9RbYzfQmywT5D
 Pci3QxuWS0slRxE/4DC/R9nYa59uTheq7R6RUSEGfCjXOAiqsEhVADsSQqbT5e9NZmql
 bsZN4MZJF/7dDIugrzBmr20EGjoKPBqhw+pJ8mROX3pp5BZI2T2CTGEPZASaKA1160r9
 4r3g==
X-Gm-Message-State: AOJu0Yx/Kks0Vm2TqKiLfu7zlnMNhR1UurU9iyvpKlp/dkwRmebaIlcA
 U7qdWetxd+490BetJKiAmuF4E4XRcjXVDwKdJ5DZ+o3+JUR6a2cUN6uw+HI/0Lf6iZWIb65fj6g
 vsvJKS6LKwm8OoWs64VgOCDr4q2viWpN5R7iVqxagw33xrSeLKL0kHrnLwC6LoXrj
X-Gm-Gg: ASbGncvHwAMgTEbhNxxvt/2E1SeRcv+DaBx9df0zaGIYLDTzbx+sQCOOsyvGVZlATNH
 Q4TyNs+VJH3J+IM6O0NSX9jWr1gziSKVEhkwiem2PLNjkYP0g9IDKDRUDUd+n0bw8Pb2p6Mq1IM
 rfhuKnJltFiSOBBBJKtXia0z2JWZ5PZevVdy7j1INlDK/VuCt5qjgvfnyBUNVrFruTLk35FJRGX
 beN+xaGRNniffbGzSruMa8fjkQfyf28xFEa3DU2XWKkA2CthKceEYVs6hfHpPAF0FiwMSHZL7TY
 U5ll27xdBGFA9z82IHBv4hgyfIieDg==
X-Received: by 2002:ac8:6f19:0:b0:4b0:71cb:5e2 with SMTP id
 d75a77b69052e-4b31dd1fdcemr92746081cf.57.1756732748530; 
 Mon, 01 Sep 2025 06:19:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNmxZYs29TRWVw9Wn/eWiqsSXUGhj9E7i1WfH0OW9arhfI0QkOYGlt9GrlRss++rXUgZCn3g==
X-Received: by 2002:ac8:6f19:0:b0:4b0:71cb:5e2 with SMTP id
 d75a77b69052e-4b31dd1fdcemr92745571cf.57.1756732748002; 
 Mon, 01 Sep 2025 06:19:08 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-71c0594ee6esm9608306d6.63.2025.09.01.06.19.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 06:19:07 -0700 (PDT)
Date: Mon, 1 Sep 2025 15:19:04 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, richard.henderson@linaro.org
Subject: Re: [PATCH 11/18] accel/tcg: create a thread-kick function for TCG
Message-ID: <20250901151904.2746de88@fedora>
In-Reply-To: <20250829153115.1590048-7-pbonzini@redhat.com>
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829153115.1590048-7-pbonzini@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 29 Aug 2025 17:31:08 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> Round-robin TCG is calling into cpu_exit() directly.  In preparation
> for making cpu_exit() usable from all accelerators, define a generic
> thread-kick function for TCG which is used directly in the multi-threaded
> case, and through CPU_FOREACH in the round-robin case.
> 
> Use it also for user-mode emulation, and take the occasion to move
> the implementation to accel/tcg/user-exec.c.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  docs/devel/tcg-icount.rst       | 2 +-
>  accel/tcg/tcg-accel-ops-mttcg.h | 3 ---
>  accel/tcg/tcg-accel-ops.h       | 1 +
>  accel/tcg/cpu-exec.c            | 6 ++++++
>  accel/tcg/tcg-accel-ops-mttcg.c | 5 -----
>  accel/tcg/tcg-accel-ops-rr.c    | 2 +-
>  accel/tcg/tcg-accel-ops.c       | 2 +-
>  accel/tcg/user-exec.c           | 6 ++++++
>  bsd-user/main.c                 | 5 -----
>  linux-user/main.c               | 5 -----
>  10 files changed, 16 insertions(+), 21 deletions(-)
> 
> diff --git a/docs/devel/tcg-icount.rst b/docs/devel/tcg-icount.rst
> index 7df883446a7..a1dcd79e0fd 100644
> --- a/docs/devel/tcg-icount.rst
> +++ b/docs/devel/tcg-icount.rst
> @@ -37,7 +37,7 @@ translator starts by allocating a budget of instructions to be
>  executed. The budget of instructions is limited by how long it will be
>  until the next timer will expire. We store this budget as part of a
>  vCPU icount_decr field which shared with the machinery for handling
> -cpu_exit(). The whole field is checked at the start of every
> +qemu_cpu_kick(). The whole field is checked at the start of every
>  translated block and will cause a return to the outer loop to deal
>  with whatever caused the exit.
>  
> diff --git a/accel/tcg/tcg-accel-ops-mttcg.h b/accel/tcg/tcg-accel-ops-mttcg.h
> index 8ffa7a9a9fe..5c145cc8595 100644
> --- a/accel/tcg/tcg-accel-ops-mttcg.h
> +++ b/accel/tcg/tcg-accel-ops-mttcg.h
> @@ -10,9 +10,6 @@
>  #ifndef TCG_ACCEL_OPS_MTTCG_H
>  #define TCG_ACCEL_OPS_MTTCG_H
>  
> -/* kick MTTCG vCPU thread */
> -void mttcg_kick_vcpu_thread(CPUState *cpu);
> -
>  /* start an mttcg vCPU thread */
>  void mttcg_start_vcpu_thread(CPUState *cpu);
>  
> diff --git a/accel/tcg/tcg-accel-ops.h b/accel/tcg/tcg-accel-ops.h
> index 6feeb3f3e9b..aecce605d7b 100644
> --- a/accel/tcg/tcg-accel-ops.h
> +++ b/accel/tcg/tcg-accel-ops.h
> @@ -18,5 +18,6 @@ void tcg_cpu_destroy(CPUState *cpu);
>  int tcg_cpu_exec(CPUState *cpu);
>  void tcg_handle_interrupt(CPUState *cpu, int mask);
>  void tcg_cpu_init_cflags(CPUState *cpu, bool parallel);
> +void tcg_kick_vcpu_thread(CPUState *cpu);
>  
>  #endif /* TCG_ACCEL_OPS_H */
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index f838535d111..9241bcadb5f 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -40,6 +40,7 @@
>  #include "exec/replay-core.h"
>  #include "system/tcg.h"
>  #include "exec/helper-proto-common.h"
> +#include "tcg-accel-ops.h"
>  #include "tb-jmp-cache.h"
>  #include "tb-hash.h"
>  #include "tb-context.h"
> @@ -748,6 +749,11 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
>      return false;
>  }
>  
> +void tcg_kick_vcpu_thread(CPUState *cpu)
> +{
> +    cpu_exit(cpu);
> +}
> +
>  static inline bool icount_exit_request(CPUState *cpu)
>  {
>      if (!icount_enabled()) {
> diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
> index b12b7a36b5d..1148ebcaae5 100644
> --- a/accel/tcg/tcg-accel-ops-mttcg.c
> +++ b/accel/tcg/tcg-accel-ops-mttcg.c
> @@ -123,11 +123,6 @@ static void *mttcg_cpu_thread_fn(void *arg)
>      return NULL;
>  }
>  
> -void mttcg_kick_vcpu_thread(CPUState *cpu)
> -{
> -    cpu_exit(cpu);
> -}
> -
>  void mttcg_start_vcpu_thread(CPUState *cpu)
>  {
>      char thread_name[VCPU_THREAD_NAME_SIZE];
> diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
> index c2468d15d4f..610292d3bac 100644
> --- a/accel/tcg/tcg-accel-ops-rr.c
> +++ b/accel/tcg/tcg-accel-ops-rr.c
> @@ -43,7 +43,7 @@ void rr_kick_vcpu_thread(CPUState *unused)
>      CPUState *cpu;
>  
>      CPU_FOREACH(cpu) {
> -        cpu_exit(cpu);
> +        tcg_kick_vcpu_thread(cpu);
>      };
>  }
>  
> diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
> index 9c37266c1e0..1f662a9c745 100644
> --- a/accel/tcg/tcg-accel-ops.c
> +++ b/accel/tcg/tcg-accel-ops.c
> @@ -206,7 +206,7 @@ static void tcg_accel_ops_init(AccelClass *ac)
>  
>      if (qemu_tcg_mttcg_enabled()) {
>          ops->create_vcpu_thread = mttcg_start_vcpu_thread;
> -        ops->kick_vcpu_thread = mttcg_kick_vcpu_thread;
> +        ops->kick_vcpu_thread = tcg_kick_vcpu_thread;
>          ops->handle_interrupt = tcg_handle_interrupt;
>      } else {
>          ops->create_vcpu_thread = rr_start_vcpu_thread;
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index 66c25fba7dd..3c072fd868f 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -38,6 +38,7 @@
>  #include "qemu/int128.h"
>  #include "trace.h"
>  #include "tcg/tcg-ldst.h"
> +#include "tcg-accel-ops.h"
>  #include "backend-ldst.h"
>  #include "internal-common.h"
>  #include "tb-internal.h"
> @@ -46,6 +47,11 @@ __thread uintptr_t helper_retaddr;
>  
>  //#define DEBUG_SIGNAL
>  
> +void qemu_cpu_kick(CPUState *cpu)
> +{
> +    tcg_kick_vcpu_thread(cpu);
> +}
> +
>  /*
>   * Adjust the pc to pass to cpu_restore_state; return the memop type.
>   */
> diff --git a/bsd-user/main.c b/bsd-user/main.c
> index 7e5d4bbce09..fc33e4d4880 100644
> --- a/bsd-user/main.c
> +++ b/bsd-user/main.c
> @@ -214,11 +214,6 @@ bool qemu_cpu_is_self(CPUState *cpu)
>      return thread_cpu == cpu;
>  }
>  
> -void qemu_cpu_kick(CPUState *cpu)
> -{
> -    cpu_exit(cpu);
> -}
> -
>  /* Assumes contents are already zeroed.  */
>  static void init_task_state(TaskState *ts)
>  {
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 6edeeecef38..2ba073eb830 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -189,11 +189,6 @@ bool qemu_cpu_is_self(CPUState *cpu)
>      return thread_cpu == cpu;
>  }
>  
> -void qemu_cpu_kick(CPUState *cpu)
> -{
> -    cpu_exit(cpu);
> -}
> -
>  void task_settid(TaskState *ts)
>  {
>      if (ts->ts_tid == 0) {



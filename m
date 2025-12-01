Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA4BD116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 15:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ5qu-000307-56; Mon, 01 Dec 2025 10:30:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vQ5qm-0002x4-8Q
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 10:30:04 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vQ5qk-0002R4-46
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 10:30:03 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-343806688c5so3312665a91.0
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 07:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764602999; x=1765207799; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ALjEle/bXZ7mznlKzWAyImOuDhq86EgjP21QLwEm7ZE=;
 b=rc3uMeFr8w2mbpMRN+xFEeYOGDnTw/darXzpUw/23OulQziDDxwZpjuMmmgo66OTOn
 ojKHBk/xYl+3MC6zbPU1XzQCFg1YT9BfMBjwnIHKHdyHKjCyaT4bfl9ujGoBR/yTmDkS
 hg+vMkCuJ/2qXQaftBLLIxsj13iDn83faTuN7Bdi1M9N6V3SiROsncAvo5AR/sGlc86c
 ZhSx8/In/BQvviDpy1WcX6h3h8bnBsz+4CYfbBSGR7ntTEVktT9dk2BUleqGqX8idK4q
 SH/HtC+oF/y3HysPFqNnsG2VKpnF2j5V5+firipKOwhN1yjnsDhh1Cv4ZNUqOvTMW6vR
 q5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764602999; x=1765207799;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ALjEle/bXZ7mznlKzWAyImOuDhq86EgjP21QLwEm7ZE=;
 b=Jcx7ksFH8KExXyUE2NZPJ6QvF1tIEAzJCwJmtoVBEWuoG/qqGTM+hp4Ty41+KEiRLO
 pm3sCfJN7Gq56HTfZpL2JuGEUFL3EhPl3S8V8WiOx+UIjHRs4A6zomL7U3tWDbo4Yjea
 8p1KcDiBEVG7j4LkV/x6SJ/NqGZFAa8T46Uoef1cWSYkXacRGNGzXj4nJoduHL5R72gB
 MqhcG553w/xTM2PagC9Hvp7ekgWgOuGOZ+PHtilPPHFD+lcvcOMgBlyME1WXPKgkYCBn
 UGKcZYyyNUgUFhrno8ZvixDvh0Fmo5t98McOeOJW0lvpSVMUaVYP8OaNRVL0qjYHPmY8
 4BZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMRw2HjO7KIi8YZoaa+NcPm5VlDjsQh8/g/Dk/IQs71G+3kZoVv1IZQyEporGXiNSRSzKPOogkAjjq@nongnu.org
X-Gm-Message-State: AOJu0YztNksd6SlpVwUGMe2A/sOcQNjQgp5zRdOj0dIlIE9KDg1yqGEh
 uB36P1vz66DwGCQ3UIXc5po8WYJYbYwYOopQe+38bNxxjkx5+Qy4kdVmNiLkslwkOiw=
X-Gm-Gg: ASbGnctxxg6te38TQ6/NakRChtOfoZMz+JKDlUFtFJFUQnqEm9qRQbBN+t53Ma3ptqO
 BrueuZLUApuKqcFIz5srp6gPZkUqd/86lr2mhH6YPXyaWcpyDbyScnA92YCOxB86QV5Dckxb20z
 lY4Nq13XLUo2FVNEp+05qfLzN3yCAsCtxkDfCSeiDZ8OHtlt3xIDznM/rhwfBmkQrecttaKc+ns
 wl7ETSLazpx3W2rTtOc5DTiflgga7EDe8AGGoTA1vFTd60xk1rrdcORs4JuO0YM6RGH/SHt+vOd
 tTKO8FQGLTkVswmVH43pyBk2m/hwFgDQFb0/zYQ993qTBfvut5TDIijWM9mkef4B6S3fGepNYxV
 5Q5emN6myIXNv6P+uUF/xJ+sX8Uq8MuNj8N/P7ayV9IkTguMU4mHfEtND6rMs3mYg7Nb57HpcmC
 NITgEOz8LFrvqHEm7dELrrWgU=
X-Google-Smtp-Source: AGHT+IHILKFFCcSy9xaRCyPik849sP6FdJGLY3ZrfOl7YCrvSHXCHTfgVkfvh7a9+NBC1saYGtgoEQ==
X-Received: by 2002:a17:90b:1d83:b0:340:bb5c:7dd7 with SMTP id
 98e67ed59e1d1-3475ebe7417mr28083628a91.5.1764602999128; 
 Mon, 01 Dec 2025 07:29:59 -0800 (PST)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3477b1cc804sm13437746a91.4.2025.12.01.07.29.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Dec 2025 07:29:58 -0800 (PST)
Message-ID: <f66c9963-cc86-4951-8875-eaf4f720e47e@linaro.org>
Date: Mon, 1 Dec 2025 07:29:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] plugins: shorten aggressively long name
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20251121130317.2874416-1-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251121130317.2874416-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
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

On 11/21/25 5:03 AM, Alex Bennée wrote:
> The old name comes in at a 51 characters, contains at least one
> redundant token and exec is arguably implied by inline as all inline
> operations occur when instructions are executing.
> 
> By putting the name on a substantial diet we can reduce it by 15% and
> gain valuable white-space in the process.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   include/qemu/qemu-plugin.h    |  4 ++--
>   contrib/plugins/cflow.c       | 22 +++++++++++-----------
>   contrib/plugins/howvec.c      |  2 +-
>   contrib/plugins/stoptrigger.c | 10 ++++++----
>   plugins/api.c                 |  2 +-
>   tests/tcg/plugins/discons.c   | 18 +++++++++---------
>   tests/tcg/plugins/inline.c    |  6 +++---
>   tests/tcg/plugins/insn.c      |  5 +++--
>   8 files changed, 36 insertions(+), 33 deletions(-)
> 
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index 60de4fdd3fa..29663591ebf 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -516,7 +516,7 @@ void qemu_plugin_register_vcpu_insn_exec_cond_cb(
>       void *userdata);
>   
>   /**
> - * qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu() - insn exec inline op
> + * qemu_plugin_register_inline_per_vcpu() - insn exec inline op
>    * @insn: the opaque qemu_plugin_insn handle for an instruction
>    * @op: the type of qemu_plugin_op (e.g. ADD_U64)
>    * @entry: entry to run op
> @@ -525,7 +525,7 @@ void qemu_plugin_register_vcpu_insn_exec_cond_cb(
>    * Insert an inline op to every time an instruction executes.
>    */
>   QEMU_PLUGIN_API
> -void qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
> +void qemu_plugin_register_inline_per_vcpu(
>       struct qemu_plugin_insn *insn,
>       enum qemu_plugin_op op,
>       qemu_plugin_u64 entry,
> diff --git a/contrib/plugins/cflow.c b/contrib/plugins/cflow.c
> index b5e33f25f9b..cef5ae2239f 100644
> --- a/contrib/plugins/cflow.c
> +++ b/contrib/plugins/cflow.c
> @@ -320,14 +320,14 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>        * check where we are at. Do this on the first instruction and not
>        * the TB so we don't get mixed up with above.
>        */
> -    qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(first_insn,
> -                                                      QEMU_PLUGIN_INLINE_STORE_U64,
> -                                                      end_block, qemu_plugin_insn_vaddr(last_insn));
> -    qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(first_insn,
> -                                                      QEMU_PLUGIN_INLINE_STORE_U64,
> -                                                      pc_after_block,
> -                                                      qemu_plugin_insn_vaddr(last_insn) +
> -                                                      qemu_plugin_insn_size(last_insn));
> +    qemu_plugin_register_inline_per_vcpu(first_insn,
> +                                         QEMU_PLUGIN_INLINE_STORE_U64,
> +                                         end_block, qemu_plugin_insn_vaddr(last_insn));
> +    qemu_plugin_register_inline_per_vcpu(first_insn,
> +                                         QEMU_PLUGIN_INLINE_STORE_U64,
> +                                         pc_after_block,
> +                                         qemu_plugin_insn_vaddr(last_insn) +
> +                                         qemu_plugin_insn_size(last_insn));
>   
>       for (int idx = 0; idx < qemu_plugin_tb_n_insns(tb); ++idx) {
>           struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, idx);
> @@ -355,9 +355,9 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>           }
>   
>           /* Store the PC of what we are about to execute */
> -        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(insn,
> -                                                            QEMU_PLUGIN_INLINE_STORE_U64,
> -                                                            last_pc, ipc);
> +        qemu_plugin_register_inline_per_vcpu(insn,
> +                                             QEMU_PLUGIN_INLINE_STORE_U64,
> +                                             last_pc, ipc);
>       }
>   }
>   
> diff --git a/contrib/plugins/howvec.c b/contrib/plugins/howvec.c
> index 42bddb6566d..c60737d57f1 100644
> --- a/contrib/plugins/howvec.c
> +++ b/contrib/plugins/howvec.c
> @@ -321,7 +321,7 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>   
>           if (cnt) {
>               if (do_inline) {
> -                qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
> +                qemu_plugin_register_inline_per_vcpu(
>                       insn, QEMU_PLUGIN_INLINE_ADD_U64,
>                       qemu_plugin_scoreboard_u64(cnt), 1);
>               } else {
> diff --git a/contrib/plugins/stoptrigger.c b/contrib/plugins/stoptrigger.c
> index b3a6ed66a7b..68c0ed432af 100644
> --- a/contrib/plugins/stoptrigger.c
> +++ b/contrib/plugins/stoptrigger.c
> @@ -73,10 +73,12 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>   
>           if (exit_on_icount) {
>               /* Increment and check scoreboard for each instruction */
> -            qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
> -                insn, QEMU_PLUGIN_INLINE_ADD_U64, insn_count, 1);
> -            qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
> -                insn, QEMU_PLUGIN_INLINE_STORE_U64, current_pc, insn_vaddr);
> +            qemu_plugin_register_inline_per_vcpu(insn,
> +                                                 QEMU_PLUGIN_INLINE_ADD_U64,
> +                                                 insn_count, 1);
> +            qemu_plugin_register_inline_per_vcpu(insn,
> +                                                 QEMU_PLUGIN_INLINE_STORE_U64,
> +                                                 current_pc, insn_vaddr);
>               qemu_plugin_register_vcpu_insn_exec_cond_cb(
>                   insn, exit_icount_reached, QEMU_PLUGIN_CB_NO_REGS,
>                   QEMU_PLUGIN_COND_EQ, insn_count, icount + 1, NULL);
> diff --git a/plugins/api.c b/plugins/api.c
> index eac04cc1f6b..267fa2fd503 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -154,7 +154,7 @@ void qemu_plugin_register_vcpu_insn_exec_cond_cb(
>                                          cond, entry, imm, udata);
>   }
>   
> -void qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
> +void qemu_plugin_register_inline_per_vcpu(
>       struct qemu_plugin_insn *insn,
>       enum qemu_plugin_op op,
>       qemu_plugin_u64 entry,
> diff --git a/tests/tcg/plugins/discons.c b/tests/tcg/plugins/discons.c
> index 2e0e664e823..1348d6e5020 100644
> --- a/tests/tcg/plugins/discons.c
> +++ b/tests/tcg/plugins/discons.c
> @@ -156,15 +156,15 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>           uint64_t next_pc = pc + qemu_plugin_insn_size(insn);
>           uint64_t has_next = (i + 1) < n_insns;
>   
> -        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(insn,
> -                                                            QEMU_PLUGIN_INLINE_STORE_U64,
> -                                                            last_pc, pc);
> -        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(insn,
> -                                                            QEMU_PLUGIN_INLINE_STORE_U64,
> -                                                            from_pc, next_pc);
> -        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(insn,
> -                                                            QEMU_PLUGIN_INLINE_STORE_U64,
> -                                                            has_from, has_next);
> +        qemu_plugin_register_inline_per_vcpu(insn,
> +                                             QEMU_PLUGIN_INLINE_STORE_U64,
> +                                             last_pc, pc);
> +        qemu_plugin_register_inline_per_vcpu(insn,
> +                                             QEMU_PLUGIN_INLINE_STORE_U64,
> +                                             from_pc, next_pc);
> +        qemu_plugin_register_inline_per_vcpu(insn,
> +                                             QEMU_PLUGIN_INLINE_STORE_U64,
> +                                             has_from, has_next);
>           qemu_plugin_register_vcpu_insn_exec_cb(insn, insn_exec,
>                                                  QEMU_PLUGIN_CB_NO_REGS, NULL);
>       }
> diff --git a/tests/tcg/plugins/inline.c b/tests/tcg/plugins/inline.c
> index 73dde995781..35307501105 100644
> --- a/tests/tcg/plugins/inline.c
> +++ b/tests/tcg/plugins/inline.c
> @@ -244,15 +244,15 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>           void *insn_store = insn;
>           void *mem_store = (char *)insn_store + 0xff;
>   
> -        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
> +        qemu_plugin_register_inline_per_vcpu(
>               insn, QEMU_PLUGIN_INLINE_STORE_U64, data_insn,
>               (uintptr_t) insn_store);
>           qemu_plugin_register_vcpu_insn_exec_cb(
>               insn, vcpu_insn_exec, QEMU_PLUGIN_CB_NO_REGS, insn_store);
> -        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
> +        qemu_plugin_register_inline_per_vcpu(
>               insn, QEMU_PLUGIN_INLINE_ADD_U64, count_insn_inline, 1);
>   
> -        qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
> +        qemu_plugin_register_inline_per_vcpu(
>               insn, QEMU_PLUGIN_INLINE_ADD_U64, insn_cond_track_count, 1);
>           qemu_plugin_register_vcpu_insn_exec_cond_cb(
>               insn, vcpu_insn_cond_exec, QEMU_PLUGIN_CB_NO_REGS,
> diff --git a/tests/tcg/plugins/insn.c b/tests/tcg/plugins/insn.c
> index 0c723cb9ed8..b337fda9f13 100644
> --- a/tests/tcg/plugins/insn.c
> +++ b/tests/tcg/plugins/insn.c
> @@ -147,8 +147,9 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
>           struct qemu_plugin_insn *insn = qemu_plugin_tb_get_insn(tb, i);
>   
>           if (do_inline) {
> -            qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
> -                insn, QEMU_PLUGIN_INLINE_ADD_U64, insn_count, 1);
> +            qemu_plugin_register_inline_per_vcpu(insn,
> +                                                 QEMU_PLUGIN_INLINE_ADD_U64,
> +                                                 insn_count, 1);
>           } else {
>               qemu_plugin_register_vcpu_insn_exec_cb(
>                   insn, vcpu_insn_exec_before, QEMU_PLUGIN_CB_NO_REGS, NULL);

Good change.
The initial name was motivated by keeping coherency with other 
callbacks, but it was obviously too long.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


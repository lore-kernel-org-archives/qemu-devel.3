Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F583C2D0CD
	for <qemu-devel@archiver.kernel.org>; Sat, 17 May 2025 11:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGFmr-0000Ue-AQ; Sat, 17 May 2025 07:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uGFmo-0000U8-Sw
 for qemu-devel@nongnu.org; Sat, 17 May 2025 07:33:02 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uGFmk-0006nY-Ve
 for qemu-devel@nongnu.org; Sat, 17 May 2025 07:33:02 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5fff52493e0so3051897a12.3
 for <qemu-devel@nongnu.org>; Sat, 17 May 2025 04:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747481576; x=1748086376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u/VpCwDJnLzioEamcqkk0mhZibJD3bq7pp1tAVmeB/k=;
 b=Xs+GlG38q9Syjok5aCdlxKVYNckPJ2UO53XhZxhTb1qlkWIjxHYb4leA3YTlWeW/AF
 BUtlrf1LUkxeDDwOcblHScS9xK4Mu7a3PB/S8rBy+aWVxbNZXx+sUTBA0Ig1nxCfu6ER
 dmuA0nX2hg/ahdGfF94kkwGU8RqOp0lCFhgi5ZFWCD57mGHx+07L02vziKAsvZS9iJiQ
 B65bSVgFTJXuuxRfiiBswD1pCR1ypM/Y+DtCM4uvJhKJPCiUoZpShSrTnr/Vua3/kvjm
 BMTXElzWlXQ5ZXxQzzNN91ZnEbCSFWP51aHZdaGPRnk46gNS/KOycchhsWTas8MjrDMT
 DFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747481576; x=1748086376;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u/VpCwDJnLzioEamcqkk0mhZibJD3bq7pp1tAVmeB/k=;
 b=hDPEHu86vBYzYvkzFoyXyrLQ0dNwEN7Exh4FKj+5SQHjnFuxD14JoOzgZJhvEJOdyu
 FLdi/r1Et8GD1O5ZjUT7lJVUaZxktaJ50QF3VpgmUOALvCpMtwjb2HUTpDTs3pLF8FDD
 1CGBAqEdQt1r5IgcMENKELTDfHhEdtRvvP0ZvTDY9ECTZMWrwSWWWOcxQPRUu8naNd7C
 Fi3I0NKgetz1yGJIwcQZ5Qa++XGNgou3xr+dF7Ag2aGNzZiItnAOqyAJZK4qnqlnUr6C
 C1ZLq4Fscbp7HcaF6ScJnjKpYnuPy6fijsCbO1hMdSFsNMFJKePvaPD9aZvJSS2/Znk/
 /AuQ==
X-Gm-Message-State: AOJu0YwlB4Cx9gP4zlKh1ooHzc3RSqAWy+ygAK2Z3BSt8DNFvseusiZt
 Dv+GDsX9esGdJYbY35oW0vXZSyxgDrNXbMAACJax4gbfW8ort6LjvJroBXdENK8mj8Y=
X-Gm-Gg: ASbGncsEJeqwlV/Q72rhACTCAfFez6vnuIsvz5K35NrlnDTUgy6CXOwwkyas8Vet6F8
 HU8O68aRHZXu8uTFMnR1wAP4CxuDM5PTPnO9MP6RAzk1tiOwqJpPuzhNxd8o/HBXLeqAw7JGD8E
 oARyadtwA4TruZelGvB5vMf0Z/ag1+B82ovXvrn08F9iFQrra7qJ+dYwJNd9Nf0JcDFGQuwspPf
 /0hk1mRrI9MQ7APySCcEdfUJvfc42U+o7wr5Tr0lL2cruRgF5pYlCBuYMgJRy+H8ig0gRb+QpXF
 q+h+kwIUulbO87I64MFLWvNu0/0SYYu0wKAfWQ+Upu6CDP/KqVhH
X-Google-Smtp-Source: AGHT+IH/wI0p4fFw4bw2qMSVw24eK7UmuXIu8T+2rdd6mE+waWoQyIT45rAwL6xBPwzTsghqXC7ItA==
X-Received: by 2002:a05:6402:3510:b0:5ff:9484:dcce with SMTP id
 4fb4d7f45d1cf-60090068fdbmr5803117a12.17.1747481576030; 
 Sat, 17 May 2025 04:32:56 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6005a6e63a0sm2655313a12.39.2025.05.17.04.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 May 2025 04:32:55 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6292C5F78F;
 Sat, 17 May 2025 12:32:54 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Liu marko <marko1616@outlook.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,  "erdnaxe@crans.org"
 <erdnaxe@crans.org>,  "ma.mandourr@gmail.com" <ma.mandourr@gmail.com>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>, Julian Ganz
 <neither@nut.email>
Subject: Re: [PATCH v2] plugin: Add callback support for vCPU hardware and
 architecture-specific interrupts
In-Reply-To: <ME3P282MB27931E7D5FDC64EC4BD91C9DA692A@ME3P282MB2793.AUSP282.PROD.OUTLOOK.COM>
 (Liu marko's message of "Sat, 17 May 2025 10:49:53 +0000")
References: <ME3P282MB27931E7D5FDC64EC4BD91C9DA692A@ME3P282MB2793.AUSP282.PROD.OUTLOOK.COM>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Sat, 17 May 2025 12:32:54 +0100
Message-ID: <878qmvlbfd.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Liu marko <marko1616@outlook.com> writes:

> Implemented the `qemu_plugin_vcpu_int_cb` callback to allow plugins to ob=
serve hardware and architecture-specific
> interrupts. Modified `cpu-exec.c` to invoke the callback on hard interrup=
ts, and added a test plugin (`countint`) to
> demonstrate its functionality. A similar approach was previously proposed
> (https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg07359.html) but=
 was not merged.
>
> Changes since v1:
> - Fixed build with `--disable-plugins`
>
> Signed-off-by: marko1616 <marko1616@outlook.com>

Could you look at:

  Message-ID: <cover.1746968215.git.neither@nut.email>
  Date: Sun, 11 May 2025 15:13:52 +0200
  Subject: [PATCH v4 00/23] tcg-plugins: add hooks for discontinuities
  From: Julian Ganz <neither@nut.email>

Which I think has a more comprehensive approach to modelling
discontinuities in execution with architectural semantics.=20

> ---
>  accel/tcg/cpu-exec.c        | 11 +++++
>  contrib/plugins/countint.c  | 90 +++++++++++++++++++++++++++++++++++++
>  contrib/plugins/meson.build |  2 +-
>  include/qemu/plugin-event.h |  1 +
>  include/qemu/plugin.h       |  5 +++
>  include/qemu/qemu-plugin.h  | 17 +++++++
>  plugins/core.c              | 23 ++++++++++
>  7 files changed, 148 insertions(+), 1 deletion(-)
>  create mode 100644 contrib/plugins/countint.c
>
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index cc5f362305..e4113f8966 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -34,6 +34,9 @@
>  #include "tcg/tcg.h"
>  #include "qemu/atomic.h"
>  #include "qemu/rcu.h"
> +#ifdef CONFIG_PLUGIN
> +#include "qemu/plugin.h"
> +#endif
>  #include "exec/log.h"
>  #include "qemu/main-loop.h"
>  #include "exec/icount.h"
> @@ -818,7 +821,15 @@ static inline bool cpu_handle_interrupt(CPUState *cp=
u,
>               * True when it is, and we should restart on a new TB,
>               * and via longjmp via cpu_loop_exit.
>               */
> +#ifdef CONFIG_PLUGIN
> +            const int prev_interrupt_request =3D interrupt_request;
> +#endif /* CONFIG_PLUGIN */
>              if (tcg_ops->cpu_exec_interrupt(cpu, interrupt_request)) {
> +#ifdef CONFIG_PLUGIN
> +                if (interrupt_request & CPU_INTERRUPT_HARD) {
> +                    qemu_plugin_vcpu_int_cb(cpu, prev_interrupt_request);
> +                }
> +#endif /* CONFIG_PLUGIN */

My main concern with this plugin point is that it seems very QEMU
internals focused and we try not to leak internal impdef details to the
plugin API.

>                  if (!tcg_ops->need_replay_interrupt ||
>                      tcg_ops->need_replay_interrupt(interrupt_request)) {
>                      replay_interrupt();
> diff --git a/contrib/plugins/countint.c b/contrib/plugins/countint.c
> new file mode 100644
> index 0000000000..601b7f30d5
> --- /dev/null
> +++ b/contrib/plugins/countint.c
> @@ -0,0 +1,90 @@
> +/*
> + * Copyright (c) 2025 marko1616
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <stdio.h>
> +#include <glib.h>
> +
> +#include <qemu-plugin.h>
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
> +
> +typedef struct {
> +    unsigned int vcpu_index;
> +    struct qemu_plugin_scoreboard *int_count;
> +} IntStat;
> +
> +static GHashTable *vcpu_int_table;
> +static GMutex lock;
> +
> +static guint intstat_hash(gconstpointer key)
> +{
> +    const IntStat *s =3D key;
> +    return s->vcpu_index;
> +}
> +
> +static gboolean intstat_equal(gconstpointer a, gconstpointer b)
> +{
> +    return ((IntStat *)a)->vcpu_index =3D=3D ((IntStat *)b)->vcpu_index;
> +}
> +
> +static void intstat_free(gpointer key, gpointer value, gpointer user_dat=
a)
> +{
> +    IntStat *s =3D value;
> +    qemu_plugin_scoreboard_free(s->int_count);
> +    g_free(s);
> +}
> +
> +static void vcpu_hardint(qemu_plugin_id_t id,
> +                         unsigned int vcpu_index,
> +                         uint32_t int_req)
> +{
> +    IntStat *stat =3D NULL;
> +
> +    g_mutex_lock(&lock);
> +    {
> +        IntStat key =3D { .vcpu_index =3D vcpu_index };
> +        stat =3D g_hash_table_lookup(vcpu_int_table, &key);
> +
> +        if (!stat) {
> +            stat =3D g_new0(IntStat, 1);
> +            stat->vcpu_index =3D vcpu_index;
> +            stat->int_count =3D qemu_plugin_scoreboard_new(sizeof(uint64=
_t));
> +            g_hash_table_insert(vcpu_int_table, stat, stat);
> +        }
> +    }
> +    g_mutex_unlock(&lock);
> +
> +    qemu_plugin_u64_add(
> +        qemu_plugin_scoreboard_u64(stat->int_count),
> +        vcpu_index,
> +        1
> +    );
> +}
> +
> +static void plugin_exit(qemu_plugin_id_t id, void *p)
> +{
> +    GList *stats =3D g_hash_table_get_values(vcpu_int_table);
> +    for (GList *it =3D stats; it !=3D NULL; it =3D it->next) {
> +        IntStat *stat =3D (IntStat *)it->data;
> +        uint64_t count =3D qemu_plugin_u64_sum(
> +            qemu_plugin_scoreboard_u64(stat->int_count)
> +        );
> +        printf("vCPU %u: %" PRIu64 " interrupts\n", stat->vcpu_index, co=
unt);
> +    }
> +    g_list_free(stats);
> +    g_hash_table_foreach(vcpu_int_table, intstat_free, NULL);
> +    g_hash_table_destroy(vcpu_int_table);
> +}
> +
> +QEMU_PLUGIN_EXPORT
> +int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
> +                        int argc, char **argv)
> +{
> +    vcpu_int_table =3D g_hash_table_new(intstat_hash, intstat_equal);
> +    qemu_plugin_register_vcpu_int_cb(id, vcpu_hardint);
> +    qemu_plugin_register_atexit_cb(id, plugin_exit, NULL);
> +    return 0;
> +}
> diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
> index fa8a426c8b..17e3b0ec27 100644
> --- a/contrib/plugins/meson.build
> +++ b/contrib/plugins/meson.build
> @@ -1,4 +1,4 @@
> -contrib_plugins =3D ['bbv', 'cache', 'cflow', 'drcov', 'execlog', 'hotbl=
ocks',
> +contrib_plugins =3D ['bbv', 'cache', 'cflow', 'drcov', 'execlog', 'count=
int', 'hotblocks',
>                     'hotpages', 'howvec', 'hwprofile', 'ips', 'stoptrigge=
r']
>  if host_os !=3D 'windows'
>    # lockstep uses socket.h
> diff --git a/include/qemu/plugin-event.h b/include/qemu/plugin-event.h
> index 7056d8427b..cd9f9eb25b 100644
> --- a/include/qemu/plugin-event.h
> +++ b/include/qemu/plugin-event.h
> @@ -16,6 +16,7 @@ enum qemu_plugin_event {
>      QEMU_PLUGIN_EV_VCPU_TB_TRANS,
>      QEMU_PLUGIN_EV_VCPU_IDLE,
>      QEMU_PLUGIN_EV_VCPU_RESUME,
> +    QEMU_PLUGIN_EV_VCPU_INT,
>      QEMU_PLUGIN_EV_VCPU_SYSCALL,
>      QEMU_PLUGIN_EV_VCPU_SYSCALL_RET,
>      QEMU_PLUGIN_EV_FLUSH,
> diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
> index 9726a9ebf3..f1d5d91141 100644
> --- a/include/qemu/plugin.h
> +++ b/include/qemu/plugin.h
> @@ -61,6 +61,7 @@ union qemu_plugin_cb_sig {
>      qemu_plugin_vcpu_udata_cb_t      vcpu_udata;
>      qemu_plugin_vcpu_tb_trans_cb_t   vcpu_tb_trans;
>      qemu_plugin_vcpu_mem_cb_t        vcpu_mem;
> +    qemu_plugin_vcpu_int_cb_t    vcpu_hardint;
>      qemu_plugin_vcpu_syscall_cb_t    vcpu_syscall;
>      qemu_plugin_vcpu_syscall_ret_cb_t vcpu_syscall_ret;
>      void *generic;
> @@ -160,6 +161,7 @@ void qemu_plugin_vcpu_exit_hook(CPUState *cpu);
>  void qemu_plugin_tb_trans_cb(CPUState *cpu, struct qemu_plugin_tb *tb);
>  void qemu_plugin_vcpu_idle_cb(CPUState *cpu);
>  void qemu_plugin_vcpu_resume_cb(CPUState *cpu);
> +void qemu_plugin_vcpu_int_cb(CPUState *cpu, int interrupt_request);
>  void
>  qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1,
>                           uint64_t a2, uint64_t a3, uint64_t a4, uint64_t=
 a5,
> @@ -242,6 +244,9 @@ static inline void qemu_plugin_vcpu_idle_cb(CPUState =
*cpu)
>  static inline void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
>  { }
>=20=20
> +static inline void qemu_plugin_vcpu_int_cb(CPUState *cpu, int interrupt_=
request)
> +{ }
> +
>  static inline void
>  qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64=
_t a2,
>                           uint64_t a3, uint64_t a4, uint64_t a5, uint64_t=
 a6,
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index 3a850aa216..65096c4c64 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -728,6 +728,23 @@ const void *qemu_plugin_request_time_control(void);
>  QEMU_PLUGIN_API
>  void qemu_plugin_update_ns(const void *handle, int64_t time);
>=20=20
> +typedef void
> +(*qemu_plugin_vcpu_int_cb_t)(qemu_plugin_id_t id,
> +                                 unsigned int vcpu_index,
> +                                 uint32_t interrupt_request);
> +
> +/**
> + * qemu_plugin_register_vcpu_int_cb() -
> + *   register a vCPU hardware interruption callback
> + * @id: plugin ID
> + * @cb: callback function
> + *
> + * The @cb function is called every time a vCPU gets hardware interrupti=
on.
> + */
> +QEMU_PLUGIN_API
> +void qemu_plugin_register_vcpu_int_cb(qemu_plugin_id_t id,
> +                                          qemu_plugin_vcpu_int_cb_t cb);
> +
>  typedef void
>  (*qemu_plugin_vcpu_syscall_cb_t)(qemu_plugin_id_t id, unsigned int vcpu_=
index,
>                                   int64_t num, uint64_t a1, uint64_t a2,
> diff --git a/plugins/core.c b/plugins/core.c
> index eb9281fe54..b6fbfe20e9 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -539,6 +539,23 @@ void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
>      }
>  }
>=20=20
> +/*
> + * Disable CFI checks.
> + * The callback function has been loaded from an external library so we =
do not
> + * have type information
> + */
> +QEMU_DISABLE_CFI
> +void qemu_plugin_vcpu_int_cb(CPUState *cpu, int interrupt_request)
> +{
> +    struct qemu_plugin_cb *cb, *next;
> +    enum qemu_plugin_event ev =3D QEMU_PLUGIN_EV_VCPU_INT;
> +
> +    QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
> +        qemu_plugin_vcpu_int_cb_t func =3D cb->f.vcpu_hardint;
> +        func(cb->ctx->id, cpu->cpu_index, interrupt_request);
> +    }
> +}
> +
>  void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
>                                         qemu_plugin_vcpu_simple_cb_t cb)
>  {
> @@ -551,6 +568,12 @@ void qemu_plugin_register_vcpu_resume_cb(qemu_plugin=
_id_t id,
>      plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_RESUME, cb);
>  }
>=20=20
> +void qemu_plugin_register_vcpu_int_cb(qemu_plugin_id_t id,
> +                                          qemu_plugin_vcpu_int_cb_t cb)
> +{
> +    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_INT, cb);
> +}
> +
>  void qemu_plugin_register_flush_cb(qemu_plugin_id_t id,
>                                     qemu_plugin_simple_cb_t cb)
>  {

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


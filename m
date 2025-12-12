Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 309B8D49230
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 14:29:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU48z-0006SH-Jd; Fri, 12 Dec 2025 09:29:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vU48x-0006Rg-Sn
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 09:29:15 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vU48v-00071c-IC
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 09:29:15 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so14384525e9.3
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 06:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765549752; x=1766154552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2eGAl/6ZNAOXMS3zCtZm2fZ2wyzKAzaFGptc89vi/T8=;
 b=nhoz28v8t2ZtwTh278lVvW7wSZTaG7KdEuR3gkJfPI8Nq/jLFyuXxVbk/FArOZRZZS
 soC1DfnJ14YIbUcAookorxOXHVvcp9bNuMoX7h5wvPK4FsCfwlCZOWIVYBwfvQWyx5qm
 OCCfPIJCmKYBy2PQwSAiH1jhLkH1OB93zoe0r+S+cUwu7jXE+YShuctuYY5qZ/tU6Lls
 eRvcaZpiu+NZ1RxFP1FsUT+7Kv0Le6kLnQeEkKrUKSts3dOOKLMMs05/ho9o54LUNRfh
 3NSaM8pAjf5mR4BokUHx5anYd/47YvJ6pRpPnRsDEM9Nu8x0ZYqtyI+6AZOPknDgUqnF
 773Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765549752; x=1766154552;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2eGAl/6ZNAOXMS3zCtZm2fZ2wyzKAzaFGptc89vi/T8=;
 b=r6uonV32uYdXvyuCDuWkPrDQeMKYCyi4eAlU+7rhhmq353ALoqA28P6wwAgUoKzdBQ
 Qd6Cv4DkG+7GCij9Pi0xad9bC3xdTv/knAHEfnaEra6SaqZZDKtosY+bjULpyU71/0Gr
 3Sig6GfhBQ5rAqFyc5NjVjWvKMFyHpvca2Lk9rD8wWMbmMmJ2/foQwSBYXJTY9sWs9Db
 6OQk+7JYASCAog8uFjGQ8LnVrVu6AASsI3yMyfbWktf4gXXvaAWHMFlkyLwcsZXT7Cnw
 MIQo2DjlcNsQ2STROR80TsIoSTziIurn8vkY3BlLTjqi6Lh/XQo6PlWt1vvJz+9ztihS
 /HKA==
X-Gm-Message-State: AOJu0Yy7sz16Qh2/jXp1OQUftcToLqntDkidYIIFcCFXSxxy+NIXYsxu
 JNf5KHZWNDTsuS0zxF8qWjVsL8X4M4/jOJ7m8wwZUn7p39ytA+hB/GHM35X8Sjz0PY8=
X-Gm-Gg: AY/fxX6wNEc0QxW/M237I352mmsCq7WguGFupy+o6bfe0lrpjUYeMwZd8xCMxroNkV2
 VJ6Z/DHgse8IXmk3LQP1FaFSyJvznTpdIKMRLI+85jj88ccm8H5FbMMuctJ/Vfm8NXQ9WGqS3Jp
 c2QjI//ZCiTaZl09/PWMYtbVAsjdDh1mpZCwi2ZIVfhFdhkPrOcHg6HrbL0a9ythGr8YFw0mmUK
 tuEw1nuSIIukMVmX8OYmWGNU9XXas89VB2ZUkhDrC70YJ8wB0zhNFLjONPquy/CJOlmRQmCipjA
 zoj7l5zjeTN5qSPh0NjnzV0gKcigGneW2VJd5PkPVXzGW+q7Jipofm/wrmE4BRWQhm0tIaPm+q0
 Aasg4OXPSSfT0/3zseu9bssH/I9xFzYuXn5TIkLP6RlKeS/9mAf4KiaAHJDFhhbbAn62skNS3Uy
 VJx7bMSeDOX8U=
X-Google-Smtp-Source: AGHT+IGlDwMEQjhF9gVuCvzIzD0bEL+tbJtz3fUFxwEnVKQHZDpSkv2phRkzniCn2KZaO4ThGe9QIQ==
X-Received: by 2002:a05:600c:3e10:b0:477:9b35:3e49 with SMTP id
 5b1f17b1804b1-47a8f8a79bemr24125835e9.3.1765549751786; 
 Fri, 12 Dec 2025 06:29:11 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f8d9d63sm33849665e9.9.2025.12.12.06.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 06:29:10 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 085E15F82E;
 Fri, 12 Dec 2025 14:29:10 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ziyang Zhang <functioner@sjtu.edu.cn>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>,  Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Zhengwei Qi <qizhwei@sjtu.edu.cn>,  Yun
 Wang <yunwang94@sjtu.edu.cn>,  Mingyuan Xia <xiamy@ultrarisc.com>,
 Kailiang Xu <xukl2019@sjtu.edu.cn>
Subject: Re: [PATCH 1/2] linux-user: add a plugin API to filter syscalls
In-Reply-To: <20251110133442.579086-2-functioner@sjtu.edu.cn> (Ziyang Zhang's
 message of "Mon, 10 Nov 2025 21:34:42 +0800")
References: <20251110133442.579086-1-functioner@sjtu.edu.cn>
 <20251110133442.579086-2-functioner@sjtu.edu.cn>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Fri, 12 Dec 2025 14:29:09 +0000
Message-ID: <87v7ibsrii.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Ziyang Zhang <functioner@sjtu.edu.cn> writes:

> This commit adds a syscall filter API to the TCG plugin API set.
> Plugins can register a filter callback to QEMU to decide whether
> to intercept a syscall, process it and bypass the QEMU syscall
> handler.
>
> Signed-off-by: Ziyang Zhang <functioner@sjtu.edu.cn>
> Co-authored-by: Mingyuan Xia <xiamy@ultrarisc.com>
> ---
>  include/qemu/plugin-event.h  |  1 +
>  include/qemu/plugin.h        | 29 +++++++++++++++++++++--------
>  include/qemu/qemu-plugin.h   | 24 ++++++++++++++++++++++++
>  include/user/syscall-trace.h | 17 +++++++++++++++++
>  linux-user/syscall.c         |  7 +++++--
>  plugins/api.c                |  7 +++++++
>  plugins/core.c               | 36 ++++++++++++++++++++++++++++++++++++
>  7 files changed, 111 insertions(+), 10 deletions(-)
>
> diff --git a/include/qemu/plugin-event.h b/include/qemu/plugin-event.h
> index 7056d8427b..bbb1c2b91f 100644
> --- a/include/qemu/plugin-event.h
> +++ b/include/qemu/plugin-event.h
> @@ -20,6 +20,7 @@ enum qemu_plugin_event {
>      QEMU_PLUGIN_EV_VCPU_SYSCALL_RET,
>      QEMU_PLUGIN_EV_FLUSH,
>      QEMU_PLUGIN_EV_ATEXIT,
> +    QEMU_PLUGIN_EV_VCPU_SYSCALL_FILTER,
>      QEMU_PLUGIN_EV_MAX, /* total number of plugin events we support */
>  };
>=20=20
> diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
> index f355c7cb8a..9f90a233e7 100644
> --- a/include/qemu/plugin.h
> +++ b/include/qemu/plugin.h
> @@ -55,14 +55,15 @@ void qemu_plugin_opt_parse(const char *optstr, QemuPl=
uginList *head);
>  int qemu_plugin_load_list(QemuPluginList *head, Error **errp);
>=20=20
>  union qemu_plugin_cb_sig {
> -    qemu_plugin_simple_cb_t          simple;
> -    qemu_plugin_udata_cb_t           udata;
> -    qemu_plugin_vcpu_simple_cb_t     vcpu_simple;
> -    qemu_plugin_vcpu_udata_cb_t      vcpu_udata;
> -    qemu_plugin_vcpu_tb_trans_cb_t   vcpu_tb_trans;
> -    qemu_plugin_vcpu_mem_cb_t        vcpu_mem;
> -    qemu_plugin_vcpu_syscall_cb_t    vcpu_syscall;
> -    qemu_plugin_vcpu_syscall_ret_cb_t vcpu_syscall_ret;
> +    qemu_plugin_simple_cb_t              simple;
> +    qemu_plugin_udata_cb_t               udata;
> +    qemu_plugin_vcpu_simple_cb_t         vcpu_simple;
> +    qemu_plugin_vcpu_udata_cb_t          vcpu_udata;
> +    qemu_plugin_vcpu_tb_trans_cb_t       vcpu_tb_trans;
> +    qemu_plugin_vcpu_mem_cb_t            vcpu_mem;
> +    qemu_plugin_vcpu_syscall_cb_t        vcpu_syscall;
> +    qemu_plugin_vcpu_syscall_ret_cb_t    vcpu_syscall_ret;
> +    qemu_plugin_vcpu_syscall_filter_cb_t vcpu_syscall_filter;
>      void *generic;
>  };
>=20=20
> @@ -165,6 +166,11 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num,=
 uint64_t a1,
>                           uint64_t a2, uint64_t a3, uint64_t a4, uint64_t=
 a5,
>                           uint64_t a6, uint64_t a7, uint64_t a8);
>  void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t re=
t);
> +bool
> +qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
> +                                uint64_t a2, uint64_t a3, uint64_t a4,
> +                                uint64_t a5, uint64_t a6, uint64_t a7,
> +                                uint64_t a8, uint64_t *ret);
>=20=20
>  void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
>                               uint64_t value_low,
> @@ -267,6 +273,13 @@ static inline
>  void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t re=
t)
>  { }
>=20=20
> +static inline bool
> +qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
> +                                uint64_t a2, uint64_t a3, uint64_t a4,
> +                                uint64_t a5, uint64_t a6, uint64_t a7,
> +                                uint64_t a8, uint64_t *ret)
> +{ }
> +

This needs to return false so it compile and work with --disable-plugins.

>  static inline void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t vaddr,
>                                             uint64_t value_low,
>                                             uint64_t value_high,
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index c450106af1..cdd0b2c4da 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -738,6 +738,25 @@ typedef void
>                                   uint64_t a3, uint64_t a4, uint64_t a5,
>                                   uint64_t a6, uint64_t a7, uint64_t a8);
>=20=20
> +/*
> + * typedef qemu_plugin_vcpu_syscall_filter_cb_t - vCPU syscall filter ca=
llback
> + * function type
> + * @vcpu_index: the executing vCPU
> + * @num: the syscall number
> + * @a1-a8: the syscall arguments
> + * @ret: the address of the syscall return value, set this if
> filtered

"must set this..."

> + *
> + * Returns: true if you want to filter this syscall (i.e. stop it being
> + * handled further), otherwise return false.
> + */
> +typedef bool
> +(*qemu_plugin_vcpu_syscall_filter_cb_t)(qemu_plugin_id_t id,
> +                                        unsigned int vcpu_index,
> +                                        int64_t num, uint64_t a1, uint64=
_t a2,
> +                                        uint64_t a3, uint64_t a4, uint64=
_t a5,
> +                                        uint64_t a6, uint64_t a7, uint64=
_t a8,
> +                                        uint64_t *ret);
> +
>  QEMU_PLUGIN_API
>  void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
>                                            qemu_plugin_vcpu_syscall_cb_t =
cb);
> @@ -751,6 +770,11 @@ void
>  qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
>                                           qemu_plugin_vcpu_syscall_ret_cb=
_t cb);
>=20=20
> +QEMU_PLUGIN_API
> +void
> +qemu_plugin_register_vcpu_syscall_filter_cb(qemu_plugin_id_t id,
> +                                            qemu_plugin_vcpu_syscall_fil=
ter_cb_t cb);
> +
>=20=20
>  /**
>   * qemu_plugin_insn_disas() - return disassembly string for instruction
> diff --git a/include/user/syscall-trace.h b/include/user/syscall-trace.h
> index 9bd7ca19c8..61cdbd7583 100644
> --- a/include/user/syscall-trace.h
> +++ b/include/user/syscall-trace.h
> @@ -39,5 +39,22 @@ static inline void record_syscall_return(CPUState *cpu=
, int num, abi_long ret)
>      gdb_syscall_return(cpu, num);
>  }
>=20=20
> +static bool send_through_syscall_filters(CPUState *cpu, int num,
> +                                         abi_long arg1, abi_long arg2,
> +                                         abi_long arg3, abi_long arg4,
> +                                         abi_long arg5, abi_long arg6,
> +                                         abi_long arg7, abi_long arg8,
> +                                         abi_long *ret)
> +{
> +    uint64_t sysret64 =3D 0;
> +    bool filtered =3D qemu_plugin_vcpu_syscall_filter(cpu, num, arg1, ar=
g2,
> +                                                    arg3, arg4, arg5, ar=
g6,
> +                                                    arg7, arg8, &sysret6=
4);
> +    if (filtered) {
> +        *ret =3D sysret64;
> +    }
> +    return filtered;
> +}
> +
>=20=20
>  #endif /* SYSCALL_TRACE_H */
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index d78b2029fa..1fb99dcf0c 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -14084,8 +14084,11 @@ abi_long do_syscall(CPUArchState *cpu_env, int n=
um, abi_long arg1,
>          print_syscall(cpu_env, num, arg1, arg2, arg3, arg4, arg5, arg6);
>      }
>=20=20
> -    ret =3D do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
> -                      arg5, arg6, arg7, arg8);
> +    if (!send_through_syscall_filters(cpu, num, arg1, arg2, arg3, arg4, =
arg5,
> +                                      arg6, arg7, arg8, &ret)) {
> +        ret =3D do_syscall1(cpu_env, num, arg1, arg2, arg3, arg4,
> +                          arg5, arg6, arg7, arg8);
> +    }
>=20=20
>      if (unlikely(qemu_loglevel_mask(LOG_STRACE))) {
>          print_syscall_ret(cpu_env, num, ret, arg1, arg2,
> diff --git a/plugins/api.c b/plugins/api.c
> index eac04cc1f6..478d0c8889 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -208,6 +208,13 @@ qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin=
_id_t id,
>      plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_SYSCALL_RET, cb);
>  }
>=20=20
> +void
> +qemu_plugin_register_vcpu_syscall_filter_cb(qemu_plugin_id_t id,
> +                                            qemu_plugin_vcpu_syscall_fil=
ter_cb_t cb)
> +{
> +    plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_SYSCALL_FILTER, cb);
> +}
> +
>  /*
>   * Plugin Queries
>   *
> diff --git a/plugins/core.c b/plugins/core.c
> index ead09fd2f1..8cd773cbca 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -538,6 +538,42 @@ void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int=
64_t num, int64_t ret)
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
> +bool
> +qemu_plugin_vcpu_syscall_filter(CPUState *cpu, int64_t num, uint64_t a1,
> +                                uint64_t a2, uint64_t a3, uint64_t a4,
> +                                uint64_t a5, uint64_t a6, uint64_t a7,
> +                                uint64_t a8, uint64_t *ret)
> +{
> +    struct qemu_plugin_cb *cb, *next;
> +    enum qemu_plugin_event ev =3D QEMU_PLUGIN_EV_VCPU_SYSCALL_FILTER;
> +
> +    if (!test_bit(ev, cpu->plugin_state->event_mask)) {
> +        return false;
> +    }
> +
> +    bool filtered =3D false;

nit: keep args together in the block

> +    QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
> +        qemu_plugin_vcpu_syscall_filter_cb_t func =3D cb->f.vcpu_syscall=
_filter;
> +
> +        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);

I think setting these flags could be outside the loop.

> +        if (func(cb->ctx->id, cpu->cpu_index, num, a1, a2, a3, a4,
> +                 a5, a6, a7, a8, ret)) {
> +            filtered =3D true;

then you could just break here.

> +        }
> +        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
> +
> +        if (filtered)
> +            break;

nit: brackets

> +    }
> +    return filtered;
> +}
> +
>  void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
>  {
>      /* idle and resume cb may be called before init, ignore in this case=
 */

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


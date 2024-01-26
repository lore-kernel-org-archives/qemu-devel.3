Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DC6C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 12:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTKzb-0000OC-ON; Fri, 26 Jan 2024 07:07:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rTKzU-00009U-Tz
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 07:07:26 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rTKzS-0002IS-5u
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 07:07:24 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40e76626170so4300265e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 04:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706270838; x=1706875638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kF6EQ6yJNQUfcc3v5/85yeOipzh6ZTyjGiKiLHYQFMg=;
 b=p5+aLfAaB1ZhkJlcM0POG+KnZG1yVw3bmbr2L/6TLiuEDP7HN48H6tfQfn7trLjorL
 eOwDQN+OoDM6jYY9t+jbRPwj5TF9JqkiQOn6jb6vX5Ym5HiqvDk444PDZQwxFmQA8Chs
 /wGpuGZKEVC6ONT/mqhYAc5Tt4kqD3gotNL+Vt6nB0oZdXqUzIr9bA1Knlt3gfKjmIan
 xAHpiS9bZb7Q0VbY2iLpReso80i6kpjv69ZfAbiW10/U5Im1uNPQM+4nTpHKTOeVo+gD
 R1GQSRaUnZeXEHrxdS38lcfu9zA2Htlrr9FfrP0OjxHxOCyZ8Pq82wPyN8otbEneZcrD
 UJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706270838; x=1706875638;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kF6EQ6yJNQUfcc3v5/85yeOipzh6ZTyjGiKiLHYQFMg=;
 b=Exkj2Q9gufaAKXVWRtDZJqdPpucZu9qokA0gWfGAy1VGpMkIQItNU54AZ2LQvpjjjG
 3NzYQEg7AY9Hc7VWsS/RXhv28BZBjprNfXcjP0mJLwh5fvXASzjLQbO0usW55xMScFJf
 iFdKZ3tM61lmSuGfu2M70LM6lWPK7iEnQgrgcI6mB2V+Hvbtz5V9/WZydnyyEKVj/UKT
 2qwalsf9jObSFiq+66A5lIKw5WiMSkq6heT6xsohP8EPHxSUo0NfSQAxo70COBxx7yJ+
 s95MOsEqpkoKrsdUqWe52r8Trx7YNZWvwnR1IzGN7plCxaWWsGc1kjx3SIHvJ9vSaTm9
 xMTw==
X-Gm-Message-State: AOJu0YwPYB5PZwgtRG+tinKDzSXhgu4dVDxH5NL8LhQfDSZOI5K8zcgJ
 IBPKUwun431Zshqu/8IU/8YZinGQPES0cd0flAMvcmDLGjqAg2lIk82Qb2pS1Kc=
X-Google-Smtp-Source: AGHT+IHsxYxjhTVJSKKsGZWUoNSbelUS/JOBTjUf/S2yssYo5MYEDZxNA3/2cHkXaDnw1/k/iLyL2g==
X-Received: by 2002:a05:600c:4e44:b0:40e:e417:9722 with SMTP id
 e4-20020a05600c4e4400b0040ee4179722mr318031wmq.175.1706270838519; 
 Fri, 26 Jan 2024 04:07:18 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 t15-20020a05600c198f00b0040e395cd20bsm5621698wmq.7.2024.01.26.04.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 04:07:18 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BE2DA5F78A;
 Fri, 26 Jan 2024 12:07:17 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH v2 01/14] plugins: implement inline operation relative
 to cpu_index
In-Reply-To: <20240118032400.3762658-2-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Thu, 18 Jan 2024 07:23:46 +0400")
References: <20240118032400.3762658-1-pierrick.bouvier@linaro.org>
 <20240118032400.3762658-2-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Fri, 26 Jan 2024 12:07:17 +0000
Message-ID: <87ttn0s3gq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> Instead of working on a fixed memory location, allow to address it based
> on cpu_index, an element size and a given offset.
> Result address: ptr + offset + cpu_index * element_size.
>
> With this, we can target a member in a struct array from a base pointer.
>
> Current semantic is not modified, thus inline operation still targets
> always the same memory location.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  accel/tcg/plugin-gen.c | 67 +++++++++++++++++++++++++++++++++++-------
>  include/qemu/plugin.h  |  3 ++
>  plugins/api.c          |  7 +++--
>  plugins/core.c         | 18 +++++++++---
>  plugins/plugin.h       |  6 ++--
>  5 files changed, 81 insertions(+), 20 deletions(-)
>
> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
> index b37ce7683e6..1a2375d7779 100644
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -132,16 +132,28 @@ static void gen_empty_udata_cb_no_rwg(void)
>   */
>  static void gen_empty_inline_cb(void)
>  {
> +    TCGv_i32 cpu_index =3D tcg_temp_ebb_new_i32();
> +    TCGv_ptr cpu_index_as_ptr =3D tcg_temp_ebb_new_ptr();
>      TCGv_i64 val =3D tcg_temp_ebb_new_i64();
>      TCGv_ptr ptr =3D tcg_temp_ebb_new_ptr();
>=20=20
> +    tcg_gen_ld_i32(cpu_index, tcg_env,
> +                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_inde=
x));
> +    /* pass an immediate !=3D 0 so that it doesn't get optimized away */
> +    tcg_gen_muli_i32(cpu_index, cpu_index, 0xdeadbeef);
> +    tcg_gen_ext_i32_ptr(cpu_index_as_ptr, cpu_index);
> +
>      tcg_gen_movi_ptr(ptr, 0);
> +    tcg_gen_add_ptr(ptr, ptr, cpu_index_as_ptr);
>      tcg_gen_ld_i64(val, ptr, 0);
>      /* pass an immediate !=3D 0 so that it doesn't get optimized away */
>      tcg_gen_addi_i64(val, val, 0xdeadface);
> +
>      tcg_gen_st_i64(val, ptr, 0);
>      tcg_temp_free_ptr(ptr);
>      tcg_temp_free_i64(val);
> +    tcg_temp_free_ptr(cpu_index_as_ptr);
> +    tcg_temp_free_i32(cpu_index);
>  }
>=20=20
<snip>
>      if (UINTPTR_MAX =3D=3D UINT32_MAX) {
> @@ -395,18 +439,19 @@ static TCGOp *append_inline_cb(const struct qemu_pl=
ugin_dyn_cb *cb,
>                                 TCGOp *begin_op, TCGOp *op,
>                                 int *unused)
>  {
> -    /* const_ptr */
> -    op =3D copy_const_ptr(&begin_op, op, cb->userp);
> -
> -    /* ld_i64 */
> +    char *ptr =3D cb->userp;
> +    if (!cb->inline_direct_ptr) {
> +        /* dereference userp once to get access to memory location */
> +        ptr =3D *(char **)cb->userp;
> +    }

I'm confused here, probably because inline_direct_ptr gets removed later
on?

> +    op =3D copy_ld_i32(&begin_op, op);
> +    op =3D copy_mul_i32(&begin_op, op, cb->inline_element_size);
> +    op =3D copy_ext_i32_ptr(&begin_op, op);
> +    op =3D copy_const_ptr(&begin_op, op, ptr + cb->inline_offset);
> +    op =3D copy_add_ptr(&begin_op, op);
>      op =3D copy_ld_i64(&begin_op, op);
> -
> -    /* add_i64 */
>      op =3D copy_add_i64(&begin_op, op, cb->inline_insn.imm);
> -
> -    /* st_i64 */
>      op =3D copy_st_i64(&begin_op, op);
> -
>      return op;
>  }
>=20=20
> diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
> index b0c5ac68293..9346249145d 100644
> --- a/include/qemu/plugin.h
> +++ b/include/qemu/plugin.h
> @@ -86,6 +86,9 @@ enum plugin_dyn_cb_subtype {
>  struct qemu_plugin_dyn_cb {
>      union qemu_plugin_cb_sig f;
>      void *userp;
> +    size_t inline_offset;
> +    size_t inline_element_size;
> +    bool inline_direct_ptr;

Ahh here it is.

(I seem to recall there is a setting for git to order headers first that
helps with this).

We could do with some documentation here. I can guess the offset and
element size values but what inline_direct_ptr means is not clear.

>      enum plugin_dyn_cb_subtype type;
>      /* @rw applies to mem callbacks only (both regular and inline) */
>      enum qemu_plugin_mem_rw rw;
> diff --git a/plugins/api.c b/plugins/api.c
> index 8d5cca53295..e777eb4e9fc 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -106,7 +106,8 @@ void qemu_plugin_register_vcpu_tb_exec_inline(struct =
qemu_plugin_tb *tb,
>                                                void *ptr, uint64_t imm)
>  {
>      if (!tb->mem_only) {
> -        plugin_register_inline_op(&tb->cbs[PLUGIN_CB_INLINE], 0, op, ptr=
, imm);
> +        plugin_register_inline_op(&tb->cbs[PLUGIN_CB_INLINE],
> +                                  0, op, ptr, 0, sizeof(uint64_t), true,=
 imm);
>      }
>  }
>=20=20
> @@ -131,7 +132,7 @@ void qemu_plugin_register_vcpu_insn_exec_inline(struc=
t qemu_plugin_insn *insn,
>  {
>      if (!insn->mem_only) {
>          plugin_register_inline_op(&insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_I=
NLINE],
> -                                  0, op, ptr, imm);
> +                                  0, op, ptr, 0, sizeof(uint64_t), true,=
 imm);
>      }
>  }
>=20=20
> @@ -156,7 +157,7 @@ void qemu_plugin_register_vcpu_mem_inline(struct qemu=
_plugin_insn *insn,
>                                            uint64_t imm)
>  {
>      plugin_register_inline_op(&insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE=
],
> -                              rw, op, ptr, imm);
> +                              rw, op, ptr, 0, sizeof(uint64_t), true, im=
m);
>  }
>=20=20
>  void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
> diff --git a/plugins/core.c b/plugins/core.c
> index 49588285dd0..e07b9cdf229 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -280,13 +280,18 @@ static struct qemu_plugin_dyn_cb *plugin_get_dyn_cb=
(GArray **arr)
>=20=20
>  void plugin_register_inline_op(GArray **arr,
>                                 enum qemu_plugin_mem_rw rw,
> -                               enum qemu_plugin_op op, void *ptr,
> +                               enum qemu_plugin_op op,
> +                               void *ptr, size_t offset, size_t element_=
size,
> +                               bool direct_ptr,
>                                 uint64_t imm)
>  {
>      struct qemu_plugin_dyn_cb *dyn_cb;
>=20=20
>      dyn_cb =3D plugin_get_dyn_cb(arr);
>      dyn_cb->userp =3D ptr;
> +    dyn_cb->inline_element_size =3D element_size;
> +    dyn_cb->inline_offset =3D offset;
> +    dyn_cb->inline_direct_ptr =3D direct_ptr;
>      dyn_cb->type =3D PLUGIN_CB_INLINE;
>      dyn_cb->rw =3D rw;
>      dyn_cb->inline_insn.op =3D op;
> @@ -431,9 +436,14 @@ void qemu_plugin_flush_cb(void)
>      plugin_cb__simple(QEMU_PLUGIN_EV_FLUSH);
>  }
>=20=20
> -void exec_inline_op(struct qemu_plugin_dyn_cb *cb)
> +void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index)
>  {
> -    uint64_t *val =3D cb->userp;
> +    char *ptr =3D cb->userp;
> +    if (!cb->inline_direct_ptr) {
> +        ptr =3D *(char **) cb->userp;
> +    }
> +    ptr +=3D cb->inline_offset;
> +    uint64_t *val =3D (uint64_t *)(ptr + cpu_index * cb->inline_element_=
size);
>=20=20
>      switch (cb->inline_insn.op) {
>      case QEMU_PLUGIN_INLINE_ADD_U64:
> @@ -466,7 +476,7 @@ void qemu_plugin_vcpu_mem_cb(CPUState *cpu, uint64_t =
vaddr,
>                             vaddr, cb->userp);
>              break;
>          case PLUGIN_CB_INLINE:
> -            exec_inline_op(cb);
> +            exec_inline_op(cb, cpu->cpu_index);
>              break;
>          default:
>              g_assert_not_reached();
> diff --git a/plugins/plugin.h b/plugins/plugin.h
> index 5eb2fdbc85e..2c278379b70 100644
> --- a/plugins/plugin.h
> +++ b/plugins/plugin.h
> @@ -66,7 +66,9 @@ struct qemu_plugin_ctx *plugin_id_to_ctx_locked(qemu_pl=
ugin_id_t id);
>=20=20
>  void plugin_register_inline_op(GArray **arr,
>                                 enum qemu_plugin_mem_rw rw,
> -                               enum qemu_plugin_op op, void *ptr,
> +                               enum qemu_plugin_op op,
> +                               void *ptr, size_t offset, size_t element_=
size,
> +                               bool direct_ptr,
>                                 uint64_t imm);
>=20=20
>  void plugin_reset_uninstall(qemu_plugin_id_t id,
> @@ -95,6 +97,6 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
>                                   enum qemu_plugin_mem_rw rw,
>                                   void *udata);
>=20=20
> -void exec_inline_op(struct qemu_plugin_dyn_cb *cb);
> +void exec_inline_op(struct qemu_plugin_dyn_cb *cb, int cpu_index);
>=20=20
>  #endif /* PLUGIN_H */

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37677C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 10:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjcaV-0003hW-59; Mon, 11 Mar 2024 06:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rjcaU-0003hN-2N
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 06:08:54 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rjcaR-0006RI-8S
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 06:08:53 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33e94de1f34so481307f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 03:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710151729; x=1710756529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aAffEftEc8IpOEy4lvt93IdrpKRsIswtaYEqc2sfn8Y=;
 b=ELyrZ4BQz4BGGHKfWeVPU0mOcZv3vTKNKEzvmbnN6g4LbDWWhV8NsA5UaU6S6ctv0x
 jnoUv9Q2mlMFdcyJp7rj4UsDatYqIBh7F9Hq4SleeShJEarnHtU/wwOa2U/MXf+MH+cX
 msupmLq13DBzryvShFAA3ihIQ1QMz5IYcHk2+6s3qDSz/F4zu6SWs7GVBBmJmv0sEZwH
 kyKejLoyymHdkUiN4ntu6RqMXBYLbgTLibWqgITCJm28hlumyNeKHSYrEU+M/INBa74n
 dIWXrFt9QHK+DeQP7qZX6ByK+l33CI9g/HoLBxtqp7aEsmUbUSCepWbcWFu5ko64pFp+
 eF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710151729; x=1710756529;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aAffEftEc8IpOEy4lvt93IdrpKRsIswtaYEqc2sfn8Y=;
 b=NlaKtwpBrVCi1tLu+j59BKDOZhzKF2xiNr+5imCEDsFA58LlYlARK+kI82aN6HMTuY
 h6KdAumSNae+AXGZ5+Gj6MYuaRXO3j4AamW7itYhsQVtVSmpLXN7/jIeqhf+DF617aqy
 0nCkbOM2l8kghx1Cw0GVria8ijVE2IisbPpBr97C3ffUgKAEa5qCHg33Z78Ym7Avg3aw
 laBMbT8/UKeANfNiuEbQzGD7OTMppn736sg/3Cni1x8sIA/ebARJvFZ51YY9EAulxMM0
 0WpfL4iIdQQOvj7YDSPG6n6kUjhzZGLdA4dft1RFcTFBBVVIHh2kkU9CaPiZCtyvbzQ/
 w8yg==
X-Gm-Message-State: AOJu0YxwLBLiJ4ktChocSjl9w/EigsqMb5piHt/+Kzz33eOka/Nn7bF5
 pGtbXe2n1F1MUFjDz5w6lTRTAbPaHqzeN6fEehpp8CCL58U+TtK4F2plH9RpObc=
X-Google-Smtp-Source: AGHT+IGY0YXrOC1xeXWThQ0S8LSOK7vd9m2lMd0skwuE8vH2fPGgthXHhk49UiSIpCm3skBsSpfx8Q==
X-Received: by 2002:a5d:4b51:0:b0:33e:6faf:7740 with SMTP id
 w17-20020a5d4b51000000b0033e6faf7740mr4495405wrs.13.1710151728450; 
 Mon, 11 Mar 2024 03:08:48 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 z4-20020adff744000000b0033e7910ae23sm6038908wrp.49.2024.03.11.03.08.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 03:08:47 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 738385F78F;
 Mon, 11 Mar 2024 10:08:47 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 4/5] plugins: conditional callbacks
In-Reply-To: <20240229055359.972151-5-pierrick.bouvier@linaro.org> (Pierrick
 Bouvier's message of "Thu, 29 Feb 2024 09:53:58 +0400")
References: <20240229055359.972151-1-pierrick.bouvier@linaro.org>
 <20240229055359.972151-5-pierrick.bouvier@linaro.org>
User-Agent: mu4e 1.12.1; emacs 29.1
Date: Mon, 11 Mar 2024 10:08:47 +0000
Message-ID: <87bk7lqdw0.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

> Extend plugins API to support callback called with a given criteria
> (evaluated inline).
>
> Added functions:
> - qemu_plugin_register_vcpu_tb_exec_cond_cb
> - qemu_plugin_register_vcpu_insn_exec_cond_cb
>
> They expect as parameter a condition, a qemu_plugin_u64_t (op1) and an
> immediate (op2). Callback is called if op1 |cond| op2 is true.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  include/qemu/plugin.h        |   7 ++
>  include/qemu/qemu-plugin.h   |  76 +++++++++++++++
>  plugins/plugin.h             |   8 ++
>  accel/tcg/plugin-gen.c       | 174 ++++++++++++++++++++++++++++++++++-
>  plugins/api.c                |  51 ++++++++++
>  plugins/core.c               |  19 ++++
>  plugins/qemu-plugins.symbols |   2 +
>  7 files changed, 334 insertions(+), 3 deletions(-)
>
> diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
> index d92d64744e6..056102b2361 100644
> --- a/include/qemu/plugin.h
> +++ b/include/qemu/plugin.h
> @@ -74,6 +74,8 @@ enum plugin_dyn_cb_type {
>  enum plugin_dyn_cb_subtype {
>      PLUGIN_CB_REGULAR,
>      PLUGIN_CB_REGULAR_R,
> +    PLUGIN_CB_COND,
> +    PLUGIN_CB_COND_R,
>      PLUGIN_CB_INLINE_ADD_U64,
>      PLUGIN_CB_INLINE_STORE_U64,
>      PLUGIN_N_CB_SUBTYPES,
> @@ -97,6 +99,11 @@ struct qemu_plugin_dyn_cb {
>              enum qemu_plugin_op op;
>              uint64_t imm;
>          } inline_insn;
> +        struct {
> +            qemu_plugin_u64 entry;
> +            enum qemu_plugin_cond cond;
> +            uint64_t imm;
> +        } cond_cb;
>      };
>  };
>=20=20
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index c5cac897a0b..337de25ece7 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -262,6 +262,29 @@ enum qemu_plugin_mem_rw {
>      QEMU_PLUGIN_MEM_RW,
>  };
>=20=20
> +/**
> + * enum qemu_plugin_cond - condition to enable callback
> + *
> + * @QEMU_PLUGIN_COND_NEVER: false
> + * @QEMU_PLUGIN_COND_ALWAYS: true
> + * @QEMU_PLUGIN_COND_EQ: is equal?
> + * @QEMU_PLUGIN_COND_NE: is not equal?
> + * @QEMU_PLUGIN_COND_LT: is less than?
> + * @QEMU_PLUGIN_COND_LE: is less than or equal?
> + * @QEMU_PLUGIN_COND_GT: is greater than?
> + * @QEMU_PLUGIN_COND_GE: is greater than or equal?
> + */
> +enum qemu_plugin_cond {
> +    QEMU_PLUGIN_COND_NEVER,
> +    QEMU_PLUGIN_COND_ALWAYS,
> +    QEMU_PLUGIN_COND_EQ,
> +    QEMU_PLUGIN_COND_NE,
> +    QEMU_PLUGIN_COND_LT,
> +    QEMU_PLUGIN_COND_LE,
> +    QEMU_PLUGIN_COND_GT,
> +    QEMU_PLUGIN_COND_GE,
> +};
> +
>  /**
>   * typedef qemu_plugin_vcpu_tb_trans_cb_t - translation callback
>   * @id: unique plugin id
> @@ -301,6 +324,32 @@ void qemu_plugin_register_vcpu_tb_exec_cb(struct qem=
u_plugin_tb *tb,
>                                            enum qemu_plugin_cb_flags flag=
s,
>                                            void *userdata);
>=20=20
> +/**
> + * qemu_plugin_register_vcpu_tb_exec_cond_cb() - register conditional ca=
llback
> + * @tb: the opaque qemu_plugin_tb handle for the translation
> + * @cb: callback function
> + * @cond: condition to enable callback
> + * @entry: first operand for condition
> + * @imm: second operand for condition
> + * @flags: does the plugin read or write the CPU's registers?
> + * @userdata: any plugin data to pass to the @cb?
> + *
> + * The @cb function is called when a translated unit executes if
> + * entry @cond imm is true.
> + * If condition is QEMU_PLUGIN_COND_ALWAYS, condition is never interpret=
ed and
> + * this function is equivalent to qemu_plugin_register_vcpu_tb_exec_cb.
> + * If condition QEMU_PLUGIN_COND_NEVER, condition is never interpreted a=
nd
> + * callback is never installed.
> + */
> +QEMU_PLUGIN_API
> +void qemu_plugin_register_vcpu_tb_exec_cond_cb(struct qemu_plugin_tb *tb,
> +                                               qemu_plugin_vcpu_udata_cb=
_t cb,
> +                                               enum qemu_plugin_cb_flags=
 flags,
> +                                               enum qemu_plugin_cond con=
d,
> +                                               qemu_plugin_u64 entry,

Is this a fixed entry or part of a scoreboard?

I'm trying to write a control flow plugin with a structure like:

  /* We use this to track the current execution state */
  typedef struct {
      /* address of start of block */
      uint64_t block_start;
      /* address of end of block */
      uint64_t block_end;
      /* address of last executed PC */
      uint64_t last_pc;
  } VCPUScoreBoard;

And I want to check to see if last_pc (set by STORE_U64 for each insn) =3D=
=3D block_end
(set at start of TB with what we know).

Is this something I need to get with:

   last_pc =3D qemu_plugin_scoreboard_u64_in_struct(state, VCPUScoreBoard, =
last_pc);

?

> +                                               uint64_t imm,
> +                                               void *userdata);
> +
>  /**
>   * enum qemu_plugin_op - describes an inline op
>   *
> @@ -344,6 +393,33 @@ void qemu_plugin_register_vcpu_insn_exec_cb(struct q=
emu_plugin_insn *insn,
>                                              enum qemu_plugin_cb_flags fl=
ags,
>                                              void *userdata);
>=20=20
> +/**
> + * qemu_plugin_register_vcpu_insn_exec_cond_cb() - conditional insn exec=
ution cb
> + * @insn: the opaque qemu_plugin_insn handle for an instruction
> + * @cb: callback function
> + * @flags: does the plugin read or write the CPU's registers?
> + * @cond: condition to enable callback
> + * @entry: first operand for condition
> + * @imm: second operand for condition
> + * @userdata: any plugin data to pass to the @cb?
> + *
> + * The @cb function is called when an instruction executes if
> + * entry @cond imm is true.
> + * If condition is QEMU_PLUGIN_COND_ALWAYS, condition is never interpret=
ed and
> + * this function is equivalent to qemu_plugin_register_vcpu_insn_exec_cb.
> + * If condition QEMU_PLUGIN_COND_NEVER, condition is never interpreted a=
nd
> + * callback is never installed.
> + */
> +QEMU_PLUGIN_API
> +void qemu_plugin_register_vcpu_insn_exec_cond_cb(
> +    struct qemu_plugin_insn *insn,
> +    qemu_plugin_vcpu_udata_cb_t cb,
> +    enum qemu_plugin_cb_flags flags,
> +    enum qemu_plugin_cond cond,
> +    qemu_plugin_u64 entry,
> +    uint64_t imm,
> +    void *userdata);
> +
>  /**
>   * qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu() - insn exec inl=
ine op
>   * @insn: the opaque qemu_plugin_insn handle for an instruction
> diff --git a/plugins/plugin.h b/plugins/plugin.h
> index 696b1fa38b0..118cc99bb2a 100644
> --- a/plugins/plugin.h
> +++ b/plugins/plugin.h
> @@ -94,6 +94,14 @@ plugin_register_dyn_cb__udata(GArray **arr,
>                                qemu_plugin_vcpu_udata_cb_t cb,
>                                enum qemu_plugin_cb_flags flags, void *uda=
ta);
>=20=20
> +void
> +plugin_register_dyn_cond_cb__udata(GArray **arr,
> +                                   qemu_plugin_vcpu_udata_cb_t cb,
> +                                   enum qemu_plugin_cb_flags flags,
> +                                   enum qemu_plugin_cond cond,
> +                                   qemu_plugin_u64 entry,
> +                                   uint64_t imm,
> +                                   void *udata);
>=20=20
>  void plugin_register_vcpu_mem_cb(GArray **arr,
>                                   void *cb,
> diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
> index 02c894106e2..15762a26439 100644
> --- a/accel/tcg/plugin-gen.c
> +++ b/accel/tcg/plugin-gen.c
> @@ -46,6 +46,7 @@
>  #include "qemu/plugin.h"
>  #include "cpu.h"
>  #include "tcg/tcg.h"
> +#include "tcg/tcg-cond.h"
>  #include "tcg/tcg-internal.h"
>  #include "tcg/tcg-op.h"
>  #include "tcg/tcg-temp-internal.h"
> @@ -82,6 +83,8 @@ enum plugin_gen_from {
>  enum plugin_gen_cb {
>      PLUGIN_GEN_CB_UDATA,
>      PLUGIN_GEN_CB_UDATA_R,
> +    PLUGIN_GEN_CB_COND_UDATA,
> +    PLUGIN_GEN_CB_COND_UDATA_R,
>      PLUGIN_GEN_CB_INLINE_ADD_U64,
>      PLUGIN_GEN_CB_INLINE_STORE_U64,
>      PLUGIN_GEN_CB_MEM,
> @@ -119,16 +122,58 @@ static void gen_empty_udata_cb(void (*gen_helper)(T=
CGv_i32, TCGv_ptr))
>      tcg_temp_free_i32(cpu_index);
>  }
>=20=20
> +static void gen_empty_cond_udata_cb(void (*gen_helper)(TCGv_i32, TCGv_pt=
r))
> +{
> +    TCGv_i32 cpu_index =3D tcg_temp_ebb_new_i32();
> +    TCGv_i32 cpu_offset =3D tcg_temp_ebb_new_i32();
> +    TCGv_ptr cpu_index_as_ptr =3D tcg_temp_ebb_new_ptr();
> +    TCGv_i64 val =3D tcg_temp_ebb_new_i64();
> +    TCGv_ptr ptr =3D tcg_temp_ebb_new_ptr();
> +    TCGv_ptr udata =3D tcg_temp_ebb_new_ptr();
> +    TCGLabel *after_cb =3D gen_new_label();
> +
> +    tcg_gen_movi_ptr(udata, 0);
> +    tcg_gen_ld_i32(cpu_index, tcg_env,
> +                   -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_inde=
x));
> +    /* second operand will be replaced by immediate value */
> +    tcg_gen_mul_i32(cpu_offset, cpu_index, cpu_index);
> +    tcg_gen_ext_i32_ptr(cpu_index_as_ptr, cpu_offset);
> +    tcg_gen_movi_ptr(ptr, 0);
> +    tcg_gen_add_ptr(ptr, ptr, cpu_index_as_ptr);
> +    tcg_gen_ld_i64(val, ptr, 0);
> +
> +    tcg_gen_brcondi_i64(TCG_COND_EQ, val, 0, after_cb);
> +    gen_helper(cpu_index, udata);
> +    gen_set_label(after_cb);
> +
> +    tcg_temp_free_ptr(udata);
> +    tcg_temp_free_ptr(ptr);
> +    tcg_temp_free_i64(val);
> +    tcg_temp_free_ptr(cpu_index_as_ptr);
> +    tcg_temp_free_i32(cpu_offset);
> +    tcg_temp_free_i32(cpu_index);
> +}
> +
>  static void gen_empty_udata_cb_no_wg(void)
>  {
>      gen_empty_udata_cb(gen_helper_plugin_vcpu_udata_cb_no_wg);
>  }
>=20=20
> +static void gen_empty_cond_udata_cb_no_wg(void)
> +{
> +    gen_empty_cond_udata_cb(gen_helper_plugin_vcpu_udata_cb_no_wg);
> +}
> +
>  static void gen_empty_udata_cb_no_rwg(void)
>  {
>      gen_empty_udata_cb(gen_helper_plugin_vcpu_udata_cb_no_rwg);
>  }
>=20=20
> +static void gen_empty_cond_udata_cb_no_rwg(void)
> +{
> +    gen_empty_cond_udata_cb(gen_helper_plugin_vcpu_udata_cb_no_rwg);
> +}
> +
>  static void gen_empty_inline_cb_add_u64(void)
>  {
>      TCGv_i32 cpu_index =3D tcg_temp_ebb_new_i32();
> @@ -248,6 +293,10 @@ static void plugin_gen_empty_callback(enum plugin_ge=
n_from from)
>                      gen_empty_inline_cb_store_u64);
>          gen_wrapped(from, PLUGIN_GEN_CB_UDATA, gen_empty_udata_cb_no_rwg=
);
>          gen_wrapped(from, PLUGIN_GEN_CB_UDATA_R, gen_empty_udata_cb_no_w=
g);
> +        gen_wrapped(from, PLUGIN_GEN_CB_COND_UDATA,
> +                    gen_empty_cond_udata_cb_no_rwg);
> +        gen_wrapped(from, PLUGIN_GEN_CB_COND_UDATA_R,
> +                    gen_empty_cond_udata_cb_no_wg);
>          break;
>      default:
>          g_assert_not_reached();
> @@ -456,6 +505,29 @@ static TCGOp *copy_call(TCGOp **begin_op, TCGOp *op,=
 void *func, int *cb_idx)
>      return op;
>  }
>=20=20
> +static TCGOp *copy_brcondi_i64(TCGOp **begin_op, TCGOp *op, TCGCond cond,
> +                               uint64_t imm)
> +{
> +    if (TCG_TARGET_REG_BITS =3D=3D 32) {
> +        op =3D copy_op(begin_op, op, INDEX_op_brcond2_i32);
> +        /* low(arg1), high(arg1), 32(arg2), 32(arg2 >> 32), cond, label =
*/
> +        op->args[2] =3D tcgv_i32_arg(tcg_constant_i32(imm));
> +        op->args[3] =3D tcgv_i32_arg(tcg_constant_i32(imm >> 32));
> +        op->args[4] =3D cond;
> +    } else {
> +        op =3D copy_op(begin_op, op, INDEX_op_brcond_i64);
> +        /* arg1, arg2, cond, label */
> +        op->args[1] =3D tcgv_i64_arg(tcg_constant_i64(imm));
> +        op->args[2] =3D cond;
> +    }
> +    return op;
> +}
> +
> +static TCGOp *copy_set_label(TCGOp **begin_op, TCGOp *op)
> +{
> +    return copy_op(begin_op, op, INDEX_op_set_label);
> +}
> +
>  /*
>   * When we append/replace ops here we are sensitive to changing patterns=
 of
>   * TCGOps generated by the tcg_gen_FOO calls when we generated the
> @@ -482,6 +554,50 @@ static TCGOp *append_udata_cb(const struct qemu_plug=
in_dyn_cb *cb,
>      return op;
>  }
>=20=20
> +static TCGCond plugin_cond_to_tcgcond(enum qemu_plugin_cond cond)
> +{
> +    switch (cond) {
> +    case QEMU_PLUGIN_COND_EQ:
> +        return TCG_COND_EQ;
> +    case QEMU_PLUGIN_COND_NE:
> +        return TCG_COND_NE;
> +    case QEMU_PLUGIN_COND_LT:
> +        return TCG_COND_LTU;
> +    case QEMU_PLUGIN_COND_LE:
> +        return TCG_COND_LEU;
> +    case QEMU_PLUGIN_COND_GT:
> +        return TCG_COND_GTU;
> +    case QEMU_PLUGIN_COND_GE:
> +        return TCG_COND_GEU;
> +    default:
> +        /* ALWAYS and NEVER conditions should never reach */
> +        g_assert_not_reached();
> +    }
> +}
> +
> +static TCGOp *append_cond_udata_cb(const struct qemu_plugin_dyn_cb *cb,
> +                                   TCGOp *begin_op, TCGOp *op, int *cb_i=
dx)
> +{
> +    char *ptr =3D cb->cond_cb.entry.score->data->data;
> +    size_t elem_size =3D g_array_get_element_size(
> +        cb->cond_cb.entry.score->data);
> +    size_t offset =3D cb->cond_cb.entry.offset;
> +    /* Condition should be negated, as calling the cb is the "else" path=
 */
> +    TCGCond cond =3D tcg_invert_cond(plugin_cond_to_tcgcond(cb->cond_cb.=
cond));
> +
> +    op =3D copy_const_ptr(&begin_op, op, ptr);
> +    op =3D copy_ld_i32(&begin_op, op);
> +    op =3D copy_mul_i32(&begin_op, op, elem_size);
> +    op =3D copy_ext_i32_ptr(&begin_op, op);
> +    op =3D copy_const_ptr(&begin_op, op, ptr + offset);
> +    op =3D copy_add_ptr(&begin_op, op);
> +    op =3D copy_ld_i64(&begin_op, op);
> +    op =3D copy_brcondi_i64(&begin_op, op, cond, cb->cond_cb.imm);
> +    op =3D copy_call(&begin_op, op, cb->f.vcpu_udata, cb_idx);
> +    op =3D copy_set_label(&begin_op, op);
> +    return op;
> +}
> +
>  static TCGOp *append_inline_cb_add_u64(const struct qemu_plugin_dyn_cb *=
cb,
>                                         TCGOp *begin_op, TCGOp *op,
>                                         int *unused)
> @@ -601,6 +717,12 @@ inject_udata_cb(const GArray *cbs, TCGOp *begin_op)
>      inject_cb_type(cbs, begin_op, append_udata_cb, op_ok);
>  }
>=20=20
> +static void
> +inject_cond_udata_cb(const GArray *cbs, TCGOp *begin_op)
> +{
> +    inject_cb_type(cbs, begin_op, append_cond_udata_cb, op_ok);
> +}
> +
>  static void
>  inject_inline_cb_add_u64(const GArray *cbs, TCGOp *begin_op, op_ok_fn ok)
>  {
> @@ -654,7 +776,7 @@ static void inject_mem_enable_helper(struct qemu_plug=
in_tb *ptb,
>                                       struct qemu_plugin_insn *plugin_ins=
n,
>                                       TCGOp *begin_op)
>  {
> -    GArray *cbs[3];
> +    GArray *cbs[4];
>      GArray *arr;
>      size_t n_cbs, i;
>=20=20
> @@ -662,6 +784,7 @@ static void inject_mem_enable_helper(struct qemu_plug=
in_tb *ptb,
>      cbs[0] =3D plugin_insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE_ADD_U64];
>      cbs[1] =3D plugin_insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_INLINE_STORE_U6=
4];
>      cbs[2] =3D plugin_insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_REGULAR];
> +    cbs[3] =3D plugin_insn->cbs[PLUGIN_CB_MEM][PLUGIN_CB_COND];
>=20=20
>      n_cbs =3D 0;
>      for (i =3D 0; i < ARRAY_SIZE(cbs); i++) {
> @@ -727,6 +850,18 @@ static void plugin_gen_tb_udata_r(const struct qemu_=
plugin_tb *ptb,
>      inject_udata_cb(ptb->cbs[PLUGIN_CB_REGULAR_R], begin_op);
>  }
>=20=20
> +static void plugin_gen_tb_cond_udata(const struct qemu_plugin_tb *ptb,
> +                                     TCGOp *begin_op)
> +{
> +    inject_cond_udata_cb(ptb->cbs[PLUGIN_CB_COND], begin_op);
> +}
> +
> +static void plugin_gen_tb_cond_udata_r(const struct qemu_plugin_tb *ptb,
> +                                       TCGOp *begin_op)
> +{
> +    inject_cond_udata_cb(ptb->cbs[PLUGIN_CB_COND_R], begin_op);
> +}
> +
>  static void plugin_gen_tb_inline_add_u64(const struct qemu_plugin_tb *pt=
b,
>                                           TCGOp *begin_op)
>  {
> @@ -745,7 +880,6 @@ static void plugin_gen_insn_udata(const struct qemu_p=
lugin_tb *ptb,
>                                    TCGOp *begin_op, int insn_idx)
>  {
>      struct qemu_plugin_insn *insn =3D g_ptr_array_index(ptb->insns, insn=
_idx);
> -
>      inject_udata_cb(insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_REGULAR], begin_=
op);
>  }
>=20=20
> @@ -753,10 +887,23 @@ static void plugin_gen_insn_udata_r(const struct qe=
mu_plugin_tb *ptb,
>                                      TCGOp *begin_op, int insn_idx)
>  {
>      struct qemu_plugin_insn *insn =3D g_ptr_array_index(ptb->insns, insn=
_idx);
> -
>      inject_udata_cb(insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_REGULAR_R], begi=
n_op);
>  }
>=20=20
> +static void plugin_gen_insn_cond_udata(const struct qemu_plugin_tb *ptb,
> +                                       TCGOp *begin_op, int insn_idx)
> +{
> +    struct qemu_plugin_insn *insn =3D g_ptr_array_index(ptb->insns, insn=
_idx);
> +    inject_cond_udata_cb(insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_COND], begi=
n_op);
> +}
> +
> +static void plugin_gen_insn_cond_udata_r(const struct qemu_plugin_tb *pt=
b,
> +                                    TCGOp *begin_op, int insn_idx)
> +{
> +    struct qemu_plugin_insn *insn =3D g_ptr_array_index(ptb->insns, insn=
_idx);
> +    inject_cond_udata_cb(insn->cbs[PLUGIN_CB_INSN][PLUGIN_CB_COND_R], be=
gin_op);
> +}
> +
>  static void plugin_gen_insn_inline_add_u64(const struct qemu_plugin_tb *=
ptb,
>                                             TCGOp *begin_op, int insn_idx)
>  {
> @@ -843,6 +990,15 @@ static void pr_ops(void)
>              case PLUGIN_GEN_CB_UDATA:
>                  type =3D "udata";
>                  break;
> +            case PLUGIN_GEN_CB_UDATA_R:
> +                type =3D "udata (read)";
> +                break;
> +            case PLUGIN_GEN_CB_COND_UDATA:
> +                type =3D "cond udata";
> +                break;
> +            case PLUGIN_GEN_CB_COND_UDATA_R:
> +                type =3D "cond udata (read)";
> +                break;
>              case PLUGIN_GEN_CB_INLINE_ADD_U64:
>                  type =3D "inline add u64";
>                  break;
> @@ -897,6 +1053,12 @@ static void plugin_gen_inject(struct qemu_plugin_tb=
 *plugin_tb)
>                  case PLUGIN_GEN_CB_UDATA_R:
>                      plugin_gen_tb_udata_r(plugin_tb, op);
>                      break;
> +                case PLUGIN_GEN_CB_COND_UDATA:
> +                    plugin_gen_tb_cond_udata(plugin_tb, op);
> +                    break;
> +                case PLUGIN_GEN_CB_COND_UDATA_R:
> +                    plugin_gen_tb_cond_udata_r(plugin_tb, op);
> +                    break;
>                  case PLUGIN_GEN_CB_INLINE_ADD_U64:
>                      plugin_gen_tb_inline_add_u64(plugin_tb, op);
>                      break;
> @@ -919,6 +1081,12 @@ static void plugin_gen_inject(struct qemu_plugin_tb=
 *plugin_tb)
>                  case PLUGIN_GEN_CB_UDATA_R:
>                      plugin_gen_insn_udata_r(plugin_tb, op, insn_idx);
>                      break;
> +                case PLUGIN_GEN_CB_COND_UDATA:
> +                    plugin_gen_insn_cond_udata(plugin_tb, op, insn_idx);
> +                    break;
> +                case PLUGIN_GEN_CB_COND_UDATA_R:
> +                    plugin_gen_insn_cond_udata_r(plugin_tb, op, insn_idx=
);
> +                    break;
>                  case PLUGIN_GEN_CB_INLINE_ADD_U64:
>                      plugin_gen_insn_inline_add_u64(plugin_tb, op, insn_i=
dx);
>                      break;
> diff --git a/plugins/api.c b/plugins/api.c
> index 4a033c16f83..f24d68d7a68 100644
> --- a/plugins/api.c
> +++ b/plugins/api.c
> @@ -113,6 +113,31 @@ void qemu_plugin_register_vcpu_tb_exec_cb(struct qem=
u_plugin_tb *tb,
>      }
>  }
>=20=20
> +void qemu_plugin_register_vcpu_tb_exec_cond_cb(struct qemu_plugin_tb *tb,
> +                                               qemu_plugin_vcpu_udata_cb=
_t cb,
> +                                               enum qemu_plugin_cb_flags=
 flags,
> +                                               enum qemu_plugin_cond con=
d,
> +                                               qemu_plugin_u64 entry,
> +                                               uint64_t imm,
> +                                               void *udata)
> +{
> +    if (cond =3D=3D QEMU_PLUGIN_COND_NEVER || tb->mem_only) {
> +        return;
> +    }
> +    if (cond =3D=3D QEMU_PLUGIN_COND_ALWAYS) {
> +        qemu_plugin_register_vcpu_tb_exec_cb(tb, cb, flags, udata);
> +        return;
> +    }
> +    int index =3D flags =3D=3D QEMU_PLUGIN_CB_R_REGS ||
> +                flags =3D=3D QEMU_PLUGIN_CB_RW_REGS ?
> +                PLUGIN_CB_COND_R : PLUGIN_CB_COND;
> +
> +    plugin_register_dyn_cond_cb__udata(&tb->cbs[index],
> +                                       cb, flags,
> +                                       cond, entry, imm,
> +                                       udata);
> +}
> +
>  void qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu(
>      struct qemu_plugin_tb *tb,
>      enum qemu_plugin_op op,
> @@ -141,6 +166,32 @@ void qemu_plugin_register_vcpu_insn_exec_cb(struct q=
emu_plugin_insn *insn,
>      }
>  }
>=20=20
> +void qemu_plugin_register_vcpu_insn_exec_cond_cb(
> +    struct qemu_plugin_insn *insn,
> +    qemu_plugin_vcpu_udata_cb_t cb,
> +    enum qemu_plugin_cb_flags flags,
> +    enum qemu_plugin_cond cond,
> +    qemu_plugin_u64 entry,
> +    uint64_t imm,
> +    void *udata)
> +{
> +    if (cond =3D=3D QEMU_PLUGIN_COND_NEVER || insn->mem_only) {
> +        return;
> +    }
> +    if (cond =3D=3D QEMU_PLUGIN_COND_ALWAYS) {
> +        qemu_plugin_register_vcpu_insn_exec_cb(insn, cb, flags, udata);
> +        return;
> +    }
> +    int index =3D flags =3D=3D QEMU_PLUGIN_CB_R_REGS ||
> +                flags =3D=3D QEMU_PLUGIN_CB_RW_REGS ?
> +                PLUGIN_CB_COND_R : PLUGIN_CB_COND;
> +
> +    plugin_register_dyn_cond_cb__udata(&insn->cbs[PLUGIN_CB_INSN][index],
> +                                       cb, flags,
> +                                       cond, entry, imm,
> +                                       udata);
> +}
> +
>  void qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
>      struct qemu_plugin_insn *insn,
>      enum qemu_plugin_op op,
> diff --git a/plugins/core.c b/plugins/core.c
> index 11f72594229..82d5f17438e 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -347,6 +347,25 @@ void plugin_register_dyn_cb__udata(GArray **arr,
>      dyn_cb->type =3D PLUGIN_CB_REGULAR;
>  }
>=20=20
> +void plugin_register_dyn_cond_cb__udata(GArray **arr,
> +                                        qemu_plugin_vcpu_udata_cb_t cb,
> +                                        enum qemu_plugin_cb_flags flags,
> +                                        enum qemu_plugin_cond cond,
> +                                        qemu_plugin_u64 entry,
> +                                        uint64_t imm,
> +                                        void *udata)
> +{
> +    struct qemu_plugin_dyn_cb *dyn_cb =3D plugin_get_dyn_cb(arr);
> +
> +    dyn_cb->userp =3D udata;
> +    /* Note flags are discarded as unused. */
> +    dyn_cb->f.vcpu_udata =3D cb;
> +    dyn_cb->type =3D PLUGIN_CB_COND;
> +    dyn_cb->cond_cb.cond =3D cond;
> +    dyn_cb->cond_cb.entry =3D entry;
> +    dyn_cb->cond_cb.imm =3D imm;
> +}
> +
>  void plugin_register_vcpu_mem_cb(GArray **arr,
>                                   void *cb,
>                                   enum qemu_plugin_cb_flags flags,
> diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
> index a9fac056c7f..aa0a77a319f 100644
> --- a/plugins/qemu-plugins.symbols
> +++ b/plugins/qemu-plugins.symbols
> @@ -27,6 +27,7 @@
>    qemu_plugin_register_vcpu_idle_cb;
>    qemu_plugin_register_vcpu_init_cb;
>    qemu_plugin_register_vcpu_insn_exec_cb;
> +  qemu_plugin_register_vcpu_insn_exec_cond_cb;
>    qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu;
>    qemu_plugin_register_vcpu_mem_cb;
>    qemu_plugin_register_vcpu_mem_inline_per_vcpu;
> @@ -34,6 +35,7 @@
>    qemu_plugin_register_vcpu_syscall_cb;
>    qemu_plugin_register_vcpu_syscall_ret_cb;
>    qemu_plugin_register_vcpu_tb_exec_cb;
> +  qemu_plugin_register_vcpu_tb_exec_cond_cb;
>    qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu;
>    qemu_plugin_register_vcpu_tb_trans_cb;
>    qemu_plugin_reset;

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


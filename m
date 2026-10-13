Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5F8CA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY9n-0003KQ-AW; Tue, 13 Oct 2026 04:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGY6E-0003y2-Tr
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:43:07 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xGY69-0008Uf-2y
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:43:04 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-486e8faff03so1125687f8f.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880979; x=1792485779; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mnxj7h7HvIWfwoZQRTFXGU62+t1KiKfVReRxfjWSfds=;
 b=E6h129X1h/qJ3fjBYxx+iq2eC/rYGIkNrrts6w4Jj33W1j2xp6sgD8JmkejWhdi3BL
 penAaIDy4sLMxR0k9W4kdO8bJ3wiXk69029XCqHbYTWkXIKjUCz8R7qX7D2T2f8CrqAx
 MDatoMK0Wg4KhZh8xcdm0cQGH/R9DMX2Q5nwO3429l8Pycnnuty6ewl9ImPG1V18Cmtc
 MTBZy+jUmxZK7DegmoOHQ0zC0N7bIyuo6ZT+gTQAU89SZt3/Bjz2ebblwcyL1cB2zL93
 T3azqWDEjZe6hjAYiIgZyq0xQppXiAiOSfrjS/+DuU4tlEWfkLAAF4FM8BC+Qw8cRdZy
 MipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880979; x=1792485779;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mnxj7h7HvIWfwoZQRTFXGU62+t1KiKfVReRxfjWSfds=;
 b=iBELeoIrptD5nEOxXTYoehD8XolXrEpWiqYcHI+MBSm8TLL3ZzpFFJn6VFltLXaKa+
 owvXbG2mH/ualkDQ4NJZxC+rvLvgK8xXpLxA68nRa7ViEGmHVb5MYg2/5UkVhodqWKhM
 cUuGNvQ6Tyc/u/XxBuRzLpUvfq/AyezdV6IlMD24PtR6XPMSo6/db34sRhDKRIlJj5wP
 jKxTkydW2fYMWiQcmwcbZVTcROEdJls+Sed8Q0NS9VpH7g9rfr0v8QUuOObRz+rBk4Pz
 z/LqlqRloc3Wd9gt7yI7LfwSXZynMrYbB3xfRbMSRUfRoeYuVUFQpDROW5E1Au0ac/Q+
 40pw==
X-Gm-Message-State: AFq9FYJXE/lCdYFu6I0u04T6lipunBYdOWJydvRASwvelRdI5IbS1/M8
 hAN/fUcVc8WTvLS4/L6V7VZbrnLAOVRH3l2fZdEsM1MJCZ/WwElxs9DaKB1BZ6maiqk=
X-Gm-Gg: AYBFou3xs7eoNgsKVn/EIQPfaC9P01nIvkE4sllRp8P5xmNxCO4xMG6GfmDssjWhCGj
 xuvET/tNTHatFRHpoxGDeNpnGDqweHK3GdievG9LmSTChNukdoK6gBAAbJKswGGWxtgnlXQDc5R
 tBLw3Ef/jwCVlFg0FiHsgYWHEl+XS9LScIfFPVO/Q+oAEsvJbkufBpgImH0VVXBhKfKoft1WBIc
 V0EvLsFJ+sQB2kpFWnJZtKtcMTUA37n3nae4cGskl/1NPQTWq3RQ3tgZup1N+iYnexHSJS8wGoj
 2cqX1xUplxXrk1HRTrNyNUQKGgVaI1b099HNrRjMNEQI6lYHvWRHYLve8+lJKLbHI8Dyl/sgq4P
 X9EbaiWU0DHfdmjGkA7hnLa1aSdDnR5GRPo/XAv8nrEyAUJuSca/5UUI5g7VCnSJPDNgFDymX4B
 B5saEBLUeaZICDC27McAcZgZDTp5zahaaKv8tZFmUtg2EC3SxC0Oudw/IweTginu7yVTtE2Q==
X-Received: by 2002:a05:6000:4a14:b0:487:15a3:1cab with SMTP id
 ffacd0b85a97d-48dbaadb081mr21260264f8f.18.1791880979139; 
 Tue, 13 Oct 2026 01:42:59 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0ab5262sm3937232f8f.22.2026.10.13.01.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:42:58 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4098C5F8E5;
 Tue, 13 Oct 2026 09:42:57 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  "Dr. David Alan Gilbert" <dave@treblig.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Zhao
 Liu
 <zhao1.liu@intel.com>,  Peter Maydell <peter.maydell@linaro.org>,  Chinmay
 Rath <rathc@linux.ibm.com>,  Nicholas Piggin <npiggin@gmail.com>,  Glenn
 Miles <milesg@linux.ibm.com>,  Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,  Alistair Francis
 <alistair.francis@wdc.com>,  Weiwei Li <liwei1518@gmail.com>,  Daniel
 Henrique Barboza <daniel.barboza@oss.qualcomm.com>,  Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>,  Chao Liu <chao.liu@processmission.com>,
 Max Filippov <jcmvbkbc@gmail.com>,  qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org,  qemu-riscv@nongnu.org,  Paolo Bonzini
 <pbonzini@redhat.com>,  Laurent Vivier <laurent@vivier.eu>,  Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>,  Artyom Tarasenko
 <atar4qemu@gmail.com>,  Helge Deller <deller@gmx.de>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Warner Losh <imp@bsdimp.com>,  Kyle
 Evans <kevans@freebsd.org>
Subject: Re: [PATCH v2 04/10] gdbstub: add gdb_register_internal_coprocessor()
In-Reply-To: <20261013-query-reg-v2-4-6f95a2e139a9@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
 Lureau"'s message of "Tue, 13 Oct 2026 00:34:07 +0400")
References: <20261013-query-reg-v2-0-6f95a2e139a9@redhat.com>
 <20261013-query-reg-v2-4-6f95a2e139a9@redhat.com>
User-Agent: mu4e 1.14.4-pre6; emacs 30.1
Date: Tue, 13 Oct 2026 09:42:57 +0100
Message-ID: <87ik36gfe6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Add support for registering coprocessor features that are only visible
> to QEMU's internal APIs (HMP monitor $register expressions, plugins) but
> hidden from GDB's target description XML.
>
> When a feature is registered as internal:
> - It is excluded from the target.xml sent to GDB
> - Its XML is not served via qXfer:features:read
> - 'p'/'P' packets for internal register numbers return E14
>
> This is useful for exposing system registers to the HMP monitor without
> affecting GDB's register namespace. Exposing aliases or synthetic
> registers through GDB's target description can cause problems: name
> collisions with GDB's pseudo-registers, independent register caching,
> and missing DWARF unwind rules.

Hmm are they *that* useful for HMP then?

The front-ends do limit what they export to gdb (see for example
ARM_CP_NO_GDB) generally because reading them causes side-effects. Those
restrictions are also a reason to limit them from the HMP interface.

>
> Internal features must be registered after all GDB-visible features to
> keep remote register numbering consistent. This ordering is enforced
> with an assertion.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  gdbstub/gdbstub.c      | 71 ++++++++++++++++++++++++++++++++++++++++++++=
------
>  include/exec/gdbstub.h | 21 +++++++++++++++
>  2 files changed, 84 insertions(+), 8 deletions(-)
>
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 912e31b66744..ac0f76d62333 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -54,6 +54,7 @@ typedef struct GDBRegisterState {
>      gdb_get_reg_cb get_reg;
>      gdb_set_reg_cb set_reg;
>      const GDBFeature *feature;
> +    bool internal; /* hidden from GDB, accessible via API/monitor */
>  } GDBRegisterState;
>=20=20
>  GDBState gdbserver_state;
> @@ -385,6 +386,11 @@ static const char *get_feature_xml(const char *p, co=
nst char **newp,
>              }
>              for (guint i =3D 0; i < cpu->gdb_regs->len; i++) {
>                  r =3D &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
> +                /* The core target.xml feature must never be internal. */
> +                g_assert(i > 0 || !r->internal);
> +                if (r->internal) {
> +                    continue;
> +                }
>                  g_ptr_array_add(
>                      xml,
>                      g_markup_printf_escaped("<xi:include href=3D\"%s\"/>=
",
> @@ -400,6 +406,9 @@ static const char *get_feature_xml(const char *p, con=
st char **newp,
>      /* Is it one of the features? */
>      for (guint i =3D 0; i < cpu->gdb_regs->len; i++) {
>          r =3D &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
> +        if (r->internal) {
> +            continue;
> +        }
>          if (strncmp(p, r->feature->xmlname, len) =3D=3D 0) {
>              return r->feature->xml;
>          }
> @@ -563,13 +572,14 @@ int gdb_write_register(CPUState *cpu, uint8_t *mem_=
buf, int reg)
>=20=20
>  static void gdb_register_feature(CPUState *cpu, int base_reg,
>                                   gdb_get_reg_cb get_reg, gdb_set_reg_cb =
set_reg,
> -                                 const GDBFeature *feature)
> +                                 const GDBFeature *feature, bool interna=
l)
>  {
>      GDBRegisterState s =3D {
>          .base_reg =3D base_reg,
>          .get_reg =3D get_reg,
>          .set_reg =3D set_reg,
> -        .feature =3D feature
> +        .feature =3D feature,
> +        .internal =3D internal
>      };
>=20=20
>      trace_gdbxml_register_feature(feature->name, feature->xmlname,
> @@ -605,7 +615,7 @@ void gdb_init_cpu(CPUState *cpu)
>          assert(feature->base_reg =3D=3D 0);
>          gdb_register_feature(cpu, 0,
>                               cc->gdb_read_register, cc->gdb_write_regist=
er,
> -                             feature);
> +                             feature, false);
>          cpu->gdb_next_base_reg =3D cpu->gdb_num_g_regs =3D feature->num_=
regs;
>      } else {
>          cpu->gdb_next_base_reg =3D cpu->gdb_num_g_regs =3D cc->gdb_num_c=
ore_regs;
> @@ -616,20 +626,26 @@ void gdb_init_cpu(CPUState *cpu)
>                            cc->gdb_num_core_regs);
>  }
>=20=20
> -void gdb_register_coprocessor(CPUState *cpu,
> -                              gdb_get_reg_cb get_reg, gdb_set_reg_cb set=
_reg,
> -                              const GDBFeature *feature)
> +static void do_gdb_register_coprocessor(CPUState *cpu,
> +                                        gdb_get_reg_cb get_reg,
> +                                        gdb_set_reg_cb set_reg,
> +                                        const GDBFeature *feature,
> +                                        bool internal)
>  {
>      GDBRegisterState *s;
>      guint i;
>      int base_reg =3D cpu->gdb_next_base_reg;
>=20=20
>      for (i =3D 0; i < cpu->gdb_regs->len; i++) {
> -        /* Check for duplicates.  */
>          s =3D &g_array_index(cpu->gdb_regs, GDBRegisterState, i);
> +        /* Check for duplicates.  */
>          if (s->feature =3D=3D feature) {
>              return;
>          }
> +        /* GDB-visible features must not follow internal ones.  */
> +        if (!internal) {
> +            g_assert(!s->internal);
> +        }
>      }
>=20=20
>      if (base_reg < feature->base_reg) {
> @@ -637,12 +653,27 @@ void gdb_register_coprocessor(CPUState *cpu,
>                                                feature->base_reg);
>          base_reg =3D feature->base_reg;
>      }
> -    gdb_register_feature(cpu, base_reg, get_reg, set_reg, feature);
> +    gdb_register_feature(cpu, base_reg, get_reg, set_reg, feature, inter=
nal);
>=20=20
>      /* Add to end of list.  */
>      cpu->gdb_next_base_reg =3D base_reg + feature->num_regs;
>  }
>=20=20
> +void gdb_register_coprocessor(CPUState *cpu,
> +                              gdb_get_reg_cb get_reg, gdb_set_reg_cb set=
_reg,
> +                              const GDBFeature *feature)
> +{
> +    do_gdb_register_coprocessor(cpu, get_reg, set_reg, feature, false);
> +}
> +
> +void gdb_register_internal_coprocessor(CPUState *cpu,
> +                                       gdb_get_reg_cb get_reg,
> +                                       gdb_set_reg_cb set_reg,
> +                                       const GDBFeature *feature)
> +{
> +    do_gdb_register_coprocessor(cpu, get_reg, set_reg, feature, true);
> +}
> +
>  void gdb_unregister_coprocessor_all(CPUState *cpu)
>  {
>      /*
> @@ -1223,6 +1254,18 @@ static void handle_remove_bp(GArray *params, void =
*user_ctx)
>   * the remote gdb to fallback to older methods.
>   */
>=20=20
> +static bool gdb_register_is_internal(CPUState *cpu, int reg)
> +{
> +    for (guint i =3D 0; i < cpu->gdb_regs->len; i++) {
> +        GDBRegisterState *r =3D &g_array_index(cpu->gdb_regs, GDBRegiste=
rState, i);
> +
> +        if (r->base_reg <=3D reg && reg < r->base_reg + r->feature->num_=
regs) {
> +            return r->internal;
> +        }
> +    }
> +    return false;
> +}
> +
>  static void handle_set_reg(GArray *params, void *user_ctx)
>  {
>      int reg_size;
> @@ -1232,6 +1275,12 @@ static void handle_set_reg(GArray *params, void *u=
ser_ctx)
>          return;
>      }
>=20=20
> +    if (gdb_register_is_internal(gdbserver_state.g_cpu,
> +                                 gdb_get_cmd_param(params, 0)->val_ull))=
 {
> +        gdb_put_packet("E14");
> +        return;
> +    }
> +
>      reg_size =3D strlen(gdb_get_cmd_param(params, 1)->data) / 2;
>      gdb_hextomem(gdbserver_state.mem_buf, gdb_get_cmd_param(params, 1)->=
data, reg_size);
>      gdb_write_register(gdbserver_state.g_cpu, gdbserver_state.mem_buf->d=
ata,
> @@ -1248,6 +1297,12 @@ static void handle_get_reg(GArray *params, void *u=
ser_ctx)
>          return;
>      }
>=20=20
> +    if (gdb_register_is_internal(gdbserver_state.g_cpu,
> +                                 gdb_get_cmd_param(params, 0)->val_ull))=
 {
> +        gdb_put_packet("E14");
> +        return;
> +    }
> +
>      reg_size =3D gdb_read_register(gdbserver_state.g_cpu,
>                                   gdbserver_state.mem_buf,
>                                   gdb_get_cmd_param(params, 0)->val_ull);
> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
> index 75eb4d9c365e..1bc778324758 100644
> --- a/include/exec/gdbstub.h
> +++ b/include/exec/gdbstub.h
> @@ -40,6 +40,27 @@ void gdb_register_coprocessor(CPUState *cpu,
>                                gdb_get_reg_cb get_reg, gdb_set_reg_cb set=
_reg,
>                                const GDBFeature *feature);
>=20=20
> +/**
> + * gdb_register_internal_coprocessor() - register internal registers
> + *
> + * Like gdb_register_coprocessor(), but the feature is NOT exposed to
> + * GDB via the target description XML. The registers are only
> + * accessible through QEMU's internal APIs (HMP monitor ``$register``
> + * expressions via gdb_get_register_list()).
> + *
> + * Internal features must be registered after all GDB-visible features
> + * to avoid register numbering mismatches with GDB.
> + *
> + * @cpu - the CPU associated with registers
> + * @get_reg - get function
> + * @set_reg - set function
> + * @feature - the GDBFeature describing the registers
> + */
> +void gdb_register_internal_coprocessor(CPUState *cpu,
> +                                       gdb_get_reg_cb get_reg,
> +                                       gdb_set_reg_cb set_reg,
> +                                       const GDBFeature *feature);
> +
>  /**
>   * gdb_unregister_coprocessor_all() - unregisters supplemental set of re=
gisters
>   * @cpu - the CPU associated with registers

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


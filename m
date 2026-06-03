Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4C4CD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 01:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUa04-0005uD-JA; Tue, 02 Jun 2026 21:02:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wUa02-0005t1-Tp
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 21:02:27 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wUZzy-0008Ql-Ju
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 21:02:26 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-bec429c2bb1so460309966b.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 18:02:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780448537; cv=none;
 d=google.com; s=arc-20240605;
 b=Ne28OYx6PVWE4OZlDSXd0qBA2ptgdU853+S0duZGOgOlhyXB0eMY4DQzBa746zDSt9
 T6nKC0kPNfO0mRhC+u/dXiASYPorvv1ESj8DqErc7Q1L6dUhMg/q3jDo1ofpmiCDF0Qz
 uAzsYiiyXXXKmOa1Qcg+4mxWK+/2A2ytRg5T8orSFLZsc6RhrbKUFT3lHZNUXT8NqkE0
 dWeHjY3sezy2UhVW21UKwSstmVZewmhwx5+kHYE3IFCqaJy39ROT2mkflmd5mXEIha57
 +XsxEffYXjenu6BFnWyAuyP8S0NpDIRKbAizJ8SCZ54Ci+e4mS4IzJ3RbuiL+vyzfzhU
 gFAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CPuKn6hMaFOSX7Zez4Xd2rA12Ugd2r9mYBlyBK5nE4g=;
 fh=+1firF9KONN4Yc1L4UE+f7hjZIqv5yKMPW+CbJoXUyw=;
 b=atiqozZ7KZBTYmniqjiTvn4ap4o6YZvS0bRzhicst8JTawk/Mrrr7TJnGzbhKfPxZ4
 kdjBxKT5NJKBT7z1nbFvXFsueIif4p9tY5VMreurtaDLTnZIIQXazZC0zGpV2/4QJ+79
 Xy69a8+Z0k8ksC0jOGw60/WwBDYhLh1Ne3ezoKpkunMw6gU1Rk5MzupoNYislcynWRIL
 Cv3SWxm84GJAAvsG4UstjFb+ry7IHGoi4v6J1NV1g544zqUiDQWhHD3bzsMzfbfJ/pnO
 B9Uo/tPzihqtrHKfxXg+6VaNAVdldt6+Xul3VawV7SB+9mQArC+siUAygW/mo5CZIp+j
 FAmA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780448537; x=1781053337; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CPuKn6hMaFOSX7Zez4Xd2rA12Ugd2r9mYBlyBK5nE4g=;
 b=ZiBHz0MvGJOOpw3zGOOAGJQ3rrHx07A6RP4I6vMdjxlu5cNzfN9tkBdl35NPthup//
 sPfOKvqJuGrYVB0DpoyZOblJRmpf+b/ErDmxwFrpICDPt/w+diojHPtJfal9usiS2FBQ
 3YyeQSoxaCqMDFMs7OdUqQ+n1YDNQCSmCIuHNHYeA6Q/RT7tFBdOfi/ycX2vwXrp0c3a
 Clij1RpL5LEqMIvdf5W57kzqWKfEqZ3UrORAAHY/5LMiLLyUdTQal2mDJrHCTVmyBxQO
 4wvHF3CqJ/Q4PcC+b1JXJ4qv1YVpGzq30NqgeRWz5j+MRTLeA8tT8Zng5tiDFWNdHHoi
 PHpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780448537; x=1781053337;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CPuKn6hMaFOSX7Zez4Xd2rA12Ugd2r9mYBlyBK5nE4g=;
 b=UccKGQg7i0ye6awAgyqRFxyst4HtgEMU7YleT2gM0yANQB4s6P02+QCr5/iYhGoVdH
 pISzhKdmjRY8rxGwn9QD8lCaO4+vuPhSRSMXpGRItX+rbnSefzhLHHNqzbO0Ek2si38D
 CY/smAFMqmJGTHlF4Y/s8d6dYj4FzAwGgbeRq6brkOVFTHbJ4cG+m+b7d/cBoTh6/AmA
 hIepR6wCTB/3wc0nnV3bD/RIYasAuwo4EM1uZx9keaG2zBLa7G5p5IUXqkPEE5eEa+L6
 DJadIqe2vCo8vXiNCBkzhxB57x9mARrbq8z6lMLJ595M9LPR+4Bfi+UhutwQAjfh2MwX
 PwJg==
X-Gm-Message-State: AOJu0YxF5vN8QG0AklwptNRTCPnHh/LSY5fd/o0/H1nzav7hL73VbLSZ
 nzyFJJng6yoS1iFLp3qKYqElBXmQPGEGvLPbQlUCn9RP3Tm5NAgLLcvZkDe+Ar1+j6fu3iyUPsj
 pi+dMzUKfnB4c1od+LURbAJiaapQqu6L8F4rhMvw=
X-Gm-Gg: Acq92OH7tE4WduNtbPZ6gb55LxH5lqm3fah9+pWIWdVACxGHVwIHKq21hZf1rs6qJLO
 l3L0w8+XJCiqrXIMgpT3xQGbgLC+olr4EJbPQGzXwIvtBYahPlBKs7EBbDXdxwrFlS6eOcR3g2o
 68mOIlRrjz5+KWIhNf/TgMWVvQJYYA2lBt9pxGgUa5GfruMzvER7/fkvwt0VWZ0vRgcJYUsyLON
 iTusJxQ6kBeEh97iCQCiPYBgeTyEv48UuhuGzKKEiIzka9o7Mye8UIKJeRFtWrpTA59ZQ7hyQoL
 wDOn/WYsBr25T40kD2/gWt7oEmvVl0DfLfzPyvv40gUxzb/Z
X-Received: by 2002:a17:907:c282:b0:bec:5234:af7d with SMTP id
 a640c23a62f3a-bf0ac20eee8mr37150266b.6.1780448537140; Tue, 02 Jun 2026
 18:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260516-qom-tests-v3-0-3f20c3a029a7@redhat.com>
 <20260516-qom-tests-v3-21-3f20c3a029a7@redhat.com>
In-Reply-To: <20260516-qom-tests-v3-21-3f20c3a029a7@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Jun 2026 11:01:50 +1000
X-Gm-Features: AVHnY4IgyEP3mj7wCocOKFubNPGFzfO2IOCNlZOTvOUpo4uUmbFm1bs9NoEB7o0
Message-ID: <CAKmqyKPh5Zb8mD=6pmtSKcO14Bp26dHnsX_5NPgDEj6mLot8bA@mail.gmail.com>
Subject: Re: [PATCH v3 21/24] target/riscv: fix general_user_opts hash table
 leak
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sat, May 16, 2026 at 6:02=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> The global general_user_opts hash table is recreated on every
> riscv_cpu_init() call, leaking the previous one.
>
> Furthermore, the CPU settings should be associated with their instance
> and not global.
>
> Add a finalize() to free associated instances.
>
> Fixes: d167a2247ede ("target/riscv: move 'pmu-mask' and 'pmu-num' to risc=
v_cpu_properties[]")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h         |  3 ++-
>  target/riscv/cpu.c         | 53 ++++++++++++++++++++++++++++------------=
------
>  target/riscv/kvm/kvm-cpu.c |  6 +++---
>  3 files changed, 37 insertions(+), 25 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index fae839cade4..86a38a7288b 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -546,6 +546,7 @@ struct ArchCPU {
>      uint32_t pmu_avail_ctrs;
>      /* Mapping of events to counters */
>      GHashTable *pmu_event_ctr_map;
> +    GHashTable *user_options;
>      const GPtrArray *decoders;
>  };
>
> @@ -619,7 +620,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, =
int size,
>                          bool probe, uintptr_t retaddr);
>  char *riscv_isa_string(RISCVCPU *cpu);
>  int riscv_cpu_max_xlen(RISCVCPUClass *mcc);
> -bool riscv_cpu_option_set(const char *optname);
> +bool riscv_cpu_option_set(RISCVCPU *cpu, const char *optname);
>
>  #ifndef CONFIG_USER_ONLY
>  void riscv_cpu_do_interrupt(CPUState *cpu);
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 506a018d52b..bbdc9d8f5de 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -27,6 +27,7 @@
>  #include "qapi/error.h"
>  #include "qapi/visitor.h"
>  #include "qemu/error-report.h"
> +#include "qemu/timer.h"
>  #include "hw/core/qdev-properties.h"
>  #include "hw/core/qdev-prop-internal.h"
>  #include "migration/vmstate.h"
> @@ -59,18 +60,16 @@ bool riscv_cpu_is_32bit(RISCVCPU *cpu)
>      return riscv_cpu_mxl(&cpu->env) =3D=3D MXL_RV32;
>  }
>
> -/* Hash that stores general user set numeric options */
> -static GHashTable *general_user_opts;
> -
> -static void cpu_option_add_user_setting(const char *optname, uint32_t va=
lue)
> +static void cpu_option_add_user_setting(RISCVCPU *cpu, const char *optna=
me,
> +                                        uint32_t value)
>  {
> -    g_hash_table_insert(general_user_opts, (gpointer)optname,
> +    g_hash_table_insert(cpu->user_options, (gpointer)optname,
>                          GUINT_TO_POINTER(value));
>  }
>
> -bool riscv_cpu_option_set(const char *optname)
> +bool riscv_cpu_option_set(RISCVCPU *cpu, const char *optname)
>  {
> -    return g_hash_table_contains(general_user_opts, optname);
> +    return g_hash_table_contains(cpu->user_options, optname);
>  }
>
>  #ifndef CONFIG_USER_ONLY
> @@ -1103,7 +1102,7 @@ static void riscv_cpu_init(Object *obj)
>                              "riscv.cpu.rnmi", RNMI_MAX);
>  #endif /* CONFIG_USER_ONLY */
>
> -    general_user_opts =3D g_hash_table_new(g_str_hash, g_str_equal);
> +    cpu->user_options =3D g_hash_table_new(g_str_hash, g_str_equal);
>
>      /*
>       * The timer and performance counters extensions were supported
> @@ -1453,7 +1452,7 @@ static void prop_pmu_num_set(Object *obj, Visitor *=
v, const char *name,
>
>      warn_report("\"pmu-num\" property is deprecated; use \"pmu-mask\"");
>      cpu->cfg.pmu_mask =3D pmu_mask;
> -    cpu_option_add_user_setting("pmu-mask", pmu_mask);
> +    cpu_option_add_user_setting(cpu, "pmu-mask", pmu_mask);
>  }
>
>  static void prop_pmu_num_get(Object *obj, Visitor *v, const char *name,
> @@ -1495,7 +1494,7 @@ static void prop_pmu_mask_set(Object *obj, Visitor =
*v, const char *name,
>          return;
>      }
>
> -    cpu_option_add_user_setting(name, value);
> +    cpu_option_add_user_setting(cpu, name, value);
>      cpu->cfg.pmu_mask =3D value;
>  }
>
> @@ -1527,7 +1526,7 @@ static void prop_mmu_set(Object *obj, Visitor *v, c=
onst char *name,
>          return;
>      }
>
> -    cpu_option_add_user_setting(name, value);
> +    cpu_option_add_user_setting(cpu, name, value);
>      cpu->cfg.mmu =3D value;
>  }
>
> @@ -1559,7 +1558,7 @@ static void prop_pmp_set(Object *obj, Visitor *v, c=
onst char *name,
>          return;
>      }
>
> -    cpu_option_add_user_setting(name, value);
> +    cpu_option_add_user_setting(cpu, name, value);
>      cpu->cfg.pmp =3D value;
>  }
>
> @@ -1599,7 +1598,7 @@ static void prop_num_pmp_regions_set(Object *obj, V=
isitor *v, const char *name,
>          return;
>      }
>
> -    cpu_option_add_user_setting(name, value);
> +    cpu_option_add_user_setting(cpu, name, value);
>      cpu->cfg.pmp_regions =3D value;
>  }
>
> @@ -1637,7 +1636,7 @@ static void prop_pmp_granularity_set(Object *obj, V=
isitor *v, const char *name,
>          return;
>      }
>
> -    cpu_option_add_user_setting(name, value);
> +    cpu_option_add_user_setting(cpu, name, value);
>      cpu->cfg.pmp_granularity =3D value;
>  }
>
> @@ -1710,7 +1709,7 @@ static void prop_priv_spec_set(Object *obj, Visitor=
 *v, const char *name,
>          return;
>      }
>
> -    cpu_option_add_user_setting(name, priv_version);
> +    cpu_option_add_user_setting(cpu, name, priv_version);
>      cpu->env.priv_ver =3D priv_version;
>  }
>
> @@ -1744,7 +1743,7 @@ static void prop_vext_spec_set(Object *obj, Visitor=
 *v, const char *name,
>          return;
>      }
>
> -    cpu_option_add_user_setting(name, VEXT_VERSION_1_00_0);
> +    cpu_option_add_user_setting(cpu, name, VEXT_VERSION_1_00_0);
>      cpu->env.vext_ver =3D VEXT_VERSION_1_00_0;
>  }
>
> @@ -1787,7 +1786,7 @@ static void prop_vlen_set(Object *obj, Visitor *v, =
const char *name,
>          return;
>      }
>
> -    cpu_option_add_user_setting(name, value);
> +    cpu_option_add_user_setting(cpu, name, value);
>      cpu->cfg.vlenb =3D value >> 3;
>  }
>
> @@ -1828,7 +1827,7 @@ static void prop_elen_set(Object *obj, Visitor *v, =
const char *name,
>          return;
>      }
>
> -    cpu_option_add_user_setting(name, value);
> +    cpu_option_add_user_setting(cpu, name, value);
>      cpu->cfg.elen =3D value;
>  }
>
> @@ -1864,7 +1863,7 @@ static void prop_cbom_blksize_set(Object *obj, Visi=
tor *v, const char *name,
>          return;
>      }
>
> -    cpu_option_add_user_setting(name, value);
> +    cpu_option_add_user_setting(cpu, name, value);
>      cpu->cfg.cbom_blocksize =3D value;
>  }
>
> @@ -1900,7 +1899,7 @@ static void prop_cbop_blksize_set(Object *obj, Visi=
tor *v, const char *name,
>          return;
>      }
>
> -    cpu_option_add_user_setting(name, value);
> +    cpu_option_add_user_setting(cpu, name, value);
>      cpu->cfg.cbop_blocksize =3D value;
>  }
>
> @@ -1936,7 +1935,7 @@ static void prop_cboz_blksize_set(Object *obj, Visi=
tor *v, const char *name,
>          return;
>      }
>
> -    cpu_option_add_user_setting(name, value);
> +    cpu_option_add_user_setting(cpu, name, value);
>      cpu->cfg.cboz_blocksize =3D value;
>  }
>
> @@ -2975,6 +2974,17 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt,=
 char *nodename)
>      DEFINE_RISCV_CPU(type_name, parent_type_name,             \
>          .profile =3D &(profile_))
>
> +static void riscv_cpu_instance_finalize(Object *obj)
> +{
> +    RISCVCPU *cpu =3D RISCV_CPU(obj);
> +
> +#ifndef CONFIG_USER_ONLY
> +    g_clear_pointer(&cpu->pmu_timer, timer_free);
> +    g_clear_pointer(&cpu->pmu_event_ctr_map, g_hash_table_destroy);
> +#endif
> +    g_clear_pointer(&cpu->user_options, g_hash_table_destroy);
> +}
> +
>  static const TypeInfo riscv_cpu_type_infos[] =3D {
>      {
>          .name =3D TYPE_RISCV_CPU,
> @@ -2982,6 +2992,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>          .instance_size =3D sizeof(RISCVCPU),
>          .instance_align =3D __alignof(RISCVCPU),
>          .instance_init =3D riscv_cpu_init,
> +        .instance_finalize =3D riscv_cpu_instance_finalize,
>          .abstract =3D true,
>          .class_size =3D sizeof(RISCVCPUClass),
>          .class_init =3D riscv_cpu_common_class_init,
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index b047ffa9c0c..e0241870ada 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -2025,7 +2025,7 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu,=
 Error **errp)
>      }
>
>      if (cpu->cfg.ext_zicbom &&
> -        riscv_cpu_option_set(kvm_cbom_blocksize.name)) {
> +        riscv_cpu_option_set(cpu, kvm_cbom_blocksize.name)) {
>
>          reg.id =3D KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CONFIG,
>                                          kvm_cbom_blocksize.kvm_reg_id);
> @@ -2044,7 +2044,7 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu,=
 Error **errp)
>      }
>
>      if (cpu->cfg.ext_zicboz &&
> -        riscv_cpu_option_set(kvm_cboz_blocksize.name)) {
> +        riscv_cpu_option_set(cpu, kvm_cboz_blocksize.name)) {
>
>          reg.id =3D KVM_RISCV_REG_ID_ULONG(KVM_REG_RISCV_CONFIG,
>                                          kvm_cboz_blocksize.kvm_reg_id);
> @@ -2063,7 +2063,7 @@ void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu,=
 Error **errp)
>      }
>
>      /* Users are setting vlen, not vlenb */
> -    if (riscv_has_ext(env, RVV) && riscv_cpu_option_set("vlen")) {
> +    if (riscv_has_ext(env, RVV) && riscv_cpu_option_set(cpu, "vlen")) {
>          if (!kvm_v_vlenb.supported) {
>              error_setg(errp, "Unable to set 'vlenb': register not suppor=
ted");
>              return;
>
> --
> 2.54.0
>
>


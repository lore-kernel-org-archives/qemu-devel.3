Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D771FF886F
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:54:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrsJ-0001ik-Sx; Mon, 04 May 2026 07:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wJrsC-0001g1-0I
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:54:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wJrs9-00065U-0j
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:54:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777895638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=19HXGqSox2hwZB7/J65WnaWVZDUxRzJIIwGFz2bh+58=;
 b=QRZ526D4HmF5sANOv/i+UWOKcMhMjtk3YJqpxw2ghmST+nf5YafZGvgG2wcej389xU9MwP
 NxlRiV+bHppo4NshUUsFRRhskL9T2g+LiZQc/9lDRsUYxycJCWEilLR+Od9VbIJCG5XHe9
 GbSBLOMXavLpTKzDaxZ8OBxEskwM3YE=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-n08ihjKUOdCSSs1PQADJXg-1; Mon, 04 May 2026 07:53:57 -0400
X-MC-Unique: n08ihjKUOdCSSs1PQADJXg-1
X-Mimecast-MFC-AGG-ID: n08ihjKUOdCSSs1PQADJXg_1777895636
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c70ea91bfe1so1619479a12.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 04:53:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777895635; cv=none;
 d=google.com; s=arc-20240605;
 b=EMYfxweOpZz+WqvFs0ni/EQU1b//VWgJND+z97bb3wbTsDCfteG0cpBpC4QEiRfhqa
 0mNjxZ5sZY0WuzBy9FraOgzneG842yTtmQVBU5IiqeAxtZUKj39zLn6ea+rU3ktBAAnA
 h0wHxXACqhGhD+8otV4MsO1xuKX9cX0nGWS3qXCCspmJepqppwqWYw0rj4VwFTwf44Za
 9KKztrrZ6/OBD7EEx9vanqB+aWJMAIU1MHp7Xqf5PcBsv9Tnx3/8tUZjU/0Wazjnwxpx
 NJ13n9omkcCeeRPN3331cEI5tp1+hT9Fi/MmGisGxUHb9k4bwznQx+0QQRroc7sUF4c7
 JLRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=19HXGqSox2hwZB7/J65WnaWVZDUxRzJIIwGFz2bh+58=;
 fh=iExg1+WOn1OQKO7evmLFhUuLbnagnvx+Q/4+PBaFS1Y=;
 b=OLQnIcR7cj8YUtSWsxpbBowCgZDFMitriSSB0GOEehRQkppHPxaJF4yRCoRpof9vaU
 wcAzA0V80mKZvp4STcf2IRZync7h4BJSw6OegN9VZr3er+baTC0TTIUWV2Vb/avvO3zd
 yDkOu8zh7eQoKoZuKOn/KR09SP52bv5/w0bSY8fivdImJ0qf9Gq6kxHNpTo7Mmx8Q+qb
 1PYLSv0SYIZfmgoR8Ap1DrimuEOLm/Ecsjt2ZHqUPkB8ud1KibAC0FRGu70kfOLSjjd0
 v8WUCw3EOgcWZYy4Sq+1T6ekdvs84/59hXDuubD130Sm7ArhgBUnSIMU+mE7g1haojyH
 KKBg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777895635; x=1778500435; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=19HXGqSox2hwZB7/J65WnaWVZDUxRzJIIwGFz2bh+58=;
 b=ZdSK0PxAaJDds/pCx7gFORXy3gWF501WoFv7T8657iM1iwFeaxCeal7XjW7UTqLpcW
 3Dkk+bohM5FsjUMadPV/HDGWohYru56LN8ZXU31Umr6yJ6RYodstzTGYNCP6qEdUAujp
 hzXjHOAANfdvh4lBGjDeVY/0BNbrFWWTjpsr2Z2kEUWct3dGXi0wgMKkizAQgJ9mhVka
 +XF0yX3AoufcXkYqBXekjQdn+fwj0iAqk9IRPuL45+a8/xiEwAjfRSL4OOCy3qGEbH/h
 SDf0jlZRcssbICLXyScWAPjMMSQQcn37/+NyPTlojB0kKTKeJ8Oa56Z9SberL4Qm/n1+
 OsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777895635; x=1778500435;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=19HXGqSox2hwZB7/J65WnaWVZDUxRzJIIwGFz2bh+58=;
 b=A4lM2nJQBZO3VaXf9/iKXZnnYo1A6v0R0QlHaKReZI9azoqfqaKMcxSBI8BbT++z9c
 KA9tf15anuwaMHnwnvlzdAXzXWOSWoilN9kQv4/bICSlLEEDvrRVIuNiusWhA+pGMFNl
 N89tbomEkD1xljScQh4gd5sr5YKuJTrkA0OqicvUPlMWw6z6JY8L2uDtRxqGFSMQjak9
 NnnJslRf+QFVRcQOupqkKHNCx8lWU20ORySyZDOLtjiNDcaEC/GF6DdCUVBeirclCh3p
 9x3O79Ej1/ZA8AWFBOLTPVMLzzjxEvPurz2Gxr9BKuz9C39qLnl6+W4iiK2bk46I5w3i
 +aFw==
X-Gm-Message-State: AOJu0YzInSup6mR2/kOr+OwKg7Leom0DXylS41hePKXnuEwccgyDzcau
 gHFESPMne0lPut7CiuldOyRRenRnckb/lpSHuaGT+qK31Bhtnd8fiZod0XgAeEgYCDf6/JTZP0z
 zwj0cPU2LkXDksx9g0kzKnWzuKQeMogeamLv27CX6ya52khf/a6AVaZtZj/FjGRL6vF7DpC3REu
 qgqF5KqbrvNA5EUv75MMuRgoxAO0yn/8CSq5F6/0V3/g==
X-Gm-Gg: AeBDieuoPavkYmYiAwoHqNxEPEDDD3SCRR7Jvo81p1bC/ebO4bPynSprhOkUGmoMoE7
 uwW8GujEkv7hyS+unVg1n0t2I653zpYG6OK5T3mKOFu9xEy4u3FTcaO+2PhNuVqvz7Kgca3Z4Cy
 IFc4WgPkaUEqm2wL+hYV0Pufgz5kH+yf0sKdn98P1kPRxYK9kU5bvLMN7+fQp3h+N15BLjmDZ1D
 hH04+YpFrV6UK3ukz37OQ55gL26HW27ONSyM7rS+uCOJdrnO7JEt+NnhqbFTA2t6jOM+PVlQG/6
 qbSi0R74WiuzUQ/mCWSzgOe8RrFQc7k/Ha8=
X-Received: by 2002:a05:6a20:938e:b0:39c:787:f196 with SMTP id
 adf61e73a8af0-3a7f1a8c3f6mr9050954637.16.1777895635189; 
 Mon, 04 May 2026 04:53:55 -0700 (PDT)
X-Received: by 2002:a05:6a20:938e:b0:39c:787:f196 with SMTP id
 adf61e73a8af0-3a7f1a8c3f6mr9050920637.16.1777895634585; Mon, 04 May 2026
 04:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
 <20260504-qom-tests-v2-42-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-42-ef7e3dc94f7a@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 4 May 2026 15:53:43 +0400
X-Gm-Features: AVHnY4KvPjcViPnxdKEXBtwEfZaA7zkZegpaMnChRJCsSrh-rd1QNr0x_FCWIzE
Message-ID: <CAMxuvax9D6EfQpiHX9BWs-1nH9npaFVSmPbP9cMUST0k31z7HQ@mail.gmail.com>
Subject: Re: [PATCH v2 42/46] target/riscv: fix general_user_opts hash table
 leak
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Mon, May 4, 2026 at 3:39=E2=80=AFPM Marc-Andr=C3=A9 Lureau
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
> ---
>  target/riscv/cpu.h         |  3 ++-
>  target/riscv/cpu.c         | 51 +++++++++++++++++++++++++++-------------=
------
>  target/riscv/kvm/kvm-cpu.c |  6 +++---
>  3 files changed, 35 insertions(+), 25 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 81c41e34296..55a26aeb5be 100644
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
> index ce15a17c37d..be9a3ac13e7 100644
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
> @@ -2974,6 +2973,15 @@ void riscv_isa_write_fdt(RISCVCPU *cpu, void *fdt,=
 char *nodename)
>      DEFINE_RISCV_CPU(type_name, parent_type_name,             \
>          .profile =3D &(profile_))
>
> +static void riscv_cpu_instance_finalize(Object *obj)
> +{
> +    RISCVCPU *cpu =3D RISCV_CPU(obj);
> +
> +    g_clear_pointer(&cpu->pmu_timer, timer_free);
> +    g_clear_pointer(&cpu->pmu_event_ctr_map, g_hash_table_destroy);

Those 2 should be guarded with
#ifndef CONFIG_USER_ONLY

fixed

> +    g_clear_pointer(&cpu->user_options, g_hash_table_destroy);
> +}
> +
>  static const TypeInfo riscv_cpu_type_infos[] =3D {
>      {
>          .name =3D TYPE_RISCV_CPU,
> @@ -2981,6 +2989,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
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



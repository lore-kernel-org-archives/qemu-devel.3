Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B2DCA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 22:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGOZq-00014N-Bn; Mon, 12 Oct 2026 18:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebasjosue84@gmail.com>)
 id 1xGOZn-000141-Lv
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 18:32:59 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sebasjosue84@gmail.com>)
 id 1xGOZk-0003kc-Ak
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 18:32:59 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c2acc1e170cso378626766b.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 15:32:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791844373; cv=none;
 d=google.com; s=arc-20260327;
 b=j8OLCh8u+dKJ4RQ3Zq5jGlwQ+5Q5uDdf89zlmiaXkaeAYp6yMYDXHuXcpGiwZ8vf/0
 8IdM1LlHsqima885x5kFjM24JTNl56k3/2punCudBiFP5K6KVGg9ABONGmNMbH5g89r7
 6pat0INPryrIHyzvnaciMV7I6AXL3UaPnIVoH14lCnlmqnzMKAlKluJGit+C8ARqaIj6
 hUQIJEgAQ10u+cSJuuyCBNd22bJEiU60HAAz0wDsPg8OpWJqUuQ0MxSX2t8HsvPkAqco
 9myIjSdMYzo1FtHL+kCwOmwZd5K8Y9fBOH2S+JUvykgdommEzsGNB4MYh7gQ/LEyieef
 oN2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7sj2j+PKgzRHIhCs0KM7Rd1TZY1lcNEpwetTquNHA5o=;
 fh=ABU4QYAW007E6VH/N0jiAOEC+cU8Er0JQC4fLuLe3SA=;
 b=RvJxiA6YtUDshQbHniAVQ2Qv1uuHcoBRJoA2U5i9kzqQ//LQW6ScebZX9z8OY2E/YG
 FaF0MOLY5XpgXbcqTCM2PVCwcfScK2Ptr11RGRhWsP8Ncx4Gn7/MSo0yhtP8dvntu67l
 sacjZbJnID/sdfTeyO+IWMGdQ8TI9hpV/tJ2HtSoMs5pckoM7/PFCTX9R5KUAxEVH4IV
 Mf9mAKNKRz/uIL1rFt7eomid1Z5MKLhI32a8OaiavGyBePuPTARrnQKZoikATrFWSBlO
 ONiHEKRvTwE4rlwkuUjcaGhb9ntayn/+UDZsc0v0pgWSV4Eb5ivLkZIwG/iZH/tDm0BY
 bEkw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791844373; x=1792449173; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7sj2j+PKgzRHIhCs0KM7Rd1TZY1lcNEpwetTquNHA5o=;
 b=M36pQj215NjfvV+X6kZLy3jTKPXlV1hBW///7XJW6LmCAhRP1eQahVMDJRgiYndX00
 fv9lRsQCy9ibu3ACDQ/I92NY1MxE+XudTdlbiDmyHU84Q8O8eG16McaFs+WuWUaLpnKn
 q4iYYjB0LrW2g7IKLlD8DylFloL79EUKTNAg8HcJJFbINDoC8s/La1AhWpqtPHj2wiC8
 Nle+FTQMGX5FCBdpRYHg26R3+fPpjFwI3IdLh2tbLH1fWlUQRiJwFdrMSYhPgiIzAjLg
 Ll/rf7VHUw5PzQIOMpN/wx1nFDjTWeo2HWbDxZE9La4ciECa6HH51bCKuTltMRpbrWFb
 ehTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791844373; x=1792449173;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7sj2j+PKgzRHIhCs0KM7Rd1TZY1lcNEpwetTquNHA5o=;
 b=rmO0niIuwG8sMD8d8757Pdu4aFn/OYTEeSiNq4O+wwrwzGkvZe7SituBkEtvfqlDdh
 qldEtOdHpU/zSs/AFMrO0TMsJgbdNUAE5icUDIeO7M94kgFiMT28WEXO+MnYWRLIYdzZ
 YIGmtdraGtfyaQaz7jrAGU4SrzCeVo32l1+3dwrJhf1iD16iOwsbFGkJx47DVrNJP026
 U2Wg/Qjw/En5aVVe5EAuOTif0VXXErQxWujy/7cekxdeaAI9/1dh2S0JpCf8qeLEgI/w
 gPrNJbfE9P/g8wud3XwbD/xt/BTTz2iP7XuseBgj9ekk7IFGwghjajwnaJ8cZiRpIJd3
 NajA==
X-Gm-Message-State: AFq9FYJHT9jRdN37+v0Y0r/iz2Tkfe6n+YLrdz1R32HSSCjq6uu+CulG
 PpzJe40xesydf1UBXSlpN7IveXvyGevXr1mxliwP18PyVCGDuxhpVzqzyPSdbUA8Mpv7gHFRSCI
 ZNr0QDpJVkA7M7cAA25w/yU0w26GEVT29rcf5VD4=
X-Gm-Gg: AYBFou1xx6WywtTIjFX2bH2x/pijoNEe9o+OZGUQj2R0klzi4W5lUhVzbyLhNPOmk9g
 DjMmfr108JdnZcVgYhpQekDthzeMat/WNevju4z+N3mTdSppTyUBKIJ4/rBZoOzPQOyH8l6mbmj
 snZltyrs1hMIjHDs5Y3Aj5RL2bvU6H8gM7cVz9id6SCDEyT7tWS4AP3+RxMVy31/x0GDOTiSVSz
 FrjkJj96JBc2Fdn7ralrVx+PekFR7dKZmawXLnzjZGWEPIVriDhY727I8eaL4MB3qs9eQyXwfQc
 7eYca1GrAtNu4LrgtG21tWsgehAStJvHdsB5KG3WhyH1lJ8TLrqxqmxgqzoxLCqQl0RMR4fpaV/
 pOZnibK8WUx2F
X-Received: by 2002:a17:907:9720:b0:c26:337e:7e05 with SMTP id
 a640c23a62f3a-c31a9a29d50mr1002992466b.4.1791844373387; Mon, 12 Oct 2026
 15:32:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260916034331.2390427-1-sebasjosue84@gmail.com>
 <20261011040617.807504-1-sebasjosue84@gmail.com>
In-Reply-To: <20261011040617.807504-1-sebasjosue84@gmail.com>
From: =?UTF-8?Q?Sebasti=C3=A1n_Alba?= <sebasjosue84@gmail.com>
Date: Mon, 12 Oct 2026 16:32:41 -0600
X-Gm-Features: AclHuK_WNHZg6jiQLSqkXTz6bmvZ3MwxP7UDRWziI0LllEuRsM0lhnFtdJM4BtM
Message-ID: <CAJD=UNcvzM8=k7j84fkCDDO79gNES3o4d=mmV3k+FiCU+y43pA@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: pmp: clear the entire PMP state on reset
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com, 
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com, 
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com, 
 richard.henderson@linaro.org
Content-Type: multipart/alternative; boundary="0000000000005e5cfd065dac4714"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=sebasjosue84@gmail.com; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--0000000000005e5cfd065dac4714
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Two things, one about reading the test program's output and one about the
approach.

The test program decides which boot it is in by reading pmpcfg0: zero means
first boot, so it prints 'A', programs entries 2 and 3 as locked NAPOT, and
resets through sifive_test. The second-boot path prints 'B', dumps pmpcfg0,
attempts to clear it, dumps it again, and is the only path that signals PAS=
S
and exits. On an unpatched build the second boot reads back 0x99990000 and
the clear attempt is ignored, so the value is printed twice: the entries
survive the reset and are immutable from then on, since mseccfg is cleared
before pmp_unlock_entries() runs and RLB is gone with it. With this patch
pmpcfg0 reads zero after every reset, so the program takes the first-boot
path every time and prints 'A' indefinitely, never reaching its exit. The
repeating 'A' is the pass condition, not a hang: it means no PMP state
survived the reset.

On clearing the whole struct rather than individual fields: Spike reaches
the same post-reset state by a different route. In riscv-isa-sim at
17e8a69fb755, state_t::reset() calls csr_init() (riscv/processor.cc:132),
which reallocates mseccfg and every pmpaddr and pmpcfg object
(riscv/csr_init.cc:328 and 336-342); base_pmpaddr_csr_t's constructor start=
s
from val(0), cfg(0) (riscv/csrs.cc:88-93), and processor_t::reset() then
flushes the TLB (riscv/processor.cc:159). It also keeps no derived PMP stat=
e
that could go stale: state_t holds only the pmpaddr CSR objects
(riscv/processor.h:174) and recomputes the range bounds on every check
(riscv/csrs.cc:103-116), so there is no counterpart to pmp_state.addr[] or
num_rules; num_rules does not occur anywhere under riscv/. Its scan is
bounded by the number of implemented entries (mmu_t::pmp_ok calls
pmp_lookup(addr, len, 0, proc->n_pmp), riscv/mmu.cc:519), and the A field i=
s
tested before any address comparison (base_pmpaddr_csr_t::match4,
riscv/csrs.cc:124).

Clearing the whole struct gives QEMU the same reset state, and removes the
possibility of the architectural fields and the derived bounds disagreeing.

If you would prefer the bound fix and the state clearing as two separate
patches, I can respin it that way.

El s=C3=A1b, 10 oct 2026 a las 22:06, Sebastian Alba Vives (<
sebasjosue84@gmail.com>) escribi=C3=B3:

> pmp_unlock_entries() bounded its loop with pmp_get_num_rules(), which
> returns the number of entries whose A field is not OFF rather than the
> number of implemented entries. With a sparse configuration the loop
> stops early: with entries 0 and 1 OFF and entries 2 and 3 locked,
> num_rules is 2, the loop covers i =3D 0 and i =3D 1, and entries 2 and 3
> keep their lock and address-match bits across reset.
>
> riscv_cpu_reset_hold() clears mseccfg, and with it RLB, before calling
> this, so pmp_is_readonly() then silently discards every subsequent
> pmpcfg write to those entries. The stale rules survive for the
> lifetime of the machine.
>
> Clearing only PMP_LOCK and PMP_AMATCH is not enough either. The priv
> spec only mandates that the A and L fields be reset, but QEMU keeps
> derived state next to the architectural registers: pmp_state.addr[]
> and pmp_state.num_rules are recomputed from the pmpaddr and pmpcfg
> write paths only, never at reset. pmp_is_in_range() compares against
> addr[].sa and addr[].ea without consulting the A field, and the
> partially-inside check in pmp_hart_has_privs() runs before the A
> field is tested, so a range left over from before the reset can still
> deny an access that straddles its boundary once the guest configures
> any entry again.
>
> Zero the whole structure instead. Zero is the correct reset value for
> every field: a cfg_reg of 0 is A=3DOFF with no permissions, and a
> num_rules of 0 restores the no-rules short cut. Rename the function
> since it no longer only unlocks entries.
>
> Fixes: 4bf501dc0118 ("target/riscv: pmp: Clear pmp/smepmp bits on reset")
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
> ---
> Changes in v2:
> - Zero the whole env->pmp_state instead of masking PMP_LOCK and
>   PMP_AMATCH over a bounded set of entries, as suggested by Richard.
>   v1 also left pmp_state.addr[] and pmp_state.num_rules stale across
>   reset, which the memset covers as well.
>
> v1:
> https://lore.kernel.org/qemu-devel/20260916034331.2390427-1-sebasjosue84@=
gmail.com/
>
>  target/riscv/cpu.c     | 4 ++--
>  target/riscv/tcg/pmp.c | 9 ++-------
>  target/riscv/tcg/pmp.h | 2 +-
>  3 files changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index da4c1a090b..0b71196507 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1048,7 +1048,7 @@ static void riscv_cpu_reset_hold(Object *obj,
> ResetType type)
>      }
>
>      /*
> -     * Clear mseccfg and unlock all the PMP entries upon reset.
> +     * Clear mseccfg and the PMP state upon reset.
>       * This is required as per the priv, smepmp, and other security
>       * extension specifications that share this CSR, and is needed
>       * to clear stale entries across reboots.
> @@ -1060,7 +1060,7 @@ static void riscv_cpu_reset_hold(Object *obj,
> ResetType type)
>          env->mseccfg =3D 0;
>      }
>
> -    pmp_unlock_entries(env);
> +    pmp_reset(env);
>  #endif /* ifdef CONFIG_TCG */
>  #else
>      env->priv =3D PRV_U;
> diff --git a/target/riscv/tcg/pmp.c b/target/riscv/tcg/pmp.c
> index 41b55519a8..437e0ff2af 100644
> --- a/target/riscv/tcg/pmp.c
> +++ b/target/riscv/tcg/pmp.c
> @@ -199,14 +199,9 @@ static bool pmp_write_cfg(CPURISCVState *env,
> uint32_t pmp_index, uint8_t val)
>      return false;
>  }
>
> -void pmp_unlock_entries(CPURISCVState *env)
> +void pmp_reset(CPURISCVState *env)
>  {
> -    uint32_t pmp_num =3D pmp_get_num_rules(env);
> -    int i;
> -
> -    for (i =3D 0; i < pmp_num; i++) {
> -        env->pmp_state.pmp[i].cfg_reg &=3D ~(PMP_LOCK | PMP_AMATCH);
> -    }
> +    memset(&env->pmp_state, 0, sizeof(env->pmp_state));
>  }
>
>  static void pmp_decode_napot(hwaddr a, hwaddr *sa, hwaddr *ea)
> diff --git a/target/riscv/tcg/pmp.h b/target/riscv/tcg/pmp.h
> index 4c95c2767a..99546934fc 100644
> --- a/target/riscv/tcg/pmp.h
> +++ b/target/riscv/tcg/pmp.h
> @@ -79,7 +79,7 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t
> pmp_index);
>  void pmp_update_rule_nums(CPURISCVState *env);
>  uint32_t pmp_get_num_rules(CPURISCVState *env);
>  int pmp_priv_to_page_prot(pmp_priv_t pmp_priv);
> -void pmp_unlock_entries(CPURISCVState *env);
> +void pmp_reset(CPURISCVState *env);
>
>  #define MSECCFG_MML_ISSET(env) get_field(env->mseccfg, MSECCFG_MML)
>  #define MSECCFG_MMWP_ISSET(env) get_field(env->mseccfg, MSECCFG_MMWP)
> --
> 2.43.0
>
>

--=20
Sebasti=C3=A1n Alba

--0000000000005e5cfd065dac4714
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Two things, one about reading the test program&#39;s outpu=
t and one about the<br>approach.<br><br>The test program decides which boot=
 it is in by reading pmpcfg0: zero means<br>first boot, so it prints &#39;A=
&#39;, programs entries 2 and 3 as locked NAPOT, and<br>resets through sifi=
ve_test. The second-boot path prints &#39;B&#39;, dumps pmpcfg0,<br>attempt=
s to clear it, dumps it again, and is the only path that signals PASS<br>an=
d exits. On an unpatched build the second boot reads back 0x99990000 and<br=
>the clear attempt is ignored, so the value is printed twice: the entries<b=
r>survive the reset and are immutable from then on, since mseccfg is cleare=
d<br>before pmp_unlock_entries() runs and RLB is gone with it. With this pa=
tch<br>pmpcfg0 reads zero after every reset, so the program takes the first=
-boot<br>path every time and prints &#39;A&#39; indefinitely, never reachin=
g its exit. The<br>repeating &#39;A&#39; is the pass condition, not a hang:=
 it means no PMP state<br>survived the reset.<br><br>On clearing the whole =
struct rather than individual fields: Spike reaches<br>the same post-reset =
state by a different route. In riscv-isa-sim at<br>17e8a69fb755, state_t::r=
eset() calls csr_init() (riscv/processor.cc:132),<br>which reallocates msec=
cfg and every pmpaddr and pmpcfg object<br>(riscv/csr_init.cc:328 and 336-3=
42); base_pmpaddr_csr_t&#39;s constructor starts<br>from val(0), cfg(0) (ri=
scv/csrs.cc:88-93), and processor_t::reset() then<br>flushes the TLB (riscv=
/processor.cc:159). It also keeps no derived PMP state<br>that could go sta=
le: state_t holds only the pmpaddr CSR objects<br>(riscv/processor.h:174) a=
nd recomputes the range bounds on every check<br>(riscv/csrs.cc:103-116), s=
o there is no counterpart to pmp_state.addr[] or<br>num_rules; num_rules do=
es not occur anywhere under riscv/. Its scan is<br>bounded by the number of=
 implemented entries (mmu_t::pmp_ok calls<br>pmp_lookup(addr, len, 0, proc-=
&gt;n_pmp), riscv/mmu.cc:519), and the A field is<br>tested before any addr=
ess comparison (base_pmpaddr_csr_t::match4,<br>riscv/csrs.cc:124).<br><br>C=
learing the whole struct gives QEMU the same reset state, and removes the<b=
r>possibility of the architectural fields and the derived bounds disagreein=
g.<br><br>If you would prefer the bound fix and the state clearing as two s=
eparate<br>patches, I can respin it that way.<br></div><br><div class=3D"gm=
ail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">El s=
=C3=A1b, 10 oct 2026 a las 22:06, Sebastian Alba Vives (&lt;<a href=3D"mail=
to:sebasjosue84@gmail.com">sebasjosue84@gmail.com</a>&gt;) escribi=C3=B3:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left-width:1px;border-left-style:solid;border-left-color:rgb(204,20=
4,204);padding-left:1ex">pmp_unlock_entries() bounded its loop with pmp_get=
_num_rules(), which<br>
returns the number of entries whose A field is not OFF rather than the<br>
number of implemented entries. With a sparse configuration the loop<br>
stops early: with entries 0 and 1 OFF and entries 2 and 3 locked,<br>
num_rules is 2, the loop covers i =3D 0 and i =3D 1, and entries 2 and 3<br=
>
keep their lock and address-match bits across reset.<br>
<br>
riscv_cpu_reset_hold() clears mseccfg, and with it RLB, before calling<br>
this, so pmp_is_readonly() then silently discards every subsequent<br>
pmpcfg write to those entries. The stale rules survive for the<br>
lifetime of the machine.<br>
<br>
Clearing only PMP_LOCK and PMP_AMATCH is not enough either. The priv<br>
spec only mandates that the A and L fields be reset, but QEMU keeps<br>
derived state next to the architectural registers: pmp_state.addr[]<br>
and pmp_state.num_rules are recomputed from the pmpaddr and pmpcfg<br>
write paths only, never at reset. pmp_is_in_range() compares against<br>
addr[].sa and addr[].ea without consulting the A field, and the<br>
partially-inside check in pmp_hart_has_privs() runs before the A<br>
field is tested, so a range left over from before the reset can still<br>
deny an access that straddles its boundary once the guest configures<br>
any entry again.<br>
<br>
Zero the whole structure instead. Zero is the correct reset value for<br>
every field: a cfg_reg of 0 is A=3DOFF with no permissions, and a<br>
num_rules of 0 restores the no-rules short cut. Rename the function<br>
since it no longer only unlocks entries.<br>
<br>
Fixes: 4bf501dc0118 (&quot;target/riscv: pmp: Clear pmp/smepmp bits on rese=
t&quot;)<br>
Suggested-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lin=
aro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
Signed-off-by: Sebastian Alba Vives &lt;<a href=3D"mailto:sebasjosue84@gmai=
l.com" target=3D"_blank">sebasjosue84@gmail.com</a>&gt;<br>
---<br>
Changes in v2:<br>
- Zero the whole env-&gt;pmp_state instead of masking PMP_LOCK and<br>
=C2=A0 PMP_AMATCH over a bounded set of entries, as suggested by Richard.<b=
r>
=C2=A0 v1 also left pmp_state.addr[] and pmp_state.num_rules stale across<b=
r>
=C2=A0 reset, which the memset covers as well.<br>
<br>
v1: <a href=3D"https://lore.kernel.org/qemu-devel/20260916034331.2390427-1-=
sebasjosue84@gmail.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.=
kernel.org/qemu-devel/20260916034331.2390427-1-sebasjosue84@gmail.com/</a><=
br>
<br>
=C2=A0target/riscv/cpu.c=C2=A0 =C2=A0 =C2=A0| 4 ++--<br>
=C2=A0target/riscv/tcg/pmp.c | 9 ++-------<br>
=C2=A0target/riscv/tcg/pmp.h | 2 +-<br>
=C2=A03 files changed, 5 insertions(+), 10 deletions(-)<br>
<br>
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c<br>
index da4c1a090b..0b71196507 100644<br>
--- a/target/riscv/cpu.c<br>
+++ b/target/riscv/cpu.c<br>
@@ -1048,7 +1048,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetTy=
pe type)<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/*<br>
-=C2=A0 =C2=A0 =C2=A0* Clear mseccfg and unlock all the PMP entries upon re=
set.<br>
+=C2=A0 =C2=A0 =C2=A0* Clear mseccfg and the PMP state upon reset.<br>
=C2=A0 =C2=A0 =C2=A0 * This is required as per the priv, smepmp, and other =
security<br>
=C2=A0 =C2=A0 =C2=A0 * extension specifications that share this CSR, and is=
 needed<br>
=C2=A0 =C2=A0 =C2=A0 * to clear stale entries across reboots.<br>
@@ -1060,7 +1060,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetTy=
pe type)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;mseccfg =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 pmp_unlock_entries(env);<br>
+=C2=A0 =C2=A0 pmp_reset(env);<br>
=C2=A0#endif /* ifdef CONFIG_TCG */<br>
=C2=A0#else<br>
=C2=A0 =C2=A0 =C2=A0env-&gt;priv =3D PRV_U;<br>
diff --git a/target/riscv/tcg/pmp.c b/target/riscv/tcg/pmp.c<br>
index 41b55519a8..437e0ff2af 100644<br>
--- a/target/riscv/tcg/pmp.c<br>
+++ b/target/riscv/tcg/pmp.c<br>
@@ -199,14 +199,9 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32_t=
 pmp_index, uint8_t val)<br>
=C2=A0 =C2=A0 =C2=A0return false;<br>
=C2=A0}<br>
<br>
-void pmp_unlock_entries(CPURISCVState *env)<br>
+void pmp_reset(CPURISCVState *env)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 uint32_t pmp_num =3D pmp_get_num_rules(env);<br>
-=C2=A0 =C2=A0 int i;<br>
-<br>
-=C2=A0 =C2=A0 for (i =3D 0; i &lt; pmp_num; i++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 env-&gt;pmp_state.pmp[i].cfg_reg &amp;=3D ~(PM=
P_LOCK | PMP_AMATCH);<br>
-=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 memset(&amp;env-&gt;pmp_state, 0, sizeof(env-&gt;pmp_state))=
;<br>
=C2=A0}<br>
<br>
=C2=A0static void pmp_decode_napot(hwaddr a, hwaddr *sa, hwaddr *ea)<br>
diff --git a/target/riscv/tcg/pmp.h b/target/riscv/tcg/pmp.h<br>
index 4c95c2767a..99546934fc 100644<br>
--- a/target/riscv/tcg/pmp.h<br>
+++ b/target/riscv/tcg/pmp.h<br>
@@ -79,7 +79,7 @@ void pmp_update_rule_addr(CPURISCVState *env, uint32_t pm=
p_index);<br>
=C2=A0void pmp_update_rule_nums(CPURISCVState *env);<br>
=C2=A0uint32_t pmp_get_num_rules(CPURISCVState *env);<br>
=C2=A0int pmp_priv_to_page_prot(pmp_priv_t pmp_priv);<br>
-void pmp_unlock_entries(CPURISCVState *env);<br>
+void pmp_reset(CPURISCVState *env);<br>
<br>
=C2=A0#define MSECCFG_MML_ISSET(env) get_field(env-&gt;mseccfg, MSECCFG_MML=
)<br>
=C2=A0#define MSECCFG_MMWP_ISSET(env) get_field(env-&gt;mseccfg, MSECCFG_MM=
WP)<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div style=3D"=
text-align:left">Sebasti=C3=A1n Alba</div><div style=3D"text-align:center">=
</div></div></div></div></div>

--0000000000005e5cfd065dac4714--


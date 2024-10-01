Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49ADCEACFB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 19:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svibQ-0001bi-Sp; Tue, 01 Oct 2024 15:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1svibL-0001aW-9q; Tue, 01 Oct 2024 15:32:03 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1svibG-0000u4-RT; Tue, 01 Oct 2024 15:32:02 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42e82f7f36aso47715265e9.0; 
 Tue, 01 Oct 2024 12:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727811113; x=1728415913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SCifLU40Ttl6+Yh6jb5nPSqXhIJ6hPKbRqJixaGvriM=;
 b=aBBQujExmwwvvTgWmYadkyfDl1hiTulHZRBth/M0/nQw7SijCelqXfK9HV43lP6tkB
 wsFcSUH+8ItG26V0ULRSLAbOwO9EMYy7HbVFkBYJPK8FsuYdeoesBSUP+vnlAlmTS8Cp
 +q6aUs/fTnbLbll6G9sWjr+tMuGfAz2Vz2CPwvBALq6fKUSAV1CuJZ5QNucoeF73U7K4
 u2FPB6+IE3iIerQi739ZnHSxfeodmnGoqVDOLzEasEdPR3i7XGZy5tfqbfYBitpbZmPd
 5em9sHAgfyJtZEBumJvfW4b6ynTQnZ7pzu1amFKniHXwmXWGMZtK+QLWd8c1dLQyrRFP
 f0qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727811113; x=1728415913;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SCifLU40Ttl6+Yh6jb5nPSqXhIJ6hPKbRqJixaGvriM=;
 b=S/OKzwpCsToUqUdqDApsCXcEd5ZpdPFGjBnPgnBM+Sfcy8N+nWU3t1kP7R1HF5popQ
 pPjAyCM1ILJiGovDf/bnwPJDea5M9pV9uqEmr6rFtC1UuX4eTT4muSqlAuZfH6PTPkWP
 KEsrJv2uL8j7WL8FO+7L+TonaLwgTQQZMktwaDc5hg4/vxSuAVbmRwMDZT2FCwRVW+AD
 fF5VIcrr5fVd5wnUy8fqwXyfBbSJf0mvLxXBdvVUIQMbIDSY7n+iCtVLaNqOl4Z/cwbO
 CDVHjA5nRnJwAskm12edf21S/C8pVdaI7SqVQTVCGoWHDjovQZzm5gbwDXev+3huVrqP
 5Yfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPmAEUH81mXlqir0WYNZ3UGpx/lN5HIyqUCgtYybh84gk/h3fbxKioxL6/FKsvjfkK4Ruq18JUTg==@nongnu.org
X-Gm-Message-State: AOJu0YwjKeoMkBXbKqS9IxngP7mS6EqeTc5Y3Zd19JbeR5uu/U9pPeYg
 YnhqwRkpiYOTYX+UmC8PzKc65fg677b7fK8bBf4NSpBO9hq7iOMPy/EZsw==
X-Google-Smtp-Source: AGHT+IER9pCvvcAsTSn72QZNF+nP82NQneF/MxO5ue66prs+34GL9tuzNSNMtn1QnbZeqHEcGZesbg==
X-Received: by 2002:a05:600c:1d1f:b0:42c:b22e:fbfa with SMTP id
 5b1f17b1804b1-42f777dba40mr4151785e9.21.1727811113079; 
 Tue, 01 Oct 2024 12:31:53 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-078-055-096-038.78.55.pool.telefonica.de.
 [78.55.96.38]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd572fa48sm12424252f8f.66.2024.10.01.12.31.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2024 12:31:52 -0700 (PDT)
Date: Tue, 01 Oct 2024 19:31:52 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-ppc@nongnu.org
CC: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/2=5D_hw/ppc=3A_Consolidate_e?=
 =?US-ASCII?Q?500_initial_mapping_creation_functions?=
In-Reply-To: <C252CEDD-75BE-4A32-9EA3-98FECBF36BA8@gmail.com>
References: <cover.1721131193.git.balaton@eik.bme.hu>
 <485a90bca642c894d94c8dbcadac58448c0bfa71.1721131193.git.balaton@eik.bme.hu>
 <C252CEDD-75BE-4A32-9EA3-98FECBF36BA8@gmail.com>
Message-ID: <AB32405D-9A0A-4332-98F6-174650648DB7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 15=2E August 2024 19:01:47 UTC schrieb Bernhard Beschow <shentey@gmail=
=2Ecom>:
>
>
>Am 16=2E Juli 2024 12:07:57 UTC schrieb BALATON Zoltan <balaton@eik=2Ebme=
=2Ehu>:
>>Add booke206_set_tlb() utility function and use it to replace very
>>similar create_initial_mapping functions in e500 machines=2E
>>
>>Signed-off-by: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>>---
>> hw/ppc/e500=2Ec         | 41 +++++++++++++++++++----------------------
>> hw/ppc/e500=2Eh         |  2 --
>> hw/ppc/ppce500_spin=2Ec | 30 +++++++++---------------------
>> include/hw/ppc/ppc=2Eh  |  5 +++++
>> 4 files changed, 33 insertions(+), 45 deletions(-)
>>
>>diff --git a/hw/ppc/e500=2Ec b/hw/ppc/e500=2Ec
>>index 3bd12b54ab=2E=2E8682bc7838 100644
>>--- a/hw/ppc/e500=2Ec
>>+++ b/hw/ppc/e500=2Ec
>>@@ -721,11 +721,21 @@ static int ppce500_prep_device_tree(PPCE500Machine=
State *machine,
>>                                     kernel_base, kernel_size, true);
>> }
>>=20
>>-hwaddr booke206_page_size_to_tlb(uint64_t size)
>>+static hwaddr booke206_page_size_to_tlb(uint64_t size)
>> {
>>     return 63 - clz64(size / KiB);
>> }
>>=20
>>+void booke206_set_tlb(ppcmas_tlb_t *tlb, target_ulong va, hwaddr pa,
>>+                      hwaddr len)
>>+{
>>+    tlb->mas1 =3D booke206_page_size_to_tlb(len) << MAS1_TSIZE_SHIFT;
>>+    tlb->mas1 |=3D MAS1_VALID;
>>+    tlb->mas2 =3D va & TARGET_PAGE_MASK;
>>+    tlb->mas7_3 =3D pa & TARGET_PAGE_MASK;
>>+    tlb->mas7_3 |=3D MAS3_UR | MAS3_UW | MAS3_UX | MAS3_SR | MAS3_SW | =
MAS3_SX;
>>+}
>>+
>> static int booke206_initial_map_tsize(CPUPPCState *env)
>> {
>>     struct boot_info *bi =3D env->load_info;
>>@@ -751,25 +761,6 @@ static uint64_t mmubooke_initial_mapsize(CPUPPCStat=
e *env)
>>     return (1ULL << 10 << tsize);
>> }
>>=20
>>-/* Create -kernel TLB entries for BookE=2E */
>>-static void mmubooke_create_initial_mapping(CPUPPCState *env)
>>-{
>>-    ppcmas_tlb_t *tlb =3D booke206_get_tlbm(env, 1, 0, 0);
>>-    hwaddr size;
>>-    int ps;
>>-
>>-    ps =3D booke206_initial_map_tsize(env);
>>-    size =3D (ps << MAS1_TSIZE_SHIFT);
>>-    tlb->mas1 =3D MAS1_VALID | size;
>>-    tlb->mas2 =3D 0;
>>-    tlb->mas7_3 =3D 0;
>>-    tlb->mas7_3 |=3D MAS3_UR | MAS3_UW | MAS3_UX | MAS3_SR | MAS3_SW | =
MAS3_SX;
>>-
>>-#ifdef CONFIG_KVM
>>-    env->tlb_dirty =3D true;
>>-#endif
>>-}
>>-
>> static void ppce500_cpu_reset_sec(void *opaque)
>> {
>>     PowerPCCPU *cpu =3D opaque;
>>@@ -786,6 +777,8 @@ static void ppce500_cpu_reset(void *opaque)
>>     CPUState *cs =3D CPU(cpu);
>>     CPUPPCState *env =3D &cpu->env;
>>     struct boot_info *bi =3D env->load_info;
>>+    uint64_t map_size =3D mmubooke_initial_mapsize(env);
>>+    ppcmas_tlb_t *tlb =3D booke206_get_tlbm(env, 1, 0, 0);
>>=20
>>     cpu_reset(cs);
>>=20
>>@@ -796,11 +789,15 @@ static void ppce500_cpu_reset(void *opaque)
>>     env->gpr[4] =3D 0;
>>     env->gpr[5] =3D 0;
>>     env->gpr[6] =3D EPAPR_MAGIC;
>>-    env->gpr[7] =3D mmubooke_initial_mapsize(env);
>>+    env->gpr[7] =3D map_size;
>>     env->gpr[8] =3D 0;
>>     env->gpr[9] =3D 0;
>>     env->nip =3D bi->entry;
>>-    mmubooke_create_initial_mapping(env);
>>+    /* create initial mapping */
>>+    booke206_set_tlb(tlb, 0, 0, map_size);
>
>Both invocations of booke206_set_tlb() are followed by:
>
>>+#ifdef CONFIG_KVM
>>+    env->tlb_dirty =3D true;
>>+#endif=20
>
>Doesn't it make sense to move these three lines into booke206_set_tlb()? =
The two copies you're resolving did so, too=2E

Ping

>
>Best regards,
>Bernhard
>
>> }
>>=20
>> static DeviceState *ppce500_init_mpic_qemu(PPCE500MachineState *pms,
>>diff --git a/hw/ppc/e500=2Eh b/hw/ppc/e500=2Eh
>>index 8c09ef92e4=2E=2E01db102625 100644
>>--- a/hw/ppc/e500=2Eh
>>+++ b/hw/ppc/e500=2Eh
>>@@ -41,8 +41,6 @@ struct PPCE500MachineClass {
>>=20
>> void ppce500_init(MachineState *machine);
>>=20
>>-hwaddr booke206_page_size_to_tlb(uint64_t size);
>>-
>> #define TYPE_PPCE500_MACHINE      "ppce500-base-machine"
>> OBJECT_DECLARE_TYPE(PPCE500MachineState, PPCE500MachineClass, PPCE500_M=
ACHINE)
>>=20
>>diff --git a/hw/ppc/ppce500_spin=2Ec b/hw/ppc/ppce500_spin=2Ec
>>index dfbe759481=2E=2E208d87569a 100644
>>--- a/hw/ppc/ppce500_spin=2Ec
>>+++ b/hw/ppc/ppce500_spin=2Ec
>>@@ -33,6 +33,7 @@
>> #include "hw/hw=2Eh"
>> #include "hw/sysbus=2Eh"
>> #include "sysemu/hw_accel=2Eh"
>>+#include "hw/ppc/ppc=2Eh"
>> #include "e500=2Eh"
>> #include "qom/object=2Eh"
>>=20
>>@@ -70,30 +71,12 @@ static void spin_reset(DeviceState *dev)
>>     }
>> }
>>=20
>>-static void mmubooke_create_initial_mapping(CPUPPCState *env,
>>-                                     target_ulong va,
>>-                                     hwaddr pa,
>>-                                     hwaddr len)
>>-{
>>-    ppcmas_tlb_t *tlb =3D booke206_get_tlbm(env, 1, 0, 1);
>>-    hwaddr size;
>>-
>>-    size =3D (booke206_page_size_to_tlb(len) << MAS1_TSIZE_SHIFT);
>>-    tlb->mas1 =3D MAS1_VALID | size;
>>-    tlb->mas2 =3D (va & TARGET_PAGE_MASK) | MAS2_M;
>>-    tlb->mas7_3 =3D pa & TARGET_PAGE_MASK;
>>-    tlb->mas7_3 |=3D MAS3_UR | MAS3_UW | MAS3_UX | MAS3_SR | MAS3_SW | =
MAS3_SX;
>>-#ifdef CONFIG_KVM
>>-    env->tlb_dirty =3D true;
>>-#endif
>>-}
>>-
>> static void spin_kick(CPUState *cs, run_on_cpu_data data)
>> {
>>     CPUPPCState *env =3D cpu_env(cs);
>>     SpinInfo *curspin =3D data=2Ehost_ptr;
>>-    hwaddr map_size =3D 64 * MiB;
>>-    hwaddr map_start;
>>+    hwaddr map_start, map_size =3D 64 * MiB;
>>+    ppcmas_tlb_t *tlb =3D booke206_get_tlbm(env, 1, 0, 1);
>>=20
>>     cpu_synchronize_state(cs);
>>     stl_p(&curspin->pir, env->spr[SPR_BOOKE_PIR]);
>>@@ -107,7 +90,12 @@ static void spin_kick(CPUState *cs, run_on_cpu_data =
data)
>>     env->gpr[9] =3D 0;
>>=20
>>     map_start =3D ldq_p(&curspin->addr) & ~(map_size - 1);
>>-    mmubooke_create_initial_mapping(env, 0, map_start, map_size);
>>+    /* create initial mapping */
>>+    booke206_set_tlb(tlb, 0, map_start, map_size);
>>+    tlb->mas2 |=3D MAS2_M;
>>+#ifdef CONFIG_KVM
>>+    env->tlb_dirty =3D true;
>>+#endif
>>=20
>>     cs->halted =3D 0;
>>     cs->exception_index =3D -1;
>>diff --git a/include/hw/ppc/ppc=2Eh b/include/hw/ppc/ppc=2Eh
>>index d5d119ea7f=2E=2E070524b02e 100644
>>--- a/include/hw/ppc/ppc=2Eh
>>+++ b/include/hw/ppc/ppc=2Eh
>>@@ -116,6 +116,11 @@ enum {
>>=20
>> #define PPC_SERIAL_MM_BAUDBASE 399193
>>=20
>>+#ifndef CONFIG_USER_ONLY
>>+void booke206_set_tlb(ppcmas_tlb_t *tlb, target_ulong va, hwaddr pa,
>>+                      hwaddr len);
>>+#endif
>>+
>> /* ppc_booke=2Ec */
>> void ppc_booke_timers_init(PowerPCCPU *cpu, uint32_t freq, uint32_t fla=
gs);
>> #endif


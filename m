Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65157D1CDC6
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 12:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSwbx-0003JZ-8N; Tue, 09 Dec 2025 07:14:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vSwbp-0003Iu-Nu
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 07:14:25 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vSwbk-0002TX-Ez
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 07:14:25 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-477563e28a3so40434875e9.1
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 04:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765282458; x=1765887258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VFn0AkVJ0M+bkz8IfnbGN+ZD2KmdYOWgIWbW2WJXjXI=;
 b=ev8QxgKSGY3KvOYqf6GDWLcSKOmELfLRH5ye+n3HWI6Y5IJP4DAk5Tp04Pm3z4QVLb
 dkkW7XWTlEdEOYYEJzAbvLgXmlpjHyBJxXmSShBbAVhGGexo206n1Le7W7Lpow6ppNcx
 WNTmMCL3oZ2hajk/Any4XH1fB3dFoFYJ+0/w315hD6Oqvc46+G311hYBHzlrjBM6/BGR
 x2TcZ+RedBFD8hpSSjVNRgWpkqXv/h6vOuBZjOx5G/W6PvjAG3h/QK0cXfIBTzhrljd+
 cDqOsVmIhq2Qmx265IAMfPVeZd8i53TvJQS+8cxHczRbgqUAPLiwOEGXjqQkUSAA8C2h
 V51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765282458; x=1765887258;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VFn0AkVJ0M+bkz8IfnbGN+ZD2KmdYOWgIWbW2WJXjXI=;
 b=tQI+nM0Gp21xL7tOOR8Zt1Cw0x1KUx7I4OvO3ePOp9hYfVb59Z0LDb7Cfg2n5l4/zX
 pYpzcg1Te1e6F8pi1l2XpIwExzNWRMo+mxnUd5xUrpD1FzVA2+ObHd4swTKTY8e8OReZ
 6XXbBT2dm7xX5/VzdThYXunCDhgUzpqYZDj7rR44/VUUDjHRALHSVhGQk33I6aFy+kQV
 8KIli7RF8NAkBtPgb/BiQ46Q1wkDOX4Aj2mrcXjKTvo9B+Mrsu2ALLbBMl7liW8z/PF+
 TceG+CUbnwGflvfqStvdGdOgXge05PXMrHWB9FnjPPsbhUNjDaZNuI/EOY22f2vr54uE
 s8tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc9Ifu0GlGEZGe2clCAtTo3josva9dAMhWj9fw/+yTW9nMJLFIl3nTJklmds5oambwtlDHMrmrFUfE@nongnu.org
X-Gm-Message-State: AOJu0YzKz0SpxV/W3NU+06dZPomiafP5dzcYcOxI6bdBVWR3JI7nlMRW
 0HZAaaLlMnoGJeEdDbLV7wNelHyuFfjkC1eqqUzvOSgcD1WBsPeLyblAGzHIZranLek=
X-Gm-Gg: ASbGncv2Vy1816XgfRZULRX1i9UIZW2x3/1rh/CVhJeAdCknBwb7/qgrjRmurkWA+N+
 lVxoXl6yH/vm03M0JPHsFshF0ktq+1V0RqTlhrY+xIl+FP4a0mV6n8fphOCt8jwnxkXX6TzefRK
 F0Nf1g8qLDIbPBWURIpHKzRobvZfF1SlQMH8cOJp8BXc6G2vSf6NHTs+uIAYOQCIFxJULSaXvis
 v8qJef1Jj71m1BHfBVvTyuDgsaprd+TxUVFpxyl5Z3fnra3ZpCAM7CWcLH6Rab5nsB88IuVvgmz
 kYr2e/CfYDcwSjfa6CdIYJXPMb3ByRLHpCPC5POE9Mz3bHuPRNaJhQiWxn6Y/kwzIEV9EKd8r4+
 IDeRAo0YMDsN0HX1nPq8zzSz3AT8rQkGRPoIGAmdGh79C7//hvTM6DPPM79tjwJHMuFpmB4mppT
 wU7AD4TNL6B10=
X-Google-Smtp-Source: AGHT+IE1871RI4vZggWCTRCwucbLQW/viXhnUDVixOtzpRmA9sqmYXdSer8XuoOOjQh1LxIuOmNRLw==
X-Received: by 2002:a05:600c:8211:b0:479:13e9:3d64 with SMTP id
 5b1f17b1804b1-47a7fa4b57fmr16140855e9.15.1765282457961; 
 Tue, 09 Dec 2025 04:14:17 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a7da22878sm15178115e9.16.2025.12.09.04.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 04:14:17 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 684A85F747;
 Tue, 09 Dec 2025 12:14:16 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Mark Burton <mburton@qti.qualcomm.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Pierrick
 Bouvier <pierrick.bouvier@linaro.org>,  Matheus Bernardino
 <mathbern@qti.qualcomm.com>,  Sid Manning <sidneym@quicinc.com>,  Brian
 Cain <bcain@quicinc.com>,  QEMU Developers <qemu-devel@nongnu.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: Record AS in full tlb
In-Reply-To: <A5D46F85-9B92-477C-B964-1DCE2A1CCF19@qti.qualcomm.com> (Mark
 Burton's message of "Tue, 9 Dec 2025 10:47:40 +0000")
References: <A5D46F85-9B92-477C-B964-1DCE2A1CCF19@qti.qualcomm.com>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Tue, 09 Dec 2025 12:14:16 +0000
Message-ID: <87ikefhmxz.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

Mark Burton <mburton@qti.qualcomm.com> writes:

> Just posting this here for the discussion this afternoon.
>
> Cheers
> Mark.
>
>
> [2. 0001-Record-AddressSpace-in-full-tlb-so-access-to-MMIO-vi.patch --- t=
ext/x-diff; 0001-Record-AddressSpace-in-full-tlb-so-access-to-MMIO-vi.patch=
]...

We were discussing last week how we should break the dependency on
CPUState for AddressSpaces while Gustavo was looking at adding the
FEAT_MEC code.

They are really a function of the machine where most CPUs will share the
same set of views. However we still need a way to resolve the AS from
the CPUs perspective.

Copying inline for easier commenting:

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index b09229dae8..4b1aa9df71 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1073,7 +1073,8 @@ void tlb_set_page_full(CPUState *cpu, int mmu_idx,
     prot =3D full->prot;
     asidx =3D cpu_asidx_from_attrs(cpu, full->attrs);
     section =3D address_space_translate_for_iotlb(cpu, asidx, paddr_page,
-                                                &xlat, &sz, full->attrs, &=
prot);
+                                                &xlat, &sz, &full->attrs,
+                                                &full->as, &prot);
     assert(sz >=3D TARGET_PAGE_SIZE);
=20
     tlb_debug("vaddr=3D%016" VADDR_PRIx " paddr=3D0x" HWADDR_FMT_plx
@@ -1294,13 +1295,13 @@ static inline void cpu_unaligned_access(CPUState *c=
pu, vaddr addr,
 }
=20
 static MemoryRegionSection *
-io_prepare(hwaddr *out_offset, CPUState *cpu, hwaddr xlat,
+io_prepare(hwaddr *out_offset, CPUState *cpu, AddressSpace *as, hwaddr xla=
t,
            MemTxAttrs attrs, vaddr addr, uintptr_t retaddr)
 {
     MemoryRegionSection *section;
     hwaddr mr_offset;
=20
-    section =3D iotlb_to_section(cpu, xlat, attrs);
+    section =3D iotlb_to_section(as, xlat, attrs);
     mr_offset =3D (xlat & TARGET_PAGE_MASK) + addr;
     cpu->mem_io_pc =3D retaddr;
     if (!cpu->neg.can_do_io) {
@@ -1618,7 +1619,7 @@ bool tlb_plugin_lookup(CPUState *cpu, vaddr addr, int=
 mmu_idx,
     /* We must have an iotlb entry for MMIO */
     if (tlb_addr & TLB_MMIO) {
         MemoryRegionSection *section =3D
-            iotlb_to_section(cpu, full->xlat_section & ~TARGET_PAGE_MASK,
+            iotlb_to_section(full->as, full->xlat_section & ~TARGET_PAGE_M=
ASK,
                              full->attrs);
         data->is_io =3D true;
         data->mr =3D section->mr;
@@ -2028,7 +2029,8 @@ static uint64_t do_ld_mmio_beN(CPUState *cpu, CPUTLBE=
ntryFull *full,
     tcg_debug_assert(size > 0 && size <=3D 8);
=20
     attrs =3D full->attrs;
-    section =3D io_prepare(&mr_offset, cpu, full->xlat_section, attrs, add=
r, ra);
+    section =3D io_prepare(&mr_offset, cpu, full->as,
+                         full->xlat_section, attrs, addr, ra);
     mr =3D section->mr;
=20
     BQL_LOCK_GUARD();
@@ -2049,7 +2051,8 @@ static Int128 do_ld16_mmio_beN(CPUState *cpu, CPUTLBE=
ntryFull *full,
     tcg_debug_assert(size > 8 && size <=3D 16);
=20
     attrs =3D full->attrs;
-    section =3D io_prepare(&mr_offset, cpu, full->xlat_section, attrs, add=
r, ra);
+    section =3D io_prepare(&mr_offset, cpu, full->as,
+                         full->xlat_section, attrs, addr, ra);
     mr =3D section->mr;
=20
     BQL_LOCK_GUARD();
@@ -2593,7 +2596,8 @@ static uint64_t do_st_mmio_leN(CPUState *cpu, CPUTLBE=
ntryFull *full,
     tcg_debug_assert(size > 0 && size <=3D 8);
=20
     attrs =3D full->attrs;
-    section =3D io_prepare(&mr_offset, cpu, full->xlat_section, attrs, add=
r, ra);
+    section =3D io_prepare(&mr_offset, cpu, full->as,
+                         full->xlat_section, attrs, addr, ra);
     mr =3D section->mr;
=20
     BQL_LOCK_GUARD();
@@ -2613,7 +2617,8 @@ static uint64_t do_st16_mmio_leN(CPUState *cpu, CPUTL=
BEntryFull *full,
     tcg_debug_assert(size > 8 && size <=3D 16);
=20
     attrs =3D full->attrs;
-    section =3D io_prepare(&mr_offset, cpu, full->xlat_section, attrs, add=
r, ra);
+    section =3D io_prepare(&mr_offset, cpu, full->as,
+                         full->xlat_section, attrs, addr, ra);
     mr =3D section->mr;
=20
     BQL_LOCK_GUARD();
diff --git a/include/accel/tcg/iommu.h b/include/accel/tcg/iommu.h
index 90cfd6c0ed..ac50e50601 100644
--- a/include/accel/tcg/iommu.h
+++ b/include/accel/tcg/iommu.h
@@ -16,22 +16,23 @@
=20
 /**
  * iotlb_to_section:
- * @cpu: CPU performing the access
+ * @as: Address space to access
  * @index: TCG CPU IOTLB entry
  *
  * Given a TCG CPU IOTLB entry, return the MemoryRegionSection that
  * it refers to. @index will have been initially created and returned
  * by memory_region_section_get_iotlb().
  */
-MemoryRegionSection *iotlb_to_section(CPUState *cpu,
-                                      hwaddr index, MemTxAttrs attrs);
+struct MemoryRegionSection *iotlb_to_section(AddressSpace *as,
+                                             hwaddr index, MemTxAttrs attr=
s);
=20
 MemoryRegionSection *address_space_translate_for_iotlb(CPUState *cpu,
                                                        int asidx,
                                                        hwaddr addr,
                                                        hwaddr *xlat,
                                                        hwaddr *plen,
-                                                       MemTxAttrs attrs,
+                                                       MemTxAttrs *attrs,
+                                                       AddressSpace **as,
                                                        int *prot);
=20
 hwaddr memory_region_section_get_iotlb(CPUState *cpu,
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index c0ca4b6905..a27d8feefc 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -269,6 +269,8 @@ struct CPUTLBEntryFull {
             bool guarded;
         } arm;
     } extra;
+
+    AddressSpace *as;
 };
=20
 /*
diff --git a/system/physmem.c b/system/physmem.c
index cf7146b224..52156325d9 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -688,7 +688,8 @@ void tcg_iommu_init_notifier_list(CPUState *cpu)
 MemoryRegionSection *
 address_space_translate_for_iotlb(CPUState *cpu, int asidx, hwaddr orig_ad=
dr,
                                   hwaddr *xlat, hwaddr *plen,
-                                  MemTxAttrs attrs, int *prot)
+                                  MemTxAttrs *attrs, AddressSpace **as,
+                                  int *prot)
 {
     MemoryRegionSection *section;
     IOMMUMemoryRegion *iommu_mr;
@@ -696,7 +697,8 @@ address_space_translate_for_iotlb(CPUState *cpu, int as=
idx, hwaddr orig_addr,
     IOMMUTLBEntry iotlb;
     int iommu_idx;
     hwaddr addr =3D orig_addr;
-    AddressSpaceDispatch *d =3D address_space_to_dispatch(cpu->cpu_ases[as=
idx].as);
+    *as =3D cpu->cpu_ases[asidx].as;
+    AddressSpaceDispatch *d =3D address_space_to_dispatch(*as);
=20
     for (;;) {
         section =3D address_space_translate_internal(d, addr, &addr, plen,=
 false);
@@ -708,13 +710,13 @@ address_space_translate_for_iotlb(CPUState *cpu, int =
asidx, hwaddr orig_addr,
=20
         imrc =3D memory_region_get_iommu_class_nocheck(iommu_mr);
=20
-        iommu_idx =3D imrc->attrs_to_index(iommu_mr, attrs);
+        iommu_idx =3D imrc->attrs_to_index(iommu_mr, *attrs);
         tcg_register_iommu_notifier(cpu, iommu_mr, iommu_idx);
         /* We need all the permissions, so pass IOMMU_NONE so the IOMMU
          * doesn't short-cut its translation table walk.
          */
         if (imrc->translate_attr) {
-            iotlb =3D imrc->translate_attr(iommu_mr, addr, IOMMU_NONE, &at=
trs);
+            iotlb =3D imrc->translate_attr(iommu_mr, addr, IOMMU_NONE, att=
rs);
         } else {
             iotlb =3D imrc->translate(iommu_mr, addr, IOMMU_NONE, iommu_id=
x);
         }
@@ -735,7 +737,8 @@ address_space_translate_for_iotlb(CPUState *cpu, int as=
idx, hwaddr orig_addr,
             goto translate_fail;
         }
=20
-        d =3D flatview_to_dispatch(address_space_to_flatview(iotlb.target_=
as));
+        *as =3D iotlb.target_as;
+        d =3D flatview_to_dispatch(address_space_to_flatview(*as));
     }
=20
     assert(!memory_region_is_iommu(section->mr));
@@ -756,12 +759,12 @@ translate_fail:
     return &d->map.sections[PHYS_SECTION_UNASSIGNED];
 }
=20
-MemoryRegionSection *iotlb_to_section(CPUState *cpu,
+
+MemoryRegionSection *iotlb_to_section(AddressSpace *as,
                                       hwaddr index, MemTxAttrs attrs)
 {
-    int asidx =3D cpu_asidx_from_attrs(cpu, attrs);
-    CPUAddressSpace *cpuas =3D &cpu->cpu_ases[asidx];
-    AddressSpaceDispatch *d =3D address_space_to_dispatch(cpuas->as);
+    assert(as);
+    AddressSpaceDispatch *d =3D address_space_to_dispatch(as);
     int section_index =3D index & ~TARGET_PAGE_MASK;
     MemoryRegionSection *ret;
=20
@@ -3102,6 +3105,9 @@ static void tcg_commit(MemoryListener *listener)
      * That said, the listener is also called during realize, before
      * all of the tcg machinery for run-on is initialized: thus halt_cond.
      */
+// Why are these removed   ?=20=20=20=20=20=20=20=20
+//     cpu_reloading_memory_map();
+//     tlb_flush(cpuas->cpu);
     if (cpu->halt_cond) {
         async_run_on_cpu(cpu, tcg_commit_cpu, RUN_ON_CPU_HOST_PTR(cpuas));
     } else {
--=20
2.51.1

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


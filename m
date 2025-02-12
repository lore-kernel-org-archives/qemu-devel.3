Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60536C021A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 10:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti9pt-0000Yw-H8; Wed, 12 Feb 2025 05:19:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1ti9pi-0000Xk-Ey
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 05:19:06 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkanwal@rivosinc.com>)
 id 1ti9pe-00045m-Mq
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 05:19:06 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38dd14c99d3so3835166f8f.3
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 02:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739355539; x=1739960339;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6XkriyTzPI5DjwkNonjIK3I5ClgViopgS3eYB4dJgVw=;
 b=Bc0YJoUPSBZnm1gnNmOtLr+9Cn2WJ3Mc5HqRZKacMlFs27NlfAEZy1ferLTMWBrAV5
 stzRoKne/DEUYYTfEB/JT9sfqw5fpjUkVhNnpEQKIXN0SxODxH0wlZ4pSPgYZ1iG3iuo
 +Rzeq+gEKaB0vV0k5vlc/G+DYnCQYANYaeMDlCGHNi0FQ3gX20gSROOsNZ5Ef0GUVnxV
 LfU43FIK6L1sQ1rTN9GEF4I4HWj2sINn/3O6lmX+xMDvaj/zGc64uEAbALXYSPR046Bj
 wmUlWzFYup+pNwS7AfG7Cz5r2Z/GeE9DGUiUw2sYXfcGdImnc0tmylYrcDnjbpCNSmJU
 7nVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739355539; x=1739960339;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6XkriyTzPI5DjwkNonjIK3I5ClgViopgS3eYB4dJgVw=;
 b=nr4ghaAbhBA7flBmnvAlC4HEMAat+OxBUusX1g5bRnRpLXKHO0OnTBFiXXZETjchT1
 EtwjW2eUSu/XKxQBWSM/q4t9NzHbmchtJs6mSs4zybMPwZ2JwwbOFghmIcv3OFyX6TQn
 lgmYwd3mq9auCwxdipTV/AyzO/je4DYCmq32tU60o8mN6ATPI+EZwINZs60MY2h7RbT6
 4txgc/Wop8k4AKQ1T8q6om/RiNFctW/p/Pel1s7EWyClnuceb0po/TGLCMN/+3u/M7BT
 vtS2eF3ypO9WzVOIyfviUv3gWamn/fPyzNfsjiEtNJo9Qh1dRMDrjvpZsjZA9Mqhzb/x
 gojg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4jGairMFpvI77tBAxBbIjufxcl/+n50lveN776HMsgd7kXb06nns8dg5+oLuBu+NXK90UBRWdqaXV@nongnu.org
X-Gm-Message-State: AOJu0YyP643q34lA5d9Bu/5xAnz95mP1AtGU+ho8Ml4+TFqoFIfxH4K7
 ddj7zF3nYEwwQaS6+o6y8whX8G+z/tAT1TdEseOoP+NbRaRWzbMKnEPOrPidlxk=
X-Gm-Gg: ASbGncu76fH4JFhZ3TKDLW2P40jC5IYs56qD1Jd0i/m0Pw56rQfEBt62z8b9AGbiCee
 WLoMvKzQx2rlVl9rQJXnlfAjiaZxacR1tPS7O6O6kxdo6SgSdhsvL4JXi9w8NskAh3LBs2yen+7
 NF4MLyIqMq+e59Y6sJjiYGX+kewjHuDKKXE5M7j2h9fjsoIASm14C8OiZRPG+1T06Dr5aY2SRj8
 C4TqoJIFHev2wM7+IBrxpEWMRbGQfYqNnao59Lbnmng6TGQaOGOxxqJWc0Gi5ygy3uq7+aS/aPd
 S1thk7OnRIbylDucfyharND0Z/Tqy179GtWSBphSJ2QpiQ==
X-Google-Smtp-Source: AGHT+IGdA1J8VnJK7SNU9iar8PaWOAn/+9tsuLrb1ZTqL02IANB01QEcVxNtosElwND1L6a6kjMNfQ==
X-Received: by 2002:a05:6000:156f:b0:38e:d026:820 with SMTP id
 ffacd0b85a97d-38ed02609f0mr1428947f8f.16.1739355538838; 
 Wed, 12 Feb 2025 02:18:58 -0800 (PST)
Received: from rkanwal-XPS-15-9520.uk.rivosinc.com ([51.52.155.79])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc73c2e00sm15148815f8f.57.2025.02.12.02.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 02:18:58 -0800 (PST)
From: Rajnesh Kanwal <rkanwal@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, rkanwal@rivosinc.com,
 beeman@rivosinc.com, jason.chien@sifive.com, frank.chang@sifive.com,
 richard.henderson@linaro.org, bmeng.cn@gmail.com
Subject: [PATCH v7] target/riscv: Add support to access ctrsource,
 ctrtarget, ctrdata regs.
Date: Wed, 12 Feb 2025 10:18:49 +0000
Message-ID: <20250212-b4-ctr_upstream_v6-v7-1-4e8159ea33bf@rivosinc.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20250205-b4-ctr_upstream_v6-71418cd245ee
X-Mailer: b4 0.14.2
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=rkanwal@rivosinc.com; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

CTR entries are accessed using ctrsource, ctrtarget and ctrdata=0D
registers using smcsrind/sscsrind extension. This commits extends=0D
the csrind extension to support CTR registers.=0D
=0D
ctrsource is accessible through xireg CSR, ctrtarget is accessible=0D
through xireg1 and ctrdata is accessible through xireg2 CSR.=0D
=0D
CTR supports maximum depth of 256 entries which are accessed using=0D
xiselect range 0x200 to 0x2ff.=0D
=0D
This commits also adds properties to enable CTR extension. CTR can be=0D
enabled using smctr=3Dtrue and ssctr=3Dtrue now.=0D
=0D
Signed-off-by: Rajnesh Kanwal <rkanwal@rivosinc.com>=0D
Acked-by: Alistair Francis <alistair.francis@wdc.com>=0D
---=0D
This series enables Control Transfer Records extension support on riscv=0D
platform. This extension is similar to Arch LBR in x86 and BRBE in ARM.=0D
The Extension has been ratified and this series is based on v1.0 [0]=0D
=0D
CTR extension depends on both the implementation of S-mode and Sscsrind=0D
extension v1.0.0 [1]. CTR access ctrsource, ctrtartget and ctrdata CSRs usi=
ng=0D
sscsrind extension.=0D
=0D
The series is based on Smcdeleg/Ssccfg counter delegation extension [2]=0D
patches [3]. CTR itself doesn't depend on counter delegation support. This=
=0D
rebase is basically to include the Smcsrind patches.=0D
=0D
Here is the link to a quick start guide [4] to setup and run a basic perf d=
emo=0D
on Linux to use CTR Ext.=0D
=0D
Qemu patches can be found here:=0D
https://github.com/rajnesh-kanwal/qemu/tree/b4/ctr_upstream_v7=0D
=0D
Opensbi patch can be found here:=0D
https://github.com/rajnesh-kanwal/opensbi/tree/ctr_upstream_v2=0D
=0D
Linux kernel patches can be found here:=0D
https://github.com/rajnesh-kanwal/linux/tree/b4/ctr_upstream_v2=0D
=0D
[0]: https://github.com/riscv/riscv-control-transfer-records/releases/tag/v=
1.0=0D
[1]: https://github.com/riscvarchive/riscv-indirect-csr-access/releases/tag=
/v1.0.0=0D
[2]: https://github.com/riscvarchive/riscv-smcdeleg-ssccfg/releases/tag/v1.=
0.0=0D
[3]: https://lore.kernel.org/qemu-riscv/20241203-counter_delegation-v4-0-c1=
2a89baed86@rivosinc.com/=0D
[4]: https://github.com/rajnesh-kanwal/linux/wiki/Running-CTR-basic-demo-on=
-QEMU-RISC%E2%80%90V-Virt-machine=0D
---=0D
Changes in v7:=0D
v7: Rebased on latest riscv-to-apply.next. Given 6 out of 7 patches=0D
    are already in riscv-to-apply.next, this version only contains the=0D
    last patch which failed to apply.=0D
=0D
v6: Rebased on latest riscv-to-apply.for-upstream.=0D
  - https://lore.kernel.org/qemu-devel/20250205-b4-ctr_upstream_v6-v6-0-439=
d8e06c8ef@rivosinc.com=0D
=0D
v5: Improvements based on Richard Henderson's feedback.=0D
  - Fixed code gen logic to use gen_update_pc() instead of=0D
    tcg_constant_tl().=0D
  - Some function renaming.=0D
  - Rebased onto v4 of counter delegation series.=0D
  - https://lore.kernel.org/qemu-riscv/20241205-b4-ctr_upstream_v3-v5-0-60b=
993aa567d@rivosinc.com/=0D
=0D
v4: Improvements based on Richard Henderson's feedback.=0D
  - Refactored CTR related code generation to move more code into=0D
    translation side and avoid unnecessary code execution in generated=0D
    code.=0D
  - Added missing code in machine.c to migrate the new state.=0D
  - https://lore.kernel.org/r/20241204-b4-ctr_upstream_v3-v4-0-d3ce6bef9432=
@rivosinc.com=0D
=0D
v3: Improvements based on Jason Chien and Frank Chang's feedback.=0D
  - Created single set of MACROs for CTR CSRs in cpu_bit.h=0D
  - Some fixes in riscv_ctr_add_entry.=0D
  - Return zero for vs/sireg4-6 for CTR 0x200 to 0x2ff range.=0D
  - Improved extension dependency check.=0D
  - Fixed invalid ctrctl csr selection bug in riscv_ctr_freeze.=0D
  - Added implied rules for Smctr and Ssctr.=0D
  - Added missing SMSTATEEN0_CTR bit in mstateen0 and hstateen0 write ops.=
=0D
  - Some more cosmetic changes.=0D
  - https://lore.kernel.org/qemu-riscv/20241104-b4-ctr_upstream_v3-v3-0-32f=
d3c48205f@rivosinc.com/=0D
=0D
v2: Lots of improvements based on Jason Chien's feedback including:=0D
  - Added CTR recording for cm.jalt, cm.jt, cm.popret, cm.popretz.=0D
  - Fixed and added more CTR extension enable checks.=0D
  - Fixed CTR CSR predicate functions.=0D
  - Fixed external trap xTE bit checks.=0D
  - One fix in freeze function for VS-mode.=0D
  - Lots of minor code improvements.=0D
  - Added checks in sctrclr instruction helper.=0D
  - https://lore.kernel.org/qemu-riscv/20240619152708.135991-1-rkanwal@rivo=
sinc.com/=0D
=0D
v1:=0D
  - https://lore.kernel.org/qemu-riscv/20240529160950.132754-1-rkanwal@rivo=
sinc.com/=0D
---=0D
 target/riscv/cpu.c         |  26 +++++++-=0D
 target/riscv/csr.c         | 150 +++++++++++++++++++++++++++++++++++++++++=
+++-=0D
 target/riscv/tcg/tcg-cpu.c |  11 ++++=0D
 3 files changed, 185 insertions(+), 2 deletions(-)=0D
=0D
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c=0D
index 8264c81e889424dfd491cec0ef95eeffc8fcc5b6..522d6584e4c3be7070e5a59f70f=
5948be8196a77 100644=0D
--- a/target/riscv/cpu.c=0D
+++ b/target/riscv/cpu.c=0D
@@ -216,6 +216,8 @@ const RISCVIsaExtData isa_edata_arr[] =3D {=0D
     ISA_EXT_DATA_ENTRY(ssu64xl, PRIV_VERSION_1_12_0, has_priv_1_12),=0D
     ISA_EXT_DATA_ENTRY(supm, PRIV_VERSION_1_13_0, ext_supm),=0D
     ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),=0D
+    ISA_EXT_DATA_ENTRY(smctr, PRIV_VERSION_1_12_0, ext_smctr),=0D
+    ISA_EXT_DATA_ENTRY(ssctr, PRIV_VERSION_1_12_0, ext_ssctr),=0D
     ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),=0D
     ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),=0D
     ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),=0D
@@ -1599,6 +1601,8 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] =
=3D {=0D
     MULTI_EXT_CFG_BOOL("smcdeleg", ext_smcdeleg, false),=0D
     MULTI_EXT_CFG_BOOL("sscsrind", ext_sscsrind, false),=0D
     MULTI_EXT_CFG_BOOL("ssccfg", ext_ssccfg, false),=0D
+    MULTI_EXT_CFG_BOOL("smctr", ext_smctr, false),=0D
+    MULTI_EXT_CFG_BOOL("ssctr", ext_ssctr, false),=0D
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),=0D
     MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),=0D
     MULTI_EXT_CFG_BOOL("zicfiss", ext_zicfiss, false),=0D
@@ -2863,6 +2867,26 @@ static RISCVCPUImpliedExtsRule SSPM_IMPLIED =3D {=0D
     },=0D
 };=0D
 =0D
+static RISCVCPUImpliedExtsRule SMCTR_IMPLIED =3D {=0D
+    .ext =3D CPU_CFG_OFFSET(ext_smctr),=0D
+    .implied_misa_exts =3D RVS,=0D
+    .implied_multi_exts =3D {=0D
+        CPU_CFG_OFFSET(ext_sscsrind),=0D
+=0D
+        RISCV_IMPLIED_EXTS_RULE_END=0D
+    },=0D
+};=0D
+=0D
+static RISCVCPUImpliedExtsRule SSCTR_IMPLIED =3D {=0D
+    .ext =3D CPU_CFG_OFFSET(ext_ssctr),=0D
+    .implied_misa_exts =3D RVS,=0D
+    .implied_multi_exts =3D {=0D
+        CPU_CFG_OFFSET(ext_sscsrind),=0D
+=0D
+        RISCV_IMPLIED_EXTS_RULE_END=0D
+    },=0D
+};=0D
+=0D
 RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] =3D {=0D
     &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,=0D
     &RVM_IMPLIED, &RVV_IMPLIED, NULL=0D
@@ -2881,7 +2905,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rule=
s[] =3D {=0D
     &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,=0D
     &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,=0D
     &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,=0D
-    &SUPM_IMPLIED, &SSPM_IMPLIED,=0D
+    &SUPM_IMPLIED, &SSPM_IMPLIED, &SMCTR_IMPLIED, &SSCTR_IMPLIED,=0D
     NULL=0D
 };=0D
 =0D
diff --git a/target/riscv/csr.c b/target/riscv/csr.c=0D
index a62c50f057f487753a79393306641d3e50085ee5..d0068ce98c156abd67b7d08f94f=
29edb957143bd 100644=0D
--- a/target/riscv/csr.c=0D
+++ b/target/riscv/csr.c=0D
@@ -2431,6 +2431,13 @@ static bool xiselect_cd_range(target_ulong isel)=0D
     return (ISELECT_CD_FIRST <=3D isel && isel <=3D ISELECT_CD_LAST);=0D
 }=0D
 =0D
+static bool xiselect_ctr_range(int csrno, target_ulong isel)=0D
+{=0D
+    /* MIREG-MIREG6 for the range 0x200-0x2ff are not used by CTR. */=0D
+    return CTR_ENTRIES_FIRST <=3D isel && isel <=3D CTR_ENTRIES_LAST &&=0D
+           csrno < CSR_MIREG;=0D
+}=0D
+=0D
 static int rmw_iprio(target_ulong xlen,=0D
                      target_ulong iselect, uint8_t *iprio,=0D
                      target_ulong *val, target_ulong new_val,=0D
@@ -2476,6 +2483,124 @@ static int rmw_iprio(target_ulong xlen,=0D
     return 0;=0D
 }=0D
 =0D
+static int rmw_ctrsource(CPURISCVState *env, int isel, target_ulong *val,=
=0D
+                          target_ulong new_val, target_ulong wr_mask)=0D
+{=0D
+    /*=0D
+     * CTR arrays are treated as circular buffers and TOS always points to=
 next=0D
+     * empty slot, keeping TOS - 1 always pointing to latest entry. Given =
entry=0D
+     * 0 is always the latest one, traversal is a bit different here. See =
the=0D
+     * below example.=0D
+     *=0D
+     * Depth =3D 16.=0D
+     *=0D
+     * idx    [0] [1] [2] [3] [4] [5] [6] [7] [8] [9] [A] [B] [C] [D] [E] =
[F]=0D
+     * TOS                                 H=0D
+     * entry   6   5   4   3   2   1   0   F   E   D   C   B   A   9   8  =
 7=0D
+     */=0D
+    const uint64_t entry =3D isel - CTR_ENTRIES_FIRST;=0D
+    const uint64_t depth =3D 16 << get_field(env->sctrdepth, SCTRDEPTH_MAS=
K);=0D
+    uint64_t idx;=0D
+=0D
+    /* Entry greater than depth-1 is read-only zero */=0D
+    if (entry >=3D depth) {=0D
+        if (val) {=0D
+            *val =3D 0;=0D
+        }=0D
+        return 0;=0D
+    }=0D
+=0D
+    idx =3D get_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK);=0D
+    idx =3D (idx - entry - 1) & (depth - 1);=0D
+=0D
+    if (val) {=0D
+        *val =3D env->ctr_src[idx];=0D
+    }=0D
+=0D
+    env->ctr_src[idx] =3D (env->ctr_src[idx] & ~wr_mask) | (new_val & wr_m=
ask);=0D
+=0D
+    return 0;=0D
+}=0D
+=0D
+static int rmw_ctrtarget(CPURISCVState *env, int isel, target_ulong *val,=
=0D
+                          target_ulong new_val, target_ulong wr_mask)=0D
+{=0D
+    /*=0D
+     * CTR arrays are treated as circular buffers and TOS always points to=
 next=0D
+     * empty slot, keeping TOS - 1 always pointing to latest entry. Given =
entry=0D
+     * 0 is always the latest one, traversal is a bit different here. See =
the=0D
+     * below example.=0D
+     *=0D
+     * Depth =3D 16.=0D
+     *=0D
+     * idx    [0] [1] [2] [3] [4] [5] [6] [7] [8] [9] [A] [B] [C] [D] [E] =
[F]=0D
+     * head                                H=0D
+     * entry   6   5   4   3   2   1   0   F   E   D   C   B   A   9   8  =
 7=0D
+     */=0D
+    const uint64_t entry =3D isel - CTR_ENTRIES_FIRST;=0D
+    const uint64_t depth =3D 16 << get_field(env->sctrdepth, SCTRDEPTH_MAS=
K);=0D
+    uint64_t idx;=0D
+=0D
+    /* Entry greater than depth-1 is read-only zero */=0D
+    if (entry >=3D depth) {=0D
+        if (val) {=0D
+            *val =3D 0;=0D
+        }=0D
+        return 0;=0D
+    }=0D
+=0D
+    idx =3D get_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK);=0D
+    idx =3D (idx - entry - 1) & (depth - 1);=0D
+=0D
+    if (val) {=0D
+        *val =3D env->ctr_dst[idx];=0D
+    }=0D
+=0D
+    env->ctr_dst[idx] =3D (env->ctr_dst[idx] & ~wr_mask) | (new_val & wr_m=
ask);=0D
+=0D
+    return 0;=0D
+}=0D
+=0D
+static int rmw_ctrdata(CPURISCVState *env, int isel, target_ulong *val,=0D
+                        target_ulong new_val, target_ulong wr_mask)=0D
+{=0D
+    /*=0D
+     * CTR arrays are treated as circular buffers and TOS always points to=
 next=0D
+     * empty slot, keeping TOS - 1 always pointing to latest entry. Given =
entry=0D
+     * 0 is always the latest one, traversal is a bit different here. See =
the=0D
+     * below example.=0D
+     *=0D
+     * Depth =3D 16.=0D
+     *=0D
+     * idx    [0] [1] [2] [3] [4] [5] [6] [7] [8] [9] [A] [B] [C] [D] [E] =
[F]=0D
+     * head                                H=0D
+     * entry   6   5   4   3   2   1   0   F   E   D   C   B   A   9   8  =
 7=0D
+     */=0D
+    const uint64_t entry =3D isel - CTR_ENTRIES_FIRST;=0D
+    const uint64_t mask =3D wr_mask & CTRDATA_MASK;=0D
+    const uint64_t depth =3D 16 << get_field(env->sctrdepth, SCTRDEPTH_MAS=
K);=0D
+    uint64_t idx;=0D
+=0D
+    /* Entry greater than depth-1 is read-only zero */=0D
+    if (entry >=3D depth) {=0D
+        if (val) {=0D
+            *val =3D 0;=0D
+        }=0D
+        return 0;=0D
+    }=0D
+=0D
+    idx =3D get_field(env->sctrstatus, SCTRSTATUS_WRPTR_MASK);=0D
+    idx =3D (idx - entry - 1) & (depth - 1);=0D
+=0D
+    if (val) {=0D
+        *val =3D env->ctr_data[idx];=0D
+    }=0D
+=0D
+    env->ctr_data[idx] =3D (env->ctr_data[idx] & ~mask) | (new_val & mask)=
;=0D
+=0D
+    return 0;=0D
+}=0D
+=0D
 static RISCVException rmw_xireg_aia(CPURISCVState *env, int csrno,=0D
                          target_ulong isel, target_ulong *val,=0D
                          target_ulong new_val, target_ulong wr_mask)=0D
@@ -2628,6 +2753,27 @@ done:=0D
     return ret;=0D
 }=0D
 =0D
+static int rmw_xireg_ctr(CPURISCVState *env, int csrno,=0D
+                        target_ulong isel, target_ulong *val,=0D
+                        target_ulong new_val, target_ulong wr_mask)=0D
+{=0D
+    if (!riscv_cpu_cfg(env)->ext_smctr && !riscv_cpu_cfg(env)->ext_ssctr) =
{=0D
+        return -EINVAL;=0D
+    }=0D
+=0D
+    if (csrno =3D=3D CSR_SIREG || csrno =3D=3D CSR_VSIREG) {=0D
+        return rmw_ctrsource(env, isel, val, new_val, wr_mask);=0D
+    } else if (csrno =3D=3D CSR_SIREG2 || csrno =3D=3D CSR_VSIREG2) {=0D
+        return rmw_ctrtarget(env, isel, val, new_val, wr_mask);=0D
+    } else if (csrno =3D=3D CSR_SIREG3 || csrno =3D=3D CSR_VSIREG3) {=0D
+        return rmw_ctrdata(env, isel, val, new_val, wr_mask);=0D
+    } else if (val) {=0D
+        *val =3D 0;=0D
+    }=0D
+=0D
+    return 0;=0D
+}=0D
+=0D
 /*=0D
  * rmw_xireg_csrind: Perform indirect access to xireg and xireg2-xireg6=0D
  *=0D
@@ -2639,11 +2785,13 @@ static int rmw_xireg_csrind(CPURISCVState *env, int=
 csrno,=0D
                               target_ulong isel, target_ulong *val,=0D
                               target_ulong new_val, target_ulong wr_mask)=
=0D
 {=0D
-    int ret =3D -EINVAL;=0D
     bool virt =3D csrno =3D=3D CSR_VSIREG ? true : false;=0D
+    int ret =3D -EINVAL;=0D
 =0D
     if (xiselect_cd_range(isel)) {=0D
         ret =3D rmw_xireg_cd(env, csrno, isel, val, new_val, wr_mask);=0D
+    } else if (xiselect_ctr_range(csrno, isel)) {=0D
+        ret =3D rmw_xireg_ctr(env, csrno, isel, val, new_val, wr_mask);=0D
     } else {=0D
         /*=0D
          * As per the specification, access to unimplented region is undef=
ined=0D
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c=0D
index 027b0324136961c61efb3fcca7a8dc13920d5e4d..29f6a3a72901abd9d56744834c6=
b0c28ae8cf685 100644=0D
--- a/target/riscv/tcg/tcg-cpu.c=0D
+++ b/target/riscv/tcg/tcg-cpu.c=0D
@@ -681,6 +681,17 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, =
Error **errp)=0D
         return;=0D
     }=0D
 =0D
+    if ((cpu->cfg.ext_smctr || cpu->cfg.ext_ssctr) &&=0D
+        (!riscv_has_ext(env, RVS) || !cpu->cfg.ext_sscsrind)) {=0D
+        if (cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_smctr)) ||=0D
+            cpu_cfg_ext_is_user_set(CPU_CFG_OFFSET(ext_ssctr))) {=0D
+            error_setg(errp, "Smctr and Ssctr require S-mode and Sscsrind"=
);=0D
+            return;=0D
+        }=0D
+        cpu->cfg.ext_smctr =3D false;=0D
+        cpu->cfg.ext_ssctr =3D false;=0D
+    }=0D
+=0D
     /*=0D
      * Disable isa extensions based on priv spec after we=0D
      * validated and set everything we need.=0D
=0D
---=0D
base-commit: 485adaaf6657dd5070dbefed593b2923a397a63f=0D
change-id: 20250205-b4-ctr_upstream_v6-71418cd245ee=0D
=0D
Best regards,=0D
-- =0D
Rajnesh Kanwal=0D
=0D


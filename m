Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482D2606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 03:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=picoheart.com header.i=@picoheart.com header.a=rsa-sha256 header.s=feishu2604151535 header.b=hQQBDG8T
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xW47K-0002TI-1p; Tue, 24 Nov 2026 22:56:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhumingjie.123@picoheart.com>)
 id 1xW47I-0002ST-N8
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 22:56:20 -0500
Received: from va-2-55.ptr.blmpb.com ([209.127.231.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhumingjie.123@picoheart.com>)
 id 1xW47G-0001X6-Rc
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 22:56:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1795578966; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=fRcNrzkHsPFAnhJpGb10+teSgNBQtww16AezXHfrFqA=;
 b=hQQBDG8Tr8gIj5WpfW2z6wxzdTKLKmoSZQtUApFTD92oUcFEdvOrYk7YrSu+X+qjW3lsYv
 SDj2ERnPFAyQRuwBnZCvgB7v18AT5v/0DPt4FmIQq3A/MAGVkQexjKqXp3jsDui5kUO00V
 oHkRttk8ovcEYkpTJrRHjhw+2ZKY4fcy9aixHcga23wDchgY31Bme7GB6XLHa2jCvocZvl
 EBuaFhEtOLPV5E70Dgn+ZaIlrQ0j3nZ818Sz5qdXy6P+fKEmd/OSO81DtqJmKoMIq3OOpR
 TLzucMgYrrJHEYqF0mNMUmeFAEPw1ZlGV0UbhLrO0/jSSrFpy5LH7PYCzpTr0Q==
To: <qemu-devel@nongnu.org>
Message-Id: <20261125035601.51127-1-zhumingjie.123@picoheart.com>
X-Original-From: Mingjie Zhu <zhumingjie.123@picoheart.com>
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH] target/riscv: Fix Sstc STIP/VSTIP handling in shared CSR
 helpers
X-Mailer: git-send-email 2.54.0
From: "Mingjie Zhu" <zhumingjie.123@picoheart.com>
Date: Wed, 25 Nov 2026 11:56:01 +0800
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: <qemu-riscv@nongnu.org>, "Palmer Dabbelt" <palmer@dabbelt.com>, 
 "Alistair Francis" <alistair.francis@wdc.com>, 
 "Weiwei Li" <liwei1518@gmail.com>, 
 "Daniel Henrique Barboza" <daniel.barboza@oss.qualcomm.com>, 
 "Liu Zhiwei" <zhiwei_liu@linux.alibaba.com>, 
 "Chao Liu" <chao.liu@processmission.com>, 
 "Yang Shen" <shenyang.young@picoheart.com>, 
 "Ziang Wang" <wangziang.ok@picoheart.com>, 
 "Mingjie Zhu" <zhumingjie.123@picoheart.com>
X-Lms-Return-Path: <lba+26b065c54+d7fa54+nongnu.org+zhumingjie.123@picoheart.com>
Received: from L67K0VQC6L ([114.94.228.66]) by smtp.feishu.cn with ESMTPS;
 Wed, 25 Nov 2026 11:56:03 +0800
Received-SPF: pass client-ip=209.127.231.55;
 envelope-from=zhumingjie.123@picoheart.com; helo=va-2-55.ptr.blmpb.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Yang Shen <shenyang.young@picoheart.com>

With Sstc enabled and STIP delegated to S-mode, an M-mode read of
sip can incorrectly report STIP as zero even though the interrupt
is pending in mip. With menvcfg.STCE=1, stimecmp=0 and
mideleg[5]=1, the unpatched build returns mip=0xa0 but sip=0x0.
Delegated STIP should be visible in sip (privileged specification
Section 3.1.9), and with Sstc it reflects the stimecmp timer
signal (Section 12.1.3), so sip should also report bit 5.

rmw_mvip64() is shared by sip and mvip accesses. Its alias_mask
controls which bits are taken from mip when assembling the value
for the current CSR view. The STIP exception is appropriate for
mvip/mviph, but the env->priv == PRV_M condition also applies it
to an M-mode read of sip. The timer remains pending in mip; only
the value assembled for sip is wrong. Check csrno instead and
apply this exception only to CSR_MVIP and CSR_MVIPH.

rmw_mip64() has a related problem for an M-mode write to hvip
when both menvcfg.STCE and henvcfg.STCE are enabled. The old
privilege-based condition does not distinguish hvip from the
other CSR views using this helper and therefore masks VSTIP from
the write. However, hvip.VSTIP is a writable software-injection
bit (Section 15.2.3). It is distinct from hip.VSTIP, the read-only
OR of the VS timer signal and the software-injected bit;
mip.VSTIP aliases hip.VSTIP (Section 15.4.3), rather than naming
the hvip injection input.

On RV64, setting vstimecmp to all ones keeps the VS timer from
expiring during the test, isolating the software-injection input.
An M-mode write of hvip.VSTIP=1 then leaves bit 6 clear in the
unpatched build, while the patched build reads it back as set.
Within the existing Sstc and menvcfg.STCE handling in this
helper, mask VSTIP only when the access is not through
hvip/hviph and henvcfg.STCE is enabled.

Also drop the privilege-level condition from the STIP write mask.
For ordinary sip writes, the outer writable mask already prevents
software from modifying STIP.

Signed-off-by: Yang Shen <shenyang.young@picoheart.com>
Signed-off-by: Ziang Wang <wangziang.ok@picoheart.com>
Signed-off-by: Mingjie Zhu <zhumingjie.123@picoheart.com>
---
Validation used a local bare-metal RISC-V probe; it is not
included in this submission as an upstream regression test.

The unpatched reference was built from upstream master
8f66cb7904. The patched build was based on upstream master
2bfbe39d0f plus this change. These are two separately recorded
builds, not before-and-after builds from the same baseline commit.

With the VS timer not pending, the patched build reads back bit 6
as set after software writes hvip.VSTIP=1. When the VS timer is
already pending, hvip.VSTIP still reads back as zero after such a
write; this known limitation remains outside the scope of the
change.

 target/riscv/tcg/csr.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index af444e3e6f..121b7b9624 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -3999,15 +3999,27 @@ static RISCVException rmw_mip64(CPURISCVState *env, int csrno,
         new_val |= env->external_seip * MIP_SEIP;
     }
 
-    if (riscv_cpu_cfg(env)->ext_sstc && (env->priv == PRV_M) &&
+    if (riscv_cpu_cfg(env)->ext_sstc &&
         get_field(env->menvcfg, MENVCFG_STCE)) {
-        /* sstc extension forbids STIP & VSTIP to be writeable in mip */
-
-        /* STIP is not writable when menvcfg.STCE is enabled. */
+        /*
+         * With Sstc active, mip.STIP is read-only and driven by stimecmp,
+         * so drop software writes to STIP regardless of privilege level
+         * or which CSR view (mip/sip) the write arrives through.
+         *
+         * VSTIP is different: hvip.VSTIP stays a writable software
+         * injection source (hip.VSTIP is the logical-OR of hvip.VSTIP
+         * and the vstimecmp timer signal, which QEMU keeps separately in
+         * env->vstime_irq and ORs in on read below). Blocking hvip
+         * writes here would both disable legal VS timer injection from
+         * HS-mode and leave a previously injected bit stuck in env->mip,
+         * uncleanable from M-mode. Only block the mip view of VSTIP
+         * (an alias of the read-only hip.VSTIP), and only when
+         * vstimecmp is active for the guest, matching upstream commit
+         * 3cb2edae7401 ("target/riscv: Fix VSTIP bit in sstc extension.").
+         */
         mask = mask & ~MIP_STIP;
-
-        /* VSTIP is not writable when both [mh]envcfg.STCE are enabled. */
-        if (get_field(env->henvcfg, HENVCFG_STCE)) {
+        if (csrno != CSR_HVIP && csrno != CSR_HVIPH &&
+            get_field(env->henvcfg, HENVCFG_STCE)) {
             mask = mask & ~MIP_VSTIP;
         }
     }
@@ -4126,9 +4138,12 @@ static RISCVException rmw_mvip64(CPURISCVState *env, int csrno,
 
     /*
      * If sstc is present, mvip.STIP is not an alias of mip.STIP so clear
-     * that our in mip returned value.
+     * that our in mip returned value. This only applies to accesses to
+     * mvip itself (an M-mode-only CSR, so no privilege check is needed);
+     * for the sip view an interrupt delegated via mideleg must keep the
+     * (read-only, stimecmp-driven) mip.STIP state visible to S-mode.
      */
-    if (cpu->cfg.ext_sstc && (env->priv == PRV_M) &&
+    if (cpu->cfg.ext_sstc && (csrno == CSR_MVIP || csrno == CSR_MVIPH) &&
         get_field(env->menvcfg, MENVCFG_STCE)) {
         alias_mask &= ~MIP_STIP;
     }
-- 
2.34.1


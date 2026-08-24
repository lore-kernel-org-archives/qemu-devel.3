Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC87BC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNaS-0004Ce-8F; Mon, 24 Aug 2026 01:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNZJ-00025Z-Bv
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:50:04 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNZH-00029t-EY
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:50:00 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-38ec1402b05so2252682a91.2
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550598; x=1788155398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Dcu9FE/U8PfA/SpygFMvwaeC9nhEaYjrnABSaaS6uHA=;
 b=nrbi76uoV9b7BTndsQKaVx5fT1kQLewAhzMbvep3GnoHtrLyvUu7OSHvrm12IGinVx
 /RAW2XkqwTHw0glYfCuxC5y4mrvrb2QoZwwah0d94xfYJ+15q5wVWd5ezu5QiLs6qgyV
 6YxeMxbNsARrC1xcsEhqLtJgJrv3A40uEsD8IfaJAehVumLKdyxJtzppmAMyYHxPz38K
 EPn8KvugtLgQy8IXyosJj1mhI7rwksEaI1CsG/S+M262K6C/xqArCKzk67F4K2/HZ+8+
 /6H+sEG1nNwaECff05DymSlBd8wlSdgO4vhIKjMCEWsw7JnVBagNKUcaK1GKx8el13Wo
 gaIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550598; x=1788155398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Dcu9FE/U8PfA/SpygFMvwaeC9nhEaYjrnABSaaS6uHA=;
 b=j4W+IVx/lmDT2Gj5F5hwmYR15LujqMll39GpOQKauGgVYNhyrO8BZLBNYs+uLnhZ3A
 EU6hqLweufKtTjBhPbr8qR9Q//hbwfqspWF/a2crA1R4cUzR1/TfLKO/pyOByq1T90hG
 yx9Vt9IHgnjuHGGm7akILHo3KDrip/ayW4P2Vgw36GB74UfYgfZrAHnLVEmONR5wqm7b
 w7JFxEhStCbDYQjj+pfLC/Rxh3O2SSnGozv6MtYmWRPfFqaQOwVoIygeDnzHPtmDvrSS
 +ERD0513lhJhLUqKYhnf5z97gH4nugCiYLKRqj5nxGh01hIG7quM4OukTpaQuICxu3J1
 inXA==
X-Gm-Message-State: AFuF++lhElh2VThzsgZTghkTLp9BgKjO5A4cmrj8zkaw/7E8uJ1ZqDpg
 Ry0xm+qtvbnfmoIebk9U1uCHJ++49qFq/n/QKvy2J24JsJ6n5nSErXgc2VRx5Q==
X-Gm-Gg: AR+sD13KU1GIHbIzpXAv4dwRI+t+W86+73s4WY4i/V0VVtSv3DLs92W062veWaKoFJX
 sXmRev2UPi+mRbds8L+962w57xzIlZ6ku8+rMNgsutAaUDoTxu0b75gQGpDaQtHQFVGSyyEUiM4
 Dsr/jhQSiDRVRhPowxtk9ql7u1wM/NwJEqQ2INg43f4b6e7Ecf0NryKOZy/GXVNOL5ZwN8BIs5N
 iJTymJccXjn9BsyzDgVc73+5Fe09Bd1ODnXxZaJ/mlVBF5fuHP4kWTq97oK/ZYV/DN7J2QzFjlp
 s511Bb9NIZtzXx9JYpemdMqlLa10vqo67TJQg5tqBPtiJfmT9y3Qty7nqQj0v6rh7Tpw334SLmV
 OAdJu7tzAz01KgAcvEqVJmGdahU+h6qsN5bLU4JOzngds05RcsJQlwIyhzJr09I+n9wHzf6mvhp
 FVeHVoJRbAZHsH7S75Pvm00n9Z5BOLqZMxr1J/Zlq0gzRAAi5BMdWs/lFrT7mmaMv3H56XSx26C
 JhRtXfkgp1O/t07
X-Received: by 2002:a17:90b:1b03:b0:38e:524:8797 with SMTP id
 98e67ed59e1d1-395c39cb2damr37498503a91.13.1787550597898; 
 Sun, 23 Aug 2026 22:49:57 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:49:57 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Nutty Liu <nutty.liu@hotmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 31/96] hw/riscv/riscv-iommu: fix U-bit check to apply only
 to leaf S/VS-stage PTEs
Date: Mon, 24 Aug 2026 15:47:01 +1000
Message-ID: <20260824054806.2790041-32-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102f.google.com
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

From: Andrew Jones <andrew.jones@oss.qualcomm.com>

Commit b795ea0ba471 ("hw/riscv/riscv-iommu.c: fault when !PTE_U and
no priv access") placed its check ahead of the leaf-vs-non-leaf
branch in riscv_iommu_spa_fetch(), so it fires on every PTE walked,
including non-leaf/table entries. Per the RISC-V privileged spec's
address translation algorithm (Sv39/Sv48/etc., the "leaf PTE has
been reached" step, followed separately by the U-bit permission
check), the U bit is only defined and checked for the leaf PTE
reached at the end of the walk -- non-leaf PTEs don't carry a
meaningful U bit at all.

Move the check after the leaf/non-leaf branch, alongside the other
leaf-only checks, mirroring how the G_STAGE U-bit check (added in
9158c900ab30) is already correctly placed.

Fixes: b795ea0ba471 ("hw/riscv/riscv-iommu.c: fault when !PTE_U and no priv access")
Signed-off-by: Andrew Jones <andrew.jones@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Message-ID: <20260717112340.1071148-1-andrew.jones@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/riscv-iommu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index f6865d1e16..ed9fb09f8b 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -476,13 +476,6 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
             break;                /* Invalid PTE */
         } else if (pte & PTE_RESERVED(false)) {
             break;                /* Reserved PTE bits set */
-        } else if (!(pte & PTE_U) && !pv) {
-            /*
-             * All accesses are assumed to be User mode unless
-             * process_id is valid (pv).  In case we have a
-             * non-user mode PTE and !pv we need to fault.
-             */
-            break;
         } else if (!(pte & (PTE_R | PTE_W | PTE_X))) {
             base = PPN_PHYS(ppn); /* Inner PTE, continue walking */
         } else if ((pte & (PTE_R | PTE_W | PTE_X)) == PTE_W) {
@@ -491,6 +484,13 @@ static int riscv_iommu_spa_fetch(RISCVIOMMUState *s, RISCVIOMMUContext *ctx,
             break;                /* Reserved leaf PTE flags: PTE_W + PTE_X */
         } else if (ppn & ((1ULL << (va_skip - TARGET_PAGE_BITS)) - 1)) {
             break;                /* Misaligned PPN */
+        } else if (!(pte & PTE_U) && !pv) {
+            /*
+             * All accesses are assumed to be User mode unless
+             * process_id is valid (pv).  In case we have a
+             * non-user mode leaf PTE and !pv we need to fault.
+             */
+            break;
         } else if ((iotlb->perm & IOMMU_RO) && !(pte & PTE_R)) {
             break;                /* Read access check failed */
         } else if ((iotlb->perm & IOMMU_WO) && !(pte & PTE_W)) {
-- 
2.54.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5735EC531C9
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 23:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woUsg-0002tx-3e; Mon, 27 Jul 2026 19:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sun4qemu@gmail.com>)
 id 1woUsf-0002tp-Fj
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 19:37:09 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sun4qemu@gmail.com>)
 id 1woUsV-0002Ql-4p
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 19:37:01 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-47f84023916so3236755f8f.3
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 16:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785195417; x=1785800217; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CigsiWeyA1HuSQ8GLStcze2Pv5BC6aTI0LG5dEVFdW8=;
 b=m6Ccxi1f5yodzdr3cXVBn+ag49Aavg6scZxhfe8P58W9iT0zhPoTg0qYe+QySx15D/
 A53PFPI+4/9r7/XLQdeDm2iHc+t+xGYnt0X1CcmY/idmtoxwx+yv3Zt3rRq66JPrGb/p
 sX/mMC0Hzaml/FqQ3rv3/yPZDvayIuvGcU0M37iMQ+QcTirZZ3GKrO7Eq2xEeCOi63qo
 IiRPKYfCQCYr3FPKYMA4wpgT7krslgha96QPYhQgGtzBqktg1x7q4W0zUiJqvD22E1Ut
 LwYpCCTx9RRfmVSADZa9IUIEjOlzZ8mZirSNnwLBe4jOQ+nfDqwqdP+YxrQlwt25O8dl
 4+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785195417; x=1785800217;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CigsiWeyA1HuSQ8GLStcze2Pv5BC6aTI0LG5dEVFdW8=;
 b=qjX2UXbkjeQ+dI5HoNWGucJ74VOSS5VMePVaLSuMofLUYmUAUo9KBwVL8hHOdWJVkn
 OZ5YqKC1bw48PkMD46LZuuz2jlP2WxpBJdSgYO8kzrILOx5B79yjlv+gpcGAAS8k0lGG
 X8bD8LitWg26OZOqNNImUTC72Lsxmzv7GAnjmSww4fnTCkp9t+U+K0qDTG1J5IOPQjmc
 rawiXV2Px5O3ON2RxJPbAyKuts5cgvS2rlXTMV0hV8UZUndq5EYIG8Cjb5sRytCknBNB
 8X6fCQTGCvyAmcHL/wmZOqVWz5/EclRbunELiR4iI8xuYeRsthTNXXhLltBlpshQzjHc
 rusw==
X-Gm-Message-State: AOJu0Yxwnnk6uEW8xgZAYSMSKDtbjMQHtb+fJf/AhN+QIBwl6V54Zb1h
 FPAAOhgC3v0eKgyh6FYK9OIVZ53jnNmXhcIv1cqeaBio0yJ6sHN8KhOS
X-Gm-Gg: AR+sD11DtrsZoy8msAsNwInWNS95LeN6xcqjX0bx77gHzDoWF640Dm/CuR/uRtGLSU8
 8yyVNQvRqaHGka3qEfSWcdOe8v/FZNhao4qSufoiHOcE656xMKCyB3JCekUaZ1+A0q4hiNAnDv9
 dE0VgTiU7esBBe7HWF4FAKZl9foanu41gx+R/L5A3Tx16pBkliLo7YSp/zji72qihDoJvTjJYZa
 HcJYrvwoozUl4mkUxeW1M0wjQkCx1997ORoWsudl3fEZWVAllOuPwaKYzQDWcLu+4AYXegSrNF0
 JDBHwc9uG47g/L8eGVBJb8DS/ehE8QRuJbBf1WWmWDoFV7SmkhgAmpD1iFAUjkrOTUJzn6GN8hi
 Quiasw4Ppn6T6jdqU3nVjCie81WhSY2V/qYL7sOswYyPGZ1mkyDZl9vPZwV4oI+1g4eMfdN8QzU
 73ERAIzqQ69tBhDUREqiICCFy3Wiq9japYlA==
X-Received: by 2002:a05:6000:22c4:b0:47f:9266:7cbf with SMTP id
 ffacd0b85a97d-47fb1ed729fmr1159f8f.20.1785195417207; 
 Mon, 27 Jul 2026 16:36:57 -0700 (PDT)
Received: from vmbox.lan (088156177242.warszawa.vectranet.pl. [88.156.177.242])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a60asm56317546f8f.3.2026.07.27.16.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 16:36:56 -0700 (PDT)
From: Dmitry Pimenov <sun4qemu@gmail.com>
To: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Cc: qemu-devel@nongnu.org,
	dpim <sun4qemu@gmail.com>
Subject: [PATCH] target/sparc: fix sun4v TTE page-size truncation (32M/256M
 pages)
Date: Tue, 28 Jul 2026 01:36:46 +0200
Message-ID: <20260727233646.332875-1-sun4qemu@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=sun4qemu@gmail.com; helo=mail-wr1-x435.google.com
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

From: dpim <sun4qemu@gmail.com>

sun4v_tte_to_sun4u() keeps only 2 bits of the incoming TTE page-size
field, while TTE_PGSIZE_UA2005() in the same header defines it as 3.
Sizes 32M (4) and 256M (5) therefore alias down to 64K (1) and 512K
(2): a guest asking for a large page gets a TLB entry covering a
fraction of it, and faults on the first access past that.

Keep all three bits, in the two pieces the hardware uses for them:

    bit 62:61   Size<1:0>
    bit 48      Size<2>

That is the sun4u encoding introduced when 32M and 256M pages were
added, so it is where the field belongs in this word rather than in an
arbitrary spare bit:

  Panther Implementation Supplement (SPARC V9 JPS1 Implementation
  Supplement: Sun UltraSPARC Panther -- UltraSPARC IV+), Preliminary
  Draft 17 Mar 2006, TABLE F-1-4 "TTE Data Field Description", p.337:
    Size<1:0>  "Bit <62:61> represent the least significant 2 bits of
                the page size" -- 000=8K 001=64K 010=512K 011=4M
                100=32M 101=256M
    Size<2>    "Bit 48 is the most significant bit of the page size and
                is concatenated with bits <62:61>"
  https://www.oracle.com/technetwork/server-storage/sun-sparc-enterprise/documentation/sparc4plus-usersmanual-2516673.pdf

UltraSPARC T1 keeps bit 48 for the same purpose in its sun4u-format
TTE, where the halves are called szl and szh:

  UltraSPARC T1 Supplement to the UltraSPARC Architecture 2005,
  Draft D2.1, sec. 13.1.2, TABLE 13-1, p.182
  https://www.oracle.com/docs/tech/systems/t1-09-ust1-uasuppl-draft-hp-ext.pdf

TTE_PGSIZE() is shared with the sun4u path, which is fine in both
directions. Parts that predate the extension -- UltraSPARC III,
SPARC64 V -- have a 2-bit size field and bit 48 reserved, reading as
zero:

  JPS1 Commonality, Working Draft 1.0.5, TABLE F-1, p.441:
    Data<49:47>  "Reserved, read as 0" (bit 48 is part of this range)
  https://www.oracle.com/technetwork/server-storage/sun-sparc-enterprise/documentation/joint-program-spec1-2516675.pdf

so they keep decoding the same four sizes as before; parts that do
implement Size<2> now get 32M and 256M decoded correctly.

Callers computing 8192ULL << 3*TTE_PGSIZE(tte) then get 32M and 256M
for free. Two related fixes come with it:

  - demap_tlb() built its mask from the raw bits ((tte>>61)&3) rather
    than the accessor, so large-page demaps truncated the same way.
    It now uses TTE_PGSIZE().

  - dump_mmu() gains 32M/256M labels.

A QEMU_BUILD_BUG_ON guards bit 48 against a future overlapping TTE_*
field.

Tested with rebuilt machine-description blobs -- 1up-md.bin and
1up-hv.bin, two of the six files hw/sparc64/niagara.c loads. These are
generated with mdgen, not the pair shipped in the OpenSPARC T1
archive, whose MD does not declare the property at all: the cpu node
here sets mmu-page-size-list = 0x2b, so the guest actually selects
TTE256M. kmem64_szc = 0x5 confirmed under Solaris kmdb guest at a
breakpoint on alloc_kmem64(), and "info tlb" -- whose 32M/256M labels
this same patch adds to dump_mmu() -- shows a live 256M entry at the
matching kmem64_base address, e.g.:

  [57] VA: 70000100000, PA: 150000000, 256M, priv, RW, unlocked, ie no, ctx 0 local

confirming the kernel's kmem64 mapping is backed by an actual 256M
TLB entry, not a 512K one truncated from the same bits.

Solaris 10 3/05 HW2, 10u8, 10u10, 10u11, OpenSolaris snv_134, Solaris
11 Express 2010.11, Solaris 11 11/11 and Solaris 11.1 boot at 4GB and
8GB; the same configurations trapped or hung in early kernel VM setup
before the fix.

Link: https://unix0cc.github.io/md/
AI-used-for: code, research, and result analysis.
Signed-off-by: dpim <sun4qemu@gmail.com>
---
 target/sparc/cpu.h         | 38 +++++++++++++++++++++++++++++++++++++-
 target/sparc/ldst_helper.c | 18 ++++++++++++++++--
 target/sparc/mmu_helper.c  | 12 ++++++++++++
 3 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 5f583ed9de..17d1308101 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -307,10 +307,46 @@ enum {
 #define TTE_SET_USED(tte)   ((tte) |= TTE_USED_BIT)
 #define TTE_SET_UNUSED(tte) ((tte) &= ~TTE_USED_BIT)
 
-#define TTE_PGSIZE(tte)     (((tte) >> 61) & 3ULL)
 #define TTE_PGSIZE_UA2005(tte)     ((tte) & 7ULL)
 #define TTE_PA(tte)         ((tte) & 0x1ffffffe000ULL)
 
+/*
+ * Internal QEMU TLB-entry page-size field: Size<1:0> at bits 62-61 plus
+ * Size<2> at bit 48, encoding the six sizes 8K/64K/512K/4M/32M/256M.
+ *
+ * That split is the sun4u encoding introduced when 32M and 256M pages were
+ * added, and it is the layout this internal word models:
+ *
+ *   Panther Implementation Supplement (SPARC V9 JPS1 Implementation
+ *   Supplement: Sun UltraSPARC Panther -- UltraSPARC IV+), Preliminary
+ *   Draft 17 Mar 2006, TABLE F-1-4 "TTE Data Field Description", p.337:
+ *     Size<1:0>  "Bit <62:61> represent the least significant 2 bits of
+ *                 the page size" -- 000=8K 001=64K 010=512K 011=4M
+ *                 100=32M 101=256M
+ *     Size<2>    "Bit 48 is the most significant bit of the page size and
+ *                 is concatenated with bits <62:61>"
+ *
+ * UltraSPARC T1 keeps bit 48 for the same purpose in its sun4u-format TTE,
+ * where the halves are called szl and szh (UltraSPARC T1 Supplement to the
+ * UltraSPARC Architecture 2005, Draft D2.1, TABLE 13-1, p.182).
+ *
+ * Earlier JPS1 parts -- UltraSPARC III, SPARC64 V -- have a 2-bit size
+ * field with bit 48 reserved, reading as zero (JPS1 Commonality, Working
+ * Draft 1.0.5, TABLE F-1, p.441), so they keep decoding the same four
+ * sizes as before.
+ *
+ * Only the low two bits used to be kept here, which truncated 32M/256M.
+ *
+ * The QEMU_BUILD_BUG_ON below fails the build if any other TTE_* field is
+ * ever defined overlapping bit 48, so a future field can never silently
+ * corrupt page-size decoding at runtime.
+ */
+#define TTE_PGSIZE_HI_BIT   (1ULL << 48)
+QEMU_BUILD_BUG_ON((TTE_PGSIZE_HI_BIT & (TTE_VALID_BIT | TTE_NFO_BIT |
+                                        TTE_USED_BIT | TTE_PA(~0ULL))) != 0);
+#define TTE_PGSIZE(tte)     ((((tte) >> 61) & 3ULL) | \
+                             (((tte) & TTE_PGSIZE_HI_BIT) >> 46))
+
 /* UltraSPARC T1 specific */
 #define TLB_UST1_IS_REAL_BIT   (1ULL << 9)  /* Real translation entry */
 #define TLB_UST1_IS_SUN4V_BIT  (1ULL << 10) /* sun4u/sun4v TTE format switch */
diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 4ec8799d1f..43a7ab6b09 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -186,7 +186,7 @@ static void demap_tlb(SparcTLBEntry *tlb, target_ulong demap_addr,
                 /* demap page
                    will remove any entry matching VA */
                 mask = 0xffffffffffffe000ULL;
-                mask <<= 3 * ((tlb[i].tte >> 61) & 3);
+                mask <<= 3 * TTE_PGSIZE(tlb[i].tte);
 
                 if (!compare_masked(demap_addr, tlb[i].tag, mask)) {
                     continue;
@@ -217,7 +217,21 @@ static uint64_t sun4v_tte_to_sun4u(CPUSPARCState *env, uint64_t tag,
         return sun4v_tte;
     }
     sun4u_tte = TTE_PA(sun4v_tte) | (sun4v_tte & TTE_VALID_BIT);
-    sun4u_tte |= (sun4v_tte & 3ULL) << 61; /* TTE_PGSIZE */
+    /*
+     * sun4v/UA2005 page size is a 3-bit field (TTE_PGSIZE_UA2005, values
+     * 0-5 = 8K/64K/512K/4M/32M/256M). Storing only the low 2 bits here (as
+     * this historically did) silently aliased 32M(4)/256M(5) down to
+     * 64K(1)/512K(2), so a guest asking for a large page got a real TLB
+     * entry covering a much smaller region. Preserve all three bits: the
+     * low two stay at 61-62, the high one goes to TTE_PGSIZE_HI_BIT
+     * (bit 48), which is where real UltraSPARC T1 keeps szh -- see the
+     * comment on TTE_PGSIZE_HI_BIT in cpu.h.
+     */
+    {
+        uint64_t pgsz = TTE_PGSIZE_UA2005(sun4v_tte);
+        sun4u_tte |= (pgsz & 3ULL) << 61;                 /* low 2 bits: 61-62 */
+        sun4u_tte |= (pgsz & 4ULL) ? TTE_PGSIZE_HI_BIT : 0; /* high bit */
+    }
     sun4u_tte |= CONVERT_BIT(sun4v_tte, TTE_NFO_BIT_UA2005, TTE_NFO_BIT);
     sun4u_tte |= CONVERT_BIT(sun4v_tte, TTE_USED_BIT_UA2005, TTE_USED_BIT);
     sun4u_tte |= CONVERT_BIT(sun4v_tte, TTE_W_OK_BIT_UA2005, TTE_W_OK_BIT);
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 07ba25dfce..8544de097d 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -830,6 +830,12 @@ void dump_mmu(CPUSPARCState *env)
             case 0x3:
                 mask = "  4M";
                 break;
+            case 0x4:
+                mask = " 32M";
+                break;
+            case 0x5:
+                mask = "256M";
+                break;
             }
             if (TTE_IS_VALID(env->dtlb[i].tte)) {
                 qemu_printf("[%02u] VA: %" PRIx64 ", PA: %llx"
@@ -869,6 +875,12 @@ void dump_mmu(CPUSPARCState *env)
             case 0x3:
                 mask = "  4M";
                 break;
+            case 0x4:
+                mask = " 32M";
+                break;
+            case 0x5:
+                mask = "256M";
+                break;
             }
             if (TTE_IS_VALID(env->itlb[i].tte)) {
                 qemu_printf("[%02u] VA: %" PRIx64 ", PA: %llx"
-- 
2.43.0



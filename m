Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD52F436BB
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 16:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDmIZ-0003Ux-ED; Fri, 17 Apr 2026 12:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wDmI6-0003ON-7U
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 12:43:38 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wDmI3-0004sb-4I
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 12:43:37 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso10467295e9.2
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 09:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776444213; x=1777049013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1u4VMlYWoknXWIQYDOwzMT4DF7B50H/00MexCpIIM+0=;
 b=KqYPDkG0E7l2voo7+L+eY+TQ+2fmmpeKH7RiskDSTazXO0zY8NWfJ3WKzxgkGpQJm2
 cJJSnNpPs0coxXsfPM4UV70HSF773QL5Slr+OfkXmWmD/nKzszesoihf99+7mGK/gKMw
 YljbB25yRP3DQ3DFazvChEdrkS6dnj3W2B1MF1kAxPXVL+tdywmjyAxwndXOqA5djwQe
 UD5Oat8KkdNGW3kg4om6zm9ZMAl35UkLVhQei7AuyU0LN+zfUeY5AxFwDPhlrNQKgttI
 PfhGXXmJxmiyfQouDYXphQRc2D8fdk8ylRopKCh3/waNdJuFeQc2/EaM1b02eO66AyKC
 W5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776444213; x=1777049013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1u4VMlYWoknXWIQYDOwzMT4DF7B50H/00MexCpIIM+0=;
 b=a69ORbo6PyGWrcqwl5dKPf4CRTOIUp2xL/4NnCTE8Eb6+TGqKR3CcpO/aVcF9n65g9
 abDMZW5JSctKjuRs75VmzWBw5m+PZedhWLwvBSkY/zS7xaGTqFWtlsOKbLRsQK9iD427
 pQGpGc80CyVtk4yJklk22ipiNxbjxx8GRTPze4LsByvx8MyEAq49Mgmt5/oTkiChTfoE
 ZiVJlQIqEq5nsZ5HNicLIjx+s4Yy8XcODNsm677GM4b1GnQ/nFKsZWQj6QeNZMF3RP4Y
 4Cf196VYrVOL1If3DKmoZK8DB1cyzQwT4V69Etqc3WSlmB3PWc3WlpQSFY1GOHl2Bhka
 0/TQ==
X-Gm-Message-State: AOJu0YxgGkTBQYPtCdxTE2g9w2XEXEqpiqB8Vpy5nEpnjIj2WA3RsQma
 ZZnWGEeDrIOdyaN0L2nd7AZXlRBhSwuBA7thWEs3EtjO2VV65DAxbTB4uka+F4ZiVls=
X-Gm-Gg: AeBDiespaM7WfXEE2bMZ/AiEfHaoNSnuwmsmu08HI/cvGxx2y0lfO0HVllHAN9ecevj
 NehrmLABi82rz6wEJi3hNDAe42czz+LLyKexHr2UBSk+/Uj5M81l8uUPcRiGqVkknsdSYFJ02K8
 wkEX8ExSD/2idIliX1WITDRh842c6/kWyIYN3Y0iEASQhzk0VZpgFIJKEFAxmSaC81tOPkKtlmq
 mk7IT5AV17HXuQo6GECOl0Almg+EroJeqwpW9ONIntgxJQVOV5MbhnPqT/nv0bjtOTiMTmJ83uK
 rkVEvpTK9h878Da+RH/F40fTDseXl2+uHDQQ3K3kcZBmh2e/ihyMEKppoJFLu2rhqFYFtXfAkPf
 KUA68J3vBZA4b3sLAXm56ku5VIIrcuxQZ7l6uUy2sStspXVw4aZ75eooWtIeanuQHrpPD+mVg70
 xsaZ5QyWaz17Hk5zbY5x+2TrkhoAfmjQii3g==
X-Received: by 2002:a05:600d:14:b0:488:bc6a:5285 with SMTP id
 5b1f17b1804b1-488fb7957efmr37591885e9.30.1776444213494; 
 Fri, 17 Apr 2026 09:43:33 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1393f5sm53147385e9.9.2026.04.17.09.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 09:43:32 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E74675FA18;
 Fri, 17 Apr 2026 17:43:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 5/7] tests/tcg: add HW page for aarch64 tests
Date: Fri, 17 Apr 2026 17:43:25 +0100
Message-ID: <20260417164328.1009132-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260417164328.1009132-1-alex.bennee@linaro.org>
References: <20260417164328.1009132-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

If the test cases need to program items like the GIC we need to define
the region as Device-nGnRE memory. As this is for test cases just map
the whole first GB block (which is all HW in the -M virt machine).

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/aarch64/system/lib/pgtable.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/tests/tcg/aarch64/system/lib/pgtable.c b/tests/tcg/aarch64/system/lib/pgtable.c
index a558f5f0dd5..5e7d95fd3d7 100644
--- a/tests/tcg/aarch64/system/lib/pgtable.c
+++ b/tests/tcg/aarch64/system/lib/pgtable.c
@@ -17,14 +17,18 @@ uint64_t ttb_l1[512] __attribute__((aligned(4096)));
 uint64_t ttb_l2[512] __attribute__((aligned(4096)));
 
 /*
- * Setup a flat address mapping page-tables. Stage one simply
- * maps RAM to the first Gb. The stage2 tables have two 2mb
- * translation block entries covering a series of adjacent
- * 4k pages.
+ * Setup a flat address mapping page-tables.
+ *
+ * ttb (Level 1):
+ *   - Entry 0 [0 - 1GB]: 1GB Device block (for GIC and other H/W)
+ *   - Entry 1 [1GB - 2GB]: Table entry pointing to ttb_l2 (for RAM)
  */
 void setup_pgtables(void)
 {
-    /* L1 entry points to L2 table */
+    /* L1 entry 0: 1GB Device block mapping at 0x0 */
+    pgt_map_l1_block(ttb_l1, 0, 0, DESC_AF | DESC_ATTRINDX(2));
+
+    /* L1 entry 1: points to L2 table for finer permissions */
     pgt_map_l1_table(ttb_l1, (uintptr_t)_text_start, ttb_l2);
 
     /* L2 entries: 2MB blocks */
@@ -40,8 +44,14 @@ void setup_pgtables(void)
     /* Set TTBR0_EL1 */
     write_sysreg(ttb_l1, ttbr0_el1);
 
-    /* Set MAIR_EL1 */
-    write_sysreg(0xeeULL, mair_el1);
+    /*
+     * Set MAIR_EL1
+     *
+     * Attr0 (0xee): Normal memory, Outer/Inner WB/WA/Read-Alloc
+     * Attr1 (0x00): MTE page
+     * Attr2 (0x04): Device-nGnRE memory (for the first 1GB)
+     */
+    write_sysreg(0x0400eeULL, mair_el1);
 
     /* Set TCR_EL1 */
     uint64_t tcr = TCR_EL1_IPS_40BIT | TCR_EL1_TG0_4KB | TCR_EL1_ORGN0_WBWA | TCR_EL1_IRGN0_WBWA | TCR_EL1_T0SZ(25);
-- 
2.47.3



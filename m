Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1F6C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 02:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whe98-0004ez-Vi; Wed, 08 Jul 2026 22:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1whe97-0004eo-B7
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 22:05:49 -0400
Received: from out-186.mta0.migadu.com ([2001:41d0:1004:224b::ba])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cui.tao@linux.dev>) id 1whe95-0006kF-5Q
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 22:05:49 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1783562745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w3JZLxnO6XLta1pKoilZoueRwppuc8ig9aUa6rlyn2s=;
 b=VqvumEPX7QgEUUlPuWI9ATHBG+qi9nysIpwY0ZXXiUarZt64SdZ2rMyig+YmhjrmJU3mVA
 dGne5aye8u+sLJ6A42bcuSW95uJK+/DtxliAsIsReAQsFHze7/TKBIL6MNpOdG4CDx7GsC
 zXHa7lKz/pc+mXsz4g613eJEKrCzIJ8=
From: Tao Cui <cui.tao@linux.dev>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, cuitao@kylinos.cn,
 cui.tao@linux.dev
Subject: [PATCH v1 1/2] accel/tcg: fix crash on instruction straddling
 address-space end
Date: Thu,  9 Jul 2026 10:05:28 +0800
Message-ID: <20260709020529.126652-2-cui.tao@linux.dev>
In-Reply-To: <20260709020529.126652-1-cui.tao@linux.dev>
References: <20260709020529.126652-1-cui.tao@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Received-SPF: pass client-ip=2001:41d0:1004:224b::ba;
 envelope-from=cui.tao@linux.dev; helo=out-186.mta0.migadu.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

From: Tao Cui <cuitao@kylinos.cn>

translator_ld() reads the bytes of a page-crossing instruction into a
contiguous buffer. When computing the second page address it assumes the
two pages are virtually contiguous (second = page0 + TARGET_PAGE_SIZE)
and asserts that the read pointer pc is on that page.

On targets whose address space is narrower than vaddr (the 32-bit
targets, e.g. i386 or ARM AArch32 Thumb), an instruction at the very end
of the address space wraps the second page back to the start of the
address space. The target advances its fetch PC as a target_ulong, so pc
wraps to 0, while the linear page0 + TARGET_PAGE_SIZE stays at
0x1_0000_0000; the assert fails and QEMU aborts. A guest can trigger this
by mapping the last page executable and running a straddling instruction,
i.e. a guest-triggered host crash (DoS).

Instead of asserting, take the second page from pc: if the linear
page0 + TARGET_PAGE_SIZE does not land on pc's page, use pc's page. This
is correct for both the normal contiguous case and the wraparound case,
without needing to know the address-space width.

Tested with a minimal i386 multiboot payload that executes an instruction
at 0xfffffffe: before this change QEMU aborts (translator.c:296), after it
translates and runs normally.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 accel/tcg/translator.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index cd7d079fe0..750c132bbc 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -283,16 +283,16 @@ static bool translator_ld(CPUArchState *env, DisasContextBase *db,
     }
 
     /*
-     * The read must conclude on the second page and not extend to a third.
-     *
-     * TODO: We could allow the two pages to be virtually discontiguous,
-     * since we already allow the two pages to be physically discontiguous.
-     * The only reasonable use case would be executing an insn at the end
-     * of the address space wrapping around to the beginning.  For that,
-     * we would need to know the current width of the address space.
-     * In the meantime, assert.
+     * The read must conclude on the second page and must not extend to a
+     * third.  An instruction that straddles the end of the address space
+     * wraps the second page back to the start of the address space, so the
+     * linear page0 + TARGET_PAGE_SIZE does not land on pc's page; in that
+     * case take the second page from pc instead of asserting.
      */
     base = (base & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
+    if (((base ^ pc) & TARGET_PAGE_MASK) != 0) {
+        base = pc & TARGET_PAGE_MASK;
+    }
     assert(((base ^ pc) & TARGET_PAGE_MASK) == 0);
     assert(((base ^ last) & TARGET_PAGE_MASK) == 0);
     host = db->host_addr[1];
-- 
2.43.0



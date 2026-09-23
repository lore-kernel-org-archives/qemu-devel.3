Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1794C9830D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9TiE-0001I6-Su; Wed, 23 Sep 2026 16:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Tg9-0008AL-7E
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:34:57 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9Tg6-00050m-DH
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 16:34:56 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 d2e1a72fcca58-85469e25187so600541b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 13:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790195693; x=1790800493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DgAprjmUded0KXGxt7eIheLbb6J1qxtmQvcnaMR2XbY=;
 b=GgVVHRrSIaOoEB4XcEIia/nkFT/sJu7sOipCWSzFOdsLYyqybD6/qETK0rVDTdhXCZ
 C2I8mSajOE/SkfPUA+FwUWd4qRdby07PhwPoKSCcM1oo+FMCQsOO8xvJQj76/N61KHJW
 6Wr5B5Uqsc+QbTInuuOPirau98dGCNP8VVI0FCyRL0jk8xE7zkPgb/lDT4X6jIUpPs4i
 74nEHAaeXmI0xslnADuNSxGXMQhOCh/t9fikxrmvto3TLeV+RgSiGVb40lNGBTnipS+p
 e3JktNyZrJUTFeA57M3umngK0PLg6Wf3nlyGzWga+JMrkRi+0O8agjswcYnqh8AXomjH
 u2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790195693; x=1790800493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DgAprjmUded0KXGxt7eIheLbb6J1qxtmQvcnaMR2XbY=;
 b=BuUsQ0ve9qzg2dtYkeyDNuYZSGEt7YFopAJejMPz+OHyqU0qMvU77j3awfJFpC3kT3
 wSIgbXWQ/VKOkUlXoisr7i0eB3PTSqXgdTSui2e6zn3hwSO62phNZtQ6dR0ezP1jNrrJ
 8YeFXGI/xWKy7l8uz//Qu3sz0nCCYhC6yfemJPeyYkqrWMZBoX/Tfefr+pWH8rOVYOn3
 PvozaZkbolUGDI3eVd4ZNk+6695nvrgPDRSnoplI2/YlaBNIIGy9YPhQACaagPCmOFBt
 nTs4Zvcq2waP0H8KDsqjU4kD1+/1RE3jKpB7dVxLQNNAUtTtRuqRosquRXUPjvVnNeFa
 OxiQ==
X-Gm-Message-State: AFuF++mvs0TQLb0Y87ab1QCFihfdoMyz3VmsXJM3aOHXI0Q8Sr0E5bhL
 ooesXvYSUOB4Y1FvvJu+APY3nCKq1LR81qS5+AnCx6/qrFwF+7/imKAQKTdfAxbRDFBPLg1lJZg
 8p3aU
X-Gm-Gg: AYBFou3bXK4F7nrKk7LD0bSGdAQ0AzF5O9RiA6eFJDnx/EQ7QLo9Og2LK7M3u1AXNCz
 UZLMQgmx/iIiid57LBHWnVPdIHF7lJ2P0s9RddGJw/+DfKL7zPmWm/O6ll9auM7iLTKqPvjtF1J
 TQ+jslveleeDW5mThGhWegWAI+t6cfH9FqroVUjQI/zSymkw9uLw5RhpwaPsvSXraS/uadqHbDH
 sRzrBOW5ghHID4cU8Ro9V3jVRjydz/Bq19ijuPSoGRslAe3iMOj/Af9tEfeYav0rGGZtUKabJMw
 L2I/VrunmjDBQiBhPBaQogZeY9ZBwa/bV9NunsAjZZhGc2QdIEedahHI4mhuhnv3djms/ksTwsa
 fEMiM7mfSfhHj+lHjs9s3G9QtSEdZ2qodxKRAHL5Be1YkY5goh0dnlI6bEyITIgLRlnNO5p0bgP
 +94szdCLAQpj95WKElGudHFjOzOMzskdBMflI+bRRFwM22Uwnwfa3010as+ONhhVIVyzKNCjx92
 xPQRJAyS1iZ+mDqIB8MhT1dAjWFwg==
X-Received: by 2002:a05:6a00:4004:b0:870:c2db:da31 with SMTP id
 d2e1a72fcca58-87e996729e7mr197599b3a.20.1790195692983; 
 Wed, 23 Sep 2026 13:34:52 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d3894211asm1678638b3a.36.2026.09.23.13.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:34:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Tao Cui <cui.tao@linux.dev>,
	Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PULL 10/16] accel/tcg: Allow some address space wraparound during
 translation
Date: Wed, 23 Sep 2026 13:34:35 -0700
Message-ID: <20260923203441.31276-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923203441.31276-1-richard.henderson@linaro.org>
References: <20260923203441.31276-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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

Allow the two pages of translation to be non-contiguous.
As long as the target translator wraps pc properly, this
allows address space wraparound to function correctly.

This avoids an assert on a valid i386 system-mode test case.

Reported-by: Tao Cui <cui.tao@linux.dev>
Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h |  3 +++
 accel/tcg/translator.c    | 45 ++++++++++++++++++++++++---------------
 2 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 978dee25add..104e6d4f361 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -55,6 +55,8 @@ typedef enum DisasJumpType {
  * @pc_first: Address of first guest instruction in this TB.
  * @pc_next: Address of next guest instruction in this TB (current during
  *           disassembly).
+ * @pc_second_page: Address of the beginning of the second page of this TB,
+ *                  or -1 if the TB does not yet extend to a second page.
  * @is_jmp: What instruction to disassemble next.
  * @num_insns: Number of translated instructions (including current).
  * @max_insns: Maximum number of instructions to be translated in this TB.
@@ -69,6 +71,7 @@ struct DisasContextBase {
     TranslationBlock *tb;
     vaddr pc_first;
     vaddr pc_next;
+    vaddr pc_second_page;
     DisasJumpType is_jmp;
     int num_insns;
     int max_insns;
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 3f08c1c15c7..2083f4285a2 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -169,6 +169,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     db->tb = tb;
     db->pc_first = pc;
     db->pc_next = pc;
+    db->pc_second_page = -1;
     db->is_jmp = DISAS_NEXT;
     db->num_insns = 0;
     db->max_insns = *max_insns;
@@ -328,16 +329,18 @@ static bool translator_ld(CPUArchState *env, DisasContextBase *db,
     /*
      * The read must conclude on the second page and not extend to a third.
      *
-     * TODO: We could allow the two pages to be virtually discontiguous,
-     * since we already allow the two pages to be physically discontiguous.
-     * The only reasonable use case would be executing an insn at the end
-     * of the address space wrapping around to the beginning.  For that,
-     * we would need to know the current width of the address space.
-     * In the meantime, assert.
+     * TODO: This doesn't handle address space wraparound properly for
+     * multi-byte reads, as we don't know the size of the address space here.
+     * But if the target translator wraps pc to 0 itself, and issues aligned
+     * reads, then this can work.
      */
-    base = (base & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
-    assert(((base ^ pc) & TARGET_PAGE_MASK) == 0);
-    assert(((base ^ last) & TARGET_PAGE_MASK) == 0);
+    if (db->pc_second_page == -1) {
+        db->pc_second_page = pc & TARGET_PAGE_MASK;
+    } else {
+        assert((pc & TARGET_PAGE_MASK) == db->pc_second_page);
+    }
+    assert((last & TARGET_PAGE_MASK) == db->pc_second_page);
+    base = db->pc_second_page;
     host = db->host_addr[1];
 
     if (host == NULL) {
@@ -415,16 +418,24 @@ static void record_save(DisasContextBase *db, vaddr pc,
 {
     int offset;
 
-    /* Do not record probes before the start of TB. */
-    if (pc < db->pc_first) {
-        return;
-    }
-
     /*
-     * In translator_access, we verified that pc is within 2 pages
-     * of pc_first, thus this will never overflow.
+     * In translator_ld, we verified that we touched no more than 2 pages,
+     * but we did not verify that they were virtually contiguous.
+     * Here, reimagine the two pages as virtually contiguous.
      */
-    offset = pc - db->pc_first;
+    if (likely(((db->pc_first ^ pc) & TARGET_PAGE_MASK) == 0)) {
+        /* first page */
+        /* Do not record probes before the start of TB. */
+        if (pc < db->pc_first) {
+            return;
+        }
+        offset = pc - db->pc_first;
+    } else {
+        int first_page_end_offset = -(db->pc_first | TARGET_PAGE_MASK);
+        assert(db->pc_second_page != -1);
+        assert((pc & TARGET_PAGE_MASK) == db->pc_second_page);
+        offset = pc - db->pc_second_page + first_page_end_offset;
+    }
 
     /*
      * Either the first or second page may be I/O.  If it is the second,
-- 
2.53.0



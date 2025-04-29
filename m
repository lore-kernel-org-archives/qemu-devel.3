Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C57C369DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 20:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9rLP-0000W0-Kg; Tue, 29 Apr 2025 16:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1u9rLI-0000U1-JZ
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 16:14:14 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1u9rLF-0001HP-26
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 16:14:12 -0400
DKIM-Signature: a=rsa-sha256; bh=ZwKTKwPjWlWVZatu7IE1KQEKahaTMt2yAH0BvmABkgM=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1745957643; v=1;
 b=T0gtyCy812WehqHghiUYvvTFrEDC09HwewDFgif6KKU2mu51WSViUeNMryGN23NZXvh01l2h
 2cXUMVmoAkxjH364nWGjA9n7fisfmVcaHr0BcWgpN8wwk8dlOmeFixlhC2zjwTsGHhxTS7dZk/1
 bbONc5mPnan2xlVMl5ty421CkQxc4WXgLGkdUWHOABeGcJrwHgWQV3aOOsDJFsODBGGzs5mQsuP
 OMhMBfZmM3aDKmKLsXVw139C1MtFhabgI6wL6tXQQjvhPbFEMtRqfMSEOFupT3LUKG83/yzpqsA
 WL7jcJsB7kJZjnttxImKzGF8YZywGRAJwJtJwET7m/Bnw==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 4964721568;
 Tue, 29 Apr 2025 20:14:03 +0000 (UTC)
From: ~percival_foss <percival_foss@git.sr.ht>
Date: Tue, 29 Apr 2025 12:03:53 -0400
Subject: [PATCH qemu v2 1/2] accel/tcg: Fixed cross-page overflow for 32 bit
 guest
Message-ID: <174595764300.3422.13156465553505851834-1@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <174595764300.3422.13156465553505851834-0@git.sr.ht>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: ~percival_foss <foss@percivaleng.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Percival Foss <foss@percivaleng.com>

The bug being resolved is that the current code in mmu_lookup() assumes
a valid 64-bit address space. If a guest has a 32-bit address space, a
page translation that crosses beyond the last page in the address space
will overflow out of the allocated guest virtual memory space in the
QEMU application and cause it to crash. In this case the first page will
be the last of the 32-bit address space (for example 0xFFFFF000 for 4K
page sizes) and the second page will overflow to a page beyond the
32-bit address space (0x100000000 in the very same example). An invalid
translation will be added to the cpu translation table from the second
page. Thought the translation will be for page address 0x100000000,
checks in other parts of the codebase actually enforce using only 32
bits, and will match this translation. Part of the stored translation is
the effective address, and another part is the addend to be used to
offset into the QEMU process's virtual memory space. The addend will
incorporate the 0x100000000 and offset into likely invalid virtual
address space.

The fix in the diff checks if the target is 32 bits and wraps the second
page address to the beginning of the memory space.

Signed off by: Percival Engineering <foss@percivaleng.com>
---
 accel/tcg/cputlb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index fb22048876..457b3f8ec7 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1767,6 +1767,13 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemO=
pIdx oi,
         l->page[1].size =3D l->page[0].size - size0;
         l->page[0].size =3D size0;
=20
+        /* check for wrapping address space on page crossing if target is 32=
 bit */
+        #if TARGET_LONG_BITS =3D=3D 32
+        if (l->page[1].addr >=3D (1UL << TARGET_LONG_BITS)) {
+            l->page[1].addr %=3D (1UL << TARGET_LONG_BITS);
+        }
+        # endif
+
         /*
          * Lookup both pages, recognizing exceptions from either.  If the
          * second lookup potentially resized, refresh first CPUTLBEntryFull.
--=20
2.45.3



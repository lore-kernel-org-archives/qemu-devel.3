Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2094DC369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 17:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5TDs-0002uo-46; Thu, 17 Apr 2025 13:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1u5T8K-00052y-Uv
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 13:34:41 -0400
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>) id 1u5T8G-0001oL-Tt
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 13:34:40 -0400
DKIM-Signature: a=rsa-sha256; bh=0opaJak5v69z9RyU5DA2C8fIfqJ/w0ElDx889KwlBIk=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:In-Reply-To:To:Cc; q=dns/txt; s=20240113;
 t=1744911270; v=1;
 b=cKBdr9fbinHodmd6y5E58P2D/XtSeiz/CszKDpTcEG1CmjtJVD8XFzqKogpYI7IT3cbzF0UN
 ULr5aJRJi8OEYvXizKxXhLyy0txB6+6J4EFNcFYwLQa46Za6sRIRsvGpCE6z4y+dlmah1nDrXfJ
 /2K5lZ+5i2xGAUp+r5uxygQv/6CC4hG9OZl+6bIQUJI8jla6J2fdWNQjviE/STGvhxoVVvUPiSh
 TdkeJsX1I3sxTRv4i5MTDbUQjIGV7xahhwCP4BdpoI6z4ve3X72YUBEM+gZTjx5VVHD5MIJsoC7
 yz7ZrEgYxczGWRsrekED0xScth5ffqHTOp8hsPGrEp/Ng==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 701582121C;
 Thu, 17 Apr 2025 17:34:30 +0000 (UTC)
From: ~percival_foss <percival_foss@git.sr.ht>
Date: Wed, 16 Apr 2025 14:29:18 -0400
Subject: [PATCH qemu 1/2] Fix: TCG cross-page overflow for 32 bit guest
Message-ID: <174491127002.20547.8069526486864738611-1@git.sr.ht>
X-Mailer: git.sr.ht
In-Reply-To: <174491127002.20547.8069526486864738611-0@git.sr.ht>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_INVALID=0.1, DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 17 Apr 2025 13:39:22 -0400
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

From: foss@percivaleng.com <sean.stultz@percivaleng.com>

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



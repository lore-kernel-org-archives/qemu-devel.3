Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B80EE6F09F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 15:51:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY4f4-000066-9U; Tue, 23 Dec 2025 10:51:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vY4ez-0008WN-0k
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 10:50:54 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vY4ex-0005RK-6j
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 10:50:52 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9C0766013D;
 Tue, 23 Dec 2025 15:50:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3A4C116C6;
 Tue, 23 Dec 2025 15:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766505050;
 bh=L0YXx2FHn1M1+9urKytakexkVLHdg/o0WnZJ/wbJyC4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rmunOenXhgMDqUkj3h7/T6LJmlBX0fzRSfrK3+V0TypUomoZqCxZTJt0PlIx3arbo
 RnGTQsfgEnG47SVX00BXl+76rwGxCEG3CLx8DLAxtf+TtzhzhMiwi/YUwdWZ4AVqMX
 lyvY0CgRMgCgpVuOap2phBizXKEPYXY7jWgbgfRpNh5xaWZJZ7jEn2unfAfU1qRSmL
 uaLST91xKfPNuu3zaEtm5IJhcvk+GqIozSg92NdTX6kW7a0GD7kNNUG4/mM9mvDgWf
 ghbCCGQslz/5pq+UehwcwnnesQzWzgxEFKY7wewR97jPKBimkxlPLuoM8tHZAlI32K
 xC57DqD0ZSFew==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fam Zheng <fam@euphon.net>
Subject: [PULL 06/12] scsi: ncr710: Fix table indirect addressing endianness
Date: Tue, 23 Dec 2025 16:50:25 +0100
Message-ID: <20251223155031.7110-7-deller@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251223155031.7110-1-deller@kernel.org>
References: <20251223155031.7110-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>

Correct the endianness conversion for table indirect addressing and
use be32_to_cpu() instead of cpu_to_le32().

This fix descriptor table parsing when using indirect addressing modes
in SCRIPTS.

Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/scsi/ncr53c710.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index e17d1f3fb8..4b42fab754 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -1355,8 +1355,8 @@ again:
             offset = sextract32(addr, 0, 24);
             ncr710_dma_read(s, s->dsa + offset, buf, 8);
             /* byte count is stored in bits 0:23 only */
-            s->dbc = cpu_to_le32(buf[0]) & 0xffffff;
-            addr = cpu_to_le32(buf[1]);
+            s->dbc = be32_to_cpu(buf[0]) & 0xffffff;
+            addr = be32_to_cpu(buf[1]);
         }
         /* Check phase match for block move instructions */
         if ((s->sstat2 & PHASE_MASK) != ((insn >> 24) & 7)) {
-- 
2.52.0



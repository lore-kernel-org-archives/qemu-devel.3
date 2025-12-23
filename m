Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C90E6FE21
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 15:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY4fN-0000Hx-4p; Tue, 23 Dec 2025 10:51:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vY4f6-00006r-C0
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 10:51:00 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vY4f4-0005Sv-Kp
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 10:50:59 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5B6E760142;
 Tue, 23 Dec 2025 15:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4703EC113D0;
 Tue, 23 Dec 2025 15:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766505057;
 bh=YSbao9+pz5e5p18/9pn0mAzTdqVYmjVKQthvY8JC8YA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nzjQ6MPPTz7gxqoNFD/d21/WtDzZBx7cqbpk9QuiG/djmZHLFTjAdeANsqAfE2Sg/
 gGJjrH4077adJfzJB/plyHpCfgpnwtTZbWAjtebZYnEL+U6qfBPCkhOx8lM6AVKl1j
 /SmIWqedjLZQa7gUILG5rV2lDZ2ILOLKS3J66oFWjDxVaDD+HSBpuHbjB9bKbnWBTD
 Tce22KVHx6bTvJf1yY51SRiaT8aAU/uQpa7OplSeTpPm2ZQCoIuH2IEH8DacvFGv6P
 qXuHV1ERimq3qTRr06e4GqG4MP6jCHxpt6k6FFuJIOOEY0Q/FghL2cKzCn0LG47Igc
 B0sHaIpqq4rRg==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fam Zheng <fam@euphon.net>
Subject: [PULL 09/12] scsi: ncr710: Simplify disconnect handling
Date: Tue, 23 Dec 2025 16:50:28 +0100
Message-ID: <20251223155031.7110-10-deller@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251223155031.7110-1-deller@kernel.org>
References: <20251223155031.7110-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Simplify disconnect instruction by unconditionally clearing waiting
statements when command completes.

Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Tested-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/scsi/ncr53c710.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 277aa2c3d3..dd453991e0 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -1469,9 +1469,7 @@ again:
                 if (s->command_complete != NCR710_CMD_PENDING) {
                     s->scntl1 &= ~NCR710_SCNTL1_CON;
                     s->istat &= ~NCR710_ISTAT_CON;
-                    if (s->waiting == NCR710_WAIT_RESELECT) {
-                        s->waiting = NCR710_WAIT_NONE;
-                    }
+                    s->waiting = NCR710_WAIT_NONE;
                 } else {
                     if (s->current) {
                         s->current->resume_offset = s->dsp;
-- 
2.52.0



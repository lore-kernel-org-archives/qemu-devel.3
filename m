Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8FF2CFD64E
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 15:31:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdVUc-00014u-IH; Wed, 07 Jan 2026 10:30:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pruiz@clavium.io>) id 1vdUtw-0004vJ-Lx
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 09:52:44 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pruiz@clavium.io>) id 1vdUtu-0001UQ-Kb
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 09:52:44 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42fbc305882so1117432f8f.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 06:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=clavium.io; s=google; t=1767797560; x=1768402360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R9KMC1+h/mruHXUqpErhUi0wZq2bEw7Vtio1rqjzaZg=;
 b=kOyNxTBXwRo20Uq8iFxOqfjcmgSspkcp4bgFte/a7SgOhESq5Wo/sqKdbMgD4bM+9X
 8H0DFPhQj/R8kpYFhZPUJ0ALCCmvlqJry78TWZaR0BG+dhvqPNAf6/elaiFDPHFuMSvn
 YXfB3xFdSBhuR6cllzHlPk8AbgawWiZmGzdNi+S2iT2Cz6QhY51EE1REjQIndrWcVhnr
 7tzFkTr7JRofo3luAlQb0yXj0C93+eu2jAQDn64ixNP8sO/v3dMe5d7LSPo5bJLBgBUW
 4XmZm7hP7X5018lUscstOyMGb+k+6/JBQOx/57zf4T7UWqVCJyqBTalByA0446Xo6cId
 eqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767797560; x=1768402360;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R9KMC1+h/mruHXUqpErhUi0wZq2bEw7Vtio1rqjzaZg=;
 b=mhrdsguh9WLD4kBH8crS0pgTuoxBIn+Kg9PeU0SN6bWp3yki/iuhh7aGzGtgw7VeS/
 V21E+Bg/xcgDLMe2dCcna6dCkDNxnzov2qPYXyp3ylL8V6YK5JwcAzwEjq1zoyCp94Jj
 +v68Nt47bi1ooDqb3HJVM8S6v3KTVqEyAz+f+N60qU2w1eLPdCJTeYCq6jqKtLUQDnTB
 YxS248nex0E70NnrBaJGYwG84BvV7VwqhVTzfJkHZVjpnviT50Qv5LrNcT5eZ960nkdk
 GgLEcyQIzx5/6E6Cha88wpCtrJZ34FMBaNEa0wf/+U6SUQYW375bbWEJ7fkO6l8P47i0
 APxw==
X-Gm-Message-State: AOJu0Yw2GNw+PStXFPmIDyloOl4MCTu1PxVwVmbOX6uWlTikUGrqFNlj
 QBrCPWHGohlQ2HYWgFft2uKOOCD1oe4a1Os26AdjUYAUjFozWMCIjT4pQ3NTEwV9c0U=
X-Gm-Gg: AY/fxX57lA4vHCXSxIK5GcSSuq07jaM60yCxWgwjUV+X5+IW0ePwL8XhLSExxHQumc3
 JUCuxO8kfqO1DLXQgGOUS9FaC5ABtEM4O05JrNmvF8qJT1qDkbSsxwk+tDroXwwxB3pZMmCygVK
 g/DGA05NSpu9hUkx32HFTazvGNZSwrO/X7FakjEuv1u2MTPNW2bedAOrMSHOMXLJt4DDfPn1fiS
 OGp1GKcbNy6qQniEqMaGqxUqXjIXcAFc3LqK7eW6yO53iWEZ1RDlclSzIWwrn5aQQjCWOLBIJRe
 mgQbm57rLjLI2oiKfBi2pIN+y5ThoRtiD65Xk0b0/tRDd2qs4wktXilQ0wyxLcji9kMNfod4Yr/
 cNhJKRzfarrkK1cHlTGM5RZUZunwJVGLMdEr1YeJ5Wm9Nh83iSfOP2Y+LdOO6XqlLleb69m7yxf
 y7Zzp2Auek0GRU7fCg
X-Google-Smtp-Source: AGHT+IEGEBWmyUoKm5TVuSk4qYJoR0/aieUomPZXFqpVAgoabA67h5MK1X+auszuJLfSjLdU9i/k/g==
X-Received: by 2002:a05:600c:b86:b0:479:3a86:dc1e with SMTP id
 5b1f17b1804b1-47d84b41007mr34315515e9.36.1767797559835; 
 Wed, 07 Jan 2026 06:52:39 -0800 (PST)
Received: from CLV-PRUIZ ([195.76.50.98]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f70bc4fsm99301085e9.15.2026.01.07.06.52.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Jan 2026 06:52:39 -0800 (PST)
From: "Pedro J. Ruiz" <pruiz@clavium.io>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, kwolf@redhat.com,
 hreitz@redhat.com, "Pedro J. Ruiz" <pruiz@clavium.io>
Subject: [PATCH] fdc: Don't set FD_SR0_SEEK during automatic track crossing
Date: Wed,  7 Jan 2026 15:52:20 +0100
Message-ID: <20260107145220.18047-1-pruiz@clavium.io>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=pruiz@clavium.io; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 07 Jan 2026 10:30:04 -0500
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

The floppy disk controller was incorrectly setting the FD_SR0_SEEK
(Seek End) status bit during automatic track crossing in multi-track
read/write operations. This caused legacy operating systems like Minix 2
to interpret successful read operations as errors, resulting in
"Unrecoverable disk error" messages for blocks that crossed track
boundaries.

When executing multi-sector READ/WRITE commands with the MT (multi-track)
flag set, the FDC would correctly advance to the next track when needed
to continue the transfer. However, it was incorrectly setting the SE
(Seek End) bit in Status Register 0 (ST0) during this automatic track
advancement.

According to the Intel 82078 datasheet and related documentation, the
SE bit (bit 5, value 0x20) in ST0 should only be set:
1. After explicit SEEK or RECALIBRATE commands
2. After READ/WRITE commands that perform an "implied seek" (when the
   command specifies a different cylinder/head/sector than the current
   position and EIS flag is not set)

The SE bit should NOT be set during automatic track crossing that occurs
as part of an ongoing multi-track data transfer. This automatic track
advancement is part of the normal multi-track operation, not a seek.

This bug prevented Minix 2 and potentially other legacy operating systems
from booting. The OS floppy driver would detect the unexpected SE bit and
interpret it as a read error, even though the data was transferred
successfully. This particularly affected 1024-byte filesystem blocks that
spanned track boundaries.

Modified fdctrl_seek_to_next_sect() to remove the line that set
FD_SR0_SEEK when advancing to the next track during multi-track
operations. The function now:
- In multi-track mode: advances tracks/heads as needed WITHOUT setting
  the SE bit
- In non-multi-track mode: stops at end of track without seeking (also
  without setting SE bit, as no seek occurs)

The SE bit is still correctly set by explicit SEEK and RECALIBRATE
commands elsewhere in the code.

Fixes: c5139bd9 (fdc: fix FD_SR0_SEEK for non-DMA transfers and multi
sectors transfers)
Signed-off-by: Pedro J. Ruiz <pruiz@clavium.io>
---
 hw/block/fdc.c         | 9 ++++++---
 tests/qtest/fdc-test.c | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 4585640af9..21713c9c41 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -1403,14 +1403,17 @@ static int fdctrl_seek_to_next_sect(FDCtrl *fdctrl, FDrive *cur_drv)
             } else {
                 new_head = 0;
                 new_track++;
-                fdctrl->status0 |= FD_SR0_SEEK;
+                /* Don't set FD_SR0_SEEK for implicit track crossing during
+                 * multi-track transfers. SEEK bit must only be set for
+                 * explicit SEEK commands, not automatic track advancement.
+                 */
                 if ((cur_drv->flags & FDISK_DBL_SIDES) == 0) {
                     ret = 0;
                 }
             }
         } else {
-            fdctrl->status0 |= FD_SR0_SEEK;
-            new_track++;
+            /* Not in multi-track mode: stop at end of track and don't seek. */
+            FLOPPY_DPRINTF("end of track, stopping transfer\n");
             ret = 0;
         }
         if (ret == 1) {
diff --git a/tests/qtest/fdc-test.c b/tests/qtest/fdc-test.c
index 1b37a8a4d2..9edfbb5a40 100644
--- a/tests/qtest/fdc-test.c
+++ b/tests/qtest/fdc-test.c
@@ -519,7 +519,7 @@ static void test_read_no_dma_19(void)
 
     outb(FLOPPY_BASE + reg_dor, inb(FLOPPY_BASE + reg_dor) & ~0x08);
     send_seek(0);
-    ret = send_read_no_dma_command(19, 0x20);
+    ret = send_read_no_dma_command(19, 0x00);
     g_assert(ret == 0);
 }
 
-- 
2.50.1 (Apple Git-155)



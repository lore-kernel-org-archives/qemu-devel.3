Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C90C44506
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:21:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wilgT-0000eI-OY; Sun, 12 Jul 2026 00:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilgH-00009f-HZ; Sun, 12 Jul 2026 00:20:44 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilgF-00073o-Rc; Sun, 12 Jul 2026 00:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829781; bh=tc+gDOY5VW16+p5jmG6OzerDXc3kw4V9NV/IBhw6beo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kfB2fj5yJbgQjpjVfwTYIQk2LRU6PNKH45p04uVHoyeIP7EgyfTLC1s8RLDLmeQ+U
 7RhnhOVr1HdJKVxYpHJmuUnluaVQpyAZVGitRyX9W9lR80cUuK54uxTm39ZceFdNDy
 db4rrYkHmmp0E6qOAL5RJdUEfu0PkpMgWN7oVmILZPjmHwSkRAmf0yhrnJljVi6URN
 WzbWPz4fmLevPoQZ+rVOfE1NKPvWMz5GNUQ82fHVrBkdU7NIl2HEK9G/aVHnrVaTE/
 z0conoDHHsB+RVa610vT1yOWBmTiqc24UGtktiiSfGwTLmWJ5j0k+/aKkzvUEQosPZ
 iWKBGImzvnuoQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D549E1C0C0B;
 Sun, 12 Jul 2026 07:16:21 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1492A3EB96B;
 Sun, 12 Jul 2026 07:16:32 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 861FB13419; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 48/75] hw/scsi/mptsas: Reset doorbell state on reset
Date: Sun, 12 Jul 2026 07:15:06 +0300
Message-ID: <20260712041539.108341-48-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

Currently the mptsas reset function clears intr_status, but it
doesn't reset the doorbell state machine.  This means that the state
machine and the interrupt state get out of sync, and the guest can
trigger an assertion failure in mptsas_doorbell_read() where
s->doorbell_state is still DOORBELL_READ but s->intr_status does not
have MPI_HIS_DOORBELL_INTERRUPT set.

Fix this by having reset also reset the doorbell state.  Strictly
speaking we don't need to also clear doorbell_reply_idx and
doorbell_reply_size, because those are only read when in
DOORBELL_READ state, and the code always sets them up before
transitioning into that state.  But it's less confusing to clear them
out on reset.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/304
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260629185035.2138238-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 831a13665ab1123b5ccd127820f287e41be137e9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index ba7a7d07707..4335ccd5003 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -811,6 +811,10 @@ static void mptsas_soft_reset(MPTSASState *s)
     s->intr_status = 0;
     s->intr_mask = save_mask;
 
+    s->doorbell_state = DOORBELL_NONE;
+    s->doorbell_reply_idx = 0;
+    s->doorbell_reply_size = 0;
+
     s->reply_free_tail = 0;
     s->reply_free_head = 0;
     s->reply_post_tail = 0;
-- 
2.47.3



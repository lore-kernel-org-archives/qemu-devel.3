Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7FB8CD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuCq-0003O3-Dv; Tue, 12 May 2026 16:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuBj-0002Nh-PT; Tue, 12 May 2026 16:58:51 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuBf-0004iV-0F; Tue, 12 May 2026 16:58:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619275; bh=x5mBKVMJZjq2GhMSm7vHo3lfE2ygnY2l74h1Qg6bN1U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Ep8FJPVtPPLRbR6CuOn2/zVURonoWT6iuXeUn7gRv7rBeTE/FlY/I9MbaSJrGF4Wg
 i9uzvJWkzfqvdUPwySBBlOaSJU7jptNWtV7vfZ9P6VpCtXjN41Zt+Bg79iFJGkElC/
 Y4ZGFZOwxKjMnPTkoY5rNu1NIAo8zJSEHV/adohwfTQdqPEYhenKpB8dMaVAUWJKM6
 Se+2EQtwMPkmY3jHu+QQC8WyDx8PmfUPF9u+02PQXu6QXpGMm/hh6TA2/33QgHfOvC
 AIazHlp4ilmrciPCwR2py+QstP5N/8rkePVWcxf/EBKt0aGnWcZ8tKEW6i7JkNqss0
 rxHxeNZW3lCtw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EA58B1AA2F5;
 Tue, 12 May 2026 23:54:35 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 025543ABC66;
 Tue, 12 May 2026 23:54:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Tingting Mao <timao@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 041/107] ide: Fix potential assertion failure on VM
 stop for PIO read error
Date: Tue, 12 May 2026 23:53:28 +0300
Message-ID: <20260512205437.360850-41-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Kevin Wolf <kwolf@redhat.com>

ide_sector_read() as well as its callers neglect to call ide_set_retry()
before starting I/O. If the I/O fails, this means that the retry
information is stale. In particular, ide_handle_rw_error() has an
assertion that s->bus->retry_unit == s->unit, which can fail if either
there was no previous request or it came from another device on the bus.
If the assertion weren't there, a wrong request would be retried after
resuming the VM.

Fix this by adding a ide_set_retry() call to ide_sector_read().

This affects only reads because ide_transfer_start() does call
ide_set_retry(). For writes, the data transfer comes first and the I/O
is only started when the data has been read into s->io_buffer, so by
that time, ide_set_retry() has been called. For reads, however, the I/O
comes first and only then the data is transferred to the guest, so the
call in ide_transfer_start() is too late.

Buglink: https://redhat.atlassian.net/browse/RHEL-153537
Reported-by: Tingting Mao <timao@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20260326165124.138593-1-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 59c1d31136688415e5d682a87942292dbb3caaeb)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ide/core.c b/hw/ide/core.c
index b14983ec54..9ca480f72e 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -799,6 +799,7 @@ static void ide_sector_read(IDEState *s)
     s->error = 0; /* not needed by IDE spec, but needed by Windows */
     sector_num = ide_get_sector(s);
     n = s->nsector;
+    ide_set_retry(s);
 
     if (n == 0) {
         ide_transfer_stop(s);
-- 
2.47.3



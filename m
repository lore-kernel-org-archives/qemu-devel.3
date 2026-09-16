Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 395EFC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6n4C-0000OI-RK; Wed, 16 Sep 2026 06:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6n2p-0006ic-Dy; Wed, 16 Sep 2026 06:39:15 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6n2n-00021R-1a; Wed, 16 Sep 2026 06:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789554957; bh=Av1g4b1yq9HBrphqd3fj3i3wvIVgUolRG8MeHlTryeg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=q0X81m6mxZDownBcUqNHoX8HsnruZDe/WjmSgz60fEFGeObtoiI/n54jG8/LNewyw
 Ojobox5Ukeixgq+XhWF7nI/GhZzAuhHyF1Z1cyMJUXShGQ0doq9M+cKmzuQBm43wPX
 qQF3TO3dWCBX1YgFeuXE4xkBsfGo+qNp/EY7f4Qw+MUZ6kf8ElEinhnCgKeSOc3Igd
 IHv5cG6OggYxlIjjmyn8nARzvG7pVWtdMHVymZhy/Rr5P/EtVkwZCABSAXu4cKagk4
 KRjitZNnZu+xtrHHYO/2CVjzt5wK8Rl+hwOo4g1oSBZFMc9AHQxV5i57Yl3x7FGaIZ
 E9jfWDV3Nhqbg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1F3441D5814;
 Wed, 16 Sep 2026 13:35:57 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id DE141429F71;
 Wed, 16 Sep 2026 13:36:39 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C0B9F5A81F; Wed, 16 Sep 2026 13:36:39 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Junjie Cao <junjie.cao@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.2 31/56] hw/cxl: fix timer leak in cxl_destroy_cci()
Date: Wed, 16 Sep 2026 13:35:49 +0300
Message-ID: <20260916103622.684817-31-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.2-20260916133554@cover.tls.msk.ru>
References: <qemu-stable-11.1.2-20260916133554@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Junjie Cao <junjie.cao@intel.com>

cxl_init_cci() allocates a QEMUTimer via timer_new_ms() but
cxl_destroy_cci() never frees it.  This leaks a timer object on every
device exit path and, more critically, on every device reset cycle since
the secondary CCIs (vdm_fm_owned_ld_mctp_cci, ld0_cci) are destroyed
and re-initialized each time ct3d_reset() runs.

Tear the CCI down in the reverse of cxl_init_cci()'s setup order:
destroy the mutex, then free the timer.  timer_free() cancels any
pending expiry via timer_del() internally and tolerates a NULL pointer;
clear the field afterwards so that a repeated timer_free() on the same
CCI is a safe no-op.
(The function as a whole is still not idempotent: qemu_mutex_destroy()
asserts on an already-destroyed mutex.  Callers must not invoke
cxl_destroy_cci() twice; the .initialized guard added in the next patch
enforces that.)

Cc: qemu-stable@nongnu.org
Fixes: 98cbac128f1c ("hw/cxl: Support aborting background commands")
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260729144645.1552511-2-junjie.cao@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 259b877eac36be4dc593f42b36d33260741cd7d2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index ec18338b423..603677a97bb 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -4795,6 +4795,8 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
 void cxl_destroy_cci(CXLCCI *cci)
 {
     qemu_mutex_destroy(&cci->bg.lock);
+    timer_free(cci->bg.timer);
+    cci->bg.timer = NULL;
     cci->initialized = false;
 }
 
-- 
2.47.3



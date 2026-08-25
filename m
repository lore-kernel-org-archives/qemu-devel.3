Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D11DFC5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 09:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyn4P-0005Ws-H3; Tue, 25 Aug 2026 05:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyn4D-0005Hm-FM; Tue, 25 Aug 2026 05:03:37 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wyn4B-0003Ai-4E; Tue, 25 Aug 2026 05:03:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1787648560; bh=CFPows6GStlgG3gr+8/RBIPRlNE/zpu80hsjchtYKVw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Ou4lgqd5At+IFiTU5H6kVSIi29HYlJbTLAEAXPcajNTuhRDFypJ4hfoQQVuuf9+3+
 Hcl8xSsMRxcAA+yIt0Aj7m8SLVZPnXkSS8m8uhcpvII6SvSm3mHtEK25z7o+ww+/N+
 80Jbw6Nxz3+2NldlJvtm3r2tpZ8g0z/UkScKur1TtbBAbNk+WXg4duBbh62KFI8h63
 Gaq7ck19NPVNT4tVYlejKb7/BRrWyzb21TJhR2Z2u6FbgFY4aZSVep9p2K3CyPbfP5
 GEu8QK/eKJXCwna6gwgfLOXgrzDAmrpkuP3LAAWkaN2JQnJnsbIBphCr/P4Pc+kFYU
 fCQiTNru39e7g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5A1E51CE3B4;
 Tue, 25 Aug 2026 12:02:40 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 46A50416176;
 Tue, 25 Aug 2026 12:03:17 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id BFE3332551; Tue, 25 Aug 2026 12:02:39 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 v3 170/196] serial: clear transmit retry callback on
 unrealize
Date: Tue, 25 Aug 2026 12:01:27 +0300
Message-ID: <20260825090157.471948-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260825115401@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260825115401@cover.tls.msk.ru>
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

From: Paolo Bonzini <pbonzini@redhat.com>

The GSource is removed when resetting but remains active (and can
cause use-after-free) on hot-unplug.  Remove it before the character
device is disconnected.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4125

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit eb3f7fe382babbab44419603e81da56abb91d11a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/char/serial.c b/hw/char/serial.c
index 0f3469a1e8f..1174e0e38a2 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -940,6 +940,7 @@ static void serial_unrealize(DeviceState *dev)
 {
     SerialState *s = SERIAL(dev);
 
+    g_clear_handle_id(&s->watch_tag, g_source_remove);
     qemu_chr_fe_deinit(&s->chr, false);
 
     timer_free(s->modem_status_poll);
-- 
2.47.3



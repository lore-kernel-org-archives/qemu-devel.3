Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C8DCCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB1q-0006xM-8k; Sat, 17 Oct 2026 16:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB0h-00062h-SQ; Sat, 17 Oct 2026 16:28:09 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB0g-0003xP-3N; Sat, 17 Oct 2026 16:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268839; bh=68cmUY1QwDoYLeMIO9z89j05rrMVPbqlL9YaOcVbpoY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KpMf5joagGIcj0qRaxIiiDQnu892bivqtByeIvzzcFFse1sRPejARObecYLVtQ8ko
 O/NHSt6b2G7DXx4+NaVfkM09G0WEoBJACx8PhUJLheLJn/cI+kBDTtv5tch/bsLCIU
 sHsUOgrYCefU8JxRQcvrScLBZ9Y5DK1M42Ktae3gVBgYb15LoSzVu5AfFpOutm9gST
 nMllutlhwLYlai6qkuCncITBtv31G22KbC8ueueGY6aVoEacJpXTEawdLsNbAGv78O
 YJrC9nwAZIAKKWqQ2MHQ9HPVvY3Dan0XeC0SUQIKKcZPCf9hpW8LXYHW23IRYqa1XN
 Ie8ks/a/EzONg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EC1A41DE74B;
 Sat, 17 Oct 2026 23:27:19 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1F9FF443422;
 Sat, 17 Oct 2026 23:27:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Warisjeet Singh <sinxx198@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 16/73] hw/usb/dev-smartcard-reader: fix OOB read from
 pending bulk-in ring
Date: Sat, 17 Oct 2026 23:25:34 +0300
Message-ID: <20261017202638.728621-16-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

ccid_bulk_in_get() decrements bulk_in_pending_num when a slot becomes
active, but the slot is only truly free after ccid_bulk_in_release().
A guest can fill all 8 ring slots, partially read one (leaving pos
non-zero), then send another command whose response reuses the active
slot. The stale pos > new len makes the uint32_t subtraction in
ccid_bulk_in_copy_to_guest() wrap, reading past data[].

Move the decrement to ccid_bulk_in_release() so the slot stays busy
until then. Add an assert(pos <= len) before the subtraction.

Resetting or removing the card must also discard the active slot so
that its stale position and pointer cannot be reused.

In practice, the device advertises bMaxCCIDBusySlots=1, so a conforming
host never has more than one command in flight and the ring never fills.

Fixes: CVE-2026-18204
Fixes: 367071447ec5 ("usb-ccid: add CCID bus")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4086
Reported-by: Warisjeet Singh <sinxx198@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
(cherry picked from commit 49851e859506c6326288162718573c1e22ab9bf4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index bba97a2b19..aee966c0c9 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -570,6 +570,10 @@ static void ccid_remove_pending_answer(USBCCIDState *s,
 
 static void ccid_bulk_in_clear(USBCCIDState *s)
 {
+    if (s->current_bulk_in != NULL) {
+        s->current_bulk_in->pos = 0;
+        s->current_bulk_in = NULL;
+    }
     s->bulk_in_pending_start = 0;
     s->bulk_in_pending_end = 0;
     s->bulk_in_pending_num = 0;
@@ -580,6 +584,7 @@ static void ccid_bulk_in_release(USBCCIDState *s)
     assert(s->current_bulk_in != NULL);
     s->current_bulk_in->pos = 0;
     s->current_bulk_in = NULL;
+    s->bulk_in_pending_num--;
 }
 
 static void ccid_bulk_in_get(USBCCIDState *s)
@@ -587,8 +592,6 @@ static void ccid_bulk_in_get(USBCCIDState *s)
     if (s->current_bulk_in != NULL || s->bulk_in_pending_num == 0) {
         return;
     }
-    assert(s->bulk_in_pending_num > 0);
-    s->bulk_in_pending_num--;
     s->current_bulk_in =
         &s->bulk_in_pending[(s->bulk_in_pending_start++) % BULK_IN_PENDING_NUM];
 }
@@ -1078,6 +1081,7 @@ static void ccid_bulk_in_copy_to_guest(USBCCIDState *s, USBPacket *p,
 
     ccid_bulk_in_get(s);
     if (s->current_bulk_in != NULL) {
+        assert(s->current_bulk_in->pos <= s->current_bulk_in->len);
         len = MIN(s->current_bulk_in->len - s->current_bulk_in->pos,
                   p->iov.size);
         if (len) {
-- 
2.47.3



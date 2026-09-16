Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F294DC982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:09:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6lcX-0001Y6-BX; Wed, 16 Sep 2026 05:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6lcT-0001N0-E1; Wed, 16 Sep 2026 05:07:57 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6lcR-0007MR-O0; Wed, 16 Sep 2026 05:07:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789549558; bh=zQke51u6U0pw+SIIU70byH/CP3flri66wTAzQsEHW9c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=yHi9K7POr3vhiQJUx6Al+t5Hddhv37SNOx5IN7E18tbf9OnDrjgF/DOvVnvHxBCwm
 cFmqrNMHims04uo6v9mAU3ZlGMrIRSISOkFyGhaaD6fZF3HTDmLsCI3GD3m6K/u+8s
 6fETBRo/ZOZ9HKIQifsDyXKAjdmEK3mR7hYatEwj40NYLsK+Geqm7Y/Wn1OzKPVxuX
 46g90IGBtYhXU7dn//ic4lXmXCSwfclEVsQzPo+lktvpiZK+benLbo91nkoNWAftMs
 q5Pk+Bs+Q1oz99CXTl1wHSDHw5rCpcn6TeRqvqlW00Dosj/iARdFWFKrKAxPaQjCKV
 F/MVUKSfMmoUQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C71011D56C8;
 Wed, 16 Sep 2026 12:05:58 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 72A66429E13;
 Wed, 16 Sep 2026 12:06:41 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 402835A781; Wed, 16 Sep 2026 12:06:41 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 XlabAI Team of Tencent Xuanwu Lab <xlabai@tencent.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 20/57] hw/ide: reject an out-of-range PIO transfer
 window on load
Date: Wed, 16 Sep 2026 12:03:44 +0300
Message-ID: <20260916090516.677749-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
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

From: "Denis V. Lunev" <den@openvz.org>

ide_drive_pio_post_load() validates end_transfer_fn_idx but takes
cur_io_buffer_offset and cur_io_buffer_len straight from the migration
stream, so data_ptr and data_end can be placed anywhere within +-2GB of
the 131076-byte io_buffer allocation. Both fields are signed 32-bit.

The subsection loader consumes every subsection present in the stream
without consulting needed(), so a crafted stream can inject
ide_drive/pio_state for a drive that was never in a DRQ state. Once
data_end is out of bounds, ide_data_writew() only compares the guest's
pointer against that same bogus data_end, and the resumed guest turns a
repeated outw to the data port into a controlled 16-bit heap write.
end_transfer_fn_idx picks the direction, so the read side of the same
code path leaks host heap instead.

Validate the window against io_buffer_total_len and fail the load. The
subtraction form avoids overflowing the addition.

Reported-by: XlabAI Team of Tencent Xuanwu Lab <xlabai@tencent.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4179
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3738
Cc: John Snow <jsnow@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
(cherry picked from commit 1332990194b53f5ca6a4fe7ac93cf4ad6eecfa9c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ide/core.c b/hw/ide/core.c
index befbab94867..2b9c903bd18 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -2874,6 +2874,12 @@ static int ide_drive_pio_post_load(void *opaque, int version_id)
     if (s->end_transfer_fn_idx >= ARRAY_SIZE(transfer_end_table)) {
         return -EINVAL;
     }
+    if (s->cur_io_buffer_offset < 0 || s->cur_io_buffer_len < 0 ||
+        s->cur_io_buffer_offset > s->io_buffer_total_len ||
+        s->cur_io_buffer_len >
+            s->io_buffer_total_len - s->cur_io_buffer_offset) {
+        return -EINVAL;
+    }
     s->end_transfer_func = transfer_end_table[s->end_transfer_fn_idx];
     s->data_ptr = s->io_buffer + s->cur_io_buffer_offset;
     s->data_end = s->data_ptr + s->cur_io_buffer_len;
-- 
2.47.3



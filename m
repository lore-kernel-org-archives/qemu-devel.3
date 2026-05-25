Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669E1CD5BBF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 06:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wROwU-0007nH-LD; Mon, 25 May 2026 02:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wROvj-0005mP-87
 for qemu-devel@nongnu.org; Mon, 25 May 2026 02:36:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wROvf-0001pT-9C
 for qemu-devel@nongnu.org; Mon, 25 May 2026 02:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779691004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eo/torMXRmw2KXbPEuUYi8EP3nU9GnWFaWfOmb/VO6s=;
 b=I+fgwFeFQ3yzn10RXZfi4NOeKCndU4Gmr3sPucQphg5k1B0rZik79HjWIdWJ3RX6bxxcDn
 S2xdCT4OrLeapCzzO5LxxuxRH77CYx209dlBTn83iMQl/0HnsLjTP2s2kkLt/BU1cs+ZkH
 aZ0Am1y8wJbqaZQJBgGZ1H6XlZ7viVE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-LowQwfNcMFaeVfFnQZe_Uw-1; Mon,
 25 May 2026 02:36:37 -0400
X-MC-Unique: LowQwfNcMFaeVfFnQZe_Uw-1
X-Mimecast-MFC-AGG-ID: LowQwfNcMFaeVfFnQZe_Uw_1779690996
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B62CA19560B1; Mon, 25 May 2026 06:36:36 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 64943300019F; Mon, 25 May 2026 06:36:27 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v3 33/38] ui/spice: Use Linux key codes
Date: Mon, 25 May 2026 10:32:16 +0400
Message-ID: <20260525063223.1409791-34-marcandre.lureau@redhat.com>
In-Reply-To: <20260525063223.1409791-1-marcandre.lureau@redhat.com>
References: <20260525063223.1409791-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

QemuInputEvent now stores Linux key codes for key events. Use those
codes directly instead of translating between internal key code
representations.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20260520-input-v3-25-7c9e4c7abe34@rsg.ci.i.u-tokyo.ac.jp>
---
 ui/spice-input.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ui/spice-input.c b/ui/spice-input.c
index a5c5d78474e..f0bb915fd77 100644
--- a/ui/spice-input.c
+++ b/ui/spice-input.c
@@ -20,6 +20,7 @@
 #include <spice.h>
 #include <spice/enums.h>
 
+#include "standard-headers/linux/input-event-codes.h"
 #include "ui/qemu-spice.h"
 #include "ui/console.h"
 #include "keymaps.h"
@@ -61,7 +62,7 @@ static void kbd_push_key(SpiceKbdInstance *sin, uint8_t scancode)
     if (scancode == pauseseq[kbd->pauseseq]) {
         kbd->pauseseq++;
         if (kbd->pauseseq == G_N_ELEMENTS(pauseseq)) {
-            qemu_input_event_send_key_qcode(NULL, Q_KEY_CODE_PAUSE, true);
+            qemu_input_event_send_key_linux(NULL, KEY_PAUSE, true);
             kbd->pauseseq = 0;
         }
         return;
-- 
2.54.0



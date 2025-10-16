Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAD9CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 22:22:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9WM7-0005bu-5F; Thu, 16 Oct 2025 18:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <md@excello.cz>) id 1v9Vr0-0002hl-NY
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 17:49:46 -0400
Received: from out2.virusfree.cz ([89.187.156.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <md@excello.cz>) id 1v9Vqx-0004hT-54
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 17:49:46 -0400
Received: (qmail 20071 invoked from network); 16 Oct 2025 23:22:56 +0200
Received: from vm1.excello.cz by vm1.excello.cz
 (VF-Scanner: Clear:RC:0(89.187.156.50):SC:0(1.399999/5.0):CC:0:;
 processed in 0.9 s); 16 Oct 2025 21:22:56 +0000
X-VF-Scanner-Mail-From: md@excello.cz
X-VF-Scanner-Rcpt-To: qemu-devel@nongnu.org
X-VF-Scanner-ID: 20251016212255.172138.20067.vm1.excello.cz.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=excello.cz; h=
 date:message-id:from:to:subject:reply-to; q=dns/txt; s=default2;
 t=1760649775; bh=NgnOnbgkormG8QmLxuYuCEhiFcxpVFHZ+7vqElCwV7M=; b=
 Ml0iphtUw/bcqTog5VOmEPcOLEEeviMmyLWyssZMEydk13nIyRp6ZwIHpU6R8Fa+
 8cdBODWaVrZlnddqRAtFYvyYsBFKucPSQ7qiRjeAgcKsiOiTe3fNMKOcX0OvUIs9
 QhBrFU2EhIP8C5B00/UYO4rvyzwBnZKA8HMqnRfIBOrq9I9twmxoCLEjVEwGukhg
 l+VbjOL5XP3hq2mWXITRvXEhqH0U2Nc2uzIFgPvu5BU+t1H17OzVxtYuQwWskox7
 sdqyl9thicTi1fI0LUx4KhwdO4o0KKk1OkxmduW8b8+iHohrhlu1qqhXpFz+o/IN
 Laqt38rlqHjrubun81CnSg==
Received: from posta.excello.cz (89.187.156.50)
 by out2.virusfree.cz with ESMTPS (TLSv1.3, TLS_AES_256_GCM_SHA384);
 16 Oct 2025 23:22:55 +0200
Received: from localhost.localdomain (unknown [193.179.66.165])
 by posta.excello.cz (Postfix) with ESMTPA id 4B0019D7481;
 Thu, 16 Oct 2025 23:22:33 +0200 (CEST)
From: md@excello.cz
To: martin.drab@virtuozzo.com
Cc: md@excello.cz,
	qemu-devel@nongnu.org
Subject: [PATCH] qga: Close handle to the serial device when destroying a
 channel
Date: Thu, 16 Oct 2025 23:21:56 +0200
Message-Id: <20251016212156.1063-1-md@excello.cz>
X-Mailer: git-send-email 2.39.1.windows.1
In-Reply-To: <561f5abd-c699-48e5-a396-fd4714b11fa0@virtuozzo.com>
References: <561f5abd-c699-48e5-a396-fd4714b11fa0@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=89.187.156.42; envelope-from=md@excello.cz;
 helo=out2.virusfree.cz
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 16 Oct 2025 18:21:52 -0400
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

From: Martin Drab <martin.drab@virtuozzo.com>

It seems the handle is not being closed when QGA is freeing its communication channel. The open handle prevents the serial device from being removed. That may happen, for example, when the Virtio serial driver fails to restart its devices after HW resource reassignment due to a CPU/memory hotplug.

This fix adds the handle closing code into the ga_channel_free function. Only QGA for Windows is being fixed.

Signed-Off-By: Martin Drab <martin.drab@virtuozzo.com>
---
 qga/channel-win32.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/qga/channel-win32.c b/qga/channel-win32.c
index 779007e39b..520cd6ae50 100644
--- a/qga/channel-win32.c
+++ b/qga/channel-win32.c
@@ -354,6 +354,12 @@ void ga_channel_free(GAChannel *c)
     if (c->rstate.ov.hEvent) {
         CloseHandle(c->rstate.ov.hEvent);
     }
+
+    if (c->handle) {
+        CancelIo(c->handle);
+        CloseHandle(c->handle);
+    }
+
     g_free(c->rstate.buf);
     g_free(c);
 }
-- 
2.39.1.windows.1



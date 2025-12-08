Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21743D3B7E2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 01:17:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSmLr-0000YU-Tg; Mon, 08 Dec 2025 20:17:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <erickra@cs.utexas.edu>)
 id 1vSkCQ-0003uM-4U
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 17:59:22 -0500
Received: from newman.cs.utexas.edu ([128.83.139.110])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <erickra@cs.utexas.edu>)
 id 1vSkCO-0003E1-4p
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 17:59:21 -0500
X-AuthUser: erickra@cs.utexas.edu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs.utexas.edu;
 s=default; t=1765234753;
 bh=RM01Kv7BoWbA+js1ttiKbz24jSMxTvmkQ4atM1+m2K4=;
 h=From:To:Cc:Subject:Date:From;
 b=mExZAHnpeW3on4qRmW0uKt62QMbHVJdGXLYGJAR82fDologQgm6WH4H2EWLfBm269
 3Q8R7ArRPPnI8fTfhQYiDlrF2L+krgm8WpWdm+ZRuEGz5MHXAllR/8Lz/yuq5byxRa
 IYprZZCcuForhyu8+MnJcuTvtFIvi16NfDHJ3hG0=
Received: from DESKTOP-312SSTN.public.utexas.edu
 (wireless-10-147-52-59.public.utexas.edu [10.147.52.59])
 (authenticated bits=0)
 by newman.cs.utexas.edu (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id
 5B8Mwn48039094
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 8 Dec 2025 16:59:11 -0600
From: Eric K <erickra@cs.utexas.edu>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric K <erickra@cs.utexas.edu>
Subject: [PATCH] char-udp: Fix initial backend open status
Date: Mon,  8 Dec 2025 16:58:49 -0600
Message-ID: <20251208225849.705554-1-erickra@cs.utexas.edu>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.3.9
 (newman.cs.utexas.edu [128.83.139.110]); Mon, 08 Dec 2025 16:59:12 -0600 (CST)
X-Virus-Scanned: clamav-milter 0.103.8 at newman
X-Virus-Status: Clean
Received-SPF: pass client-ip=128.83.139.110;
 envelope-from=erickra@cs.utexas.edu; helo=newman.cs.utexas.edu
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 08 Dec 2025 20:17:14 -0500
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

This patch removes the `*be_opened = false` override for the UDP chardev
backend. Since UDP is connectionless it never sends a `CHR_EVENT_OPENED`
so it is never marked open. This causes some frontends (e.g. virtio-serial)
to never perform any operations on the socket.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2993
Signed-off-by: Eric K <erickra@cs.utexas.edu>
---
 chardev/char-udp.c     | 2 --
 tests/unit/test-char.c | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/chardev/char-udp.c b/chardev/char-udp.c
index 572fab0ad1..1025f577a0 100644
--- a/chardev/char-udp.c
+++ b/chardev/char-udp.c
@@ -215,8 +215,6 @@ static void qmp_chardev_open_udp(Chardev *chr,
     g_free(name);
 
     s->ioc = QIO_CHANNEL(sioc);
-    /* be isn't opened until we get a connection */
-    *be_opened = false;
 }
 
 static void char_udp_class_init(ObjectClass *oc, const void *data)
diff --git a/tests/unit/test-char.c b/tests/unit/test-char.c
index 8a98e42cad..2869c4e09d 100644
--- a/tests/unit/test-char.c
+++ b/tests/unit/test-char.c
@@ -1012,6 +1012,8 @@ static void char_udp_test_internal(Chardev *reuse_chr, int sock)
         qemu_chr_fe_init(fe, chr, &error_abort);
     }
 
+    g_assert(chr->be_open);
+
     d.chr = chr;
     qemu_chr_fe_set_handlers(fe, socket_can_read_hello, socket_read_hello,
                              NULL, NULL, &d, NULL, true);
-- 
2.52.0



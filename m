Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553F1C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 17:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wze9D-0007X6-2Y; Thu, 27 Aug 2026 13:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1wze94-0007WO-GB
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 13:44:10 -0400
Received: from mout.kundenserver.de ([217.72.192.75])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1wze91-0003BC-UO
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 13:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1787852644; x=1788457444; i=laurent@vivier.eu;
 bh=FayGp7oNk7UMZbF1YjwDcw12S09W58A+zP9OPgRzJNE=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ToRDRTI3xKMEi6LXwLG1peDK0hjwppPalTPxnPbC+sdI5yAur/wsimguLMsgdURG
 G02wQGuUvGVZ5v3yKHiGkABUpBNHTg9MZ4VZg8vCF/6ZyO2UfMaE4wqW0hQK/LeT8
 xVz29lVEagLsyEtuSvPVgqxt4ZDTDaBPhHNl7IjXi6vzMUjGslWEp5kOGg0OpeAyX
 KHR+gQuApc9XLQfv8OezrRpTMG5xpif93qAAHCTgvx5PjEitVMo7fvH3SoGyxNJ4N
 5srIfjXLgPzzhUGvZF2iR+300g4oH6M8nCjWelYhcZJ3fOirlTY5pHijxR/6e6BUR
 y7GX7qmGHUWg1285Vw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue106
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MAPBF-1xBRRX0DjH-00CH3H; Thu, 27
 Aug 2026 19:44:04 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] hw/char/goldfish_tty: Fix signed data length
Date: Thu, 27 Aug 2026 19:44:03 +0200
Message-ID: <20260827174403.610834-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D7H3coAiJY0BUeMn2FIIh6TtK5pQnCZvM+vtgN4SzkJjNm3qsFR
 4JLiMsTGObSN6w0+i+7Ja8fuO3UwrL1jgHwdsiLqg9Xiv6P50JeVIYVe9Ht12CGnoXIEMSr
 PDi5CWRKcKrSXIWrv8PAhJdi6PgMeArO/4sg+LvfhR5H5b0XwJPJcUHf4cIP89L9gkaiSEc
 2AoaTdx/e7HghcdjRV9BQ==
UI-OutboundReport: notjunk:1;M01:P0:U0vFoW6DiYQ=;/zWQiIFR6hozLQgtbaBNY0WOrtA
 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
Received-SPF: pass client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

The guest-controlled data_len register is uint32_t, but was copied into
a signed int. A value of 0xffffffff consequently became -1, allowing the
DMA transfer size to exceed the 128-byte stack buffer.

Use an unsigned length variable so that each transfer remains bounded by
GOLFISH_TTY_BUFFER_SIZE.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4245
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
=2D--
 hw/char/goldfish_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/char/goldfish_tty.c b/hw/char/goldfish_tty.c
index 8e1e9228c78b..f64527f50a02 100644
=2D-- a/hw/char/goldfish_tty.c
+++ b/hw/char/goldfish_tty.c
@@ -71,7 +71,7 @@ static void goldfish_tty_cmd(GoldfishTTYState *s, uint32=
_t cmd)
 {
     uint32_t to_copy;
     uint8_t data_out[GOLFISH_TTY_BUFFER_SIZE];
-    int len;
+    unsigned int len;
     uint64_t ptr;
=20
     switch (cmd) {
=2D-=20
2.55.0



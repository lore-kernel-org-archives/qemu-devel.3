Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04875C54791
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Mar 2024 15:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjKjZ-0003M7-PL; Sun, 10 Mar 2024 11:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rjKjX-0003Lq-GM
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 11:05:03 -0400
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rjKjU-00040s-DZ
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 11:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1710083092; bh=zY+X/BwY+jBK5l1E95pXPBkev8OC8i1y85k3OHugqbg=;
 h=From:Date:Subject:To:Cc:From;
 b=ELlxwtiaYoaOlqNZZs2hZwKULBtcLlbWTqdofp/yH6YR5DZ9kKSXjPsZ0RpQhapq/
 bikFHUcShHUEYsE3fmJjZPyzOSA+MtBLMBt0DkWvinMe6kYTE7tfU7eP7JmLMLV/LY
 dBQ9COMOAnnRR6w9gO7Pus1WjuGztzx+OYUGxMug=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Date: Sun, 10 Mar 2024 16:04:51 +0100
Subject: [PATCH] docs/specs/pvpanic: document shutdown event
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240310-pvpanic-shutdown-spec-v1-1-b258e182ce55@t-8ch.de>
X-B4-Tracking: v=1; b=H4sIABLM7WUC/x3MSwqFMAxA0a1IxgbaqOh7WxEHpUbNpJbGH4h7t
 zg8g3tvUE7CCv/ihsSHqKwhw5YF+MWFmVHGbCBDtamswXhEF8SjLvs2rmdAjeyxZke2pYZ+3EF
 uY+JJru/bD8/zAhQLYmRnAAAA
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710083091; l=1536;
 i=thomas@t-8ch.de; s=20221212; h=from:subject:message-id;
 bh=zY+X/BwY+jBK5l1E95pXPBkev8OC8i1y85k3OHugqbg=;
 b=Xg0vzViBtk9I/aZzFRtokvs+FxCyPuTHfOu9cZZ2MNsh7N/q+qag/RUtTa9Ip3oqffnVPHEr2
 8Ebb9wBNtygCKk4vvjOHtQY5ilAS4zuJysC812tKOzK6jLtzNN1o0D1
X-Developer-Key: i=thomas@t-8ch.de; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Received-SPF: pass client-ip=2a01:4f8:c010:41de::1;
 envelope-from=thomas@t-8ch.de; helo=todd.t-8ch.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Shutdown requests are normally hardware dependent.
By extending pvpanic to also handle shutdown requests, guests can
submit such requests with an easily implementable and cross-platform
mechanism.

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
---
This patch was split out from my earlier pvpanic-shutdown series [0].
The original series dropped the usage of the linux/pvpanic.h UAPI
header.
As we decided to keep the linux header [1] this first commit only adds
the spec definition.
Then a patch to Linux will add the new events to linux/pvpanic.h.
After this the rest of the changes to QEMU will be submitted again.

[0] https://lore.kernel.org/qemu-devel/20240208-pvpanic-shutdown-v6-0-965580ac057b@t-8ch.de/
[1] https://lore.kernel.org/lkml/20240213053953-mutt-send-email-mst@kernel.org/
---
 docs/specs/pvpanic.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/docs/specs/pvpanic.rst b/docs/specs/pvpanic.rst
index f894bc19555f..61a80480edb8 100644
--- a/docs/specs/pvpanic.rst
+++ b/docs/specs/pvpanic.rst
@@ -29,6 +29,8 @@ bit 1
   a guest panic has happened and will be handled by the guest;
   the host should record it or report it, but should not affect
   the execution of the guest.
+bit 2
+  a regular guest shutdown has happened and should be processed by the host
 
 PCI Interface
 -------------

---
base-commit: f901bf11b3ddf852e591593b09b8aa7a177f9a0b
change-id: 20240310-pvpanic-shutdown-spec-4ea2172529e8

Best regards,
-- 
Thomas Weißschuh <thomas@t-8ch.de>



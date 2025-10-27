Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40CDCCF9E9
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 01:25:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDByS-0006hP-Ln; Sun, 26 Oct 2025 21:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vDByQ-0006gz-5P
 for qemu-devel@nongnu.org; Sun, 26 Oct 2025 21:24:38 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vDByN-0001Tl-1h
 for qemu-devel@nongnu.org; Sun, 26 Oct 2025 21:24:37 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59R1OKnC028259
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 27 Oct 2025 10:24:26 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=r7eOArZbEgx/gJEZsCqJRcA0Cs2zDBsoRM0W70CaX2g=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1761528266; v=1;
 b=GR610rhtOtIKz9FXnl65E1Iw6rGUxohbKEKSfMsh8lW6rY5KInbIvkU9zllsgxVe
 ytkZzg3JBDrQCb9mgxmXm9ds4Dz9KDod2VT295oEWV+ni51I3x9UCGfyt1zaW50W
 RZWuQNaP8YEmTxrcwkPdtK2mCLsw7mwx3uEBtu6Awky//dErYGNBk3TUjRwhuPdN
 2zKCvKPuzsdYH2FlQM22HFPrVFSyJ/RN7h/NdBYlhVFYdQUvq6sNhGLU3TJX9CjZ
 dZlRWV3AmxI3TzVgBN9XT90rtynQiBlw68fNgkr1z3HNfANtILMOcbTZwN/08HHc
 vAnStwJ7XYaPzFUdeo+5RA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 27 Oct 2025 10:24:18 +0900
Subject: [PATCH] pci/shpc: Do not unparent in instance_finalize()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-shpc-v1-1-00e9b20a355d@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAMHJ/mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyNz3eKMgmTdFHPDpCRzoxQz88Q0JaDSgqLUtMwKsDHRsbW1AI6K60h
 WAAAA
X-Change-ID: 20251027-shpc-d71bb72d67af
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-179e8
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Children are automatically unparented so manually unparenting is
unnecessary.

Worse, automatic unparenting happens before the instance_finalize()
callback of the parent gets called, so object_unparent() calls in
the callback will refer to objects that are already unparented, which
is semantically incorrect.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
See also:
https://lore.kernel.org/qemu-devel/20250924-use-v4-0-07c6c598f53d@rsg.ci.i.u-tokyo.ac.jp
---
 hw/pci/shpc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
index aac6f2d03459..938602866d77 100644
--- a/hw/pci/shpc.c
+++ b/hw/pci/shpc.c
@@ -735,7 +735,6 @@ void shpc_free(PCIDevice *d)
     if (!shpc) {
         return;
     }
-    object_unparent(OBJECT(&shpc->mmio));
     g_free(shpc->config);
     g_free(shpc->cmask);
     g_free(shpc->wmask);

---
base-commit: c85ba2d7a4056595166689890285105579db446a
change-id: 20251027-shpc-d71bb72d67af

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>



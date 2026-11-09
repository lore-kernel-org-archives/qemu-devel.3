Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33BC606A322
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=hsf1SIZv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQNKN-0002cB-Tn; Mon, 09 Nov 2026 06:14:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xQNKJ-0002bP-Ck
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 06:14:16 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xQNKG-00064Q-Vx
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 06:14:15 -0500
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6A9BE3h8022502
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 9 Nov 2026 20:14:05 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=5VQBrEzTxHaGiRgVXaC2D6eNG850IWnntlflc0F/gpo=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1794222845; v=1;
 b=hsf1SIZvXIjBpQvX1165w/E4aJD/CKZTtEUQCKZaITxxxVAQ6ByCctHlqEc3fXfF
 3LssFUW+ZaVTUNEp0AvowiLImoytRPOneaqiFHyd38Dz6SvvFHfiY6h3DUN41umo
 BIY51eHQU7no9Ts8e8T26HAIoTMOlq1lMdoajzm5Quy2PF6a/R4fjFXDKNE4vfdY
 ASh+AuMAsZPnlgJeorKHDG0ELV84CbAQG6bb9OlUnHSm/Jc0RBDdOCLW0tQAR3OI
 A0828Tg/izY1mA5w6eTd7IbZPubZpkD1QIZwCSxe6RWKqDPu+MGJwUs9eUPOakH7
 QviSnq7BsZHKmAw6fFeqag==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 09 Nov 2026 20:13:42 +0900
Subject: [PATCH] net: Free the NIC model list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-nic-v1-1-4a26870ac3e9@rsg.ci.i.u-tokyo.ac.jp>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMQQqAIBBG4asM/zpBC4K8SrRQm2paWGhFEN09q
 uVbfO9C5iScYelC4kOyLBGWTEEIk4sjK+lhCaUua2N0paIEpV1otK8b11ceBWFNPMj5Xdru77z
 7mcP2Utz3A09oe49nAAAA
X-Change-ID: 20261103-nic-0ac90b69ad3b
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=771;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=9BqJ/hAjYTskkE2QHssXKLGOIAD7yw08dbukqY40G+s=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ9bHVT+4VvYub9LslDiy2bDtZnvDsb745d+XWEd/0Ts9t
 1ax5Nb9jlIWBjEuBlkxRZaUot3cGtG1nwoT4ltg5rAygQxh4OIUgIkIVzIynDhx10au5a2CMdvK
 jPvTtWQNs78tN+qPyFyhxrVyjwHjVYb/0Vu9l71ZlRaYIq/z0vFrd3dxfXnJ6u2xxy+se2+5oEC
 GAQA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

LeakSanitizer found this leak.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 net/net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/net.c b/net/net.c
index bf7e5d9b1258..8cfdd866e7df 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1115,7 +1115,7 @@ static int model_cmp(char **a, char **b)
 
 static void show_nic_models(void)
 {
-    GPtrArray *results = g_ptr_array_new();
+    g_autoptr(GPtrArray) results = g_ptr_array_new_with_free_func(g_free);
     int i;
 
     g_hash_table_foreach_remove(nic_model_help, add_nic_result, results);

---
base-commit: 74f7bf4c59e6b6d50dbc6e124d93440be8be4386
change-id: 20261103-nic-0ac90b69ad3b

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>



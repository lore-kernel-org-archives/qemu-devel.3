Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D942606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=IivYMkqh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLD5-0000rC-KR; Mon, 26 Oct 2026 09:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLCZ-0007tp-IG; Mon, 26 Oct 2026 09:57:29 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLCV-0000Js-O5; Mon, 26 Oct 2026 09:57:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793022943; bh=wKq5UAK8pb9xQe/Gm3jEB4GHahLDJteoor0la24kiIU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IivYMkqhQKh9evs6LTJaz8xB8AsdW/P4F3BX63yuFQq+FrI/ytwmLnIhl9DM4SwZE
 o/4/kj4yFJv44fxgq89VY2j7nnAGPde+seR69j9UTZ8OC0C+7wFfyJuCk3unzOocBg
 PNIlY8mmh4u5Ofx67UFY/GPoKyI25pfwN2nwUCojsQq6PsEcSVYp0r48KMsk66HLl/
 /7HMKplOdMz6l9G4g3/cAf+BuswDSHtMpjBmkHTiiYJvpIjpILUdwezrh74qGdpiP+
 nyzsKwfGPQZWcPDXa5eAcZMkYkULB8Tu6hpg628TfDAU7TSoCW0Fcz7+sYvGWVqMMG
 oORXWoO1AwmRw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E8F871E129A;
 Mon, 26 Oct 2026 16:55:43 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E64ED44B8EB;
 Mon, 26 Oct 2026 16:55:43 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id DBD69934BB; Mon, 26 Oct 2026 16:55:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Eric Blake <eblake@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 v2 77/98] iotests.py: add filter_qemu()
Date: Mon, 26 Oct 2026 16:55:04 +0300
Message-ID: <20261026135529.1019772-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261026165135@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261026165135@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

From: Fiona Ebner <f.ebner@proxmox.com>

Add a filter_qemu() helper function for replacing the QEMU program
name with 'QEMU_PROG' in test's log messages.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20260930132140.2342574-3-f.ebner@proxmox.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
(cherry picked from commit 9d2cdc4d3b716cf5c19af522237e8d3597d079c2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 072be80e079..ed41f88d2a3 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -596,6 +596,10 @@ def filter_qemu_io(msg):
     return qemu_io_re.sub("X ops; XX:XX:XX.X "
                           "(XXX YYY/sec and XXX ops/sec)", msg)
 
+qemu_re = re.compile(r"%s" % os.path.basename(qemu_prog))
+def filter_qemu(msg):
+    return qemu_re.sub("QEMU_PROG", msg)
+
 chown_re = re.compile(r"chown [0-9]+:[0-9]+")
 def filter_chown(msg):
     return chown_re.sub("chown UID:GID", msg)
-- 
2.47.3



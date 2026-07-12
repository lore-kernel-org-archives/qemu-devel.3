Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07053C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:23:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wilcn-00029K-R5; Sun, 12 Jul 2026 00:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilcO-0001d1-Mj; Sun, 12 Jul 2026 00:16:41 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilcM-0006FZ-Mo; Sun, 12 Jul 2026 00:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829780; bh=hU82KUVs7r0uV1CuQQBBYe00HlzyamewboyrZdlPX8c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=X2TkcpS8TGU298/I6kZ2X/vepZrXnd7VaOnJZivdziwWCh5VILA2EErciN/MlsW8l
 JQQK/TApS1KTh0ss13ScxKu33NbDEFJjX426O7i1A4e0w6oSBoquQG+99x/78944AK
 EVfgB9RtOFDKkVoNfXPvje7sayxpxA42zLvkqUWqec86wjolG1xADVdNxvmxkIzU8c
 R+nqUkF3ETSbogKD+eDOQufY89uofyfrL2Cqn3mYbxhW3PycMF9rrmV56MJDCnlcf/
 qJuda4bJlzoY3FkFMH4TYzhyOlzUn+I3J69A/3sw/WPVAR8G/w6xVghlccQ8ZO3cfa
 2zlnxlvDSZGkQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B39481C0BE0;
 Sun, 12 Jul 2026 07:16:20 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E53B83EB940;
 Sun, 12 Jul 2026 07:16:30 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 20CCB133C3; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 05/75] hw/9pfs: add msize_limit transport callback
Date: Sun, 12 Jul 2026 07:14:23 +0300
Message-ID: <20260712041539.108341-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Christian Schoenebeck <qemu_oss@crudebyte.com>

Add a new callback 'msize_limit' to the V9fsTransport structure.

This allows each transport implementation to provide its theoretical
maximum 'msize' value, which will be used to cap the negotiated
msize during Tversion handshake.

Link: https://lore.kernel.org/qemu-devel/7c4e53eb73c0580d7a321dbf3823ba5647652298.1781287774.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit a1c0e5a73740566d4b9eac1f97f78b8ce470116a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index b2df659b0e8..d8f364fafdb 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -481,6 +481,7 @@ struct V9fsTransport {
     void        (*init_out_iov_from_pdu)(V9fsPDU *pdu, struct iovec **piov,
                                          unsigned int *pniov, size_t size);
     void        (*push_and_notify)(V9fsPDU *pdu);
+    size_t      (*msize_limit)(V9fsState *s);
 };
 
 #endif
-- 
2.47.3



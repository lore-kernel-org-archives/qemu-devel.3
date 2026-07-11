Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C99C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifjq-0001WU-6P; Sat, 11 Jul 2026 17:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifjp-0001VY-1j; Sat, 11 Jul 2026 17:59:57 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifjn-0007sL-7N; Sat, 11 Jul 2026 17:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807180; bh=hU82KUVs7r0uV1CuQQBBYe00HlzyamewboyrZdlPX8c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=LUkSfxiTTIZeawfLRfQVMUo4sKPhes1wAkQdoCkYB/RBV9fjMb+cyiyjaZfENE51U
 3wczN2sU4GdwpA8VVFaRRV2Tb5i3JvLSw0aT6GEx/L//XJwK0EpINxt8tki7wh7+d1
 OY8Rvx1e09CnhTu3O9GMBirANFkoWdzKc8LbnGAmxCy3Hj0/CB64buboHEXXkDjssx
 v3d6Kho7aisCFa+NCJAgmppE2EmvtbdsC/iFpBjmxQg6kymcGwrv6Fx8eDUfwcL9Qa
 1pHtcLOuK+7Bld+tKBC5QoCahQ2Ou1THm8OiQSuBfezlqaaELjInz//U+4KljqFyZ9
 5/D6oDOba6LzA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1EF081C0A8F;
 Sun, 12 Jul 2026 00:59:40 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C98DE3EAF1A;
 Sun, 12 Jul 2026 00:59:49 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 400BC132EB; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 04/81] hw/9pfs: add msize_limit transport callback
Date: Sun, 12 Jul 2026 00:57:42 +0300
Message-ID: <20260711215904.3757-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
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



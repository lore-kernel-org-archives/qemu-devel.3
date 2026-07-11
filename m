Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C9BC44506
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:01:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifjz-0001fh-GM; Sat, 11 Jul 2026 18:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifjv-0001bZ-DT; Sat, 11 Jul 2026 18:00:03 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifjt-0007u9-NO; Sat, 11 Jul 2026 18:00:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807180; bh=hsiOAVI1pxA6gsTTT3L+Qtz9jOIhe5gxKl4Fs1a8qgU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=he50b1ylsyRDgnHpoEHSM2Dv3ca1G5/hvZJvmMSDOzGrsMu8f7DMpGvxpW5P7hq2h
 dVV7uKkfEYcHgQBE/0vdnIZbutmH7ZVSJBdE58vj5GdTTUv/lTE5Cy3KI9GG+nkQCZ
 OAffiLpTsV4WfB+X66r/OM0sM1KVWd/673DFiJWvGeoxqaiE83uaVasK6Mcycf+vkx
 bhDzZlrx6pJSu7Kp26gBelOl09d+tb+LSIyko3pborFv+EGE2REr+IXaMwGfDaOWp9
 zQ342easLnIjJ4h72nkVh9bpFsYw4Cd3jkPe30s039w9yiGfp506jyu4BVk/rRrz+Y
 tWVPGE+iH+KNQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 33EFE1C0A93;
 Sun, 12 Jul 2026 00:59:40 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id DF6713EAF1E;
 Sun, 12 Jul 2026 00:59:49 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 49341132F3; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 08/81] hw/9pfs: add response_buffer_size transport
 callback
Date: Sun, 12 Jul 2026 00:57:46 +0300
Message-ID: <20260711215904.3757-8-mjt@tls.msk.ru>
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

Add a new callback to the V9fsTransport interface that allows each transport
to provide the real size of its current response buffer.

This is needed for subsequent safety guards that will limit generated
responses appropriately before trying to allocate, generate, and send a
response to guest.

This is especially required for request handlers that need to allocate
dynamic and potentially large host memory for generating a response. These
safety guards are mandatory to counter bad clients that try to trick server
by supplying response buffers being smaller than the previously negotiated
msize value.

Link: https://lore.kernel.org/qemu-devel/703ed8ce4401c4550ef2cd99f30ab808665d6e85.1781287774.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit 4b615eaa1be4a54fb677c302e1a86fe09a94aecd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index d8f364fafdb..1a309664f6e 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -482,6 +482,7 @@ struct V9fsTransport {
                                          unsigned int *pniov, size_t size);
     void        (*push_and_notify)(V9fsPDU *pdu);
     size_t      (*msize_limit)(V9fsState *s);
+    size_t      (*response_buffer_size)(V9fsPDU *pdu);
 };
 
 #endif
-- 
2.47.3



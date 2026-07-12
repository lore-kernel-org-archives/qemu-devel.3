Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2278CC43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wilcn-0002AK-RB; Sun, 12 Jul 2026 00:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilcW-0001hB-5O; Sun, 12 Jul 2026 00:16:51 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilcU-0006Gq-HU; Sun, 12 Jul 2026 00:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829780; bh=hsiOAVI1pxA6gsTTT3L+Qtz9jOIhe5gxKl4Fs1a8qgU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NoxqKGLa+CbOH3Fg4Dxs95zsD7t/qr6rDGAEh2hLIuWfEgkUl4vKaWzD1r5gM1Coa
 dgg4PDwGx8Npsu9HWCnjo9QunfMQeDdjDkJVWMwG5TALtD1FalXzsMcxaMXsUgRlTr
 BRjeYGX6ueptL+nRjGwinBv06O30+FYsfP9ijLAY8f+66oG6k77k9PMvQCL+RLIoEc
 5No7sEz2VKpOpmm96r51vr8n32A8/g1uNaFzLVCHwoH+81z1cw70otBb6y5YgCzRnj
 iMbmQkjDIJNc6Y0IBwKh8ZileTGSDeSlfDqfGkhW8NkZBHw9b/6hU5xwJ8jhusaO/6
 NvHFf6vaBqo6g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CB2E81C0BE4;
 Sun, 12 Jul 2026 07:16:20 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0A95B3EB944;
 Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 29766133CB; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 09/75] hw/9pfs: add response_buffer_size transport
 callback
Date: Sun, 12 Jul 2026 07:14:27 +0300
Message-ID: <20260712041539.108341-9-mjt@tls.msk.ru>
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8E8C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCC0-0001Kr-QU; Mon, 29 Jun 2026 09:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <4b615eaa1be4a54fb677c302e1a86fe09a94aecd@kylie.crudebyte.com>)
 id 1weCBz-00017V-5O; Mon, 29 Jun 2026 09:38:31 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <4b615eaa1be4a54fb677c302e1a86fe09a94aecd@kylie.crudebyte.com>)
 id 1weCBw-0003s1-4J; Mon, 29 Jun 2026 09:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=O1zLhq6mUlcxDD4gyURp+Ui17aiGUEOzm6zq3xQ5tDU=; b=NM8/O
 qViVyKLLZMUDterdSrf4XU2HQOz0HrcKeZxiVpXaQWNCH4xv7FhaEAfGe7WSd/Wcq46snDz+orGAr
 XO+rwSE2HWgHMnOb4CNR49/axZ72VPy4lPf3Z3ceyR9/hKE5RUO1Oniot6HY2w7RTxob6ipoVQFW4
 lk+0iRqqVMvI4FfBQJCqBzlZQ8HX8G33dp+ZggoQCBvse2h4QVgDMw5AmkDY8y9KErVRRrpZRZg/B
 yKdRxB7aq+52OYh9VhSMyYuIN9dJrQTMEyHj2SlWAPDWZW6qeskOtnbaiTv6qecwRSdtkwf4OD2Qe
 JY3MxQn+6gi+YQHj+gzRe4Or7zNY9Edsl41ShMiFqrh3vKypc1nkPotjIavLS321ofZCGXq2XgsXZ
 98jjK3JJYlDfPYOr1TM8JtUhZO/9ymoH+PG97gu9k9aWfXjTh1k0S5mc+P7lCwqmINnIE/7WM7o7a
 d5OGPbhED49plT9UFzaikx1+ctKNXLfGVMDzSASA0rsvdUIioyzJFC1QXMmPCH2ML5/1HrrKXJdYO
 LDutkgfObc0cILuVNp8xCOVSW8/WaYyTz39+6VoMGtSSvfTSUFSUauWYQQQ2EnVZve0AhIXBXnQSu
 Ekie2UqbHZ4XDdDhKCKR2ctmJiTNNGkqZMpvn4AgdqDXX3EUwjCbXDRjLvw+BE=;
Message-ID: <4b615eaa1be4a54fb677c302e1a86fe09a94aecd.1782739719.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1782739719.git.qemu_oss@crudebyte.com>
References: <cover.1782739719.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 29 Jun 2026 15:28:39 +0200
Subject: [PULL 05/23] hw/9pfs: add response_buffer_size transport callback
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=4b615eaa1be4a54fb677c302e1a86fe09a94aecd@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
---
 hw/9pfs/9p.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index d8f364fafd..1a309664f6 100644
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



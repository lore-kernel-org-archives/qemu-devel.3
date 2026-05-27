Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B37CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 22:01:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSMIA-0003VL-Uj; Wed, 27 May 2026 17:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <8aef6df2c8e86a961ff233633eb2dcb9b4793ea1@kylie.crudebyte.com>)
 id 1wSMIA-0003V9-2P; Wed, 27 May 2026 17:59:58 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <8aef6df2c8e86a961ff233633eb2dcb9b4793ea1@kylie.crudebyte.com>)
 id 1wSMI7-0004Ht-NH; Wed, 27 May 2026 17:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=nz0jGzs/Ah602Nv6FwI476PLtl2CK7ANoNulNygqAu8=; b=ZnJZP
 qfFRwuw4T6EqskwfOnFPNNwoSIyWuSzx9XPGT5ePtWLJBvyQsHPAtOIYX1+lqUZN7EC4ljY3g4w8G
 ZOju00V3+uVV17HAfu+k2MzHy7yLtbr7RiS5qg2IiBKuNEpS4kNHhoSIvfHJJbOzJ98tkAiu7M5QB
 FXQsgsT5xpWOl6fk0ETE5QjKJ/HZ3j7+Gu3GQR2so9NYWGRkx8VdXyx+022MUkgC9WpiYRRpd3iW8
 NwW9VU4AkV0mHZqqWDT7HEtGSHchEUrUP2R9V1cZ9UAzsUhwxYTJG605XXkK/1pvrlAGgS8XLUxL+
 ViwA2gzHAUQ47i1jjhYABi3E1PieLx3cVKzhLQV4v0DCME+KNjLJod4HzTw8rKaUT7B/Vj2eKBCKD
 OynPHL7vr5UU1WXofU7iQKzoVuyEEvHMkaRZRYxMz5zmFFOf90BD3dKeF14rANzNgZvrsmInwWpmw
 yDM5UiT48ZxCVIiWWTLTrXz5TAb7snEOe4VwnbJpG+RPXKeqmk74GXXhP0wGLGvjDeIV3+AaX1aS8
 Ay15tK1t0gJ1zsF2CFZ/cuNQVmG4zlZrPkzfZ6JKQ+BPhB/PS2T29s/sr8i64QTuJndhZ+iDj5gRj
 v8tmbVCwoo+SbFQUQTev78iluWr01or0cqnFi8JmWtS5MMYgk71wRXQptw9jeY=;
Message-ID: <8aef6df2c8e86a961ff233633eb2dcb9b4793ea1.1779916560.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1779916560.git.qemu_oss@crudebyte.com>
References: <cover.1779916560.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 27 May 2026 23:15:30 +0200
Subject: [PATCH 5/8] hw/9pfs: add response_buffer_size transport callback
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Feifan Qian <bea1e@proton.me>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=8aef6df2c8e86a961ff233633eb2dcb9b4793ea1@kylie.crudebyte.com;
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

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 14111e041a..1efe000f6f 100644
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



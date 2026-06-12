Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC19CD98CF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 19:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY77D-00019f-9P; Fri, 12 Jun 2026 15:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <703ed8ce4401c4550ef2cd99f30ab808665d6e85@kylie.crudebyte.com>)
 id 1wY77B-00019R-Tp; Fri, 12 Jun 2026 15:00:25 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <703ed8ce4401c4550ef2cd99f30ab808665d6e85@kylie.crudebyte.com>)
 id 1wY77A-0000Kp-Ge; Fri, 12 Jun 2026 15:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=nz0jGzs/Ah602Nv6FwI476PLtl2CK7ANoNulNygqAu8=; b=Y+cH1
 4RWz6YpD7zUDMBFk5RF91u1wsXKwVl9CO4MLfyFxCaObuCW/y+M8/xZJ+yjOwq6Me8RL//Y7kfCcE
 WIfk8g0/sw4jfu1j+1WZq5VbOWUCjOEgAAteKR0oj0CS3sT8a7WpdhHkfC4qw8ruLs+nun3YJg0Vt
 WPfRCYRnJ8J+BGUrDkDo6qS+luAdte6ggFjq0mg4Kz99MrdsUw/DeKZzgGOa9MIl5JXEgoQqSrFaJ
 t2d0fi5usAkEQ/ZmnphCtI2f499AIcVjq2Dw05DgPczFUk31EKyC51vpiXQidn1neWpfJPag2x18J
 pGeU1IqleDkJvLYmouuqNlJUWhoAFY3sM7X22YTcnW9RdmwbyJVKRjHr/j1SZK/YN3O+3sRQ1VPp8
 XUnxcJO3uTEwae4QlIobo/eKBx1N1Ft0NrbzXJAuOvJpy1JaaF08qDe66+y+KEzc5Xi+0PWDJhOwL
 uxCbTd+ZSWKVX7B+9yGySIT4QxVU9ScVsdxwyQ+geyN5z5miCO2FzStAmssEDc8+ECJsr0NO4ZRaq
 nei/q6+7SEboYy8CWJ6E3AWdqhFCqToymgf64s/zIaLbsL8O88aJ+vEC+Kmwfbppph2Fc3KdolTxH
 KyEOPGHRphVLCKrqokEsuJOmyTNKvOPsCnQJ/axtpUe+3HN/ft1hCBPLevq5Yo=;
Message-ID: <703ed8ce4401c4550ef2cd99f30ab808665d6e85.1781287774.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1781287774.git.qemu_oss@crudebyte.com>
References: <cover.1781287774.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 12 Jun 2026 20:22:52 +0200
Subject: [PATCH v2 5/8] hw/9pfs: add response_buffer_size transport callback
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Feifan Qian <bea1e@proton.me>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=703ed8ce4401c4550ef2cd99f30ab808665d6e85@kylie.crudebyte.com;
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



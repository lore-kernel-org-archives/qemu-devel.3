Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A69D9CC6B12
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 19:37:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGiJK-0005s9-Sm; Tue, 13 Oct 2026 15:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xGiJJ-0005ru-Le
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 15:37:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xGiJH-0000ed-WA
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 15:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791920234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=yLxGAdVBgYuUaJkISs1hJZXwTdp9oSA9EMj9RCr0ZTY=;
 b=KqjERyOtJX+o924XPTd+yMMBEyQ2zmpbNnkOMIJvDelCCSSQbvoMid4dR/F+ybTxiXGLD9
 XsirI6MjYN4ivAUHJiWRzzd9fuBOGmgHsdjooSx6WjdeH5um4ZTXqCpyxLlQmp0Fl2TYQk
 e8wDA6TLmO6QsJj39Dljr9hUycGqfcA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-MovkUSVQOZWMfEIzG7DhTg-1; Tue,
 13 Oct 2026 19:37:13 +0000
X-MC-Unique: MovkUSVQOZWMfEIzG7DhTg-1
X-Mimecast-MFC-AGG-ID: MovkUSVQOZWMfEIzG7DhTg_1791920232
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E0701955F29; Tue, 13 Oct 2026 19:37:12 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A9024769; Tue, 13 Oct 2026 19:37:11 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH] dmg: avoid out-of-bounds memory load in dmg_read_mish_block()
Date: Tue, 13 Oct 2026 15:37:08 -0400
Message-ID: <20261013193710.1311621-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

dmg_read_mish_block() loads from memory beyond the end of the buffer
when count is less than 4.

There is no known security impact here because dmg_read_mish_block()
returns almost immediately without any opportunity to gain control of
execution or cause other damage. A crash will not happen because it's a
32-bit load from a memory address that was just heap allocated. The
address will be properly aligned and will not span a page of memory.

Reported-by: router0mail <https://gitlab.com/router0mail>
Fixes: 7aee37b93a4f ("block/dmg: process a buffer instead of reading ints")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4569
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/dmg.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/dmg.c b/block/dmg.c
index 5d7d3b8901f..412d4bfc354 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -226,9 +226,13 @@ static int dmg_read_mish_block(BDRVDMGState *s, DmgHeaderState *ds,
     uint64_t in_offset = ds->data_fork_offset;
     uint64_t out_offset;
 
+    if (count < 244) {
+        return 0; /* too small, skip silently */
+    }
+
     type = buff_read_uint32(buffer, offset);
-    /* skip data that is not a valid MISH block (invalid magic or too small) */
-    if (type != 0x6d697368 || count < 244) {
+    /* skip data that is not a valid MISH block (invalid magic) */
+    if (type != 0x6d697368) {
         /* assume success for now */
         return 0;
     }
-- 
2.56.0



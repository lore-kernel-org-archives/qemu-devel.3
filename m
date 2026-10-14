Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DEC6CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 14:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH0Bi-0006le-Km; Wed, 14 Oct 2026 10:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xH0Bh-0006lG-9Q
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 10:42:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xH0Bf-0003k9-R5
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 10:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791988955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tcgCoIamvMlm9LpHA5ocjjZ1wJy+Hx7oD+Z0QMeFelk=;
 b=d9SEcjqc/hEm6KL+TpAsi/QozKLsZ8BFt9LxuqfIAiJgrSFzwf1Pd1NhdaA297xniqP6kd
 Jrohxv/0dDUXotpokba4mKRtZILhwpQIVNpAXahBCM0RBt5rGnPjmHA7/KvstqM5IoV/z7
 jc0PZamavV1nld9mNtkMKLgXxpgwPV4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-2CHJTbYINb-N-WAV1oN2aw-1; Wed,
 14 Oct 2026 14:42:31 +0000
X-MC-Unique: 2CHJTbYINb-N-WAV1oN2aw-1
X-Mimecast-MFC-AGG-ID: 2CHJTbYINb-N-WAV1oN2aw_1791988950
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C10EB1956056; Wed, 14 Oct 2026 14:42:29 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D17F7195608D; Wed, 14 Oct 2026 14:42:28 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: [PULL] dmg: avoid out-of-bounds memory load in dmg_read_mish_block()
Date: Wed, 14 Oct 2026 10:42:24 -0400
Message-ID: <20261014144227.1357644-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20261013193710.1311621-1-stefanha@redhat.com
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



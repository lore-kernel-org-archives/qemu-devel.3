Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51938C28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 17:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twPPI-0003M2-KU; Sun, 23 Mar 2025 13:46:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1twPOi-0002dv-Hp
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:46:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1twPOg-00041M-7Z
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742751964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MvcPmepQnYaqXyzcNgX6ZnHaPADmQDVdyjY/kGblWr4=;
 b=OulJpfcw870c0+UuwI6D34j7ONQCkj72TabXwYxaz7euxPMU6qLov49hnPOBmjGt0BKMmW
 NNE5Iv6ydDCNUcUGCkjbNTS1qqgaMxEoUahCqzrorbVTicO5u45rap3Nkfroa9RjMKw8+R
 bXTlots/ZgJrzvre93F/uNffuBjYDx8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-t5hOVJvmOfuI_my2LcqDCg-1; Sun,
 23 Mar 2025 13:46:02 -0400
X-MC-Unique: t5hOVJvmOfuI_my2LcqDCg-1
X-Mimecast-MFC-AGG-ID: t5hOVJvmOfuI_my2LcqDCg_1742751961
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A47C180899B; Sun, 23 Mar 2025 17:46:00 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.3])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 88BC61956095; Sun, 23 Mar 2025 17:45:58 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 3/3] hw/misc/aspeed_hace: Fix buffer overflow in has_padding
 function
Date: Sun, 23 Mar 2025 18:45:41 +0100
Message-ID: <20250323174541.406860-4-clg@redhat.com>
In-Reply-To: <20250323174541.406860-1-clg@redhat.com>
References: <20250323174541.406860-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jamin Lin <jamin_lin@aspeedtech.com>

The maximum padding size is either 64 or 128 bytes and should always be smaller
than "req_len". If "padding_size" exceeds "req_len", then
"req_len - padding_size" underflows due to "uint32_t" data type, leading to a
large incorrect value (e.g., `0xFFXXXXXX`). This causes an out-of-bounds memory
access, potentially leading to a buffer overflow.

Added a check to ensure "padding_size" does not exceed "req_len" before
computing "pad_offset". This prevents "req_len - padding_size" from underflowing
and avoids accessing invalid memory.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Fixes: 5cd7d8564a8b563da724b9e6264c967f0a091afa ("aspeed/hace: Support AST2600 HACE ")
Link: https://lore.kernel.org/qemu-devel/20250321092623.2097234-3-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/aspeed_hace.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/misc/aspeed_hace.c b/hw/misc/aspeed_hace.c
index 32a5dbded3c6..d75da3335336 100644
--- a/hw/misc/aspeed_hace.c
+++ b/hw/misc/aspeed_hace.c
@@ -128,6 +128,11 @@ static bool has_padding(AspeedHACEState *s, struct iovec *iov,
     if (*total_msg_len <= s->total_req_len) {
         uint32_t padding_size = s->total_req_len - *total_msg_len;
         uint8_t *padding = iov->iov_base;
+
+        if (padding_size > req_len) {
+            return false;
+        }
+
         *pad_offset = req_len - padding_size;
         if (padding[*pad_offset] == 0x80) {
             return true;
-- 
2.49.0



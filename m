Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A92C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 11:32:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBYZq-0004sq-6t; Mon, 27 May 2024 07:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sBYZn-0004rU-9L
 for qemu-devel@nongnu.org; Mon, 27 May 2024 07:31:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sBYZl-0001Ok-Q6
 for qemu-devel@nongnu.org; Mon, 27 May 2024 07:31:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716809497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LVl/3RlbGuSyK2JmZR32QsIwXQ4iTQ3frlv9Hx6VZq0=;
 b=UhetkfGFGJe46sBQZ3gwg3Ew1m/c75GtpsiE8rd8M7UAFjZdnFS7ah/Tzfdw04mKtKNqkm
 VjNC7Fw143zIT+Sc5313+I7eSdLUfzlCKAqRYbSUSVpcjdf1toKtqQEhCnnU5Aom0FkCDK
 x47UxAvFC5AZuwBwb04F7rgYYnkAbSI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-n9DC4fGMPhC1S7M_BmXAuw-1; Mon, 27 May 2024 07:31:33 -0400
X-MC-Unique: n9DC4fGMPhC1S7M_BmXAuw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1EF25185A783;
 Mon, 27 May 2024 11:31:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E9ABEC15BED;
 Mon, 27 May 2024 11:31:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E99DD21E6601; Mon, 27 May 2024 13:31:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 3/9] block/vmdk: Improve error messages on extent write error
Date: Mon, 27 May 2024 13:31:25 +0200
Message-ID: <20240527113131.2054486-4-armbru@redhat.com>
In-Reply-To: <20240527113131.2054486-1-armbru@redhat.com>
References: <20240527113131.2054486-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

vmdk_init_extent() reports blk_co_pwrite() failure to its caller as

    An IO error has occurred

The errno code returned by blk_co_pwrite() is lost.

Improve this to

    failed to write VMDK <what>: <description of errno>

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240513141703.549874-4-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 block/vmdk.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 3b82979fdf..78f6433607 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -28,7 +28,6 @@
 #include "block/block_int.h"
 #include "sysemu/block-backend.h"
 #include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
@@ -2278,12 +2277,12 @@ vmdk_init_extent(BlockBackend *blk, int64_t filesize, bool flat, bool compress,
     /* write all the data */
     ret = blk_co_pwrite(blk, 0, sizeof(magic), &magic, 0);
     if (ret < 0) {
-        error_setg(errp, QERR_IO_ERROR);
+        error_setg_errno(errp, -ret, "failed to write VMDK magic");
         goto exit;
     }
     ret = blk_co_pwrite(blk, sizeof(magic), sizeof(header), &header, 0);
     if (ret < 0) {
-        error_setg(errp, QERR_IO_ERROR);
+        error_setg_errno(errp, -ret, "failed to write VMDK header");
         goto exit;
     }
 
@@ -2303,7 +2302,7 @@ vmdk_init_extent(BlockBackend *blk, int64_t filesize, bool flat, bool compress,
     ret = blk_co_pwrite(blk, le64_to_cpu(header.rgd_offset) * BDRV_SECTOR_SIZE,
                         gd_buf_size, gd_buf, 0);
     if (ret < 0) {
-        error_setg(errp, QERR_IO_ERROR);
+        error_setg_errno(errp, -ret, "failed to write VMDK grain directory");
         goto exit;
     }
 
@@ -2315,7 +2314,8 @@ vmdk_init_extent(BlockBackend *blk, int64_t filesize, bool flat, bool compress,
     ret = blk_co_pwrite(blk, le64_to_cpu(header.gd_offset) * BDRV_SECTOR_SIZE,
                         gd_buf_size, gd_buf, 0);
     if (ret < 0) {
-        error_setg(errp, QERR_IO_ERROR);
+        error_setg_errno(errp, -ret,
+                         "failed to write VMDK backup grain directory");
     }
 
     ret = 0;
-- 
2.45.0



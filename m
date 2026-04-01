Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D832D35163
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7sDa-0002Oy-0a; Wed, 01 Apr 2026 05:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1w7sDY-0002OT-3A
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:50:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1w7sDW-0000iM-Ip
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775037029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MIISWhrOYIIZTLSTfVQOo7bsgxwF6AZpd+13kQost8E=;
 b=WNfOU7CZ4+1KpFdB3Tx3jVuFr77AP5Sv0BQSDjvP7RLA4ky34N3odPA6xw+zOYxB3XMvnX
 YckEmI8/Z+LGJjB3AV7gGE2B7qgjCd5EFP10w4VZQtamelhdPxXNKb0Px2nvcf4uwQ5vK+
 mRAeGDwBD4xWhltPgpcAKlCJz/MVZzk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-JiixwK3pPbi31_KugfgjTw-1; Wed,
 01 Apr 2026 05:50:28 -0400
X-MC-Unique: JiixwK3pPbi31_KugfgjTw-1
X-Mimecast-MFC-AGG-ID: JiixwK3pPbi31_KugfgjTw_1775037027
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC3071954B20
 for <qemu-devel@nongnu.org>; Wed,  1 Apr 2026 09:50:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.48])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3277530001A2; Wed,  1 Apr 2026 09:50:27 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 014FC180060A; Wed, 01 Apr 2026 11:50:25 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Luigi Leonardi <leonardi@redhat.com>
Subject: [PULL 1/3] igvm: switch to PRIx64
Date: Wed,  1 Apr 2026 11:50:22 +0200
Message-ID: <20260401095024.1562621-2-kraxel@redhat.com>
In-Reply-To: <20260401095024.1562621-1-kraxel@redhat.com>
References: <20260401095024.1562621-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Luigi Leonardi <leonardi@redhat.com>

Use the PRIx64 format macro instead of %lX for uint64_t values.

This is to improve portability as %lX is not necessarily 64 bit long.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Message-ID: <20260330-igvm_fixes-v1-1-03587a5a808b@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/igvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 3b5edf15213c..50f0d6fb9a7b 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -187,7 +187,7 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
             error_setg(
                 errp,
                 "Processing of IGVM file failed: Could not prepare memory "
-                "at address 0x%lX due to existing non-RAM region",
+                "at address 0x%" PRIx64 " due to existing non-RAM region",
                 addr);
             return NULL;
         }
@@ -198,7 +198,7 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
             error_setg(
                 errp,
                 "Processing of IGVM file failed: Could not prepare memory "
-                "at address 0x%lX: region size exceeded",
+                "at address 0x%" PRIx64 ": region size exceeded",
                 addr);
             return NULL;
         }
-- 
2.53.0



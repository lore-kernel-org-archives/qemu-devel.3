Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 283E0C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 13:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDNZe-0002pY-OR; Fri, 09 May 2025 09:15:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNYK-0001oD-Hd
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:14:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uDNYI-000759-6T
 for qemu-devel@nongnu.org; Fri, 09 May 2025 09:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746796449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nHiDi2ZHWr431HJmeW0LZI0aOuvHwVaomQkrQOS5eew=;
 b=LBT/OkNYDI5o6iT1WTxOLK69nnNl0/cDiOQdyLSfRy39yZMZEhPg0uic6GrQn7cD+WWihS
 ikHdg6zvnbUKwfKoU0vWKOZDhGwGbOKYmuSdnJqmPStC+8fPR9mNOqhXkk0WBrGQLe4KtW
 tH93NRpgFZpgdVjC3T89jrshKV3rc14=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-Isp83ryhPxm6a03K9l4SEA-1; Fri,
 09 May 2025 09:14:08 -0400
X-MC-Unique: Isp83ryhPxm6a03K9l4SEA-1
X-Mimecast-MFC-AGG-ID: Isp83ryhPxm6a03K9l4SEA_1746796447
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B987180098E; Fri,  9 May 2025 13:14:06 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 974A71800DB9; Fri,  9 May 2025 13:14:03 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Rorie Reyes <rreyes@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 13/28] linux-header: update-linux-header script changes
Date: Fri,  9 May 2025 15:13:02 +0200
Message-ID: <20250509131317.164235-14-clg@redhat.com>
In-Reply-To: <20250509131317.164235-1-clg@redhat.com>
References: <20250509131317.164235-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Rorie Reyes <rreyes@linux.ibm.com>

Kernel commit 8a141be3233a changed from using
ASSEMBLY to ASSEMBLER
Updated the update-linux-header script to match

Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250425052401.8287-2-rreyes@linux.ibm.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 scripts/update-linux-headers.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
index 8913e4fb99b7d6589dd90143cec407b0f0cf6301..b43b8ef75a6321588475ec2bdf7f04e4b1ca5090 100755
--- a/scripts/update-linux-headers.sh
+++ b/scripts/update-linux-headers.sh
@@ -177,7 +177,7 @@ EOF
 
         # Remove everything except the macros from bootparam.h avoiding the
         # unnecessary import of several video/ist/etc headers
-        sed -e '/__ASSEMBLY__/,/__ASSEMBLY__/d' \
+        sed -e '/__ASSEMBLER__/,/__ASSEMBLER__/d' \
                "$hdrdir/include/asm/bootparam.h" > "$hdrdir/bootparam.h"
         cp_portable "$hdrdir/bootparam.h" \
                     "$output/include/standard-headers/asm-$arch"
-- 
2.49.0



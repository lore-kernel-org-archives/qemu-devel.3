Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45182C982C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 14:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6qz3-00040q-OB; Wed, 16 Sep 2026 10:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1x6qyb-0003qw-9v
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 10:51:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1x6qyX-0007LU-Ii
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 10:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789570256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=vEXdstDua2BZAhj6ayDVN5F5Nk8TK/TZmKRVlNcBD9I=;
 b=GOkl+wBQt5gC2arxpQavtRERytuHEWSeS0eWhq8b3yrau9HOtzwzIXxIrl6NhDhylud04z
 fHePrz0doP3HX6rpTvoJKtV1OYjrguMP2NLDIzatAKZ+QoR/H7mcNpFyFlGXiPZ3MUZdr8
 0BYHNgRZZMtUXE3ALVcmREHYn7eTMII=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-286-zrs2gKk0PCCnHkzDkF4h1A-1; Wed,
 16 Sep 2026 10:50:53 -0400
X-MC-Unique: zrs2gKk0PCCnHkzDkF4h1A-1
X-Mimecast-MFC-AGG-ID: zrs2gKk0PCCnHkzDkF4h1A_1789570252
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5C2A2185589F
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 14:50:52 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.37])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E2DB5433; Wed, 16 Sep 2026 14:50:51 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id CD8C9180038A; Wed, 16 Sep 2026 16:50:50 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] hw/uefi: add missing uefi_str_is_valid check to
 uefi_vars_mm_lock_variable
Date: Wed, 16 Sep 2026 16:50:50 +0200
Message-ID: <20260916145050.1329206-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4213
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/uefi/var-service-vars.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/uefi/var-service-vars.c b/hw/uefi/var-service-vars.c
index e0ea3d532eb6..ef8849f81511 100644
--- a/hw/uefi/var-service-vars.c
+++ b/hw/uefi/var-service-vars.c
@@ -690,6 +690,10 @@ uefi_vars_mm_lock_variable(uefi_vars_state *uv, mm_header *mhdr,
         return uefi_vars_mm_error(mhdr, mvar, EFI_BAD_BUFFER_SIZE);
     }
 
+    if (!uefi_str_is_valid(name, lv->name_size, true)) {
+        return uefi_vars_mm_error(mhdr, mvar, EFI_INVALID_PARAMETER);
+    }
+
     uefi_trace_variable(__func__, lv->guid, name, lv->name_size);
 
     pe = g_malloc0(sizeof(*pe) + lv->name_size);
-- 
2.55.0



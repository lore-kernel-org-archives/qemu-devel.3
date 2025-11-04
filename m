Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31DACCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 10:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGEG6-00055e-QS; Tue, 04 Nov 2025 05:27:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vGEG4-00054C-F0
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 05:27:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vGEG2-0002VV-KN
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 05:27:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762252040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Iqnj/tZa1MgLHYhxVlvVox41Ads81UBg9q6aKofNzhc=;
 b=ftZP98jpJignsKRa7M8KTMAnJ8G/yEvSoIskHUEMegiHjn4v1YRnmd2jN3xpXzEv5GeIel
 HLVST5ZlAfu7WXuPPZKAvgLEYwqlsE6ophhtgfir4jIgZdOohvQ9OWGglzqLipWj703GaM
 rUvRPwgEqF7Pxsb+e5r95eZjMNk9ms8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-XkLWZ32yM6CkfCeDxU6WBw-1; Tue,
 04 Nov 2025 05:27:18 -0500
X-MC-Unique: XkLWZ32yM6CkfCeDxU6WBw-1
X-Mimecast-MFC-AGG-ID: XkLWZ32yM6CkfCeDxU6WBw_1762252038
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C7D6019560B2
 for <qemu-devel@nongnu.org>; Tue,  4 Nov 2025 10:27:17 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.33.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6324E1800576; Tue,  4 Nov 2025 10:27:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C61901800080; Tue, 04 Nov 2025 11:27:14 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] hw/uefi: skip time check for append-write updates.
Date: Tue,  4 Nov 2025 11:27:14 +0100
Message-ID: <20251104102714.733078-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Only execute the time time check if the EFI_VARIABLE_APPEND_WRITE bit is
clear.  For append-write updates the timestamp verification is not
needed.

See uefi spec, section "8.2.6 Using the EFI_VARIABLE_AUTHENTICATION_2
descriptor"

Fixes: db1ecfb473ac ("hw/uefi: add var-service-vars.c")
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/uefi/var-service-vars.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/uefi/var-service-vars.c b/hw/uefi/var-service-vars.c
index 8533533ea5c8..52845e9723d3 100644
--- a/hw/uefi/var-service-vars.c
+++ b/hw/uefi/var-service-vars.c
@@ -475,7 +475,8 @@ static size_t uefi_vars_mm_set_variable(uefi_vars_state *uv, mm_header *mhdr,
                 goto rollback;
             }
             if (old_var && new_var) {
-                if (uefi_time_compare(&old_var->time, &new_var->time) > 0) {
+                if ((va->attributes & EFI_VARIABLE_APPEND_WRITE) == 0 &&
+                    uefi_time_compare(&old_var->time, &new_var->time) > 0) {
                     trace_uefi_vars_security_violation("time check failed");
                     mvar->status = EFI_SECURITY_VIOLATION;
                     goto rollback;
-- 
2.51.1



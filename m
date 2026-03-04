Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0C6EA4E27
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 08:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxh9J-000568-NH; Wed, 04 Mar 2026 03:00:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vxh9G-00051u-Ok
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 03:00:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vxh9E-00054M-VY
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 03:00:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772611199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=we2FB+ZMX82M1IcCOaZm4lzgrVAGYn4lhVZl4P65ADw=;
 b=fMHeoY8wvtXDTnUAFwRaMWiJwsejNzJN4O4elBNEtCUAWIpev4bcX0hI+ZJ2QOFQjlzqYu
 8DxAFh7l78Q8fD3NgJypVOP5rR1fhm/dkzrTvWRjDbZeDYE5p1pSc8q6tpQhbFybRx2pyf
 V8oRz3xiwty8LMeh37gLAW1ps1uWn00=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-fNP8nwV1O8SLOXIkH6mysQ-1; Wed,
 04 Mar 2026 02:59:57 -0500
X-MC-Unique: fNP8nwV1O8SLOXIkH6mysQ-1
X-Mimecast-MFC-AGG-ID: fNP8nwV1O8SLOXIkH6mysQ_1772611197
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E21C719560A6
 for <qemu-devel@nongnu.org>; Wed,  4 Mar 2026 07:59:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.140])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83D691800759; Wed,  4 Mar 2026 07:59:56 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 107131800382; Wed, 04 Mar 2026 08:59:54 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] hw/uefi: add variable digest to vmstate
Date: Wed,  4 Mar 2026 08:59:53 +0100
Message-ID: <20260304075954.584423-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_PASS=-0.001,
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

Add digest to vmstate if needed.  Clear digest before
loading vmstate to make sure it is initialized.

Fixes: db1ecfb473ac ("hw/uefi: add var-service-vars.c")
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/uefi/var-service-vars.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/hw/uefi/var-service-vars.c b/hw/uefi/var-service-vars.c
index 94f40ef23684..22f91ab2d4b5 100644
--- a/hw/uefi/var-service-vars.c
+++ b/hw/uefi/var-service-vars.c
@@ -37,8 +37,40 @@ const VMStateDescription vmstate_uefi_time = {
     },
 };
 
+static int uefi_vars_pre_load(void *opaque)
+{
+    uefi_variable *var = opaque;
+
+    /* clear digest which is optional in the live migration data stream */
+    var->digest = NULL;
+    var->digest_size = 0;
+    return 0;
+}
+
+static bool uefi_vars_digest_is_needed(void *opaque)
+{
+    uefi_variable *var = opaque;
+
+    if ((var->attributes & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS) &&
+        !uefi_vars_is_sb_any(var)) {
+        return true;
+    }
+    return false;
+}
+
+const VMStateDescription vmstate_uefi_variable_digest = {
+    .name = "uefi-variable-digest",
+    .needed = uefi_vars_digest_is_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(digest_size, uefi_variable),
+        VMSTATE_VBUFFER_ALLOC_UINT32(digest, uefi_variable, 0, NULL, digest_size),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 const VMStateDescription vmstate_uefi_variable = {
     .name = "uefi-variable",
+    .pre_load = uefi_vars_pre_load,
     .fields = (VMStateField[]) {
         VMSTATE_UINT8_ARRAY_V(guid.data, uefi_variable, sizeof(QemuUUID), 0),
         VMSTATE_UINT32(name_size, uefi_variable),
@@ -49,6 +81,10 @@ const VMStateDescription vmstate_uefi_variable = {
         VMSTATE_STRUCT(time, uefi_variable, 0, vmstate_uefi_time, efi_time),
         VMSTATE_END_OF_LIST()
     },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_uefi_variable_digest,
+        NULL
+    }
 };
 
 uefi_variable *uefi_vars_find_variable(uefi_vars_state *uv, QemuUUID guid,
-- 
2.53.0



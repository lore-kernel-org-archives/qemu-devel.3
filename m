Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79968C44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmXSf-0007iV-K5; Wed, 22 Jul 2026 09:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wmXSd-0007hv-Pp
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 09:58:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wmXSc-0006tv-Cw
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 09:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784728686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qnhe/K/CSnKFF9lkiIC7iZSwbav49Tu/KtUY5ACFBZ0=;
 b=EfHErmm9QTBLR2/RN2jMf2sRTfHK88FrEMH7KSPv91TAy7Y6J3cFBsUINK+iVdntOMBRWB
 tBlwfXmIYVsCIFaSUtq79ta+T9xMSHtUc4u6MQHVUgPkxREgkKkBtjuRKiVwX4wo/K+dOy
 xvHpeXSXq+TY+qyc+ZwfyxqILRsB4UU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-dAWsfpg-Plu0jthF9DIOnA-1; Wed,
 22 Jul 2026 09:57:58 -0400
X-MC-Unique: dAWsfpg-Plu0jthF9DIOnA-1
X-Mimecast-MFC-AGG-ID: dAWsfpg-Plu0jthF9DIOnA_1784728677
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 432D11956044
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 13:57:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.49.247])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 003F03004082; Wed, 22 Jul 2026 13:57:56 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id CC8CD1826B15; Wed, 22 Jul 2026 15:57:52 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
	Luigi Leonardi <leonardi@redhat.com>
Subject: [PULL 6/6] hw/uefi: make SetupMode read-only
Date: Wed, 22 Jul 2026 15:57:50 +0200
Message-ID: <20260722135752.1264244-7-kraxel@redhat.com>
In-Reply-To: <20260722135752.1264244-1-kraxel@redhat.com>
References: <20260722135752.1264244-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=kraxel@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

This is read-only variable which informs the OS about the
secure boot state.  Reject any attempts to write to it.

Fixes: CVE-2026-16288
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4039
Acked-by: Luigi Leonardi <leonardi@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20260720143244.821889-7-kraxel@redhat.com>
---
 hw/uefi/var-service-auth.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/uefi/var-service-auth.c b/hw/uefi/var-service-auth.c
index f3dc9c6ca608..899444af12df 100644
--- a/hw/uefi/var-service-auth.c
+++ b/hw/uefi/var-service-auth.c
@@ -298,6 +298,13 @@ efi_status uefi_vars_check_secure_boot(uefi_vars_state *uv, uefi_variable *var)
         return EFI_WRITE_PROTECTED;
     }
 
+    /* reject SetupMode updates */
+    if (qemu_uuid_is_equal(&var->guid, &EfiGlobalVariable) &&
+        uefi_str_equal(var->name, var->name_size,
+                       name_setup_mode, sizeof(name_setup_mode))) {
+        return EFI_WRITE_PROTECTED;
+    }
+
     return EFI_SUCCESS;
 }
 
-- 
2.55.0



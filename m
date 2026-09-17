Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664F6C982CF
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 13:34:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7CFO-0000dV-6U; Thu, 17 Sep 2026 09:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1x7CF6-0000bT-Bd
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 09:33:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1x7CEy-0003WG-ID
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 09:33:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789652006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CF0kpZJ5GhLztDravSG1LpM76fb5OfpRcRDbaQO4WRM=;
 b=hpG/8KJFGgmocwUNGK6XxTEZa3Tc1LSOkbn06EKjENFeUx1JSKd0QCigZ6v9Gq+vqSBUWz
 NadLMNo1ZrRCdZiobptY0rxhcPpFrPTOgVmWj8xQ7XNH+ZdTPUEQbnd+RapHDa0FUviOQO
 JysQGg8xpQmK8425fpHZh5hQ+ahkD90=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-G4UqsCcqMKShI2MLLmT5NA-1; Thu,
 17 Sep 2026 09:33:21 -0400
X-MC-Unique: G4UqsCcqMKShI2MLLmT5NA-1
X-Mimecast-MFC-AGG-ID: G4UqsCcqMKShI2MLLmT5NA_1789652001
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D45B9195FD22; Thu, 17 Sep 2026 13:33:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.37])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 089D21956095; Thu, 17 Sep 2026 13:33:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id EF81C18003BB; Thu, 17 Sep 2026 15:33:18 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Luigi Leonardi <leonardi@redhat.com>
Subject: [PULL 1/5] hw/uefi: add missing uefi_str_is_valid check to
 uefi_vars_mm_lock_variable
Date: Thu, 17 Sep 2026 15:33:14 +0200
Message-ID: <20260917133318.2004317-2-kraxel@redhat.com>
In-Reply-To: <20260917133318.2004317-1-kraxel@redhat.com>
References: <20260917133318.2004317-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4213
Reviewed-by: Luigi Leonardi <leonardi@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20260916145050.1329206-1-kraxel@redhat.com>
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



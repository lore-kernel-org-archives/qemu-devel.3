Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098A1C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 09:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfDeI-0005Nx-Qn; Thu, 02 Jul 2026 05:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wfDeH-0005Nh-4O
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 05:23:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wfDeF-0005uB-DL
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 05:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782984233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ha4XTpT+RqnbRJPQX2PzEMZ+ZMG44RCEdXff0/ITp0A=;
 b=S0QtWEXXBGH9F57/QZWyPeXvoeJI6dIDuYPp6xMJOQk2k5NXeeOWmJ4vMMG5LjThaOLt0p
 FzsZ54zwUBEyu8Tq2cNtq53FByRmJZYRxSoDu3BnR0ady7jJkSwRx+7VFLkguxAd+eV4mE
 FN8dILwQ2HvwhSH/3WnJm9TjyR2OPr8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-u4fK1_dAMr6zC4sHk_tm5g-1; Thu,
 02 Jul 2026 05:23:52 -0400
X-MC-Unique: u4fK1_dAMr6zC4sHk_tm5g-1
X-Mimecast-MFC-AGG-ID: u4fK1_dAMr6zC4sHk_tm5g_1782984231
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D6E118333AD; Thu,  2 Jul 2026 09:23:51 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.8])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C5D161966660; Thu,  2 Jul 2026 09:23:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9EEFA1800D63; Thu, 02 Jul 2026 11:23:49 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
	peter.maydell@linaro.org
Subject: [PATCH v2 1/2] hw/uefi: add sanity check
Date: Thu,  2 Jul 2026 11:23:46 +0200
Message-ID: <20260702092349.4183512-2-kraxel@redhat.com>
In-Reply-To: <20260702092349.4183512-1-kraxel@redhat.com>
References: <20260702092349.4183512-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Verify the passed buffer has the minimal required length before
reading the size field + verifying the total length.

Fixes: CVE-2026-58581
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3614
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/uefi/var-service-policy.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/uefi/var-service-policy.c b/hw/uefi/var-service-policy.c
index 58da4adbebaf..989bf87ddb86 100644
--- a/hw/uefi/var-service-policy.c
+++ b/hw/uefi/var-service-policy.c
@@ -276,6 +276,9 @@ static uint32_t uefi_vars_mm_check_policy_register(uefi_vars_state *uv,
     uefi_var_policy *pol;
     uint64_t length;
 
+    if (mhdr->length < sizeof(*mchk) + sizeof(*pe)) {
+        return uefi_vars_mm_policy_error(mhdr, mchk, EFI_BAD_BUFFER_SIZE);
+    }
     if (uadd64_overflow(sizeof(*mchk), pe->size, &length)) {
         return uefi_vars_mm_policy_error(mhdr, mchk, EFI_BAD_BUFFER_SIZE);
     }
-- 
2.55.0



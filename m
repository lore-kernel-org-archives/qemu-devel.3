Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A65C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 08:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weTs0-0001J6-PO; Tue, 30 Jun 2026 04:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1weTrz-0001Iw-OK
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 04:31:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1weTry-0007OA-Bi
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 04:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782808261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hv+0R834BwhHICPy1zKpGYMVlCiOM1GdjbkzMGOS51o=;
 b=c1YQoNz40G1mcrSY9+fY3PUspSXKlHI2Imvw4qTgh9tp5xtAsc+YZ/1aZ8CSiWMu/rE9UT
 Al6b4iU1/rThUIL7sASDsZk2og9Y7c805/zFc1LvmcIi9lX6vde/34QQky+l+x8azcC+ES
 U3CSq2lJv8eLlU1cjcDBiSt3pwqbrXw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-2_wbR7PoM7C3Cp1a5RgNsw-1; Tue,
 30 Jun 2026 04:30:57 -0400
X-MC-Unique: 2_wbR7PoM7C3Cp1a5RgNsw-1
X-Mimecast-MFC-AGG-ID: 2_wbR7PoM7C3Cp1a5RgNsw_1782808256
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 485F91955D92; Tue, 30 Jun 2026 08:30:56 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.33.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5F4BA1955F6F; Tue, 30 Jun 2026 08:30:53 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, berrange@redhat.com,
 skolothumtho@nvidia.com, nicolinc@nvidia.com, nathanc@nvidia.com
Subject: [PATCH 2/2] hw/arm/smmuv3: Sanitize SMMU_S_STRTAB_BASE_CFG.LOG2SIZE
Date: Tue, 30 Jun 2026 10:30:20 +0200
Message-ID: <20260630083042.2692392-3-eric.auger@redhat.com>
In-Reply-To: <20260630083042.2692392-1-eric.auger@redhat.com>
References: <20260630083042.2692392-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

STRTAB_BASE_CFG.LOG2SIZE is programmed by the guest through the
emulated SMMUv3 MMIO register interface. Currently the value is
not checked.

The SMMU spec says: "Except for readback of a written value, the
effective LOG2SIZE is <= SMMU_IDR1.SIDSIZE for the purposes of
input StreamID range checking and upper/lower/linear Stream table
index address calculation."

So for STE lookup make sure log2size is capped at SMMU_IDR1.SIDSIZE.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmuv3.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 0a8d2fbb6a7..db5aca26ec0 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -672,6 +672,15 @@ int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste, SMMUEventInfo *event)
     /*
      * Check SID range against both guest-configured and implementation limits
      */
+    if (log2size > SMMU_IDR1_SIDSIZE) {
+        /*
+         * spec says: Except for readback of a written value, the effective
+         * LOG2SIZE is <= SMMU_IDR1.SIDSIZE for the purposes of input StreamID
+         * range checking and upper/lower/linear Stream table index address
+         * calculation.
+         */
+        log2size = SMMU_IDR1_SIDSIZE;
+    }
     if (sid >= (1 << MIN(log2size, SMMU_IDR1_SIDSIZE))) {
         event->type = SMMU_EVT_C_BAD_STREAMID;
         return -EINVAL;
-- 
2.53.0



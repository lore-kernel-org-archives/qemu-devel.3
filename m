Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEAC6CCFA05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 10:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGxfo-0006Xd-Cq; Thu, 06 Nov 2025 05:57:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vGxfj-0006XJ-FN
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 05:56:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1vGxfh-0006ZQ-8u
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 05:56:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762426610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=5ZliaAzIL0/XsEs0zQXoK22rXGo24lUlSn1S6cRytrA=;
 b=MXAO/3S7+nQIogpiBNEUy0xH4J6QqiOaXRD3d2RPnLj/qAqK0/t+9eimxLMtR0dh/L9oUd
 DzExgfAHxouHbv3Pl96+MXY32U8IKyaH9D37K2GwI1TjfWqd31o4JCgMdlgiOP4NtUU40x
 D+5l4o1fYJIUKTaP1Lc55BMAlYzIK1Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-466-PegsU3D0PXigelTsXYoCRQ-1; Thu,
 06 Nov 2025 05:56:45 -0500
X-MC-Unique: PegsU3D0PXigelTsXYoCRQ-1
X-Mimecast-MFC-AGG-ID: PegsU3D0PXigelTsXYoCRQ_1762426604
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE71D1800473; Thu,  6 Nov 2025 10:56:43 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.33.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 105441945110; Thu,  6 Nov 2025 10:56:43 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C522D1800080; Thu, 06 Nov 2025 11:56:40 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] q35: increase default tseg size
Date: Thu,  6 Nov 2025 11:56:40 +0100
Message-ID: <20251106105640.1642109-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
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

With virtual machines becoming larger (more CPUs, more memory) the
memory needed by the SMM code in OVMF to manage page tables and vcpu
state grows too.

Default SMM memory (aka TSEG) size is 16 MB, and this often is not
enough.  Bump it to 64 MB for new machine types.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/i386/pc.c      | 4 +++-
 hw/pci-host/q35.c | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 4d6bcbb846a0..f8b919cb6c47 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -81,7 +81,9 @@
     { "qemu64-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },\
     { "athlon-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },
 
-GlobalProperty pc_compat_10_1[] = {};
+GlobalProperty pc_compat_10_1[] = {
+    { "mch", "extended-tseg-mbytes", "16" },
+};
 const size_t pc_compat_10_1_len = G_N_ELEMENTS(pc_compat_10_1);
 
 GlobalProperty pc_compat_10_0[] = {
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 1951ae440cce..a708758d3615 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -663,7 +663,7 @@ static void mch_realize(PCIDevice *d, Error **errp)
 
 static const Property mch_props[] = {
     DEFINE_PROP_UINT16("extended-tseg-mbytes", MCHPCIState, ext_tseg_mbytes,
-                       16),
+                       64),
     DEFINE_PROP_BOOL("smbase-smram", MCHPCIState, has_smram_at_smbase, true),
 };
 
-- 
2.51.1



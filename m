Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE6BC43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 08:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weq0E-0002QP-06; Wed, 01 Jul 2026 04:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1weq0C-0002QF-1B
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 04:09:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1weq0A-0006bO-Iu
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 04:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782893336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=bQ3M6u0zpTTcOhFlHT0c+jxShYtZY0spxxjksEOvKso=;
 b=jOxzghEh1UG2tboeGSvTCKA+qHeX5GG7epMeg8aguYost6yXIEBukoWPrQoQ+MrKuMUnU2
 eZer38Ja5DTI5VFEWRJWCzHNpkUCfjIU4xRPc0bKvdN5yNTmFqDOqTNflSY+1gVCv7mf0e
 gFgHBBkL1Uq4ZX8TcErJZkIiuGZY9oM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-B8AzSNTAPhuOG59G8-sE7A-1; Wed,
 01 Jul 2026 04:08:53 -0400
X-MC-Unique: B8AzSNTAPhuOG59G8-sE7A-1
X-Mimecast-MFC-AGG-ID: B8AzSNTAPhuOG59G8-sE7A_1782893332
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 482F8180AEA9; Wed,  1 Jul 2026 08:08:52 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.58])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 47C4D180049F; Wed,  1 Jul 2026 08:08:48 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Eric Auger <eric.auger@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH] vfio/listener: Extend safe misalignment check to tpm-ppi
 region
Date: Wed,  1 Jul 2026 10:08:43 +0200
Message-ID: <20260701080843.2418461-1-clg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

On aarch64 hosts with 64K pages, the platform bus MMIO allocator can
allocate the 1KB "tpm-ppi" region at offsets not aligned to the host
page size, triggering a noisy VFIO IOMMU warning at VM startup:

  vfio_listener_valid_section received unaligned region tpm-ppi
    iova=0xc005000 offset_within_region=0x0
    qemu_real_host_page_size=0x10000

Commit 851d6d1a0ff2 ("vfio/common: remove spurious tpm-crb-cmd
misalignment warning") suppressed this for TPM CRB devices via a
TPM_IS_CRB(owner) check. However, this misses "tpm-ppi" regions owned
by other TPM types like SysBus/ISA tpm-tis devices.

Avoid enumerating every TPM device type by matching the "tpm-ppi"
memory region name directly in vfio_known_safe_misalignment().

Signed-off-by: Cedric Le Goater <clg@redhat.com>
---
 hw/vfio/listener.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index c19600e980a8d02217b5d9df4aca8f879ab2c5d5..c76ba285ddb7ef4f93bb081e67de47b3aecbe212 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -355,8 +355,10 @@ static void vfio_ram_discard_unregister_listener(VFIOContainer *bcontainer,
 static bool vfio_known_safe_misalignment(MemoryRegionSection *section)
 {
     MemoryRegion *mr = section->mr;
+    const char *name = memory_region_name(mr);
 
-    if (!TPM_IS_CRB(mr->owner)) {
+    if (!TPM_IS_CRB(mr->owner) &&
+        !(name && strcmp(name, "tpm-ppi") == 0)) {
         return false;
     }
 
-- 
2.54.0



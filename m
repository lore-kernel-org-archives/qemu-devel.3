Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 186D3C982FE
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 00:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9B9a-0004uR-Mn; Tue, 22 Sep 2026 20:48:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1x9B9Z-0004u4-FV
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 20:48:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1x9B9W-0007Ps-J3
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 20:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790124482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=XbckBX6CWc+Vy2dG2X3RfOkZJvpOUpReWlkTKTbKUco=;
 b=ftxObwNbOajPtUI4i/YOwYpdZJckYZo7odTsi++8TzjBU1zFDZVZU/5HP8hMQjjVXLepOv
 5/NnSAeWJ56S+l9bMWPYK3p/gCrB7UOLTJkpVNFUYfgQN24x5ZjbDgJ2n6wXngrS2N4yoP
 xQUyRlAH118iNdIldaQqZRjdtP97tdc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-kf2VhPpFNUWoVsTsV9MU9A-1; Tue,
 22 Sep 2026 20:46:34 -0400
X-MC-Unique: kf2VhPpFNUWoVsTsV9MU9A-1
X-Mimecast-MFC-AGG-ID: kf2VhPpFNUWoVsTsV9MU9A_1790124393
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 541B91944EAA
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 00:46:33 +0000 (UTC)
Received: from mlevitsk-thinkpadt14gen3.ibmmarkh.csb
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6AEAF18005B3; Wed, 23 Sep 2026 00:46:32 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH] accel/kvm: coalesced mmio: check lenght of the MMIO write
 entry
Date: Tue, 22 Sep 2026 20:46:31 -0400
Message-ID: <20260923004631.100997-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

KVM's coalesced mmio ring buffer has entries that contain deffered MMIO
writes.

Each such entry contains the length, an 8 byte value and a guest address.

While the length value comes from the kernel, it is still possible for
an attacker to corrupt the length field using another exploit.

The attacker can then invoke kvm_flush_coalesced_mmio_buffer, which blindly
trusts the length and can be used to inflict further damage.

Add a sanity check on the length field to prevent this.

This patch was only compile tested.

Reported by: "Labs, STAR" <info@starlabs.sg>
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3863
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 accel/kvm/kvm-all.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 83cbd120a847..82898fd89148 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3174,8 +3174,15 @@ void kvm_flush_coalesced_mmio_buffer(void)
 
             ent = &ring->coalesced_mmio[ring->first];
             as = ent->pio == 1 ? &address_space_io : &address_space_memory;
-            address_space_write(as, ent->phys_addr, MEMTXATTRS_UNSPECIFIED,
-                                ent->data, ent->len);
+
+            if (ent->len > sizeof(ent->data)) {
+                warn_report("coalesced MMIO entry has invalid len %u",
+                            ent->len);
+            } else {
+                address_space_write(as, ent->phys_addr, MEMTXATTRS_UNSPECIFIED,
+                                    ent->data, ent->len);
+            }
+
             smp_wmb();
             ring->first = (ring->first + 1) % KVM_COALESCED_MMIO_MAX;
         }
-- 
2.54.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA18CCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 19:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI9eX-0007RP-Ap; Sat, 17 Oct 2026 15:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9dR-0005Yu-8E; Sat, 17 Oct 2026 15:00:04 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xI9dN-000403-R8; Sat, 17 Oct 2026 15:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792263412; bh=89Xk3cst3xlBoAObjfSiAUTAt07Ma4hw6vkcXvBpLfQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=j5p4OGdf1lMIvU2IA+tXyEOV0poQ7GPTxxPqK+2qKo2fIRR208KDCQnh8i2q2S/U0
 ZnxuYqO7EyS+Z7kT/zwR6z5Iyf0yTscbrwMmDY1zKOUkesHb+O1jlxywaFFcnY5ZfU
 WtUxZUrVxyOtrFJQT+kIWzlCzokqbc4mEzLkBLz47P+Z/NZSqZVa3r4h9mhiXfNoy0
 TRtL7eqVBE1/CniVC9F9YCR4arl/LXD74TQJpBC3OsC3lTmYsRxbWIu52Jk2e45Tgw
 jfytshvGsGNPuGej3MxhbGX89PpQzfgoGvGCadFlfJ8ryUaHlYqzzNpe+U+oP/MKxU
 WLLcK4aHST7Ww==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7BA4E1DE6CF;
 Sat, 17 Oct 2026 21:56:52 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id A38B9443397;
 Sat, 17 Oct 2026 21:56:51 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 44/63] accel/kvm: coalesced mmio: check lenght of the
 MMIO write entry
Date: Sat, 17 Oct 2026 21:55:00 +0300
Message-ID: <20261017185528.722197-44-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261017215444@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Maxim Levitsky <mlevitsk@redhat.com>

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
Link: https://lore.kernel.org/r/20260923004631.100997-1-mlevitsk@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 12916d64b78ec5dd0171e607ad2ffcc34537f3cf)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 13d44abb31..9edd64fac7 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2854,9 +2854,15 @@ void kvm_flush_coalesced_mmio_buffer(void)
             AddressSpace *as;
 
             ent = &ring->coalesced_mmio[ring->first];
-            as = ent->pio == 1 ? &address_space_io : &address_space_memory;
-            address_space_write(as, ent->phys_addr, MEMTXATTRS_UNSPECIFIED,
-                                ent->data, ent->len);
+            if (ent->len > sizeof(ent->data)) {
+                warn_report("coalesced MMIO entry has invalid len %u",
+                            ent->len);
+            } else {
+                as = ent->pio == 1 ? &address_space_io : &address_space_memory;
+                address_space_write(as, ent->phys_addr, MEMTXATTRS_UNSPECIFIED,
+                                    ent->data, ent->len);
+            }
+
             smp_wmb();
             ring->first = (ring->first + 1) % KVM_COALESCED_MMIO_MAX;
         }
-- 
2.47.3



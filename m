Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C50C8CCF2CF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB3R-0003FQ-ID; Sat, 17 Oct 2026 16:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB2j-0001PJ-V7; Sat, 17 Oct 2026 16:30:14 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB2i-0004Mv-2o; Sat, 17 Oct 2026 16:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268863; bh=RRSkN6dmkYkm6sMTLPdZFn+BI7d5/T+OeuYo4GeinyE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cTYcHVovotm+BGO0DR87mMYbY5pHNgLOOaGywLIt0VBUYMeRMQJgSViwEdTdOzrXA
 qlkkKMGtbhefKSl1DSy9DzuOc6jA7ayuWlLCiKipkzY7K2rOm5BvU9eXTpPCm3nIz/
 ubAbotW8ndJM1mGQSFAe/2MJ/L8b07HawLKwBzaSIXaLsqedu9plTs2Dza1y9Z8EVX
 eyXr3+HI0i5/JZdzOmTWr1q13L1ALMLZbKAs/z+YemiPeyPHV88XDRwyfoYB/1KXph
 BYgxjR/9SmUo4ulWRpFcNwQMJV/qchR01L7vHZFpqeH0d1efxgSZIsQ91o3gR/Fgd9
 YPRn2tBr6kNpw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 30BB51DE763;
 Sat, 17 Oct 2026 23:27:43 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4AAEC443437;
 Sat, 17 Oct 2026 23:27:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 37/73] accel/kvm: coalesced mmio: check lenght of the
 MMIO write entry
Date: Sat, 17 Oct 2026 23:25:55 +0300
Message-ID: <20261017202638.728621-37-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
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
index da3afdc68d..5433a223e3 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3185,9 +3185,15 @@ void kvm_flush_coalesced_mmio_buffer(void)
             const AddressSpace *as;
 
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7EACCFA05
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 11:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGbzF-0006cT-RU; Wed, 05 Nov 2025 06:47:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vGbyU-0005tY-JD
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 06:46:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1vGbyR-0003fB-Ty
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 06:46:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762343206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TdPL9uIhQICvUXMZRqohjzNZ3rdqxelbqFx+NwG8wN8=;
 b=gKccsWvhSVyKUeAQ8VlLZxS2WEWlnMt9RVo4CefwD0rxoTMp/UhVTiGT+8h/0ZBTOv6cTv
 7cyqbmL0vsIfpAfpOhg+mDr7eP56fPnrdHqf/RiSKhHdHwHxN5WGSH3pTB4ba3bFLBEcCt
 gtTwjND6j468Wb+ZEibfBISpRRJaH6c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-6tyzGIASN9qWIGWNLaxHXw-1; Wed,
 05 Nov 2025 06:46:45 -0500
X-MC-Unique: 6tyzGIASN9qWIGWNLaxHXw-1
X-Mimecast-MFC-AGG-ID: 6tyzGIASN9qWIGWNLaxHXw_1762343204
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 031FE1956089; Wed,  5 Nov 2025 11:46:44 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.rmtau.csb (unknown [10.64.136.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CFED41800451; Wed,  5 Nov 2025 11:46:38 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 mchehab+huawei@kernel.org, gengdongjiu1@gmail.com, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, peter.maydell@linaro.org,
 pbonzini@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v3 7/8] kvm/arm/kvm: Introduce helper push_ghes_memory_errors()
Date: Wed,  5 Nov 2025 21:44:52 +1000
Message-ID: <20251105114453.2164073-8-gshan@redhat.com>
In-Reply-To: <20251105114453.2164073-1-gshan@redhat.com>
References: <20251105114453.2164073-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
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

Introduce helper push_ghes_memory_errors(), which sends ACPI GHES memory
errors and injects SEA exception. With this, we can add more logics to
the function to support multiple ACPI GHES memory errors in the next
path.

No functional changes intended.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 target/arm/kvm.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index a889315606..5b151eda3c 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2429,12 +2429,23 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
     return ret;
 }
 
+static void push_ghes_memory_errors(CPUState *c, AcpiGhesState *ags,
+                                    uint64_t paddr, Error **errp)
+{
+    uint64_t addresses[16];
+
+    addresses[0] = paddr;
+
+    kvm_cpu_synchronize_state(c);
+    acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC, addresses, 1, errp);
+    kvm_inject_arm_sea(c);
+}
+
 void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
 {
     ram_addr_t ram_addr;
     hwaddr paddr;
     AcpiGhesState *ags;
-    uint64_t addresses[16];
 
     assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
 
@@ -2455,12 +2466,8 @@ void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
              * later from the main thread, so doing the injection of
              * the error would be more complicated.
              */
-            addresses[0] = paddr;
             if (code == BUS_MCEERR_AR) {
-                kvm_cpu_synchronize_state(c);
-                acpi_ghes_memory_errors(ags, ACPI_HEST_SRC_ID_SYNC,
-                                        addresses, 1, &error_abort);
-                kvm_inject_arm_sea(c);
+                push_ghes_memory_errors(c, ags, paddr, &error_abort);
             }
             return;
         }
-- 
2.51.0



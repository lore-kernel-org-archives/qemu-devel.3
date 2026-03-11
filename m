Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60CCC112584D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LLd-0002bF-S7; Wed, 11 Mar 2026 11:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w0LLG-00022Q-1o; Wed, 11 Mar 2026 11:19:26 -0400
Received: from sender4-of-o54.zoho.com ([136.143.188.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anirudh@anirudhrb.com>)
 id 1w0LLC-000101-8Q; Wed, 11 Mar 2026 11:19:21 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1773242222; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=DO4PW5W2ShrFy4NjoZsDG7h/RIIVttsxGwm9HgMqM05oNqY5KD7SIfyQnIZYPFPNuapZ+ai304LLq22UeOT83i3AO2eK8KkN5bhLBV+CuX7BDKUkMBnFGysULgOnT/8lZdG03JEA2BcdVkgeAHFEQQ3Y3vBiDN8HL7zfRrrhD1c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773242222;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=tl1TuVW379TWu0X8kuo6XYGo0xIhPshRyx52O0YMWKo=; 
 b=ShXEGOsyPkhmNifQPgPzsUxuiLobF4Grf82JDT4dUPrVQXNFYneC+28eKxpWMaoCBDt8heBESwJvthEsYT2SKcGZoTEbqvlTZUSQsDP6x8ZepAz/oKHSzyRaXsSqZId4Y8JmYgbas0EtBgFu5HFC8fzatFSJu4QFWdy7eSDeDQg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=anirudhrb.com;
 spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
 dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773242222; 
 s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=tl1TuVW379TWu0X8kuo6XYGo0xIhPshRyx52O0YMWKo=;
 b=St0EE1lYutVgLwiMPIP6ZMOgY56UvykaJFZI+vIp1KJ9FtX7QEM+vbL6Pt9+d+5o
 9rt+VufKOwEz2q5Gosa5XLOVUKbqMB/n6U7VJi/dyIa6e8juqnAgF050wB2I9TaKJLW
 ISvqXpj7JGhGRKsOVodiB+v+RZbDFNq9pAbh3ew4=
Received: by mx.zohomail.com with SMTPS id 1773242220986933.1361530940103;
 Wed, 11 Mar 2026 08:17:00 -0700 (PDT)
From: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>
Date: Wed, 11 Mar 2026 15:15:39 +0000
Subject: [PATCH 12/14] include/hw/hyperv: adjust hv_interrupt_control
 structure for arm64
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-mshv_accel_arm64_supp-v1-12-c31699b7bc1f@anirudhrb.com>
References: <20260311-mshv_accel_arm64_supp-v1-0-c31699b7bc1f@anirudhrb.com>
In-Reply-To: <20260311-mshv_accel_arm64_supp-v1-0-c31699b7bc1f@anirudhrb.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>, 
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Anirudh Rayabharam <anirudh@anirudhrb.com>, 
 Aastha Rawat <aastharawat@linux.microsoft.com>, qemu-arm@nongnu.org
X-Mailer: b4 0.14.3
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.54;
 envelope-from=anirudh@anirudhrb.com; helo=sender4-of-o54.zoho.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add the arm64 specific fields to the hv_interrupt_control struct and
adjust the existing usage accordingly. mshv_request_interrupt is only
needed only for x86 so compile it out entirely for arm64.

Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
---
 accel/mshv/irq.c               |  2 ++
 include/hw/hyperv/hvgdk_mini.h | 25 +++++++++++++++++++++++++
 include/system/mshv.h          |  2 ++
 3 files changed, 29 insertions(+)

diff --git a/accel/mshv/irq.c b/accel/mshv/irq.c
index 3c238c33c3..a391d7db86 100644
--- a/accel/mshv/irq.c
+++ b/accel/mshv/irq.c
@@ -310,6 +310,7 @@ int mshv_irqchip_update_msi_route(int virq, MSIMessage msg, PCIDevice *dev)
     return 0;
 }
 
+#if defined(__x86_64__)
 int mshv_request_interrupt(MshvState *mshv_state, uint32_t interrupt_type, uint32_t vector,
                            uint32_t vp_index, bool logical_dest_mode,
                            bool level_triggered)
@@ -346,6 +347,7 @@ int mshv_request_interrupt(MshvState *mshv_state, uint32_t interrupt_type, uint3
     }
     return 0;
 }
+#endif
 
 void mshv_irqchip_commit_routes(void)
 {
diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
index 84b3c6af5f..eb766734d6 100644
--- a/include/hw/hyperv/hvgdk_mini.h
+++ b/include/hw/hyperv/hvgdk_mini.h
@@ -506,13 +506,38 @@ typedef struct hv_input_set_vp_registers {
     struct hv_register_assoc elements[];
 } hv_input_set_vp_registers;
 
+enum hv_interrupt_type {
+#if defined(__x86_64__)
+    HV_X64_INTERRUPT_TYPE_FIXED             = 0x0000,
+    HV_X64_INTERRUPT_TYPE_LOWESTPRIORITY    = 0x0001,
+    HV_X64_INTERRUPT_TYPE_SMI               = 0x0002,
+    HV_X64_INTERRUPT_TYPE_REMOTEREAD        = 0x0003,
+    HV_X64_INTERRUPT_TYPE_NMI               = 0x0004,
+    HV_X64_INTERRUPT_TYPE_INIT              = 0x0005,
+    HV_X64_INTERRUPT_TYPE_SIPI              = 0x0006,
+    HV_X64_INTERRUPT_TYPE_EXTINT            = 0x0007,
+    HV_X64_INTERRUPT_TYPE_LOCALINT0         = 0x0008,
+    HV_X64_INTERRUPT_TYPE_LOCALINT1         = 0x0009,
+    HV_X64_INTERRUPT_TYPE_MAXIMUM           = 0x000A,
+#elif defined(__aarch64__)
+    HV_ARM64_INTERRUPT_TYPE_FIXED           = 0x0000,
+    HV_ARM64_INTERRUPT_TYPE_MAXIMUM         = 0x0008,
+#endif
+};
+
 union hv_interrupt_control {
     uint64_t as_uint64;
     struct {
         uint32_t interrupt_type; /* enum hv_interrupt type */
+#if defined(__x86_64__)
         uint32_t level_triggered:1;
         uint32_t logical_dest_mode:1;
         uint32_t rsvd:30;
+#elif defined(__aarch64__)
+        uint32_t rsvd1:2;
+        uint32_t asserted:1;
+        uint32_t rsvd2:29;
+#endif
     };
 };
 
diff --git a/include/system/mshv.h b/include/system/mshv.h
index 75286baf16..0db18fcee9 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -47,10 +47,12 @@ extern bool mshv_allowed;
 typedef struct MshvState MshvState;
 extern MshvState *mshv_state;
 
+#if defined(__x86_64__)
 /* interrupt */
 int mshv_request_interrupt(MshvState *mshv_state, uint32_t interrupt_type, uint32_t vector,
                            uint32_t vp_index, bool logical_destination_mode,
                            bool level_triggered);
+#endif
 
 int mshv_irqchip_add_msi_route(int vector, PCIDevice *dev);
 int mshv_irqchip_update_msi_route(int virq, MSIMessage msg, PCIDevice *dev);

-- 
2.43.0



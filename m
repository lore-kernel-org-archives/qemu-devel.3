Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE87C25B5C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 11:47:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3woY-0003tb-7C; Mon, 06 May 2024 07:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wmd-0001zc-FV
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:45:30 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wmb-00020C-RZ
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RdZxbvcd9Ww/IUgTe96WN9PtS1C0KS34Ir6CDMqHT3w=; b=eSLEXoiEeyU6/sSFs/Rl2fZDRM
 HPDH85q9hKY9+gzyehL8F0rfjMiHVYVHMQqwOO69fmc/oTZ4eKywwtjWE1FBYkjtBTOnJvHhvRZZZ
 08g/IqedpWspxer5c7I6U8qNf11KtAD2UMqNAza/dY0s1Dwp2DP9RK193JDXRujDaj0Y4afmLiRhn
 ZauWIrkiJ8KH34cmB2IkGrqBTGoRMXFJuxGwXofAX1q81KCex6PxlV2b4e+RZsf+hDNSPSY5kPZJp
 d1hAowwQE+cTMylGzoy+TXhsAwH+K8WtYRMdRDrYjyDPlWPxQVvuKuMc8qeMr4g9ZM6CaD8t2ph87
 iFvLGqxq+ywGbMzFh8QUN5tqh8ANl+wcnDVVlvvMtwcH4PybN341ZQn5Mv8lamuZm0OsMkIj3DdQr
 /7+F9dKRLF382YlB2pCpzfaxoWlSU7YouwKDfP/npTeR6b0Y/9vrSUikK9ZMh7YM6i9eamlqttnKF
 DKkeugapNv00Kb7k+5gQn1KuiLIiWaE1ywMnnv9ZZNmnQDcoFBf1Li2/FKJtt/M6NsqgX9NArBjEJ
 jAJLa5wt9lo5efnvI6bUFfFLthC42a5VC00nK+hdoX5gg3l2AhXLUh1Ye0roTBhTxiWxQdHUn+sfi
 0jQakl7E2eiobiJOpHHoOiSnd0sZMyLtH7BQ0YvTo=;
Received: from [2a00:23c4:8bb4:4000:b60d:a162:d698:c802]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1s3wlS-0005pA-Eq; Mon, 06 May 2024 12:44:18 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Date: Mon,  6 May 2024 12:44:44 +0100
Message-Id: <20240506114451.331311-6-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240506114451.331311-1-mark.cave-ayland@ilande.co.uk>
References: <20240506114451.331311-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:b60d:a162:d698:c802
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 05/12] hw/sparc64: set iommu_platform=on for virtio devices
 attached to the sun4u machine
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The sun4u machine has an IOMMU and therefore it is possible to program it such
that the virtio-device IOVA does not map directly to the CPU physical address.

This is not a problem with Linux which always maps the IOVA directly to the CPU
physical address, however it is required for the NetBSD virtio driver where this
is not the case.

Set the sun4u machine defaults for all virtio devices so that disable-legacy=on
and iommu_platform=on to ensure a default configuration will allow virtio
devices to function correctly on both Linux and NetBSD.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20240418205730.31396-1-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/sparc64/sun4u.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index cff6d5abaf..4ece1ac1ff 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -793,6 +793,12 @@ static void sun4v_init(MachineState *machine)
     sun4uv_init(get_system_memory(), machine, &hwdefs[1]);
 }
 
+static GlobalProperty hw_compat_sparc64[] = {
+    { "virtio-pci", "disable-legacy", "on", .optional = true },
+    { "virtio-device", "iommu_platform", "on" },
+};
+static const size_t hw_compat_sparc64_len = G_N_ELEMENTS(hw_compat_sparc64);
+
 static void sun4u_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -810,6 +816,7 @@ static void sun4u_class_init(ObjectClass *oc, void *data)
     mc->default_nic = "sunhme";
     mc->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
     fwc->get_dev_path = sun4u_fw_dev_path;
+    compat_props_add(mc->compat_props, hw_compat_sparc64, hw_compat_sparc64_len);
 }
 
 static const TypeInfo sun4u_type = {
-- 
2.39.2



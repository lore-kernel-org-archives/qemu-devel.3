Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AC6107BCD0
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 17:04:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15vD-0005jG-Kn; Fri, 13 Mar 2026 13:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.69b43f94.v1-69a179cf209f4f279f3821309798888a@bounce.vates.tech>)
 id 1w15v3-0005i4-RI
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 13:03:26 -0400
Received: from mail179-36.suw41.mandrillapp.com ([198.2.179.36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.69b43f94.v1-69a179cf209f4f279f3821309798888a@bounce.vates.tech>)
 id 1w15uu-0000hI-E4
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 13:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
 s=mte1; t=1773420436; x=1773690436;
 bh=tBqT15VgX6aHPkE4gLQnkO0oJx1PmUhyS6eAmAg6IcA=;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=GX5lVS29RUTKr/vbIVOLwFzgCUUFqxSTOIUfJoV4hu8dmQbu4bIFWZvsVBzTHy705
 c7CbqOt5zCXc+RADwUEFKsp7IhgxU4LszeIRGWb04GkkMdzeMtWgY3BUhlKenWhGU+
 ckx68gKYyJvt/kvLkjh7u432Br5QvCD1DnZAM8zIYYHVDaAtoccCow8c1w24rTJEc+
 L1GTcfQu567K9NAIDHe1cuC14Sn2Zsx0fQIQuEIgE0X+1ME6n5Y6Hwni4cg6qzidNe
 MCD3mW3jj4q8jnINAFrR1TE/7MYUmQNDgZvyairJ0wY4g0Vj460xeC+m9cktaHeHGM
 KlvQMXMDfLcHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
 t=1773420436; x=1773680936; i=thierry.escande@vates.tech;
 bh=tBqT15VgX6aHPkE4gLQnkO0oJx1PmUhyS6eAmAg6IcA=;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=IKvtfnlQuiiJnkVOazyhGMevNQOw1IbmwXhVJ+rkVMRg8YN18RLN3qm6mN6H5FJzo
 GVjDkvZRx8JWrq2jL4IiuPKUTWsrmYgO8WeaAV+6wt9Gm5paIBDh9X6u/Pjo5TVVeQ
 FnHiM6+siNRiJgZ3bC+N4RYkY2aWkPXBt0FWc0woKXD4IlMuE2iJICHJtMM5jnDor7
 9xaMX12kSskk4dQyohROhI5GC4IIbnWIDsk3fMl8ConzdyjBI9hgOBpjXYOkFsm++L
 e6febQyGMYropNNEGkfGa5XnPI261xljXJ+gg8hoxgEDX/hyYIi/qVOvBu0QH5zYBY
 kv62fwCxdzYOA==
Received: from pmta12.mandrill.prod.suw01.rsglab.com (localhost [127.0.0.1])
 by mail179-36.suw41.mandrillapp.com (Mailchimp) with ESMTP id 4fXVl85nHrzlfcWR
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 16:47:16 +0000 (GMT)
From: "Thierry Escande" <thierry.escande@vates.tech>
Subject: =?utf-8?Q?[PATCH=203/4]=20q35:=20Fix=20incorrect=20values=20for=20PCIEXBAR=20masks?=
Received: from [37.26.189.201] by mandrillapp.com id
 69a179cf209f4f279f3821309798888a; Fri, 13 Mar 2026 16:47:16 +0000
X-Mailer: git-send-email 2.51.0
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1773420435540
To: qemu-devel@nongnu.org
Cc: "Alexey Gerasimenko" <x1917x@gmail.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, "Eduardo Habkost" <eduardo@habkost.net>,
 "Anthony PERARD" <anthony@xenproject.org>, xen-devel@lists.xenproject.org,
 "Thierry Escande" <thierry.escande@vates.tech>
Message-Id: <20260313164649.794591-4-thierry.escande@vates.tech>
In-Reply-To: <20260313164649.794591-1-thierry.escande@vates.tech>
References: <20260313164649.794591-1-thierry.escande@vates.tech>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,
 =20including=20all=20headers,
 =20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.69a179cf209f4f279f3821309798888a?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20260313:md
Date: Fri, 13 Mar 2026 16:47:16 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.2.179.36;
 envelope-from=bounce-md_30504962.69b43f94.v1-69a179cf209f4f279f3821309798888a@bounce.vates.tech;
 helo=mail179-36.suw41.mandrillapp.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
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

From: Alexey Gerasimenko <x1917x@gmail.com>

There are two small issues in PCIEXBAR address mask handling:
- wrong bit positions for address mask bits (see PCIEXBAR description
  in Q35 datasheet)
- incorrect usage of 64ADR_MASK

Due to this, attempting to write a valid PCIEXBAR address may cause it
to shift to another address, causing memory layout corruption where
emulated MMIO regions may overlap real (passed through) MMIO ranges. Fix
this by providing correct values.

Signed-off-by: Alexey Gerasimenko <x1917x@gmail.com>
Signed-off-by: Thierry Escande <thierry.escande@vates.tech>
---
 hw/pci-host/q35.c         | 6 +++---
 include/hw/pci-host/q35.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index e85e4227b3..7368e3c598 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -306,12 +306,12 @@ static void mch_update_pciexbar(MCHPCIState *mch)
         break;
     case MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_128M:
         length = 128 * 1024 * 1024;
-        addr_mask |= MCH_HOST_BRIDGE_PCIEXBAR_128ADMSK |
-            MCH_HOST_BRIDGE_PCIEXBAR_64ADMSK;
+        addr_mask |= MCH_HOST_BRIDGE_PCIEXBAR_128ADMSK;
         break;
     case MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_64M:
         length = 64 * 1024 * 1024;
-        addr_mask |= MCH_HOST_BRIDGE_PCIEXBAR_64ADMSK;
+        addr_mask |= MCH_HOST_BRIDGE_PCIEXBAR_64ADMSK |
+            MCH_HOST_BRIDGE_PCIEXBAR_128ADMSK;
         break;
     case MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_RVD:
         qemu_log_mask(LOG_GUEST_ERROR, "Q35: Reserved PCIEXBAR LENGTH\n");
diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
index ddafc3f2e3..f31a71010b 100644
--- a/include/hw/pci-host/q35.h
+++ b/include/hw/pci-host/q35.h
@@ -100,8 +100,8 @@ struct Q35PCIHost {
 #define MCH_HOST_BRIDGE_PCIEXBAR_DEFAULT       0xb0000000
 #define MCH_HOST_BRIDGE_PCIEXBAR_MAX           (0x10000000) /* 256M */
 #define MCH_HOST_BRIDGE_PCIEXBAR_ADMSK         Q35_MASK(64, 35, 28)
-#define MCH_HOST_BRIDGE_PCIEXBAR_128ADMSK      ((uint64_t)(1 << 26))
-#define MCH_HOST_BRIDGE_PCIEXBAR_64ADMSK       ((uint64_t)(1 << 25))
+#define MCH_HOST_BRIDGE_PCIEXBAR_128ADMSK      ((uint64_t)(1 << 27))
+#define MCH_HOST_BRIDGE_PCIEXBAR_64ADMSK       ((uint64_t)(1 << 26))
 #define MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_MASK   ((uint64_t)(0x3 << 1))
 #define MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_256M   ((uint64_t)(0x0 << 1))
 #define MCH_HOST_BRIDGE_PCIEXBAR_LENGTH_128M   ((uint64_t)(0x1 << 1))
-- 
2.51.0



--
Thierry Escande | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech



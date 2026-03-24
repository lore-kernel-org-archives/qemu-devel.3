Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A989FEC0FC
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 20:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w58hB-00015N-CA; Tue, 24 Mar 2026 16:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w58h8-0000wi-Vw
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 16:49:47 -0400
Received: from p-west2-cluster2-host5-snip4-8.eps.apple.com ([57.103.68.231]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w58h7-0004ho-GL
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 16:49:46 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-0 (Postfix) with ESMTPS id
 93D421800462; Tue, 24 Mar 2026 20:49:40 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774385384; x=1776977384;
 bh=QB3B8N7SFrVJgVcgwhULIchHgcpWoIrdxwvNpW8E5hE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=HdkqfjpoJOhfaMK5asqn5ZzDzt6Rhp0s7Sg/kKZTx59IIQESxiFDHyKEkbYXBTHNTZILqkRn3l9fUr8P+Lh9uKf9zkOo2BFZ7DxVUol1Iubc+EV2E0Gs5I0K7TnxaTctoDga3OxYGMBZFvOvH9Y56OR4dWE0vbE3/EkxZ8Rr6ACLtbTAHMi1MDv/bmk9QmH2gFJdKi2VRplIEmspdtuCy67K0PhKwfUCWIFjQGg4xyE5x6cOJ3gKmehuBeHjjCvDpBVDZbrBSvLBdvWu8eFsRGb5SHWHBrfNaIBTztyQyQK+W0X15WSO45KiafBLn08FXTdzkzbFJu+UvHmxhAVrUA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-0 (Postfix) with ESMTPSA id
 D30C61800472; Tue, 24 Mar 2026 20:49:35 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Peter Xu <peterx@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Roman Bolshakov <rbolshakov@ddn.com>,
 Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [RFC PATCH v7 6/7] vmapple, gicv2m: add macOS compat quirk
Date: Tue, 24 Mar 2026 21:48:54 +0100
Message-ID: <20260324204855.29759-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260324204855.29759-1-mohamed@unpredictable.fr>
References: <20260324204855.29759-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE2MSBTYWx0ZWRfX/OV3G5zIHjeZ
 hazn5XBwuJbUkeDVNic4WIFH0/a0WYHYBDGZJxp4YG4sJqZ+frNHhsZUrauwg6T+cfMdP3CiMlV
 LPjVU6sMnI3S5KdgY7Z2ttf8Ex6YB0BddQmRwa0wcyMM3gWR87eRP4y94upLN4FcmgLML7jQsnc
 UIKUx79sE7rduembhg4R5qd2A//JR5BsjRNPT54FCiJLXEU9x5EZI3FIx4z2Ty1GScA2sveC/Gf
 3Go0Snuxldo5wNKsvSey0wKRi7nfmStcIc6EfTUGfAjsKh07HvaTi2RvV1GVrPOR2/jKn2lCwwg
 lxcIj4GCAgKIFE25fWDKWFC0enCyvbyV8KAUg2kPmMOwhAfCkyRBDhwz0f6qig=
X-Proofpoint-GUID: R4YtHuzrzNSTSpmdQH9hrvtV3DpQgUZJ
X-Proofpoint-ORIG-GUID: R4YtHuzrzNSTSpmdQH9hrvtV3DpQgUZJ
X-Authority-Info-Out: v=2.4 cv=J6qnLQnS c=1 sm=1 tr=0 ts=69c2f8e6
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=k7I_zsxD337gQve_B7IA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=849 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxscore=0 clxscore=1030 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603240161
Received-SPF: pass client-ip=57.103.68.231;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

macOS expects bit 31 of MSI_TYPER to be set.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 hw/intc/arm_gicv2m.c | 5 +++++
 hw/vmapple/vmapple.c | 1 +
 2 files changed, 6 insertions(+)

diff --git a/hw/intc/arm_gicv2m.c b/hw/intc/arm_gicv2m.c
index b343e17ca5..ead1d9d079 100644
--- a/hw/intc/arm_gicv2m.c
+++ b/hw/intc/arm_gicv2m.c
@@ -57,6 +57,7 @@ struct ARMGICv2mState {
 
     uint32_t base_spi;
     uint32_t num_spi;
+    uint32_t macos_compat;
 };
 
 static void gicv2m_set_irq(void *opaque, int irq)
@@ -81,6 +82,9 @@ static uint64_t gicv2m_read(void *opaque, hwaddr offset,
     case V2M_MSI_TYPER:
         val = (s->base_spi + 32) << 16;
         val |= s->num_spi;
+        if (s->macos_compat) {
+            val |= BIT(31);
+        }
         return val;
     case V2M_MSI_IIDR:
         /* We don't have any valid implementor so we leave that field as zero
@@ -173,6 +177,7 @@ static void gicv2m_init(Object *obj)
 static const Property gicv2m_properties[] = {
     DEFINE_PROP_UINT32("base-spi", ARMGICv2mState, base_spi, 0),
     DEFINE_PROP_UINT32("num-spi", ARMGICv2mState, num_spi, 64),
+    DEFINE_PROP_UINT32("macos-compat", ARMGICv2mState, macos_compat, 0),
 };
 
 static void gicv2m_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
index f2a6fda2e5..e68b623c5b 100644
--- a/hw/vmapple/vmapple.c
+++ b/hw/vmapple/vmapple.c
@@ -301,6 +301,7 @@ static void create_gicv2m(VMAppleMachineState *vms)
     dev = qdev_new("arm-gicv2m");
     qdev_prop_set_uint32(dev, "base-spi", irq);
     qdev_prop_set_uint32(dev, "num-spi", NUM_GICV2M_SPIS);
+    qdev_prop_set_uint32(dev, "macos-compat", 1);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VMAPPLE_GICV2M].base);
 
-- 
2.50.1 (Apple Git-155)



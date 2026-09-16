Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E1E2C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 10:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6mSV-0000Gm-9g; Wed, 16 Sep 2026 06:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x6mRi-00088A-EC
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:00:58 -0400
Received: from qs-2003k-snip6-1.eps.apple.com ([2a01:b747:3006:204::68]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x6mRg-0005Ff-Hb
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 06:00:54 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-8 (Postfix) with ESMTPS id
 B37841800BCF; Wed, 16 Sep 2026 10:00:48 +0000 (UTC)
X-ICL-RepId: 01a0a9a9-6f0a-7e8e-8215-5dda3f8eb3ce
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0IShMFUgddTVYNRw9YHlwUFwlAQ14IXh9MHB0OWAYSAE0KDjYGWQVeCVYDQwU2EhRdRUYDRxlXFFAbRwxVB1deXwoTAF4PD0wLSAFbB1IDRghIA10FWhxHCkABWBpaAl1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIHWEcURw4PE0wLRwJaNFYfVBlaAw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1789552851; x=1792144851;
 bh=+9RJGRbMENE6HFIHE0Ze2Tr+1IRKcLOn/xT+W7qDSus=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=xWhx6sEXXAGpY24G0zaZRHquIXXL71bsXCBlwXrEnBWtMqjILC2jFP3TV8SgYVX4bv7KxtKT1AbreTs4lfwqbegCOz81xVFpWxvm0vS8D2U9FzxEnL0+IbjGBYba4jg0K3W2j+PRR1jsQGzajmPj+zWnQpz7OjbDTzCyPbQuZwPcpkV3tMORLApGDpW7MCwCj+0mpZifGS+0a+oDjpWkfHAC6OEkBKz2Ag2yjJm9RnXJiAmCnJbiFjWhUCBxOdxMItVVg64YSo6XSk5ZzXJy8aBSJov8p0ygGP+OmMHYw64E5qKaIRAPgWJ5f8dsq3XqJImnfqMlQNotVtAD8gmF5w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-8 (Postfix) with ESMTPSA id
 A0FA018009EA; Wed, 16 Sep 2026 10:00:46 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v8 09/10] vmapple, gicv2m: add macOS compat quirk
Date: Wed, 16 Sep 2026 12:00:17 +0200
Message-ID: <20260916100021.73825-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916100021.73825-1-mohamed@unpredictable.fr>
References: <20260916100021.73825-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: YXLEMC356AQdTEp13BMOYdc-aHPcMoVM
X-Proofpoint-GUID: YXLEMC356AQdTEp13BMOYdc-aHPcMoVM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDEzMCBTYWx0ZWRfX5ZrpeGiF4s4Y
 bgIBvo3DTS+mj0p+eAGC2lNj7iWgqHMSel+CbdHaNg6sv0JcLLq9MohYvaQ/XSRwsV7YlyjrVu7
 f6ZGj1u03ID69jl9f/fiTkeU8DDALXTNa035FMUmXYCwOu+ih6e1djgNsXwQ7W/JGxutWx6oPow
 47GePLBJY7eFaSQ6gW8GiAYEH3XCrAMOyGDAs6PBRNsZIg5eL8QvlejhuiqGctqDrgUMbdKoC7l
 sduDMT1cOa/vCZNU4UQpV3Snq1y2Uqh+L7GzV/TfwKdTXqr3Q4jo6AOke6p4ihY+LyCf8+1gDs9
 r1XvyEKxY1ITaUUc+ynIqk+q8WzB8GmX+VNmfd9mwtc7m5cOzHTFSjAjWL/A38=
X-Authority-Info-Out: v=2.4 cv=H67WAuYi c=1 sm=1 tr=0 ts=6aaa68d1
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gOpaI4mCDWYJJ-FYbkA:9
X-JNJ: AAAAAAABYh5AWrTdkw0t0bnDBSbjQA6qAdbjmG3JRPBZiZIRn1c7lbMGOiy6TZFehoNffJKTZ4bJ8yrUSdr1tLmBgbLjY2s6e0FNsDapkQkZ/iazHr5PCr0eHflMmToXElvnOTRp913mN9yiBBtGDx5hJV/0K6aaAuzd7tLE8JvecSXgZXz8SYJBvd7cuIr7hm1OiZBaOjtiuNJHd5a7kmu8tnROorPXTodtevtHW96XR3JuswbElZe8HyLC0X7DWHHB2Bw8YP43JsHQ8xCagCX200qzFYUuJVQaP6gbrCfRU/DW0P1j51rfMxgCCK9BBsUc8NsELPWSPQxaPrK7WOx6Vq1xt6IKBoJjnp3ihTg5AiwhFb6sKP4moV/KoGHR3DHx53e0beepVfXscs0tGoXu+nh2sivu65CfZ27BwqaKpPtBEENvyjED0q6qShqe4jF0FZLEbVd2QFpV857QAfjMPkeHI5kMWcBHvMBQO3oJbMDpQSFIeq4sN+s9AYAWmpGDfiouS9uTPcofegq8R7sqx8pRZ6cr/153/bhe+7TQ98eva5B4/3fdsUHv4BeN3mZm8cPIU4IT3AXHRnw4JUREQrJg+zn77Qvw3vQEu3hmIqpS7r/UAST6fwkeKc9Eo+RFJ0yhisM+bBD8XiB7B7H/7A4K9144ZflGhSrFxe1CSTX7dMKWXAVN0vWTHtbN5/fWVGg2JLS4Jfwv1jTJctGcY8oXHJIs3cYtSqAC9Kc/Tjd299TFi4Ar9sPXhV9HsWERkGfqvyEkxDgT/mRh2cuSMfIvkdvZ9D+aYtrsh891c+Rc6vm13qY+lpvLhAiQHyHUB1m+SIGAk3pdF9X9veTjvfQ=
Received-SPF: pass client-ip=2a01:b747:3006:204::68;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
index b343e17ca5..10598d8d50 100644
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
+    DEFINE_PROP_UINT32("x-macos-compat", ARMGICv2mState, macos_compat, 0),
 };
 
 static void gicv2m_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/vmapple/vmapple.c b/hw/vmapple/vmapple.c
index 2467c79ab3..072a49ac4f 100644
--- a/hw/vmapple/vmapple.c
+++ b/hw/vmapple/vmapple.c
@@ -299,6 +299,7 @@ static void create_gicv2m(VMAppleMachineState *vms)
     dev = qdev_new("arm-gicv2m");
     qdev_prop_set_uint32(dev, "base-spi", irq);
     qdev_prop_set_uint32(dev, "num-spi", NUM_GICV2M_SPIS);
+    qdev_prop_set_uint32(dev, "x-macos-compat", 1);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VMAPPLE_GICV2M].base);
 
-- 
2.54.0 (Apple Git-157)



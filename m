Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A54C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 18:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfMLP-0007aS-5I; Thu, 02 Jul 2026 14:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wfMLK-0007K6-KT
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:40:58 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wfMLE-0005UT-Qh
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:40:58 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-493b68b4643so12989635e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 11:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783017650; x=1783622450; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UUNZ/LM026A5WYcYSy2SVFfc7Tu09tsw26gWqws57nw=;
 b=XGWk90IhiB+nMtILpPEhTbYDUPF2oIOQ1xdzivFJvbAnuw7s4MghyJXWHQUJCRn8ab
 EVjI8+7+0eYNx0+KDjdDozWzEB7YRvPih/7PVwiIn9WVVWQU4v1SE5ioivueuDBxIgep
 OjCdyNRBS6yRA0gXREb9oC083S3mE0fGX3OQW1BYh5ndSnYpuqvww8w5w4cAd5U2GFMZ
 s8/y43k8IZOn69olObwcgZDT99Lw08AgGsNPU1dGFb8TNaaitaOSTOJX3cbKNLElK80/
 KS6a6c+wlR6CUwHdXNWtKFnJm8BRqSFx2JFao2VaaK6g/PJF1mbvLhciZWznanlUYowE
 bbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783017650; x=1783622450;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UUNZ/LM026A5WYcYSy2SVFfc7Tu09tsw26gWqws57nw=;
 b=g8OE54LJPpcLSlUw2x3uo6hzIJzRimG1KHNRqFA4wx5hlOEMBZDSG57t7Gmz0guWIR
 5HC0RLMfHXs4e3aBobHxIGQ2TucUkoAlKcHoVsTZjdPgVzZYbi0l/Q9q8hRNFfz5XtIa
 poM9eRo8x/mp6eKtUo1z92Aqh5nv+HYwRnGzpbeYH79uRX6JHX2I9Mn46raRtWx5yJX8
 SPTACiKMpk8VFwnXIOyM+WTBLxPkJTxC9VOhkrP+BjfdNXxFmZccQDa/BoltyPASfwgs
 UpyxLFi96rKrdTa5vvsmRIVXeFeIZj8wpmDXLhtnH+aR8xAWfRLKaQCIv68fXAsohDsZ
 Vkpg==
X-Gm-Message-State: AOJu0YyOboaI9ZdDi2JcPLeguL2fVzw/DlCWFlfTC+VnEZlV+A0jO5Jq
 ZrFfMo/ckDJbVoj7FZijcZ/PzO17WtErphzGI7dz/ALnQLVLQ2ZI3cdKY/x4Uw==
X-Gm-Gg: AfdE7clhfpqO5C//KcT04JG6OXADBQKOWvW8BGkZwrmq2fhnfGmpGEs0aT/0dPFYY7q
 dRL3JnHQ8TYZf/5j183OkZ+B8J+uj8IRe7gce59nnrcPoYJW+Q6JWocQBXsWcxoCJ1U5op18wO4
 NvmmwR9mI89JXJ6BiHGZfejG7KAIQWYoW1EVX7EmDxGpep2phSOhMUCmgW95Wye2uZbFo1SDZuP
 wy3tRnY5ZjV7E3WKswpSiCX4Ta0m8KvjL8Xqzj2X2KZS0wcd4vnUImXje9vi6AG+lAnsQZTYlJQ
 O074KmBLOtCHcuoS+rTjVzGvKXK2XnlEqRVjRVkO89jE+3ughgE+5Y0abL6SK4KT1ljlfMnj3kj
 SxX4HKGRu1ud0HII4Jr3VAuxFTXe2ktaAuj7qzjNdlfcs3qQ98bxgLVfOwXiZhGI73DCUImcn24
 bZyg3TqCIYXlfii6UAM9rCJ8HPB3jx7nOGk27FVahi30aTNHcpNPLfpD07gevRBZDwQfB2Ts9mo
 x1YjK2cATbCjkBy27Iln8PA7P8xWfp2Jvri
X-Received: by 2002:a05:600c:218e:b0:490:b7e6:bd1d with SMTP id
 5b1f17b1804b1-493c3cd9fcfmr71950875e9.16.1783017650138; 
 Thu, 02 Jul 2026 11:40:50 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-25c8-8a00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:25c8:8a00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bef1807asm120271225e9.1.2026.07.02.11.40.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 11:40:49 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Matyas Bobek <matyas.bobek@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Jason Wang <jasowangio@gmail.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Jason Wang <jasowang@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Francisco Iglesias <francisco.iglesias@amd.com>
Subject: [PATCH v2 1/5] hw/net/can/flexcan: Wire clock control module via link
 property
Date: Thu,  2 Jul 2026 20:40:34 +0200
Message-ID: <20260702184038.178196-2-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702184038.178196-1-shentey@gmail.com>
References: <20260702184038.178196-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

When wiring struct FlexcanState to the clock control module, it is
currently necessary to reach into its private data. Moreover, when
forgetting to wire the clock control module, QEMU will crash after the
guest has already started. Fix both by letting struct FlexcanState
expose a link property whose sanity is checked at realize time.

Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/fsl-imx6.c    |  3 ++-
 hw/net/can/flexcan.c | 10 ++++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index bf106a9063..585c935b89 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -391,7 +391,8 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
             { FSL_IMX6_CAN2_ADDR, FSL_IMX6_FLEXCAN2_IRQ },
         };
 
-        s->flexcan[i].ccm = IMX_CCM(&s->ccm);
+        object_property_set_link(OBJECT(&s->flexcan[i]), "clock-control-module",
+                                 OBJECT(&s->ccm), &error_abort);
         object_property_set_link(OBJECT(&s->flexcan[i]), "canbus",
                                  OBJECT(s->canbus[i]), &error_abort);
 
diff --git a/hw/net/can/flexcan.c b/hw/net/can/flexcan.c
index 1ea459d9f6..8f3f066ef5 100644
--- a/hw/net/can/flexcan.c
+++ b/hw/net/can/flexcan.c
@@ -333,8 +333,6 @@ static uint32_t flexcan_get_bitrate(FlexcanState *s)
 
     uint32_t pe_freq, s_freq, bitrate;
 
-    assert(s->ccm);
-
     /* s_freq: CAN clock from CCM divided by the prescaler */
     pe_freq = imx_ccm_get_clock_frequency(s->ccm, CLK_CAN);
     s_freq = pe_freq / (1 + conf_presdiv);
@@ -1346,6 +1344,12 @@ static void flexcan_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    if (!s->ccm) {
+        error_setg(errp, "%s 'clock-control-module' link property not set",
+                   dev->canonical_path);
+        return;
+    }
+
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
     sysbus_init_irq(SYS_BUS_DEVICE(SYS_BUS_DEVICE(dev)), &s->irq);
 }
@@ -1366,6 +1370,8 @@ static const VMStateDescription vmstate_can = {
 static const Property flexcan_properties[] = {
     DEFINE_PROP_LINK("canbus", FlexcanState, canbus, TYPE_CAN_BUS,
                      CanBusState *),
+    DEFINE_PROP_LINK("clock-control-module", FlexcanState, ccm, TYPE_IMX_CCM,
+                     IMXCCMState *),
 };
 
 static void flexcan_class_init(ObjectClass *klass, const void *data)
-- 
2.55.0



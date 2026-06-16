Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F24CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZDj-00040E-Oj; Tue, 16 Jun 2026 15:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8L-0004bK-Eb
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:41 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8F-00011f-1J
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:35 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-45ef616daf6so5640606f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636838; x=1782241638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UcXYR0u9XO6butqPyE33f491+UF5RjAaf8RWRVOWwfM=;
 b=X+hIlhQcJNn5fkYad6lZQOYdWhAB3hBfWJhRNxSg/olIGjzavl0IEAWa7CCRd1uB2b
 SalWKQKTRNaF8BYyB4d208N0Ry+HjqsVrs/BeaIV7NGvo+JQjCoEoehDjiB1agmsrtpJ
 w6Cxz9qd79Sx5iYY7W7wP/EWsq46QPuZf0xWGG9E1bCFDP6bZDu7zs2uN25ANFzdpbBr
 W3GbOlqYDk/VBl13J4j+zXhwR5/3znUBsyEg9SQJNW1Ujwnz/rvccs24HxLg/l3z8nJ6
 VkbZoBmRVh+P51L0xRgskWVkHWCinkcaDOg3/etW2AUEtBS5xHfEhDvPZJ75cvprg8uS
 srZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636838; x=1782241638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UcXYR0u9XO6butqPyE33f491+UF5RjAaf8RWRVOWwfM=;
 b=FIcgutT/OZpQhRhmBFWJYiAkWm8Z95cRbhLKh2VT1U7g1cuImQvMKaXbAd44w4WPzZ
 dC3Zxd0f1d1z9YECF4IFZtn9usvXGG41ouPkZNSEDJrKY1348cy2DFzXacz/9HTmjo25
 nAkkSF7IUWZhaG6UOUVBGnOZHAQdRC9ygSVeC2hcGJoMi01c1NEXnTAdXTpJxQOhekNU
 fNaRA5xF758Iz28k9R42jUvZY6tmnrZEiL49ifBW/foCV8UsMxPD6yFQ7VmuGrdi9teo
 +P09uSJE6BqbmxSytlPXczGvlzt7zOW9xQ+O0OMYgPoD0Vrq8d5f0kswD5CgrqI87cg3
 K6bA==
X-Gm-Message-State: AOJu0Yzc3ZR66oqPssl5Ec1T6/yqk0dYbh/H28jGCr/bEk5PTOyWfV8B
 iIETarUEN8FalasBfZ3edsmSds9dG4fI/g5qUkMCQHtpBt0tZQ5dNO6H/Olo9k629foeb3npvLb
 5Db6b
X-Gm-Gg: Acq92OEwrvdetfFzF17lJw4T6helWpEzhfaz1+ZUKP/vBdLQB3B/L+Sd8D+6JbGYIyf
 Z07ISwaHoaKZL1vx1cmdRKm6B574jeASOO5nCoLTzWbwTWb16KiLZwQNVCj2jjVjvnLSFhH00h0
 NyBWVU6WsxT1LcNVmBulUfgwoe6he5KNSbejkKgf5uEjr6UXwvwtyMcQCAScw0Jaw1AiIY+8kGZ
 5s/ZwFLJcHHuKaiqKMXStoivt4xE7qc03HYpSeVFjSQwYFge03r5/xaSbAbRGuqRFOj2WnLQT9A
 b38NUdX7E7IpxZaiWQ1wwwjSAxzcKwP+XZU6u+uXru9aqgq+Ggu025oVi58MAH11aUR17KbT+Kh
 931qyFto0HZeHo2CYtqgQJw+hBtlEVRnBWLT6Z5XCuID1UDVJmX1l+G6bUM1NU+MesFPNmWxjXX
 NWm8P2CMn4vf2hLp5BPLzWFJ7GAu3g/KBumrcV3V2RS7aVEItmw0dYfEqwhjLnabNnCRff2/t0Z
 MtaIGGIJ7Jqt5BPn9QmQfzhm/dJcT13
X-Received: by 2002:a05:6000:43c6:20b0:460:6a8f:5d36 with SMTP id
 ffacd0b85a97d-46238acb5ebmr1101385f8f.22.1781636837660; 
 Tue, 16 Jun 2026 12:07:17 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/61] hw/arm/smmuv3-accel: Introduce common helper for veventq
 read
Date: Tue, 16 Jun 2026 20:06:09 +0100
Message-ID: <20260616190639.3462006-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

Move the vEVENTQ read and validation logic into a common helper
smmuv3_accel_event_read_validate(). The helper performs the read(),
checks for overflow and short reads, validates the sequence number,
and updates the sequence state.

This helper can be reused for Tegra241 CMDQV vEVENTQ support in a
subsequent patch.

Error handling is slightly adjusted: instead of reporting errors
directly in the read handler, the helper now returns errors via
Error **. Sequence gaps are reported as warnings.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260609112552.378999-23-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-accel-stubs.c |  7 ++++
 hw/arm/smmuv3-accel.c       | 73 ++++++++++++++++++++++---------------
 hw/arm/smmuv3-accel.h       |  2 +
 3 files changed, 52 insertions(+), 30 deletions(-)

diff --git a/hw/arm/smmuv3-accel-stubs.c b/hw/arm/smmuv3-accel-stubs.c
index 70cef66966..9e6c44a282 100644
--- a/hw/arm/smmuv3-accel-stubs.c
+++ b/hw/arm/smmuv3-accel-stubs.c
@@ -47,6 +47,13 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
     return true;
 }
 
+bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
+                                      void *buf, size_t size, Error **errp)
+{
+    return true;
+}
+
+
 void smmuv3_accel_reset(SMMUv3State *s)
 {
 }
diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 3ceca56a67..c1c2a67c97 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -440,6 +440,44 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
                    sizeof(Cmd), &entry_num, cmd, errp);
 }
 
+bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
+                                      void *buf, size_t size, Error **errp)
+{
+    uint32_t last_seq = veventq->last_event_seq;
+    uint32_t id = veventq->veventq_id;
+    struct iommufd_vevent_header *hdr;
+    ssize_t bytes;
+
+    bytes = read(veventq->veventq_fd, buf, size);
+    if (bytes <= 0) {
+        if (errno == EAGAIN || errno == EINTR) {
+            return true;
+        }
+        error_setg(errp, "vEVENTQ(type %u id %u): read failed (%m)", type, id);
+        return false;
+    }
+    hdr = (struct iommufd_vevent_header *)buf;
+    if (bytes == sizeof(*hdr) &&
+        (hdr->flags & IOMMU_VEVENTQ_FLAG_LOST_EVENTS)) {
+        error_setg(errp, "vEVENTQ(type %u id %u): overflowed", type, id);
+        veventq->event_start = false;
+        return false;
+    }
+    if (bytes < size) {
+        error_setg(errp, "vEVENTQ(type %u id %u): short read(%zd/%zd bytes)",
+                          type, id, bytes, size);
+        return false;
+    }
+    /* Check sequence in hdr for lost events if any */
+    if (veventq->event_start && (hdr->sequence - last_seq != 1)) {
+        warn_report("vEVENTQ(type %u id %u): lost %u event(s)",
+                    type, id, hdr->sequence - last_seq - 1);
+    }
+    veventq->last_event_seq = hdr->sequence;
+    veventq->event_start = true;
+    return true;
+}
+
 static void smmuv3_accel_event_read(void *opaque)
 {
     SMMUv3State *s = opaque;
@@ -448,39 +486,14 @@ static void smmuv3_accel_event_read(void *opaque)
         struct iommufd_vevent_header hdr;
         struct iommu_vevent_arm_smmuv3 vevent;
     } buf;
-    enum iommu_veventq_type type = IOMMU_VEVENTQ_TYPE_ARM_SMMUV3;
-    uint32_t id = veventq->veventq_id;
-    uint32_t last_seq = veventq->last_event_seq;
-    ssize_t bytes;
+    Error *local_err = NULL;
 
-    bytes = read(veventq->veventq_fd, &buf, sizeof(buf));
-    if (bytes <= 0) {
-        if (errno == EAGAIN || errno == EINTR) {
-            return;
-        }
-        error_report_once("vEVENTQ(type %u id %u): read failed (%m)", type, id);
+    if (!smmuv3_accel_event_read_validate(veventq,
+                                          IOMMU_VEVENTQ_TYPE_ARM_SMMUV3, &buf,
+                                          sizeof(buf), &local_err)) {
+        warn_report_err_once(local_err);
         return;
     }
-
-    if (bytes == sizeof(buf.hdr) &&
-        (buf.hdr.flags & IOMMU_VEVENTQ_FLAG_LOST_EVENTS)) {
-        error_report_once("vEVENTQ(type %u id %u): overflowed", type, id);
-        veventq->event_start = false;
-        return;
-    }
-    if (bytes < sizeof(buf)) {
-        error_report_once("vEVENTQ(type %u id %u): short read(%zd/%zd bytes)",
-                          type, id, bytes, sizeof(buf));
-        return;
-    }
-
-    /* Check sequence in hdr for lost events if any */
-    if (veventq->event_start && (buf.hdr.sequence - last_seq != 1)) {
-        error_report_once("vEVENTQ(type %u id %u): lost %u event(s)",
-                          type, id, buf.hdr.sequence - last_seq - 1);
-    }
-    veventq->last_event_seq = buf.hdr.sequence;
-    veventq->event_start = true;
     smmuv3_propagate_event(s, (Evt *)&buf.vevent);
 }
 
diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index e0bbec8581..8d0f636338 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -87,6 +87,8 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *s, void *cmd, SMMUDevice *sdev,
                                 Error **errp);
 void smmuv3_accel_idr_override(SMMUv3State *s);
 bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp);
+bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
+                                      void *buf, size_t size, Error **errp);
 void smmuv3_accel_reset(SMMUv3State *s);
 
 #endif /* HW_ARM_SMMUV3_ACCEL_H */
-- 
2.43.0



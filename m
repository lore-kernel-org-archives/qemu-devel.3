Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3290AFCB608
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWef-0003gW-Jz; Fri, 06 Mar 2026 09:59:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWee-0003bJ-Ac
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:59:52 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWec-0002J9-Is
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:59:52 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4833115090dso96352835e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 06:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809189; x=1773413989; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WCR0Wsa3KNmvE4hvefzUstZHB/A8U7VaN0odN4WHJOc=;
 b=avA/mMher6kt4M01uquUWJRfALpG84T/DwQmWsoixTRPw966TBfmQJ7258GA8FVDWn
 EmcUqpkoHIi7HJRY87ylQzosIBFaTmA43q+04MLICfrJfCfTntt3ROrt1p7OtJxK41Vy
 qTQZWUALQ67BLOYTEUlk521/CwLYpR9XvVjMP4p/4NtBthCXKeWAncWxmXyCxAFy+IeX
 7r+yYEId9nevWIRrOgBh3a2/M4qQUD9fhIwUY86L2+J8ZwFJBNFcg5O1KolS+BQdKA+n
 u8+qP8D3BVF+8N8tjx7xWdOiFvXT0xGnGvI7BplMnhyvJ6LFcExujGX+3gliFURYLcRM
 ZtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809189; x=1773413989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WCR0Wsa3KNmvE4hvefzUstZHB/A8U7VaN0odN4WHJOc=;
 b=r5eVKW68ai5WXkeUq58d9bjJT772Skni2dVQcE1jcR3vtS9+zUYWChX7ARHRvcG3cA
 /dLmGaZl0nXocLFvWsQ6A/WCfeqWIznxVUzupeUtjxwrIWaLVPZ4s01L5oKvmQ4GkDyV
 oAsTs+NoYFJ7aO4xbeWbbjjos8qYeOY3m6+Pbo9IPqGBmHCf6BBbzLtFjC5Rl9X37HdI
 7IlgO8kv5tNttQbzx58NjL2p4DqZkPX5L7HsH141p8uUFZ9CSyDKpMckZJi69Vzo9r/+
 hngls1WgC9yi1wWOs+97t/WyJL3BgFjBomKoT1QBll44bCv3c49veS6U3Wbz32MUnO/D
 2B/A==
X-Gm-Message-State: AOJu0Yxq9EO+SmCVkKACgZv4GOQJ7wmdeWcmHYp8QoIwCqPimNGO8YiD
 FzjUNo/mmeQhBLwQ1w0NZU0lj/QIwqoEMwyQJW6bvUz7cv4Iz89birQ2v9od1BaETTmNn3mhlk9
 PO5UE
X-Gm-Gg: ATEYQzxybiiaS4FVY3sAgFT2CKTaBCFB0wyqARY8WBarF6iclNGu3d6zy5Z3/5O0wkj
 52s5PmoYKMnDGF3GVWJem6KEznCzBg+GEbf9CoFQje7yUoJN13a2kcaPnfk2IFdUnwQeZ0z5xBT
 SYpn7+1ucG5AsoF+wovaZFbn6vhPtE1d530vYt+Vc5eiONtPIl8gyNKCpGStdMo2neR6pXuDIfc
 a3tw8PVhZooBNV+WEkhAyzdvVlTGKAJ8fxJ598n9iaDwsFonxuk1AQtsIrxE0mstBkIKwlI+8vo
 zcinEhIRn7Rypnc05xGNKAS0raTPtgc4jvfVMI5JbMCI1RI1tCgXGAd29fCKOCQZOzzmTlzsTbO
 EyLsvzi1+49688uMG3/HitmxZ/cnbP1oHh08xHQ+8jgoQQqj5rY2o33R01CzkGX8ksg0z2UEB/B
 wVmNzqHdsVi985FyQTh+TpFDYFteNwH/pm9KprMaC4335lniBtuBLzGIAdMrbZIBn916HcBuloR
 zDeAWsErcLEYiwNg8shydWUd9To9PM=
X-Received: by 2002:a05:600c:470e:b0:480:7162:fa48 with SMTP id
 5b1f17b1804b1-485269304c0mr40981925e9.13.1772809189053; 
 Fri, 06 Mar 2026 06:59:49 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.06.59.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 06:59:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/49] hw/arm/smmuv3-accel: Read and propagate host vIOMMU
 events
Date: Fri,  6 Mar 2026 14:58:58 +0000
Message-ID: <20260306145939.2162189-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Install an event handler on the vEVENTQ fd to read and propagate host
generated vIOMMU events to the guest.

The handler runs in QEMU's main loop, using a non-blocking fd registered
via qemu_set_fd_handler().

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260226084456.112142-6-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-accel.c | 64 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index f703ea1aac..17306cd04b 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -390,6 +390,50 @@ bool smmuv3_accel_issue_inv_cmd(SMMUv3State *bs, void *cmd, SMMUDevice *sdev,
                    sizeof(Cmd), &entry_num, cmd, errp);
 }
 
+static void smmuv3_accel_event_read(void *opaque)
+{
+    SMMUv3State *s = opaque;
+    IOMMUFDVeventq *veventq = s->s_accel->veventq;
+    struct {
+        struct iommufd_vevent_header hdr;
+        struct iommu_vevent_arm_smmuv3 vevent;
+    } buf;
+    enum iommu_veventq_type type = IOMMU_VEVENTQ_TYPE_ARM_SMMUV3;
+    uint32_t id = veventq->veventq_id;
+    uint32_t last_seq = veventq->last_event_seq;
+    ssize_t bytes;
+
+    bytes = read(veventq->veventq_fd, &buf, sizeof(buf));
+    if (bytes <= 0) {
+        if (errno == EAGAIN || errno == EINTR) {
+            return;
+        }
+        error_report_once("vEVENTQ(type %u id %u): read failed (%m)", type, id);
+        return;
+    }
+
+    if (bytes == sizeof(buf.hdr) &&
+        (buf.hdr.flags & IOMMU_VEVENTQ_FLAG_LOST_EVENTS)) {
+        error_report_once("vEVENTQ(type %u id %u): overflowed", type, id);
+        veventq->event_start = false;
+        return;
+    }
+    if (bytes < sizeof(buf)) {
+        error_report_once("vEVENTQ(type %u id %u): short read(%zd/%zd bytes)",
+                          type, id, bytes, sizeof(buf));
+        return;
+    }
+
+    /* Check sequence in hdr for lost events if any */
+    if (veventq->event_start && (buf.hdr.sequence - last_seq != 1)) {
+        error_report_once("vEVENTQ(type %u id %u): lost %u event(s)",
+                          type, id, buf.hdr.sequence - last_seq - 1);
+    }
+    veventq->last_event_seq = buf.hdr.sequence;
+    veventq->event_start = true;
+    smmuv3_propagate_event(s, (Evt *)&buf.vevent);
+}
+
 static void smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
 {
     IOMMUFDVeventq *veventq = accel->veventq;
@@ -397,6 +441,7 @@ static void smmuv3_accel_free_veventq(SMMUv3AccelState *accel)
     if (!veventq) {
         return;
     }
+    qemu_set_fd_handler(veventq->veventq_fd, NULL, NULL, NULL);
     close(veventq->veventq_fd);
     iommufd_backend_free_id(accel->viommu->iommufd, veventq->veventq_id);
     g_free(veventq);
@@ -424,6 +469,7 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
     IOMMUFDVeventq *veventq;
     uint32_t veventq_id;
     uint32_t veventq_fd;
+    int flags;
 
     if (!accel || !accel->viommu) {
         return true;
@@ -445,12 +491,30 @@ bool smmuv3_accel_alloc_veventq(SMMUv3State *s, Error **errp)
         return false;
     }
 
+    flags = fcntl(veventq_fd, F_GETFL);
+    if (flags < 0) {
+        error_setg_errno(errp, errno, "Failed to get flags for vEVENTQ fd");
+        goto free_veventq;
+    }
+    if (fcntl(veventq_fd, F_SETFL, flags | O_NONBLOCK) < 0) {
+        error_setg_errno(errp, errno, "Failed to set O_NONBLOCK on vEVENTQ fd");
+        goto free_veventq;
+    }
+
     veventq = g_new0(IOMMUFDVeventq, 1);
     veventq->veventq_id = veventq_id;
     veventq->veventq_fd = veventq_fd;
     veventq->viommu = accel->viommu;
     accel->veventq = veventq;
+
+    /* Set up event handler for veventq fd */
+    qemu_set_fd_handler(veventq_fd, smmuv3_accel_event_read, NULL, s);
     return true;
+
+free_veventq:
+    close(veventq_fd);
+    iommufd_backend_free_id(accel->viommu->iommufd, veventq_id);
+    return false;
 }
 
 static bool
-- 
2.43.0



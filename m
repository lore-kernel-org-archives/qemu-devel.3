Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46982CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 15:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDlYi-0007Za-1c; Tue, 28 Oct 2025 11:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vDlYe-0007XG-Cf
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 11:24:24 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vDlYV-0001Md-Pm
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 11:24:23 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-378d50e1c82so61108601fa.3
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 08:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761665042; x=1762269842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=veIL5vzROWT+lr9Su8nHxZGlO3ufKltes8yim3GkeBY=;
 b=NNs3juMAUbXSLxQaDNJlb/P710/vYM0Ct9U7zQAkia5hdkSVzYEuO5ZPa95DjRHqpf
 S0h/a3SdubouzI9bw1s0+5R6xYx5fa2iL05/d4lTyi6Z6brh9octNtrXOdAXrdPRcBJt
 pi8WMshO+ngGPEzOKwkGAQI8lYP+IiBEshVaOfZqssUNK/CXD+QvYHGkXhJQfmkwfc9+
 BtLiY08XBEiRz3ik8briFfin8Crx6DIU2xnUa63wiSVajWQOvahZH3CkxSDLmuHkVXXN
 tGhMZZNqPDyQZ4g+XHFtNYTsLO3YbU+vktWJti3n8A9v4zSYsN7w3LAJG408XeZLAelW
 H/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761665042; x=1762269842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=veIL5vzROWT+lr9Su8nHxZGlO3ufKltes8yim3GkeBY=;
 b=QP/qLaR4JgBX0giT614NiDEoHMGaUqBxuWGM1d3RRtey2oXXV35DU0H1BBhx/1MylH
 I3gRK6Vvq7Masz/d7jQYuP/XKT0xjWG6R++fuQroWF06qXckHJ33oDDqTralmBSEjolP
 iLqPrcM5b7qqFKtiLmX+bwpagJjHlqboxs/5qSg/tv7O6U3yuFe2Hvd5n2C3SkkKvxEV
 Eeiu/fbC8BVLmaR8sIw1sAGyLto24iIUZRs0LvvI7r50deBdrgSFgsTOFqfnWrdGteCM
 E1bpsoLzEqCagBWIBeYJ7ciE2et5/ioEwP+TXyLk74otebyhkg7c56tsx3GNoNWFmm9O
 8QrQ==
X-Gm-Message-State: AOJu0YzQgAvN+ftjgAlzzUmp7iJsU3RizCRbjJId1+7oXrQQLAlPwRfa
 WnVz/FFzUH+veOZuk4RG/Nvs9zxSX3k2Izy2n40ceR8dtXyyuB5sGZA8CP/l8ud9x67QsQ==
X-Gm-Gg: ASbGncu94EuJwXGhu9N47HvJyJXLvEnZOo/CLIDxaljnrYm6A7sxhkVSoB/hLcMXLiG
 STdslKtkT2Pkk40KgAzURDAYZpxC4+O877d1ETe02HC0UUK89Osm4aIvGXPkwKIrbxmC1aLE4on
 rfEUsrVGVPepq2zP78pW2TJ+JxHouUUwyDslkhBZRuzS3opFHGLBx9iKP1RJcFITrp5bYOyAs2Q
 uJkMw7mPKtveZBOu3VBCRE6DW476dU/3apAWf8Ga6m0MDmJ0Fw9F7+jgU1cRRgCwB7PLIRH5F2y
 CwdQ/3QAJ0fEZm4+SCZDLaR1axpZx+UlGURdRj6h7I6b6/QVVqLQY1rLBxVXzZcF2MuwMPVmqLC
 RbyUHKr3fQrzE6m8WzTD4OAIVNsgpuabJwpxMTSUbqOidjG/dcZdGGUoh+8KAPuYdWHo2Bzv3Xh
 tUGaJDBIKfLttdvCN0ygTnsyRIhZYJpkQrQoJ15+OM/CHGUcI=
X-Google-Smtp-Source: AGHT+IE42aUwC7B+Kswtt3arvxTuEmSc+UwZlHxEm9hFoZBm3M0v0grDcvrpvvfDzF6xf/Jw1S9B8g==
X-Received: by 2002:a05:651c:4394:20b0:378:cdf0:ad52 with SMTP id
 38308e7fff4ca-379076c6938mr11102181fa.18.1761665041748; 
 Tue, 28 Oct 2025 08:24:01 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-378ee0c625esm26448271fa.29.2025.10.28.08.24.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 08:24:00 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: alex.bennee@linaro.org,
	bill.mills@linaro.org,
	edgar.iglesias@amd.com
Subject: [PATCH v1 1/5] virtio: Introduce notify_queue
Date: Tue, 28 Oct 2025 16:23:46 +0100
Message-ID: <20251028152351.1247812-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251028152351.1247812-1-edgar.iglesias@gmail.com>
References: <20251028152351.1247812-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/virtio/virtio.c             | 7 +++++++
 include/hw/virtio/virtio-bus.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 153ee0a0cf..8a53fb5f93 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2700,12 +2700,19 @@ static void virtio_irq(VirtQueue *vq)
 
 void virtio_notify(VirtIODevice *vdev, VirtQueue *vq)
 {
+    BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+
     WITH_RCU_READ_LOCK_GUARD() {
         if (!virtio_should_notify(vdev, vq)) {
             return;
         }
     }
 
+    if (k->notify_queue) {
+        k->notify_queue(qbus->parent, virtio_get_queue_index(vq));
+    }
+
     trace_virtio_notify(vdev, vq);
     virtio_irq(vq);
 }
diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bus.h
index 7ab8c9dab0..043dbeb4cf 100644
--- a/include/hw/virtio/virtio-bus.h
+++ b/include/hw/virtio/virtio-bus.h
@@ -39,6 +39,7 @@ DECLARE_OBJ_CHECKERS(VirtioBusState, VirtioBusClass,
 struct VirtioBusClass {
     /* This is what a VirtioBus must implement */
     BusClass parent;
+    void (*notify_queue)(DeviceState *d, uint16_t index);
     void (*notify)(DeviceState *d, uint16_t vector);
     void (*save_config)(DeviceState *d, QEMUFile *f);
     void (*save_queue)(DeviceState *d, int n, QEMUFile *f);
-- 
2.43.0



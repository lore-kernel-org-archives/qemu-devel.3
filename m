Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E11AEE7718B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2024 19:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tP53g-0002Pz-Dg; Sat, 21 Dec 2024 14:22:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tP53f-0002PZ-Bq
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 14:22:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tP53d-0000FP-VL
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 14:22:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734808957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rqKCWQR3QB2io/MyyfabdA53d/IBhffWJa6uY0wK/vs=;
 b=LQdJ2NjTNOYjppsIN3KDFrNqWZ73hJRZA6aixhfO0A9+zTHrt5QwlSKvXCxsuOvIBQ6jfg
 oRr79QGlq5S/MWRybqD7g9GOrWBaetaMy9BL84A2JNO0HhKL5ywoJdy5s9V1FZ3V06wp6W
 kCmyF9X+rO4xQZ/6ak8QW9gI14XW2tw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-FtsSCamHOyaOxWv7MENjwQ-1; Sat, 21 Dec 2024 14:22:35 -0500
X-MC-Unique: FtsSCamHOyaOxWv7MENjwQ-1
X-Mimecast-MFC-AGG-ID: FtsSCamHOyaOxWv7MENjwQ
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-436289a570eso24136085e9.0
 for <qemu-devel@nongnu.org>; Sat, 21 Dec 2024 11:22:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734808954; x=1735413754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rqKCWQR3QB2io/MyyfabdA53d/IBhffWJa6uY0wK/vs=;
 b=CQEkS76HkQTWz471hNZFgrHlp559nMGMEJTaXRuxFXlOHR11A+E8bliK1/ySl+65Dk
 QenGWZIA5GsoeUZ3ATISK/uCfV0/ESiz2U2aqEfWBazS6PiuX7OIRZRUIdPlHpYkJwYJ
 MRNTKaSPwUPZorE5k4tJGRVg/Zp2zFKoK1xyDTRkF1rR/NVKQib2QSOeGYVGQ+USSN2t
 ur4DHma0gpnMNwD0+q4qZ1d3TspY8ghJ1FoUMOob6XxelKQatfvCt2FT4XLhySrSmfGF
 sQ0fNGl5JAx2EkGNDhFipGopWtvhf3BA7FTT419dKpM6es8sPlpsnGF3bIH8LflAJsSG
 Ovgg==
X-Gm-Message-State: AOJu0YxWw7OORPaiCBux+FhgrRIa8tvF2RNjBS4GGHc0BG3h4tJEw3I2
 hW4IgH1FZl4MzTHroeZnsoAwuCCNtlL20dt906WaXQxTM55TQOwMhVUMfMVdFFHOHLuhqtTf3wd
 TAxsl8oXyQv18rp+3wri95NIJ2iId1f/qoannXlR76gPHcHq3mZ8kiV/8B/tTMAikQM1DdnWy0r
 sBYiRod6gXobj6hlRWHA5EDYhyeOIJYvas
X-Gm-Gg: ASbGncvUMeXDxVggT+YP+EdVzLA9lZxl5oEvXRAETXDpO0P87schQhnPLTAWyKhKlbR
 T92ryqrXctzqoHxX09AvFPZ7m9OTXaf1EcnLpZEIqhcC2+2Ua9VcFWfFWldQKjaLg4BzU7gfsFb
 o00qJ4PVQkNQGhDbXwFH5SlGadTvmXWxajb8SF1yqHu19G/D73kouxucoKZpgIzhuKIzb3qTKYj
 DhAAwpPbIw7PLGbjTKHLdrGuDSZ6sr4RViT/2NDy7XhQczAab9SG4tljgGuS8Bq8wVBGPpyPeiE
 uA2g+KJiIidtJPYBHDlL8SUE/4gAB4FQ25nwqnA=
X-Received: by 2002:a5d:584c:0:b0:385:d7f9:f16c with SMTP id
 ffacd0b85a97d-38a223f758emr6888107f8f.46.1734808954547; 
 Sat, 21 Dec 2024 11:22:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkftMM59mvDXCH8p49S8A7Ny/OME7qNNogDTT/MUi6oCR3zMBAP698T0J34AXc74CpSLn6Vw==
X-Received: by 2002:a5d:584c:0:b0:385:d7f9:f16c with SMTP id
 ffacd0b85a97d-38a223f758emr6888083f8f.46.1734808954127; 
 Sat, 21 Dec 2024 11:22:34 -0800 (PST)
Received: from localhost
 (p200300cbc7137800820d0e9f08ce52bd.dip0.t-ipconnect.de.
 [2003:cb:c713:7800:820d:e9f:8ce:52bd])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4366120088esm82859165e9.13.2024.12.21.11.22.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Dec 2024 11:22:33 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL v2 08/15] s390x/s390-hypercall: introduce DIAG500 STORAGE_LIMIT
Date: Sat, 21 Dec 2024 20:22:02 +0100
Message-ID: <20241221192209.3979595-9-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241221192209.3979595-1-david@redhat.com>
References: <20241221192209.3979595-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.177,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

A guest OS that supports memory hotplug / memory devices must during
boot be aware of the maximum possible physical memory address that it might
have to handle at a later stage during its runtime.

For example, the maximum possible memory address might be required to
prepare the kernel virtual address space accordingly (e.g., select page
table hierarchy depth).

On s390x there is currently no such mechanism that is compatible with
paravirtualized memory devices, because the whole SCLP interface was
designed around the idea of "storage increments" and "standby memory".
Paravirtualized memory devices we want to support, such as virtio-mem, have
no intersection with any of that, but could co-exist with them in the
future if ever needed.

In particular, a guest OS must never detect and use device memory
without the help of a proper device driver. Device memory must not be
exposed in any firmware-provided memory map (SCLP or diag260 on s390x).
For this reason, these memory devices will be places in memory *above*
the "maximum storage increment" exposed via SCLP.

Let's provide a new diag500 subcode to query the memory limit determined in
s390_memory_init().

Message-ID: <20241219144115.2820241-8-david@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-hypercall.c | 12 +++++++++++-
 hw/s390x/s390-hypercall.h |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-hypercall.c b/hw/s390x/s390-hypercall.c
index f816c2b1ef..ac1b08b2cd 100644
--- a/hw/s390x/s390-hypercall.c
+++ b/hw/s390x/s390-hypercall.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "hw/boards.h"
+#include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/s390x/s390-hypercall.h"
 #include "hw/s390x/ioinst.h"
 #include "hw/s390x/css.h"
@@ -57,6 +57,13 @@ static int handle_virtio_ccw_notify(uint64_t subch_id, uint64_t data)
     return 0;
 }
 
+static uint64_t handle_storage_limit(void)
+{
+    S390CcwMachineState *s390ms = S390_CCW_MACHINE(qdev_get_machine());
+
+    return s390_get_memory_limit(s390ms) - 1;
+}
+
 void handle_diag_500(S390CPU *cpu, uintptr_t ra)
 {
     CPUS390XState *env = &cpu->env;
@@ -69,6 +76,9 @@ void handle_diag_500(S390CPU *cpu, uintptr_t ra)
     case DIAG500_VIRTIO_CCW_NOTIFY:
         env->regs[2] = handle_virtio_ccw_notify(env->regs[2], env->regs[3]);
         break;
+    case DIAG500_STORAGE_LIMIT:
+        env->regs[2] = handle_storage_limit();
+        break;
     default:
         s390_program_interrupt(env, PGM_SPECIFICATION, ra);
     }
diff --git a/hw/s390x/s390-hypercall.h b/hw/s390x/s390-hypercall.h
index 2fa81dbfdd..4f07209128 100644
--- a/hw/s390x/s390-hypercall.h
+++ b/hw/s390x/s390-hypercall.h
@@ -18,6 +18,7 @@
 #define DIAG500_VIRTIO_RESET            1 /* legacy */
 #define DIAG500_VIRTIO_SET_STATUS       2 /* legacy */
 #define DIAG500_VIRTIO_CCW_NOTIFY       3 /* KVM_S390_VIRTIO_CCW_NOTIFY */
+#define DIAG500_STORAGE_LIMIT           4
 
 void handle_diag_500(S390CPU *cpu, uintptr_t ra);
 
-- 
2.47.1



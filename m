Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32DAC3ABCE
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 15:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqDLj-0004ox-SM; Mon, 16 Sep 2024 11:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sqDLf-0004er-6e; Mon, 16 Sep 2024 11:09:07 -0400
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sqDLd-00048w-L9; Mon, 16 Sep 2024 11:09:06 -0400
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3a08c907245so9776635ab.0; 
 Mon, 16 Sep 2024 08:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726499343; x=1727104143; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z9fGayqu8/3BSy8pNgZk7M/4P7YOiJj/gcULOkYYJOg=;
 b=BAy7wX3+pWWrVkTOxwDps+Rv+c3i9/cNNL/FBqpxjMMXXMfpFwM4/I2dmsya7XCBxf
 51d+kRkuW4QwZuSdWWf3e6LtOxM9qENoRMg7G3CFc5Y/Ef+2L+fJMtsebnDZWIQEgLFC
 wvwY7ewfCPmbtmZuta2PiLMt6FiJzWlZoHJ+eeGgY1bM0yKp8cYdOgvdrjrhxo5wzPRC
 h86h0GO+86TxPQlT2kOq8NQZd7k0wvIGLiCSkgXlTACujeN76r2aGPd8dOqIYk9/vOHb
 XrAtMkIRLBGNO1ngcXz+1KnaUgxYbhQqbwanBK8Ye1jI22umvdv372igm745Srg6V3l0
 052g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726499343; x=1727104143;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z9fGayqu8/3BSy8pNgZk7M/4P7YOiJj/gcULOkYYJOg=;
 b=EIIhI4KfsfBeBXlX/eQTMCTG+VnJ6XDNpd9bi87O59SOyGnxhp+OhFZiEYhXGQ+A9p
 yyIjq9tsXfG9xVfiiObMJjkSWHpCfDQhaHxK1hXevnaPlFEa0OeX5DQ8K0lgJhNdRfdf
 816Lrj0pI4trSR0omTaQY090RWimgQt1U/h9VZ8UHhRvR5kVWP0lvPBc/QfwdQrCos7V
 ohF6n9wqNJyiQDwbpedWnIDgcBbpSqRLFNRQDxX/Uoug1yXQP5RqbV1Wp4FeH6OJ/1Y9
 NVNmEP4AY0S7OnFqZ6nUKEs+WX5CmYzR8qohjgeA4g3iK7OjJ49ePiVPJrHNrcfinM85
 9QHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsKtJ+6yQUIg0ivK8FowJtsVeb49RNM3L2ryxQltr8P+TPuxt7UztK8hoE4zyRXeCsuqYZHn8F2g==@nongnu.org
X-Gm-Message-State: AOJu0YwS4ePGfPlUTrkMiUsDl91/Jdqv0qqeSC2oAA7wp18n+uyBet0m
 k5OLZ0Bsn0Jm3Ix5FFKNWY8vREs5sx3vYmfk+FsY843VlaWPqfF4DXJRQ1UF
X-Google-Smtp-Source: AGHT+IEqUvGdjraR0wBvs0H47m4U/lbEz4963FbfsqjYnrckE5XmjraeI29NnHQZvwRQLEUjUdTYsg==
X-Received: by 2002:a05:6e02:12e7:b0:3a0:8eb3:5160 with SMTP id
 e9e14a558f8ab-3a08eb35230mr80173955ab.11.1726499343305; 
 Mon, 16 Sep 2024 08:09:03 -0700 (PDT)
Received: from gmail.com (ip190-5-140-142.intercom.com.sv. [190.5.140.142])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4d37ec3d0aasm1507302173.84.2024.09.16.08.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 08:09:02 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org
Subject: [PATCH v1 2/4] hw/xen: xenpvh: Disable buffered IOREQs for ARM
Date: Mon, 16 Sep 2024 17:08:50 +0200
Message-ID: <20240916150853.1216703-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240916150853.1216703-1-edgar.iglesias@gmail.com>
References: <20240916150853.1216703-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12b;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-il1-x12b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add a way to enable/disable buffered IOREQs for PVH machines
and disable them for ARM. ARM does not support buffered
IOREQ's nor the legacy way to map IOREQ info pages.

See the following for more details:
https://xenbits.xen.org/gitweb/?p=xen.git;a=commitdiff;h=2fbd7e609e1803ac5e5c26e22aa8e4b5a6cddbb1
https://xenbits.xen.org/gitweb/?p=xen.git;a=blob;f=xen/arch/arm/ioreq.c;h=2e829d2e7f3760401b96fa7c930e2015fb1cf463;hb=HEAD#l138

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/arm/xen-pvh.c                | 3 +++
 hw/i386/xen/xen-pvh.c           | 3 +++
 hw/xen/xen-pvh-common.c         | 2 +-
 include/hw/xen/xen-pvh-common.h | 3 +++
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
index 04cb9855af..28af3910ea 100644
--- a/hw/arm/xen-pvh.c
+++ b/hw/arm/xen-pvh.c
@@ -66,6 +66,9 @@ static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
      */
     mc->max_cpus = GUEST_MAX_VCPUS;
 
+    /* Xen/ARM does not use buffered IOREQs.  */
+    xpc->handle_bufioreq = HVM_IOREQSRV_BUFIOREQ_OFF;
+
     /* List of supported features known to work on PVH ARM.  */
     xpc->has_tpm = true;
     xpc->has_virtio_mmio = true;
diff --git a/hw/i386/xen/xen-pvh.c b/hw/i386/xen/xen-pvh.c
index 45645667e9..f1f02d3311 100644
--- a/hw/i386/xen/xen-pvh.c
+++ b/hw/i386/xen/xen-pvh.c
@@ -89,6 +89,9 @@ static void xen_pvh_machine_class_init(ObjectClass *oc, void *data)
     /* We have an implementation specific init to create CPU objects.  */
     xpc->init = xen_pvh_init;
 
+    /* Enable buffered IOREQs.  */
+    xpc->handle_bufioreq = HVM_IOREQSRV_BUFIOREQ_ATOMIC;
+
     /*
      * PCI INTX routing.
      *
diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index 08641fdcec..76a9b2b945 100644
--- a/hw/xen/xen-pvh-common.c
+++ b/hw/xen/xen-pvh-common.c
@@ -195,7 +195,7 @@ static void xen_pvh_init(MachineState *ms)
 
     xen_pvh_init_ram(s, sysmem);
     xen_register_ioreq(&s->ioreq, ms->smp.max_cpus,
-                       HVM_IOREQSRV_BUFIOREQ_ATOMIC,
+                       xpc->handle_bufioreq,
                        &xen_memory_listener);
 
     if (s->cfg.virtio_mmio_num) {
diff --git a/include/hw/xen/xen-pvh-common.h b/include/hw/xen/xen-pvh-common.h
index bc09eea936..62c44a1ce7 100644
--- a/include/hw/xen/xen-pvh-common.h
+++ b/include/hw/xen/xen-pvh-common.h
@@ -43,6 +43,9 @@ struct XenPVHMachineClass {
      */
     int (*set_pci_link_route)(uint8_t line, uint8_t irq);
 
+    /* Allow implementations to optionally enable buffered ioreqs.  */
+    int handle_bufioreq;
+
     /*
      * Each implementation can optionally enable features that it
      * supports and are known to work.
-- 
2.43.0



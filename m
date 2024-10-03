Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3CFCF34A9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 14:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swMrP-00067Q-Dt; Thu, 03 Oct 2024 10:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1swMrO-00066S-27; Thu, 03 Oct 2024 10:31:18 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1swMrM-0003m7-3N; Thu, 03 Oct 2024 10:31:17 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-53991d05416so1268674e87.2; 
 Thu, 03 Oct 2024 07:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727965873; x=1728570673; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G14n863A5XJ+R3OWZM+ShGFWWx326n2e7KMDwbqTXOk=;
 b=db4zawEDn8bh/jdVT4q1fQrY0gLhfKphPbxZyDEjrOeX6HBEp3VKxPSQ/1SdO7wiIf
 xwABU1pQVXxwQkcUkiecwwBpud+rRN1O9Dqx/86QmgKg+gPltp1W+Boz7hdR9dCu005s
 FKhRiwqvjUFbFTOjaU3S6g71BC0rwPWivDhOMbYU9P4vmqT4T87xv+JVNhIJxXPABg+/
 srbWmM8QbW72fFc3E0C+/a44O2kWYlP70la47HfyoD3rpphM54qTAbhzDuWdxa7OU6sh
 M2VlTN9k53e6bc4GdJ7oPtwtiFq1ecJWzjq83UlorEFWSEukSFlcRpWrZasS7UtyfmlL
 jTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727965873; x=1728570673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G14n863A5XJ+R3OWZM+ShGFWWx326n2e7KMDwbqTXOk=;
 b=R/CdXwLYAi6jzFEur/v1A2zDCMx3aqKQ59cwwC0uZWPTbg4bacssd3tkFwO1QX0lsX
 Q3fdUS1VGW/ryBTW9bQoKPVa+nmc6u6EWGmjiz6HIvDEGjlsJcuokDzgxVrYOzRD+ZQW
 YxoIZJQS7doNr1syHgIw0WsecaEBQMBgXfv6XAaQZdD3rN3wQpqljMZxdgf1oacjLwH3
 eiA6RU3WO0Quduzb4w2Sp8E7QJ6vkxAxjvN57Rgwr4Hy8H/bBDbfD3VllITICakhVofS
 xf+46vKxFLhKWmBLT8Q5gYwyDoK0YMyg2qz+WFu45tZVcpiDcDyQl53MNTPUpAlw273J
 SU2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQMqOXZ6SB+1aeOoq6OjnVu5n/rgUDsNTKo/cn4d7QQDs0xIawPLbEvGHtIkx5LD0gg9hLiMiHeg==@nongnu.org
X-Gm-Message-State: AOJu0Yzl8MbOPJTfmvxJc2qmwfJE/EZ8nZOouVE34MgnXojwJ5xt9DAd
 DxfjOxPqn6qsrT3S/g3/F+3PzluQ25uqO5VjXfzY6qSxNPi9nTex0BLuNSIB
X-Google-Smtp-Source: AGHT+IHOBNtTy8Z6hlO7HIVsJ2JrpsTcBJsLU3WHSwU8CKz+ObM1If7037IORqFyBvOjTb7coQLByw==
X-Received: by 2002:a05:6512:304e:b0:539:8d9b:b61c with SMTP id
 2adb3069b0e04-539a07a62c1mr6698903e87.51.1727965873124; 
 Thu, 03 Oct 2024 07:31:13 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-539a8256ab3sm188873e87.79.2024.10.03.07.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 07:31:12 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org
Subject: [PULL v1 3/5] hw/xen: xenpvh: Disable buffered IOREQs for ARM
Date: Thu,  3 Oct 2024 16:31:00 +0200
Message-ID: <20241003143103.1476805-4-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241003143103.1476805-1-edgar.iglesias@gmail.com>
References: <20241003143103.1476805-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12a.google.com
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

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
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
index bc09eea936..5cdd23c2f4 100644
--- a/include/hw/xen/xen-pvh-common.h
+++ b/include/hw/xen/xen-pvh-common.h
@@ -43,6 +43,9 @@ struct XenPVHMachineClass {
      */
     int (*set_pci_link_route)(uint8_t line, uint8_t irq);
 
+    /* Allow implementations to optionally enable buffered ioreqs.  */
+    uint8_t handle_bufioreq;
+
     /*
      * Each implementation can optionally enable features that it
      * supports and are known to work.
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82906C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 13:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdUku-0004LD-4f; Mon, 12 Aug 2024 09:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sdUkm-0003zz-Mx; Mon, 12 Aug 2024 09:06:30 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sdUkj-00046P-EL; Mon, 12 Aug 2024 09:06:26 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-52f025bc147so4940358e87.3; 
 Mon, 12 Aug 2024 06:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723467982; x=1724072782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xwk/c9fy7uMLWpwC3gxJL5qXeUXnd09Co6O9sN+JUhY=;
 b=Do70/WIyKcQqsaxL/jNIVm1OfMzzar5gGlHqD3KsT7Pp5u8125TLDVZ67peKOwO8Yk
 fdoB8rEv9BjeGs8dufHT2EPW9gnmtcH8TAx3/q+6YiTAgSnS3BF1pqSgg/UMYUUAMeU4
 50QWEAiammNoyPjim8YXfZmRh/B0lCsWN4NtUwgbJTzNfp+uQ5UCM20x6i5GIrxfzJCw
 JRkGlxel4FOd4EtF76+gZNpO/0fI1jfZL4/gxY3rWvJOOMmoE+t46215CdBlFlJBZ557
 OCGlztg43d5E67/CNPgaoISba/kCr5uS3ppiaiDJ47PHsDn4G0p6s355mgR7KXyXHYfB
 3mSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723467982; x=1724072782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xwk/c9fy7uMLWpwC3gxJL5qXeUXnd09Co6O9sN+JUhY=;
 b=mfWvbX9qff5XJpyMip0+dd4/ph4XU6sAv3fpddgotQzQPYnGEB+Y7zquUyZitUvoMn
 JvXs4/i7K7UYc1y4FfxIvB9ueWCxflc0ErlwAXFiAYZ1TWTGNNekMpdNIh2XzCXQsRcz
 2x+KaX0fGXLsZYiDKtVQhhT7MwiiEy7UztriXF89jhuSFxuptcos9lr6nrkhuiAznHyW
 /ExGGjwTErCcjDFlRUUV7UlTEi0f7PD4MidO2OsDkAWD21MfMgumsBuGgMrk/Xds3myR
 WWs8GtH9BBLSPInKX9846eEbvLDQtcoUke7OiRNFyxNnFFTMFGyGXHPmhNVwwmmvzIcI
 N19A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHdmCqO/WW7TcZF3kL+dWhcDy97X/1f/oektHLnlH2rYHkR36OIQ2jF0krKVbutGTtZAMi4ZaJ0W5yFl5qcuxf5ao8
X-Gm-Message-State: AOJu0YyE3wUCN3k62Skbj1Cl6tRa86WOA5Eo3BzCupmtna3ZF5qO2kNW
 pmKlYY07FAy+Exkm25VJcpDM4z9FyAdor+/vDsmjWexGVTfKccPlJKwrKBJ7
X-Google-Smtp-Source: AGHT+IFqodcbXvvGQbYAmgjAlCjjHyzPPhL/5h6u/IlGoF6PnqI7PI9+Ax4L4kxnxBVCA+PqtUfB/w==
X-Received: by 2002:a05:6512:10d1:b0:52e:76e8:e18e with SMTP id
 2adb3069b0e04-5321364a598mr46079e87.7.1723467981708; 
 Mon, 12 Aug 2024 06:06:21 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53200f42164sm727333e87.256.2024.08.12.06.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 06:06:21 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, xenia.ragiadakou@amd.com,
 jason.andryuk@amd.com, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org
Subject: [PATCH v1 04/10] hw/arm: xenpvh: Add support for SMP guests
Date: Mon, 12 Aug 2024 15:05:59 +0200
Message-ID: <20240812130606.90410-5-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812130606.90410-1-edgar.iglesias@gmail.com>
References: <20240812130606.90410-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add SMP support for Xen PVH ARM guests. Create max_cpus ioreq
servers to handle hotplug.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/arm/xen_arm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index 5f75cc3779..ef8315969c 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -173,7 +173,7 @@ static void xen_arm_init(MachineState *machine)
 
     xen_init_ram(machine);
 
-    xen_register_ioreq(xam->state, machine->smp.cpus, &xen_memory_listener);
+    xen_register_ioreq(xam->state, machine->smp.max_cpus, &xen_memory_listener);
 
     xen_create_virtio_mmio_devices(xam);
 
@@ -218,7 +218,8 @@ static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     mc->desc = "Xen PVH ARM machine";
     mc->init = xen_arm_init;
-    mc->max_cpus = 1;
+    /* MAX number of vcpus supported by Xen.  */
+    mc->max_cpus = GUEST_MAX_VCPUS;
     mc->default_machine_opts = "accel=xen";
     /* Set explicitly here to make sure that real ram_size is passed */
     mc->default_ram_size = 0;
-- 
2.43.0



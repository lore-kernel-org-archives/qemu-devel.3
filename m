Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1784EC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 08:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJTcu-0004iG-31; Mon, 26 May 2025 04:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1uJTcM-0004SZ-MW
 for qemu-devel@nongnu.org; Mon, 26 May 2025 04:55:34 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1uJTcK-00083H-Df
 for qemu-devel@nongnu.org; Mon, 26 May 2025 04:55:34 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-442f9043f56so12619275e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 01:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1748249730; x=1748854530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZepsipKrTHKMZ/Hf+3FKIyyQF/voSTVlZvQ7yPeFvjE=;
 b=X0n+E8NoDhkKGrWo2lvVFghtDYHPSEY1dm0njTiEVpTwcKjQP+W10yDrQPXKAAOkOE
 1O6LzdKNemwpYKvxuU+FrEJ86hyQD0LWSetks16Iii13WOZFlJ1f4kJgVaCK2nK/2KdC
 4d0KRiz/KColCC7yfbEHttXR0g6VS6EcGgY/Vs6WnZtrcmNS7oTzvc3UPXL+H/55fNWA
 S4nXkad9ov9kTTLn/VepIjtZOGou/8hJPPC7m3jgMQlsKN9ZjkYDkzU3L7oZKIQWepey
 y13pX/Z7GKVkLPKqCxk2m7Knq4mMi71j8Fq5Akyd6ouNNmTVlcXCfA4vrokSy9hj32iT
 TEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748249730; x=1748854530;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZepsipKrTHKMZ/Hf+3FKIyyQF/voSTVlZvQ7yPeFvjE=;
 b=jb7R2IfLeHnDStQouWxfx3eAq1iRQXK8Y+QapYwG31AKznixEgNO+4C5eV9l5Qr//7
 FBSnekvJlLCEUgYTX6kdk9gR6NbgG4bVd1beYZxHcSrgEDF37bVRd779pfYgXMxTPJll
 KmNGLdhW/yQL/mkVxDGDX552jVDuIXxwewYk9R6hFOCDrVxlncBLlcBeXhy4AjNMQ+0n
 3GyLHerxZhIdbGx88NQENLtjDvqqstlQdO9ppsFMyFRajc5DKlYbTnTbIl3Ifi+XZZP3
 Dik2EUv11QchI27q7FKqebOtEzxeDUVpnMSxoYO+n4eY5Kd0EcyrUK5eaLXORm57pF+8
 cuEg==
X-Gm-Message-State: AOJu0Yw6sd3tLbFApBEKPor8kYT8x7d4Agyxura2yPwUde1xuK9S2HUe
 DnIFug0Z4yxeBWF/poTOdZBDMDeDyjA8hf7x+DOaz4E8btMKoLxOs6US48Acia4zEFGY2yUSwqD
 F7EU=
X-Gm-Gg: ASbGncttiNYZB+qQNo/aVvuVZ0supcXMo4UnS09DC/S46gpk+8nq/P/T1DZuBgpGoON
 5DyMJ6+ir8zsTsj/UfDCATXVwm8+AiBM14+FTl02rIc/YO0BHiTud8zZ3j/9G/DAiTIj2Zxo9a0
 X1HxDTGMtwKTWlHo/ZAfNKNJG+QxdWPZU2DWgY5X2nNku8XBykGWsivRzLlU1NFmYQ0rLh+lfP8
 Cikjh7ROWAbckmzj8BcMU3GOEg1s1K3ia5xE3wYzPwYmdWI6VNbkMH9R4/iXHESlvWhdGmdnk3e
 GKoLopQdu3grW+6zVGrclvCNJxxqgSsNm4qqXkhwFqUmiZTZenUbt2cj6WwbqxvBsrB8yQNVXU6
 GJ4XEOc2aeRt5jxajIeioaqvSV1OUpHTu5yX6ROv0NvOd2B79
X-Google-Smtp-Source: AGHT+IE1THs4xLGWy2VBKiAoYdoDLaKMY24d66fK1dRn+7107zZGfHsxK6Vxt9QaiSlamZBajIl+uQ==
X-Received: by 2002:a05:600c:3b90:b0:43d:77c5:9c1a with SMTP id
 5b1f17b1804b1-44c9141a950mr78217825e9.4.1748249730513; 
 Mon, 26 May 2025 01:55:30 -0700 (PDT)
Received: from chigot-Dell.telnowedge.local
 (lmontsouris-659-1-24-67.w81-250.abo.wanadoo.fr. [81.250.175.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f23bfd54sm238911675e9.17.2025.05.26.01.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 01:55:30 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, edgar.iglesias@gmail.com,
 alistair@alistair23.me,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH v2 4/4] hw/arm/xlnx-zynqmp: adapt cluster-id based on the boot
 cpu
Date: Mon, 26 May 2025 10:55:23 +0200
Message-Id: <20250526085523.809003-5-chigot@adacore.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250526085523.809003-1-chigot@adacore.com>
References: <20250526085523.809003-1-chigot@adacore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x335.google.com
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

When gdb is being connected to QEMU, it will be attached to the first
CPU cluster. However, the ZynqMP board has two clusters, those being of
two different architectures.
Therefore, when gdb is connecting to the ZynqMP, it receives the target
descriptor of the first CPU cluster. Up to now, it was always the APU
cluster, which is AARCH64.

When booting on a RPU, gdb will still connect to the APU. If gdb is
supporting only ARM32, it will receive the APU target descriptor,
resulting in:
  | (gdb) target remote :1234
  | warning: while parsing target description (at line 1): Target
  | description specified unknown architecture "aarch64"

Adjust the cluster-id based on the boot cpu will resolve the above
issue; allowing a pure ARM32 toolchain to debug programs running on
RPUs.

Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 hw/arm/xlnx-zynqmp.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index be33669f87..f23ace6446 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -221,7 +221,13 @@ static void xlnx_zynqmp_create_rpu(MachineState *ms, XlnxZynqMPState *s,
 
     object_initialize_child(OBJECT(s), "rpu-cluster", &s->rpu_cluster,
                             TYPE_CPU_CLUSTER);
-    qdev_prop_set_uint32(DEVICE(&s->rpu_cluster), "cluster-id", 1);
+
+    /* In order to connect gdb to the boot cpu, adjust the cluster-id.  */
+    if (!strncmp(boot_cpu, "rpu-cpu", 7)) {
+        qdev_prop_set_uint32(DEVICE(&s->rpu_cluster), "cluster-id", 0);
+    } else {
+        qdev_prop_set_uint32(DEVICE(&s->rpu_cluster), "cluster-id", 1);
+    }
 
     for (i = 0; i < num_rpus; i++) {
         const char *name;
@@ -380,7 +386,6 @@ static void xlnx_zynqmp_init(Object *obj)
 
     object_initialize_child(obj, "apu-cluster", &s->apu_cluster,
                             TYPE_CPU_CLUSTER);
-    qdev_prop_set_uint32(DEVICE(&s->apu_cluster), "cluster-id", 0);
 
     for (i = 0; i < num_apus; i++) {
         object_initialize_child(OBJECT(&s->apu_cluster), "apu-cpu[*]",
@@ -475,6 +480,13 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
 
     ram_size = memory_region_size(s->ddr_ram);
 
+    /* In order to connect gdb to the boot cpu, adjust the cluster-id.  */
+    if (!strncmp(boot_cpu, "apu-cpu", 7)) {
+        qdev_prop_set_uint32(DEVICE(&s->apu_cluster), "cluster-id", 0);
+    } else {
+        qdev_prop_set_uint32(DEVICE(&s->apu_cluster), "cluster-id", 1);
+    }
+
     /*
      * Create the DDR Memory Regions. User friendly checks should happen at
      * the board level
-- 
2.34.1



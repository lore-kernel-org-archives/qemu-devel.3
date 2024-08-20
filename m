Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E74C531DC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 14:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgPt7-0002yx-Hn; Tue, 20 Aug 2024 10:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sgPs6-0001vh-Bv; Tue, 20 Aug 2024 10:30:13 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sgPs2-0001Z3-OP; Tue, 20 Aug 2024 10:30:06 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-530e22878cfso5798107e87.2; 
 Tue, 20 Aug 2024 07:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724164199; x=1724768999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3FilNtR3ylHjSgCwXgc1/4kLFqGR/asrW9olruIp6U=;
 b=foPLAVNsyPjttb90f4xTuTNIdL1BGYWBHi/hw8vZLXG44Dv3gPqQmw0p1QTMPesbkt
 w4fwU4rPQwz7PSHSa2e5pkk3v8OqW2D/dpdkMk/9OrmF6Ed+4yYQb8DlJEatkYAUyTqV
 dMm8OPuFkOC3lEBjqOBmRInVIEQlhEp5aq3d/aoyF0Q1J9jVSkV+GJz3ZmXzU8Y+k10+
 WQa8hG/os2n4y2cUHhuPD+d8hqLieR80vUmDq+W+3jVEQFDOVzIkD3guH+keg4y0MxW0
 2XcghiU+ejgjt3TWq6cuuzAWf2jJr/o4XQRlUFdpN70fY/LuX6Yxawvs6O0KH1aQKNDx
 viqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724164199; x=1724768999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j3FilNtR3ylHjSgCwXgc1/4kLFqGR/asrW9olruIp6U=;
 b=r4wA/e9ZqjrtRmnXhu+Q/IMifOcH1Bc7us3zDZB69B8bXpcic+8q2SN8SzzpeZPTG9
 hWPTXiNVeZsW/H7wKVW4J3ok1+Fu6hoK8Rf5BKAPCpoJ9U52DVp2AWIM1eg9ZBirBEV+
 XTsHPog+VtvB/VmZkk5DXTAS6k6fOZVwijs88evYnyUu139P/laKb1WfyeN2cb2Fxisw
 /S59LmPF+JVN4rrtc89l1j7n/9o9rD9AjVUh6Ea2DkBTX9IqSwlzBqjdIhULKoEusBZY
 geM1/b1tpqea04k2IVlsyLZ5YMZxKhOC7oUywOGxps/4ycQ8UIOcJlW+AWr4f7QjN6nC
 LzBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSi7syID9DxFxofU9bjuMVXAr8TEeBljVGdhigxKIOrHiuj07PMocaLCTbnGBK+OtHq6c5yRPiKw==@nongnu.org
X-Gm-Message-State: AOJu0YwjSXP7QdQ8Eddtrn1qInMkFi6lBYdSA6MhS+VMmeXga4kWNvuO
 kHfghQHbN+GY9/y2o1jpk1Q77X59V/g+owDy3RcHeGR/bHxO5MjB01KnqEhi
X-Google-Smtp-Source: AGHT+IGQzw9towbWt3esYv6BylqAAAmG7i8maUZip7BzOASpnZ5frQ70BGwkwxAacACbTLNukHjFrw==
X-Received: by 2002:a05:6512:224c:b0:52e:a008:8f55 with SMTP id
 2adb3069b0e04-5331c6dcd38mr9613532e87.41.1724164198100; 
 Tue, 20 Aug 2024 07:29:58 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5330d41e1a0sm1782218e87.196.2024.08.20.07.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 07:29:57 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, xenia.ragiadakou@amd.com,
 jason.andryuk@amd.com, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org
Subject: [PATCH v2 04/12] hw/arm: xenpvh: Add support for SMP guests
Date: Tue, 20 Aug 2024 16:29:41 +0200
Message-ID: <20240820142949.533381-5-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820142949.533381-1-edgar.iglesias@gmail.com>
References: <20240820142949.533381-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12a.google.com
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

Add SMP support for Xen PVH ARM guests.
Create ms->smp.max_cpus ioreq servers to handle hotplug.

Note that ms->smp.max_cpus will be passed to us by the
user (Xen tools) set to the guests maxvcpus.

The value in mc->max_cpus is an absolute maximum for the
-smp option and won't be used to setup ioreq servers unless
the user explicitly specifies it with -smp.

If the user doesn't pass -smp on the command-line, smp.cpus
and smp.max_cpus will default to 1.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/arm/xen_arm.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index 5f75cc3779..fda65d0d8d 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -173,7 +173,7 @@ static void xen_arm_init(MachineState *machine)
 
     xen_init_ram(machine);
 
-    xen_register_ioreq(xam->state, machine->smp.cpus, &xen_memory_listener);
+    xen_register_ioreq(xam->state, machine->smp.max_cpus, &xen_memory_listener);
 
     xen_create_virtio_mmio_devices(xam);
 
@@ -218,7 +218,26 @@ static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
     MachineClass *mc = MACHINE_CLASS(oc);
     mc->desc = "Xen PVH ARM machine";
     mc->init = xen_arm_init;
-    mc->max_cpus = 1;
+
+    /*
+     * mc->max_cpus holds the MAX value allowed in the -smp command-line opts.
+     *
+     * 1. If users don't pass any -smp option:
+     *   ms->smp.cpus will default to 1.
+     *   ms->smp.max_cpus will default to 1.
+     *
+     * 2. If users pass -smp X:
+     *   ms->smp.cpus will be set to X.
+     *   ms->smp.max_cpus will also be set to X.
+     *
+     * 3. If users pass -smp X,maxcpus=Y:
+     *   ms->smp.cpus will be set to X.
+     *   ms->smp.max_cpus will be set to Y.
+     *
+     * In scenarios 2 and 3, if X or Y are set to something larger than
+     * mc->max_cpus, QEMU will bail out with an error message.
+     */
+    mc->max_cpus = GUEST_MAX_VCPUS;
     mc->default_machine_opts = "accel=xen";
     /* Set explicitly here to make sure that real ram_size is passed */
     mc->default_ram_size = 0;
-- 
2.43.0



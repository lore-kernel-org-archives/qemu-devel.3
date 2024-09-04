Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A77CD4F22
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 16:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slsg5-0002Cn-Nh; Wed, 04 Sep 2024 12:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1slsfk-0001FG-Ko; Wed, 04 Sep 2024 12:16:00 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1slsff-0002Gd-1a; Wed, 04 Sep 2024 12:15:52 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5356bb55224so348912e87.0; 
 Wed, 04 Sep 2024 09:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725466546; x=1726071346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+QaVLnXt0IgeqG1OF+UMCmmf0V+2Gd+nNBZAoCF8K30=;
 b=D6nnaplvvfiyJYVgHB+mKKe2Sx/ogFuk1POpArw0YQy9rr3W6Qk+k58aAw6mydYo2J
 AC2KQHuW8inLu6Z1DisseL+TQrhe88EbS8yE5+b9ZUuWmksHE5vEW0qNLGfU0S9oVXIf
 mEPr6nQGZMq7W22gwbBCFXXGF8Rg/OKn5iFWcXveSBTfffh5vZQ9wQeFeW6CGG+Q/AHH
 MT4lCfjxApuRINYDv0WTuwuBH6yMbm5sgZOLSyCK8xp22BKTt1GGlYcRaAAMi03pohtJ
 FN1uPTtqCzX3QfTnFkxb7FwQ+yBcqJblGZQgLlJ3c2o4QMIsMfymroEgPVQ5OGSca7nS
 m8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725466546; x=1726071346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+QaVLnXt0IgeqG1OF+UMCmmf0V+2Gd+nNBZAoCF8K30=;
 b=Jq3kJ+4E7+wNCpL2uG3GB7oREETieO1k8yjb+swSHxuhE0BXLXnikMvCpx54V5iEh5
 JUSzDk+Qhfwf3Hjte8cbT23MwPiTaMXaCgTbhxEXLjf/QoEcOCMfld0OOxYsPOlmsF7Z
 7Ci1BVLEAtaQLPh85Lor/qBC5L/6TPLejny0W9isB49qLKp+n6fJ8j4Ul964cnHlQBxO
 ermg/gHhbChlUaSpsNzDrpW5GW76h3p8iOUZnRX5g8J+Si4r7bzai7Nrc9+twfrXlT3W
 9dO4oFY1h53dnZpEbNy87Z/qglnG3O+NlaReMWVK7tYWl1hRNzalgRdyPO65EOJ5pbWz
 n5Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXK+2GjIQ+jEdetym/O2po6xxUUeuCtF9iZj1KBoAPCLgLcDiq33I9zyUmPCTJP4nAzVrtzJB2ncg==@nongnu.org
X-Gm-Message-State: AOJu0YxjCCpX0lWvJrSsrk94iFPP1S2ZKbX16sRbYqsFtQbbKk1YIAZX
 B36LOm1DKLhOyHVHfJ51JQKhk1Q/zqVPvfeNSandSS/4phJYr9xSqqk+8MVG
X-Google-Smtp-Source: AGHT+IEVrMi7SUj3gDc4PnljMDbfUGQS9M6WFx0DSiUFiYCkcinXMFPRnZOAOrty7uworisOgwpFVQ==
X-Received: by 2002:a05:6512:3e08:b0:52f:2ea:499f with SMTP id
 2adb3069b0e04-53546b3b1d7mr12943686e87.24.1725466546316; 
 Wed, 04 Sep 2024 09:15:46 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-535408286b2sm2393762e87.172.2024.09.04.09.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 09:15:45 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, xenia.ragiadakou@amd.com,
 jason.andryuk@amd.com, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org
Subject: [PULL v1 04/12] hw/arm: xenpvh: Add support for SMP guests
Date: Wed,  4 Sep 2024 18:15:28 +0200
Message-ID: <20240904161537.664189-5-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240904161537.664189-1-edgar.iglesias@gmail.com>
References: <20240904161537.664189-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x134.google.com
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
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CEFECF34A9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 14:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swMrW-0006Bs-2s; Thu, 03 Oct 2024 10:31:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1swMrS-0006Ab-5Y; Thu, 03 Oct 2024 10:31:22 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1swMrQ-0003wr-Jx; Thu, 03 Oct 2024 10:31:21 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-539885dd4bcso1333422e87.0; 
 Thu, 03 Oct 2024 07:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727965878; x=1728570678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7NqZgDSIdmym8k9v4wrElx9POiJdcsjS85l4BMSFw2Y=;
 b=UVeQZv4/Io8jMBSHA0aUpBQmGK8XKp9k0Di8GT0opisDt0VaZpyYE3P/bn5YbDXe49
 kFffsCHOMCdKlP8WXIVALVzObJkIH1Ti6Sc8lIZZi30YNfq2XfefP1fHyT2LliOnzO2H
 63hvJ7PB5NycJGq9a7iwaMHrzXe6f2Vy7+t5vqhl+NrzwxkhFO3oyVcbSIeJpd8WHKFp
 YFqUzAsUdi1uOih51ZGsWD/UsfXMdz7xIaJgrpxPLtNfgodgHtqGXibnh2lcSipPLsjm
 FT5LNFVFw++3d1yZ30eQSA+Pd+bbAYT+lgqfCdMJaJd87yhnHG1I8MV5O8jGpWDemCCP
 WZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727965878; x=1728570678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7NqZgDSIdmym8k9v4wrElx9POiJdcsjS85l4BMSFw2Y=;
 b=KRISi4yl6VTC0NWGo0cOOKCopR7Am5H0xp/GYc5ujZZQoYcxHV/nkJT98FvNBYFDMG
 ycV2rFkGOymgujRrGnRAhRI3LQ3pabCt5x7Qy1UCGuvxEWh5TWc1qCu6D7Fj/vCnG7UN
 1iXWVCxzyoTmXDaB4ZGuEGK4ltbiodus9+7LCEA7M+rEzqcBcic/nWNbXCtSv9W9Ro9k
 90Dm2YImiL5QiEWK3TR7GoBjB27MglQGy54rfb5VEiIBxU9y/nV4e9d7doyMC9eBXj5i
 RZCxpgKJtBw5XeFa905Y5vC8CB7UYD0VQ57CVtd1l0/Wwhe6VvPbRjzaV0AsZD06zl+j
 nXdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb8aWd1XQjY8PU+bX/sIsaxlXE/7xtz37twYievxwdBJtZJXzwxl9u4Csp4cWWeNYATlfA1RuXew==@nongnu.org
X-Gm-Message-State: AOJu0YzBCksheHLCy7qq92/7Q755CMsXuVXhNN7GV+wdc3lJMwgyRxLg
 jXp/w7zFRDOpf1Dud7qQiX1WKts8+mpbkyZsf024jFhO11kDx+QEVBoqdYdO
X-Google-Smtp-Source: AGHT+IET81PHAds/Q3QNcBRs8kVhS58wFGAWTG93rqF8wvxXNPYtyFncOLDYwbQheecmXThSjwTeoQ==
X-Received: by 2002:a05:6512:3da1:b0:539:93b2:1383 with SMTP id
 2adb3069b0e04-539a07a1d8emr4381480e87.46.1727965877639; 
 Thu, 03 Oct 2024 07:31:17 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-539a82570b4sm190849e87.91.2024.10.03.07.31.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 07:31:16 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org
Subject: [PULL v1 5/5] hw/arm: xenpvh: Enable PCI for ARM PVH
Date: Thu,  3 Oct 2024 16:31:02 +0200
Message-ID: <20241003143103.1476805-6-edgar.iglesias@gmail.com>
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

Enable PCI support for the ARM Xen PVH machine.

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/arm/xen-pvh.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
index 28af3910ea..33f0dd5982 100644
--- a/hw/arm/xen-pvh.c
+++ b/hw/arm/xen-pvh.c
@@ -39,6 +39,16 @@ static void xen_arm_instance_init(Object *obj)
                                          VIRTIO_MMIO_DEV_SIZE };
 }
 
+static void xen_pvh_set_pci_intx_irq(void *opaque, int intx_irq, int level)
+{
+    XenPVHMachineState *s = XEN_PVH_MACHINE(opaque);
+    int irq = s->cfg.pci_intx_irq_base + intx_irq;
+
+    if (xendevicemodel_set_irq_level(xen_dmod, xen_domid, irq, level)) {
+        error_report("xendevicemodel_set_pci_intx_level failed");
+    }
+}
+
 static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
 {
     XenPVHMachineClass *xpc = XEN_PVH_MACHINE_CLASS(oc);
@@ -69,7 +79,11 @@ static void xen_arm_machine_class_init(ObjectClass *oc, void *data)
     /* Xen/ARM does not use buffered IOREQs.  */
     xpc->handle_bufioreq = HVM_IOREQSRV_BUFIOREQ_OFF;
 
+    /* PCI INTX delivery.  */
+    xpc->set_pci_intx_irq = xen_pvh_set_pci_intx_irq;
+
     /* List of supported features known to work on PVH ARM.  */
+    xpc->has_pci = true;
     xpc->has_tpm = true;
     xpc->has_virtio_mmio = true;
 
-- 
2.43.0



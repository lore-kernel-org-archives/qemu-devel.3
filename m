Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF77C369AB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 16:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6u41-0007qh-Js; Mon, 21 Apr 2025 12:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u6u3y-0007ps-TP
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 12:32:06 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1u6u3x-0003Gs-5r
 for qemu-devel@nongnu.org; Mon, 21 Apr 2025 12:32:06 -0400
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-223fb0f619dso47132525ad.1
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 09:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745253123; x=1745857923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ohi+F3lKklXIM/TQUWoY9PCWQTYMsPvmzNWFHYG+80o=;
 b=jhxZX+rG/VojI+y7LWvJt4hZ2wViO2mm64eXGyJL/2ttYYrCwQ6BxkrFbtZysIXlxF
 N2Ar94wP980u4VixifLodovbIETQtWizBup8cZ3BrvQnVnicoNCHE4KDjpQF3GVqaGxm
 IMdlIhSgGfpSkMQiVOX0nwAfSBEe7pCFjF3B4B3pqEsar4fQ1VB4mxdx8mQrQforE80s
 yWVHgj3x0IP1rRtChnJ4TtzCJna9ybbLju7Nm/HgOqn5qKUoWMu4GS7UL9V+hEC1fBic
 I5a6C+zPQH1ybXimaMSg4bPcDYPQxvNVFKfLB4yScCzP/PNSG6cXGnXOw1Yv+/ADlO0O
 c7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745253123; x=1745857923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ohi+F3lKklXIM/TQUWoY9PCWQTYMsPvmzNWFHYG+80o=;
 b=cvs0cZtEXQivkcNg3zeOEbngEQ+qZGXeK9A1RPS614VXDxnUXeu1WcfiN/h/0L+Dbh
 mJb/igjd5zmwOav6QgYZ3tWuZn+bBqo4ywGLRJsYySsqpKqxF2Dj3gTE/Xiu6KGBuImi
 toKJqfB4aaNEXqgmmXc59H1KE8qYuE/3/330wewrbbcwrHPuIC2GJbE/W29fqj0fzusf
 IjRatpJMHndm+hDoBMaUFrtMrEvQnOydnIv8L+4b6vBvv1Rijhurms2zesKYejxWQ+o4
 PZO7K1y85/T4evBTyUFmQMOZFY4Zq6s2nibUD0XQTkkBd+4VIEGr0Jnb/6FCYzDaUINd
 eO5w==
X-Gm-Message-State: AOJu0Yz4Sdh5Y4E/3cnPErRhqIx30hww02Qf5rHhQif1S5icoCoBYfdi
 FehMgi6moWs79m5fWKHbMxLzm4qgzvF1+HK+cxoyrCrAzNx+FhA=
X-Gm-Gg: ASbGncsG9tIuxSJyJ5Ir1qpcsNaER9enNRpKxAMOdPoa+k7DZ85G9yzIAShj+/vRglp
 Eo1P+zUV8e3Nxl+jwY84alChxp3vmlPv6x0uXKE6FSFNDtqAh3oNvh2qxKxu1Ix6FdmddZszDYp
 D4+S7I51ms8COdQiN4wq/Cw3cg5ZeCwoX2/RIuU0ugXmAAYYpevZvCk3+vOA0BF9dsyHldtkJEu
 Fx3+4WlXx7U1tV4Xlh0aKE0CMtLMnrN2lFFcfj3sOM1aunuMcQZ4YkiQckdo4U66PYt+9iF3FtH
 WkkMbsC8o6B3WFNutI+QdGLd1v0LvkJIZTJLAw/oymMNckxNvnZ6Lfe8oxU2RlgY
X-Google-Smtp-Source: AGHT+IFlvhoND1PP68Fo4uUJYaEEpwQub9vgifjUTH0t/y5Hw0HrbBlL8jhJ7DM/HGgfpDU3meDMlQ==
X-Received: by 2002:a17:902:ce88:b0:223:5e6a:57ab with SMTP id
 d9443c01a7336-22c5360bdedmr170591465ad.39.1745253123514; 
 Mon, 21 Apr 2025 09:32:03 -0700 (PDT)
Received: from localhost.localdomain ([139.227.17.39])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50ed1997sm67778725ad.201.2025.04.21.09.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 09:32:03 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>
Subject: [PATCH 01/11] vfio/igd: Restrict legacy mode to Gen6-9 devices
Date: Tue, 22 Apr 2025 00:31:01 +0800
Message-ID: <20250421163112.21316-2-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250421163112.21316-1-tomitamoeko@gmail.com>
References: <20250421163112.21316-1-tomitamoeko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x643.google.com
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

Intel only provides legacy VBIOS for IGD up to Gen9, and there is no
CSM support on later devices. Additionally, Seabios can only handle
32-bit BDSM register used until Gen9. Since legacy mode requires VGA
capability, restrict it to Gen6 through Gen9 devices.

Link: https://lore.kernel.org/qemu-devel/20250325172239.27926-1-tomitamoeko@gmail.com/T/
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 hw/vfio/igd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
index 6678e0e5cd..01826acf10 100644
--- a/hw/vfio/igd.c
+++ b/hw/vfio/igd.c
@@ -516,11 +516,13 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
 
     /*
      * For backward compatibility, enable legacy mode when
+     * - Device geneation is 6 to 9 (including both)
      * - Machine type is i440fx (pc_piix)
      * - IGD device is at guest BDF 00:02.0
      * - Not manually disabled by x-igd-legacy-mode=off
      */
     if ((vdev->igd_legacy_mode != ON_OFF_AUTO_OFF) &&
+        (gen >= 6 && gen <= 9) &&
         !strcmp(MACHINE_GET_CLASS(qdev_get_machine())->family, "pc_piix") &&
         (&vdev->pdev == pci_find_device(pci_device_root_bus(&vdev->pdev),
         0, PCI_DEVFN(0x2, 0)))) {
@@ -565,7 +567,9 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
         vdev->features |= VFIO_FEATURE_ENABLE_IGD_LPC;
     } else if (vdev->igd_legacy_mode == ON_OFF_AUTO_ON) {
         error_setg(&err,
-                   "Machine is not i440fx or assigned BDF is not 00:02.0");
+                   "Machine is not i440fx, assigned BDF is not 00:02.0, "
+                   "or device %04x doesn't support legacy mode",
+                   vdev->device_id);
         goto error;
     }
 
-- 
2.47.2



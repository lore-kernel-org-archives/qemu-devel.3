Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA3ECD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11z-0005a1-U9; Thu, 07 May 2026 11:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11y-0005Vn-K2
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:54 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11w-00042F-Vw
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:54 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso10538695e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169171; x=1778773971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qmukM0rLu6/TpUZJMyD0+LRnOOucPeGB4MUjHA3sUKU=;
 b=ikPn8yOAEJn8OEVTWJVlnWqKouN44EdQy3nCz1X3vVSOwkJqiBol8rdUp77IKq0Uch
 NiJw6SPwSHBhKLOYGOls/9ywwu16OsxcBhVrHSqr+Fj1CNdRZ8N2m5B7V4wXMFMbGC+H
 WID4hjTNU9EfofZwuf5FYFB4m6roBn+njbJyaEq8awgkr+UO547wWqeYs36uwwNG8h8i
 iIUp8NwaVad/i/lhM1ekN6Rl0GN8BIZdv7Sa4w4pvEKPnyTejOl8WR7uIq3eRiLam5VL
 qMNLKEMQtbBYJkHByFEXCwJ0fsCmHTyqOBJ/o6XxJWZFi3NDm68ghf0CwovrUunNdHKe
 af1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169171; x=1778773971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qmukM0rLu6/TpUZJMyD0+LRnOOucPeGB4MUjHA3sUKU=;
 b=dl38cWyc+HKUGblRKcioH9qXlQkCRGOo8pv32MzedQpVztaU5N8wu2etOK6PJkrCx1
 5GvKkRcEDs4R0OcSUOQ9kRooz/3cQlqp5UBQgOUWpTbf2HI2TfDwDxeL8gHcoodpGh98
 GY3hEqbv2K7ypgNI80GxWebfWOl5k+N3cI1SEgPaw1g/90GS7F3oDCsI0/UfSJHwNgDx
 uZ1XqBD9yswSHrClHdhfXL34UrGmNHq86Eoy6hFIvcy3qGykUJSxvFfM9/TYLyf1ejKi
 YjLudGwmXG0t/xft4j58Yzu0fSn5j8RKmj/9JBowYXBYAFRN/zfe3wSIbBu6HzgG+tAI
 Ri+w==
X-Gm-Message-State: AOJu0YxpnEj96HWzMY7gGAumkB37xoJYNae700xZkSa3P6E5VeszzaKS
 euI1k6qzXLNDs2t04wS7Ox0+eMzhtTBbMcaC8G/s2VCjtcv6qwv4FvVlrcaEMwo6d5mGlhPNa0e
 +6Npv
X-Gm-Gg: AeBDieu2yYHssua6rXuwoWVAGtWKMfufR2BSeXQla+bvayAQQUQdKyLnk1tOejqCsD2
 n294zs54jQRKM8nm2fsffx/IaVljGoppJyeEfHMqLQYTV697wnQ6naKlNmd2rfMlFSz2O1bKXLt
 KejORWJ0R4t2g3dSQNfQu0kmXJFxxC6tW8+bYUdX3mDFXPkH1GCOT3ajczxouOlC2bVJZQn56DQ
 XVJSxhsZZLdXbAcZ+T0C3yYM3WKSQC0zoKxXwAUWqBRxWDdwt6Ssq9Pvd5NyptWyLay10c73qor
 0H7o18FE1iBllToM7Ec65nUmn1XR2bNJGD0wEpUZRLiGIUtLI5AGHgnXGN+uXySSqBBkFLH/r/Z
 oVtJOD9o7Ldbp14xGTeUUklyHnb33Bm3poG0ppCV8Wz4yRw0pXn1v0OTMf0cJTMwm4jE4L4aAlu
 SbGAQ3fwGgP+ktK8ek5VO3K49xj7kcjisWeX2tXF5hWJgL406vtduvIpwglCYu+BWo5t9jw+qKZ
 RhoKiplfbHeG+6u
X-Received: by 2002:a05:600c:354b:b0:486:fa35:aef2 with SMTP id
 5b1f17b1804b1-48e51e0c802mr134888425e9.4.1778169171409; 
 Thu, 07 May 2026 08:52:51 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 57/67] hw/arm/virt: Move MSI controller creation out of
 create_gic()
Date: Thu,  7 May 2026 16:51:44 +0100
Message-ID: <20260507155154.1886557-58-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The create_gic() function also creates the MSI controller; however
there isn't really a strong linkage here, and for the GICv5 it will
be more convenient to separate it out.  Move it to a new
create_msi_controller() function.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260327111700.795099-58-peter.maydell@linaro.org
---
 hw/arm/virt.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 58e05acb8c..a8d7f47040 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1285,11 +1285,21 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
     }
 
     fdt_add_gic_node(vms);
+}
 
-    if (vms->msi_controller == VIRT_MSI_CTRL_ITS) {
+static void create_msi_controller(VirtMachineState *vms)
+{
+    switch (vms->msi_controller) {
+    case VIRT_MSI_CTRL_ITS:
         create_its(vms);
-    } else if (vms->msi_controller == VIRT_MSI_CTRL_GICV2M) {
+        break;
+    case VIRT_MSI_CTRL_GICV2M:
         create_v2m(vms);
+        break;
+    case VIRT_MSI_CTRL_NONE:
+        break;
+    default:
+        g_assert_not_reached();
     }
 }
 
@@ -2856,6 +2866,7 @@ static void machvirt_init(MachineState *machine)
     virt_flash_fdt(vms, sysmem, secure_sysmem ?: sysmem);
 
     create_gic(vms, sysmem);
+    create_msi_controller(vms);
 
     virt_post_cpus_gic_realized(vms, sysmem);
 
-- 
2.43.0



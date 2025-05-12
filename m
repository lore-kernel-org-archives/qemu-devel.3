Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878D4C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJbP-000156-Cb; Sun, 11 May 2025 23:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJaW-0007zh-Dv; Sun, 11 May 2025 23:12:21 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJaT-0006pX-Rk; Sun, 11 May 2025 23:12:19 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-b268e4bfd0dso1514820a12.2; 
 Sun, 11 May 2025 20:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019536; x=1747624336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qw3QOgjxIAcD1Na4MRTwlaGEnVGZvj86P2/EE8eX4Is=;
 b=g/vJrsuRKYPnemeD/L0qQ8Ok5yfxjSFCsiakNtxuURr39tp1wjkezt/lzMxj519Xny
 CF18QorZePtN0Pz7CESOC5DtfeCIjaj98rFOnTVV4CtsOJtIv480hcv/b3osBEF9GqDi
 d/oKmNjm0RSX2m7gozEbU2XOZPuuae6vhCH/9ozcCuGG6CGHBwL7AtEziLoHNhbWF1AE
 UuQXglPEhBOL5rAVm6UdOz+eNwXa+kvbKvjNRVRxJnFuww6r93EZcpoCQ+wyhFMQ0GWv
 v2Bh9d4h5kkmb7aEVurbr0wUgagiK5iN0yeuGAvGgUAUT4qjONRxPCU2ukRaphRGaIRl
 r7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019536; x=1747624336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qw3QOgjxIAcD1Na4MRTwlaGEnVGZvj86P2/EE8eX4Is=;
 b=srAW0IoWUQB4rPUTgkVRmiHjBPISLNeCS/jAO3h6pglzt8GPpZ6U7rNOjIfo0dS4YU
 PxhFNn9JG3UaILlz3w4hjUvr1bL91szkSL+hgI4XgrVRgkJyjgkljH4wZ1sPUzf6o9GZ
 cX5YZC3YtYGIhRGQspiUiDAA5eYxpKU4tF50mZw8pLNsZmO97SqvkgUUtKh8nJDrwqi+
 IiqdBC7dDHB1PA/yuZfRWGpw2sGus7ETRY/bkvkyg8QnrgYWqJxmSOVp0RBsp90Uz50u
 CaJU4TVDj0KhEhOU+22U/PQLkt9wTjq0oK1oLb18LmoybU+IdrKCLvfdcN8D2rsRTdLV
 NkWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtAufXuNO4iujx9uTmI58h+POkZVzyRi+CRSpirCL50S/hDNsNL5m3XSJIwMJA0ooV1zqHHTIIUDfo@nongnu.org
X-Gm-Message-State: AOJu0YxxLYEQOazNmSwO8gEph9ZqQmw+Qm/HHOODX4vOm8v+LFydReqw
 oT6Ga8Y4dbYFTEaNblUI6WOO0QhDt1zSTFPNJMoT68wu38qk6ssU2Woqgg==
X-Gm-Gg: ASbGncsAL8cqyyPWbr9qDK8k9loX6yJiXCelFT5JfbIR2HQOI0hhBm6jDkFyyOytui+
 BsvBWR4vyQhl+QkG4AKZNsvmRhUT/4rY3WZvDbSdtPiUkagOj7L9wHUctieM0QGZevccbb/ufPL
 Ya71QddomViICM+2sRbgPUucU6B5uKFHgKnmFxCKwoeKUQ/l2sm90NeMPYyPq3Spbhq7d2EwWA5
 L87PJKxyxLstIc1cjCADBaYxu6XayfWEdvJWoe7xQtxa0fmlotuxHTwlgjqJyPmlz6aqEW+pm3D
 BOftNtBYXpO1WMpl2VEr33UHSCcHvBlsRKWQQWkLFDDc9sW8N4nIlaZv3w==
X-Google-Smtp-Source: AGHT+IElrI0fI2u7v9Ew/kl/laYL81jTHnafLU8w0dl2MG4G0nZdjgl5eMBnjpmvvNxx8PaUOXL/og==
X-Received: by 2002:a05:6a21:1788:b0:1f5:8655:3287 with SMTP id
 adf61e73a8af0-215abd23189mr17862362637.40.1747019535760; 
 Sun, 11 May 2025 20:12:15 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.12.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:12:15 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 18/50] pnv/xive2: Print value in invalid register write logging
Date: Mon, 12 May 2025 13:10:27 +1000
Message-ID: <20250512031100.439842-19-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512031100.439842-1-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x529.google.com
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

From: Michael Kowal <kowal@linux.ibm.com>

This can make it easier to see what the target system is trying to
do.

[npiggin: split from larger patch]
Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
---
 hw/intc/pnv_xive2.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
index d7ca97ecbb..fcf5b2e75c 100644
--- a/hw/intc/pnv_xive2.c
+++ b/hw/intc/pnv_xive2.c
@@ -1197,7 +1197,8 @@ static void pnv_xive2_ic_cq_write(void *opaque, hwaddr offset,
     case CQ_FIRMASK_OR: /* FIR error reporting */
         break;
     default:
-        xive2_error(xive, "CQ: invalid write 0x%"HWADDR_PRIx, offset);
+        xive2_error(xive, "CQ: invalid write 0x%"HWADDR_PRIx" value 0x%"PRIx64,
+                    offset, val);
         return;
     }
 
@@ -1495,7 +1496,8 @@ static void pnv_xive2_ic_vc_write(void *opaque, hwaddr offset,
         break;
 
     default:
-        xive2_error(xive, "VC: invalid write @%"HWADDR_PRIx, offset);
+        xive2_error(xive, "VC: invalid write @0x%"HWADDR_PRIx" value 0x%"PRIx64,
+                    offset, val);
         return;
     }
 
@@ -1703,7 +1705,8 @@ static void pnv_xive2_ic_pc_write(void *opaque, hwaddr offset,
         break;
 
     default:
-        xive2_error(xive, "PC: invalid write @%"HWADDR_PRIx, offset);
+        xive2_error(xive, "PC: invalid write @0x%"HWADDR_PRIx" value 0x%"PRIx64,
+                    offset, val);
         return;
     }
 
@@ -1790,7 +1793,8 @@ static void pnv_xive2_ic_tctxt_write(void *opaque, hwaddr offset,
         xive->tctxt_regs[reg] = val;
         break;
     default:
-        xive2_error(xive, "TCTXT: invalid write @%"HWADDR_PRIx, offset);
+        xive2_error(xive, "TCTXT: invalid write @0x%"HWADDR_PRIx
+                    " data 0x%"PRIx64, offset, val);
         return;
     }
 }
@@ -1861,7 +1865,8 @@ static void pnv_xive2_xscom_write(void *opaque, hwaddr offset,
         pnv_xive2_ic_tctxt_write(opaque, mmio_offset, val, size);
         break;
     default:
-        xive2_error(xive, "XSCOM: invalid write @%"HWADDR_PRIx, offset);
+        xive2_error(xive, "XSCOM: invalid write @%"HWADDR_PRIx
+                    " value 0x%"PRIx64, offset, val);
     }
 }
 
@@ -1929,7 +1934,8 @@ static void pnv_xive2_ic_notify_write(void *opaque, hwaddr offset,
         break;
 
     default:
-        xive2_error(xive, "NOTIFY: invalid write @%"HWADDR_PRIx, offset);
+        xive2_error(xive, "NOTIFY: invalid write @%"HWADDR_PRIx
+                    " value 0x%"PRIx64, offset, val);
     }
 }
 
@@ -1971,7 +1977,8 @@ static void pnv_xive2_ic_lsi_write(void *opaque, hwaddr offset,
 {
     PnvXive2 *xive = PNV_XIVE2(opaque);
 
-    xive2_error(xive, "LSI: invalid write @%"HWADDR_PRIx, offset);
+    xive2_error(xive, "LSI: invalid write @%"HWADDR_PRIx" value 0x%"PRIx64,
+                offset, val);
 }
 
 static const MemoryRegionOps pnv_xive2_ic_lsi_ops = {
@@ -2074,7 +2081,8 @@ static void pnv_xive2_ic_sync_write(void *opaque, hwaddr offset,
         inject_type = PNV_XIVE2_QUEUE_NXC_ST_RMT_CI;
         break;
     default:
-        xive2_error(xive, "SYNC: invalid write @%"HWADDR_PRIx, offset);
+        xive2_error(xive, "SYNC: invalid write @%"HWADDR_PRIx" value 0x%"PRIx64,
+                    offset, val);
         return;
     }
 
-- 
2.47.1



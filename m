Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1CACD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 13:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMQ9S-0003AA-53; Mon, 11 May 2026 08:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agarwal.vineet2006@gmail.com>)
 id 1wMPIm-0002UW-Oe
 for qemu-devel@nongnu.org; Mon, 11 May 2026 08:00:00 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <agarwal.vineet2006@gmail.com>)
 id 1wMPIk-0001eb-PJ
 for qemu-devel@nongnu.org; Mon, 11 May 2026 08:00:00 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-367cbac9cb1so2015228a91.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 04:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778500796; x=1779105596; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tBn1VGxNnAc4aB1p1N+PvHCKFDMtL5hRTj5MOOdEZoU=;
 b=sW9bF0JDyNNfrixqwBZ+aya53h3UwX2NImrDkma/Vi3R4FPBCKunvigbRaRDOviuSW
 A8y03jrUfV7MLP+sYGNyMuNgRV6MdhDVBpv5bzEIuSxzltm/NykUmHtSpVU7ypGXiOz6
 h66CvfHKcJDswxfsKLcHgVa/tCd3ERB9FrkP0+gUhYoJ1+bJz3RwhHZ8x1ZzyCL3oEPA
 HBTE3Aat2zIihBp74w0fMphk5qiO21Wa7clgp1frFjcjAOpYJles2iDk3hcLIHTYvTnn
 WDONINdBPDMirs93CrNVyTQtBJh7U1ihovFhgOyV08PtUj95qOEL5h9qf9kUZG0+nZz3
 cp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778500796; x=1779105596;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tBn1VGxNnAc4aB1p1N+PvHCKFDMtL5hRTj5MOOdEZoU=;
 b=flooA7Py/DxEXSS3+8ZBK8DMoUAa3crifNskHbWG2ORea+0azqBZyXSTfHetldUyag
 KKvbDVc9/dNEJcprd+Friz3nSDadETDIuffhP61XefytmiLmtv2TbvAx0y1tjVdh79G0
 /ezKdSkfqg4hp2sxcDhIhVVRT52pAMW5ir0RRM4epz9XY9hGQN2l+m8+QZr9HxM181Uw
 t1ba8Wx8HatP/VLh73nDpSz8GCEZmnXaVeTZKtRzmEoIrKBd/BVtP8TugmM9R1IgYD5R
 vkpP2kEx6twp7rmJ5cAioeKDoBSx3QHM+nJoTuC4VO3HmCnOQo3oQeGkkDlkxZ7I+Pir
 9k/w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9MCe4ilBK4H/oRLrgmXkyrb9l+CKuxMMSr+4AYK+IdMVevvikR4RLiXyAG1CNrIOFzWqfdXn7MPuP8@nongnu.org
X-Gm-Message-State: AOJu0Yz6qaCxUPTsG9E0Bxw2DiZJgXI4CIOIccUT/WHfeEoyaMIBWIYx
 +sbk11t5I0o5Pq64gVd6W9pFbQPchAr4qI0cJsKv9GRZJArDnnlBzy9j
X-Gm-Gg: Acq92OE1vpTjmnp4smZClKTxMA3Kt4g+esbaG5ClLqya8p5rPlc9H7uKAtyM06ixtJ5
 zHkoo9Rp8xNN2H6oMiWxh62e8H7B0y6XZxarIdZ+d0iD4evrdvGWsFeSmqW/KTzN8NXOvUtCju2
 ev9jaOXF/Ygc6PCBTwYnNOs3hjwA2t/4tMmQqBOhLIMESkFWsI12m8e05lY6ubRsJw+svIgiVcA
 S1Yh3Lu8tOJmza56ex9MRLwSyZqSKmYBmOlPa3ldVpkLqie5/QQguVN6Ut/OAXe+6yDspEA/DRB
 b1pKhKia0WB2GB3pHWzsMN92w2B6KDZk4n1yixdMYinBOnlWVwFOVNHysh4+xERKooQeolQo/Bl
 ckUAbySsyE3I32Qj2vxcGUpwIc0sbIvHGH1LUvjlcXNL6FX9bdXoO169G6FYU/AmQwW6Wk5488i
 lVBRevDNgfBk0aJsmandbn2AiR1fblaw==
X-Received: by 2002:a17:90b:5603:b0:366:479c:59e7 with SMTP id
 98e67ed59e1d1-366479c5dc4mr15361917a91.4.1778500796514; 
 Mon, 11 May 2026 04:59:56 -0700 (PDT)
Received: from vini ([2401:4900:8fc8:73c6:dda6:576b:fa0d:f68e])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-367d65ed459sm9891405a91.14.2026.05.11.04.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 04:59:56 -0700 (PDT)
From: Vineet Agarwal <agarwal.vineet2006@gmail.com>
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, Vineet Agarwal <agarwal.vineet2006@gmail.com>
Subject: [PATCH] hw/arm: fsl-imx8mm: Don't call qdev_get_machine in init
Date: Mon, 11 May 2026 17:29:18 +0530
Message-ID: <20260511115918.32765-1-agarwal.vineet2006@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=agarwal.vineet2006@gmail.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 11 May 2026 08:54:02 -0400
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

Calling qdev_get_machine() from fsl_imx8mm_init() can trigger
an assertion failure because the machine may not be created yet.

Reproducer:

  ./qemu-system-aarch64 -S -display none \
      -M virt -device fsl-imx8mm,help

This hits:

../hw/core/qdev.c:844: Object *qdev_get_machine(void):
Assertion `dev' failed.

Move the CPU initialization into realize(), where accessing the
machine state is safe.

Signed-off-by: Vineet Agarwal <agarwal.vineet2006@gmail.com>
---
 hw/arm/fsl-imx8mm.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/arm/fsl-imx8mm.c b/hw/arm/fsl-imx8mm.c
index 97c3f8542c..875e92bb34 100644
--- a/hw/arm/fsl-imx8mm.c
+++ b/hw/arm/fsl-imx8mm.c
@@ -157,16 +157,9 @@ static const struct {
 
 static void fsl_imx8mm_init(Object *obj)
 {
-    MachineState *ms = MACHINE(qdev_get_machine());
     FslImx8mmState *s = FSL_IMX8MM(obj);
-    const char *cpu_type = ms->cpu_type ?: ARM_CPU_TYPE_NAME("cortex-a53");
     int i;
 
-    for (i = 0; i < MIN(ms->smp.cpus, FSL_IMX8MM_NUM_CPUS); i++) {
-        g_autofree char *name = g_strdup_printf("cpu%d", i);
-        object_initialize_child(obj, name, &s->cpu[i], cpu_type);
-    }
-
     object_initialize_child(obj, "gic", &s->gic, gicv3_class_name());
 
     object_initialize_child(obj, "ccm", &s->ccm, TYPE_IMX8MP_CCM);
@@ -229,6 +222,8 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
     MachineState *ms = MACHINE(qdev_get_machine());
     FslImx8mmState *s = FSL_IMX8MM(dev);
     DeviceState *gicdev = DEVICE(&s->gic);
+    const char *cpu_type =
+        ms->cpu_type ?: ARM_CPU_TYPE_NAME("cortex-a53");
     int i;
 
     if (ms->smp.cpus > FSL_IMX8MM_NUM_CPUS) {
@@ -237,6 +232,12 @@ static void fsl_imx8mm_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    for (i = 0; i < ms->smp.cpus; i++) {
+        g_autofree char *name = g_strdup_printf("cpu%d", i);
+        object_initialize_child(OBJECT(dev), name,
+                                &s->cpu[i], cpu_type);
+    }
+
     /* CPUs */
     for (i = 0; i < ms->smp.cpus; i++) {
         /* On uniprocessor, the CBAR is set to 0 */
-- 
2.54.0



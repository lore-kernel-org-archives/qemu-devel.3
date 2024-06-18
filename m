Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B89C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbLN-0006PY-Rr; Tue, 18 Jun 2024 12:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbLF-0006PE-Hp
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:05:53 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbLD-0007jV-LF
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:05:53 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-362f62ae4c5so120809f8f.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726750; x=1719331550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KzZq3iGA+Ys+b27eQPwLx5mcriu5b6pZoRIjvgOYd8M=;
 b=e8h/2AfyKnK3l7aVl4AN8Rzky0GrIIOYTQqJq0d3WaKkQTDGV43dJOgQhTREfKVjy9
 Ypn1IEjrTS6DuacOnjbrOISQAyNPR8/1RlQWQoW9/mzKpP4uDPJGpjqltOdpcWdND47J
 06aeaBJ86FopD+JqCMB5ws8taqWhG8q0ZhPjjcbTr1MHRRkdMcLVotzD5pxtGzXmy/8i
 7USeyp0qwOQar+JfaaosRgoO+rn05OtBwoqW4iDvQmlQf7hbGdDMyuhwJT1SyBX/qNet
 Lwm44tRYLBUeK7FgmeAqoNaqbwaBmnbExIOf/fqhCcbc5Mo3X5nsVpxG0LBoBW8+X17/
 jN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726750; x=1719331550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KzZq3iGA+Ys+b27eQPwLx5mcriu5b6pZoRIjvgOYd8M=;
 b=ICS7q8s6PeuNlhGdMI/xlCttFN80RdJ4iJRodEBRJlnnHEEhe7G8kPUuyALbiGJfA2
 OeSD1FaeuZKIDPKdeYsCeU4ezlbl4iWXl1zOHz+GIPc7H/AVGghy+nHtoKpC+JxUIeE+
 Zgc2iEp/cwnYjt6BkN5/d/ckyZYIowIFC79NgWSseJ52c/9yNZqdMulHDmWUghGCaemF
 M/Qyj7xVHtex89AOhPZeL6mOo7yjrHMuylvQ2VQRjIzo38G46v2WaO+xqIwzPC0wiVy1
 2w4TaUhgTAIi00RB9L02hlx3FIgXizhlpx5RC94q4ob76p1phZXcqma+xY/+DiembdX2
 gEOA==
X-Gm-Message-State: AOJu0YzlOJqA5sfKiuI6N8JxEXqf1YanNyIs2oWSTJyf5VFb6QtNDPyu
 gLWXgnOjSCHpTCBb2GBUooj+3CxdjzTXOx4umg/9Q0BSlDmxKbssyXTLbhKP8nQbfB1jFH1V6ub
 B
X-Google-Smtp-Source: AGHT+IGwfHe86djaPMrWAqocVmLNPm1nYoZM7OOGcLLDZ/ENSv/6Ap22PcNYws88XdJc3NtaUGczDw==
X-Received: by 2002:a5d:4052:0:b0:362:8138:f45e with SMTP id
 ffacd0b85a97d-362ffb429d4mr362808f8f.17.1718726749759; 
 Tue, 18 Jun 2024 09:05:49 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36075093a3fsm14582256f8f.1.2024.06.18.09.05.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:05:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 53/76] ppc/pnv: Introduce pnv_chip_foreach_cpu()
Date: Tue, 18 Jun 2024 18:00:15 +0200
Message-ID: <20240618160039.36108-54-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Cédric Le Goater <clg@redhat.com>

This helper routine uses the machine definition, sockets, cores and
threads, to loop on all CPUs of the machine. Replace CPU_FOREACH()
with it.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240424093048.180966-1-clg@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/pnv.c | 50 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 13 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 03c595788f..6b41d1d2dd 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2261,6 +2261,21 @@ PowerPCCPU *pnv_chip_find_cpu(PnvChip *chip, uint32_t pir)
     return NULL;
 }
 
+static void pnv_chip_foreach_cpu(PnvChip *chip,
+                   void (*fn)(PnvChip *chip, PowerPCCPU *cpu, void *opaque),
+                   void *opaque)
+{
+    int i, j;
+
+    for (i = 0; i < chip->nr_cores; i++) {
+        PnvCore *pc = chip->cores[i];
+
+        for (j = 0; j < CPU_CORE(pc)->nr_threads; j++) {
+            fn(chip, pc->threads[j], opaque);
+        }
+    }
+}
+
 static ICSState *pnv_ics_get(XICSFabric *xi, int irq)
 {
     PnvMachineState *pnv = PNV_MACHINE(xi);
@@ -2329,22 +2344,25 @@ static ICPState *pnv_icp_get(XICSFabric *xi, int pir)
     return cpu ? ICP(pnv_cpu_state(cpu)->intc) : NULL;
 }
 
+static void pnv_pic_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
+                                    void *opaque)
+{
+    PNV_CHIP_GET_CLASS(chip)->intc_print_info(chip, cpu, opaque);
+}
+
 static void pnv_pic_print_info(InterruptStatsProvider *obj, GString *buf)
 {
     PnvMachineState *pnv = PNV_MACHINE(obj);
     int i;
-    CPUState *cs;
-
-    CPU_FOREACH(cs) {
-        PowerPCCPU *cpu = POWERPC_CPU(cs);
-
-        /* XXX: loop on each chip/core/thread instead of CPU_FOREACH() */
-        PNV_CHIP_GET_CLASS(pnv->chips[0])->intc_print_info(pnv->chips[0], cpu,
-                                                           buf);
-    }
 
     for (i = 0; i < pnv->num_chips; i++) {
-        PNV_CHIP_GET_CLASS(pnv->chips[i])->pic_print_info(pnv->chips[i], buf);
+        PnvChip *chip = pnv->chips[i];
+
+        /* First CPU presenters */
+        pnv_chip_foreach_cpu(chip, pnv_pic_intc_print_info, buf);
+
+        /* Then other devices, PHB, PSI, XIVE */
+        PNV_CHIP_GET_CLASS(chip)->pic_print_info(chip, buf);
     }
 }
 
@@ -2545,12 +2563,18 @@ static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
     }
 }
 
+static void pnv_cpu_do_nmi(PnvChip *chip, PowerPCCPU *cpu, void *opaque)
+{
+    async_run_on_cpu(CPU(cpu), pnv_cpu_do_nmi_on_cpu, RUN_ON_CPU_NULL);
+}
+
 static void pnv_nmi(NMIState *n, int cpu_index, Error **errp)
 {
-    CPUState *cs;
+    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
+    int i;
 
-    CPU_FOREACH(cs) {
-        async_run_on_cpu(cs, pnv_cpu_do_nmi_on_cpu, RUN_ON_CPU_NULL);
+    for (i = 0; i < pnv->num_chips; i++) {
+        pnv_chip_foreach_cpu(pnv->chips[i], pnv_cpu_do_nmi, NULL);
     }
 }
 
-- 
2.41.0



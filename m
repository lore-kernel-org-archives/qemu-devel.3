Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA6CC2BB85
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 16:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJbJF-0000Ss-3c; Tue, 18 Jun 2024 12:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbJD-0000Jn-8D
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:03:47 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJbJB-0007Cp-Eu
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 12:03:47 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a6f958a3a69so128999266b.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 09:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718726623; x=1719331423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=krPmmezu/ZiSsAEmiOwTBGR2YHLemSWbvTZgat4esgU=;
 b=kXIMsOE91cmF24ygAsPh2qHliZMam4DFnwYhDLegrKb3tv+6ACPdU8ajX4ag4SkHmf
 UubEKlf75Z6vdkCVBP/sEm6cLIKs1x4js9XioeI49LX0r7ptJJzRNEQsBaEoblnFVcm0
 L6Q8/55gF+F+hgoKXDvDBFDtEBDkxIf2X2bMpTJq4KFeONg/OU8A5KPGLX/CzOeqU1Wd
 7e5ieuYmR/8ocdAbxjqaFE+U+rurMtKB5d92PcHm8ZLKb2Cvifa+zbIlSNwXbjtNFTy/
 JPm6ScRLXMhbi5MZ14inmTUbcVx4Wgab5J70UScShqFja6cdQWy0FM7Str6EextsXUtd
 ZACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718726623; x=1719331423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=krPmmezu/ZiSsAEmiOwTBGR2YHLemSWbvTZgat4esgU=;
 b=TJaEI6XfeghORgC/Efb6x4rAu/M5qWZO4WSyz6kE+Nlei0CsINCAoFJIXmET52qaly
 qqC4ohYa4z5i5wpSZkX0KaDmipU0MNd7fC9Scq1rHyCKliHdL7seZHc75ZrpeM7CNrPt
 PMiltyGPXm7LSgHhS3PGxt+rhUVW443e0FwdYSZS8mm5u3rl4bwE25RW8DLZR9Hd6XG6
 D2PczZjqDJhAEzRnhwLHN52/FdmHDRvh9Y+spBieE+QuYSEzRZJ998Ygo9g3/upzcS+C
 T+62TG1wgIACVSIxLatq0V775BnrpLI91Er4k+4q3QCv0Qiewg3LTdufwluayTGTS75F
 NNcg==
X-Gm-Message-State: AOJu0YyITAttM8P3JLXxJdhfm5v+V2/4jCwm3HFOLQEq3ujNsclzjFFY
 o5e/Kk7RzUgpBgV8Z29/aeha2wCtr6rwYboTlaG82jFvQT9DSTosS2CjonSK9bX7sTZAkqm5m/k
 M
X-Google-Smtp-Source: AGHT+IHai8HShAwOS7bG4/I7Ta5HFUmfP6zr3dUiwCjm569R+Mr3Vfy/gK0ODA/CDcmwP+vAIdBhUQ==
X-Received: by 2002:a17:906:2288:b0:a6f:1443:1e24 with SMTP id
 a640c23a62f3a-a6f60d3fd34mr839471766b.34.1718726623576; 
 Tue, 18 Jun 2024 09:03:43 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f5f377dd8sm577968866b.146.2024.06.18.09.03.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Jun 2024 09:03:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 31/76] hw/ppc: Avoid using Monitor in
 spapr_xive_end_pic_print_info()
Date: Tue, 18 Jun 2024 17:59:53 +0200
Message-ID: <20240618160039.36108-32-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240618160039.36108-1-philmd@linaro.org>
References: <20240618160039.36108-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

Replace Monitor API by HumanReadableText one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Message-Id: <20240610062105.49848-8-philmd@linaro.org>
---
 hw/intc/spapr_xive.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 3357f6325f..d571645e9e 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -133,7 +133,7 @@ static int spapr_xive_target_to_end(uint32_t target, uint8_t prio,
  * structure dumping only the information related to the OS EQ.
  */
 static void spapr_xive_end_pic_print_info(SpaprXive *xive, XiveEND *end,
-                                          Monitor *mon)
+                                          GString *buf)
 {
     uint64_t qaddr_base = xive_end_qaddr(end);
     uint32_t qindex = xive_get_field32(END_W1_PAGE_OFF, end->w1);
@@ -142,17 +142,12 @@ static void spapr_xive_end_pic_print_info(SpaprXive *xive, XiveEND *end,
     uint32_t qentries = 1 << (qsize + 10);
     uint32_t nvt = xive_get_field32(END_W6_NVT_INDEX, end->w6);
     uint8_t priority = xive_get_field32(END_W7_F0_PRIORITY, end->w7);
-    g_autoptr(GString) buf = g_string_new("");
-    g_autoptr(HumanReadableText) info = NULL;
 
-    monitor_printf(mon, "%3d/%d % 6d/%5d @%"PRIx64" ^%d",
-                   spapr_xive_nvt_to_target(0, nvt),
-                   priority, qindex, qentries, qaddr_base, qgen);
+    g_string_append_printf(buf, "%3d/%d % 6d/%5d @%"PRIx64" ^%d",
+                           spapr_xive_nvt_to_target(0, nvt),
+                           priority, qindex, qentries, qaddr_base, qgen);
 
     xive_end_queue_pic_print_info(end, 6, buf);
-
-    info = human_readable_text_from_str(buf);
-    monitor_puts(mon, info->human_readable_text);
 }
 
 /*
@@ -198,13 +193,18 @@ static void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon)
         if (!xive_eas_is_masked(eas)) {
             uint32_t end_idx = xive_get_field64(EAS_END_INDEX, eas->w);
             XiveEND *end;
+            g_autoptr(GString) buf = g_string_new("");
+            g_autoptr(HumanReadableText) info = NULL;
 
             assert(end_idx < xive->nr_ends);
             end = &xive->endt[end_idx];
 
             if (xive_end_is_valid(end)) {
-                spapr_xive_end_pic_print_info(xive, end, mon);
+                spapr_xive_end_pic_print_info(xive, end, buf);
             }
+
+            info = human_readable_text_from_str(buf);
+            monitor_puts(mon, info->human_readable_text);
         }
         monitor_printf(mon, "\n");
     }
-- 
2.41.0



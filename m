Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13BBAC5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN1N-0001YJ-NX; Fri, 21 Aug 2026 07:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN19-0000rD-P2
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:39 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN17-0007XU-Cc
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:34 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so7649295e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310152; x=1787914952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=muWelDIkKhwsnf65Reqp+M147kq5TOZnbTDn96C2YPk=;
 b=RN6cbQyKxZF8fEdZUMsnWCEgIsp8M6O+nM+BHjKIHYiO8gsq6eqZoeCYdCADbgmwD6
 nP+4f3pbXGL9zXvRvgXTwK62MQD+LhyHPNJ5MdYSGQeH4xFdGjGvbtfI0vLCLfoNL4ob
 +xvRx7lGYguMyhS/h/26kKHbNrOq1/wzYvy0xdVcjgZlc5MmLqlAA/OMHECaASj+K6wp
 8R4GLhPOuufB/R5sH0T64m75m/N1+LXSSKk7yyO0d5Dc8IUY8DVnnOiTDCvuO/xmaHkS
 gejDNmG4+tfXYl5CnUqfy4hO+NOXRKdm8MpWJXy/aHt5RgfS3ibW4LBCa3IEx9HPCy2b
 5bhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310152; x=1787914952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=muWelDIkKhwsnf65Reqp+M147kq5TOZnbTDn96C2YPk=;
 b=BP7MoAIW4m10L8tnJbAR2c+O0l3KALn4quzvRU71TaIDNyvBiuElwvGzCV+rIRF9n+
 DZvx6ys4YCLS85foYx9G5YvqCc+QrNUFLXYlKNGnwxNL8JKiZg+OfE8dfQFvThbfnjRF
 yTXYDMO2RrX9q/F94GhNow1K7fLWCHjvaoLB65fY2VgvfwuEnPJlYZJwQ1+zobrvjMKe
 k5xTfboWEMNYrR0nbZ8fslR5faFNihdEfGxUPvbIo/MTjDx7UjeA5yYUag4iEH2b+kph
 H0iUc1FYPur92FIiTvtc3lUReXDLXbSQrU54T8i+W28GQoAD8EzjnFWzIWTVu1CXoUX9
 uw4g==
X-Gm-Message-State: AOJu0YwDs4VX2cziOshHw7XiTSJSTblBEmojMLXVex69VjxNmYEL6pJF
 0f79zJPL0Iplo0XrFl/QUIjW1HjYGMnSLBoCSJFjKa/xwRpV+xWP/3NSJxX82oU7EyR95BRHOcr
 70Z29
X-Gm-Gg: AR+sD13/MpenwCx72Jo767/Dj2aO1PDadSRCqeVHuxPRYOjDxbbhqAmnJjU8526kX0A
 bumzDvI7TO6j3EXAMHAXgwsMAkX90VqVbiBd4dSSQGrMZ/HTJQe4w7N5iOvlB/mR8sCiQQ1Kbe0
 Kh38YeN2lAo4y8UH9T7wZFKyjVV5ql1pj/mc6wosT1q8h8mm9RX14eP7RbXQe2VPv9cRIiSdLF/
 zi/e7SVj7qCFs6LsoD1qvA3JinM/NFca0ayP7gkWfAn6EdQi7tmKsZTH7vTVuV1RdFuiDJCBTOc
 xtdb/t9i79IRoE4cYG2M7EkChT7MDTYHUmWeNhKWp71DjEu8FtRuFD44QxPiAEcW7CVz4Akr+0h
 1S06JXViBYiKT4Iio7upouUBz/LJ6LoV5Bwu1yOywkQ7/Rq1AbI+fVL3SDdZdc+PSl7cg9FTgLk
 82IH8B/BliOqrvQrbVt1gi7+5LTT8chU2Ze1xBKijZJpgyIj1fll3CEojhm+nEXNAHTyXRBl29v
 mUeXTNI/zfWLWJAaVTM3EuBCW2KpVLbkztRbXrCCGlnMzZatqPfke0J3Q+m1rXk1qn6smWb3R1X
 ILX49eALmg==
X-Received: by 2002:a05:600c:4f09:b0:499:ad2e:f7bc with SMTP id
 5b1f17b1804b1-499b8455734mr77650545e9.10.1787310151976; 
 Fri, 21 Aug 2026 04:02:31 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.02.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:02:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/43] hw/arm: imx25_pdk: Store boot info in the board state
Date: Fri, 21 Aug 2026 12:00:48 +0100
Message-ID: <20260821110101.3971391-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Bin Meng <bin.meng@processmission.com>

arm_load_kernel() keeps a pointer to the boot info struct for the
lifetime of the VM, so the struct logically belongs to the machine
rather than to a file scoped static object.

The IMX25PDK struct is already allocated per machine instance, so
move the boot info there.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Message-id: 20260816131300.51799-8-bin.meng@processmission.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/imx25_pdk.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index 7ebd6c8eb9c..f7a51481af0 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -61,10 +61,9 @@
 typedef struct IMX25PDK {
     FslIMX25State soc;
     MemoryRegion ram_alias;
+    struct arm_boot_info bootinfo;
 } IMX25PDK;
 
-static struct arm_boot_info imx25_pdk_binfo;
-
 static void imx25_pdk_init(MachineState *machine)
 {
     IMX25PDK *s = g_new0(IMX25PDK, 1);
@@ -114,9 +113,9 @@ static void imx25_pdk_init(MachineState *machine)
         alias_offset += ram[i].size;
     }
 
-    imx25_pdk_binfo.ram_size = machine->ram_size;
-    imx25_pdk_binfo.loader_start = FSL_IMX25_SDRAM0_ADDR;
-    imx25_pdk_binfo.board_id = 1771;
+    s->bootinfo.ram_size = machine->ram_size;
+    s->bootinfo.loader_start = FSL_IMX25_SDRAM0_ADDR;
+    s->bootinfo.board_id = 1771;
 
     for (i = 0; i < FSL_IMX25_NUM_ESDHCS; i++) {
         BusState *bus;
@@ -138,7 +137,7 @@ static void imx25_pdk_init(MachineState *machine)
      * fail.
      */
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->soc.cpu, machine, &imx25_pdk_binfo);
+        arm_load_kernel(&s->soc.cpu, machine, &s->bootinfo);
     }
 }
 
-- 
2.43.0



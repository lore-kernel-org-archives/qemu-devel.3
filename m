Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674BFC5DF92
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:03:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN1L-0001NS-Bo; Fri, 21 Aug 2026 07:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN1D-0000vF-7Z
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:39 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN1B-0007YM-DX
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:38 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-496bb7cdf51so8319615e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310155; x=1787914955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4rTL3SdYHRUqGgeIh0nHgD5mJ1eWi+Ul3pcLYk9c+W4=;
 b=GMVLzeY20zhWqh7qWUkIbJw5aIXH6WG8z2Y02rydPUAbKYNNOWKef1/Z5n5wIIbRHq
 p8RyJ/1Ym7ulusI+2Fo2YKf+uBHJ9N0fRpy6Tf//4Sjwkn6XQ+kHYNiWhw/NYS07J8z8
 CDKFyXdHvLIxPyjmXhjZY9dGwp4UqqPriiwxVnRmtEBzEHnZqeOYGT8bhTIEhQq9QGJR
 Cjfvgnw+7+aY6t0ZIMn9cJ+VbUmyF3w56c5TPDtaFb67iO0RoY63FSmIPdQ9B69pKSiO
 pGRSeTp+gk6rlOyxIHSiHh5ClwPQmKj3rI7PpJYLuJvWymyC1mFmjBKLjYiU3YfF1ZDy
 GMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310155; x=1787914955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4rTL3SdYHRUqGgeIh0nHgD5mJ1eWi+Ul3pcLYk9c+W4=;
 b=EvnbGLPD5F7xGXtu6VXkAPQmDtLmfVqgKL/ikAOZVG+jjF+nXY9kjV6TrzmZQoPwD+
 14Pe5GAmEH98jivGGJxFvPqwYAxNXxRMDQxo2hjOsgnbpwpojaD6G2SVKzFpFKcMU7m6
 Tb14bHaDJbeMWjQRm8P6uazV1scW5xCdKrmYQPDKYC4zi3PQYh7/lWIkfSJgtfqQzY6C
 IGWnlmaFkoJhPqu4EKu83kcomLM8irmPbj2+64V2glRFtWcwokpQqdO0zYVVNA86CoMn
 EMFmNltpb4Op7MmStB2aWXDBImVimqHZWenjuhceiS0yqE3ll7SCm5nYgehgRzD6Xxm0
 E4zw==
X-Gm-Message-State: AOJu0YzPZKFXviP0d9H0SNQDr51+3hZnnroAc7kspxS/9FtLZIxQpTSa
 mYU0kbFbXnAzRyWTVUEntkk8Ly6Wt6QYjXflT/XCdodLt0Y5FxexlFjKwhWPKYT073ZLBgqGhSD
 GatNK
X-Gm-Gg: AR+sD12eoHsrSH8w/kPVMoICMgZpts0xvcLc68bxWiNUJqt9WsMwMoqvePynzE7/Qs+
 E+aJPXbaq3QfMODAvHwG/6rnbW6rukS0P+s4EAKAVvwJN65TKtH5g22UiRDug8rmbPzI+KiTKIq
 b8OljSN2in3wSoqKgb0w5RruHlWFllFNwi+gChuNwRbm2s7OYMoBDqTfQx5YPgRVknTUlInibl6
 6zHb/qHNlx41kwO/jaLf6WPrw5pTpbV9VHJ9fNadpOWXELePfF7kRRJReSMMqESUpOm8fIJrim2
 fg7zPXWHTT8XFqBbsy6a0hnrK6NM2urhZFZLrDzA2OyA/QSZlWzkLhLLHNNVs+xmrhlgw0HUtWy
 afdQPOGLL0BfGJktrIv/xha+XG4K1A4AqOCsYs2TuNGf4dHcNgjAI463ebvYVfKH5m+jnJzJqix
 ldweh+KURp1ApAUJR9BlFY3kJFJ02u3JxQQeZWl5tWO9E9huXvEnhXMfb0Rr8IgLtaEjdkPG8bL
 QlAGbk6UnnF+RaLYSoNlmnhdVNfMJKGBQYNafj5beoVm9CcwyPtwiRziR/9LchoUhs2Ag==
X-Received: by 2002:a05:600c:1f8b:b0:495:6274:56c2 with SMTP id
 5b1f17b1804b1-499b82d359dmr75802725e9.2.1787310154851; 
 Fri, 21 Aug 2026 04:02:34 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.02.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:02:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/43] hw/arm: kzm: Store boot info in the board state
Date: Fri, 21 Aug 2026 12:00:51 +0100
Message-ID: <20260821110101.3971391-34-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

The IMX31KZM struct is already allocated per machine instance, so
move the boot info there.

As in the xlnx-zcu102 and raspi machines, the boot info belongs to
the machine rather than to a static object:

4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Message-id: 20260816131300.51799-11-bin.meng@processmission.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/kzm.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 168ecf35d09..1aa5b49de92 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -54,17 +54,13 @@
 typedef struct IMX31KZM {
     FslIMX31State soc;
     MemoryRegion ram_alias;
+    struct arm_boot_info bootinfo;
 } IMX31KZM;
 
 #define KZM_RAM_ADDR            (FSL_IMX31_SDRAM0_ADDR)
 #define KZM_FPGA_ADDR           (FSL_IMX31_CS4_ADDR + 0x1040)
 #define KZM_LAN9118_ADDR        (FSL_IMX31_CS5_ADDR)
 
-static struct arm_boot_info kzm_binfo = {
-    .loader_start = KZM_RAM_ADDR,
-    .board_id = 1722,
-};
-
 static void kzm_init(MachineState *machine)
 {
     IMX31KZM *s = g_new0(IMX31KZM, 1);
@@ -125,10 +121,12 @@ static void kzm_init(MachineState *machine)
                        14745600, serial_hd(2), DEVICE_NATIVE_ENDIAN);
     }
 
-    kzm_binfo.ram_size = machine->ram_size;
+    s->bootinfo.loader_start = KZM_RAM_ADDR;
+    s->bootinfo.board_id = 1722;
+    s->bootinfo.ram_size = machine->ram_size;
 
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->soc.cpu, machine, &kzm_binfo);
+        arm_load_kernel(&s->soc.cpu, machine, &s->bootinfo);
     }
 }
 
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2142FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINrJ-0005Tn-9I; Thu, 30 Apr 2026 05:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wINrD-0005DC-1R
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:38:55 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wINqz-0002nC-Nk
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:38:54 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43d76dd4ee8so575099f8f.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 02:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777541919; x=1778146719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xL8OwV5x8S3IokvAE6V255e7vRqVHIthpETVqBABDt4=;
 b=ozdklPecS9+5OuP1UBCB1EPBCjkDYOAsGNGfHVCE9WVnJVJSKIeW+fMHh86oxHFJdB
 nvkVLUwVztXS5ABkLitxyRNGn5mPCkkkAymX+x1q7JcGYEKTRqIveE297sbFbIfU6jVD
 8aEOXxIlDLI8zOvrFstuRexAgpztTCqyoHUn+I3cyOkfolimWR9b6dcEY0OS/+h1oyjB
 tjlZehJhvKxZbIBGhMeLybZe/BzqKgfZCr+fRmkUwffoOvTYcnLNRzn9sqEkl8boUysT
 QoW9esrz5IwoftVQoW56x4u9n8pGGnlzyodjbh49LxuD5R/C7OcLK3zlV9MbgcnunbYH
 imNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777541919; x=1778146719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xL8OwV5x8S3IokvAE6V255e7vRqVHIthpETVqBABDt4=;
 b=JtS1PH/zw4Bz7b8F7mx+dAKVdAzmdSypYHL+HUxNriYDynxtIE2GBKjI6rUNHviv3O
 etvIhC0nKJyK+Q+IUP/k53kCmGRM4Pwh4xlZfp+awkhJsH6xRB4xYU0Ud/dBIKxbpRVo
 l1fAG/KWRxjhS1UyUkxuj4DAXXCMgP6/dCExFP0BDbpnmb9mqSII0jwdkZedcYRlEdnJ
 MTPke3NWl6/kd78EDacAXU5OQiDHHUQycBHIA1pv2A3rFsAjm7f9HapOuu4Ugm0wVVFH
 A7hBp28mV1B8yOEjtI12gvEajYfm9a3x7GW7FXpuiWkjyvfIEKTiKwFkUsUyc9yc2O79
 bFXQ==
X-Gm-Message-State: AOJu0YzGmWfQVOdEX1N798EDCZA41nsGE6m48KOeIQZb0mSkUBJzsD0Q
 EptlgcftCJLDqquXV9npXhvbvuBho/Tbp90FrXx71u0TNKQM4x/cBWyFBNGOkP+KKYGQ9YmpMYs
 wLCZw
X-Gm-Gg: AeBDiev5oP88qeqy3BgYOs6DfhX/iu+4Z6QoEdH9GxC9GjSAkA3g0nSHXmlCHTb6w5W
 ZcKaoknlT4bTWHxvl/JNQCa12fC6z7eJhrwZHer03m2n1SnDYUGt4Ag7GgaFj57sUQm89XNuNkW
 WQi+ZDR0yJd3heJwvomMVFpq11YOK4hGfgDgUXVO+GNcvX+7n2JSAQDyEYyVUGMaXQAUI8aIUmZ
 hgr4Qd99shSw0CUamMRn0rixI7GxVzGV7KUX4vC1VJp/npYjq2L7f96Zs0xb/Ya92a6jRC3A2RC
 snwG4KwMDMQGBv8jcSKk6Apxy96zviWMDNmh6KKaz2wFxg6uBMSB2zfJb5ScBj92DU1HtGJuiU8
 MxxFeDzXFZH2XKPI18vp5wR9I5MgZtOfRsgbQzua2u8ILBrihUNIIvoLmkNiO+UPgtdmptAnpX5
 WQLiaCt9P9upJXETNQIIVxLcZkxW14KzKViTAmJlOLystJ/iZvB/+UyFSg+d1jbIKd/j8h6rf5t
 GxMd/ECZZshwaP+Lhnq5GjrmsVZOJck36CCNO0CBA==
X-Received: by 2002:a05:6000:144b:b0:43d:7e6f:3816 with SMTP id
 ffacd0b85a97d-4493f42c2c2mr3374636f8f.40.1777541919166; 
 Thu, 30 Apr 2026 02:38:39 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b421721fsm10816795f8f.15.2026.04.30.02.38.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:38:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 21/25] hw/xtensa: Use cpu_translate_for_debug()
Date: Thu, 30 Apr 2026 10:38:06 +0100
Message-ID: <20260430093810.2762539-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430093810.2762539-1-peter.maydell@linaro.org>
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We want to remove the cpu_get_phys_addr_debug() function; update the
xtensa boards to use cpu_translate_for_debug() instead.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/xtensa/sim.c    | 6 +++++-
 hw/xtensa/xtfpga.c | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index 32eb16442f..835cd04fe0 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -40,8 +40,12 @@
 static uint64_t translate_phys_addr(void *opaque, uint64_t addr)
 {
     XtensaCPU *cpu = opaque;
+    TranslateForDebugResult tres;
 
-    return cpu_get_phys_addr_debug(CPU(cpu), addr);
+    if (!cpu_translate_for_debug(CPU(cpu), addr, &tres)) {
+        return -1;
+    }
+    return tres.physaddr;
 }
 
 static void sim_reset(void *opaque)
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 256497e162..33a2d9485c 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -191,8 +191,12 @@ static PFlashCFI01 *xtfpga_flash_init(MemoryRegion *address_space,
 static uint64_t translate_phys_addr(void *opaque, uint64_t addr)
 {
     XtensaCPU *cpu = opaque;
+    TranslateForDebugResult tres;
 
-    return cpu_get_phys_addr_debug(CPU(cpu), addr);
+    if (!cpu_translate_for_debug(CPU(cpu), addr, &tres)) {
+        return -1;
+    }
+    return tres.physaddr;
 }
 
 static void xtfpga_reset(void *opaque)
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5042CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:16:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZF3-0005dR-NX; Tue, 16 Jun 2026 15:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8X-0004jZ-Uc
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:52 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8T-00012J-Od
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:49 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-461a15bb819so939266f8f.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636840; x=1782241640; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cW2zQrTmtXwLACpSm411lB+wI1Su9/wjqYscnJrEuVc=;
 b=WVAGmlytn9DpQoFREQYE6nYN8HmhawhvawDjhd4LHoKYXL/G22D60M0fmEvMhc5etj
 gmerVvVU8bkSAczWd5pBB+7KkIuhyijlUBbGv2PCHfuWUKw6mqh0UKBE+V1oZbkOaQHr
 RHjl173N1syqH0cBMIyKUq8ZWmR/m7zOJiYXvT6Y605bo4vZJr7beyEAPyT1OVVDePat
 HsijOEM2knBxNDRWvKgw4NzNGFntZxFTuZv5c1o3bM2xOCLHZ0mftZDnRifFhG2bB+Le
 S7UgSVaxE8pWDDH+utalIRjkZ/VuMigvDVfQuV2T7YcicQ5Q9YjMflUxJh/53pNB6IWZ
 Sc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636840; x=1782241640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cW2zQrTmtXwLACpSm411lB+wI1Su9/wjqYscnJrEuVc=;
 b=cWBigTOY4uqk1XhhoIaovhEUu11N2VKUQdc8IS2H0DAmggNXjNMv9zwRWn9C7uren6
 r26s0CY3ammoXf6zidGx/timTy/VOLbtG0F6bx4+z0PjohYaWHXaXXeWsi6hb4/bVFP0
 z8TT3ixoWdMB9QZ4ztfBt5mJEuR9cNf2HC8D0xiKB4SRToXVcfe0IX75rqbzZtehQwXZ
 8v7Gsveu9KBVfotwRyvZdcIM+NYyH/F1OeDCuuDd8UhAV4Zfwvl3JzzqricFrPYCSWs6
 vQJ3i1soouxw4VXGZmCxy3lsPeqsm0AvZJn489kx15UULmWlu/9YefKJ/YyEkuxau5H4
 8Onw==
X-Gm-Message-State: AOJu0YwjTGb8TVh9j2Tzil3NB2xJG8ykBS4gyF0OkhyoWzdvfN/RhJzb
 vgEeM3BeWoj2WuC3XwF9xdrb6HTPfg1PTJZNO4sJwYaIISZ1SF6UP/f+E2s43RuBMTFfHgVSclI
 hcJtf
X-Gm-Gg: Acq92OHSYqmXxVlj+nVea5dvIQAYk6WdG7rlQ4JhaNXLjmQaTEkER1+yS7aPORcN3nr
 J5nWzw1WgSBPfTeI0hR085NGSwlTUK10Wxd8DUUTOjZQz0klAaqK1tc/MSr1x75kLGGAjZcAo1+
 ltQTaJdC7q1jvPVxyBe5Hnm7eeUbWQdtxCAf/LFvZKMcnxxjCtluZ8cJ5RxMoJV8Dy6b0JVcTbP
 +rhK9zilB5I+4+OX7mb4kAH6icChpkUDgWqZR8lj0NRswR6E/RyFkHT0Lal+muVQdqA+Ha0NyrI
 te8drpvTASGqjJhHcqKfZ4ykyBNgBo8enERgVF5lsYA90+2U2qhYA1aCn2sFOygdUQQuY88WTsg
 CoSRR6Dch+hm4cnkAh/1Ql6eroQ3m9gnUEYvvP/KvWyumhU8yQO3pn/hVIf9ThGYWdUy3VOJC2x
 gnqXMN8faoMsA/XFWFMQCD1Tlauaa/dInIvcWteLIUdVonFrEk/PSrlg9k8n86CH2Xcnush6Ttx
 0sZAyPUvyfisks7cqATYIaO6BHye6AH
X-Received: by 2002:a05:6000:41e3:b0:461:9459:874c with SMTP id
 ffacd0b85a97d-4623fe7ddfdmr952455f8f.19.1781636839838; 
 Tue, 16 Jun 2026 12:07:19 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/61] hw/arm/tegra241-cmdqv: Initialize register state on reset
Date: Tue, 16 Jun 2026 20:06:11 +0100
Message-ID: <20260616190639.3462006-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

From: Nicolin Chen <nicolinc@nvidia.com>

Initialize the Tegra241 CMDQV register state in the reset handler.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20260609112552.378999-25-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/tegra241-cmdqv.c | 38 ++++++++++++++++++++++++++++++++++++++
 hw/arm/tegra241-cmdqv.h |  3 +++
 hw/arm/trace-events     |  1 +
 3 files changed, 42 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index ff0fcd1e66..0ed2a03612 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -863,6 +863,42 @@ free_viommu:
     return false;
 }
 
+static void tegra241_cmdqv_init_regs(SMMUv3State *s, Tegra241CMDQV *cmdqv)
+{
+    int i;
+
+    cmdqv->config = V_CONFIG_RESET;
+    cmdqv->param = FIELD_DP32(0, PARAM, CMDQV_VER, CMDQV_VER);
+    cmdqv->param = FIELD_DP32(cmdqv->param, PARAM, CMDQV_NUM_CMDQ_LOG2,
+                              CMDQV_NUM_CMDQ_LOG2);
+    cmdqv->param = FIELD_DP32(cmdqv->param, PARAM, CMDQV_NUM_SID_PER_VI_LOG2,
+                              CMDQV_NUM_SID_PER_VI_LOG2);
+    trace_tegra241_cmdqv_init_regs(cmdqv->param);
+    cmdqv->status = R_STATUS_CMDQV_ENABLED_MASK;
+
+    for (i = 0; i < 2; i++) {
+        cmdqv->vi_err_map[i] = 0;
+        cmdqv->vi_int_mask[i] = 0;
+    }
+    for (i = 0; i < 4; i++) {
+        cmdqv->cmdq_err_map[i] = 0;
+        cmdqv->vintf_cmdq_err_map[i] = 0;
+    }
+    cmdqv->vintf_config = 0;
+    cmdqv->vintf_status = 0;
+    for (i = 0; i < TEGRA241_CMDQV_MAX_CMDQ; i++) {
+        cmdqv->cmdq_alloc_map[i] = 0;
+        cmdqv->vcmdq_cons_indx[i] = 0;
+        cmdqv->vcmdq_prod_indx[i] = 0;
+        cmdqv->vcmdq_config[i] = 0;
+        cmdqv->vcmdq_status[i] = 0;
+        cmdqv->vcmdq_gerror[i] = 0;
+        cmdqv->vcmdq_gerrorn[i] = 0;
+        cmdqv->vcmdq_base[i] = 0;
+        cmdqv->vcmdq_cons_indx_base[i] = 0;
+    }
+}
+
 static void tegra241_cmdqv_reset(SMMUv3State *s)
 {
     Tegra241CMDQV *cmdqv = s->s_accel->cmdqv;
@@ -873,6 +909,8 @@ static void tegra241_cmdqv_reset(SMMUv3State *s)
 
     tegra241_cmdqv_guest_unmap_vintf_page0(cmdqv);
     tegra241_cmdqv_free_all_vcmdq(cmdqv);
+
+    tegra241_cmdqv_init_regs(s, cmdqv);
 }
 
 static const MemoryRegionOps mmio_cmdqv_ops = {
diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 01cd6af97d..de4c1e5335 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -89,6 +89,9 @@ FIELD(CONFIG, CMDQ_MAX_CLK_BATCH, 4, 8)
 FIELD(CONFIG, CMDQ_MAX_CMD_BATCH, 12, 8)
 FIELD(CONFIG, CONS_DRAM_EN, 20, 1)
 
+/* CMDQV_EN=1, PER_CMD_OFFSET=16B, CLK_BATCH=256, CMD_BATCH=32. */
+#define V_CONFIG_RESET 0x00020083
+
 REG32(PARAM, 0x4)
 FIELD(PARAM, CMDQV_VER, 0, 4)
 FIELD(PARAM, CMDQV_NUM_CMDQ_LOG2, 4, 4)
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index dbed00afbb..0bd718b1ab 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -76,6 +76,7 @@ smmuv3_accel_install_ste(uint32_t vsid, const char * type, uint32_t hwpt_id) "vS
 tegra241_cmdqv_read_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
 tegra241_cmdqv_write_mmio(uint64_t offset, uint64_t val, unsigned size) "offset: 0x%"PRIx64" val: 0x%"PRIx64" size: 0x%x"
 tegra241_cmdqv_err_map(uint32_t map3, uint32_t map2, uint32_t map1, uint32_t map0) "hw irq received. error (hex) maps: %04X:%04X:%04X:%04X"
+tegra241_cmdqv_init_regs(uint32_t param) "register init, param=0x%08X"
 tegra241_cmdqv_read_vcmdq_page0(int index, const char *aperture, const char *backing, uint64_t offset0, uint64_t val) "vcmdq[%d] %s (%s) offset0: 0x%"PRIx64" val: 0x%"PRIx64
 tegra241_cmdqv_read_vcmdq_page1(int index, const char *aperture, uint64_t offset0, uint64_t val) "vcmdq[%d] %s offset0: 0x%"PRIx64" val: 0x%"PRIx64
 tegra241_cmdqv_write_vcmdq_page0(int index, const char *aperture, const char *backing, uint64_t offset0, uint64_t val) "vcmdq[%d] %s (%s) offset0: 0x%"PRIx64" val: 0x%"PRIx64
-- 
2.43.0



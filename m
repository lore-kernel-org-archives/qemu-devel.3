Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133C2CD5BC0
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 13:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smC7B-0001vx-Hr; Thu, 05 Sep 2024 09:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC70-0001GU-Pb
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:22 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6v-0001m3-OF
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:22 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-374bfc395a5so458848f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 06:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725541276; x=1726146076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MbgnugOLDPgGJXXw23NZotuiUGw5cYgIj0uJ8JeImbY=;
 b=fwk9QPEf+7cBAefPDlyUKeDlQzCZENbwFNeb5eX8hpsS067V4/E30ye+eJeOUfr4Xi
 rzecvHebYgkOVPZWKzKkdI5p4aWX9keKZ9xnD+IKcSE5o6aSCCXikvdOwA9wDZjxYv0b
 frZaXclhwm24chhJ13yK4iRnIM7+3ho++LQf3dvqfcj3Qavu5O5mkv+NpsejDu1W4Iye
 p4wibtBIOwcbbCRVh9O1Ri9e3iCCP/uShNJo5mlraLBfrcEMVIU4ap9Jo3XQnLp3GoUy
 Uy3YRGsTqAY/3k2f8JoJo69rrOB/KtgqF6pPG3Ykw2ZfbdqiwRDfGvH91E5fGOP7r+vv
 bUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725541276; x=1726146076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MbgnugOLDPgGJXXw23NZotuiUGw5cYgIj0uJ8JeImbY=;
 b=DMPCpHPeY8blcGY+wh2Z509X6ar+HKGg8LMNsCBI23JlVuIuDzwYlhyPf7VYCDfb7k
 cP+61QeZIBQtsqYHWUSnZtL84sk/+E7/ra0LQ2dvIg7FJxf+Zc2BLxfXjIMmOMD1m0tD
 osCnF8Cl3C+xQeUWALN00s07xUQ5rIQ03A1TlyioaG6LeIWpvPU30SK8Dku3Cxnl/Jie
 Ot16FAUmb0iYgISq8K9LiQJ0ZoKSrtzRU3fBNvUdFFOPrR3Zn8qVXlcbtXm/x/u/ENHm
 2hgVkZfq7/1krO2DgznV9NjAH08Bh3eAMsunuFJfBVVZhdh4HdiuD5AGi804i1QKf7eL
 qv5A==
X-Gm-Message-State: AOJu0Yy+izuwb7UcVZ+tyFUnOxpLDGm74cV8LsrRcTO9xnXMN2501cJ2
 wUn6wtAxbznJ1lwdFAMJ6WeXtTBmZM9JbJJFecRNc6thm/3XWDA22DzpmJfwumZGveKRAT5P/jl
 5
X-Google-Smtp-Source: AGHT+IGqMvomBVLGcTYSubyTEBTtvVWuiIhejUMFbjid5TTfdhPtu2KzcrSLVB6VQin4kHutTF/4/A==
X-Received: by 2002:a5d:6a07:0:b0:374:be24:a81b with SMTP id
 ffacd0b85a97d-37799e69a84mr3883581f8f.7.1725541275254; 
 Thu, 05 Sep 2024 06:01:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e355dfsm232251365e9.46.2024.09.05.06.01.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 06:01:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/25] hm/nvram/xlnx-versal-efuse-ctrl: Call
 register_finalize_block
Date: Thu,  5 Sep 2024 14:00:54 +0100
Message-Id: <20240905130100.298768-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905130100.298768-1-peter.maydell@linaro.org>
References: <20240905130100.298768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

The TYPE_XLNX_VERSAL_EFUSE_CTRL device creates a register block with
register_init_block32() in its instance_init method; we must
therefore destroy it in our instance_finalize method to avoid a leak
in the QOM introspection "init-inspect-finalize" lifecycle:

Direct leak of 304 byte(s) in 1 object(s) allocated from:
    #0 0x55f222b5b9d8 in __interceptor_calloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qemu-system-aarch64+0x294e9d8) (BuildId: 420
43d49e1139e3f3071b1f22fac1e3e7249c9a6)
    #1 0x7fbb10669c50 in g_malloc0 debian/build/deb/../../../glib/gmem.c:161:13
    #2 0x55f222f90c5d in register_init_block hw/core/register.c:248:34
    #3 0x55f222f916be in register_init_block32 hw/core/register.c:299:12
    #4 0x55f223bbdd15 in efuse_ctrl_init hw/nvram/xlnx-versal-efuse-ctrl.c:718:9
    #5 0x55f225b23391 in object_init_with_type qom/object.c:420:9
    #6 0x55f225b0a66b in object_initialize_with_type qom/object.c:562:5
    #7 0x55f225b0bf0d in object_new_with_type qom/object.c:782:5
    #8 0x55f225b0bfe1 in object_new qom/object.c:797:12
    #9 0x55f226309e0d in qmp_device_list_properties qom/qom-qmp-cmds.c:144:11

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20240822162127.705879-7-peter.maydell@linaro.org
---
 include/hw/nvram/xlnx-versal-efuse.h | 1 +
 hw/nvram/xlnx-versal-efuse-ctrl.c    | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/hw/nvram/xlnx-versal-efuse.h b/include/hw/nvram/xlnx-versal-efuse.h
index 86e2261b9a3..afa4f4f9960 100644
--- a/include/hw/nvram/xlnx-versal-efuse.h
+++ b/include/hw/nvram/xlnx-versal-efuse.h
@@ -44,6 +44,7 @@ struct XlnxVersalEFuseCtrl {
     void *extra_pg0_lock_spec;      /* Opaque property */
     uint32_t extra_pg0_lock_n16;
 
+    RegisterInfoArray *reg_array;
     uint32_t regs[XLNX_VERSAL_EFUSE_CTRL_R_MAX];
     RegisterInfo regs_info[XLNX_VERSAL_EFUSE_CTRL_R_MAX];
 };
diff --git a/hw/nvram/xlnx-versal-efuse-ctrl.c b/hw/nvram/xlnx-versal-efuse-ctrl.c
index def6fe3302b..8252a5cabe0 100644
--- a/hw/nvram/xlnx-versal-efuse-ctrl.c
+++ b/hw/nvram/xlnx-versal-efuse-ctrl.c
@@ -712,9 +712,8 @@ static void efuse_ctrl_init(Object *obj)
 {
     XlnxVersalEFuseCtrl *s = XLNX_VERSAL_EFUSE_CTRL(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-    RegisterInfoArray *reg_array;
 
-    reg_array =
+    s->reg_array =
         register_init_block32(DEVICE(obj), efuse_ctrl_regs_info,
                               ARRAY_SIZE(efuse_ctrl_regs_info),
                               s->regs_info, s->regs,
@@ -722,7 +721,7 @@ static void efuse_ctrl_init(Object *obj)
                               XLNX_VERSAL_EFUSE_CTRL_ERR_DEBUG,
                               R_MAX * 4);
 
-    sysbus_init_mmio(sbd, &reg_array->mem);
+    sysbus_init_mmio(sbd, &s->reg_array->mem);
     sysbus_init_irq(sbd, &s->irq_efuse_imr);
 }
 
@@ -730,6 +729,7 @@ static void efuse_ctrl_finalize(Object *obj)
 {
     XlnxVersalEFuseCtrl *s = XLNX_VERSAL_EFUSE_CTRL(obj);
 
+    register_finalize_block(s->reg_array);
     g_free(s->extra_pg0_lock_spec);
 }
 
-- 
2.34.1



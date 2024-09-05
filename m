Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A017ACD5BC0
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 13:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smC72-0001O2-OV; Thu, 05 Sep 2024 09:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC70-0001Dr-3J
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:22 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6v-0001lZ-Fc
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:21 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42bbffe38e6so5820355e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 06:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725541275; x=1726146075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gmfGmCF7V52uoovNppJezdO9CidRm7THzM8TZjnq7mI=;
 b=SLzfDl2REc+FKvT8zICRy3+lpnuAfbezJ9/ZhNCXQHdQarFrHRn+OXGFCy866MPHqX
 avFXMbrDJ33adUeN+by8WgBjxFLpJzELs9SgKsFH0hpnGR8/sBaazy72P6GscUVpzSYS
 4LSOXDeRqmjMu9noDHcUEuBAtr/142dyjjeumql76agzvW9tkBYJaik9dWsPuAUIoUMp
 Ay9ZaIg2KZDPoklyk0oJGtvd16apaAcjDLMLrg83ags/Gnu0SkUvxOYRkoOeMzdaXveh
 fyu9hyTu2P5CDsaXg/ZrBMazVg4n96nRi7Uxq0kxSrDOYJfSt/4mR0gF030Xin7rAgJJ
 rvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725541275; x=1726146075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gmfGmCF7V52uoovNppJezdO9CidRm7THzM8TZjnq7mI=;
 b=oIHZfM/VTbwkTtgzzKW9pjl55/DLROWpiRa/GnupsrjzHj14i5Or/8ZflVeKK7gRTq
 Iw36ZsBVWlK/OFHaGWYFnSqXoSJ/7JCJdf0vraPMH88Txg0rPSpse6JoRxhwOR0xiX2+
 ku6k6MlTkTarLGaTEoRAS17lV8tiiwMgtF2Zn3S4+oqih3C7X3YPdP2NL2e8VQtvD3vs
 U47sUV0ZmEJBHUNOfhIFB2rIigNXKRB9fezYuonQHnlvkH+7wT5drzpuZBudMCgpNjqm
 7Pk5dFBKai4VgnlM5P79mIrXxCwPSFLV/aYDGQAeBO64vSvZG1a7+G0Mud113mQWVLW6
 K4Uw==
X-Gm-Message-State: AOJu0YyiCbNI+VXxLN4qFI+ML3oe2a1YIAwFNwkQ73cwScSY0Bf87F9H
 vdxSCauveSJrBjZ2B/SNcJuY+MxtaISGGPDo5b+EckW4B10v0PNMqaTLa5lwaYzVvlNPRPBRczT
 T
X-Google-Smtp-Source: AGHT+IEyH+DXrZ94PG5GcVR9KmXctO66SUdtY8J0YOCeHYxCvgmL6DCbNUd7SeI0vajwKHON6uV+8g==
X-Received: by 2002:a05:600c:1c83:b0:428:ec2a:8c94 with SMTP id
 5b1f17b1804b1-42bb02ed81amr161923295e9.10.1725541274182; 
 Thu, 05 Sep 2024 06:01:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e355dfsm232251365e9.46.2024.09.05.06.01.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 06:01:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/25] hw/nvram/xlnx-zynqmp-efuse: Call register_finalize_block
Date: Thu,  5 Sep 2024 14:00:52 +0100
Message-Id: <20240905130100.298768-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905130100.298768-1-peter.maydell@linaro.org>
References: <20240905130100.298768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

The TYPE_XLNX_ZYNQMP_EFUSE device creates a register block with
register_init_block32() in its instance_init method; we must
therefore destroy it in our instance_finalize method to avoid a leak
in the QOM introspection "init-inspect-finalize" lifecycle:

Direct leak of 304 byte(s) in 1 object(s) allocated from:
    #0 0x55f3ff5839d8 in __interceptor_calloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qemu-system-aarch64+0x294d9d8) (BuildId: 23cf931c66865a71b6cc4da95156d03bc106fa72)
    #1 0x7f3f31c6bc50 in g_malloc0 debian/build/deb/../../../glib/gmem.c:161:13
    #2 0x55f3ff9b8c5d in register_init_block hw/core/register.c:248:34
    #3 0x55f3ff9b96be in register_init_block32 hw/core/register.c:299:12
    #4 0x55f4005e5b25 in efuse_ctrl_init hw/nvram/xlnx-versal-efuse-ctrl.c:718:9
    #5 0x55f40254afb1 in object_init_with_type qom/object.c:420:9
    #6 0x55f40253228b in object_initialize_with_type qom/object.c:562:5
    #7 0x55f402533b2d in object_new_with_type qom/object.c:782:5
    #8 0x55f402533c01 in object_new qom/object.c:797:12
    #9 0x55f402d31a2d in qmp_device_list_properties qom/qom-qmp-cmds.c:144:11

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20240822162127.705879-5-peter.maydell@linaro.org
---
 include/hw/nvram/xlnx-zynqmp-efuse.h |  1 +
 hw/nvram/xlnx-zynqmp-efuse.c         | 13 ++++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/hw/nvram/xlnx-zynqmp-efuse.h b/include/hw/nvram/xlnx-zynqmp-efuse.h
index f5beacc2e6a..7fb12df3fbb 100644
--- a/include/hw/nvram/xlnx-zynqmp-efuse.h
+++ b/include/hw/nvram/xlnx-zynqmp-efuse.h
@@ -37,6 +37,7 @@ struct XlnxZynqMPEFuse {
     qemu_irq irq;
 
     XlnxEFuse *efuse;
+    RegisterInfoArray *reg_array;
     uint32_t regs[XLNX_ZYNQMP_EFUSE_R_MAX];
     RegisterInfo regs_info[XLNX_ZYNQMP_EFUSE_R_MAX];
 };
diff --git a/hw/nvram/xlnx-zynqmp-efuse.c b/hw/nvram/xlnx-zynqmp-efuse.c
index 2d465f0fc6a..4e2d1b9d1e7 100644
--- a/hw/nvram/xlnx-zynqmp-efuse.c
+++ b/hw/nvram/xlnx-zynqmp-efuse.c
@@ -803,9 +803,8 @@ static void zynqmp_efuse_init(Object *obj)
 {
     XlnxZynqMPEFuse *s = XLNX_ZYNQMP_EFUSE(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-    RegisterInfoArray *reg_array;
 
-    reg_array =
+    s->reg_array =
         register_init_block32(DEVICE(obj), zynqmp_efuse_regs_info,
                               ARRAY_SIZE(zynqmp_efuse_regs_info),
                               s->regs_info, s->regs,
@@ -813,10 +812,17 @@ static void zynqmp_efuse_init(Object *obj)
                               ZYNQMP_EFUSE_ERR_DEBUG,
                               R_MAX * 4);
 
-    sysbus_init_mmio(sbd, &reg_array->mem);
+    sysbus_init_mmio(sbd, &s->reg_array->mem);
     sysbus_init_irq(sbd, &s->irq);
 }
 
+static void zynqmp_efuse_finalize(Object *obj)
+{
+    XlnxZynqMPEFuse *s = XLNX_ZYNQMP_EFUSE(obj);
+
+    register_finalize_block(s->reg_array);
+}
+
 static const VMStateDescription vmstate_efuse = {
     .name = TYPE_XLNX_ZYNQMP_EFUSE,
     .version_id = 1,
@@ -853,6 +859,7 @@ static const TypeInfo efuse_info = {
     .instance_size = sizeof(XlnxZynqMPEFuse),
     .class_init    = zynqmp_efuse_class_init,
     .instance_init = zynqmp_efuse_init,
+    .instance_finalize = zynqmp_efuse_finalize,
 };
 
 static void efuse_register_types(void)
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB8CFC52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 16:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shAZD-00055X-5g; Thu, 22 Aug 2024 12:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1shAZ7-0004uj-Tv
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 12:21:37 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1shAZ3-0007KI-UX
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 12:21:37 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-429e29933aaso7303365e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 09:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724343691; x=1724948491; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pKFPg971wT4+RsKvDlNvV4P8wQdSeCeiTzH4yTjPvqA=;
 b=m8LzL14jTglIPWyO8tU0YGKVSms4gUkX8TaOuM9icyoLuzAb9bguudKLDm3OkHdGI5
 hvYJsUSkPb2VEzfUHslck1ar2q6HtRG8+tMlh3P4KQkmDCQJfg1MjHdBLX34KGJdFx2l
 CevoX+6EPBl7GudgkhAoP1Omr+sfrzxiFwScG29zvsufnu/BG+3/QDVZQdvwMVFB3ra9
 +Tym4a8w6mtDQFNNzA88Yy8u125VKqAwYeEN3IZHFv69qZUNGdYsFkexW1/zmc7Z/3A+
 Ts+j5WonZBW16ZR9BsvJrhxnstxmbUGB8Kz+n3Bw1zKyKi/+Nrg+3XawysQyO6g6llJ/
 0dsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724343691; x=1724948491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pKFPg971wT4+RsKvDlNvV4P8wQdSeCeiTzH4yTjPvqA=;
 b=iEsTmFRpznreRC447pRC7wZlNB/LNFpj73zLafWRVFrry2EBctsvqtj8OmVIXN4LdZ
 SwMxkk2DoLzw/LdT657SLCTYPw0GXae8ykfrjeJqolMsnMW16scmTF90iDVnAq1NFkD2
 yA/YFuTyM3kYUmFRv0ij7WU7Sexh6rpJ2OJ54sBn69QSiE0RnRsnM2JtRsHs4TDBuSVA
 kosJtMoUS1UNDRduFlGwpRYT/4NlM3uxnJ3zXG3gPn8CCImOU7BO1Ap6Z/QSqQEGFxhw
 qzMA0fwCkZI0rd79jYgH17bba7N+UvMCxxwaUUPIrS1MUOzna9ZkYLbH44+YHeSLh78U
 ilVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW19WUIO4e7iiJX0QmXI9YZFBIJRAmE9VKAt3mUol8p3zFhny6txWwVVXmfcI5HLLYxPysNBAwWrwEd@nongnu.org
X-Gm-Message-State: AOJu0YxzS3ZdQdfD4kN5iuN01P9um8ByUDUHMd+ZhClC7t2F0DR07azt
 /RBffp+kDwbKe3RhZkF0qxwsStOQX9xeAwHzddfrDw5rijFJY9KUDl5cqBsZvsI=
X-Google-Smtp-Source: AGHT+IEdAYwlTzHwR6JIKzYtnLx5tq/S/aCOZZBUvpQQw3lx9aspZ2Sqp8nZsNt7oDiwUZAmkQSR/Q==
X-Received: by 2002:a05:600c:4e8f:b0:426:59ad:bbb3 with SMTP id
 5b1f17b1804b1-42ac564ef4bmr19280605e9.32.1724343690904; 
 Thu, 22 Aug 2024 09:21:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ac5162347sm28928485e9.23.2024.08.22.09.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 09:21:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>
Subject: [PATCH for-9.2 3/6] hw/nvram/xlnx-bbram: Call register_finalize_block
Date: Thu, 22 Aug 2024 17:21:24 +0100
Message-Id: <20240822162127.705879-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822162127.705879-1-peter.maydell@linaro.org>
References: <20240822162127.705879-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

The TYPE_XLNX_BBRAM device creates a register block with
register_init_block32() in its instance_init method; we must
therefore destroy it in our instance_finalize method to avoid a leak
in the QOM introspection "init-inspect-finalize" lifecycle:

Direct leak of 304 byte(s) in 1 object(s) allocated from:
    #0 0x5641518ca9d8 in __interceptor_calloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qemu-system-aarch64+0x294d9d8) (BuildId: 4a6
18cb63d57d5a19ed45cfc262b08da47eaafe5)
    #1 0x7ff1aab31c50 in g_malloc0 debian/build/deb/../../../glib/gmem.c:161:13
    #2 0x564151cffc5d in register_init_block hw/core/register.c:248:34
    #3 0x564151d006be in register_init_block32 hw/core/register.c:299:12
    #4 0x56415293df75 in bbram_ctrl_init hw/nvram/xlnx-bbram.c:462:9
    #5 0x564154891dc1 in object_init_with_type qom/object.c:420:9
    #6 0x56415487909b in object_initialize_with_type qom/object.c:562:5
    #7 0x56415487a93d in object_new_with_type qom/object.c:782:5
    #8 0x56415487aa11 in object_new qom/object.c:797:12
    #9 0x56415507883d in qmp_device_list_properties qom/qom-qmp-cmds.c:144:11

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/nvram/xlnx-bbram.h |  1 +
 hw/nvram/xlnx-bbram.c         | 13 ++++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/hw/nvram/xlnx-bbram.h b/include/hw/nvram/xlnx-bbram.h
index 6fc13f8cc17..bce8e89d905 100644
--- a/include/hw/nvram/xlnx-bbram.h
+++ b/include/hw/nvram/xlnx-bbram.h
@@ -47,6 +47,7 @@ struct XlnxBBRam {
     bool bbram8_wo;
     bool blk_ro;
 
+    RegisterInfoArray *reg_array;
     uint32_t regs[RMAX_XLNX_BBRAM];
     RegisterInfo regs_info[RMAX_XLNX_BBRAM];
 };
diff --git a/hw/nvram/xlnx-bbram.c b/hw/nvram/xlnx-bbram.c
index 09575a77d77..1bc58e90ad0 100644
--- a/hw/nvram/xlnx-bbram.c
+++ b/hw/nvram/xlnx-bbram.c
@@ -456,9 +456,8 @@ static void bbram_ctrl_init(Object *obj)
 {
     XlnxBBRam *s = XLNX_BBRAM(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-    RegisterInfoArray *reg_array;
 
-    reg_array =
+    s->reg_array =
         register_init_block32(DEVICE(obj), bbram_ctrl_regs_info,
                               ARRAY_SIZE(bbram_ctrl_regs_info),
                               s->regs_info, s->regs,
@@ -466,10 +465,17 @@ static void bbram_ctrl_init(Object *obj)
                               XLNX_BBRAM_ERR_DEBUG,
                               R_MAX * 4);
 
-    sysbus_init_mmio(sbd, &reg_array->mem);
+    sysbus_init_mmio(sbd, &s->reg_array->mem);
     sysbus_init_irq(sbd, &s->irq_bbram);
 }
 
+static void bbram_ctrl_finalize(Object *obj)
+{
+    XlnxBBRam *s = XLNX_BBRAM(obj);
+
+    register_finalize_block(s->reg_array);
+}
+
 static void bbram_prop_set_drive(Object *obj, Visitor *v, const char *name,
                                  void *opaque, Error **errp)
 {
@@ -537,6 +543,7 @@ static const TypeInfo bbram_ctrl_info = {
     .instance_size = sizeof(XlnxBBRam),
     .class_init    = bbram_ctrl_class_init,
     .instance_init = bbram_ctrl_init,
+    .instance_finalize = bbram_ctrl_finalize,
 };
 
 static void bbram_ctrl_register_types(void)
-- 
2.34.1



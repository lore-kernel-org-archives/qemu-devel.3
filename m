Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C844C5321D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 16:23:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shAZH-0005MH-44; Thu, 22 Aug 2024 12:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1shAZD-00057g-KE
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 12:21:43 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1shAZ5-0007Ki-NO
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 12:21:41 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-37189d8e637so504262f8f.3
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 09:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724343692; x=1724948492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nMpLWn3WW/z8gsXVfqO2IPBe/rQMV7r1aFvdjBG7Zt4=;
 b=uO3W1+tdcqqKQy9b6fD3C0ArfnIs7RrGMYpNFQMEch/K3EijismlJK6YTAqPvcx4El
 F+Lp8vFMKrGEJYJj61z3puJ9yoHuuyCJa1LkoQanbBYWXiE+Mn2T+H1NM8E2Bv8K4gFm
 F6VDDMIxHpiRfFb1wdZo477CFcC0laLLTbJgiAVvzuowCGvv0+9ICFrGyHSUtXa3xvsv
 49wsZmGzJWLF9ABqur6LH+4ITq8GbAtX0m8Xx+2LO51aT40b8ACbgOKm0rCGs70VRS52
 1yfPYrdilfBX3nkdFj7P5nHLgGf3nL4mWPjaRKZReHllYqY0yfm4GgO6gxHC/vayHZGq
 yR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724343692; x=1724948492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nMpLWn3WW/z8gsXVfqO2IPBe/rQMV7r1aFvdjBG7Zt4=;
 b=xVn49sa2GyufLHIWP+Tdj/hMFzlsjb9w7ZnpcXxzjzc+2q3UP7eqP7Qpx03e/ryjqi
 ypUFdqrVeLxLdygT3GSvDbuex9Lb+fpE2rR8Ljl2qtBcZU/SOgps0bDlIgPiBhDVNm8U
 WhOTkz+87TQ/Vd+GxFIEBrOG6pfXy0WYuu73S4i0abttRYEdhc6EUWYbgTht2HEfQwNS
 g1GvOJC0WVn4joeyQ3NXG8zK/5r9rIuud3y0NjqkeWtkNlwpQfjkTYZwRaxDj/WZ8xYX
 IuZBgzF8Puorc+OuqCUqkOYk++FIRERjArlgeuJumOq+Xup+rsojpleRlrGwCb8b1a0b
 GNYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrHi3lINXrlv79syfSxr/wWinW7vgcICU0Yew3/QRTDNHf0z+7I8GKK4r4NiiNkT6pl8fCtlfvA2yV@nongnu.org
X-Gm-Message-State: AOJu0YyhGuOib9zilu6ERSITyAdiwr52HN1M/o40EFZ/f4TUUdJVfWH+
 alFFEyF1mFw5qLrAiP4iGhMffLGwah5/6rnmNo05zCoQ67C/PBh/tsSKarIbUpTJXUAWE7GRoq7
 7
X-Google-Smtp-Source: AGHT+IHS0vZFZuCesAqtnR1b+lPmowj9GyVhYK/yJS9PX+4jrkqlDNvBVZANVpD/ZSGdQnGTHQEr6g==
X-Received: by 2002:adf:e285:0:b0:368:31c7:19dd with SMTP id
 ffacd0b85a97d-37308bff403mr1437853f8f.5.1724343691981; 
 Thu, 22 Aug 2024 09:21:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ac5162347sm28928485e9.23.2024.08.22.09.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Aug 2024 09:21:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>
Subject: [PATCH for-9.2 5/6] hw/misc/xlnx-versal-trng: Call
 register_finalize_block
Date: Thu, 22 Aug 2024 17:21:26 +0100
Message-Id: <20240822162127.705879-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822162127.705879-1-peter.maydell@linaro.org>
References: <20240822162127.705879-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

The TYPE_XLNX_VERSAL_TRNG device creates a register block with
register_init_block32() in its instance_init method; we must
therefore destroy it in our instance_finalize method to avoid a leak
in the QOM introspection "init-inspect-finalize" lifecycle:

Direct leak of 304 byte(s) in 1 object(s) allocated from:
    #0 0x55842ec799d8 in __interceptor_calloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qemu-system-aarch64+0x294e9d8) (BuildId: 47496e53f3e779f1c7e9b82cbea07407152b498b)
    #1 0x7fe793c75c50 in g_malloc0 debian/build/deb/../../../glib/gmem.c:161:13
    #2 0x55842f0aec5d in register_init_block hw/core/register.c:248:34
    #3 0x55842f0af6be in register_init_block32 hw/core/register.c:299:12
    #4 0x55842f801588 in trng_init hw/misc/xlnx-versal-trng.c:614:9
    #5 0x558431c411a1 in object_init_with_type qom/object.c:420:9
    #6 0x558431c2847b in object_initialize_with_type qom/object.c:562:5
    #7 0x558431c29d1d in object_new_with_type qom/object.c:782:5
    #8 0x558431c29df1 in object_new qom/object.c:797:12
    #9 0x558432427c1d in qmp_device_list_properties qom/qom-qmp-cmds.c:144:11

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/xlnx-versal-trng.h | 1 +
 hw/misc/xlnx-versal-trng.c         | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/hw/misc/xlnx-versal-trng.h b/include/hw/misc/xlnx-versal-trng.h
index 0bcef8a6132..d96f8f9eff3 100644
--- a/include/hw/misc/xlnx-versal-trng.h
+++ b/include/hw/misc/xlnx-versal-trng.h
@@ -50,6 +50,7 @@ typedef struct XlnxVersalTRng {
     uint64_t forced_prng_count;
     uint64_t tst_seed[2];
 
+    RegisterInfoArray *reg_array;
     uint32_t regs[RMAX_XLNX_VERSAL_TRNG];
     RegisterInfo regs_info[RMAX_XLNX_VERSAL_TRNG];
 } XlnxVersalTRng;
diff --git a/hw/misc/xlnx-versal-trng.c b/hw/misc/xlnx-versal-trng.c
index c0d1dde8708..86905479b8f 100644
--- a/hw/misc/xlnx-versal-trng.c
+++ b/hw/misc/xlnx-versal-trng.c
@@ -608,9 +608,8 @@ static void trng_init(Object *obj)
 {
     XlnxVersalTRng *s = XLNX_VERSAL_TRNG(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-    RegisterInfoArray *reg_array;
 
-    reg_array =
+    s->reg_array =
         register_init_block32(DEVICE(obj), trng_regs_info,
                               ARRAY_SIZE(trng_regs_info),
                               s->regs_info, s->regs,
@@ -618,7 +617,7 @@ static void trng_init(Object *obj)
                               XLNX_VERSAL_TRNG_ERR_DEBUG,
                               R_MAX * 4);
 
-    sysbus_init_mmio(sbd, &reg_array->mem);
+    sysbus_init_mmio(sbd, &s->reg_array->mem);
     sysbus_init_irq(sbd, &s->irq);
 
     s->prng = g_rand_new();
@@ -628,6 +627,7 @@ static void trng_finalize(Object *obj)
 {
     XlnxVersalTRng *s = XLNX_VERSAL_TRNG(obj);
 
+    register_finalize_block(s->reg_array);
     g_rand_free(s->prng);
     s->prng = NULL;
 }
-- 
2.34.1



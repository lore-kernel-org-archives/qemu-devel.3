Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A9ECD5BC5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 13:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smC7C-0001z0-CG; Thu, 05 Sep 2024 09:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6z-0001D4-Tn
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:22 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6v-0001lW-FN
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:21 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42bbe908380so6202795e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 06:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725541275; x=1726146075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yNRTbINTbj/l4s3T+Yhp0ouEZCk2q0YhAmbisqItYZM=;
 b=Uf/Da5iwAxOUZUS79YolyRboIsg19GB4SVvEeFc31GZ/tdz8eVP4/yn5wGzbsk5ykm
 Zvto1GgsSOilPFryFS8xU5imWYdIAMleVuhafijl2uSS4BDx9hjVvd085jCJ/FVT3ZhV
 R8Ff3NsPzXF3gYz1ppE1+3/n9Yaa+HmJuBQNyHVibl80cDiR16jtlsBwVof7uP8lQO7E
 RDYy28fu3cm4fxMhsdtL436hDS1LkmuqlkQLuGzYUbk5ANqihlxwDlZp8abHnejX945X
 ECbmfFiVxflBwZy1H82/8j5Kr/BUlZxmp7fkryYMD0jNN3PULB3GkF534oGNZ5ruRBCv
 cGcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725541275; x=1726146075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yNRTbINTbj/l4s3T+Yhp0ouEZCk2q0YhAmbisqItYZM=;
 b=czd/76PtZVLnOcWJudmh14oHHajxrScmFrs9CS01v4EY4CSAm8c7PRJYElOkXbfJbh
 8Rirg+oOyDUwUXmXHOZijb7+oJ1k0/lX91cGcm3y4dhyUU7MYcuGMnmJPltVhC587Eq7
 f3EEi7MwW33G/zc9FXeFjojRGqBaAtYQGEHezXHkgRu3Y2L1Hb33pPxDwgnmfQhCk4tO
 62neFlBeUh/FzAkystUat1Md+Me/BqQFgO5ijohNBgwa1cFJ20kOCyWmU4pao7aXFt1K
 +tlSPOYFSzplPouSFlmbWxQYj7gtG014p0zaVs4+mI7AlfoI3UMwlvDr0dr8wjGympyV
 gkvQ==
X-Gm-Message-State: AOJu0YwKBSTpdcOrFmvMGS2ETUq/iwErK9hZO/5l1MbnOXsku89KVItn
 e8Crd4TyPS0BVNnOPzz+8K0Dzm7ydF/Q3vBU7V8Kc3Ob/PYk9kNl5+V5cv2cH8IrYRQOCPPOdoO
 d
X-Google-Smtp-Source: AGHT+IGblgn4s1Oj3xsZ9SebczvwMqzwYIk/gJVLezIBqcayMn2GOfFJ+dnZ8wuYgSGkI5YltCnw9w==
X-Received: by 2002:a05:600c:3b19:b0:426:6667:5c42 with SMTP id
 5b1f17b1804b1-42bd731edeamr146681715e9.4.1725541274682; 
 Thu, 05 Sep 2024 06:01:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e355dfsm232251365e9.46.2024.09.05.06.01.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 06:01:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/25] hw/misc/xlnx-versal-trng: Call register_finalize_block
Date: Thu,  5 Sep 2024 14:00:53 +0100
Message-Id: <20240905130100.298768-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905130100.298768-1-peter.maydell@linaro.org>
References: <20240905130100.298768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20240822162127.705879-6-peter.maydell@linaro.org
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



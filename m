Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F02EC5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNcD-0000IH-6k; Mon, 24 Aug 2026 01:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNc5-0007gi-Id
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:52:53 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNc3-0003Ca-Uv
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:52:53 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so3409547a91.0
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550771; x=1788155571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2bo/j1CDuuQMd0oLr1kU7Y1aV/gYiZ5tDVaJf2ZCz7I=;
 b=ZeVuD2vTdHxJM+2FLd10WPNG7bMjSXmTUT7eRzbfAi2J+rtMTyzAbqc7jAHWjDLT7t
 Ax1UtOlfnPxM12f8XC7pFxGjW6hA4MCXOtGcaSctFCYdo/CT1zPIkj4jpP0lAUycqhyj
 O0UNzwI0pHGefS9YQjDJMMeWJlnS4v4lnahEkNVWoJVLMDBBeaJWbr33qc2PyXucJDr1
 MAkF7zl7WmcyhPPcuLKTLyLYa/j2NK1B9JpeKpiqAiv8oe7Ov/PNJgGYl0+BvWxnlnXw
 5aG+IhETbMiA9CpAhV+NUNYJ+t6O520MfL76TQH374YvhxDndoXbUnTNQqtbieHpv+L1
 B7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550771; x=1788155571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2bo/j1CDuuQMd0oLr1kU7Y1aV/gYiZ5tDVaJf2ZCz7I=;
 b=HaKuX3gdqYGj2owoXTQXezJelAiLaXKiqTuyxwEVRMtN9OSi5bcbDv+qpDopiVdHqJ
 miTGErg9Pl14KljQ+K/WletY1HJ6n5F1gqIZdtutNpPxdKhzPcBDWM/zAPhihpJqBzHF
 UIRnP4aZ5l7UQUJtRVU4kH3VSzm6W0MCPX5mM3RBrgy0EBTqgYK8Ml2nIg1ScDU5xc0n
 HSsjUPC0i2DC5lwvbOxe+r2V/SZ1wZLsbD6yqwNTyEgor/gAfWjZpm+H9/2bXD/gtqTM
 LC+geWsUNyc3PC8J7KNPaMJNIkUjtBH6F5YOu8AVw1v9sGlpavtZqZbttDy2vqCgAC0h
 5UhA==
X-Gm-Message-State: AFuF++n0tdcz+o/HXBkZ91CiFCV8dWSKenjD/P5Ur2g0BOMawM/kuk28
 LJiIOWs/bnk6rzsgH5Pp0IGVXYgVSxte80gprjj+V1Oja7l84tP8owqUGIlRkQ==
X-Gm-Gg: AR+sD13ETPs+q5Mv7ml0Vs96Xagfs/juxwFEgxTro8A4guAULoZwMObZ4D0bwTaXina
 Bd4DosDPSARjNSxltNqMW8QSTL+AIe4nyz+xUVU+77WnLzPipIPx/yksQAfbdg5PAkFz5dcY8PN
 zEIRUNf29Zfbqe90fUJuLlxDSV4l9P94S3pYL6j9Fjcb4XS1n8uxr3+uJ0dRMGl+5KjPGFWXmaQ
 vcLgZR1Sxc1HO7PF5fhuTwjchN8NDQbE/pGPk88K37pLjWLO2zP3igzOsFbp01V0MF0ZFVqdfyC
 +/srW3WzMjgVXUNzQ+145TODUhna9ngrZmmxXeHZ7cgcrxNcVxQOVia+zst4e6O+4Qkj2V8xOSw
 8Y0eVL+DiZFx9fUS/L1IJIP+lgOj0+CTcLsAVfRlvjVUgMofPaKqWhWea0YRth0kQ2yJRPs5F2E
 cjPfk1X3s/GtgMWUQ5uyfsPJEU3V2oVDmJtCEZXfSlqUaC1jRyIo2OU+Za2kSaaedBqNiF8b63W
 H3F3Q==
X-Received: by 2002:a17:90b:4f91:b0:381:6c5:3f63 with SMTP id
 98e67ed59e1d1-395c33a6e92mr40631985a91.6.1787550770554; 
 Sun, 23 Aug 2026 22:52:50 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:52:49 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>,
 Bin Meng <bin.meng@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 89/96] tests/qtest: remove trace output from k230 watchdog
 test
Date: Mon, 24 Aug 2026 15:47:59 +1000
Message-ID: <20260824054806.2790041-90-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Chao Liu <chao.liu@processmission.com>

The interrupt mode test does not depend on trace output, but passes a
trace file to QEMU. This makes startup fail when QEMU is built without
the log or simple trace backend, so qtest cannot connect.

Drop the unnecessary trace option.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4126

Signed-off-by: Chao Liu <chao.liu@processmission.com>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Message-ID: <20260813054329.35425-1-chao.liu@processmission.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/qtest/k230-wdt-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/k230-wdt-test.c b/tests/qtest/k230-wdt-test.c
index c8eaeaf1ae..b1131f42e3 100644
--- a/tests/qtest/k230-wdt-test.c
+++ b/tests/qtest/k230-wdt-test.c
@@ -76,7 +76,7 @@ static void test_counter_restart(void)
 
 static void test_interrupt_mode(void)
 {
-    QTestState *qts = qtest_init("-machine k230 --trace k230_*,file=k230.log");
+    QTestState *qts = qtest_init("-machine k230");
 
     /* Set interrupt mode and enable watchdog */
     qtest_writel(qts, WDT_BASE + K230_WDT_CR,
-- 
2.54.0



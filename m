Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC10C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtmH-0007tY-Pi; Wed, 19 Aug 2026 23:49:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtmC-0007lB-D6
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:49:13 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtm9-0004U8-IS
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:49:12 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-38dcbade417so1940071a91.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197748; x=1787802548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2bo/j1CDuuQMd0oLr1kU7Y1aV/gYiZ5tDVaJf2ZCz7I=;
 b=Srlx1L099xsqB5VaGS1ReZYGgZ6ajKjQqtLwEkoHqHFSapLmwEKl7BgUPgjHKQHK0o
 D1meclTIQnppuiW7JvuyCZy+1Y07J90jHxDwP83pdbJ3w59PHumB0JUdndjW5M3N6CFD
 rZK9wFt/KrGKX/n7ODa4oE0mSn+ZNBC1Tgc/qDujDxKHS26Px3NB8QR1PRsHuKXP7/Hi
 a5XM9aHOmzewj8BqjpoBhlkt67aSNGzuVsifhrUpgoqhmMNuvb+NmkGuv/YjFH2vMtH4
 gp90t71/4zYMgD03Qxbv5JouCqxtfhO7FTVAx3BM//NJkKdIWglLxs3RRUmSM0rqClW4
 9w2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197748; x=1787802548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2bo/j1CDuuQMd0oLr1kU7Y1aV/gYiZ5tDVaJf2ZCz7I=;
 b=DdVFtOMwLCZUvah6xmWxoyJlgZleTGDvZ+Gpi0EsNTNLlvX9X21ULo0AWk2UxV8qtx
 Qx3N/ZqVZnR/tfljhW0eytN9d18lCPmXi/05MICtL+Wos0DiMDrM6JhP2viJzFSGKhcb
 yunRL7wXiGs8yVLj5MFmHqHEyZYJW7IZuLY9IqWrxLLkft/6irJYZMA7U3MEtVjdNabi
 9Tohrt76o55rpCNjkvtvQK1fTE1BDY7tqhdOA7FBKExg3T68mcif4e5K3fhcjX0cfnIi
 Wfu0Lpbaslp+/5g/0KjATk6gxx08xvDm/HEpHt/YC1DLamPayhWy0n/RMQ1lgtzNurnD
 3heg==
X-Gm-Message-State: AFuF++nME8FGplNTajzbC+YiSm4PnBBRZ2UZJO3W2IpScH97t/2n1Y0b
 OYQFjX5IQT+sEejyvyWvimKJRT32x76sComRzwK4KneblqoqVSsOzHgsxEm3/w==
X-Gm-Gg: AR+sD10oMYEs4fVAPGbuuw2X9okyF819LEoL1eu76IHSVXXw6wHKx702olb+3As3njo
 1Ukbw+ELj3BQfguIBmPDqAoxkrshJHjYFj2tiUGQzFTj1Kp9nwqs6W0R3iQytmOWouR+kAw503X
 MGATt1iFhHe8jjICos4+k6ATbKG7WRTPnnlROqcY45b1IFHZBVV86jNI37l9nQ19OVJj8qj2cjI
 C/CZhfgYjE+dpuBQSVzCokLkLhP2OjeLVshVydiumnHMGprFMuk+da/7q0/hDiPwCxdLOaCTR6f
 I/RvuDfODr890x3wN18KQaIvgQo8JypM1HG0ttTi51dZd8PEwKfkAOoIylnqsOY+aUlblc7Ft94
 wMJ3rA6zbvYZgFaiEgUDqmCBf3wG6gQImxWTe3JV4cs/uhIsQrWkN+qzmg6m/KUFCzyfaU78sNe
 y59t5jItsJ+4O2/bJTrWF3YrjdzKc9xypjplUXhwkoP20ISNClVAZNRj5kYUhL/U6hHshT07kfA
 ++HIA==
X-Received: by 2002:a17:90b:2e90:b0:38e:c7b0:84ad with SMTP id
 98e67ed59e1d1-395804993b6mr17404597a91.0.1787197748139; 
 Wed, 19 Aug 2026 20:49:08 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:49:07 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>,
 Bin Meng <bin.meng@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 92/93] tests/qtest: remove trace output from k230 watchdog test
Date: Thu, 20 Aug 2026 13:44:29 +1000
Message-ID: <20260820034430.1186695-93-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102f.google.com
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



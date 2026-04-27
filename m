Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D97FF886B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 13:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLUj-0000zU-Bh; Mon, 27 Apr 2026 08:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLO9-0008Ez-1m
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:37 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLO6-0005mo-BQ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:36 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so127026025e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294113; x=1777898913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SNjguSagUUFWrnR8Tu095/iRj+cQaq/6CTCp6Ze1XcY=;
 b=NhbZ2r8ZvC42TEMQz4nvYR+HFoEnFV6KDjQ8MXq+BObgG0WH3IesN6D3T2E9VClVQV
 oqFGOowH3IGoQVemddW1OZCDthqyQR2TN1qRhsXZPwxiplYA+ekL1MMld2t+mjJkTe1i
 wL7arYMlC6kKewL/iqz1t5PmbhTZ2ogtvIy+urWWpYVHwWaJfpCs6Ftp1TOdN9yTDOF1
 3TRr8tkob9JC6qy3COm019IDIxz11jj6bZVsCrKvYklxPpa07jmx/J75mppA9iu92FbN
 PT5YA5j+/H5esZWtYYOjvC28KDKSmMCRfCmK0WeIpq07Fs0t/Bj5RRZvvUTS67e3K5Oo
 MXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294113; x=1777898913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SNjguSagUUFWrnR8Tu095/iRj+cQaq/6CTCp6Ze1XcY=;
 b=dbQjkcgKGT9I24Mv3y2q1QpTeJGlN/hdDzHw0+XliY2WaVHVNYpkAidnV3CpvqGDvo
 rBX8oNu1Vz7LRVCnQCkNhb8+XMe7sCg1/YCPKPqVMOvQydjByZz3lyOqTYHV9eADh9LW
 nF7zLGwyfRG86KXAIE9cneN2LcwUzCNj1V/kJD13K66VeAHUAb4Fra4bM/7a/8UXOfOK
 49jykDLdoFQ23ucJLEuVH59tug/SIsJuMFjGkey/qTEDHPa/7/O8hoYfy7t4pJEZtC0u
 QkbziYGuA/pmkSMj7ezxt15v+pK3dCMAJF9vyEwHj3S67BV6B2LlOXYSdsDAQ7bDY3YS
 pOfg==
X-Gm-Message-State: AOJu0Yy1T412esj7No5O2p/yK/dbVtVX3qSaQZwGBJnlrhurf7EHxUF0
 eudGhGpAugbBZ/f8W+qQ6dgRndN/K7fbngqnTHUejSkBpDRdwsENNEnlPyjMeezO5mkzYbtiTEQ
 DSB0q
X-Gm-Gg: AeBDiesJAnUoUwOwTthKH8Q6DntdS0pQ6GR9b93PZcA7fIeB5h86XzFB0g98X02lYuo
 NFv7EKl30LYA+87v/zRo30NtL/16pGG5mFZVDpuYzjo7eEdi8ED3lt+CCIqegqvTYXQBEwJViYc
 jse+5KU/OUeGfyczdPzusCuwNTcQHrd+YzXhUvlodLJt71ztwdVAHg0VSqoqpK43Q2q2oD4JfCy
 Cmhb8o7JuOkuB4VRloPJeUse6VRzojqN7HYanqJ3sX1ULmJ8Aq4cVdcU2v2LvIzqUqq9D6DrNMI
 Nvof7c8YQJJUkJsOy7egwEmC9ckZ/u5Ao0dWqPQkpdcP4EDeHu9/rz0SjpHKmPlpQ2MqlZT0IMz
 OSdBzSMevaUjfgwUKzZbBsNJBWTeCcBcx96Se/8PVOsApE52qMyBlQ/6Aq3uXIMWAfaQqzDKqlx
 53cR7O2ZWTNOTX2sDGYrUzScMWkT0vW5hcoCv1fS0PwT0LO3Ks46p0O2ez79nM+t+EL7/PHtMyh
 hEkh+6/HOQ0Oh1UZklp2TbTo8nwxGhNerVjYrCpaA==
X-Received: by 2002:a05:600c:468c:b0:48a:56d5:16f2 with SMTP id
 5b1f17b1804b1-48a56d5179amr386817155e9.7.1777294112716; 
 Mon, 27 Apr 2026 05:48:32 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.48.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:48:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 58/63] target/arm: make whpx use syndrome helpers for decode
Date: Mon, 27 Apr 2026 13:47:32 +0100
Message-ID: <20260427124738.966578-59-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

Rather than open coding a bunch of shifts and masks we can use the
syndrome definitions. While we are at it assert it really is a
EC_DATAABORT.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260422125250.1303100-19-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/whpx/whpx-all.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index bbf0f6be96..4cfc7f9969 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -356,15 +356,16 @@ static int whpx_handle_mmio(CPUState *cpu, WHV_MEMORY_ACCESS_CONTEXT *ctx)
 {
     uint64_t syndrome = ctx->Syndrome;
 
-    bool isv = syndrome & ARM_EL_ISV;
-    bool iswrite = (syndrome >> 6) & 1;
-    bool sse = (syndrome >> 21) & 1;
-    uint32_t sas = (syndrome >> 22) & 3;
+    bool isv = FIELD_EX32(syndrome, DABORT_ISS, ISV);
+    bool iswrite = FIELD_EX32(syndrome, DABORT_ISS, WNR);
+    bool sse = FIELD_EX32(syndrome, DABORT_ISS, SSE);
+    uint32_t sas = FIELD_EX32(syndrome, DABORT_ISS, SAS);
     uint32_t len = 1 << sas;
-    uint32_t srt = (syndrome >> 16) & 0x1f;
-    uint32_t cm = (syndrome >> 8) & 0x1;
+    uint32_t srt = FIELD_EX32(syndrome, DABORT_ISS, SRT);
+    uint32_t cm = FIELD_EX32(syndrome, DABORT_ISS, CM);
     uint64_t val = 0;
 
+    assert(syn_get_ec(syndrome) == EC_DATAABORT);
     assert(!cm);
     assert(isv);
 
-- 
2.43.0



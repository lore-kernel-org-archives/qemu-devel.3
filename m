Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B82C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 12:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rojYX-0002JX-IL; Mon, 25 Mar 2024 08:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rojYU-0002Ht-9n
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:35:58 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rojYS-0005dd-7v
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:35:57 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4148c650bc7so151855e9.2
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 05:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711370154; x=1711974954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4aVB8aQfFHBTbOCLmq+XJCLN+ZOpZZJ/7MtfrbF8pCw=;
 b=w9yF66WdwsE+kArJ66Pb6xkLwB9g3nGczm/cJOZDvW3tqOlgy2/rqEy0AI97C0k7FN
 ku+y1cYcrX3YZKsOafkDsbsBU5+9iLOT7JXENrI2scuhD2qwswe7s1rOyRsHhypfNhWR
 sCFbB9gSQ3ww2G+7nnXmm2xV59Ob9v3LPpPxRNBhCQM+gwCQV4RiZG1mVhKqMllR+n9C
 NUMx159Sw3REk/2cPJ97CE93mHMmcsWkbAzdOd0TowosL2jHYgh+H5yPBWLJI31aoynk
 FOfC3K+8YtCIWQNxMozhxuWD0U42oSxr6zNhF4ubTCCdDtJA9p1WscDOk214N5/lDPt9
 7csQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711370154; x=1711974954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4aVB8aQfFHBTbOCLmq+XJCLN+ZOpZZJ/7MtfrbF8pCw=;
 b=d6Quj62dOn56qTzFKFeLTeQtfGn60wrTSfwy5dhTb4h9jQmpdA2sNP7VkB4vfOYyBA
 nC2ehMlecMynk/appXtEZOIqHbVIplBuT7KX4Cxqqxq/FeSUpx32hbSy0Rziqnhfi+9L
 PWb6WG36xCKs358zGKPF/r5Zp7/+pfy/Lv+y4dZ1o2XZgBtpzbvV0RiYsddTqAXMA+oo
 dR98RK8aQNbFeOFrQ1xRvTsk6/gYU6Hm/9JxFZhEoVVkKXPCyVxlE7PVeoZ6ek2gKpyT
 HLPVcBLb75QcG88Vi50ABMJmLhslU1+R0avkG8b8+IBsF9jBibv1kPwdgj/TemnGFXWo
 yBbA==
X-Gm-Message-State: AOJu0Ywmm4334gY3/SMbUZgk9MGq3hB2Yvg3667z6BY0Agl9ovzHhVKb
 zUOxgzATmTF0v0EMpLIWvZkbpCZk7nKD/v+UazG7pHI0P9OyTYqxojNQGSLPDzC5sERjte7jQ2o
 j
X-Google-Smtp-Source: AGHT+IGqLRt27VLo3fRyDShnOrER+h0xzgX0O8ROeL2TyGpZWYt1pUpwZ7viQQ/I7hIKFpcBnipSpg==
X-Received: by 2002:a05:600c:1547:b0:413:ff10:cee with SMTP id
 f7-20020a05600c154700b00413ff100ceemr4997308wmg.13.1711370154700; 
 Mon, 25 Mar 2024 05:35:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 o19-20020a05600c339300b00414041032casm2303877wmp.1.2024.03.25.05.35.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 05:35:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 6/7] tests/unit/test-throttle: Avoid unintended integer division
Date: Mon, 25 Mar 2024 12:35:49 +0000
Message-Id: <20240325123550.1991693-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325123550.1991693-1-peter.maydell@linaro.org>
References: <20240325123550.1991693-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

In test_compute_wait() we do
 double units = bkt.max / 10;
which does an integer division and then assigns it to a double variable,
and similarly later on in the expression for an assertion.

Use 10.0 so that we do a floating point division and calculate the
exact value, rather than doing an integer division.

Spotted by Coverity.

Resolves: Coverity CID 1432564
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240312183810.557768-7-peter.maydell@linaro.org
---
 tests/unit/test-throttle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/unit/test-throttle.c b/tests/unit/test-throttle.c
index 2146cfacd36..24032a02667 100644
--- a/tests/unit/test-throttle.c
+++ b/tests/unit/test-throttle.c
@@ -127,13 +127,13 @@ static void test_compute_wait(void)
     bkt.avg = 10;
     bkt.max = 200;
     for (i = 0; i < 22; i++) {
-        double units = bkt.max / 10;
+        double units = bkt.max / 10.0;
         bkt.level += units;
         bkt.burst_level += units;
         throttle_leak_bucket(&bkt, NANOSECONDS_PER_SECOND / 10);
         wait = throttle_compute_wait(&bkt);
         g_assert(double_cmp(bkt.burst_level, 0));
-        g_assert(double_cmp(bkt.level, (i + 1) * (bkt.max - bkt.avg) / 10));
+        g_assert(double_cmp(bkt.level, (i + 1) * (bkt.max - bkt.avg) / 10.0));
         /* We can do bursts for the 2 seconds we have configured in
          * burst_length. We have 100 extra milliseconds of burst
          * because bkt.level has been leaking during this time.
-- 
2.34.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C76C3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 19:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzL89-0002Aw-C5; Mon, 31 Mar 2025 15:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL81-00029b-Op
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:49:03 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL80-0003MT-7X
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:49:01 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso33165785e9.2
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 12:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743450537; x=1744055337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ia8Kw97DGhP1r9MtPxxlIU481UcVxEFaeD8v9v4GxU4=;
 b=o0Y2MlNhEuEOPIbXfb1P+1qwO0roIjf5kX/E5gG54XCpcvL92utXGK/vjIGC2mbSJO
 ExYKPvja944tDOVCRjl0JrLVP0kKOWQi1GWT4b3vI7HtjQuiiqWZx6BQdxJlaKMOYzYO
 Q6HYFrq5iEKArjilaC7Q7x9K3704IoJcSZpMgimTd6pvZIlQo+7DBcoN1LMaA5sg0lM3
 Z5jwNVpkQIXdibozZwC4lzk0mGCTyVU0ZwIyqHDTIqP+6asPOXCgOYGWnYwm0p4SAPvB
 KdbvW0BwefEZIhI89C0IKZcbdmSemuOUdOHlybzk0jfRRAOVMYxjftLOHXwCjLxCSl2X
 N2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743450537; x=1744055337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ia8Kw97DGhP1r9MtPxxlIU481UcVxEFaeD8v9v4GxU4=;
 b=e4GvrM3Gv5yfUVJsyLd3XcMRn3xglUOLFdUq7fADXLDBIUsRj0r0QkDoRVCe3LOc8z
 h6BN90ZrwxGpNoBRvEEiSKLxB3m1KMD957V1U5NhEx3wMncU0IyaG3RWP8CxI7sDENyT
 uZSiRl03deak1OHCy27/42K+4C9gYiSJEgx1oiBOux08KllyOxOE98arwAivTSKf7My1
 AqAkoC/cj5oBjMaMhvWh5xOB8NVMNp+ElIFyPnpoM8IfBLqlpUCJ7MnfzQZQkT9YeDS/
 kj6Y/1p4bxh6Yw0Ev9s0I924Phj3vYG60qsNDrjZiR9ffPYrTg35SHlxUTW8LO93D1Rj
 Dphw==
X-Gm-Message-State: AOJu0Ywj6zcDP2oQfObmkCIVjXxU1NJcKfrxDTXZK9UeHd3sm8A+qhGv
 0ooArhE6KtvcpURfFHO693lo5RRMbAPkrAshk8p/NHcHGFSeOPNrAV6BMIKgFTvMdFC6ZKw+vG4
 +
X-Gm-Gg: ASbGnctOAlOibmemvPH/GEDR6WHTqwqKW0vlHhZc30Ccqx2EbjcpCBUdl0eOHoswUNN
 kE+wKQ3Kpqlan7cRyZSrTwl9ad371Armspmu4J30tX99vCGZqe7TQwFJedQNhZgEjdcn/kAbe65
 BljSZXaS38SyC5ZfLTUtrS0WMIUBb84LHBxdm7VVtdVdA/Rq67vTwuybvQA/xWNBHG+LT12Ph2c
 SNcOvKW3gKFR+PUKg9hrT+fKEEw9MOFytL5pnqMPTaQhNizEyE+yOoJmMdTEhnciN1Uc7zVkBZ2
 7xOKCXkvpTDI6RKDzahI1lvsg+0jkVCqBZZgeuWI0i9EWKtc6ZY9WPpv3Ysl0eCNqjej3QMm9un
 JI9sSOS0VtaYGGsywmAQ=
X-Google-Smtp-Source: AGHT+IFdFLIC4+Fdk3qiWvS70Q4uzB8lCh62s4rsYgR1ENjis9i3lv06H8kt/QMYkBGgeOp3Bmbn8g==
X-Received: by 2002:a05:600c:4744:b0:43c:fb36:d296 with SMTP id
 5b1f17b1804b1-43db62bded3mr88499355e9.25.1743450537538; 
 Mon, 31 Mar 2025 12:48:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ea8df934esm263705e9.2.2025.03.31.12.48.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 31 Mar 2025 12:48:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 07/23] hw/display/dm163: Add description
Date: Mon, 31 Mar 2025 21:48:05 +0200
Message-ID: <20250331194822.77309-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331194822.77309-1-philmd@linaro.org>
References: <20250331194822.77309-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20250325224310.8785-4-philmd@linaro.org>
---
 hw/display/dm163.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/dm163.c b/hw/display/dm163.c
index 75a91f62bd3..f6f0ec0c632 100644
--- a/hw/display/dm163.c
+++ b/hw/display/dm163.c
@@ -330,7 +330,7 @@ static void dm163_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
 
-    dc->desc = "DM163";
+    dc->desc = "DM163 8x3-channel constant current LED driver";
     dc->vmsd = &vmstate_dm163;
     dc->realize = dm163_realize;
     rc->phases.hold = dm163_reset_hold;
-- 
2.47.1



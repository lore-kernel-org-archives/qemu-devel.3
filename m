Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D173CD5BC5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 13:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smC7C-000208-Mo; Thu, 05 Sep 2024 09:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC72-0001LA-07
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:24 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6y-0001nL-Os
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:23 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-374c84dcc90so478932f8f.1
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 06:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725541279; x=1726146079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gZRGtO6SmZHDabe4EZR6EK0mqdv3jxaN8ddZYk6gMA0=;
 b=NPshg+3cYepOnD0Z3Lfbxg0lxTlb3lLt/QkGLU117hQKZ10ow5qeC6JfI6axrD9uJL
 pnsW/aXJVLBWcnq7l9TCVCyvFJxUNbum+AC7gPbf8ORWxa3D/8t7IaGb5N6XoWBW7Yan
 mY+D2qRsIy0CMKs8nej5vXuyD0rCsPZaOzhOyfoTG81fqYy0ySeAd6nNBmtx5mI1pPeH
 +yqd6ofvwFKhFga/J/pRcJWpyZ3Ck3qDOPTC2mYdnAt2eiYyftZLUzb7XKAfabJyhniX
 1MYYeGi+Kt8hp1wGbh1KTMFVsMLTiK3ddhozwFp/KEdaOarSETEdiw/4FMyNjl4YUWHX
 I2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725541279; x=1726146079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gZRGtO6SmZHDabe4EZR6EK0mqdv3jxaN8ddZYk6gMA0=;
 b=NrQJ6vCq0RjBb8FvBnbAVV8mh6RuyQvj7yn13pTz5QcWUZNTcQu0olcuPGKdmTmhV3
 WtW57TFCaI1MJ6A1BpzuRlr+jHT5sws8Lv5FuTtsqybRvkcXiy5VjT/3QsHcQ2TT3Lgh
 1iVLtIM0gKLfXYtWoz2PWydtpHEbgiGBGZPsGiBB9YwvKHLGatkr2RIOOvOr+XSYMHAt
 sU2N4Q1+kdEV4Gli0Ql7bkAypb4kpfUZgNqK2JiN+K2AfviwGcf8Wt/ioiZ3UB3R+OFZ
 MiLNfgPvc/wGkV+U5pHqrNm5fVcEHiLsWTyKjbWmiJqjElszx+BbUPvBsDN/8oRCxzzx
 dTpQ==
X-Gm-Message-State: AOJu0Yx9JKk0T4akVgYD6KqlMu5UKv7M1SuFyVnQNpAfa80qqo32F3TD
 EOiL1l3EZPWEJBNXXBppNnq+f14jxZfOL0Kk5BSr25ES/ucvBtbiINuF+IDHZW+KJJdQxp7OZhi
 /
X-Google-Smtp-Source: AGHT+IELypuksUdMYs1U38DY8kq/1Qp/rX8lRgkoi3arhmNG+49XGhNWVGyaaBlvCzObW3X3zx1eFw==
X-Received: by 2002:a5d:4fc1:0:b0:374:c87c:6648 with SMTP id
 ffacd0b85a97d-3776f929435mr3651297f8f.25.1725541278789; 
 Thu, 05 Sep 2024 06:01:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e355dfsm232251365e9.46.2024.09.05.06.01.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 06:01:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/25] platform-bus: fix refcount leak
Date: Thu,  5 Sep 2024 14:01:00 +0100
Message-Id: <20240905130100.298768-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905130100.298768-1-peter.maydell@linaro.org>
References: <20240905130100.298768-1-peter.maydell@linaro.org>
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

From: Gao Shiyuan <gaoshiyuan@baidu.com>

memory_region_find() returns an MR which it is the caller's
responsibility to unref, but platform_bus_map_mmio() was
forgetting to do so, thus leaking the MR.

Signed-off-by: Gao Shiyuan <gaoshiyuan@baidu.com>
Message-id: 20240829131005.9196-1-gaoshiyuan@baidu.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: tweaked commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/core/platform-bus.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
index b8487b26b67..dc58bf505aa 100644
--- a/hw/core/platform-bus.c
+++ b/hw/core/platform-bus.c
@@ -145,9 +145,12 @@ static void platform_bus_map_mmio(PlatformBusDevice *pbus, SysBusDevice *sbdev,
      * the target device's memory region
      */
     for (off = 0; off < pbus->mmio_size; off += alignment) {
-        if (!memory_region_find(&pbus->mmio, off, size).mr) {
+        MemoryRegion *mr = memory_region_find(&pbus->mmio, off, size).mr;
+        if (!mr) {
             found_region = true;
             break;
+        } else {
+            memory_region_unref(mr);
         }
     }
 
-- 
2.34.1



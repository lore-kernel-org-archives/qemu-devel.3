Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A87C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 12:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rojYW-0002Ic-2q; Mon, 25 Mar 2024 08:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rojYU-0002Hs-5x
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:35:58 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rojYR-0005dW-QR
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:35:57 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4148c607f31so246485e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 05:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711370154; x=1711974954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cPU63vtq7nGV4qBFhe6DUh4SCq/4JARPRKtq5Gn7vKA=;
 b=iW/PqS6VPldOP78K54KmqaPGL9XCS7yBLaUn2k871mKn+j4dfIK8MJdL+X1sqUK1nF
 WhoLC4eYZUQILN9x2hQr1X0mBumWApK+yrJS5kEQuWu5Agg2oaxObJJvTCn1o9nW2/xU
 lu+a6sMPnbZibN7PtRKM+mPmGNgYGGbwgTlXjUggjKOrXUXTR+u46f6OC8WO0J02/A9i
 lgnK6WQ1rZs3Jw80M78sCWYJKdplMmYeoy+BVvLIw6Yywinj/r0lqxq13ngBdn7zh+oX
 noo+dtzvWMWC1DESe81wY4TOV09CGCrA9VCl1q5W6a9DQg10BTczpUmW4fPD8KDK3rzz
 IJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711370154; x=1711974954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cPU63vtq7nGV4qBFhe6DUh4SCq/4JARPRKtq5Gn7vKA=;
 b=CkP5Ufgy9sJxE0bnPLC9Hspir0MIkEliRd+9ZQYFJx8C9MPPQKyPMmaPLBcqaJFuzI
 YoHrTOthpUrDcv16Di0fqTGw1D/OphC6aveu3Lt96ik1H597def7sgKhLAG3KP6XzFfv
 p9ytKhQWKEdyerCVdNsdIMxYfOdSvUYwZ5cBt5RanTpgeEUICV3BhQRJSdlewBt3OfQz
 P0BViEyn4frXMf9Jbf1DpoUtCsQRs/aUUGdGCwqIWSUpv5VbmxK+RQAzmxf9YBS7vQ+R
 9n8h/1cY+1lNPSUyazQGKhbseeqsrzBVKvcRAOCtOSfmSGeY83q3xBfAIFMhurIG1XKd
 sAaw==
X-Gm-Message-State: AOJu0YzcTeJ9lupjZiNBiVvJfbVaidFe1Vf9r/3SmReCrnelvfIPcchm
 zgGauWAqsc16mPZ0Y5ORlaW6qJmADgD147iwj/kXehWlpEess4+qzgNviTcfamyb3KElfX5t72W
 e
X-Google-Smtp-Source: AGHT+IHwYOSADN27vwyXi8KbGnJ1XMry2w9dJYCq48639W+pL+ysrGnwhO1IuC3XI27py29vJLH+mw==
X-Received: by 2002:a05:600c:450c:b0:414:86a2:a43 with SMTP id
 t12-20020a05600c450c00b0041486a20a43mr2496920wmo.40.1711370154162; 
 Mon, 25 Mar 2024 05:35:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 o19-20020a05600c339300b00414041032casm2303877wmp.1.2024.03.25.05.35.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 05:35:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 5/7] hw/nvram/mac_nvram: Report failure to write data
Date: Mon, 25 Mar 2024 12:35:48 +0000
Message-Id: <20240325123550.1991693-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325123550.1991693-1-peter.maydell@linaro.org>
References: <20240325123550.1991693-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

There's no way for the macio_nvram device to report failure to write
data, but we can at least report it to the user with error_report()
as we do in other devices like xlnx-efuse.

Spotted by Coverity.

Resolves: Coverity CID 1507628
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240312183810.557768-6-peter.maydell@linaro.org
---
 hw/nvram/mac_nvram.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/nvram/mac_nvram.c b/hw/nvram/mac_nvram.c
index 5f9d16fb3e3..59277fbc776 100644
--- a/hw/nvram/mac_nvram.c
+++ b/hw/nvram/mac_nvram.c
@@ -48,7 +48,10 @@ static void macio_nvram_writeb(void *opaque, hwaddr addr,
     trace_macio_nvram_write(addr, value);
     s->data[addr] = value;
     if (s->blk) {
-        blk_pwrite(s->blk, addr, 1, &s->data[addr], 0);
+        if (blk_pwrite(s->blk, addr, 1, &s->data[addr], 0) < 0) {
+            error_report("%s: write of NVRAM data to backing store failed",
+                         blk_name(s->blk));
+        }
     }
 }
 
-- 
2.34.1



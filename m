Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C64C3DA64
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 15:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWH8x-0005Ic-Gi; Tue, 23 Jul 2024 11:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWH8v-0005FD-KP
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 11:09:33 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWH8t-0000pv-9Q
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 11:09:33 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-368712acb8dso2719032f8f.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 08:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721747369; x=1722352169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rg4YrdclRSstpDHECHFcor9WAWNBiDqvFJIrnUKj3R4=;
 b=GKeMeaiOriIEWknnQzu6CMyF+vOC2uOe2lxw3K+k6V0QwPr8Wh6WcDPXTLhsMk8gX6
 ZyXalOg2g2AbCe3WGtIY1PMl1Zb57tgcY0RXsyNnhwwFJk2+s/5u/CFoX0Hn3L7J1mr5
 ngUtWplxOzwzTVe6e5dWXZ+OCwqOXFBNHslhS1tglJkdWzHgKupeuafy5AkeBwvgitpV
 MsS3WPltFaX6UGOF//hNYcItpypTrHmeicWO8gqnVYVz32iYdpZIG61lTTDHPBjwiMLQ
 Nf2AopYzvxGGGoMemHjY42hFl4wuGgO25lLx0TFXAkoUsw1a7HPNS8fo/nmvVKO6i9nZ
 bcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721747369; x=1722352169;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rg4YrdclRSstpDHECHFcor9WAWNBiDqvFJIrnUKj3R4=;
 b=KyNp2PBl20rz/ULPPJ19bA0NrUyo+ahTCAW86R4iGGcSXrzGlzJpoMdvq32CGHozBX
 USWSk+GUZ8nt2EupttaLgUUqfPkBl9C5eVCHrVh8LWobZ2a8jnGkwe0jh2ZoUoypv8qn
 FIvTWPu36AGyAEb0jOEhtNuFOUdZHn+BR0xNtI1MykV0l7xWZaYidy7fQT01rz9UeFAz
 KPRslN8ZlD+ylyDMfLWrvzKLzL/bUl0Q+sxj+i9FgMuoUbRRkQWacJRm2xXTC/OjznQL
 BO45b83uvEGZyLmQnY2TGT05uZrSq8VQhdjSpHuYXt8uijjpViTcowCkQJwJHvdsaeY8
 8Y5w==
X-Gm-Message-State: AOJu0YzaAp0RdS3618U85ghhk4EE8bVUiPmUJGUoiMjWjoYpZyzARIil
 LQy1yrCS0TeGEgymyfA693GxCN+qgpMn8gYxyfDTZ0iflrNP5Rpm2e9tP2Bx4p03ZUcVp58gcKb
 v
X-Google-Smtp-Source: AGHT+IFZeZl44F94akxzUA+mSCadvLTlew4iqxP78lm7gkLiOXV1PwXCZVO5gAlrwtkdyDZ0wKjGHQ==
X-Received: by 2002:adf:fece:0:b0:368:5d2:179 with SMTP id
 ffacd0b85a97d-369dee56dafmr2550057f8f.56.1721747369254; 
 Tue, 23 Jul 2024 08:09:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3687868b33bsm11844377f8f.33.2024.07.23.08.09.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 08:09:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org
Subject: [PATCH] util/async.c: Forbid negative min/max in
 aio_context_set_thread_pool_params()
Date: Tue, 23 Jul 2024 16:09:27 +0100
Message-Id: <20240723150927.1396456-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

aio_context_set_thread_pool_params() takes two int64_t arguments to
set the minimum and maximum number of threads in the pool.  We do
some bounds checking on these, but we don't catch the case where the
inputs are negative.  This means that later in the function when we
assign these inputs to the AioContext::thread_pool_min and
::thread_pool_max fields, which are of type int, the values might
overflow the smaller type.

A negative number of threads is meaningless, so make
aio_context_set_thread_pool_params() return an error if either min or
max are negative.

Resolves: Coverity CID 1547605
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 util/async.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/async.c b/util/async.c
index 0467890052a..3e3e4fc7126 100644
--- a/util/async.c
+++ b/util/async.c
@@ -746,7 +746,7 @@ void aio_context_set_thread_pool_params(AioContext *ctx, int64_t min,
                                         int64_t max, Error **errp)
 {
 
-    if (min > max || !max || min > INT_MAX || max > INT_MAX) {
+    if (min > max || max <= 0 || min < 0 || min > INT_MAX || max > INT_MAX) {
         error_setg(errp, "bad thread-pool-min/thread-pool-max values");
         return;
     }
-- 
2.34.1



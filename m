Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640E2EE499D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:29:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMJh-0000CU-4e; Wed, 11 Sep 2024 08:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMIv-0005Vu-EB
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:18:37 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMIt-0007d7-GF
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:18:37 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42cb6f3a5bcso1235465e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057112; x=1726661912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IjC/62EZVazJYeQw2M6RGzr8NQkf0Ibb5BD/Lj2iJ4w=;
 b=uVKStR93J3SDrbuKqgz2blhMQwrfsJt/xWFhc/B+OF5yDejnB95fIMGyB6eVnj+2VF
 A/F/NUdaVdl/UItsD/m3piZe2Yl+wEzOBCdzz9eeO4LjkrS9kkbMpcSLa2eJStXsKr5R
 WSY0YsQpKcjwrTebNvoLRSKLocLpy2318RpbH4DVrcgD+K6U22AuS8IF82I8LxQplvIJ
 GMyEI/uVql4VGYrma5tODEWrtWpajd/7hp8nPejFPFEIRe6ZKnUgPmVoQHxz7qQeK+jc
 /AYmvBSVN29KziBSfnOjpvbVUbRy/iEwgKXtOmV1gjQUEwVkcbKqM7JEGNL+rBCMBESt
 Dv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057112; x=1726661912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IjC/62EZVazJYeQw2M6RGzr8NQkf0Ibb5BD/Lj2iJ4w=;
 b=Jsw/ErfM9Cv3Obj1YhGjpT2bkm8xp493A+Xc7S9Z2uat99CmYQtMUqWhE43SdPcsd5
 2G3LiWo1cBpBEYF/mtFtIIDcENh2SCP/BPq2FyfemeAeaBR8TtzFAfQnzYzW1d3q15Ra
 VhL85xeNcz0jA+GNIozc8WuzUTyk75ffvLB1G8NkyMGzqpFJpGQOuMPPxyDKBkdcEOks
 UGK8E9Fss1/ZyZEC9sQbqukkq6mXvag0sEuSIqqi9rwonQvgiSyjyX/dWHN1K2dQrsSv
 NogVy2WDc17ZAkGDPvVnd8SHMrqmEGIeePit4TGQ7WAfWmMEwhfpga9EeYLu5GAa+uNX
 3LbA==
X-Gm-Message-State: AOJu0YzhOhietz3cFJo5NApU/iB8cTBFN5f5Dt1N9Zq0cEVocDyd2l3C
 ryCyGwmDyvrmo2xiSxN0r0/+y3EC09T+y/88bIJK2c+phbW1YenLz7osSiUTWvpKoxvNBBeobA7
 S
X-Google-Smtp-Source: AGHT+IEwZ8ub/zG+WTc1oVNFNPN0T22cK2V/i4z1+K3dlcahBoc6CFYvXJHoyWK5wOrBiFC5wjBUyA==
X-Received: by 2002:a5d:4387:0:b0:374:c160:269e with SMTP id
 ffacd0b85a97d-378922a6d58mr12019583f8f.22.1726057112444; 
 Wed, 11 Sep 2024 05:18:32 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895649733sm11448859f8f.8.2024.09.11.05.18.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:18:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <alistair.francis@wdc.com>,
 Octavian Purdila <tavip@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 34/56] fifo8: add skip parameter to fifo8_peekpop_bufptr()
Date: Wed, 11 Sep 2024 14:13:59 +0200
Message-ID: <20240911121422.52585-35-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

The skip parameter specifies the number of bytes to be skipped
from the current FIFO head before the peek or pop operation.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Octavian Purdila <tavip@google.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240828122258.928947-4-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 util/fifo8.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/util/fifo8.c b/util/fifo8.c
index 5faa814a6e..62d6430b05 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -72,18 +72,20 @@ uint8_t fifo8_pop(Fifo8 *fifo)
 }
 
 static const uint8_t *fifo8_peekpop_bufptr(Fifo8 *fifo, uint32_t max,
-                                           uint32_t *numptr, bool do_pop)
+                                           uint32_t skip, uint32_t *numptr,
+                                           bool do_pop)
 {
     uint8_t *ret;
     uint32_t num, head;
 
     assert(max > 0 && max <= fifo->num);
-    head = fifo->head;
+    assert(skip <= fifo->num);
+    head = (fifo->head + skip) % fifo->capacity;
     num = MIN(fifo->capacity - head, max);
     ret = &fifo->data[head];
 
     if (do_pop) {
-        fifo->head += num;
+        fifo->head = head + num;
         fifo->head %= fifo->capacity;
         fifo->num -= num;
     }
@@ -95,12 +97,12 @@ static const uint8_t *fifo8_peekpop_bufptr(Fifo8 *fifo, uint32_t max,
 
 const uint8_t *fifo8_peek_bufptr(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
 {
-    return fifo8_peekpop_bufptr(fifo, max, numptr, false);
+    return fifo8_peekpop_bufptr(fifo, max, 0, numptr, false);
 }
 
 const uint8_t *fifo8_pop_bufptr(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
 {
-    return fifo8_peekpop_bufptr(fifo, max, numptr, true);
+    return fifo8_peekpop_bufptr(fifo, max, 0, numptr, true);
 }
 
 uint32_t fifo8_pop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen)
-- 
2.45.2



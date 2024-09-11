Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53F5EE499F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMJp-0001ox-SD; Wed, 11 Sep 2024 08:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMJD-0006rN-L9
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:19:05 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMJA-0007er-OZ
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:18:54 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42cb1e623d1so19092625e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057130; x=1726661930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JGgy78gvcc3jMmF3sOv2NVPvQFdbhvqBJ1whFt/CWgE=;
 b=efwmZZqs30WofrBfABHfrfbvnJg115LhCzhRO0WfMQ9MDN4nMuKP29xrMtdUkEdpYQ
 MTZWKYgFZd/8a90GY2pRDJKJrDW3MpYMpY/YOwnL1AOS/Rz5UxnXuV7y4NQQxetj2ShD
 XTducv+yp1NKk66qhkcLyb7T1SDuN4hd8ne4O9ezKjPfDJLNdlTSzoQPCXAyqktRm6xQ
 Wrc9bSgD2VVWtdF+Tk9exTyiwO23oDpu0nbmW0Dy4qVfh/81bmIBOxhniy6g92bcpZyL
 heC4/gU+9wlqCFK4QGrgXgMxKPU2PV3+CavFQBW/hJrcq5hnz33+9ddEI4NsPPxj7G7p
 bUgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057130; x=1726661930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JGgy78gvcc3jMmF3sOv2NVPvQFdbhvqBJ1whFt/CWgE=;
 b=wxBaa2LybUrtoLZOAlvbe8Px90SOwk+7ID1EVk0WfOIA4zccQg7q4Tbtw0JtEG5pcc
 jaw3ZupOcvpewwObqE7K95739lSrZIYAVS1M1YjFHjy1Atwp1mnjfN49bG8MB2mkrb6V
 HZLmn9CylFVpEVA5TzpeQLN2LpR5ZKfow8GOV6X+t4RHtia2oOztIlvdr2WEDjQ2jCrE
 1lCUN9BKiCAWzG2NOZ8JNVtZyensTk5bxS/oFli21Zy5/HyDOThxG2nnEamQ71IpnmW/
 S3rogmRgab7xuKk8tp+uYd0yJUgLb+XlmEvOQkQb8fr4G1fcsSgOi3dWFoAk1tckKdJt
 Kajw==
X-Gm-Message-State: AOJu0YzJMBJUZIGK2UkU5jZbmgpvOGjRdMjIOk4SDTXGtgV6ga8j+XCC
 TTIKvC1ZPlugcwOnKvwDq0INdGIIH+Mt88TUDeaiHuwU3aglD3u2wieWhC3g41/C7OLkHdTRwoB
 Y
X-Google-Smtp-Source: AGHT+IFrKM3HpuL5U113y0wdP82Iwwbb/s7kyptaQXQZ+1cVSI1gbLkFMo0n5xtXfA/qZ78l32fRAg==
X-Received: by 2002:a05:600c:4fc5:b0:42c:b22e:fc2e with SMTP id
 5b1f17b1804b1-42ccd32cdb4mr22693415e9.15.1726057130295; 
 Wed, 11 Sep 2024 05:18:50 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42cc8be465csm35399005e9.28.2024.09.11.05.18.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:18:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <alistair.francis@wdc.com>,
 Octavian Purdila <tavip@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 37/56] fifo8: honour do_pop argument in fifo8_peekpop_buf()
Date: Wed, 11 Sep 2024 14:14:02 +0200
Message-ID: <20240911121422.52585-38-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Pass the do_pop value from fifo8_peekpop_buf() to fifo8_peekpop_bufptr()
to allow peeks to the FIFO buffer, including adjusting the skip parameter
to handle the case where the internal FIFO buffer wraps around.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Octavian Purdila <tavip@google.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240828122258.928947-7-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 util/fifo8.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/util/fifo8.c b/util/fifo8.c
index 5453cbc1b0..1031ffbe7e 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -117,7 +117,7 @@ static uint32_t fifo8_peekpop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen,
     }
 
     len = destlen;
-    buf = fifo8_peekpop_bufptr(fifo, len, 0, &n1, true);
+    buf = fifo8_peekpop_bufptr(fifo, len, 0, &n1, do_pop);
     if (dest) {
         memcpy(dest, buf, n1);
     }
@@ -126,7 +126,7 @@ static uint32_t fifo8_peekpop_buf(Fifo8 *fifo, uint8_t *dest, uint32_t destlen,
     len -= n1;
     len = MIN(len, fifo8_num_used(fifo));
     if (len) {
-        buf = fifo8_peekpop_bufptr(fifo, len, 0, &n2, true);
+        buf = fifo8_peekpop_bufptr(fifo, len, do_pop ? 0 : n1, &n2, do_pop);
         if (dest) {
             memcpy(&dest[n1], buf, n2);
         }
-- 
2.45.2



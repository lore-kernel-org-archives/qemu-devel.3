Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC88CC3DA7E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 20:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWMJs-0006GB-Fc; Tue, 23 Jul 2024 16:41:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMJq-00062Y-Qd
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:41:11 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWMJo-0004Vs-QJ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 16:41:10 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-367940c57ddso3144279f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 13:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721767267; x=1722372067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dSCWBLk+dTPyKUi346CpD+A3ideUlHg+vbcXd5eth70=;
 b=qapZBxDWb//CkAlAcCV2eDsSeTAadPyUoxa9ROkt43zyWWoX01SRKCXrb2QUdHTbI+
 0CFqoD6gGfw1U/eo8xPK0Z1kkYOk65BgGMLklrh+3dfvatyrlwK+4RarmDjBfArTCv2N
 FrlnemUB64CVzbXQE/fXca3R7/QeYCYtIKx/LvCcIQ96rBYgG5DvjjD6aWRmGgS/i5+2
 4sdvcO0noNDvBpVMt61gjElJhUDpsXvO/LLM0sNOxAsbllFTIJajoEW3WW6MqL1mC0vE
 QY9TZ0+Tm763/NDOcWFunNwcPHz+JNjWkTXnHl+J+NF17Tt6ivF5PWIPFPdedeZbATUs
 MwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721767267; x=1722372067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dSCWBLk+dTPyKUi346CpD+A3ideUlHg+vbcXd5eth70=;
 b=nHFaDLATtcHeQLCCgp3SCJFx+n+x31cQNfBWGLssR1c1wJ2i8VRgN09oyAINCTaDNn
 o8B/p5nqKz3/D3BjyuyqnO9a0nS6dYHAPzSlqDlbR3sjqE7nxaz7UFsC6vHr0FDGdgiw
 1frObyT87S7/hCTowGZ44hjXSyx1awi/x7egbEm+mOaT1yyFRZakQIMIRIBXVc/AWBoU
 kn/TCNd924LIfbilemgpSKMZsrcDZyYxTfI2DzRx39pdA4lmtKb/utPEPzAMuagQzNTg
 T2kS4AwXzkgJTlctE32sXYANG3bpmyemp5358O5ZkFW6dAcBrxl71n/dFnEPeaaKbIOU
 SWQw==
X-Gm-Message-State: AOJu0YwRRltk07VaCcwUs6UeDg/DOTf/wuahKFaw7U8oelmEMHKugjqX
 HsujcO6O0g0dl+dF+CDVn/xgcpyx87eOW0Z60WRzBp4ugox4/jofuOwv92h9MVwnbSP4BWVlmfl
 +W7M=
X-Google-Smtp-Source: AGHT+IFG2nm/lCT+8XjPxSNVK/q+eDv/M6vNHUpHyX6B6M8b0aVz9Nezc15d/G2ixdfU4CsbQQhhiA==
X-Received: by 2002:a5d:6a47:0:b0:368:4ed7:2acb with SMTP id
 ffacd0b85a97d-369bae01e22mr5450473f8f.5.1721767266672; 
 Tue, 23 Jul 2024 13:41:06 -0700 (PDT)
Received: from localhost.localdomain
 (vbo91-h01-176-184-50-4.dsl.sta.abo.bbox.fr. [176.184.50.4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787eced0sm12312095f8f.98.2024.07.23.13.41.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 23 Jul 2024 13:41:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 23/28] util/fifo8: Rename fifo8_peek_buf() ->
 fifo8_peek_bufptr()
Date: Tue, 23 Jul 2024 22:38:50 +0200
Message-ID: <20240723203855.65033-24-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240723203855.65033-1-philmd@linaro.org>
References: <20240723203855.65033-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Since fifo8_peek_buf() return a const buffer (which points
directly into the FIFO backing store). Rename it using the
'bufptr' suffix to better reflect that it is a pointer to
the internal buffer that is being returned. This will help
differentiate with methods *copying* the FIFO data.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-Id: <20240722160745.67904-5-philmd@linaro.org>
---
 include/qemu/fifo8.h | 11 ++++++-----
 hw/scsi/esp.c        |  2 +-
 util/fifo8.c         |  2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
index 2692d6bfdaa..e287e871190 100644
--- a/include/qemu/fifo8.h
+++ b/include/qemu/fifo8.h
@@ -89,16 +89,17 @@ uint8_t fifo8_pop(Fifo8 *fifo);
 const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr);
 
 /**
- * fifo8_peek_buf: read upto max bytes from the fifo
+ * fifo8_peek_bufptr: read upto max bytes from the fifo
  * @fifo: FIFO to read from
  * @max: maximum number of bytes to peek
  * @numptr: pointer filled with number of bytes returned (can be NULL)
  *
  * Peek into a number of elements from the FIFO up to a maximum of @max.
  * The buffer containing the data peeked into is returned. This buffer points
- * directly into the FIFO backing store. Since data is invalidated once any
- * of the fifo8_* APIs are called on the FIFO, it is the caller responsibility
- * to access it before doing further API calls.
+ * directly into the internal FIFO backing store (without checking for
+ * overflow!). Since data is invalidated once any of the fifo8_* APIs are
+ * called on the FIFO, it is the caller responsibility to access it before
+ * doing further API calls.
  *
  * The function may return fewer bytes than requested when the data wraps
  * around in the ring buffer; in this case only a contiguous part of the data
@@ -113,7 +114,7 @@ const uint8_t *fifo8_pop_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr);
  *
  * Returns: A pointer to peekable data.
  */
-const uint8_t *fifo8_peek_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr);
+const uint8_t *fifo8_peek_bufptr(Fifo8 *fifo, uint32_t max, uint32_t *numptr);
 
 /**
  * fifo8_reset:
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 8504dd30a0d..412c8cf2260 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -486,7 +486,7 @@ static bool esp_cdb_ready(ESPState *s)
         return false;
     }
 
-    pbuf = fifo8_peek_buf(&s->cmdfifo, len, &n);
+    pbuf = fifo8_peek_bufptr(&s->cmdfifo, len, &n);
     if (n < len) {
         /*
          * In normal use the cmdfifo should never wrap, but include this check
diff --git a/util/fifo8.c b/util/fifo8.c
index 2925fe56119..566b0893441 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -92,7 +92,7 @@ static const uint8_t *fifo8_peekpop_buf(Fifo8 *fifo, uint32_t max,
     return ret;
 }
 
-const uint8_t *fifo8_peek_buf(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
+const uint8_t *fifo8_peek_bufptr(Fifo8 *fifo, uint32_t max, uint32_t *numptr)
 {
     return fifo8_peekpop_buf(fifo, max, numptr, false);
 }
-- 
2.41.0



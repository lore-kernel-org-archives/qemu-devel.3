Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165FAC3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 15:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUpLo-0007NV-3Q; Fri, 19 Jul 2024 11:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUpLn-0007KG-59
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 11:16:51 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUpLl-0005x2-G9
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 11:16:50 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4257d5fc9b7so14736175e9.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2024 08:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721402208; x=1722007008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i62jBV6Wd55qPAZwjTal/ze4o9fjzCulHJqhfykkTds=;
 b=dfvdO26DReFXZr4UPuNmazfJHBaKFJPBA4WQDsG9Ge3mFy/8TPjZpQQUgrfNZjuDSG
 jL5IaytnC/rfNtbDihbfvHw+MXq6iu2M6Qu3EoG62G3H1rtWEHi3ywYMu3Id2ZFva0T+
 1myk2XTn4cYat63znf3HGbXNFzhyMut1pjTHOyhnd6lNAALG02Vpho335aMumAvh+xVJ
 kOt/jCNHZjFZcMtJ2NgRygvB1KQ+07GU1Elhm3M+HERqDWuvq/etGv6TPoeQifLnI/sA
 1iH+v6kl0fvzQH8gn0d4QP+VIuyXeSg8uTmDVbTa5DOpxw8eRQyL1TJr9JrlUa1HKW8r
 agqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721402208; x=1722007008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i62jBV6Wd55qPAZwjTal/ze4o9fjzCulHJqhfykkTds=;
 b=ADHAQLzQSjDhuxIFQ6leqNDh/Tpoyfs4rFcxurHCyYtKbBjL7tDX99YhOHQ6TfHrji
 U8DqI5uN0Ko6x4o/ZHCLWgmWty4KbmEOAvoQxpmk5sS2u7j6aRe3g+qswxTzDwdDfcnR
 0BhEC1KFjyE4TTLZS7nyyy3aIvVppALYxwPyqfv5+fa57LZAXs4jrMwzXVMXcV+HuEMs
 2itkej9CNL/fcSo3NFcumcgWPhesuKhXJotr2yoK9nTFNUgokDMzPWbDvLHHOujIMaEz
 gU/kGmZTsRlkpBDGGQBuCS4Vv1xNyoGS3HM+dWhnz/162zsdQXtCwshebI9+jejmRxPZ
 BxJw==
X-Gm-Message-State: AOJu0YwEYqrfPCashFeTyNZ5ZBIcSB7uXpPkwqgYwNU0BhryN5Od+onM
 Gp2gBd+y8h8bwrVdBQ/0lz7Gvq493nWoVJVUJ3wdp7/glHBY7na9yTN3RlME1OqDx1I31UEa52m
 M
X-Google-Smtp-Source: AGHT+IHmFBeYZWO165sVEDlQH/Y+8AS5DDH4d8ObfmnLoUCR25KysZgysm3bd43NVgkkd5kxNHNQkg==
X-Received: by 2002:a05:6000:9:b0:368:7f53:6b57 with SMTP id
 ffacd0b85a97d-3687f536bd8mr1363963f8f.18.1721402207833; 
 Fri, 19 Jul 2024 08:16:47 -0700 (PDT)
Received: from localhost.localdomain ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684204sm1857670f8f.2.2024.07.19.08.16.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Jul 2024 08:16:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/3] util/fifo8: Introduce fifo8_change_capacity()
Date: Fri, 19 Jul 2024 17:16:28 +0200
Message-ID: <20240719151628.46253-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240719151628.46253-1-philmd@linaro.org>
References: <20240719151628.46253-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

FIFOs can be resized at runtime. Introduce the
fifo8_change_capacity() method to do that.
When capacity is changed, the FIFO must be reset.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/fifo8.h | 10 ++++++++++
 util/fifo8.c         |  7 +++++++
 2 files changed, 17 insertions(+)

diff --git a/include/qemu/fifo8.h b/include/qemu/fifo8.h
index c6295c6ff0..9fe0555a24 100644
--- a/include/qemu/fifo8.h
+++ b/include/qemu/fifo8.h
@@ -31,6 +31,16 @@ void fifo8_create(Fifo8 *fifo, uint32_t capacity);
 
 void fifo8_destroy(Fifo8 *fifo);
 
+/**
+ * fifo8_change_capacity:
+ * @fifo: struct Fifo8 to change the capacity
+ * @capacity: new capacity of the FIFO
+ *
+ * Change a FIFO capacity to the specified size. The FIFO is reset.
+ */
+
+void fifo8_change_capacity(Fifo8 *fifo, uint32_t capacity);
+
 /**
  * fifo8_push:
  * @fifo: FIFO to push to
diff --git a/util/fifo8.c b/util/fifo8.c
index 2925fe5611..c453afd774 100644
--- a/util/fifo8.c
+++ b/util/fifo8.c
@@ -34,6 +34,13 @@ void fifo8_destroy(Fifo8 *fifo)
     g_free(fifo->data);
 }
 
+void fifo8_change_capacity(Fifo8 *fifo, uint32_t capacity)
+{
+    fifo->data = g_renew(uint8_t, fifo->data, capacity);
+    fifo->capacity = capacity;
+    fifo8_reset(fifo);
+}
+
 void fifo8_push(Fifo8 *fifo, uint8_t data)
 {
     assert(fifo->num < fifo->capacity);
-- 
2.41.0



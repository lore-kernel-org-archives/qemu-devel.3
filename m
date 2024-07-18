Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABF48C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMfD-0001Ju-J7; Thu, 18 Jul 2024 04:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMfC-0001DH-9D
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:38:58 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMfA-0004gQ-LA
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:38:58 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4266fd395eeso420005e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 01:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721291934; x=1721896734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ZkYqvJBN+Ms+VQxfxYaIWgzMBdCSAtS0DZxHKASYzs=;
 b=Vb8YuQkVa34ngOnrdB+7Gng8mXDOdjQfkcZBxz4uMIhAVrf+aYuY7um68nZgCQlAS+
 cIGq+fuxTiKoGq4OrwOZs4F6/uc+XG3z8qtRfjBGdPzXsMknwgJNjyRh3IX52Kgang8M
 R7NRSlm7qTMHEBC5BK406IZecKnmv61QpdD5gbb7ytaNpIOnFAGENEUvUiU+bNHI/NvV
 oMdPR+8xrA22qCiIfunUUrYihWIRTpC8PG3JdldB8zGwBVavhZox4bUxiYRGTNJZACpA
 wOiQ7Yld1NEYozwghKCUSADWIL6NTEU/DXdQmJTZs9OUaEYLnHgFqPK0B52PZp065QSa
 rCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721291934; x=1721896734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9ZkYqvJBN+Ms+VQxfxYaIWgzMBdCSAtS0DZxHKASYzs=;
 b=PjDrCzJID5zc9p5WsOhEvRciYwRY1uxK0k9wmP0hsifFXhmcP6Ljoz5aI08hC2xGzb
 mDfKut6ZFFUlpws1Xfup2/3QoCeISGjG3v0AytFW/9ekYqatDB929S/UXhwQSqKftuXx
 SG662jDgZntTIcKw8jjW30msSHzhlyML44kZ5p8MmY2ZaPaPhg1AXk6nj6b0zNYyZraa
 wma/zgRvx/SYPdIAEqGwrFAzrsRk99/3wLEu09ZfDubChv3yxiMacsnFInV/3OzbZu5r
 zh98oVf+kaCnwH7dlbhyAvDEXeggyWOMYYFrJhLYsQmQZhneUzAk5tuneKhwTz3Ma7/0
 sIYQ==
X-Gm-Message-State: AOJu0YwajY+Rzvrhj4lpFjndaFWiv7CEkWtSb7VcD+QYJPwtjjVw48Ms
 QF6QTEFqtKhUZeYXoYiwSzF3bQV+PWZUTrl3jIjbChx+/L8HysYc0OaQsViF/y38YTI2myZcHcW
 6m8xkWA==
X-Google-Smtp-Source: AGHT+IFFsWB7ZicHUXOkWBByVQOlb+zv7h0sxpKHpUc7DrACrma/tZnH7n4Q5ZMjRlXMEYZ++ftcEA==
X-Received: by 2002:a05:6000:2c8:b0:367:9639:66d3 with SMTP id
 ffacd0b85a97d-368315f3344mr3042164f8f.5.1721291934679; 
 Thu, 18 Jul 2024 01:38:54 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36853e239cfsm954342f8f.56.2024.07.18.01.38.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jul 2024 01:38:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 01/18] hw/intc/loongson_ipi: Declare QOM types using
 DEFINE_TYPES() macro
Date: Thu, 18 Jul 2024 10:38:25 +0200
Message-ID: <20240718083842.81199-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240718083842.81199-1-philmd@linaro.org>
References: <20240718083842.81199-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

When multiple QOM types are registered in the same file,
it is simpler to use the the DEFINE_TYPES() macro. Replace
the type_init() / type_register_static() combination.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/loongson_ipi.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index e6a7142480..dc82caea0d 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -363,17 +363,14 @@ static void loongson_ipi_finalize(Object *obj)
     g_free(s->cpu);
 }
 
-static const TypeInfo loongson_ipi_info = {
-    .name          = TYPE_LOONGSON_IPI,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(LoongsonIPI),
-    .class_init    = loongson_ipi_class_init,
-    .instance_finalize = loongson_ipi_finalize,
+static const TypeInfo loongson_ipi_types[] = {
+    {
+        .name               = TYPE_LOONGSON_IPI,
+        .parent             = TYPE_SYS_BUS_DEVICE,
+        .instance_size      = sizeof(LoongsonIPI),
+        .class_init         = loongson_ipi_class_init,
+        .instance_finalize  = loongson_ipi_finalize,
+    }
 };
 
-static void loongson_ipi_register_types(void)
-{
-    type_register_static(&loongson_ipi_info);
-}
-
-type_init(loongson_ipi_register_types)
+DEFINE_TYPES(loongson_ipi_types)
-- 
2.41.0



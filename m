Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E25C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sURGR-0004H4-DZ; Thu, 18 Jul 2024 09:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sURGP-00043x-4Y
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:33:41 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sURGN-0008Ri-I1
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:33:40 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4266dc7591fso3013525e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721309618; x=1721914418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2yIpr4C+mT4v88F+YuUsCQY1rp+f7UCwPe0NjDD60Fo=;
 b=lsVpPCpE0G6vo21CjEe2QnYAsfme+cfPgeRlhJD9hrkWy8yc2SmOB3FGV61NGhGaDu
 ipYzgQLaNNzzgdFIhjr9FR4/eO26tXoCNSfKhIG9qxpTI++Aea4IORJm/XEwTm4ndsDJ
 LdYANqW3Lm0KabtWDI5u9UtZ0u20RBbb8wtlmVa6YRwyIiVRGY2X66FqfnC8AAdFsFtV
 Ye41noAew5uZnvfAYsLmWf458yIPFZE2D/es5WBU3J0n8mJ13vXFqJboe1xvYp8kkL2r
 fQTSKzUBzpNn3VmLE4xA0Pwr8+uxPavzMHDyR210qfKB7WCqnoRT4gOYRsQHr6hSbgGg
 hFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721309618; x=1721914418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2yIpr4C+mT4v88F+YuUsCQY1rp+f7UCwPe0NjDD60Fo=;
 b=h78JldRsjiF1tphOjeDsSpdW/Di8Zb9p8OIN5N7mSX+J+bFz8bN+u6C9fU/4OgNhPY
 utSBPiKXtN8Xjqei8KcqQk3PTrkNNsotcdiMUAkJN5LGaHB5csaSwgqrOXEMniAlyGAT
 NA+OfOa2amjcToMTxOUlBl3GF0KTx6Ao50RP0DGDiL4fHiIsdn8SHWAKUc+mYUNdbdis
 RM1IUhJcz8apUAzQ+Jh5MC0kWP1lZ256WaQnwJwCpI1OsLPxzUiGj0u0HPlLNMMp1ltu
 gtl+OIDYlngweKq1mjy29mUPnSkA0bOgBZg/5kac5UwEmPTlRSxH8y5ieWPdwDzFSGHA
 zb9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqdaMU1zG5wd4BDjKnX36spCI7pap942vQEt7T/2Q+2tpgDepjfgUoPzv0MjzufNLS1VFK+uZeVMocK4OBTxdkNO7itGM=
X-Gm-Message-State: AOJu0Yx+qUGyvtAkHZgm2cdD2Itjz1mzfLE15tKKiZrUFTTOZKtvBgpv
 ngqh0dXzUVSfBlGa5swx0QJdG3MZnPb4iR8Jtz6gfTrzlPpiyV4UtfczwrJVLcw=
X-Google-Smtp-Source: AGHT+IEIbLNoQSzIly1KDJNpqEkWu1c5hdzKO1eJLgw4S55yrxC5LB3sR2/5xgZpGy21y+ydrbVPTA==
X-Received: by 2002:a05:600c:46c3:b0:426:6edf:4f41 with SMTP id
 5b1f17b1804b1-427c2cadfa4mr36767015e9.8.1721309617907; 
 Thu, 18 Jul 2024 06:33:37 -0700 (PDT)
Received: from localhost.localdomain ([176.176.173.113])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a5c356sm14508605e9.18.2024.07.18.06.33.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jul 2024 06:33:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bibo Mao <maobibo@loongson.cn>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>
Subject: [PATCH v5 04/19] hw/intc/loongson_ipi: Extract
 loongson_ipi_common_finalize()
Date: Thu, 18 Jul 2024 15:32:56 +0200
Message-ID: <20240718133312.10324-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240718133312.10324-1-philmd@linaro.org>
References: <20240718133312.10324-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

From: Bibo Mao <maobibo@loongson.cn>

In preparation to extract common IPI code in few commits,
extract loongson_ipi_common_finalize().

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
[PMD: Extracted from bigger commit, added commit description]
Co-Developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Song Gao <gaosong@loongson.cn>
---
 hw/intc/loongson_ipi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index d870af39c1..960d1e604f 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -357,13 +357,18 @@ static void loongson_ipi_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_loongson_ipi;
 }
 
-static void loongson_ipi_finalize(Object *obj)
+static void loongson_ipi_common_finalize(Object *obj)
 {
     LoongsonIPIState *s = LOONGSON_IPI(obj);
 
     g_free(s->cpu);
 }
 
+static void loongson_ipi_finalize(Object *obj)
+{
+    loongson_ipi_common_finalize(obj);
+}
+
 static const TypeInfo loongson_ipi_types[] = {
     {
         .name               = TYPE_LOONGSON_IPI,
-- 
2.41.0



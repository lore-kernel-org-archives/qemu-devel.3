Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D5FC3DA5D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 21:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUCVC-0007zy-Jw; Wed, 17 Jul 2024 17:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUCV2-0007bE-6M
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:47:51 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUCV0-00023H-4t
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 17:47:47 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-368526b1333so2232f8f.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 14:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721252864; x=1721857664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DELvQvW4nff9OshEIpTndk1NZr7mJcffQsAB83fChY4=;
 b=n6Lls6fuB8KPIqCiUsEW9ULUeP3LCM9tIzHZ2inFNDRcBLfL2p/ok8GjQAKkhNaOU1
 +sMS6WSyf1YHt81kTju5ye79wnjWNKPb07s9Qd47mSFG17GgHZ/FnZEoj9Q7yEl9krUC
 NMVy8GhULQeLyux3iN3smduJWm6AkctOHw+6ZR/Rhv+Caw2+10q06y46E5Hg5rsvuBM3
 0BXaAbRmkP+hdJp+gxk2gEewKmHQHVV304wJ1VxvlpCr6eoS2xL7Y9FhXkewkZX2buY8
 UvCrZmGApfWasQwJ6DLxM3v0/Ep12RiN9LLjg1Cs/rg+wpTOj/+T3dpdEOu+BTDZnvV4
 o56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721252864; x=1721857664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DELvQvW4nff9OshEIpTndk1NZr7mJcffQsAB83fChY4=;
 b=WDibydj9EB23aDTbAlFqmxdDYipVExWcPV9tyJ2ysSaNVzQBw5qUguhGx1snljtHQB
 wxs5fNt8HLGmLU138dMxS18BMikT3E0zZXTnkb7o52TUpn+FzLHVavVpLcA4ftIb8TJU
 v/QH1SnP9rnA3f3Y+YqiPwW1A2jE0ONwkYJkAqG+rFEI/HfGDtHOiGPldkhSPI6OGF+B
 7b66Y/Cn4MXzABYmo4INV/Wj+//+/6uPioKO+8d9XsBlZf77NYsWhEIuzf+qRQRYls/h
 U7cFEqR9A1hgif++ehc8xEP+inxkIOufZIgg14h22OUebA+sCoIabPpPqbpZKaVQ+uLP
 teag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhfxMxyXEblaJEsA0wXe1wm+W8G7NNmgrKboGQTE8KNpNDWID4QST3JOSyuxiJGHKakI4tEgl6b5WnXuhBHg/8Buh88aY=
X-Gm-Message-State: AOJu0YwI+GvX8RyBX+EtiYyDWkheo0VWctZa6sa/5vv96gdCmod+u+Vz
 0irWZZY5I1M3eJttteenEP1YmVW4f/y9/yg7Qnmz/PmAAjh10xrrcBH8h2A5wy4=
X-Google-Smtp-Source: AGHT+IEkhtlZ9bDaCjxBlR0ud6sTwx/0vcnXQN0QjLNL83N4FpGJeWDORG47SAkbRvO5QeYdf0UxMw==
X-Received: by 2002:a05:6000:a:b0:368:377a:e8bb with SMTP id
 ffacd0b85a97d-3684b3fa48emr547879f8f.28.1721252864684; 
 Wed, 17 Jul 2024 14:47:44 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3684ef5b688sm87768f8f.1.2024.07.17.14.47.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jul 2024 14:47:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-devel@nongnu.org
Cc: Xianglai Li <lixianglai@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PATCH v3 03/17] hw/intc/loongson_ipi: Extract
 loongson_ipi_common_finalize()
Date: Wed, 17 Jul 2024 23:46:54 +0200
Message-ID: <20240717214708.78403-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240717214708.78403-1-philmd@linaro.org>
References: <20240717214708.78403-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/loongson_ipi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index a34e7e634f..3b3481c43e 100644
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
 static const TypeInfo loongson_ipi_info = {
     .name          = TYPE_LOONGSON_IPI,
     .parent        = TYPE_SYS_BUS_DEVICE,
-- 
2.41.0



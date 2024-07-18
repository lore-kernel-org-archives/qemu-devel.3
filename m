Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 467BCC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 08:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUMfb-0002yt-Qt; Thu, 18 Jul 2024 04:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMfZ-0002ka-CZ
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:39:21 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sUMfX-0004jC-Kr
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 04:39:21 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2ebe40673d8so7404411fa.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 01:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721291957; x=1721896757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gM364jAAbzhkuB964x9fsLUOlXwiGfCqOc37mduCfFY=;
 b=wEJ+ZlOawTQdG621TE20G3yBS6QhIr7u0gmNHUF2BgFb2/aPLAyOFqz83eogaENO3O
 fvzyBHymVyCVz5G/E+Xy24XjI4/q/cG2CE0j6bha57fRd4qEn2Pa39oro6CEaanYchXU
 f2fmXluRFiOdqEqzF4FkYGQM87fxXff3gYx5TBZB2L0rCNp2+UP3l8qH9Gqs+r9ap42m
 wm5RLNxBlWTH9r6Rh/1JVWmjKySM6UbuKqaNBItz1kpbK8oeMWxOciTaDsf/OpFLmU8A
 V7ma2CUAPoQMMMNrgiJkVp5L/8dGicxQpS5U2kGykkbXkZnIyNSPTyag1gAxOpHO+L0i
 GYtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721291957; x=1721896757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gM364jAAbzhkuB964x9fsLUOlXwiGfCqOc37mduCfFY=;
 b=NdEAUHV40lYNZnEMQMLjicrHicX+zsGjRWf34LhcAxba8w54XkG3x3LDHTYnJu8iAb
 O9Haj2V+reX3Y1peV5Z6elYhcEt4TVipNk0snjTfQnqPzXQ4m8Lb8j0Nt69bCF6PY63Y
 W8osPHgF8TVM5hItsDSYI+Pwcbo+gA+QVh8mxzxJ07KK16CnLf1UcT9S4fr2U5ElYuct
 JkrNE5wTAUDpSOO/BRz/W8kZ1VzGzITFswB72S8/2P01LlVT0A6Te7FiEG7OXnjKvLXQ
 YYSn1WCn5PqZZaUgvYL2SrP0sZjCXNRUBhayI0KSDfNBGLr/zPfKCtNcAen61FgcUCzL
 Xt5Q==
X-Gm-Message-State: AOJu0YzXpG/9z33meuoSrcJScaZMKS2EXNZo18cdHtyhpOnkhgD2rA+R
 MBP8DdZe7RyW8gJuozEafPxW4TcSOCtCIJMPfnjkmPQbvTlex0xUm+PMCv6uP2vsWmc2Or1CpKr
 iZWs=
X-Google-Smtp-Source: AGHT+IEjRSTM3RDzj62Mjs5/xKtpdFxbkWU+64tn9VJ8BhtHQuAkE3dG9Fz1u5T1JNjoE7W7EhF6Vg==
X-Received: by 2002:a2e:6e09:0:b0:2ee:7b7d:66ee with SMTP id
 38308e7fff4ca-2ef05d43d93mr11606211fa.41.1721291956778; 
 Thu, 18 Jul 2024 01:39:16 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3684e96033dsm1145887f8f.23.2024.07.18.01.39.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Jul 2024 01:39:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 04/18] hw/intc/loongson_ipi: Extract
 loongson_ipi_common_finalize()
Date: Thu, 18 Jul 2024 10:38:28 +0200
Message-ID: <20240718083842.81199-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240718083842.81199-1-philmd@linaro.org>
References: <20240718083842.81199-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
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



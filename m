Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD8EC54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 18:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk71C-0003T6-1q; Tue, 12 Mar 2024 14:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk70z-0003Mh-Ne
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:38:17 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk70x-0000cL-0j
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:38:17 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-41329b6286bso14727815e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 11:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710268693; x=1710873493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XxETGuhhBQo6mApLsduj7FC9ZSriYQJnVDPgySwv8KY=;
 b=FsPkBAIvLRzG7OfBAwYq7BywGOs4oQkJxpOec3xQdU+r7w9IW6pnoXrPZi8UfhD/kR
 rC9WBfyLpbebc8vANlQzDRJwV7DL7PGDqkiPNcsOCzJ9Kf9gevymKm3ZM7yrYKXW3h1e
 zfPY9RzR/j2P7YT/PMvkIyP+cXD5qtUUyNAGygsgYpgwhEXia0sVajy3/2mfDp+13H1E
 XJTNC4is7ehzUG7dLRw4RFVLmn+X7VRo23lPymojV8A0Sa1yAXPEKTqxQ8R7Mtgq34kt
 zwmEiiJZZQL9TV5Q1sUdPRz6PsGBPH82UW23W6lTUBOZ8MMv7YNl+UKqmK+/+l6hW7AJ
 YUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710268693; x=1710873493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XxETGuhhBQo6mApLsduj7FC9ZSriYQJnVDPgySwv8KY=;
 b=ljKhcpj6spaEvpiFP2Klq7QuaNYMF7J1iUscM/GdcVXjnsD5QswaLO28zs9/TlNxFE
 Sycf49h9Bu5E1hmfYGsmOchL1/yDBpzKKDjL4TzgDjjFjFEkvSx9eqqUYIKz7+aD3BYP
 +RRuZxDqZi7zK2FuHsx85DOUKv9G76wtZdq9HIYX2g/uycjT/b3jzhGcACwF3YWQjeCF
 0lQIu2ZRhGe9GOs8Qa0GwJtpfBgtL79hDYXEjHr+5/o8/4o8IQwPUUjHwYXqNUzPFi35
 lAHXUHDvYv8M4uyvoznAE0h5yjZ5TXhc2x/tin/0jlF8I2T2sgTKiud2UiQvv52nNf9y
 +5ew==
X-Gm-Message-State: AOJu0YyITBebTpbrR6rJA6sEI9CU77Qsz98PEw6uaF1PNXI7D74QGq/X
 8wkqMocX6UPxg1cHktKu5WabzFgOeueipRB3LMv+SARtQlHvKJLdMeIEFCVrVlCyQy/gJAHbsiI
 D
X-Google-Smtp-Source: AGHT+IFpuQyr3sxFxbTV1CiCvOn2uKA/ORryDX/H7nR2om000hMsYM5fQNRFGzs0NkVfQe50tLBt6A==
X-Received: by 2002:a05:600c:4708:b0:413:2958:e323 with SMTP id
 v8-20020a05600c470800b004132958e323mr798783wmo.10.1710268693246; 
 Tue, 12 Mar 2024 11:38:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v17-20020a05600c471100b00412ee8e2f2asm19836337wmo.9.2024.03.12.11.38.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 11:38:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/7] hw/misc/pca9554: Correct error check bounds in get/set
 pin functions
Date: Tue, 12 Mar 2024 18:38:07 +0000
Message-Id: <20240312183810.557768-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312183810.557768-1-peter.maydell@linaro.org>
References: <20240312183810.557768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In pca9554_get_pin() and pca9554_set_pin(), we try to detect an
incorrect pin value, but we get the condition wrong, using ">"
when ">=" was intended.

This has no actual effect, because in pca9554_initfn() we
use the correct test when creating the properties and so
we'll never be called with an out of range value. However,
Coverity complains about the mismatch between the check and
the later use of the pin value in a shift operation.

Use the correct condition.

Resolves: Coverity CID 1534917
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/pca9554.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/misc/pca9554.c b/hw/misc/pca9554.c
index 778b32e4430..5e31696797d 100644
--- a/hw/misc/pca9554.c
+++ b/hw/misc/pca9554.c
@@ -160,7 +160,7 @@ static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
         error_setg(errp, "%s: error reading %s", __func__, name);
         return;
     }
-    if (pin < 0 || pin > PCA9554_PIN_COUNT) {
+    if (pin < 0 || pin >= PCA9554_PIN_COUNT) {
         error_setg(errp, "%s invalid pin %s", __func__, name);
         return;
     }
@@ -187,7 +187,7 @@ static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
         error_setg(errp, "%s: error reading %s", __func__, name);
         return;
     }
-    if (pin < 0 || pin > PCA9554_PIN_COUNT) {
+    if (pin < 0 || pin >= PCA9554_PIN_COUNT) {
         error_setg(errp, "%s invalid pin %s", __func__, name);
         return;
     }
-- 
2.34.1



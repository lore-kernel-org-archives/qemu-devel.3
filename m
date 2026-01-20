Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B08CD2628A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 18:43:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viGh6-0001Bg-Am; Tue, 20 Jan 2026 13:43:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGgI-0007mh-U1
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:42:25 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGgE-0006ga-It
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:42:21 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47ee974e230so45731325e9.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768934536; x=1769539336; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vWVxlgIOIG3Jwz+arTzaCTiEQKHvN9ANQV0FaiHKLv4=;
 b=H9pbWtA4EfNcwVgTrgrYmkn0//bLBQsVFkAHfjWtr6AcYKvLE83ToitwlqDeB5fBWi
 ifzMrr+XrgM25+nzYi+h2/+3kOEFxMQnHF5PN6KMTKrMOWbePEKV8IeViBOdR6C+zlN9
 zf7raVQvhPT56Eyjxn8wd3PqooddqR388UCaX424g0x+H+1G5DrkfmbJoJ/kY8z+lvhN
 dPiJ/sWiMPIquyYnuXdG6J4lJivjSAQpLxGEP0qcSuDnL5VVS9rWEpbsPqAO49nWQrLB
 aqpw+mKKL13YqizgOLYMFNZRvGX8A+uUzOj9FtxWq6ZPT+SPS2vjwvPf5PclgMZgezWn
 Wv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768934536; x=1769539336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vWVxlgIOIG3Jwz+arTzaCTiEQKHvN9ANQV0FaiHKLv4=;
 b=buWptM98rUcouOrIRsQScBjF8z8o11waSuXYqyl+2WJ7VoZmybJ4lE/4G7Tl3zhCI5
 v5cVqNuaEVC2tD4OuczDv1UyQKzl8WZRZ+qrbu+TRcrYRJT1RwLfzKByQEKTPWAPgSZu
 CIrK/8+GCobicuY+rhPitrjEil1+MGhJWCj7NklTewa+OAcjlK1SCLkp0q6Ldk1j8G8G
 ifJ+W2FNGF950gKZHDxE9Nr8aekED+7W8e4GbomN/R6ldBXOMnm2ol3XBLSnPVYYNq+f
 6I8qMQLGhkY+CY8ffbMzQimoQd3AK95sCVoVG8wd/kJ7b4FbRh8SPvg5Z8aoQLPmdsw0
 Xt7g==
X-Gm-Message-State: AOJu0Yxa6fvaN4bbOln4SwHuvrQOzPMFXGkSiilblPQEU/7O/51nJ4iu
 4ly0i8xb2PoiUYEa5OSlvSHqRON3vJLPjGs5key9UItHCJgbgxSrCCuF0xu0al06Hto07UzzKBz
 0Q7z3BmI=
X-Gm-Gg: AY/fxX4d20lTKAPZROPFWiR7rLRQnP9Vo8GIDvLZsBmmkHgSnl7gNumku5vcDCGIA4+
 GKjLtcJbT5h73EH94rTalUWzVrJ7/Lyckclgzx8yWuyE5Fe1JEcLXOkxHyvF6RDAYChfWTvJfaE
 LD/+Uv44Bu5985QJqsmvNqNYJXOZDv+XMWjqopLAlYYlbc7YCR9SA+/3HGI9FEU/B3kIkCAg8wZ
 yQn73PbRuTPvyHgMDEUKLgjrd0rCnRCfySZjFvlFC/Xf2UUKr+GSvr8FZjzJYqq1aQCqPB/PIGy
 9pxbtER1Y3T0HYEck9gdJnff4cU9isJJi5nR+W+wKB6yT5N8Yke5vYuCJBh4Gl1X5JpYoIboDHL
 gLUl99V/ejEPXTSvTJ+G0coFguusC2X6+0q+7W3NqTx8i0A+THpg4bk1TFSqp8G9N8Di6TjSxwA
 Yyac4s90AF226JYP+OFpF32v56B6dCTg/EzmoBBYGztetyl41AklijYh2f4jiw
X-Received: by 2002:a05:600c:4fcb:b0:470:fe3c:a3b7 with SMTP id
 5b1f17b1804b1-4803e79b805mr40526545e9.5.1768934536214; 
 Tue, 20 Jan 2026 10:42:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e86c197sm262675095e9.1.2026.01.20.10.42.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jan 2026 10:42:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/29] hw/virtio-nsm: include qemu/osdep.h
Date: Tue, 20 Jan 2026 19:39:01 +0100
Message-ID: <20260120183902.73845-29-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120183902.73845-1-philmd@linaro.org>
References: <20260120183902.73845-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Paolo Bonzini <pbonzini@redhat.com>

The file hw/virtio/cbor-helpers.c does not include our standard
qemu/osdep.h header, add it.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Message-ID: <20260119120402.284985-1-pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/cbor-helpers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/cbor-helpers.c b/hw/virtio/cbor-helpers.c
index 49f55df3994..010454d5383 100644
--- a/hw/virtio/cbor-helpers.c
+++ b/hw/virtio/cbor-helpers.c
@@ -8,6 +8,7 @@
  * top-level directory.
  */
 
+#include "qemu/osdep.h"
 #include "hw/virtio/cbor-helpers.h"
 
 bool qemu_cbor_map_add(cbor_item_t *map, cbor_item_t *key, cbor_item_t *value)
-- 
2.52.0



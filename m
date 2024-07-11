Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21CB6C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 13:22:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRthE-0001b8-Py; Thu, 11 Jul 2024 09:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRth6-00016Q-Mg
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:46 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sRtgq-000633-Ps
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:18:37 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4279c10a40eso2463105e9.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 06:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720703907; x=1721308707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=giPm/dMSXvq6JjcrNvdfTM1SLCmpbtjRtDEuNqjPwVE=;
 b=lj/4hA5W66F08ypqrzRELiz/JpkoqHHGSFt9LCkGnvXtFawBNBOvZoTDrWPJHKgPCu
 hUcVv0oynKtqgZQowyq+zN9silYDmEHiFbPc7oBFHdiNPAP4UmkcBJfTjsREzDOYwJBK
 bWSLB3ku7Yb9pLW20oOFZOGDsrMt/GzTZ4dnRqZyqUjiE+nSJHzg+xy7//vXfwXqFuPN
 OvHhxZSsHniIowXCn1OlggkPFQxr0Gf+9jgzDxrWIl5hU/k0c/vED43PtZnLJ3/LKXTp
 cE/81XO5kz34m7A6vF33RkbgUYY2GFaTwODosv2wkzfFl8tuOARK+psd7ckfi0/QGpsk
 Gstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720703907; x=1721308707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=giPm/dMSXvq6JjcrNvdfTM1SLCmpbtjRtDEuNqjPwVE=;
 b=JtRZtz8Csmv79JFDsHW0/uHR/UlXvgEJv+JU6PkvaIoFftiYtsL267y0J1797WncOB
 EOowN48jAiOUM99YlQwEsIf96xX3TNnGA/CLZhsLV9y08aMV756x58XCmZUwCvUfdPMX
 6gY2CMG+v/c+8FpJObfbUqy+XSin0gUBgJQnHNM79N+2GOsvj7WtXzZJx294t+b6uaDf
 XKdf6Ld4HSezoqj7hWtC3kv7p58qH31OZp9mLRCC0WPA6RJ0IYBe9SMmVbVUr/E4/Twy
 svzM93w9E7YmC/7G4/lyCUpiqOpishqNDaBV5o7CAFs+fx0L11/kYaVLklwhDMBsPfl4
 SZCQ==
X-Gm-Message-State: AOJu0YyhTe+JhvxOhH+tPa3xolkYDugHs+Mmmol49qKzmBXGXAoL1G/7
 qgfuE7Y+PLvaSXNKSuvjjLanBpca1Dz3NVaAZA/+XE5vJqTL1FpZN/ziqHKexM1yWjg700cjXgE
 NhBU=
X-Google-Smtp-Source: AGHT+IHpSmjM02wvV73kvpCIWZrkDjT87MPCIraPNwRhjkS8qeX1eM68ZeDLWnDBsHN2X5ixHvzm2w==
X-Received: by 2002:a05:600c:3b12:b0:426:66fb:fcd6 with SMTP id
 5b1f17b1804b1-426706c64b5mr47100985e9.3.1720703907190; 
 Thu, 11 Jul 2024 06:18:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f736939sm119412025e9.37.2024.07.11.06.18.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 06:18:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/24] target/arm: Implement store_cpu_field_low32() macro
Date: Thu, 11 Jul 2024 14:18:03 +0100
Message-Id: <20240711131822.3909903-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711131822.3909903-1-peter.maydell@linaro.org>
References: <20240711131822.3909903-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

We already have a load_cpu_field_low32() to load the low half of a
64-bit CPU struct field to a TCGv_i32; however we haven't yet needed
the store equivalent.  We'll want that in the next patch, so
implement it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240628142347.1283015-6-peter.maydell@linaro.org
---
 target/arm/tcg/translate-a32.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/arm/tcg/translate-a32.h b/target/arm/tcg/translate-a32.h
index 19de6e0a1a9..0b1fa57965c 100644
--- a/target/arm/tcg/translate-a32.h
+++ b/target/arm/tcg/translate-a32.h
@@ -83,6 +83,13 @@ void store_cpu_offset(TCGv_i32 var, int offset, int size);
                          sizeof_field(CPUARMState, name));              \
     })
 
+/* Store to the low half of a 64-bit field from a TCGv_i32 */
+#define store_cpu_field_low32(val, name)                                \
+    ({                                                                  \
+        QEMU_BUILD_BUG_ON(sizeof_field(CPUARMState, name) != 8);        \
+        store_cpu_offset(val, offsetoflow32(CPUARMState, name), 4);     \
+    })
+
 #define store_cpu_field_constant(val, name) \
     store_cpu_field(tcg_constant_i32(val), name)
 
-- 
2.34.1



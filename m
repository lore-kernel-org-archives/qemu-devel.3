Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D26C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73kE-0003Db-WE; Thu, 17 Sep 2026 00:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73jc-00039M-De
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:28:34 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73ja-0006lN-AV
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:28:32 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d8fb334ddcso3655715ad.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619309; x=1790224109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+yjjV+A7iYyzKjGgR+UNc4f/t+ifl8d6M9mByR9w2bU=;
 b=kynXoVqYkQm7DTte8ClDDM5swOafsu1latOxP78KbYB0Bu34iEGJUXV0Mr8z4wxTbt
 zDMhDxG4oSm8ebncFE0N6z+HUXkQLxmObSmJjTqfyzYxF9gFJJ9L2NScAPCm8Bfkd/pM
 7Faj0SBT6z/ufezTkslwk0n7gtOsxHPVqj+ZP2jY9doVugbyDy1hmcV51sm4PIi+Nrsz
 Kkpw/tT8AFTlEdBsnsTVP3uzXbbQ7OxAqCrSKeXigg8JujSlMiBiD3KW+tX2A8RirPJV
 8o1sN2LbfSVYDeSUC/ljWR3MieCKUaUP3N1j7+bKKxYUajfSUYxiXLfSF4ibS3xN4kAy
 WxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619309; x=1790224109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+yjjV+A7iYyzKjGgR+UNc4f/t+ifl8d6M9mByR9w2bU=;
 b=wUN64RBJADnwOxsN9DW699EMEu6mrx2EPEaJErVxdVCuS8rBoYragcLfug+8LU59HP
 /ldFmBJG0RW8j41v0PSBIMPPAP57fb4eDboxcnhnJLVM+5afMFCsnJBtOQy+KbsRRI0p
 UnHLZ7w6g9iGkLrpCzjStZzKQ+Y/aWzNLUTXsJGF/+J2aMeHFNpvuQym4shLBy82kLjv
 nKP+yI7/Mv6DXwTjcrmD+3b2Lp8cUWYO/hWMTLzKF/Edpy1mDjwyyqVN5ZKn25AFJW0s
 79wnAKLWj6dVJbzSN11c+3nJRijYwAx9mB6D/K0O38f3bc4cKekedP41anRqncueeAUu
 HRTw==
X-Gm-Message-State: AFuF++kHGKVlDbPv8ZGmiHMS4t2zXczAxJAC+6Lch7g3+0JM6v/VZGvx
 vLe9SsHT6Pbdh/TXhKwlvWwl8ENrVhF5p9jlPjDyLS/qux6zy4hiYl0rHZMLUK/26UMFsD68cSZ
 miMVD
X-Gm-Gg: AYBFou3YoFpMD5AZbVdolbrMSM3pRguPMpdO4rzHz1I4P+lw+Wxoj2IMjO6Iu1PgnXj
 6RmmUckkMuaPxU0zKN8GrXYuGTRqUtj3jvfYfmLQXB8nKflvNweo3KKwAKLkOcAazgIDQoM1MGI
 /L+X8MQckUBlVTpxSc0MFxyzdbQKsAS99KyGaW5928UsmMp2bXuxO0bPnM5e4u6rzVWPeLAGtrq
 Q90EOU0C46yZjIX+nDPe2QuEclWeo525k+0cz1NwMt7teahYm0lawC0J1jdidpdT3xqqzrG5dTM
 8RZ7XnK+QYA3edEtzHmFlhtg4pusjQjyOyjYdAQdW0NMQsFbAuUyKEXX8tLk3ZWIANTz25uZzvA
 /mQpWzvILd5snHzDN5KG0aMOWEjw1faPCLHDOeFJA1CR/EpHP6e3d9zCjGchSB2XxqbOOyNcl41
 tfeHLlO4x/qkvwg4EjqooYF6bcbwR0eSbQvQF0S7Rv7WXfe6u9plF9Eum74OPiXZ/nJgyFDG37t
 5U2qyI=
X-Received: by 2002:a17:90b:5386:b0:39b:3510:49e7 with SMTP id
 98e67ed59e1d1-39e1df52290mr13327070a91.0.1789619308694; 
 Wed, 16 Sep 2026 21:28:28 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.28.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:28:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 002/101] include/qemu/compiler: Define QEMU_ALIAS
Date: Wed, 16 Sep 2026 18:26:44 -1000
Message-ID: <20260917042823.542588-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/compiler.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
index 3661dc5fbaa..8fa4552ef8f 100644
--- a/include/qemu/compiler.h
+++ b/include/qemu/compiler.h
@@ -230,6 +230,13 @@
 # define QEMU_UNINITIALIZED
 #endif
 
+/*
+ * Alias the current function definition to another.
+ */
+
+#define QEMU_ALIAS(N) \
+    __attribute__((alias(stringify(glue(__USER_LABEL_PREFIX__, N)))))
+
 /*
  * http://clang.llvm.org/docs/ThreadSafetyAnalysis.html
  *
-- 
2.53.0



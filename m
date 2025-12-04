Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675C9D29FBE
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 19:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRFKH-00070l-GM; Thu, 04 Dec 2025 14:49:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRFKE-0006z0-25
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 14:49:14 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRFKC-0007Ms-Ea
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 14:49:13 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42e2d52c24dso764215f8f.1
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 11:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764877751; x=1765482551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E+iwo/nPHTmxK9I3PRQoHiQNNiLgoGcuCC7oYGWSe3A=;
 b=n3kXcV/KXUp5NTFZ3aT1pOFpH1EjRuYiWeJeM6UWw2ZBse3HhuqY8XIWvEF9p6/io6
 /wZx144C6xDG1NtNz2wibI/v0TREaC8H9c2SqDEGPMIQLv9A01dvxwR7UW/jMQnAXfDt
 pzmtqN920SG1E2rMQTOEURL/6pMCs0MSqlqW9Ote7dk8EXb2zHCtXkcRgJLxshRewTiS
 jZeKBkdzrPyM9Bzy5jkNanBkQ/7wDxErtGFzmJitWCSeY8q7M5aQQJHzLEAUfiV8QzGO
 tM/OUr1ynxA/V/GX+JAtjskYFa8q//axIzkDpCoJ8Agww+DjpIcceIk4LIjP08cII/VN
 1aPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764877751; x=1765482551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E+iwo/nPHTmxK9I3PRQoHiQNNiLgoGcuCC7oYGWSe3A=;
 b=XVVLZzHKs113qJVraRuzP4bmojL9NcDwjmZjc2xw1wWVXDBYKQRJfJQQLlUTgrTLQX
 87bSccPMRYOXKIHMPfLuOUqANMCZztvPRhmQ2Aje9/xC7kDvqEHODauGT6s9Okql/5Qj
 kKBTeGN7hnMrIoxZKCZ5oEwJPoMGR8kOFttYtuBqYFX6rDEHQGtrEGYY7BWVASA6VMLB
 Bp13Ls7PWQvIWvsaoudvytQwG5XSXmGQS15YvuyzREB3U/Y4aRL4J//XpU6MBHt22m94
 apm37V4RaXm1vJHSdZ+WbBQBg6eYWz6yFWtCN6dTxDF6ZEIuHffBK9rxTP43B/9SzsLe
 Am/w==
X-Gm-Message-State: AOJu0YzSKUE3Q5TGT5erBO+3dxi6sSEvovv9B4kmUGGeUHSuo3qBh5lE
 AaVblN9m97TViYEyqdR7E+7h9G882neHSn1FQ/1M7yL6YKeP6DcFZr20lBYc8BO++As=
X-Gm-Gg: ASbGncvMpQeVhPsUbGNWxTYQjSYAYAiTogrhaVHvBXrS1zWlun98nyMzL3EU2NUkywN
 Qj4jAxSIuiaUd6p/dQDkmBgp/V2JPl1hl+BtYHDUyuW6spmdv4DOVphWRfqwgk1upkY25NGj87q
 eSrL4Cru6WA9+Ls55rD/sq2KDRZy9sLo4xlooiGVkdDvk9pYjAjMHupaXptQXGJ0NxCqCIcmdqu
 1CKJ1W51ktj5HYSssupwhokCfY/WxJx3hQmQ/dxi3tMAZD3c9SFH385wHvgFXvvqBhGDq0z5Els
 DxcUA98masInE1h7H0fYUHz9NeCkSMKxwwyWlKz1+HHoDb1OQd9BTDkyi+4nLJWT+VrsO8dC3oD
 nO9v9LDqXTwhJrwe88B5I0bAadvcO0MZF46innGTsNhC1YFRrZJb3xPlk3bYeqXN+4GhgfAw9Sq
 OQ+HJpzHYFvs8=
X-Google-Smtp-Source: AGHT+IHVEsnFebcomrBcn32mewOOY1uDa56vKZm4GW63UMQiIXO3IYe/rKvpOgX+y5UhfBHbrp05Ug==
X-Received: by 2002:a05:6000:288d:b0:429:ed90:91dd with SMTP id
 ffacd0b85a97d-42f7318fba9mr7610577f8f.6.1764877750688; 
 Thu, 04 Dec 2025 11:49:10 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d222478sm4796121f8f.20.2025.12.04.11.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 11:49:06 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7ECA95F90A;
 Thu, 04 Dec 2025 19:49:03 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alano Song <AlanoSong@163.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: [PATCH v2 09/11] docs/devel: Correct typo
Date: Thu,  4 Dec 2025 19:49:00 +0000
Message-ID: <20251204194902.1340008-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251204194902.1340008-1-alex.bennee@linaro.org>
References: <20251204194902.1340008-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

From: Alano Song <AlanoSong@163.com>

Correct typo in atomics.rst

Signed-off-by: Alano Song <AlanoSong@163.com>
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
[AJB: fixed author entry]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/atomics.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/atomics.rst b/docs/devel/atomics.rst
index 95c7b77c01e..ea4ede4b8c4 100644
--- a/docs/devel/atomics.rst
+++ b/docs/devel/atomics.rst
@@ -266,7 +266,7 @@ Splitting a loop can also be useful to reduce the number of barriers:
     |   n = 0;                                 |     smp_mb_release();            |
     |   for (i = 0; i < 10; i++) {             |     for (i = 0; i < 10; i++)     |
     |     qatomic_store_release(&a[i], false); |       qatomic_set(&a[i], false); |
-    |     smp_mb();                            |     smb_mb();                    |
+    |     smp_mb();                            |     smp_mb();                    |
     |     n += qatomic_read(&b[i]);            |     n = 0;                       |
     |   }                                      |     for (i = 0; i < 10; i++)     |
     |                                          |       n += qatomic_read(&b[i]);  |
@@ -283,7 +283,7 @@ as well) ``smp_wmb()``:
     |                                          |     smp_mb_release();            |
     |   for (i = 0; i < 10; i++) {             |     for (i = 0; i < 10; i++)     |
     |     qatomic_store_release(&a[i], false); |       qatomic_set(&a[i], false); |
-    |     qatomic_store_release(&b[i], false); |     smb_wmb();                   |
+    |     qatomic_store_release(&b[i], false); |     smp_wmb();                   |
     |   }                                      |     for (i = 0; i < 10; i++)     |
     |                                          |       qatomic_set(&b[i], false); |
     +------------------------------------------+----------------------------------+
-- 
2.47.3



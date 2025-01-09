Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FDE8E77199
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVwCv-0002s7-QC; Thu, 09 Jan 2025 12:20:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVwCu-0002mI-2K
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:20:32 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVwCs-0000sH-E4
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:20:31 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-385e3621518so683526f8f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736443228; x=1737048028; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SAkpQ1iPeEc9FavMfrE5ZMAHDuM/hnnhJGDNmUL3hkk=;
 b=DPm4mPvaWVWDkwyQq4930Pw9asVYNlEi4obki63Z9hxpbnmfqvBgzfITufqDG2JUBP
 U6b6kaEiB1xrWqMTItg7kxEpAwvAC17H//yvOu7nt/lQmXrYBGKPtagLVexeiGoG1UaM
 LmsWNsTJpJvjc7vBvMzFmLlerFBIuIN0PlMD7zp7k/YEOXKynhM+J+UKkagHlwL/S2Or
 f+L+p2vAzbdn8GPmqorrM5pkVJ0JDtlNqF5kGKH3P73UUOgY25jbXs7AcOHI9JpJtBV9
 qcW86ve5Nr/yL/zQpc+kvfp+VBL95IooDDtpHNQDnbdV07aajr4VV7bcv05MrR385zY5
 leog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736443228; x=1737048028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SAkpQ1iPeEc9FavMfrE5ZMAHDuM/hnnhJGDNmUL3hkk=;
 b=e4Fi17x6X2ZybgK51ol//R9hxoR8cWohjMTYgHy9da2fstL07esxLMEo9RTd3rm8Hi
 w/5DQQW8m0ss2yKJg5gj6yDXlyGr7/NHoBnGnr0L1y9XCHEsQT3oNxZgMj06lXCoTt/0
 W43JlruRA1OUrGwmd3OyYbw0LwGaGGuvPvTSS6muV4E4WxJqhYh0CEL8uIm1A+smoJUv
 EbXD2ToNp56TKtpG/ndTGjrHNHhZIRdwhgcEi36sJLp+XIx7DI+pz2iVN9DHMrJfUdCP
 PQ6AdHmSTeNiIFWwpvz+XuZ1SHfVi3yhcJ/oDR04reFtmaIp6zxa5wcdbjrHFPRlnKcc
 A+9w==
X-Gm-Message-State: AOJu0Yxi+erCgTLpGHvBWfGyzHCiGn0FJ8z07Ws/pcc8hUF9KGvv6ygy
 j1jJ/aNwgcfFP1g0k9sgK9mnrDFKBzmVeHCesLKZ+qeW5VT2QOD9xrTIu9it+log7JiIMQTR1u5
 g5YM=
X-Gm-Gg: ASbGncu+vpoefmJWJOK5n9ybNi7iKoxdHSHs5Hfs8zXmJAv82uy2VzfueluIxay51M/
 t8A8UYztk4oAYA4OR7EokkLmvUHmrnx3wGbvJA+hnOhdj85UhvavL5uLZ0wy39wyQnp9o8TnhBl
 NtCPNdyO/CCQOQ76gWZX4lzSoyYONzm7ClNFnz3t6pgNI9K7wmshT+rNDLSUCQnyjAfdo8ggv9t
 0DCmILr6YEQHvcQTvaFBy/iTIpixmwwIovCW9s/kUTKm0ACM5wfFlQ81SqaBHWt1n8vToOFps0F
 cwwNhXNNtQYofvxdAztFNmzgAMctoGKtbq++
X-Google-Smtp-Source: AGHT+IGSuJk4lWB6tPRViHuFddmQsMG/6P2N4ccDhknJxFNY9hsZP3XnLPI1XgMQ8M82WoicmJ0TQw==
X-Received: by 2002:a05:6000:1446:b0:385:fc97:9c76 with SMTP id
 ffacd0b85a97d-38a872f7fd9mr7017156f8f.3.1736443227979; 
 Thu, 09 Jan 2025 09:20:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38c596sm2348386f8f.51.2025.01.09.09.20.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Jan 2025 09:20:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 07/11] qom: Add object_get_container()
Date: Thu,  9 Jan 2025 18:19:44 +0100
Message-ID: <20250109171948.31092-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109171948.31092-1-philmd@linaro.org>
References: <20250109171948.31092-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Peter Xu <peterx@redhat.com>

Add a helper to fetch a root container (under object_get_root()).  Sanity
check on the type of the object.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-ID: <20241121192202.4155849-12-peterx@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qom/object.h | 10 ++++++++++
 qom/object.c         | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 95d6e064d9b..bcf9910b42c 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1510,6 +1510,16 @@ const char *object_property_get_type(Object *obj, const char *name,
  */
 Object *object_get_root(void);
 
+/**
+ * object_get_container:
+ * @name: the name of container to lookup
+ *
+ * Lookup a root level container.
+ *
+ * Returns: the container with @name.
+ */
+Object *object_get_container(const char *name);
+
 
 /**
  * object_get_objects_root:
diff --git a/qom/object.c b/qom/object.c
index b4c52d055d9..81c06906d30 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1751,6 +1751,16 @@ static Object *object_root_initialize(void)
     return root;
 }
 
+Object *object_get_container(const char *name)
+{
+    Object *container;
+
+    container = object_resolve_path_component(object_get_root(), name);
+    assert(object_dynamic_cast(container, TYPE_CONTAINER));
+
+    return container;
+}
+
 Object *object_get_root(void)
 {
     static Object *root;
-- 
2.47.1



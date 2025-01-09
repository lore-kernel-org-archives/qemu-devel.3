Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90664E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVwDK-0004w6-A2; Thu, 09 Jan 2025 12:20:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVwDI-0004ja-D8
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:20:56 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVwDG-0000xI-Tf
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:20:56 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385e3621518so683872f8f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736443252; x=1737048052; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zevfD/0XJNMcMENJjO9t+oO6TupDgy91bB9ym/P30U4=;
 b=ZTf98iy477k8jzEFvBXLN3MV+UnBq2QenqI/CCgHgjB9oet/iT9Y0kh84dGSg7ttK6
 KNVh+JOm/D1SH2dETglvET+JNWwKIqj0Rh8G+zMSfTF5FqF+oO1aQoon2p99tuJtM8rj
 bSlcA5ixU4/LkYehxQdS7HVxJ1XfBpw+QraQHKtWV2FCQiAB04GGPmNLqjb7kWDDhEyY
 Cj4okrCBuWNLq9ycNPJKW2ZeOKnAT0NsQWwF2TKC6EEz5xnZpyZSozjMy+2IyH+MM5zg
 Bj5HV/qfUrz4M/Woav/UE/npGUd4FeQEGmbzzjkF8YAX5ZxV9RrWhKMdp4B7Y1zfblY9
 iTlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736443252; x=1737048052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zevfD/0XJNMcMENJjO9t+oO6TupDgy91bB9ym/P30U4=;
 b=VviUvd3cAb19KIohllYPw6w+e8LboCuXxe7Ur4Zw5QKiJSwa0Yl9XefIQn1c6cGVB/
 JvPrzKPxQcK7nt2/jWvsvX8FNPj3/6JbINY2BYF856NCmyUdzpcaPG+36lvZ8wzgjC6/
 Xpki23B4nkXbZz0AM0Dcq9AYvG87THwwmEKpDf8/nXvQ1iXTNAFCSMh9HvmLmEZPDXeE
 5ETbKpGwhn0R+bO7aaz7IADvMBiN6LLPpuvjdk5KODdSmoxO/X362p3y48CJ38y0D7P0
 Ti6vRhFwaUlUhs3zyvIhZ++SG4NJIdnUYZhWzO7XvClLuaQsFW0dImd+NGypkFB087xJ
 eqDg==
X-Gm-Message-State: AOJu0Yxd9RwgMX5GFVfMyhP91pQWIaRpUUeCX4c2NjDlH6nXchns0Sms
 3l9Cmo9tYddB8c8CTZARlJtTUDLLS3H64P5X621FKEWCqjkY2OT8tF4QFZbtmZsSqLs719fEwiu
 I83E=
X-Gm-Gg: ASbGncs5c/1VzULRXC2PlR+Y820FihuYDR8uVKvSDvHGD3uXf/hKz83p+m+8Ng8Bsa0
 B1wx5lSmvfvEIpUaBssgHjilYuGA+PZ95VAVqvVCLAeIdrGKLggLyGOJcPlGFNuofSH8Q7C8BVa
 9zBknwQBW2D2SVj0ii0ovo4tl3Qg0a0JHA11vuF1Bzz4J2TnW/E/qLH40VmsW4M4ijH51PVB0tz
 H8NUTC9iTyWvotvuOHzEI4twqCcArSEjfPhB4pYSHK+ViYIx3Jp+v0apd77/HE5ypryUqYOjWGq
 AprjPav0Fzq6A4oK7qzU65DuRVy44TuF1l5M
X-Google-Smtp-Source: AGHT+IGOwgjY57/fBV6z4udumMChiJWSjeOvUVwTxZtl6edZ9ywQ1NPOzWvNDxvzb9O0XOV1ag4eNg==
X-Received: by 2002:adf:a2c4:0:b0:385:faec:d94d with SMTP id
 ffacd0b85a97d-38a87355754mr6052475f8f.51.1736443252512; 
 Thu, 09 Jan 2025 09:20:52 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1ce5sm2357948f8f.94.2025.01.09.09.20.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Jan 2025 09:20:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 11/11] system: Inline machine_containers[] in
 qemu_create_machine_containers()
Date: Thu,  9 Jan 2025 18:19:48 +0100
Message-ID: <20250109171948.31092-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109171948.31092-1-philmd@linaro.org>
References: <20250109171948.31092-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Only qemu_create_machine_containers() uses the
machine_containers[] array, restrict the scope
to this single user.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250102211800.79235-9-philmd@linaro.org>
---
 system/vl.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index ed1623b26b9..be029c52ef8 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2113,18 +2113,16 @@ static void parse_memory_options(void)
     loc_pop(&loc);
 }
 
-static const char *const machine_containers[] = {
-    "unattached",
-    "peripheral",
-    "peripheral-anon"
-};
-
 static void qemu_create_machine_containers(Object *machine)
 {
-    int i;
+    static const char *const containers[] = {
+        "unattached",
+        "peripheral",
+        "peripheral-anon",
+    };
 
-    for (i = 0; i < ARRAY_SIZE(machine_containers); i++) {
-        object_property_add_new_container(machine, machine_containers[i]);
+    for (unsigned i = 0; i < ARRAY_SIZE(containers); i++) {
+        object_property_add_new_container(machine, containers[i]);
     }
 }
 
-- 
2.47.1



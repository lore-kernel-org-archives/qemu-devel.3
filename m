Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD126CF649D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 08:07:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svBQs-0002Gt-Qf; Mon, 30 Sep 2024 04:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svBQq-00022k-T9
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 04:07:01 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svBQp-0004Zw-0r
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 04:07:00 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a8a7cdfdd80so675769966b.0
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 01:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727683616; x=1728288416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PDKmxhtETyeu/iYuY2neXJ4cpuVufAHpcFENKpKvuEg=;
 b=xVF6KTM+0CFj485bBWdgFq0qOxYKOhacrjn1HJ2nJ1V/pVC4H8398JBBgo0SRDGs6S
 vYw5ByKwjXvhdQOdFYlEQmritoE35GTfaHbBi4AIF8XCjn4sB6mjRHvuCNFDdhG/EZJz
 bLHOykP+sbslfqLzENUZQtkyz61obuKx03/M7eI/xAIq0QPsWrox7wWOplULL2qHceZh
 spFMGitNckIBz9EJUT5nTMHMYLyuJ9FQshMFlGtwaDAs3zriC1R++GTqHSJ5/1iNmCzT
 J2dSJlhhA+STFeoELbwdbz48h9DFt4HFolZ5BH0T6tj3k7a261jOpD3RvS+qPZ7Tn30G
 n0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727683616; x=1728288416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PDKmxhtETyeu/iYuY2neXJ4cpuVufAHpcFENKpKvuEg=;
 b=k+ovtGvfdRtdcrX5LounSyeWQ27Z8pX7w0XHj5ayKb8BEOOB3uQdT6JuJ1cU8uJbkz
 L3jcOAqxvqorJsWpClMVux8VyUNG9zk+8kxBabRjGv633maEY6l/ewOpHEZ7c3ENKUgV
 tf/o/n+KLNV4QFvnG8TWPh6oBTCznV6XdRTgpjA0fvYqOIoph3DNigs/W3S2KtgnpI4T
 q2M+K+z9xmEct/6kgvyEQYIvDaNzqewmSBXtd5mCSIJn+nEYqE86Q7CNFts5thnN94vO
 nZAFrNZ/D/onnxAW9sosrTF+Yzq8hYovoQU6PQq8FarHIwuRa+xlx4vcKNpcfTFyfsFA
 jAtg==
X-Gm-Message-State: AOJu0YxUvjCHAAqiFggJLVPmdCd+9o3jqmJZcGJj4kcLUQuAZmJrWGjc
 ruGoZ4nhjDDMqD8qunePdJ7ljGXuyGJet5hRgbFgyTfE7vwegTGpD+EhZ3jUTmWUflfwC9etfRx
 JCaI=
X-Google-Smtp-Source: AGHT+IHYEAXZvTMQIghMVZv8Pw1TDOBPf+W7tpo+teIiQ7939xyVfth4qR6F5Ris9NSp4atmfNQHng==
X-Received: by 2002:a05:600c:3b93:b0:426:689b:65b7 with SMTP id
 5b1f17b1804b1-42f58485cc1mr80571605e9.25.1727681720993; 
 Mon, 30 Sep 2024 00:35:20 -0700 (PDT)
Received: from localhost.localdomain (186.red-88-28-13.dynamicip.rima-tde.net.
 [88.28.13.186]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd5742a23sm8324073f8f.105.2024.09.30.00.35.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 00:35:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Jason Wang <jasowang@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sven Schnelle <svens@stackframe.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-arm@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Burton <paulburton@kernel.org>
Subject: [PATCH 03/13] target/arm/ptw: Use the ld/st_endian_p() API
Date: Mon, 30 Sep 2024 09:34:40 +0200
Message-ID: <20240930073450.33195-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930073450.33195-1-philmd@linaro.org>
References: <20240930073450.33195-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Refactor to use the recently introduced ld/st_endian_p() API
No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/ptw.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index defd6b84de..a1a6b1fec3 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -699,11 +699,7 @@ static uint64_t arm_ldq_ptw(CPUARMState *env, S1Translate *ptw,
             data = le64_to_cpu(data);
         }
 #else
-        if (ptw->out_be) {
-            data = ldq_be_p(host);
-        } else {
-            data = ldq_le_p(host);
-        }
+        data = ldq_endian_p(ptw->out_be, host);
 #endif
     } else {
         /* Page tables are in MMIO. */
@@ -860,16 +856,9 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
     if (!locked) {
         bql_lock();
     }
-    if (ptw->out_be) {
-        cur_val = ldq_be_p(host);
-        if (cur_val == old_val) {
-            stq_be_p(host, new_val);
-        }
-    } else {
-        cur_val = ldq_le_p(host);
-        if (cur_val == old_val) {
-            stq_le_p(host, new_val);
-        }
+    cur_val = ldq_endian_p(ptw->out_be, host);
+    if (cur_val == old_val) {
+        stq_endian_p(ptw->out_be, host, new_val);
     }
     if (!locked) {
         bql_unlock();
-- 
2.45.2



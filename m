Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450E3C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 15:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx6PC-0003sa-NP; Tue, 25 Mar 2025 11:41:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx6PA-0003s8-Px
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 11:41:28 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx6P8-00048U-Om
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 11:41:28 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cfecdd8b2so46383495e9.2
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 08:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742917284; x=1743522084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PPypTK7DZGi7uNZ8Ij2igQ+CirZnbkfROskeOnb68NU=;
 b=S+ORs9rg2XWpTxy7tyiJcQQbDL9MeYPGgYjYdTNOSr70f03LeJCtciP4CWj7ap3je3
 /aTZIDPR08XEZ3E+Ga/JUZ1+3w+3O2+5EIVZ0Ln7cku3y0Eem46PKYwM31ifvQtdZD1P
 MoyTOq947M264azIASlHZcUti27JUJle7SpZ5W2T23vnh15oFg1kR0WWWiFM7M8rEZHr
 uLlyDZYMvBLYYMhxfFLj0H8xS35eWSmzvwYThe/82BDRzzsr1kdB3cDG7GO8yC5249EU
 5GveCEQskVppX3bsoAdoOmFmHm+cU+4B6d97KpPQ/CBqYZvE8BofvwrA7V2jVUX2jCQx
 PG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742917284; x=1743522084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PPypTK7DZGi7uNZ8Ij2igQ+CirZnbkfROskeOnb68NU=;
 b=EWLL14uWMliLWY7nJzXN+tWMc8a82nFocyNMiWyeaCLU9Umlzpekl32ZtokMXXJrZe
 9zMi7KQl1IIct74ZsPUigmq78yGydyQdbT0pB5wFRkMD0hm8rJ8CMDSKS2XJoXZwqe4O
 EfRsNeKkgmtretALKyGo/jZWkwQx6WFGwIj6F92EJIgFT15xO947FVRmogArWmUznt8W
 21IkUEgOZKh1LwjvOpNdxok7ZPM+x4gVVMJ1YONP7r0j6DG2e+1Cf/zypouKqY9nIneD
 7BmN3UWan/nfO4SVdGmSijPh6fLyJ+1RcwZpDw3U+qz6CqA8U7FmDlaKr4jSGD/ne4qt
 BmxA==
X-Gm-Message-State: AOJu0YzJ0P88URSkpt0afR1HkMy+eyAt5EOBMn9hZhE8rNTJr3MrYpqs
 sdAb2q3GCswNAHLlKarz4E5oKDsdskyZSYfZwEMRS4e4qsm891h2fEK4B55H68UXAIqDNZAqKzp
 F
X-Gm-Gg: ASbGnct2FCZjhc1E5Y3jIIuiVj/Kxvh6sg87KLZ2GzUsHv3d9ZrElRcOwmKSuWdli2x
 fAJPRfCJqJelZSR0J0C3kzT6WR9zxHQY+wadPtt2YAP1MWKXPq4N39VUMLU4AJTDCShivJNbW5t
 rbJ77oIpSfzRWSCA5u0pxjldesyOMwfxAt91sXln8sO0FCp64mTWifT1k3TPdtzdfHpYilb6XTp
 qslHqXU2zRymXtDd6SmHVQ0aGAGtjtkf2dpuXp2SPq7W78ZHmkRlyUPAn5s2F8H84jAl9RESmQq
 OK2wGXDWtNrbqinbYGvi+JIsrG7qwk1PUjbKFg5XjzoHee5A7B+T6NKGCLZA0lTNxAXN9qjjT/f
 7cKMEb+QRo/dbiRTGrBs=
X-Google-Smtp-Source: AGHT+IENHykQe0Le4bc1bmt9DfBs0fWzqY97k06UokFYP63TysbJyBIT8gShUgk5TiBMVztUEdMnog==
X-Received: by 2002:a05:600c:1d9f:b0:43c:eeee:b713 with SMTP id
 5b1f17b1804b1-43d50a201a9mr169708175e9.20.1742917284586; 
 Tue, 25 Mar 2025 08:41:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b5536sm14446174f8f.54.2025.03.25.08.41.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Mar 2025 08:41:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH-for-10.1 5/8] target/mips: Replace ldtul_p() ->
 ldn_p(sizeof(target_ulong))
Date: Tue, 25 Mar 2025 16:40:55 +0100
Message-ID: <20250325154058.92735-6-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250325154058.92735-1-philmd@linaro.org>
References: <20250325154058.92735-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Replace the single ldtul_p() call by a generic ldn_p() one.
No logical change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/gdbstub.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/mips/gdbstub.c b/target/mips/gdbstub.c
index 169d47416a6..b9fc667373e 100644
--- a/target/mips/gdbstub.c
+++ b/target/mips/gdbstub.c
@@ -79,12 +79,13 @@ int mips_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
     CPUMIPSState *env = cpu_env(cs);
     target_ulong tmp;
+    size_t regsize = sizeof(tmp);
 
-    tmp = ldtul_p(mem_buf);
+    tmp = ldn_p(mem_buf, regsize);
 
     if (n < 32) {
         env->active_tc.gpr[n] = tmp;
-        return sizeof(target_ulong);
+        return regsize;
     }
     if (env->CP0_Config1 & (1 << CP0C1_FP) && n >= 38 && n < 72) {
         switch (n) {
@@ -104,7 +105,7 @@ int mips_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
             }
             break;
         }
-        return sizeof(target_ulong);
+        return regsize;
     }
     switch (n) {
     case 32:
@@ -144,5 +145,5 @@ int mips_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
         break;
     }
 
-    return sizeof(target_ulong);
+    return regsize;
 }
-- 
2.47.1



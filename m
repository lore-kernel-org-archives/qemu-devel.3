Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA52DD7497F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 16:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWdUR-0004Ej-C1; Fri, 19 Dec 2025 11:38:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdUN-00046f-S5
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:38:00 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWdUM-0000Y8-Dz
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 11:37:59 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-477563e28a3so13041945e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 08:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766162276; x=1766767076; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uc7q1S3ew+wCXif1tbZ7lUtNiynYGdMogszF2B2DxFI=;
 b=QNjwHW4x6QJBLSJuPIe0H2l3YBnyyvQJOlfB/DNGGzvJQ7UKiD+XIBz7w4O3jhcoAW
 rD6+HHHF6Yg/6ba9gMT2b4LYDucwsWH+q13bwEhSrkdK03rj+8cqE1cmC6qPO+YdWsN4
 CbgjCcQNq+vgKJIoqelA4XsN4aEo3bxmtA5PTQxzXcSa826XRS2owN6sL4QheZJdEm1m
 4X2rukHkdxKjhpaK9YykZcHgT0Dy5yOw33ruxW0CRXoorOAeCLofQH6QGC8jSCillink
 xvT1xQdH8fxU+EBM5CaBY+KzXHzqPn69IovLjzWtvPd13xqZAvoObftVjleStEAtzyi8
 pRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766162276; x=1766767076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Uc7q1S3ew+wCXif1tbZ7lUtNiynYGdMogszF2B2DxFI=;
 b=dhw06vhRT3KB0ROL1WgxAj4jJ8WgzkXZybyPn9uznp7kivgmu7HaxqzlqX06USPaE9
 17MTrSxf+wBxylwcC+F036p8eTKVAIe7bkKxZQyovasukY6Dm4UL0MxLoI44yVf6bU3o
 L6/7MrktixsrdIaW/VJWlFc3LUzh/a7MztguuFrfpRmdqfRcIdF7eWhZne+29H0DrJIr
 EKjTt7K5ceESA1EZPj6rQCddx5732qsAtiSC7mvkZEPekJlqwu4KjOyTEWqYPvO8YtVz
 4MpyNRtzUBdoQvc3UE9i+BFDnJ3Q8UnQ/dvceviOsd5/zfyd0EYifPM9zlWHMM7fdVx1
 PIxQ==
X-Gm-Message-State: AOJu0YwYeUdg+cYf1GR0IdsGMd1wqeukkZdctiiULwGKAGVzvi1KhC0u
 eP3uuicKKvYWq5GiO1gOxoeZJUSKpzvlhF43a9tK6pNZyZ7kKh3Mp8laGwdEtxvNzPAybIVZ791
 OVYy5tTQ=
X-Gm-Gg: AY/fxX4DnRYe6nNSjuvgMassZksuV2tX+TzSnmRx23OpMQwbaq5OunTlm3B5xoeA0kN
 l63DmZqrJBYY2bf8zF/An468/k7mdgV4/zZCvP2tRtExR6uJib2zFjugWeg4qId/6QKxVhLG3Lf
 93FyrA6i/Scjc05x2lO7mwvo6V9EVCu0pvo1xNiXH8B0PTQmRs0i8Lg3+xroTc+3NxgyCUi5ijm
 KYoo6TI4ah/TzNmF6XlDBa4wW0KUDaVGnczQBi3my+rCrxqPa5oR9g6KCEgth8RYDLyDzx8CfW9
 t84UHnzh9ZC/Gc2ZhJxsJ3RmmhgP6yHE/t8btMtLpGaBLlrCHCC7IRQIPYhhPP39uOKZjW8rpMx
 TX1q4xI53dQ5sQeid64ndP+gIWHy/x/2wio+XLvkob5in5rHOB48nZ47v6IisMLEgp2Gn6gHJzv
 ZSf9KrGJi3qZWSZEMC3WYw4s4RuZKH+YmZ+x8pAA2lfXrQTYWEpmqux5prJCZY
X-Google-Smtp-Source: AGHT+IFH+phVPTG8P2oE5tgqdSSZZF/QyWXM4iwzJJIMsAj6r1BFpwGUxf7TilAqEx/WQY/l5leamQ==
X-Received: by 2002:a05:600c:4e05:b0:479:13e9:3d64 with SMTP id
 5b1f17b1804b1-47d18be1546mr36815175e9.15.1766162276261; 
 Fri, 19 Dec 2025 08:37:56 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193d5372sm54447795e9.14.2025.12.19.08.37.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Dec 2025 08:37:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 9/9] configs/targets: Forbid SPARC to use legacy native
 endianness APIs
Date: Fri, 19 Dec 2025 17:36:49 +0100
Message-ID: <20251219163650.74303-10-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251219163650.74303-1-philmd@linaro.org>
References: <20251219163650.74303-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

All SPARC-related binaries are buildable without a single use
of the legacy "native endian" API. Unset the transitional
TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
further uses of the legacy API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/sparc-linux-user.mak       | 1 -
 configs/targets/sparc-softmmu.mak          | 1 -
 configs/targets/sparc32plus-linux-user.mak | 1 -
 configs/targets/sparc64-linux-user.mak     | 1 -
 configs/targets/sparc64-softmmu.mak        | 1 -
 5 files changed, 5 deletions(-)

diff --git a/configs/targets/sparc-linux-user.mak b/configs/targets/sparc-linux-user.mak
index 1b4ee80fe17..4ff4b7287d2 100644
--- a/configs/targets/sparc-linux-user.mak
+++ b/configs/targets/sparc-linux-user.mak
@@ -3,4 +3,3 @@ TARGET_SYSTBL_ABI=common,32
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=32
-TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/sparc-softmmu.mak b/configs/targets/sparc-softmmu.mak
index f02bacb8bbf..57801faf1fc 100644
--- a/configs/targets/sparc-softmmu.mak
+++ b/configs/targets/sparc-softmmu.mak
@@ -1,4 +1,3 @@
 TARGET_ARCH=sparc
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=32
-TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/sparc32plus-linux-user.mak b/configs/targets/sparc32plus-linux-user.mak
index 75c3a600bf0..7a16934fd17 100644
--- a/configs/targets/sparc32plus-linux-user.mak
+++ b/configs/targets/sparc32plus-linux-user.mak
@@ -6,4 +6,3 @@ TARGET_SYSTBL_ABI=common,32
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
 TARGET_LONG_BITS=64
-TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/sparc64-linux-user.mak b/configs/targets/sparc64-linux-user.mak
index 1b75d276426..7c2ecb7be06 100644
--- a/configs/targets/sparc64-linux-user.mak
+++ b/configs/targets/sparc64-linux-user.mak
@@ -6,4 +6,3 @@ TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
 TARGET_XML_FILES=gdb-xml/sparc64-core.xml
 TARGET_LONG_BITS=64
-TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/sparc64-softmmu.mak b/configs/targets/sparc64-softmmu.mak
index bfa1bcfb427..d9d51d21e59 100644
--- a/configs/targets/sparc64-softmmu.mak
+++ b/configs/targets/sparc64-softmmu.mak
@@ -3,4 +3,3 @@ TARGET_BASE_ARCH=sparc
 TARGET_BIG_ENDIAN=y
 TARGET_XML_FILES=gdb-xml/sparc64-core.xml
 TARGET_LONG_BITS=64
-TARGET_USE_LEGACY_NATIVE_ENDIAN_API=y
-- 
2.52.0



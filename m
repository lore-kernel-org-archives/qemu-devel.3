Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBA9C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 15:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCLf0-0006dN-HK; Wed, 29 May 2024 11:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCLeq-0006bq-1Z
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:56:08 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCLen-0001DU-0T
 for qemu-devel@nongnu.org; Wed, 29 May 2024 11:56:07 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a621cb07d8fso253937366b.2
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 08:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716998162; x=1717602962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AbIDJBK0SOT8kERkaPr5uzNF41ZmOzdWQ1uPIqE215A=;
 b=y1Ab2V6HCFATd2jzSJvPJTNMCuqi/c637IoblkujQgJw34d+aABsbke3gBeDFgAH32
 4uGin70gXQzSCJtLUsxx+TOO/j79A9ewM/x+DN7HAul6cQnADxAmFeZrFpFYvPtnJh9W
 v4N9jsYhiDSwuHyJJDfJ0y2uYNcLjoaAKBLB1o0pYhkxaMgBh4ayqVx8Y90UKrsoQ/UX
 ABXDG/gEfGAfHDIEy7EfhcnijeBsMS0cO1Zyh2ETBffDmRcu4uMcqK2kA5L41+Qdt6yD
 B5waozhBIp4lpVh8BAnnIOU1cB4ok5ZhQJHHdzldLSiihttQBN5bN69ACucMS3aZWp64
 ZQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716998162; x=1717602962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AbIDJBK0SOT8kERkaPr5uzNF41ZmOzdWQ1uPIqE215A=;
 b=Z7m666HxtAcDQgfxQQGd0YipH3o/4YHDNtirbIkahHl3e37qorT1AgG4DU67arM7ps
 2jNJ/OTPfCiPwkh97qOYKv057apdLoXKkoK+p9nd3ihNBtKGP1yyVdtXFuQH3oh5lT75
 o2/2hwd3LDEWBW4fPNOnMiF3/yEyb3ZKaWio54sDqsZ0aQ6drwxxihCG4E593XEyXHYe
 zxNWHwiIQfvnwKKOdLVOsxIAS680mvk+WyZqyzUbz39A9b7I2FvEDGjodIukvMbByJLS
 7zyaHFMlfca7MCpT9hSohW4gUNz+AnNlSrzvVXIKzrcgd5zmrbAiHvVSlyD30lululAS
 K5Uw==
X-Gm-Message-State: AOJu0YxKeG9PmiDGY+iikniOhW5TQVkflv0sk2+I0vyU3FNS8OLrvqd8
 8sKrR3Rg9mwuTB8V/rrxZ3T3NgdimT/T3hGBVUFkRkmmZ8Tmri+0jymLh2fIzrr/lkPldIsM/rs
 t
X-Google-Smtp-Source: AGHT+IGI8mVnTn+DyawOF94GxEvNfxdq/wTIpYhtxshtUQNeVCNBfDc2At0kJbBXJJfjo1nSA7o6AQ==
X-Received: by 2002:a17:907:1b20:b0:a5a:99a4:62a with SMTP id
 a640c23a62f3a-a6265011c68mr1387218766b.75.1716998161876; 
 Wed, 29 May 2024 08:56:01 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cda8f98sm727243566b.218.2024.05.29.08.56.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 May 2024 08:56:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/3] target/riscv: Restrict semihosting to TCG
Date: Wed, 29 May 2024 17:55:47 +0200
Message-ID: <20240529155548.5878-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240529155548.5878-1-philmd@linaro.org>
References: <20240529155548.5878-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

It is pointless to build semihosting when TCG is not available.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/riscv/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/Kconfig b/target/riscv/Kconfig
index 5f30df22f2..5c360a70a9 100644
--- a/target/riscv/Kconfig
+++ b/target/riscv/Kconfig
@@ -1,9 +1,9 @@
 config RISCV32
     bool
-    select ARM_COMPATIBLE_SEMIHOSTING # for do_common_semihosting()
+    select ARM_COMPATIBLE_SEMIHOSTING if TCG # for do_common_semihosting()
     select DEVICE_TREE # needed by boot.c
 
 config RISCV64
     bool
-    select ARM_COMPATIBLE_SEMIHOSTING # for do_common_semihosting()
+    select ARM_COMPATIBLE_SEMIHOSTING if TCG # for do_common_semihosting()
     select DEVICE_TREE # needed by boot.c
-- 
2.41.0



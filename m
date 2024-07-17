Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D60EFC41513
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 10:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2MF-0004Bc-9I; Wed, 17 Jul 2024 06:58:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU2MD-00044H-Je
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:58:01 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU2MC-0005fj-2D
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:58:01 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-36798e62aeeso4312846f8f.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 03:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721213878; x=1721818678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YQ5kcnCOObbjA6/Or2TYLNPevY5gyQfg0ztfeo6rNcw=;
 b=awDkfBAQ35vvxlBLC5tWQMTYjibDAsKNdyPaMK885LEoBDQWqsiCZBl/rStaePO+MP
 PHdMHF3MoOAqvXVXTyc2qggcFNCkbKZktQuEThoukzAzSR0pEs4YIMiZvA2Coiuatbs4
 00/hB7DJed7DV3kcf73IX8enbVE3uw0tGSYUo/5h5Vj5ZRZUZMKRrVdJhyW3/zKqflsZ
 eWftatCqla2Lleyr8tGqecPEA6LfelPdMz+GWeJ4+CmSaGyjb3qc5A3j4dE9Uo/3OpaH
 un7Y/IF8zNHPhUZDHdpqjz9ZuZmf8lwnAnznWVebr+vCuOKL8Mrqxt0R4E/Wn0q81VL8
 92dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721213878; x=1721818678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YQ5kcnCOObbjA6/Or2TYLNPevY5gyQfg0ztfeo6rNcw=;
 b=mZjSJdHCFo0sVzRHsaMajzrn72XCXOkr2y93gpTcf++XfQM8F2k0NeCsdim4FIUpoh
 ZjdO2Qd21OyIHQXzC87DoHXDGNWYat0tJJ9syd2BXkvIsVtBYBPJLCzre7ejahrYIxK6
 2HwIX6vEEG7pcGKy1bmD2rXS/OVQtfARB97/WAd7BXfgtpXQivbWovKiNTOGZ0pmER3P
 BxwV595BGfhPtTBIjWJ/+Z1jY6zHt/hsNvne4j8HTblA+UY+vGRSq4z9l3x6LAz3Xf2s
 HDL6hWdgguiiKG3lTAai/dkxD7wDr02elDG49iIUGFQC/Lyh229kj6XG0UaPWl0hEGFx
 FfFg==
X-Gm-Message-State: AOJu0Yz1JIxTaub9XFcotpcp8YGT5HiOe0CVC7JFBb2lJqLkb73tk0UP
 QKXhI1aFkBiFiIC0yb8nRN6kQfECtBsqtc3FhBubRd1SkVROmKU+eHW2bwsc5yyjsFnhTRCY+v9
 CYlTpyQ==
X-Google-Smtp-Source: AGHT+IEBQtuQmFSGg1imDLHD/Xw3NQLIn8z4odfK/LV9hKI5DQW6WxvJCZYkj6qpurG05qKXWUdjPA==
X-Received: by 2002:a5d:5cc3:0:b0:368:d0d:a5cf with SMTP id
 ffacd0b85a97d-368316f8093mr740735f8f.45.1721213878365; 
 Wed, 17 Jul 2024 03:57:58 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafba03sm11370123f8f.76.2024.07.17.03.57.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jul 2024 03:57:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 6/8] target/riscv: Restrict semihosting to TCG
Date: Wed, 17 Jul 2024 12:57:21 +0200
Message-ID: <20240717105723.58965-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240717105723.58965-1-philmd@linaro.org>
References: <20240717105723.58965-1-philmd@linaro.org>
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

Semihosting currently uses the TCG probe_access API. To prepare for
encoding the TCG dependency in Kconfig, do not enable it unless TCG
is available.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/Kconfig b/target/riscv/Kconfig
index 5f30df22f2..c332616d36 100644
--- a/target/riscv/Kconfig
+++ b/target/riscv/Kconfig
@@ -1,9 +1,9 @@
 config RISCV32
     bool
-    select ARM_COMPATIBLE_SEMIHOSTING # for do_common_semihosting()
+    imply ARM_COMPATIBLE_SEMIHOSTING if TCG
     select DEVICE_TREE # needed by boot.c
 
 config RISCV64
     bool
-    select ARM_COMPATIBLE_SEMIHOSTING # for do_common_semihosting()
+    imply ARM_COMPATIBLE_SEMIHOSTING if TCG
     select DEVICE_TREE # needed by boot.c
-- 
2.41.0



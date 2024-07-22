Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFFFC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 11:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVqzn-0002cV-2Y; Mon, 22 Jul 2024 07:14:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sVqzk-0002S0-6f
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:14:20 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sVqzi-0004Jw-1b
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:14:19 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-368557c9e93so2107299f8f.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 04:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721646856; x=1722251656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mrk2g2iMtnBRvtrBAoapMSBcMDfcCWKQff90zKvNuK8=;
 b=uH9Bt1diQUxDNNipwH2hOzfCbKNutV7bzf44MeMYBL+cYStDlFjT+V2b3sc9GF2dO3
 EekDqJSAJuZw76oVAXQqnjpaHMngyLWYAdIl8zDtBKHEJ3pRNiYb5uvSBH84QMO0388P
 iAXlTPTzr93jBLG8UL3CIJ2RqiFYjjrPgsV/PE6Uc7iONMCqkNqK6Ex3JyBYBM+wwx7h
 w5Kol6NFiWQakxH3qlC4Se4RgEiCk+4X976GiUZF/Y0LL/leo6wNGdjluUOSPZrRw4hy
 1AZ6bowTsiBDBJxcBq8JZNvHNQCgZ9lI0u20bR6RymGwIw+YB+7W+DUkvnjOeHUJuLI5
 ew9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721646856; x=1722251656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mrk2g2iMtnBRvtrBAoapMSBcMDfcCWKQff90zKvNuK8=;
 b=gqEa70EEl5eNbYG3X9FrtPSQ7nG45O7/DrUH8bvfyVSZWBgJFf/zJ3yGh5ZSU01sk2
 JUm58ft2OTmmXRxnNcduwbWHiEKxTi5TIA6UJYCbvw+rpltN+pzlgv0UXsk0z749xpAI
 3aC4X+EOgi17WpPVtbtRUw/8DPBi8tt8AL3UP6JkpGcpar98ktt33s6mktfGj0oc9gcY
 5HWTsePyjVcC1XXcnELSqfY+ISdynKmfghP4rS7A5I1lxSqq3Acn7U30un5NVyRbMCpj
 b3hdmoG3q5nqCkqZVlC4yiY3j54aYJx660XUkcq+LQRX2pI1nN7/dDYWxssTkarG3cvT
 FE0g==
X-Gm-Message-State: AOJu0YyNapcw/YYiyvp7Nf9ou/aDEiyLrFd67YPcGuGXWohlQwzU/Cpd
 QrSPTC4SWhJuywZJF1Wb63vNcI4EmyL9lOz8tBJeUiz5cN7n4SCVP/KJ+mNngBI=
X-Google-Smtp-Source: AGHT+IHog/oFTJy6XYNf/ScBPInZxgsN2XaercaybmALj6e1X5srF1S4TLQ28yr2hOa93bnEzwBQ2g==
X-Received: by 2002:a5d:5f8d:0:b0:368:445e:91cc with SMTP id
 ffacd0b85a97d-369bae13627mr5096890f8f.21.1721646855413; 
 Mon, 22 Jul 2024 04:14:15 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ebd50sm8179498f8f.93.2024.07.22.04.14.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 04:14:09 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CF7E962102;
 Mon, 22 Jul 2024 12:04:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PULL 13/16] target/riscv: Restrict semihosting to TCG
Date: Mon, 22 Jul 2024 12:04:10 +0100
Message-Id: <20240722110413.118418-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240722110413.118418-1-alex.bennee@linaro.org>
References: <20240722110413.118418-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Semihosting currently uses the TCG probe_access API. To prepare for
encoding the TCG dependency in Kconfig, do not enable it unless TCG
is available.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20240717105723.58965-7-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240718094523.1198645-14-alex.bennee@linaro.org>

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
2.39.2



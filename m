Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 241F8D3E779
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SM5-0006PQ-I7; Tue, 05 Nov 2024 17:48:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SLq-0006Ii-Go
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:48:45 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SLn-0004Gh-MZ
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:48:42 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-37d50fad249so4377139f8f.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 14:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730846918; x=1731451718; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h8CrhtvCjcCTs+avOKGHYgRkcmEeUIx30wu246eyzA0=;
 b=OoDIRwikvgTUCtCkaXvMJ5nMNSWLchoTiE6HZBNbJ7zKltufP9GUGqIKH1WVXf0l8n
 GorH+IfdZg/bbm2IugtUjI1gpCI3+GcOTG0SMzWJAF9h6ms88TNGQuCs+o3PmbdrnSTa
 0F9wPl4n6gW/kTQuESTCHYVuj4JEx38Fq/bRg7Pg8X8X89SGMiIvGQKI6WCfjC/FVjXa
 j2oyfE0gEh8aZSogpQi/iCSvC3A5uyFATt8mpWGy98+Ghz8C2xHhLMKZd41Mr4J1zbnR
 a25yMmLoNsNzI2HUL/L17P2gDvzD1glJfMA++ErBNFFeq3VwU7AtNN3vVKqNV8dE4QBI
 S+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730846918; x=1731451718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h8CrhtvCjcCTs+avOKGHYgRkcmEeUIx30wu246eyzA0=;
 b=ssRtA9gDgmi2NMnD9jTxE7yFEub9+umR0PnwdhQxKMhPavGQYvrnhZTa68vVw3BemS
 +r+c9pwDRP+YSgZzzZfWB1RdPVcJpzUvFUBUS49byeyyiHecPgTiejm3/ViC/qiENlHX
 G97+krjioNapv13G0ntMYcaotmccu66vtA4ustBWSnQu4LwCPDLkQUtllsXy9u2fWr3V
 9mW8a3AuAbBgKZj5WbPw4qBIYv9vaFG5TBzSZHsGo6RnVJScYlEGA9ci+gj7N/jpa5rj
 LdEwQPLbDKYHwhOMcKGUwo8MzDxO7+jg9hkfbs26/N6JKgS2pj6vpUVmjDTUrpWH+DRh
 4UEg==
X-Gm-Message-State: AOJu0Yy9yNIAqP83wFtE9kWGJBY+1AhzWl1Jz/g7uAkxRfM6nRSON20f
 AfWsFhFJnT+1kEljvBEVoaaZH0iego7LxHnqaMNS/wG2dr2J/HehtbCpOPYlA18+nURdFsjRdQo
 CxlQsbA==
X-Google-Smtp-Source: AGHT+IG0wL3q/nyECyhCpkkwpU76W70NSARtGkmPzPxL/y6z/RL9nMytLdIw9hboo5CPDP1qjvXFJg==
X-Received: by 2002:a5d:51c1:0:b0:37d:4ab2:9cdc with SMTP id
 ffacd0b85a97d-38061127ff2mr25595632f8f.13.1730846917722; 
 Tue, 05 Nov 2024 14:48:37 -0800 (PST)
Received: from localhost.localdomain ([89.101.241.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c116ad90sm17376141f8f.99.2024.11.05.14.48.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 14:48:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/29] hw/ppc/e500: Remove unused "irqs" parameter
Date: Tue,  5 Nov 2024 22:47:11 +0000
Message-ID: <20241105224727.53059-14-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105224727.53059-1-philmd@linaro.org>
References: <20241105224727.53059-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20241103133412.73536-5-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/e500.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 060db36dbcb..d4d3a927968 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -829,7 +829,7 @@ static DeviceState *ppce500_init_mpic_qemu(PPCE500MachineState *pms,
 }
 
 static DeviceState *ppce500_init_mpic_kvm(const PPCE500MachineClass *pmc,
-                                          IrqLines *irqs, Error **errp)
+                                          Error **errp)
 {
 #ifdef CONFIG_KVM
     DeviceState *dev;
@@ -869,7 +869,7 @@ static DeviceState *ppce500_init_mpic(PPCE500MachineState *pms,
         Error *err = NULL;
 
         if (kvm_kernel_irqchip_allowed()) {
-            dev = ppce500_init_mpic_kvm(pmc, irqs, &err);
+            dev = ppce500_init_mpic_kvm(pmc, &err);
         }
         if (kvm_kernel_irqchip_required() && !dev) {
             error_reportf_err(err,
-- 
2.45.2



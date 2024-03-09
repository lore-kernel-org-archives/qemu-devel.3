Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B59C54E60
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2J8-0004Uk-3Z; Sat, 09 Mar 2024 14:24:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2J6-0004PJ-FU
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:24:32 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2J3-0002pN-NL
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:24:32 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a45ba1f8e89so379418566b.1
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012268; x=1710617068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+fuJ29vWBRe9UmwN0pN4V44UAyM0aAmIqNcBSmPyHVo=;
 b=TQBRYj9oVVvJad8rlOOGoPAGnUBtBMrNe/KfipJ2jsfgNFLgJxpMGrdpMZv15cBU66
 wjguUt/JuktcOw2K0+vt8zScN+6wSx/NBgZHzKVh3KWtKc75qrERDku+w4XSChZfIO2z
 bleR5uAlL4jsH5ceFZqO54jUW/jiIWkSiXejrD4rlD4dWsCPAkbZ01yZzxH1uookLpdV
 Z8P9P417ZNiTMOIYk16VQR+EST5v513AththRotSyLW+rE1SBzpjR3NWje0/IRWVDagI
 //pd4mf7Mn71K+mKquo3XfOoiATSQJRuBVXzuNdpXs+OtT+x+DDp7g8KjDHjCt8D+pQG
 TFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012268; x=1710617068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+fuJ29vWBRe9UmwN0pN4V44UAyM0aAmIqNcBSmPyHVo=;
 b=vVBqN4H/ReiXN3Qm2rQBB9KclYh0p7SBmO/kW2HSq4UpxmNZMtnzY1F5XMgHzFMWS/
 by/vP6kKQgiZSIazJcQC23xDw0JDNB+3si5NGsCJ2L0K6+wlP0Og6IRCqeuv/00mLRMs
 fKT+od9vCmu0t5F8QgLiWDWAcD3rSnrB31DBIe9WOWwjQe8lSv7JrW/HCPDFjTjem9fa
 cYhP9TGheZsCux7t3DRwAbu4MGQNJcBc4tvarTnxvuCrOfCM1SOU7U1p+PUguVfSDLKn
 WZOceVF35YXjYQoVpjjhtF7n8n+2UEXonGg1Z2bIx+Y7qk/T3K2jIIzuRxSXLn0izsjV
 /h1g==
X-Gm-Message-State: AOJu0YyTNsDgCJdUnCYKiFpaJn9V1Sp27gPvgNx3FqRcDJowkzcF7r9y
 ncBk4aF8/bnY6wnY0b6dglW+FZhq5y/a4FB3hsoIDZFFjkGt9qWlK0IM8JCWSmyMYJXGtrEM65s
 e
X-Google-Smtp-Source: AGHT+IHBKp40+UGhTSq+bnnVjikzcWIqKwU0NtKt0/06ov0ZeaDcTOvxjP/0RQTp71adKFj8bvB30g==
X-Received: by 2002:a17:906:52c8:b0:a45:a2cc:eb8d with SMTP id
 w8-20020a17090652c800b00a45a2cceb8dmr1224240ejn.25.1710012268039; 
 Sat, 09 Mar 2024 11:24:28 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 bk15-20020a170906b0cf00b00a4617dfc36bsm124195ejb.178.2024.03.09.11.24.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:24:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 22/43] hw/i386/pc: Have pc_init_isa() pass a NULL pci_type
 argument
Date: Sat,  9 Mar 2024 20:21:49 +0100
Message-ID: <20240309192213.23420-23-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
References: <20240309192213.23420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The "isapc" machine only provides an ISA bus, not a PCI one,
and doesn't instanciate any i440FX south bridge.
Its machine class defines PCMachineClass::pci_enabled = false,
and pc_init1() only uses the pci_type argument when pci_enabled
is true. Since for this machine the argument is not used,
passing NULL makes more sense.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20240301185936.95175-5-philmd@linaro.org>
---
 hw/i386/pc_piix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index e14dce951d..319bc4b180 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -450,7 +450,7 @@ static void pc_compat_2_0_fn(MachineState *machine)
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
-    pc_init1(machine, TYPE_I440FX_PCI_DEVICE);
+    pc_init1(machine, NULL);
 }
 #endif
 
-- 
2.41.0



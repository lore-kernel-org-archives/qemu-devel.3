Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B1C2CF6482
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 21:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suIaW-00085L-Nv; Fri, 27 Sep 2024 17:33:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1suIaU-000848-3W
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 17:33:18 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1suIaR-0002Bz-73
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 17:33:17 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42cd46f3a26so22019055e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2024 14:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727472793; x=1728077593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SzfY49PdtDNfg8MFK3xCv1xPYUCRuDNi4q0ni0OdsL8=;
 b=JVX5arCoYWC+C6Lf40m52DPwvV+ZAfhYckcspO+5YKA+EPlAHQ2vUeTxt+kS8d2QI5
 5pbmcvOz1VxbYC7r72dr+f8YX0hyqeZCHAi/F9F0gySJxycfnwwAxKN8Hg7TojjuAFkw
 QaeVefqccJV1OHK+aMTw24pQldJ6S5k9YVWQgSaRIWUkvj9FXI/xOEtRJO6Xft1oGC6P
 l8pM0HR09pj94+A3DAuEbqP0EJySbqxVijBIE4Z9O4kviSQFrmiICmcxy9MpOUDGLdjF
 OVQBX3V6Gsfdde0u+kAyNsmTiMjQZ4Aqwm3P78dh2DNhaN72DIro7KODxapCOXL2yA3U
 v2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727472793; x=1728077593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SzfY49PdtDNfg8MFK3xCv1xPYUCRuDNi4q0ni0OdsL8=;
 b=oABCGH92hADpG3i0yVZXGtXF6ltSbpuRXcP9PeBneDbvDTLCQ4fIFDpnuKUcXmOocA
 sxuM+vxlLWfwysG8M5jG3UApUNL6vsN7e/qp9TPKKSFeagDkVwMaibVqtoi/UeUwo8XQ
 txl4Xc4qvTr4YRQSKdJuQhkQ0yzSGgiRh082jFoJPr26riy1/t4LaEOPFwMTC0b0y5rK
 uazBuIKIaYEdGN1NGCP8IFKqhISoxl3eXSljihvIRD0MJqxpGQah7JlfsfYsvaAGLeKm
 L5qj+1gJ4kO3cDwjzuOIKT0mwMNIRGdkdZkLw7xbWSC2y23LUatR4eIntwzVYBLD6edV
 DfLw==
X-Gm-Message-State: AOJu0YwVfJSzrAg4xb+X68KJyVAGtZi1bF1OyWq04i4rZvgHhDxBb05b
 vt+RHOxVWUD551ah6Vk39OjHBsutMwlmTHo77kVEEv9/6TCNgUpAw4Sum2xaravYmgGCQc+Ld4x
 n
X-Google-Smtp-Source: AGHT+IEDbN5vatdsYGseitQaJDR/KbxBcX9wc4+nGPVd+ZGQBFk6sy7z/I8GFmhqx3co02xnMCTNmQ==
X-Received: by 2002:a05:600c:1c23:b0:42c:b6db:4270 with SMTP id
 5b1f17b1804b1-42f58432debmr29042835e9.11.1727472793332; 
 Fri, 27 Sep 2024 14:33:13 -0700 (PDT)
Received: from localhost.localdomain ([176.187.217.136])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e96a3622bsm84360715e9.35.2024.09.27.14.33.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 27 Sep 2024 14:33:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] hw/loongarch/fw_cfg: Build in common_ss[]
Date: Fri, 27 Sep 2024 23:32:54 +0200
Message-ID: <20240927213254.17552-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240927213254.17552-1-philmd@linaro.org>
References: <20240927213254.17552-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Nothing in LoongArch fw_cfg.c requires target specific definitions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/loongarch/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/loongarch/meson.build b/hw/loongarch/meson.build
index bce7ebac97..005f017e21 100644
--- a/hw/loongarch/meson.build
+++ b/hw/loongarch/meson.build
@@ -1,8 +1,8 @@
 loongarch_ss = ss.source_set()
 loongarch_ss.add(files(
-    'fw_cfg.c',
     'boot.c',
 ))
+common_ss.add(when: 'CONFIG_LOONGARCH_VIRT', if_true: files('fw_cfg.c'))
 loongarch_ss.add(when: 'CONFIG_LOONGARCH_VIRT', if_true: files('virt.c'))
 loongarch_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-build.c'))
 
-- 
2.45.2



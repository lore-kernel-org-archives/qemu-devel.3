Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 388C5C02185
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 07:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ta8vv-0001b4-Ns; Tue, 21 Jan 2025 02:44:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ta8vq-0001aV-Ku
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 02:44:19 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ta8vo-0005aW-Vv
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 02:44:18 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso36420545e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2025 23:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737445454; x=1738050254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XEfARowz/rydNBHLXw9YpQNaflRL33IfSCC4r75FApI=;
 b=M94TPX5cvcZMkH0H2E6ijuMWFqMd5LkZh+mXFTlFllq/X/WTbvjrkBqyCBa0IsA/ha
 pycf68DeFTb1q6skM/WfpLMtqif1wSnAfILqjktYh5/eeIccYb64+/sUgrY7MFI5VFB3
 BGAFt9botjW25Xkvh1hLJyJX7+YCuDlgCGjj7DXdf47JqbuOWafecQvD2gsNMFb4oLrq
 QtyWlVJn2PPzbF4wdiVgqGuqsFJcHInqq+ecxqL2jSUSnozApQmSyedAojunJG7eVQQF
 DSAYne0fSlVS1jD7sATP1cyZ1H44Am9+LW0oec5f5WjV2QDdSzAdlATnltjBTo56ia6L
 p+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737445454; x=1738050254;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XEfARowz/rydNBHLXw9YpQNaflRL33IfSCC4r75FApI=;
 b=ZRQp+45a7f6Kdpf7gYsTYa5vkTWkVah6ryEAI2VuvC2DgMU0dgGlQ0G/cE1s/R6+F1
 uETw7ckcKmvwGHGJRpZpchgyyV+TqFfe8LpU/WqY6SNLun5nkN7P11gSZOAYNksL+dae
 K4BUoXbv0ymAcHP+FQOjW7/W2RvE9y6ElxbaT/3TfZJZb0WO+DBT3UgQ39QGU+L+o3fc
 AY3vescmQHow39taZA/vY+uWrvmeiSgcJQV+icy61nKK4bWPrBLERrpIk7gamCm26mKz
 xEA36U74oBNZlKEfjFYaK1t8XIeLVMkkpTpgek/PuSfE4RMkXwc0sUbjyY+2natmsQhq
 yoYQ==
X-Gm-Message-State: AOJu0Yz4Nh4AhE+fRKBsMZFL4cXwIXMlL5fgAgk06fbad2lf+djnABP/
 4VNIpusXzQquYK6dOADk20hdPaHGH7c5zaPkvw+ot1THKt7Ejg9u2mcPgUHvyntZdHUUhw4vkzH
 ZXQ4=
X-Gm-Gg: ASbGncuDM2La4OsCK/02ptpzagP5EGZWlA+jpbU+KaLxrJwdUhtAGb9GLGg/0uO7HQ4
 Z+Ur5owCgq+DxH0BfJyv/nxraU5VS/uyQFvuWz77Ssvx+3xq+H+ONDJvbGGWkLL3kNfnFBKmJpK
 bAR7Swwjmhu85OFc2sOFFBACSrH7mVqhkY+RMZzdyLm861x1XZQOuY3zgsdtTDIALaa+fsFml1c
 KvH2KkLiAHA/uoodZl9zCWLrhH769Q+wF7U1kGmyh75gJ9LcJcvVLiiVTgh6m5vTmHf+EUeTQyT
 JHLvvKzL9RYmSMgOjFUW0BN4yvB5aNBLsfN2oIj9hWVK
X-Google-Smtp-Source: AGHT+IG3lwxNI0al4X/G7RBwjCgzwcepCLlyKjVBPWA2Z4WGR9OGf2LHXRgDDZ/KxIGE8UDHBBWMhw==
X-Received: by 2002:a05:600c:4fd6:b0:434:feb1:adcf with SMTP id
 5b1f17b1804b1-43891436690mr121320795e9.25.1737445454375; 
 Mon, 20 Jan 2025 23:44:14 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438904623a8sm167443265e9.26.2025.01.20.23.44.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Jan 2025 23:44:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alberto Garcia <berto@igalia.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/2] hw/ipack: Minor dust removal
Date: Tue, 21 Jan 2025 08:44:10 +0100
Message-ID: <20250121074412.70292-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Clarify what is what in Kconfig,
replace qemu_allocate_irqs() by qemu_init_irq().

Philippe Mathieu-Daudé (2):
  hw/ipack: Clarify KConfig symbols
  hw/ipack: Remove legacy qemu_allocate_irqs() use

 include/hw/ipack/ipack.h       | 7 ++-----
 hw/ipack/ipack.c               | 7 +++----
 hw/char/Kconfig                | 5 +++++
 hw/char/meson.build            | 2 +-
 hw/ipack/Kconfig               | 4 ++++
 hw/ipack/meson.build           | 3 ++-
 tests/qtest/libqos/meson.build | 4 +++-
 tests/qtest/meson.build        | 4 +++-
 8 files changed, 23 insertions(+), 13 deletions(-)

-- 
2.47.1



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4A9C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:30:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCpi-0005od-VN; Wed, 15 Jan 2025 18:29:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCph-0005nc-9U
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:29:57 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCpf-0004j5-Lz
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:29:57 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-436202dd730so1484595e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736983793; x=1737588593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gxH2m8Vs1Fx3MxkvrohYLoheIuJ0UPaHaATdWh+YJQo=;
 b=LQSAYFNq5Pm68/5ag9LdM3l611JbjdxjTKGFhdP+Tq99u2COdrnhBij7hEPjs3wljy
 b5kZMUndCm4W9GBGn1cwz8LVyO546TuSFmbUpr4VfhE/z7XbGmdKdSo7tNCQr8sqPEXS
 Zf+IZuj2Gcu/+PrtC+eHBnZyooqRUtBGnSIsbheQUrfE3/f/pClPnIRArrWTxAE7kIEb
 X8AKHqWE68rim6yvJlmwwWaEgcgu8BGlehqHO9xhvGDnK3KBnw20lsVZAvgr17ha1jrt
 8TuAcXyCXbq7fT9sMbIklTea5YXBl/lmIoAhtPcHHWab4xWVKF6F78RW1WotiwvoeG72
 +9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736983793; x=1737588593;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gxH2m8Vs1Fx3MxkvrohYLoheIuJ0UPaHaATdWh+YJQo=;
 b=Avl/RTrki2S6UrljE1YuF7EbxdKg0KbnoJvkypaRQLb4sLhlYbFqX02gBg24V5KJ0Z
 QROlHhH6XszkgmuxAVzN4Ewougx4ukStGWSO30LvnFI6KizTeyTQJ013XQkKKglKODTz
 vMWaXwy35kt5JoB64e7uGBDzdTqYfkGB3r/kAYE99ZJlxM+eQYXzK6S5iBE/OYhvOnGX
 qUTiSgdaVwJSQKwYALo/QOE+e896xrmlQh60k0sxwazIHxW22cir2UAQqXT2P9Dk/KUy
 hEyqgKmdRBbI+Ic/A+hTOeAiYn+al4kzcP34Z5upi8Y7q1iinV/0gVQVu0W1rjthia2I
 Faog==
X-Gm-Message-State: AOJu0YwzvRLMS8HEnF76jJ3Dg28B7Twcrr++iZEzObV+mA+6A4l1xG88
 1TUK3DUVCVnx3yBMFPQXlxMYEM81H+/wxlUeTA8A7bySv7ym6YyMw+OtTqb7GvQFkhsSHgQ5xgi
 1jVA=
X-Gm-Gg: ASbGncs7XwjEfD0sVjDIDV51HjzqpjDg3pZyjjGSNjcSAO22pTQIIPwVOwthVcMmvWg
 Ota36fbcxXbj/XcM7GpzKCQLgtS3/E6JiPYhzXSb8pWuSB+RRPPhD9F3AHNnYb1uv2xU6+dREN5
 EgvImaFaIUilj/zprNBm3vf/DUNmHhb6KrJbdz7gc9ImISK0UyYJUuGJ4T0AwCxvCwJXRU3P0Rn
 Tr7+FgH/rP9uhHIZGVPp+JLA5ms91qKX+KFrUzZ2iodqPW7rTjZ9cB3I0x8nTPGNwusPmcQLQdB
 Kt8y+65UZtifBdUUABaeo1vJuU4KR3c=
X-Google-Smtp-Source: AGHT+IHAEu9XEyLzuCmGgLvG03h/KIGUkdBc9AgE38AWmwlCV5F1Hg/EN+/r/5+s4to4RSBIMqSl1Q==
X-Received: by 2002:a05:600c:4fc2:b0:434:f3d8:62d0 with SMTP id
 5b1f17b1804b1-436e26803f4mr271602795e9.3.1736983793648; 
 Wed, 15 Jan 2025 15:29:53 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74ac707sm38260765e9.15.2025.01.15.15.29.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 15:29:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH v2 00/11] hw/mips/loongson3: Remove uses of &first_cpu global
Date: Thu, 16 Jan 2025 00:29:40 +0100
Message-ID: <20250115232952.31166-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Missing review: #2

Since v1:
- Reworked patch 2 (rth)

Propagate values from machine_init() in order to remove
use of globals such &first_cpu and &current_machine.

Philippe Mathieu-Daudé (11):
  hw/mips/loongson3_virt: Factor generic_cpu_reset() out
  hw/mips/loongson3_virt: Invert vCPU creation order to remove
    &first_cpu
  hw/mips/loongson3_virt: Have fw_conf_init() access local loaderparams
  hw/mips/loongson3_virt: Pass CPU argument to get_cpu_freq_hz()
  hw/mips/loongson3_bootp: Include missing headers
  hw/mips/loongson3: Propagate cpu_count to init_loongson_params()
  hw/mips/loongson3_virt: Propagate cpu_count to init_boot_param()
  hw/mips/loongson3_bootp: Propagate processor_id to init_cpu_info()
  hw/mips/loongson3_virt: Propagate processor_id to
    init_loongson_params()
  hw/mips/loongson3_virt: Propagate %processor_id to init_boot_param()
  hw/mips/loongson3_bootp: Move to common_ss[]

 hw/mips/loongson3_bootp.h |  1 +
 hw/mips/loongson3_bootp.c | 16 +++++++-----
 hw/mips/loongson3_virt.c  | 54 ++++++++++++++++++++++-----------------
 hw/mips/meson.build       |  3 ++-
 4 files changed, 42 insertions(+), 32 deletions(-)

-- 
2.47.1



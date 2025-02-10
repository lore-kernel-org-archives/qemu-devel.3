Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70E6C0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 20:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thaeK-0006ED-Tc; Mon, 10 Feb 2025 15:45:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thaeB-000591-DO
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:44:51 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thae6-00043E-Km
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 15:44:51 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38dc962f1b9so2058169f8f.3
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 12:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739220285; x=1739825085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5HB87qrSZIjcYG5MXK7Optq3v+lGh0m2fxrQ9mcJz4c=;
 b=CF1eMWSdzLuu40Cp8Pw/DSz1ybXy0lCNFcd0dYk0c9WEJ8A0Enf6e4tQfyF7KL7KQM
 FK7acsb/so/wSRQTrN1wq6+dsFIt3AxNtt1xLAV0cwwT+EtTPavS9v/hhyO482n4zYWU
 gOD7iaEuU7jQikXmQcmhbksY9uBVeZJH9e3/NBlCbosu2ex7KRZPqtxGQrlJIfWesdSJ
 EmacdwXUcec6Ek3q2dxA/lGLKxu4K4bc6Bf4yhhpqwVf0HC6tcb8F7sj+0fbddySuxLF
 KhPlDVMC285rgjr+oYoVJR8xpHQNfxDSZJMknr7hLbn5jAxbsFbnIrigcjMQCjUCWn93
 gBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739220285; x=1739825085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5HB87qrSZIjcYG5MXK7Optq3v+lGh0m2fxrQ9mcJz4c=;
 b=YDXek8HDFMH0yTM9SOwlvL4BeM7KpJBs3+PxfyNyNsdDW/M30tT56Suo7Q/ri4yoIi
 DSEqQTNTKG/iOTWF4d9ieN6kFnsBxMi9OJbELnawKsVKcsFBJROZJ/r3VHmOwb3LfYkE
 34gFSM4Qg2XoVW3svnXGJDGCO5FGP2wXCuBP1BD08UrxMqmOwe7IUGT/VgX3VQKPitfJ
 /zfNnY7cG2+LgDF28YGDUcIP6v1C8wEdky/bb+I6bGCk6cy8wJHckl2FYPz7f2Os6fVj
 4g1ipymRT+BT2YXxiyAs4SUr8doKkaXD4Wkkaighr6gSRbmIpxAseUWfMBlMR4W9dKbY
 RDMA==
X-Gm-Message-State: AOJu0Yy1qPupe9L5Gg3VF6Hoz27xSF6ns76RRlCkBIdxObvDAFCe7tY5
 IO+HtFKta9wpdV/2GUbxKIDbKnrGnKHaQSGxRs+zoQHlQ8a13AhRw2RltqTn0cninubTlVuNzOl
 8Axw=
X-Gm-Gg: ASbGnctrQsZXDCqNACYLH+uQ+9vE2aJdzOGjlh8N87PkyHztL7PuM9AFQfAgEgIcBKD
 mRtk6BcU6cV85wsuxLzzf8vgf9Z3KEJSTkeQkihT7Ynr+4iGmwsCbS+hHRjLT6WPK75XyPhlrU+
 Nla1ajZxWe+jKcj5YzWyNtJEo8nPu5NMEzu6W/5UIQJFncsdguQl++2IY2ZoGwt6nKqxX4kXb09
 mEfhNU9/EoRFxMiN19b6Hk4nRuH1aW5KTVfFkxnBZiKsWSxl2LBsXv+XYRQhviMs6Xxlsjaxomp
 ZdQxy6QQsTjzWKljne6JXAlB/VY+hpBlrtqmYQd0gupyTvtrRAb5f8cm5X/Gs3WLgg==
X-Google-Smtp-Source: AGHT+IHHZ3WC72nh6OZ7jthj9EYdd3BVMnk1xg+Ce29rPNQEPTWOC9DuTx9rVcozcNo2TJwQW9VI7A==
X-Received: by 2002:a5d:59a4:0:b0:38d:e15e:17e8 with SMTP id
 ffacd0b85a97d-38de15e1b60mr3404901f8f.1.1739220284735; 
 Mon, 10 Feb 2025 12:44:44 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd2ef7efesm8175812f8f.52.2025.02.10.12.44.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 12:44:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 31/32] hw/riscv/opentitan: Include missing
 'exec/address-spaces.h' header
Date: Mon, 10 Feb 2025 21:42:03 +0100
Message-ID: <20250210204204.54407-32-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210204204.54407-1-philmd@linaro.org>
References: <20250210204204.54407-1-philmd@linaro.org>
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

opentitan_machine_init() calls get_system_memory(),
which is declared in "exec/address-spaces.h". Include
it in order to avoid when refactoring unrelated headers:

  hw/riscv/opentitan.c:83:29: error: call to undeclared function 'get_system_memory'
     83 |     MemoryRegion *sys_mem = get_system_memory();
        |                             ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20250206181827.41557-4-philmd@linaro.org>
---
 hw/riscv/opentitan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/riscv/opentitan.c b/hw/riscv/opentitan.c
index b9e56235d87..98a67fe52a8 100644
--- a/hw/riscv/opentitan.c
+++ b/hw/riscv/opentitan.c
@@ -28,6 +28,7 @@
 #include "hw/riscv/boot.h"
 #include "qemu/units.h"
 #include "system/system.h"
+#include "exec/address-spaces.h"
 
 /*
  * This version of the OpenTitan machine currently supports
-- 
2.47.1



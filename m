Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E18C87FCF
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 02:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukCW3-0008Qx-DV; Thu, 07 Aug 2025 22:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukCVs-00087Z-7w
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 22:07:21 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ukCVl-0003Te-3L
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 22:07:16 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-76bde897110so1439728b3a.3
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 19:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754618829; x=1755223629; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=srUf+JNV3nKSoU+LY8XDAhFoKmESVt4f02H+j9OZ9vQ=;
 b=qHYe0B0mmwhVES2+ShDZaQll9sqnRctCbyGB4LfUuw50MPcX/DPKWHZEga7L6yn+Ns
 9t44rAdrtJJz+HU4D6qifw5W9H8lzaUmITs8KG/asIcf7Hc+LugoTPRKyAoJe2Y0ukK1
 ZejCHicQSY3wYI2fbPJGSFR6YSHlSOveiZiBlLk9+kQ/xMRYPLYS3c/ORjmMRglNRka5
 zqFHkfjNgL+JtAIXwcszZ4x6GxL83mKWYlLXjf1lDZIkkx24CpQ5l8I2l8nb9IDmon0o
 EpK4+gQXq1PUtR43XM4b2DzhN/NQDAqxI3BDBACrKXoW5Nt5aTMmrhLP/b/Xsa45o/YM
 IpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754618829; x=1755223629;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=srUf+JNV3nKSoU+LY8XDAhFoKmESVt4f02H+j9OZ9vQ=;
 b=IeP/tm4xjD9c7bet43XmkCwqJGIpM9DceP6R0z43qhKuuKAwLw5aWdtSvsYDI68UnI
 kVn3rF1NzmyvqyKU4r+cgQ0Ij9Xo3v1vMO2Moiw6GtS7HhQLgLQe7k1Vjhr1Rp9nPDkP
 n2DRd2+6YPBfbADbvqJneQUIt/1TRb2iuuD6+dAYEDZAhoGmJhLROK9Kc1u29dJ8zBKa
 W+fkG/nrSOXgtt/OnetoqITj3X07OEj7J4JyaYiEjoMeFBz0x+UrGVxrGY5hX/yux/3Q
 WiZnZDIPhg9XlMzOTzqexJoWfCq49vF6ig4HR9w0Q+yCIBI3o8v/8MndD3Tjpngj4VBx
 hn8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3GdyBmAj7OXjsj3y8ZqU5Hu4t247u/TxulGxIy6cX1QS2b08w8Gy7Rfa39KwbxiKyNOtByQxHQyT0@nongnu.org
X-Gm-Message-State: AOJu0YyZPrGmcWKtDPHOH7zvYodfBsyC2A0poqWrimRmd3QHV1hZvtAD
 JfQx1KLK7EZVo8ipzR0QEao0pIB9Y+IvXV2eSkvg9rBNDUG7A0TcFx8tTSRG/yW+Mzo=
X-Gm-Gg: ASbGnct0mWqmOe0Gm7RKFx55vJE7n8EdUvmTe4kQfAAM8lTCbAz2jG+rs/DFQwsioZ7
 PIQfk9DbaqDUbxGNti0ESSZkPVOqrgya23ff3ML3vLba43Sd03v/wjokE67KBULWkzGlvfyiOfx
 96Y0frt/Q5oky+qqSo+5BXqTAnZ7busNdX/IVmpMu8k9On2Ex7hcyD5y0B1G2WVu9p1b2uL/cSC
 80cZuKdedWM3L3rkAmyEM+xoIUyVKjUi3hmkucL0UbHbtwvT/jEFQfdKb0eIOvSwXGet3i0mCXR
 5QLCFtICwIDp6AarfNf3DztPdjScu5DE1eZSSEYqhFgocSWy7w+h+zTmUkrOtfZbP4ZDGWAMZ51
 Z3QiOtxlYJnX4biu/UBUUBA3AA8k6vVi5
X-Google-Smtp-Source: AGHT+IHWUMcISonCl9drvS2jmEhhwn4fAf7HZ9o4n7hvvPqc+Mz1WOjc0EGaS5v4hqb+laKgwL6Suw==
X-Received: by 2002:a05:6a21:9988:b0:23d:781f:1516 with SMTP id
 adf61e73a8af0-240551604f0mr1712010637.22.1754618828650; 
 Thu, 07 Aug 2025 19:07:08 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b428ba4cf35sm3705433a12.14.2025.08.07.19.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 19:07:08 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: pierrick.bouvier@linaro.org,
	qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 rowan Hart <rowanbhart@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 0/9] contrib/plugins: uftrace
Date: Thu,  7 Aug 2025 19:06:53 -0700
Message-ID: <20250808020702.410109-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

This plugin generates a binary trace compatible with the excellent uftrace:
https://github.com/namhyung/uftrace

In short, it tracks all function calls performed during execution, based on
frame pointer analysis. A big advantage over "uftrace record" is that it works
in system mode, allowing to trace a full system execution, which was the
original goal. It works as well in user mode, but uftrace itself already does
this. It's implemented for aarch64 and x86_64.

Let's start with concrete examples of the result.

First, in system mode, booting a stack using TF-A + U-boot + Linux:
- Two first stages of boot sequence in Arm Trusted Firmware (EL3 and S-EL1)
https://fileserver.linaro.org/s/kkxBS552W7nYESX/preview
- Stat and open syscalls in kernel
https://fileserver.linaro.org/s/dXe4MfraKg2F476/preview
- Poweroff sequence (from kernel back to firmware, NS-EL2 to EL3)
https://fileserver.linaro.org/s/oR2PtyGKJrqnfRf/preview

Full trace is available here:
https://fileserver.linaro.org/s/WsemLboPEzo24nw/download/aarch64_boot.json.gz
You can download and open it on https://ui.perfetto.dev/ to explore it.

Second, in user mode, tracing qemu-aarch64 (itself) running git --help:
- Loading program and its interpreter
https://fileserver.linaro.org/s/fie8JgX76yyL5cq/preview
- TB creation
https://fileserver.linaro.org/s/GXY6NKMw5EeRCew/preview

Full trace is available here:
https://fileserver.linaro.org/s/N8X8fnZ5yGRZLsT/download/qemu_aarch64_git_help.json.gz

If you had curiosity and now you're ready to give some attention, most of the
details you want to read are included in the documentation patch (final one).

Overhead is around x5-x15, and long traces can be directly filtered with uftrace
if needed.

I hope this plugin can help people trying to understand what happens out of the
user space, and get a better grasp of how firmwares, bootloader, and kernel
interact behind the curtain.

v2
--

- trace active stacks on exit
- do not erase map generated in system_emulation
- add documentation to generate restricted visual traces around specific events
  of execution

v3
--

- fix missing include unistd.h (build failed on MacOS only)

v4
--

- add support for x64

v5
--

- addressed Alex comments
- split plugin implementation in several commits
- removed instruction based timestamps (only use time based timestamps)
- removed sampling implementation

Pierrick Bouvier (9):
  contrib/plugins/uftrace: skeleton file
  contrib/plugins/uftrace: define cpu operations and implement aarch64
  contrib/plugins/uftrace: track callstack
  contrib/plugins/uftrace: implement tracing
  contrib/plugins/uftrace: implement privilege level tracing
  contrib/plugins/uftrace: generate additional files for uftrace
  contrib/plugins/uftrace: implement x64 support
  contrib/plugins/uftrace_symbols.py
  contrib/plugins/uftrace: add documentation

 docs/about/emulation.rst           | 197 +++++++
 contrib/plugins/uftrace.c          | 871 +++++++++++++++++++++++++++++
 contrib/plugins/meson.build        |   3 +-
 contrib/plugins/uftrace_symbols.py | 152 +++++
 4 files changed, 1222 insertions(+), 1 deletion(-)
 create mode 100644 contrib/plugins/uftrace.c
 create mode 100755 contrib/plugins/uftrace_symbols.py

-- 
2.47.2



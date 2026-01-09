Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C3CD232E6
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 06:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6P3-0003VT-KT; Fri, 09 Jan 2026 01:55:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6Oy-0003QB-Vc
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:55:17 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6Ox-0002m7-BO
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:55:16 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7b75e366866so1005898b3a.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767941713; x=1768546513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uDRHkd+Fj9YKUI2LFP9ZVKULMmvqCn3DIrkDY6oyX/Q=;
 b=aZdrR8Idfc2kKd97M0R/dsTBCv4DICxOexEkDKcbKXnRTm54cJF3LwViy9SnFYGL3v
 43EgoyH21w0azFAVqdkum+HsPoBreQX+jrZ+L4FVCefZa8uQbIif844xETM1HaTAE/Ak
 b5p6SefnIgQ9RzJOruf8urQUs563IckxogmhF78byRM0RPIa5RG9gIEDTCI2f3Qxk++o
 vVBSM4PF2vZarMk8JxR/zfliOWdxJQ5DQghn1tGL2D3R/lGCitF53nbgsytGxaq/6Zq7
 NE7sraUVZFWnVG8Dzqti2nGjxA6V3EXV9wXiF1GJIX3hYf0Wm4JwDFaTLW767Ar0Ubjm
 JX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767941713; x=1768546513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uDRHkd+Fj9YKUI2LFP9ZVKULMmvqCn3DIrkDY6oyX/Q=;
 b=HJgPdzjq98XnheMh1TMNNklWJMX4ZFTSiYSN5GP1VjmfBFA+5738Z0IX8AYt5GO/Nv
 CtOjOI1F6dZkL0kvZXRtWQ0myzFvccw16j07i9MdK4HCmctpeGaTm3zsgP7I8r602Sbe
 TmXOp9daVN+oYgG7diyjP2mKrLI9mB2Hs7LdgSYU5Xz67ywwUPjJsbQ8gJ8vfcIIO1ji
 KaoFs3hlZO3v12RxJHneXRwi9xUfIYR1WTpjxwNt4alJqxGEx48viJDBCKSfoN4LYh0Z
 mgd8JvymHOxOK1mhfHemQz2vrD7+Zaohi/UjiZnAFwO5GyhmxiPa3kCuPsw/H9ILCQMu
 DhWQ==
X-Gm-Message-State: AOJu0YwJ6wwXvS3TIWkPJdO0TTOqB8YBcBuCcWqiYb2aPbKRT/ynPx5B
 frAMPX4csdnXPOwfVZM5nkmazFFLbSnRQc4Siqhx3RBf1FNsJTfUvAMrk393bw==
X-Gm-Gg: AY/fxX53zsMZNpM6/BTn7nzSC4WAEuzFiIbOS/HyW6BuhWv6vEGapQRoNHE8fg4Nqo8
 Zb0JW+KzFr9zX0Uiiqybb9oEJlYNiRqF1UFONjHOATdWJtq42DSnwRZBs4gYqd8LYVqiPU3o4f3
 NaspnnLUT0KWAlXjdzfjK/pzHrtuyFm7n6BAkLmqaWJxVmlGDAQquf1OpXDGo0Pz23/ZebkQKI3
 OTYVzHDVLkfEI1SRHtu3iLkAGl9S+uzbpDYqEGxZFUYCpEaICsT9Y2PYDVMZz9sqJFLtuMsfvLT
 K7mRoXAPYTGCcBW01zgP1AC91mPzzSAnhzu1lYlpvPVFY3QeBjIxdS0ZrN9WldHccP0WWxaVzZM
 fhjqkXGNKa59U1EaxxATe5hctgLupwgA/WVhTlU6ZEFg/6P1BfjWijBItsy0qd03tdwjEFUcJP5
 oX8kemmOavgNt6Xj5+Ww/Qqouzb61ukVn2ckZj7m6YVfUFs7vV1XVv3CtvVMLysGE7bNrIMmCO4
 m09I9OXQDAplHap5cM=
X-Google-Smtp-Source: AGHT+IFzMpL8gAYZBYxwsghx7DP2XW4qp1t6mh+FlO+d3PtIaTi70Gi+v8vRr2C4d3Ib9W/9fo+QEQ==
X-Received: by 2002:a05:6a20:4311:b0:366:14af:9bc9 with SMTP id
 adf61e73a8af0-3898f9fa49emr8469625637.63.1767941713450; 
 Thu, 08 Jan 2026 22:55:13 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc02ecfaasm9953644a12.14.2026.01.08.22.55.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:55:12 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nutty Liu <nutty.liu@hotmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 01/34] tests/functional/riscv64/test_sifive_u: Remove unused
 import statement
Date: Fri,  9 Jan 2026 16:54:26 +1000
Message-ID: <20260109065459.19987-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260109065459.19987-1-alistair.francis@wdc.com>
References: <20260109065459.19987-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Thomas Huth <thuth@redhat.com>

skipIfMissingCommands is not used here, remove the import to silence
a pylint warning for this file.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251027112803.54564-1-thuth@redhat.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/functional/riscv64/test_sifive_u.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/functional/riscv64/test_sifive_u.py b/tests/functional/riscv64/test_sifive_u.py
index 358ff0d1f6..847f709da1 100755
--- a/tests/functional/riscv64/test_sifive_u.py
+++ b/tests/functional/riscv64/test_sifive_u.py
@@ -13,7 +13,6 @@
 import os
 
 from qemu_test import Asset, LinuxKernelTest
-from qemu_test import skipIfMissingCommands
 
 
 class SifiveU(LinuxKernelTest):
-- 
2.52.0



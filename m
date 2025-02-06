Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30560C0219B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6Sh-0007eX-31; Thu, 06 Feb 2025 13:18:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg6Sf-0007db-J1
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:18:49 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg6Se-0006p1-2o
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:18:49 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4361e89b6daso8308605e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 10:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738865924; x=1739470724; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2kCJxV5RDHMsyayf2qMyOZN0P1Hh3IgBFGYV/iLdQ4w=;
 b=qrVaVPGTiBatrfOs3RzGVhrsxxeYUmTb5snj4K2NSCZA79yD6nl+dIu2te04L6qQ8p
 CNx3vTRIYd8RMohYP+YcdCbhBaMVEqHmc6n75SUoG4osTkpwVgmcef4BKYAOH+sbMhYd
 WbybmQFtg9/b0AP5ynxMS+7Uwx2ZyRUYcxf+/nzJiwl0Rkys2Z38yIivFOgGt0M7NLL4
 LUOKQMiP0nzINDYze7xni4GGk2vYHGzXNWSpmV9+MMNYsRy+IAzQAOCBr1BO7L24OBdH
 vtSyaKMkoEqiAusem/DuSTIBPu4aLysxHA0DxF9cGuzWLSJUE6mD7D86rbMmZdhp9p7j
 U+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738865924; x=1739470724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2kCJxV5RDHMsyayf2qMyOZN0P1Hh3IgBFGYV/iLdQ4w=;
 b=C+QZtSN2MNZDfzyEG7RMQKPU5d7KwiL4uLikNF1ll9vUrsAgc+FH1HcOBCy3ABEkhu
 tyy6Su7wMIquemG2UXCxYaq5cUCi4OTV6N7QT5cHJhVFGqE+Bn+YTONlGtMgv6d2+BIK
 PEQRQL8kZZ89AqUP7/9BPADHAptKWlexRnjCuQW2kATp+BIP8IG5Pp5/vDHiL3LqdvU4
 +ETJtFcTOQRTapVB3RDWwE9eVD7yTpKO7tnraCu5NO3tgJ5q7lrp1Qd5J5K6uT1fFSnt
 Q07WcvOBWod4WVwTYUALlltTn+Hyc37sWNEXqUYGpzsu0o2EGJpoC3uvBVjq0p1bB6l/
 Ki1A==
X-Gm-Message-State: AOJu0YyjeTcb+iU+/lbh7JFifEkmJ96jjECRZ5iPTExIaW8eL1Su3yFo
 quisztMfVUqSluhH+X49zSIwXjCTww64MNL/wagOPMja7Y2hLkVqXG3yEx8ZPL78sVii0xVT94m
 2Pgo=
X-Gm-Gg: ASbGnct+5/fTJIhemKURUDuZpmc3El/AahtpSwPOP4ACofgHV4mDgJvfYKshPs1XxhA
 37vuJbkym330C514/NqdN3UBSeMU+c81CDGQVucBKIhH2uoDJzAEHEi1vbsXfQGH/22Uq53w4qa
 rY0chcxrLElyAzuXpSeHB6hafCxINgGbHrxI03Wkhws4wZKAmN6CzuLu3zYmyCqUw4wLhG3jQXX
 qP3LSuPdU+msS0EWnMAOqWLaND5upXpRZCBhK+iqGj9wVFIWN+HVbSkQ4yEpxFm7aZ8Mo6LxDDx
 X1/J+akzRB3m4YX39YWJJznfZU74TUO4gINFBrCp+lntGksaDjwLtBbk0/a4LW7oTQ==
X-Google-Smtp-Source: AGHT+IFghyzO0rCCopwEGnUM4JaOIYYuchEWuD5K1/TcR+HM0gPFrlVgwMMB7vKkwi3B+l0gPDNjbg==
X-Received: by 2002:a05:600c:3d0f:b0:434:a10f:c3 with SMTP id
 5b1f17b1804b1-43924984042mr3871135e9.9.1738865924567; 
 Thu, 06 Feb 2025 10:18:44 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dc9ffcdsm26115595e9.15.2025.02.06.10.18.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Feb 2025 10:18:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/7] hw/riscv/opentitan: Include missing
 'exec/address-spaces.h' header
Date: Thu,  6 Feb 2025 19:18:23 +0100
Message-ID: <20250206181827.41557-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206181827.41557-1-philmd@linaro.org>
References: <20250206181827.41557-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



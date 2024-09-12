Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4823AEE644A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socPh-0001I6-No; Thu, 12 Sep 2024 01:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socPd-0001Am-Af
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:39 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socPa-00030Z-Lx
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:36 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-71798661a52so407263b3a.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726119033; x=1726723833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w6UpgoFiKeN8rhCeeJc9Ofq22Ni9JUy4zXN5XGaW1OM=;
 b=F4BzFmiKqWDxhZUDUpV+i2b6FvkRWR+vRXkkXIsgejbOUadY81zBTs6ZldK0nTwisK
 CQj5piW4oihjwrNfULGzPWfWqO4oInNJDzQvV5+KtUWIgIrbTmPNwcz7dulSMtOLRwcu
 aRXurMtbUZP/Nr6oF9vm0dfFK49DgDVLfintyj5vLocOQaalY7/L9xcVZnviqDPLekwh
 iw+F5pdC/OFXCnDXGIe55j6ROxCVlBtP40kkErlK6TEHUEI1zV9mx6Q0BvHtGE9xt+aj
 Ml5J6pQeasU0Q0Rqh4LoDpJWR2bb7nPlrZkxhbor6r/O1YwSByYLPPIwC4wmmChLy6CW
 iFnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119033; x=1726723833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w6UpgoFiKeN8rhCeeJc9Ofq22Ni9JUy4zXN5XGaW1OM=;
 b=TWCSDTuBzoj2kl5jji7eAx/j4NUSzEfxIf31gAistJCZR03yMhXDsp4og/Dn87tWDj
 dAiJqGY3thCgkA6SxFngQiNF26A3gyyF0VRyAlthPEgrj6eRJ27CcH16Mz+FQst4J0jf
 Msu4kM8qRmX6z9rtzNqrXBClPahKa/FrvKMGyi00XVNZ0vXW8CtZ7YdJ2madGpPjWkHJ
 fcRYZnsgnLDLLLtfwhaUMkaGpwXkipUufUjjvhGKa5wd6+Y8FtQs0bOX+inJiOEU/Nke
 nDbcO9mPGAm7FyegWA2gunmt6gkyGG6hK/yah80qUUvUwAqb2hLh6WiIn4XGf15Typuq
 Iqow==
X-Gm-Message-State: AOJu0Yxx+Dm583DY0JgIStWSvyOlCvUywmWeDIUZkTd32DA42Xvmoplr
 shpYcluF83UEJsUZPuxbQGhXULmWS81UAsFC2YNeoVzocsDfUtEL1m0fyg==
X-Google-Smtp-Source: AGHT+IG+nsL9jDo7QpCt5svL9WkhA3cNcUrR3X2kL4n5NQ4w9dSQva4SR3emVNUpcaFYdGE6A1wAfw==
X-Received: by 2002:a05:6a00:8805:b0:717:9340:a9d0 with SMTP id
 d2e1a72fcca58-71907eb816bmr11989839b3a.6.1726119033132; 
 Wed, 11 Sep 2024 22:30:33 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8fdesm3833034b3a.1.2024.09.11.22.30.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:30:32 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Milan=20P=2E=20Stani=C4=87?= <mps@arvanta.net>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 11/47] util/util/cpuinfo-riscv.c: fix riscv64 build on musl libc
Date: Thu, 12 Sep 2024 15:29:16 +1000
Message-ID: <20240912052953.2552501-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912052953.2552501-1-alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x430.google.com
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

From: Milan P. Stanić <mps@arvanta.net>

build fails on musl libc (alpine linux) with this error:

../util/cpuinfo-riscv.c: In function 'cpuinfo_init':
../util/cpuinfo-riscv.c:63:21: error: '__NR_riscv_hwprobe' undeclared (first use in this function); did you mean 'riscv_hwprobe'?
   63 |         if (syscall(__NR_riscv_hwprobe, &pair, 1, 0, NULL, 0) == 0
      |                     ^~~~~~~~~~~~~~~~~~
      |                     riscv_hwprobe
../util/cpuinfo-riscv.c:63:21: note: each undeclared identifier is reported only once for each function it appears in
ninja: subcommand failed

add '#include "asm/unistd.h"' to util/cpuinfo-riscv.c fixes build

Signed-off-by: Milan P. Stanić <mps@arvanta.net>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240905150702.2484-1-mps@arvanta.net>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 util/cpuinfo-riscv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/util/cpuinfo-riscv.c b/util/cpuinfo-riscv.c
index 497ce12680..8cacc67645 100644
--- a/util/cpuinfo-riscv.c
+++ b/util/cpuinfo-riscv.c
@@ -9,6 +9,7 @@
 #ifdef CONFIG_ASM_HWPROBE_H
 #include <asm/hwprobe.h>
 #include <sys/syscall.h>
+#include <asm/unistd.h>
 #endif
 
 unsigned cpuinfo;
-- 
2.46.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8644AC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 02:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi1PL-0007Tu-SD; Thu, 09 Jul 2026 22:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1PI-0007Qr-Sq
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:56:04 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wi1PH-0008MX-Ec
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 22:56:04 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-84867f07d63so447734b3a.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 19:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783652162; x=1784256962; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PZOS9wr0YeRnsq3Q/TO63AlK4WPz+t+ZzPbZ9ZWHPdg=;
 b=QMYSNxIOfsYQFeiX4vNeKqHDao6MDKaUQw1gUrO2LqON14+8yZjRiOhGczNOXU6lIY
 THZ+kjO3GxWXTNcWo+VWj9mxTGoPuwCdBo36gt3sAWImH44FpqQWpn6FuxKJIdUY+jPQ
 mPoXMqfbJNzSPe2bpKJBIZe0NJ/c01TQg4BqzE1yaVvUMQ/a1b/TKtPZgoj5BUln8Gg0
 ++YopgvvaB1eAid4F6zKyhR3bOY04GzAX2B3SWaxcsSAhdayevsCN7S6X9lpAavZzJQ7
 Fz026aaRNFg4lMJEqgLsgqITaskjIkn1TGza4ROhX+OibQ6ctqnhKSdlthlH4c46PCWS
 k6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783652162; x=1784256962;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PZOS9wr0YeRnsq3Q/TO63AlK4WPz+t+ZzPbZ9ZWHPdg=;
 b=jdqiCdH1EVYFaaxlIgfGe1Jqk/OWVJpJ8gOw86KruSpQbbyHdRFbIiRdKJFDssRAh7
 phlu/eEZIKCwaUlEat2k11K5MZgh5hsMvaxpcTnyIj6bLcuZKJq+OiA0MSLQ0OxnNXw1
 wawGGkTSbR4w+iqpd4dJuKI5qd7Mub2DvKE4hmU0qX5EeJ1X1IrZV42q7llFsyzJ8vOf
 vBuV7VXlz/oASQi1IeGPRNuvTWECycdlcz4OuNdyZkvx++jiVAnj/m8xHsB0u0L41sBT
 kco7Je1FQL8YjQIahhg0VnBm8jcy5ij/8t7cLS3cDTTptQgkaOcNr1hJbPlY8HaewRza
 g75Q==
X-Gm-Message-State: AOJu0Yyc2YE3atVU3+ycNzcklrj6LkHWEC+EvYaiDhecNcnEa6o503XD
 zF7cuRh6yVp47Og4rh8CltJQYmJUiUh2+eFwcIse2PmCENOYbHo614Gtv4vJ5Q==
X-Gm-Gg: AfdE7ckdzn3fz23O5AL+YCdRK98yZvEhk7SomQXz2GPrzE3JrPI2AcG9zgeEcZVVjul
 lPTWlU9jV9nGpAzvgyedqTnny/8TXlKozDPWsq3rqXGDRPFK07CiHeAexf7uKr+8zg5p00r6x/n
 totssjSligwCLBrCCxNv8qWHUJjlEfryeLRgLQx51UfktAGfnKlRzqOsfXHyV28ZddFez5P1qZQ
 6Eo9oQ/hN0bJx/ZZ6yFdKr2RBYF++TxrNiVI2pAbh8Qn5gqmlRidFjKs9N+LFaYfizMb+Q2nftL
 4MNwLlpPdrsEQ7nI8vfB1VJdLwhT8EfkhUj8sllV+dVSqsI8w8pzkDplx9Udcq1hKqNvUX4txb7
 fC//aET3LDCph2MD8FiKP0TRHPqO9zOi25rFgJHJZ+WwT0/SJz8Gov0utbJpczob5m79bkNthsU
 yZJw7jCFPA5P+c6IX9XHMkYoRa2gHiIBzpc4rZl0luyw==
X-Received: by 2002:a05:6a00:3d0a:b0:847:99bb:b6d8 with SMTP id
 d2e1a72fcca58-8484302e490mr9823736b3a.26.1783652161892; 
 Thu, 09 Jul 2026 19:56:01 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5af6e04fcsm4576769a12.4.2026.07.09.19.55.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 19:56:01 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Zephyr Li <fritchleybohrer@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PULL 07/40] target/riscv: Remove unused tcg/tcg.h include
Date: Fri, 10 Jul 2026 12:54:52 +1000
Message-ID: <20260710025525.1704417-8-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260710025525.1704417-1-alistair.francis@wdc.com>
References: <20260710025525.1704417-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x436.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Zephyr Li <fritchleybohrer@gmail.com>

Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Message-ID: <20260703180538.3346781-2-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4d2eb281bf..7664e686fa 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -38,7 +38,6 @@
 #include "system/tcg.h"
 #include "kvm/kvm_riscv.h"
 #include "tcg/tcg-cpu.h"
-#include "tcg/tcg.h"
 #if !defined(CONFIG_USER_ONLY)
 #include "target/riscv/debug.h"
 #endif
-- 
2.54.0



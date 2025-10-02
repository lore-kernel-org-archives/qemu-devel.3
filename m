Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B086ACAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 15:00:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Klk-0007TL-Bc; Thu, 02 Oct 2025 10:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4Klh-0007SQ-O9
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 10:58:53 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4KlH-0000SB-Ip
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 10:58:53 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-42557c5cedcso668320f8f.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 07:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759417093; x=1760021893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F7o+nv06XBHGB51yxt1OEKJBgV9gHbisZFhpgcb1BqQ=;
 b=ILNAH/N+eJ89W46LJ28mzXRPxBkiTvXQehJSLabJj5HB8cvGREYVBhvBh0w+KekHnw
 atQCJvwjLiqXxgrdRdhZ9PnslbbIkS482Eph/aYSyOG/idDCRTj3gQLfLXan0guX2ymf
 yQK+N1va+aGRuKEuYWoVGxvY4K4CbsrM2ah/jYG0Wpwf5WXUcdP5Z13pSy6XfceerhbL
 ZcCuyFVhEczLY7Gv5riRB88ZVdjlWZaeslnCBaBiEQJTgWJej2lPVhWIZ4qM6WHqsWOv
 IUvDcXlHp0g3e8XcA9UmbBFC8hiaSF7j0Jc+uWZTB+4Uq2aQDnNq43t1OJxWDoZ2brL4
 PbTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759417093; x=1760021893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F7o+nv06XBHGB51yxt1OEKJBgV9gHbisZFhpgcb1BqQ=;
 b=P90LXRK7IBlxpi4sk9KwC+TS8uLjhyRjakO7Lglh+Sofv6h7J5/SihFRUtw7wJ2UPX
 hFh8IohxVR1RD3c2NO+ATvg2IHeC4yZSINI3LdD3natc/gU+3wwM+JgsvRxxx0pJhqLd
 +RCw8hCbvzdevE8G2yCF3V3fEuzGWTzWhePofWtJJUmmCEUImHsBvLX2cOH4FnbeVJeT
 a8hzzpLqcSMon185bp/QsbCZ844g9jhrnY2uWfrsSxBmNYBbM3W9KkiPaRNYKEzIauwj
 eUSKuQZx0U3RYn+ybBtjeUGLVtftTaZB1PPS9anR3l9XAxIDsW++avwAAAD2R8n4hgsh
 fxKg==
X-Gm-Message-State: AOJu0YzEQ+1iXhdkiqeoesfyfZgcl3EZESwqtlqie8+d8+sNa0ISJ/Sf
 yI0flQoZ63ao99nUlzeJScx7P3e7xqvLnpXduy6dkWThEfGwcdy82JdIhUSFT8vBu5idNgcD247
 IbyWts4AQeQ==
X-Gm-Gg: ASbGncslO1pnGmobGfC1SDdFzXIo4broTELGXMd0/J90HHJLgt5bN4FeKnjG5kkFkF8
 V34p2F5MZCRWY0a2/i89DI8AIjeDjeiOQWleP3ajwmubTAgrb/uqhOJAA9ODoKw8w2PULQwKgsg
 Wu3vcfEazwOyVRTylPRDUUHeRuP5shXKlR6Awl/MV5cSZQlesuRwMX3EmeM3kCO6d0joVIM9rR+
 ifbR9g0069SIPpnwRjn+Cr0iI7LwV7nJvho4w8BZAlgHC3eTcelJQ3QBSSF/Xkm8Q1sI9TKuwhC
 gGjBwQklzzRdE+LQBs6rlqAX5m0N1EelVNIpwXobuuEBvwxMt1qu6tO30tWGZeXnLzQYHsAwOUK
 K1uuyP4ARK0lAtR9OzJKSmVvDBfFZb/mCWsbX7fJpBV7WHQFbI/Qsi8ubCgjH4XDzvYRKEk4CHd
 IlmbgNgy4fFtJ7kR/7OlObVQNp
X-Google-Smtp-Source: AGHT+IGgcSiU0b9GBRqG6rfyaSqarD8ZqVsR1xf3ArEYrltLFBpTzsVHviFtOEZ6iKGZLx6xGRRuDw==
X-Received: by 2002:a05:6000:2c10:b0:3e9:ee54:af54 with SMTP id
 ffacd0b85a97d-425577f51f7mr5180357f8f.21.1759417093270; 
 Thu, 02 Oct 2025 07:58:13 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e6b23d4c5sm30631055e9.17.2025.10.02.07.58.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Oct 2025 07:58:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/6] target/sparc: Reduce inclusions of 'exec/cpu-common.h'
Date: Thu,  2 Oct 2025 16:57:41 +0200
Message-ID: <20251002145742.75624-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002145742.75624-1-philmd@linaro.org>
References: <20251002145742.75624-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Only 2 files require declarations from "exec/cpu-common.h".
Include it there once, instead than polluting all files
including "cpu.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/cpu.h          | 1 -
 target/sparc/helper.c       | 1 +
 target/sparc/int64_helper.c | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 31cb3d97eb1..7169a502432 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -3,7 +3,6 @@
 
 #include "qemu/bswap.h"
 #include "cpu-qom.h"
-#include "exec/cpu-common.h"
 #include "exec/cpu-defs.h"
 #include "exec/cpu-interrupt.h"
 #include "qemu/cpu-float.h"
diff --git a/target/sparc/helper.c b/target/sparc/helper.c
index 9163b9d46ad..c5d88de37c9 100644
--- a/target/sparc/helper.c
+++ b/target/sparc/helper.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "qemu/timer.h"
 #include "qemu/host-utils.h"
+#include "exec/cpu-common.h"
 #include "exec/helper-proto.h"
 
 void cpu_raise_exception_ra(CPUSPARCState *env, int tt, uintptr_t ra)
diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index 23adda4cad7..96ef81c26cd 100644
--- a/target/sparc/int64_helper.c
+++ b/target/sparc/int64_helper.c
@@ -20,6 +20,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "cpu.h"
+#include "exec/cpu-common.h"
 #include "exec/helper-proto.h"
 #include "exec/log.h"
 #include "trace.h"
-- 
2.51.0



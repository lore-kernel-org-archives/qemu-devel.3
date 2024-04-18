Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A889AC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 19:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxXSj-0001Qc-IP; Thu, 18 Apr 2024 15:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXQQ-0001a2-1H
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:28:04 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXQM-0007h7-Nc
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:28:01 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a51a80b190bso68952166b.3
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 12:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713468476; x=1714073276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/V78U8y8hgVchZketDvNFCqr9+uicpA2z97iCqadZGc=;
 b=wyC/eYyoz//UopNQW2IrLAYje4uYdyEW4RD1c5JxS/M+q4Z/a6vNGDtKPhOveYFsi8
 qx+GSFHAhWtRkLfrGLZ/bnJ7wy7w25mLuhzEITbI5BUeW3qrfM8fZGZfyzmO/zeayZxk
 nof+a9Z5wYD9DKupd8gVsfekXI0VYQV6fIrdUYS+iMmU1UfrF0wBDd2+j11Tk1C34hMt
 nObOA4Gyik2MHqb1FB1MYwEsrbgAlrtUoS/7NSHIwcNaMDm9ptbVa6hee9ODAubCRmYk
 EohyjTKSautlagCgDNeKLAQNFKzNfKkS/66Vt+OncqQzEoBXIvTbmbxyMTutYy+I0byO
 WFkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713468476; x=1714073276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/V78U8y8hgVchZketDvNFCqr9+uicpA2z97iCqadZGc=;
 b=UASLTnmVnZyIrpXa/CYUwRIRM8nAuOC9Nt9IW56kAgvtRV9pEpPmT0tz339yoPwVJl
 c62fB9N3qGNtNtm1plxnGBgVOb59Fi67f9IqpLweev+g/pF/SYzbsCBimI6RlbF/IoyM
 qi9UlO0phm238NTpeL/nJrHeVun976cS7SYES4aBYIh1aHwnfZvkwu95S4g0+OXAp9J3
 KHYw4KfAl0Nsx01YQzEZukHuMTqEk1PQEe7DEtbSP54o1eAk3S/6X6etCrPCWcaIfhy7
 v5zBV0WPmUxIBsCVdCNXqV7A5jqn9zIjjl+yvjw6CpisWfC0ACO1VmsjaLA4vzyOg/rM
 FrcQ==
X-Gm-Message-State: AOJu0YwmvFfysrlHTyV2OD7O3fflU7Qu7RXnY629M9bhq+zIOdLDWgtR
 tzqO/azwcqAnDw3yb2QHEV9dqTs/UyjDnuWGat2TVDz07AQcBo0Sp8udhuhXflYUnTX5HBZ/aKN
 h
X-Google-Smtp-Source: AGHT+IHrcqo2UHAx8u+9jCAFEincYHzZAP1Wb8pNWMNf4c7FJye8uQUKnPM8ZPTzpZx3xyIVm80lkw==
X-Received: by 2002:a50:cd1d:0:b0:56e:d54:6d63 with SMTP id
 z29-20020a50cd1d000000b0056e0d546d63mr104698edi.15.1713468476332; 
 Thu, 18 Apr 2024 12:27:56 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.151.213])
 by smtp.gmail.com with ESMTPSA id
 fe7-20020a056402390700b00571c16323b4sm736740edb.48.2024.04.18.12.27.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Apr 2024 12:27:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: [PATCH 19/24] gdbstub: Avoid including 'cpu.h' in 'gdbstub/helpers.h'
Date: Thu, 18 Apr 2024 21:25:18 +0200
Message-ID: <20240418192525.97451-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240418192525.97451-1-philmd@linaro.org>
References: <20240418192525.97451-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

We only need the "exec/tswap.h" and "cpu-param.h" headers.
Only include "cpu.h" in the target gdbstub.c source files.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/gdbstub/helpers.h | 3 ++-
 target/avr/gdbstub.c      | 1 +
 target/tricore/gdbstub.c  | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/gdbstub/helpers.h b/include/gdbstub/helpers.h
index 6277a858a1..26140ef1ac 100644
--- a/include/gdbstub/helpers.h
+++ b/include/gdbstub/helpers.h
@@ -16,7 +16,8 @@
 #error "gdbstub helpers should only be included by target specific code"
 #endif
 
-#include "cpu.h"
+#include "exec/tswap.h"
+#include "cpu-param.h"
 
 /*
  * The GDB remote protocol transfers values in target byte order. As
diff --git a/target/avr/gdbstub.c b/target/avr/gdbstub.c
index 2eeee2bf4e..d6d3c1479b 100644
--- a/target/avr/gdbstub.c
+++ b/target/avr/gdbstub.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "gdbstub/helpers.h"
+#include "cpu.h"
 
 int avr_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
diff --git a/target/tricore/gdbstub.c b/target/tricore/gdbstub.c
index f9309c5e27..29a70051ff 100644
--- a/target/tricore/gdbstub.c
+++ b/target/tricore/gdbstub.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "gdbstub/helpers.h"
+#include "cpu.h"
 
 
 #define LCX_REGNUM         32
-- 
2.41.0



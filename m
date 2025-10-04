Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E33CAC5B0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wT6-0004zg-RR; Sat, 04 Oct 2025 03:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wT4-0004sO-8i
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:14:10 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wSu-0004zL-6e
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:14:10 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3f0ae439b56so1937915f8f.3
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562037; x=1760166837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gzuwMCz9UPXzqhkXzAOKf8DdtJjfzgyRW8DD8ME/+70=;
 b=wVP+ZXsYVyeUXkQxThXCqXBX4P4Jonkad0WQV0dM+BfSl4sVCyzE6HZISW3NDFtlxW
 HarOGMzpPpvkbeEVra5oi1ZxZHXWYEiIQwZwC6CX1x/Clqsu+T/cAwXMjnrDZxYxdiDN
 gDnJIhPo8lxyYd/n8llJeGBvwTyXzz++hiQZzWnv2JA0AJNjyNdQhO0Y/sDwQiKXO4Sb
 a60X/3gsZ7ln5GciMQAHaqyZmRXymw/zHZEPtK9fg/hjW+lWPaexm9El7cqpZdIxp/E9
 Og5C+vMmfDOr7lRqZRci9OAyT+UtiDJMAPSt7/0CV9gYOf8JBiUZcYWr+U/chUfRQWRO
 2rag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562037; x=1760166837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gzuwMCz9UPXzqhkXzAOKf8DdtJjfzgyRW8DD8ME/+70=;
 b=FnVFguB2XSpPj0Pb/VyM6tGax+MFXOgxW8F6hae7QsCRBvamB2niWZ8j0QqV4gJTiF
 a+keWrX0+Iupkt7GzbX312vNaHNpRLzG/+VqqK7hU7EpmCdQkW1c44GEAjwiptoFd7jU
 ljObgFtJXuf/dY4ApDxufl4Mg0p9BTk1zP/aeMhcm3kWzUtGyiqW2rChqbw8QI/rQYKd
 9cY+Ix0zyBY3Aadw01RKMNrLCB8xvvoNToiyqk/XlYNP4CKIUccq1D8hIZTttvH17cdP
 sSG/PgF+09bBGjaeFwLlDwQ/wqpfgzV1WTSpHHR4FuFjBWK+nkbrlvb/WVPYv2bc5m3e
 7Z5A==
X-Gm-Message-State: AOJu0YxCYaBog/Kv8/OXdzQhS+lRryCishwyD2FToy0tYFdcytyk7y6Y
 zMBLuMfQZP79rYXNzrB2hl2djbnokNIv6jsnKXJTeMaqaeek7I9Nyj65xeM3rU4BFasrRQowbxE
 67Wy50b5ocw==
X-Gm-Gg: ASbGncshLXssLGz/Di+nSyDPovBAGO+ocwWdEtE+QNY7hmqIHQscivsCbKZIu62o1Vr
 BIgwJU6xtKmSUHza4fk2HL2IIQ0/4MovWiaIak+Ehz7ygpXFGDRQ6WZvHkm0+e0xjSkyCLfZx+/
 zRyG6K2qih/1jitcFnkNS+rItZzu/uWVtvTQj67lpIRPuL+tz9H0urgIOdnNMdWiztNmOfbm+0n
 D4m8fgRV/YrNOTwSsOhRqyeEyME5dGbsz4urh/JiyeI1v/3k/JgTNBmNDNoTWS/rTLHzRw7m6CA
 VnJjJtP+Yhk4a4gVlIkie3+QZxeCTt9qPNVeYeZrskGXLORLJL+V4LSHnepqjSXsndtVksLBxsy
 PWm9P38C/liYgrbClRi6OI2CGb1qLRsObGVjUjv2CNwlMhFv9RgyCG8TypwLGoBNyDd2+NrUuAR
 0EwWSMobTLdXIZHsfti0zLm70PjXZ6yufME2k=
X-Google-Smtp-Source: AGHT+IG1M7b0I4mzL1R+LBZ9HUi25J+zcFNUdAZFTUJSQe/OSQxuw3SlZujO9eE/hoYsuqOQWOGFPg==
X-Received: by 2002:a05:6000:240c:b0:3f3:ba4:29d7 with SMTP id
 ffacd0b85a97d-425671c706bmr3450198f8f.43.1759562036941; 
 Sat, 04 Oct 2025 00:13:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f0853sm11365036f8f.50.2025.10.04.00.13.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:13:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/41] hw/s390x/sclp: Use address_space_memory_is_io() in
 sclp_service_call()
Date: Sat,  4 Oct 2025 09:12:36 +0200
Message-ID: <20251004071307.37521-11-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

When cpu_address_space_init() isn't called during vCPU creation,
its single address space is the global &address_space_memory.

As s390x boards don't call cpu_address_space_init(), cpu->as
points to &address_space_memory.

We can then replace cpu_physical_memory_is_io() by the semantically
equivalent address_space_memory_is_io() call.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Message-Id: <20251002084203.63899-5-philmd@linaro.org>
---
 hw/s390x/sclp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 9718564fa42..16057356b11 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -16,6 +16,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "hw/boards.h"
+#include "system/memory.h"
 #include "hw/s390x/sclp.h"
 #include "hw/s390x/event-facility.h"
 #include "hw/s390x/s390-pci-bus.h"
@@ -308,7 +309,7 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
     if (env->psw.mask & PSW_MASK_PSTATE) {
         return -PGM_PRIVILEGED;
     }
-    if (cpu_physical_memory_is_io(sccb)) {
+    if (address_space_is_io(CPU(cpu)->as, sccb)) {
         return -PGM_ADDRESSING;
     }
     if ((sccb & ~0x1fffUL) == 0 || (sccb & ~0x1fffUL) == env->psa
-- 
2.51.0



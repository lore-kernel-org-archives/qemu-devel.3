Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B36C49EA1
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 13:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbJh0-0003WL-Aj; Tue, 06 Aug 2024 08:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJgy-00038p-A0
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:53:32 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJgw-00005n-E4
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:53:31 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2f15790b472so7239011fa.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 05:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722948808; x=1723553608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0bpORwStJfo7fInBvcfsQRF1HWEiefExBVhtYwf29qI=;
 b=zxu9xYWR2rxrtW0ea5/o4cZkZJK77btRG+PCWsl2niA9KInqrALOrqrS+YZ+Jyg902
 X3lI/tgMo0YdoiNJ/HTwas3tfpQZnyKDbF4vo2WpTJ2o6m+fnPOW6PZOSPGks2Iw2Sp/
 B1bZ4ouoLxs9df7uHgIUxT6SPqP60wO+0nMn80ohYYBHdx9EIfPjtwtW2IVbGtubdxFS
 1BwvXitFuFhJIJisznYgnNur0iBdAsr7HAeSwBY6w+5UhhWZhZ6mBotnNs6BCOfT8MLb
 VyEkK2AifAh63SGFi1ZoPP1ZTO5J7hO6MH/edK1O0QB795rRRhn5vXBWnDJqBph9JZzM
 8sfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722948808; x=1723553608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0bpORwStJfo7fInBvcfsQRF1HWEiefExBVhtYwf29qI=;
 b=nvixDsXTk3jsoIQ5VtGHWG3QJw++9u3gLJJYrnQnTPhLgbdzanXnD9NbsGHd8/6442
 xFWMJqLbY2HY30/CIR4+bvpF5wfeXK5jNSPo89ve3WWjNfo2l71vEeHlwKMvgIwHN+4Z
 7HYLQk5RRvcjsNYgAInA3xJ7O1eccuxyWoq0Tk4qZZPCYXiRGzF4yQQfQ1yVpQFcV32C
 ihpc1Q8M0epgZCsQ08WgxyS+22bpo3cspeR/eQ0CEkHl2vW2aoyUaugSaLz949A55ybk
 zVzITGzSIz1fBbdI5EVWg6DIiyIZsJogff/5AwHsbhUzQBxgRVHm2X1NKh4S3ADwH2Gm
 PtKQ==
X-Gm-Message-State: AOJu0YwW+FXvyzFlqHtNyN5RqRMeXwWwXxmMNbOsKmCl0E6EvfN3iFk9
 G0AQhYfvwtEEThatHI+LPGNgJN3ugvYDjw8kilvWgRfVoXm07afZ5WKhWo8vMvmDMstJrG3bmnY
 3
X-Google-Smtp-Source: AGHT+IFjuF1V/aDmiKY4t9ahw7IjFocwRoXWQvTiR7zA28KAoYtvKKgH/MGIa5QVn7g5xXHttQ64mw==
X-Received: by 2002:a2e:9dc8:0:b0:2ef:28ee:944 with SMTP id
 38308e7fff4ca-2f15ab37fe2mr88881071fa.45.1722948808163; 
 Tue, 06 Aug 2024 05:53:28 -0700 (PDT)
Received: from m1x-phil.lan (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bb9b99f19fsm205716a12.92.2024.08.06.05.53.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Aug 2024 05:53:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 14/28] hw/intc/loongson_ipi: Restrict to MIPS
Date: Tue,  6 Aug 2024 14:51:42 +0200
Message-ID: <20240806125157.91185-15-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240806125157.91185-1-philmd@linaro.org>
References: <20240806125157.91185-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22c.google.com
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

From: Bibo Mao <maobibo@loongson.cn>

Now than LoongArch target can use the TYPE_LOONGARCH_IPI
model, restrict TYPE_LOONGSON_IPI to MIPS.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
[PMD: Extracted from bigger commit, added commit description]
Co-Developed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Tested-by: Bibo Mao <maobibo@loongson.cn>
Acked-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-Id: <20240805180622.21001-15-philmd@linaro.org>
---
 MAINTAINERS            |  2 --
 hw/intc/loongson_ipi.c | 14 --------------
 2 files changed, 16 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5ca701cf0c..74a85360fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1251,10 +1251,8 @@ F: hw/loongarch/
 F: include/hw/loongarch/virt.h
 F: include/hw/intc/loongarch_*.h
 F: include/hw/intc/loongson_ipi_common.h
-F: include/hw/intc/loongson_ipi.h
 F: hw/intc/loongarch_*.c
 F: hw/intc/loongson_ipi_common.c
-F: hw/intc/loongson_ipi.c
 F: include/hw/pci-host/ls7a.h
 F: hw/rtc/ls7a_rtc.c
 F: gdb-xml/loongarch*.xml
diff --git a/hw/intc/loongson_ipi.c b/hw/intc/loongson_ipi.c
index 0b88ae3230..8382ceca67 100644
--- a/hw/intc/loongson_ipi.c
+++ b/hw/intc/loongson_ipi.c
@@ -16,22 +16,9 @@
 #include "exec/address-spaces.h"
 #include "exec/memory.h"
 #include "migration/vmstate.h"
-#ifdef TARGET_LOONGARCH64
-#include "target/loongarch/cpu.h"
-#endif
-#ifdef TARGET_MIPS
 #include "target/mips/cpu.h"
-#endif
 #include "trace.h"
 
-#ifdef TARGET_LOONGARCH64
-static AddressSpace *get_iocsr_as(CPUState *cpu)
-{
-    return LOONGARCH_CPU(cpu)->env.address_space_iocsr;
-}
-#endif
-
-#ifdef TARGET_MIPS
 static AddressSpace *get_iocsr_as(CPUState *cpu)
 {
     if (ase_lcsr_available(&MIPS_CPU(cpu)->env)) {
@@ -40,7 +27,6 @@ static AddressSpace *get_iocsr_as(CPUState *cpu)
 
     return NULL;
 }
-#endif
 
 static const MemoryRegionOps loongson_ipi_core_ops = {
     .read_with_attrs = loongson_ipi_core_readl,
-- 
2.45.2



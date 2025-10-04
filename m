Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BD4CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:15:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wTV-0006RT-Ky; Sat, 04 Oct 2025 03:14:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wTT-0006HR-9H
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:14:35 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wTR-00052b-B3
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:14:35 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3ecdf2b1751so1997654f8f.0
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562071; x=1760166871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0kgkeNSbexpqE32C2+AIWeJJKfc6wQvy2E/aVDskl8g=;
 b=x/EJD1qCSiMg68wP1kTiN7sYv+mQW6wbQCLqunBLt8v/4BEuUhHX64iyAgEMVsc2NJ
 eOIyPx9saj/UjOzJ2IIOtQ5t8aDFJkyh4gkbuwcOQSmcJUMQnC42rzSeIo6lN4MZIb6f
 6K+Ld1eM8SlqXqflSYdFYgsLV5yZ/R+jKFiyY/wj4xC9gGZbzO2Q038lNMv6ZUdR42ZL
 466TqW3I01gTbY8GwdJqgLLUN0m5w2jUsVcX40+ZZg/vVM2bsmDoKt3HGnAcwrstHRTe
 jD9WIze6ytJ28J5fv9JQ2pk3p8DBPXzpIYJokAlFvKzmexZwT+zLuMep9RZONrgSAZGC
 Fesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562071; x=1760166871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0kgkeNSbexpqE32C2+AIWeJJKfc6wQvy2E/aVDskl8g=;
 b=ckbqQnaoWWS9BzyfVk5PfIU+6TXg612IrYCOMUUbwZ4S8F4nT63FhDyHqX1NjeQEJG
 2aT47RNp7JRIMDvMCVx1/OnyNS7vxyV/YCGoEJioDoKHi5Dy/DGb/uR00a1DK8P8hlg/
 USy+Tue1zZDfIOqpWg02b1Rwm/gD2MZu+qbHQADhqQx8Zci28T9MJ7qWCgnFIKjW6bfu
 YIwWmhzWFYzpMl6oTmAhe7f3qVXiKjeV57eH+iySZ1Beko0hrb8h52Ldm8vzhY8RS7kV
 dtR1N92gOvrEWoWoSN/AJuihv7mhzmiLmTheQHUiy0RegBu7PVcQkDRV5JATfdWmqNM2
 Fyqw==
X-Gm-Message-State: AOJu0Yx/VzNMAFowEucKv1r6JVFgADWImdvXGFLN3ahRgaRXfgsONcSC
 95stmfsS2NMZGbYNojnXuVHoTghUbk544Wo63pSvao1vvZE0T1ZBpI9qQmBvMlbQgJiWYROsKc2
 nNP32+8Yiow==
X-Gm-Gg: ASbGncvfIwcuhZ4r+bDRv0uvu6s5mku4Ekwi6oc3jAKXCjYYClU0d4VkTYMM41CVail
 rlJzKvm5ajFxru8OGUQkE+i8OKuysN7I3ETDvrjnp8EZfSgElrR7roXnptW063wECXgpWWBBYLn
 CQ4PXPqGimYHnl7ks0LUP3qyi8pgazgmVkwrQ906dvSvBxDrI54i0LZ8WrpArwuE95omusuftFz
 WIeMrsR0OSRIPm7h8x2zuTTGPEskjBNdzWqydHq9G+h6v29yA5B3euYXeLaipgbqJOs6dAhWgcT
 5rznaSRESN7OoipCJa4XgYt7tlH7ziItGL/HmxVarq/qjuTQLhiuJuV75kVev9OhYEtdrIgkCc5
 o1fVfmjniVMbgtWfsENwLwqOBR22yIdO/wj81xOSDNIvGK/Rr00YjisZY6e8zsqOXk7BvSOQvUw
 G+Scdv2FxQRUaHzVNmSnSNHPZd
X-Google-Smtp-Source: AGHT+IFtvvDurfbWk7f0Kuq4Xfw+WZSEHe+30dhck2dvQPDcfuW5PmQo86TJNgQ60ZZJ8NCRlm/9Pw==
X-Received: by 2002:a5d:64e7:0:b0:3ff:d5c5:6b01 with SMTP id
 ffacd0b85a97d-42567135191mr3171373f8f.19.1759562070812; 
 Sat, 04 Oct 2025 00:14:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e96e0sm11088717f8f.33.2025.10.04.00.14.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:14:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/41] target/i386/nvmm: Inline cpu_physical_memory_rw() in
 nvmm_mem_callback
Date: Sat,  4 Oct 2025 09:12:43 +0200
Message-ID: <20251004071307.37521-18-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251002084203.63899-12-philmd@linaro.org>
---
 target/i386/nvmm/nvmm-all.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index ed424251673..2e442baf4b7 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -15,6 +15,7 @@
 #include "accel/accel-ops.h"
 #include "system/nvmm.h"
 #include "system/cpus.h"
+#include "system/memory.h"
 #include "system/runstate.h"
 #include "qemu/main-loop.h"
 #include "qemu/error-report.h"
@@ -516,7 +517,9 @@ nvmm_io_callback(struct nvmm_io *io)
 static void
 nvmm_mem_callback(struct nvmm_mem *mem)
 {
-    cpu_physical_memory_rw(mem->gpa, mem->data, mem->size, mem->write);
+    /* TODO: Get CPUState via mem->vcpu? */
+    address_space_rw(&address_space_memory, mem->gpa, MEMTXATTRS_UNSPECIFIED,
+                     mem->data, mem->size, mem->write);
 
     /* Needed, otherwise infinite loop. */
     current_cpu->vcpu_dirty = false;
-- 
2.51.0



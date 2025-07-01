Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8628C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcHf-0003Z0-4w; Tue, 01 Jul 2025 10:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcH0-0000Rv-Gi
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:47:53 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcGw-0007cX-Ql
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:47:49 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4531e146a24so34804915e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751381261; x=1751986061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nMdd+VHT7c/KqXfja/LU6rK589jx7m50zPUZczlHAAk=;
 b=lPoC6r85PNyJY0IfRqzA954yANZ/DNa681+LGVdP0a+07hAgKx0EXt1UXNWU/myjzu
 xF0Gjr6LAzV0sUHEmE3ImLugugthIyE7rNQZe9Yin2VW9v0UP6adREHjmMoOlFD6pKnc
 lfFn5EnH8KIMy+MCOUjtL1e2mPdOEmhTUt/pQfpE0MyAEKdGHGuokm/kf9y/WWDYeJau
 zPbpQneSIZb0cGForiMW8+Xk01TX+OJvPgEo7lp689X8wsiALoBoelFM8ZGTr9CgVnYr
 ahC7Op/KEiOS2viqdm3vY7a7NUrZrPMjgfWKAs0xYtGewJO11nyBMD6aJSowLTpLctgV
 EZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381261; x=1751986061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nMdd+VHT7c/KqXfja/LU6rK589jx7m50zPUZczlHAAk=;
 b=c19QhKjJFM5IwNt44GPH7Iz8xisAHZMlCn8AJRph6iLUCkfikVOwGm7QG/NVFzO2Es
 Iyoj1H09AIDPCE2HMhWPua9tUTiPq3jCzU+2xMvs6isAzdXP5FP48SVXsQL1iV9EWE7e
 g0wWeFb0LmYD5mWDlA+ySMHU8V9mm70TemagCOCDV4CHQFk6vjjMeHtQ+pgi0a8WhkRv
 lO49pircFnMdg81AtIJLJZw7+vs83DW9chK7pLqps/8It6S/o0O+UtxJ1OfNRjko1A0j
 xBCQ4ZRdeF0xb4VCgapeNs2kwm+F891RAC9x9GfwX4+teGysBWGKgenAvHTgX6eEfHIM
 VI+w==
X-Gm-Message-State: AOJu0YznIK132NtYp93/Bonhd9Jgrm9JNNk34ePSFrvwisO27AMPF2OJ
 jjc6YmgmFpL8CmL6myXKA1C2RdOhOMmw+bnB12v+3y5zEPk5tmocB2BDCCfCzHmlJbZEeMomdJD
 fc+Lv
X-Gm-Gg: ASbGncvmAfYhCaHEk0xJqxdpA0hJY8JaoSn7pzwEQ8oPjB/wSfFAckN8/rkc83PqSAh
 k37cpn/9vmSpuOw7H0NGsffz/rFIkelmdRldlU/0lyqDl+dKvFu3g6A2EuIgHtfqd46YvY8tpZZ
 49TPVOuY6KkOau0OxRSXvuPgGpxkVI3jBHRqNSqkkFIX2owzeeYaZ90MD2pKIbcTRb6EXpOr867
 Y5OOBEhf+xs+UaNn7eI6Ba/IwSjcnG1ak0yDey9fNZwXa3Wwc9OLJrP+SZuAdLDWssAX3cb1/a5
 LgL1Sjc8TpaStFWQr45zIvBzHYeBvzuuSeGlTNJmk69MkaFC0iu+YHPcptG11o3qi0fB+bzdySj
 +47Ds9lxVh9gp50LAmcXa2GOWjBP3IPG9Lrjm
X-Google-Smtp-Source: AGHT+IH+c8O2E2HVd2OHIZ8hWUhr5YeOtL+Sqy1VBoh7i0RV9/KHCkcP9npOgtQBIh02kYBu+6CBjw==
X-Received: by 2002:a05:600c:5246:b0:441:ac58:ead5 with SMTP id
 5b1f17b1804b1-4539a843575mr132515875e9.31.1751381260942; 
 Tue, 01 Jul 2025 07:47:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a390d4asm170125445e9.3.2025.07.01.07.47.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:47:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v3 68/68] system/memory: Restrict eventfd dispatch_write()
 to emulators
Date: Tue,  1 Jul 2025 16:40:16 +0200
Message-ID: <20250701144017.43487-69-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Commit 8c56c1a592b ("memory: emulate ioeventfd") added a !KVM
check because the only accelerator available back then were TCG,
QTest and KVM. Then commit 126e7f78036 ("kvm: require
KVM_CAP_IOEVENTFD and KVM_CAP_IOEVENTFD_ANY_LENGTH") suggested
'!KVM' check should be '(TCG || QTest)'. Later more accelerator
were added. Implement the suggestion as a safety measure, not
dispatching to eventfd when hardware accelerator is used.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/memory.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/system/memory.c b/system/memory.c
index e8d9b15b28f..b072a6bef83 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -25,7 +25,7 @@
 #include "qom/object.h"
 #include "trace.h"
 #include "system/ram_addr.h"
-#include "system/kvm.h"
+#include "system/qtest.h"
 #include "system/runstate.h"
 #include "system/tcg.h"
 #include "qemu/accel.h"
@@ -1530,12 +1530,7 @@ MemTxResult memory_region_dispatch_write(MemoryRegion *mr,
 
     adjust_endianness(mr, &data, op);
 
-    /*
-     * FIXME: it's not clear why under KVM the write would be processed
-     * directly, instead of going through eventfd.  This probably should
-     * test "tcg_enabled() || qtest_enabled()", or should just go away.
-     */
-    if (!kvm_enabled() &&
+    if ((tcg_enabled() || qtest_enabled()) &&
         memory_region_dispatch_write_eventfds(mr, addr, data, size, attrs)) {
         return MEMTX_OK;
     }
-- 
2.49.0



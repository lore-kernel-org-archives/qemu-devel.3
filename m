Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8161C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 09:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tAp-0007ad-5Q; Thu, 24 Apr 2025 05:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7tAn-0007Z6-No
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:47:13 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7tAl-0002ZC-MW
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:47:13 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so6691525e9.3
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 02:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745488030; x=1746092830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fKVbRu30xoHBRhvO25AZS8axM+b/UNVBgSZLA8vs3WU=;
 b=paEcNnRm1jKkH9Q1mIktk6g6jDYoNk680rfL7/c9D7Oo6ccGpxRRhHIGILrXCKsuQs
 VkOB3T9XzI+cnalvw8QcWdIv79xixw9MFgopMK/StG+x+GDYwn6YlH2U6mvpT78r2qTt
 YbPNlc5s6+Ktdqll+QwWhkie5Y8L//hWZLV1bVeZkUpfIHepCwAVUyvFe8dplNt0qRC6
 wUtWymcpzNsvkBX2XCeRJJ92fsfcOpb5mW83q/DKPcj2tM/1sYPY59Gexoz7Tcl4bvXG
 QvX112p9dzyt7/K2wg5KQqB+o4MBKChp3RngAK3T28aHMcbdwNLjZrb9ClhLcJnngGnX
 EWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745488030; x=1746092830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fKVbRu30xoHBRhvO25AZS8axM+b/UNVBgSZLA8vs3WU=;
 b=cJqpkssy7/whTL8G/TsBu+muVmOD8yLCbXUnj4je3h/YEfW+i1s/10iiVt6FGJ3eZ3
 TJ7pH7JpuRMtwAUsFhT3gjRXiZ0/g95eDw3uwiT9sv3yj3pu1p95pi8XoznUuaYYrhpL
 tFN3vZBagqFBimEtEMFsLjbryx4aznrSUIbXsk1N/0LgQfaUBOgkcrJu6Wd8CI0QCnas
 sD/AlJSx08B8hoYCyFOhE5G5jxdW8mIBd6taKOZYyCjDQdVkPOBMW6q2vX31Dk7+X2pa
 RikrDYoybl4ABO3DM9AAr28HWtPYeUwXfqx80BLnYGlxLqHVwh/M/aNWUAG6VVCIYIcP
 l0+A==
X-Gm-Message-State: AOJu0YxmiMKNvU3IsGzeyjyhmCflZ9XwJpNApj7FOxKmqDHz13cELlKd
 Sx5tiotNGv5gkqPcPXZGEE0BRDWQET6E5ZYbeS5oaaWV8MnYHL1HpagVlV5naKMqxkN5EHlL8/C
 I
X-Gm-Gg: ASbGncsWJmCoUASyKaWOU7MpVwdMUNQ21D0bA9jwjRcfBk/AXEx2i6GWaw8qg5SN9/m
 2sEQsfLPPfyg+3i6VhB1Eq+W0N4agYfARphw0/4prFjtP3b1WnrG9Ef/3qCgIz9mN/xxCsOyFXv
 qmOV1ztpvTmK19Xh+0bOy2ZqjvfQ5AKwRfP+ikokxoleKOExubrADjHKDIL5vsvqgJUuTL90hju
 tGEqiltLyJ3s57j+7+iF/1I5giICznwzATTyqisL0CB6R23S5aWzuRgMMaclaX/r2oF7oVimf/Q
 /FMjSOSFIVj8qlYJ00SFbVxbzMZqlZ1V3AFDWWbIz/+cYNDZFJ2d21HzTXlFvjsEdBp9dmq99pr
 Lu8Svr/JVb6CPOhk+oH5w
X-Google-Smtp-Source: AGHT+IGmQDpZfKgeqvRv5spGtYiZS6g1s/iF7Jsi5azpmkYulkw7t5vpeV86JPqp+8uopqk6oAC6Bg==
X-Received: by 2002:a05:600c:a00d:b0:43d:7588:6688 with SMTP id
 5b1f17b1804b1-4409bd18492mr17380165e9.12.1745488029784; 
 Thu, 24 Apr 2025 02:47:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2ac5a9sm13920295e9.23.2025.04.24.02.47.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 02:47:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 03/13] accel/tcg: Correct list of included headers in
 tcg-stub.c
Date: Thu, 24 Apr 2025 11:46:43 +0200
Message-ID: <20250424094653.35932-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424094653.35932-1-philmd@linaro.org>
References: <20250424094653.35932-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

In commit 3549118b498 we moved cpu_loop_exit*() declarations to
"exec/cpu-common.h" but neglected to update tcg-stub.c. We missed
it because "exec/cpu-common.h" is indirectly pulled in via
"exec/exec-all.h" -> "exec/translation-block.h". Include it
directly instead of the not necessary "exec/exec-all.h".

Commit bb6cf6f0168 ("accel/tcg: Factor tcg_cpu_reset_hold() out")
removed the need for "exec/tb-flush.h", so remote it too.

Fixes: 3549118b498 ("exec: Move cpu_loop_foo() functions to 'cpu-common.h'")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/stubs/tcg-stub.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index b2b9881bdfb..3b76b8b17c1 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -11,8 +11,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "exec/tb-flush.h"
-#include "exec/exec-all.h"
+#include "exec/cpu-common.h"
 
 G_NORETURN void cpu_loop_exit(CPUState *cpu)
 {
-- 
2.47.1



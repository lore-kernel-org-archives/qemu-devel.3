Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D94FA1FEF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdj7-0005KU-IA; Wed, 22 Apr 2026 15:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdiV-0005EB-23
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:58:42 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdiT-0000GS-Iu
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 15:58:34 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43d77f6092eso4050214f8f.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 12:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776887911; x=1777492711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I2dpvsCJ0Q3/e/j+IBXLirL2bvKDQER6wN+0qzB1pCI=;
 b=b+vFElqN4icH9r0sTB2ewzj/T29jorWxs8u+xjuzu+lqkDo6+p/xBmFMcAVEQKyb6e
 JzIc6+FYYQcsnpkHWvXAlQpUtj5hGA0YvBKEOJ3l0Ja84doi30Q3cFGvHlNFrwDBYjGN
 9OqSCcQVcTcBnlalwqvLgc8Q52PYR7EiaAKv+CO859g4BysAgQvpf5dqAvhw5iGzYVtk
 KxPNk+OYeeC05FU26YZVn1D+6+fzEQiop3jEOnFjqLuVBjklDYaUc3KPoDGLZbEmPCVt
 xJmdPQdYPTavJdNupjw7wp8KdMjmeYWbJW+WgqFnce6s0M5RN6TJp4DwncrXZhkMYXQ0
 fVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776887911; x=1777492711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=I2dpvsCJ0Q3/e/j+IBXLirL2bvKDQER6wN+0qzB1pCI=;
 b=M+i62ONp3Rdk0zGxntCpkMzqCmV1MRM430CItO1BauGXJUQglkC2JiyUkEsoako5t/
 5UGHCgDMVzt2u7rRtq88T2Ox8BUC/af9POP2VW/sdh7bi20k3oRWw17aWN/vjDUa/s63
 X3uhkb25BgbtFkbIEy1y6YohO6jLEPTK6IiLCtW59M1GmaKIPHnuRx/SD1G/1B6Kv0H2
 aET086wb6FyIr86tWuSqnntFZ658fFS9Tq52Jq0pkKrVooV6WldTZL0i7Uv7HI/MbmGP
 1mdAVEv9F86DeZ5E1lkYdexqbB83mNebX+KY22Ko9ljmpC8+CKaaWng3/izbLYNQpC82
 fOYA==
X-Gm-Message-State: AOJu0YwyRLd70yJQtJWq36bvN4X5D9YlrsbGrH8N92awzlImqJwtB1Cm
 T+9HqwY5w5ggShsE2ontePZYYY+KtED3rKql9qf2rKKrhSGK5Hwi92ZJiCYdzMQ/zTx4bNaID2D
 Dv5i4Cy8=
X-Gm-Gg: AeBDiesV8CKo16Cy82mYMPf+W1+fg7ewQScOVt0vnk3lwQZPewdiNhKqb8skdq0IlhE
 PxdDE53F5jmkRazQ8b4uARuJkPzNzXGvO/qsIlLt0mPp8+fNY4dUmIN+W0gZZltXIdjEGcMeLTd
 FnhK2uGmaFQQKLgnEMxOq/GZ56ebVuG2hDwQUazvKa0rihgT1mliRe9u1jgrzdDnGv76b9sdDlD
 9PEftveKp9MUciR2ESTkcB+++c50hUaYpUwFdRRRB37JCWv3VnurokNmSPQYush1fsfDWQnQvVB
 jAFDjxMJNFSA2fdhxyUe8O7/YZMS7tBnIahxjCt7mdbhQZ30HbvgeFDRnLWl3CB597nnrqoAhis
 meMOW2l/jgGKSKO+3j6OmvUDLG14gT66ARGhZNYPBcT32GYh3lc617mG0ADqYmht4YNSJJf6aC1
 FTHc3VZkKymK1oHKSsI23uFGnDmCXRM0nYzzERy+vQqv2vEBkNVjIpQGYllLKN7vKuR1cp3ABXF
 108QRV0OsMKxlbEO1nkLw==
X-Received: by 2002:a05:6000:1869:b0:43d:9bb5:bd9a with SMTP id
 ffacd0b85a97d-43fe3e08fb7mr36583372f8f.23.1776887910609; 
 Wed, 22 Apr 2026 12:58:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4daf2sm46548269f8f.33.2026.04.22.12.58.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 12:58:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/48] hw/hppa: Include full path to target 'cpu.h' header
Date: Wed, 22 Apr 2026 21:57:04 +0200
Message-ID: <20260422195746.88865-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20260313062055.2188-24-philmd@linaro.org>
---
 hw/hppa/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 3b03ad44d22..0937d90ed22 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -7,7 +7,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/datadir.h"
-#include "cpu.h"
+#include "target/hppa/cpu.h"
 #include "elf.h"
 #include "hw/core/loader.h"
 #include "qemu/error-report.h"
-- 
2.53.0



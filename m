Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD8DCC369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 17:43:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8N59-0003no-Jw; Fri, 25 Apr 2025 13:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8N55-0003nO-LP
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 13:43:20 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8N53-0005yS-Fu
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 13:43:18 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39ac56756f6so2478601f8f.2
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 10:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745602992; x=1746207792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=yqxJ7mdx6v2xsA4qEI8XQwgVvbXS34ddK4YUceguVuQ=;
 b=HWOmZ/4/7+ekXdFb/a3JXLAX00cBY+P+PxxLeQpd47yfHHsypDFB0y5xX5/AgQ8vlw
 TStyyd7Dws5ojF48Ywkoe/GY1f1Jg2XyTqxYK9s5rOc6+PeznLCjkMcIgOCXDvL8tWoY
 hhdWADzgVX+f48FSzMvQugQmQihzvRzbnth8a83NjFfV4INbRpXRSANM82SYtUa+01Q0
 VNITMTTp9LlSnybnwNJY9ZtNL9gGHJs5RzAmyuAmBaSonp02suk02nlsa493AJuUHYCI
 R6m6T+beLKdgl247N+qmaL7WCjlDQQB7WfbWmG35jgvO+T1oXjs1C8q7NMKCQi9Wk6CM
 vbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745602992; x=1746207792;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yqxJ7mdx6v2xsA4qEI8XQwgVvbXS34ddK4YUceguVuQ=;
 b=cUEnoLZZXeECpWQt2bNSNowlYTbOwHTg6+jyB0eVVvvFW+ZRJRVfxRvUfwJwvTchrx
 hCslwRmWvbNbnim+mbn6kO7pEzzCwvbVbQrywFbNbpYaj4STTTLU9wxaV9CMkA7lnXTZ
 hX+QuLCd6TjmDz9qjsAyvOnc74MWI88aGbScIp9/gfu1U2jwFDz9ahMYshdR45gNUx5B
 L2QV8SjOqL5fTTB67OkIP6DfKXAj19qT4VRKBFm4CXPqldm/l2t23XxQ1cQ96jxMql8O
 Yp1kyldFm6ueMNDFYhEcO0HErlX8pCnhbW6mpEoiXmsogvQ2elPcFZs8GvZdQO11l+uF
 fdpA==
X-Gm-Message-State: AOJu0YyOTYsjzcX26xJ54hA7nF44gMSKnCQOZ7ZOJS8O2YZPUFEeZGzr
 gNGAv0SOI6ENb3nK8oFjSZfw7VgcCfAgaFmTPw73NoBqfFYv8G3yJdEQRJG5UWg5tf16vcI/VPN
 W
X-Gm-Gg: ASbGnct9jP+oN13B3pdK0+uOeeTl4Rays/1X8uGzYlZ8+HRRZNuCiJmj7iuPyy2pRGs
 5Jv1NpGK4agCTXCC4fpNuHImQynKM8i2JOb/z9SN4M1Wc5ucpOhIM+AgiFUdPnglns3iDRcjK5i
 oRnKW/w4XZqPBHEXbVSKNzsKA0cCIo2lTCaRLX1Ua7YEpE/ZXLNXBBG6K0fhc4iWY3U7PTUNXO9
 nqvvGJ2WTYLUEryfOHKa1k1/RhNGAQ/v9FjJME+kQfGeYizQOlWmjgrDw6CjPiUGK+V/nDeTqlB
 d4R0RUIqRuUjJrXvKr5MX8XpFkMF8jhr6TXcZMcNns8tcHGB0/8K8C1F3B/aEAsSKbwleGdMXDQ
 gRF+XxZvqGDhtmu8=
X-Google-Smtp-Source: AGHT+IFiHVZTGn9Ov1lP5AMRSU9t0Insq2QnGswpgQclTn3ij4TrZNEW0dgMbBsz/n3Pv7T3sEepKg==
X-Received: by 2002:a05:6000:1844:b0:391:158f:3d59 with SMTP id
 ffacd0b85a97d-3a07aa69788mr187237f8f.15.1745602992303; 
 Fri, 25 Apr 2025 10:43:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e461bfsm2963279f8f.79.2025.04.25.10.43.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 25 Apr 2025 10:43:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] target/i386/hvf: Include missing 'exec/target_page.h' header
Date: Fri, 25 Apr 2025 19:43:10 +0200
Message-ID: <20250425174310.70890-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Include "exec/target_page.h" to be able to compile HVF on x86_64:

  ../target/i386/hvf/hvf.c:139:49: error: use of undeclared identifier 'TARGET_PAGE_SIZE'
              uint64_t dirty_page_start = gpa & ~(TARGET_PAGE_SIZE - 1u);
                                                ^
  ../target/i386/hvf/hvf.c:141:45: error: use of undeclared identifier 'TARGET_PAGE_SIZE'
              hv_vm_protect(dirty_page_start, TARGET_PAGE_SIZE,

Fixes: 9c2ff9cdc9b ("exec/cpu-all: remove exec/target_page include")
Reported-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/hvf/hvf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 23ebf2550ac..da1dc66da07 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -50,6 +50,7 @@
 #include "qemu/error-report.h"
 #include "qemu/memalign.h"
 #include "qapi/error.h"
+#include "exec/target_page.h"
 #include "migration/blocker.h"
 
 #include "system/hvf.h"
-- 
2.47.1



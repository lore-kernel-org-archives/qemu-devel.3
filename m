Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0866CCF9F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 15:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8SU-0004cX-DH; Wed, 29 Oct 2025 11:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8SN-0004Y3-E8
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:27 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8S0-0002tb-Kv
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:51:27 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-63c523864caso16430429a12.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 08:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761753057; x=1762357857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ONPjhxBdnZw2nEiSNLLc67Obp7P7Ify6BVfhuB1s+3s=;
 b=KglwVBffYuD8o9fN/bFgeDpp7SCI+m0tjAl/Z74EfLyE36uGVpP0EF/KVf2ukGxiMH
 xDqyNH/G1lBwrtE9q7dJfm936R03HmyfUvRoOzjcGShxpHaiK210JqvBeNo1XeIX+49j
 +nQbziPFl2MXw0JzoHDYAkiiaj0va8u7TJlBv2yMxNDOERsPABClpbc3fs3xfYCtVd5m
 zjds8zsdEzlHn2aJFU+W7qNlBj+paOeaGIQlU9Eq13obAhafHKRP7qSOynyKfTbzvW5y
 OOicqfiVZFDerFryXbCcRYuRBbtyLurNl5v/RQEWnUwsU97n5YwyQF2rWYxBlx6QM8LB
 jQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753057; x=1762357857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ONPjhxBdnZw2nEiSNLLc67Obp7P7Ify6BVfhuB1s+3s=;
 b=nVqtvxhndmtoGRWCXTXQGt89GMCDcTNOHEtCsPhQgmug6jbVrVZHjsPYIY/cVTcPsR
 8X0348yVGmCZWC1Ro10zmwGs/QocgpNMrKWi2wEdnUz8ByTxDXUwwehSizoZ311D3rkD
 G1oB+6R3FhuIlnzWmKbVeLmRjWdQU8RwvGqmoI0pITu/JCPbGNpzHfxtKKk4K4BTEhdw
 1Ndj17BCHPlcb4pKsoBGPva3bkf8sQqMDkmcS7lkNDwaRutcyNlYV9DkNIWdq9PFJohT
 pUXyoC1xybhKIny0ZuOng4Pv3ORWGclvfQEtU7mJmNqueYbThL+7eGXNGWRcWxIKjj8+
 8SCg==
X-Gm-Message-State: AOJu0YyJ70TfNV/06Kqf7yD7vUZ98WVeJ9/uImCrx/1PPm2kDwn+U6Jt
 GCb5rNFe9t8eBaMwQNObD5DeZkhxd0UfbJy1qNS97A0M5/YiQjSrbZScFa/bLYfwiFQieeS5gtA
 RMROVqTE=
X-Gm-Gg: ASbGncuBEJ/gZGDVaTCR+QKurUs0W3H5sV7pUkATjghBjayYuoDatSOk6syShIt+hup
 ZKQN0E5RRK1n/cVwIWGWKac47mGXxdZzsm7n0feJMYGKl6usJq6iG3JitWBtBLvsRCkwcUv42Do
 JdV9lB2owlVlbYCKXsYZwIn1lxWNJ12F6j3hlGGfV+ZfpshgvD64bWGXkv/DQ1BU405eBAgfwJH
 XBpKv55FDo4mw5sqhvjURMnz4YYCmWR6LtP2kVOZc7si7C4PNNjWbcZ//5Cds+g6tMRC9PGRdQ7
 rl+pV0Oioo6Vn/r/i+O3trA0h7IHKhHyvJ+v+SheiTm9iDRYpJNhhln4w8savNRRPJd8B/sTiVZ
 SdWzEd/Nh4P7+g3l0Ldjc4dZxX7ptiASqEH+fKfjT7CPtqjyVf+vLtdw9bEf3yjYI6UI87uR+ja
 Jn
X-Google-Smtp-Source: AGHT+IEk5gN0V25rW1P43a+juaOx7z4oJTcYOb6OkbZZaSFVpz1E8qXc6CbrH6kclP4LSbDjscapLA==
X-Received: by 2002:a05:6402:1442:b0:63c:4d42:993f with SMTP id
 4fb4d7f45d1cf-640441aee2dmr2776482a12.3.1761753057248; 
 Wed, 29 Oct 2025 08:50:57 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64043e05a5esm2512795a12.4.2025.10.29.08.50.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:50:54 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E7CD260915;
 Wed, 29 Oct 2025 15:50:46 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 11/35] target/alpha: call plugin trap callbacks
Date: Wed, 29 Oct 2025 15:50:20 +0000
Message-ID: <20251029155045.257802-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029155045.257802-1-alex.bennee@linaro.org>
References: <20251029155045.257802-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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

From: Julian Ganz <neither@nut.email>

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places hooks for Alpha targets.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Julian Ganz <neither@nut.email>
Message-ID: <20251027110344.2289945-12-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 096eac34458..a9af52a928f 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -27,6 +27,7 @@
 #include "exec/helper-proto.h"
 #include "qemu/qemu-print.h"
 #include "system/memory.h"
+#include "qemu/plugin.h"
 
 
 #define CONVERT_BIT(X, SRC, DST) \
@@ -328,6 +329,7 @@ void alpha_cpu_do_interrupt(CPUState *cs)
 {
     CPUAlphaState *env = cpu_env(cs);
     int i = cs->exception_index;
+    uint64_t last_pc = env->pc;
 
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         static int count;
@@ -431,6 +433,17 @@ void alpha_cpu_do_interrupt(CPUState *cs)
 
     /* Switch to PALmode.  */
     env->flags |= ENV_FLAG_PAL_MODE;
+
+    switch (i) {
+    case EXCP_SMP_INTERRUPT:
+    case EXCP_CLK_INTERRUPT:
+    case EXCP_DEV_INTERRUPT:
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
+        break;
+    default:
+        qemu_plugin_vcpu_exception_cb(cs, last_pc);
+        break;
+    }
 }
 
 bool alpha_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
-- 
2.47.3



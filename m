Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC48E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 15:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNZGJ-0008Sg-QS; Tue, 17 Dec 2024 10:13:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNZGH-0008SA-SF
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:13:26 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNZGG-0003JS-Bh
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 10:13:25 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-436249df846so38163535e9.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 07:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734448402; x=1735053202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/B5TIPsV17x+5MyZKSnFfy23Cjqmxw2Z95LPImc4y+o=;
 b=RcKF4jHP00vX01FACY9u41Wo0GMfnnCeCjqMgqod5iRn/UyCiwqrBnFvXjSS5SmGtA
 SSjRp0rim3nZNwF7r2++7E0AZAckmrDdDjYXsF5PC9vvjMzXIgry9k6tcKHFtXCgAxaq
 6wlKiya3hwKmmBT7ahEskckukBdV6Kb9EF1diWVBesXNghyeAW2FqalhyJhy5BWeTx6A
 T6WcuGnO5OMh7gkgUp2xGH58NrT9doV9xzF++c79YXPgP3XJcNhqsmTJWkBkp0RZnYl6
 /V165wVt9laDsn3ArVV3SmAad93fUO6+IHiBDsNOLdgx5iCvCm+DEt2kY9ZS8V+pa/y9
 XmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734448402; x=1735053202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/B5TIPsV17x+5MyZKSnFfy23Cjqmxw2Z95LPImc4y+o=;
 b=ptFbqP2hUUpT786/6RujAd8JeVmy+uumcJbmf+fDL5Swj94sUE/aco+jiaL/L6FZAz
 iXxxnsugVmSnYZfG7mNUp5hi9Hj8GjF03jf+bDkOrIyw/BZYjla4CHGaEk0LQlvWRZcz
 oaiFgfNN5gP7lLsu4ZkQdX5aXg4WLgXTLROB/BNW+9Duedd41gn/XImGyjwXhewOK2sN
 2NFthvAx6pP1bG5CbK59A93xXTGncAXiiM/Plyj3m1vCSJlm5VAOod45S4unOSZ/v8oy
 6gixSy0Qk5OR8N7g6aLBy5BmxSY7mMpXE+5hTjH6WYfUnnSpHCYP/vVx+whX4XpOOy8N
 KXKA==
X-Gm-Message-State: AOJu0YyLoyE0ZwNqcvRZKYeuGpQ6jQsCkCx/Pwdv1fHaNxB7MXvmXUcD
 1xtTiWLXHTry6yhBacwSLBGN7oV0qd4YfFu7szwCYpVwwHJucD6QjZ1zJZNdxLRiBmY8kTZYAL4
 g
X-Gm-Gg: ASbGncujIFveIwfHCa8YKLninarhaFrVS1/guQRzisi5urcCT7ljYdm4EPjaoAmK8E0
 IihLKqM7c2ODr4gjCW1N/xQv/ezRDHD6mDOEQfmCe+FubzXnBuTsbakqKHVJENK5PN7WegYMl7c
 eJq+xlUpaAPARtcRdQrsjG3zEG/fjOj4n8rcll+BtYSLb0872MyWPi2gwt5FI0duCCO4WGUSN1K
 OKN6c49dm88ooHU1DBM+IJv8enlzU67nwTeZRYWJtthlZRPzP0PY/Dt/ZpnuvutX5QRNw3b89eT
 Vmr7
X-Google-Smtp-Source: AGHT+IEfxORkyLYhuHxnONvt8y0GcoDDWqUCnUhwhZJaAe+AjTE0GlknrUlywXXPAdaaiQJ2vymGXQ==
X-Received: by 2002:a05:600c:b95:b0:434:f925:f5c9 with SMTP id
 5b1f17b1804b1-4362aa28ddemr150403075e9.6.1734448402549; 
 Tue, 17 Dec 2024 07:13:22 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4364a376846sm22805905e9.0.2024.12.17.07.13.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Dec 2024 07:13:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Durrant <paul@xen.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Anton Johansson <anjo@rev.ng>,
 Anthony PERARD <anthony@xenproject.org>, xen-devel@lists.xenproject.org
Subject: [PATCH 3/3] system/accel-ops: Remove unnecessary 'exec/cpu-common.h'
 header
Date: Tue, 17 Dec 2024 16:13:05 +0100
Message-ID: <20241217151305.29196-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241217151305.29196-1-philmd@linaro.org>
References: <20241217151305.29196-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Since commit c4b3f46c151 ("include/exec: Move vaddr defines to
separate file") we only need to include "exec/vaddr.h" to get
the 'vaddr' type definition, no need for "exec/cpu-common.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/sysemu/accel-ops.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/sysemu/accel-ops.h b/include/sysemu/accel-ops.h
index a0886722305..137fb96d444 100644
--- a/include/sysemu/accel-ops.h
+++ b/include/sysemu/accel-ops.h
@@ -10,7 +10,7 @@
 #ifndef ACCEL_OPS_H
 #define ACCEL_OPS_H
 
-#include "exec/cpu-common.h"
+#include "exec/vaddr.h"
 #include "qom/object.h"
 
 #define ACCEL_OPS_SUFFIX "-ops"
-- 
2.45.2



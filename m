Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6453EC369DC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl14-0004BI-Sy; Sun, 04 May 2025 21:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0h-0003ug-8x
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:49 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0X-0002Uw-OT
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:47 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-73bf1cef6ceso3774411b3a.0
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746409956; x=1747014756; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LuLpPX6X06+NE7HHzhZQmUoQgosCpwXTe/wCgu+rNqA=;
 b=AYvcAt+I/cEfCFkERwpfV9XZg2cxPk2ej9ZU7TwnTOhvV5Dtbtq60yi6LUjiPuCXOd
 9Rjm0A6VaVpIEkXWctv5NOv10NrTEDTTwqihgoTAJt4deJk7sbtpDCPdTfm/qg0IBfBl
 KQ/GRXEfrpEvT5b4i3llhaUxJvCG2XoeuC1moyz2pLazPIHkFDtVejC0Z14e2cJBSAkF
 wA5ObYR0ZIFpVasucIhze767+K1RZP7Q14VuqJGHRs2nBbApDDCmwFKdo0/WzeHnV64n
 RAr70Ba9YhK/JA120QHGGdjODIXmPL5wJ/PVld1TrhVzKUKdHmTxRGmNRVbbYj6Z9HV/
 GV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746409956; x=1747014756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LuLpPX6X06+NE7HHzhZQmUoQgosCpwXTe/wCgu+rNqA=;
 b=w6NxK6DMgVEMw/rMwFP/P0QJ8HKRo38tdiC/ssWvxfbtp6LVH5UedfqEPmIXUsDYsN
 nKZpWv8jnwWnRBhgAFl1pnXg/WPadsp+ghmG9wn5sP+2CWdif8PG0l9RTK9JnYYMBY/1
 kUomPAws1bxpZhK0uRq075cyoJo0/mIWFayogQDQ6kdAZRwyd5jspGHlK5Dd1ii+4qHv
 7T9PgcrimSBjojw6cL6YmVPAXdPPs5NFK9xYr5QQGvxSj1l1hzhDomAAOBAfCFTS57LM
 h/R8Ii5EWTiteu6sC63xgfIjBHeT9pkb2FNXOHG+irb0+KMF2BJtGNR+UmP3hBmEQMke
 FAVg==
X-Gm-Message-State: AOJu0Ywfc+fgjUAirYNiAacHvfI7NhJKCq7d5Vri/8JDSqF4wmGTm5xG
 /f+hmu2Jbi0MwNl7mDdndDMogLgKauCdjzTOBkexmgfTZyPkvMeXWG3lCz+nudR8JuvfDdvpEXv
 MTv0=
X-Gm-Gg: ASbGncuJ9nz0RqHncC6jztxWFPQivZIEhdj9eM7VHXZ79WUxZBgNkCvq5fM7S25nY47
 pY2MQMSP5p4B4qGt1zRUaHKk1k3yHc8in9tcvMM2bqTC6a4u2dVcJhvYqFASnSWKLJv9jrDDPaO
 JfVIu6j0YxfIlflfLjWzJYQEwlpdqfbiFh7kJEwscuXZudSHDg9xY1L8rI3h8rUvdts26CTg5O+
 QAjzkryDTLmZUTXX8BsKjRAICQYzwmXFWgVa8IudB4QhksTAWy21FuqjjQ+NccC6qNEd0/UrzNM
 Ok8bvOz7pzfucDwNceIqhH34FoMQVFe6T0n+rwnm
X-Google-Smtp-Source: AGHT+IHzGUohRUeOSCShyTBQEz3+cx/ASVTiK/6WfrdnkCq5fA8tyIn6zcD32STw5IjqBUMIm5B39Q==
X-Received: by 2002:a05:6a20:d503:b0:1f3:41d5:65f6 with SMTP id
 adf61e73a8af0-20e979c90f7mr9100293637.32.1746409956419; 
 Sun, 04 May 2025 18:52:36 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920074sm4462101a12.11.2025.05.04.18.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:52:36 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 09/48] target/arm/cpu: remove TARGET_BIG_ENDIAN dependency
Date: Sun,  4 May 2025 18:51:44 -0700
Message-ID: <20250505015223.3895275-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 07f279fec8c..37b11e8866f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -23,6 +23,7 @@
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "exec/page-vary.h"
+#include "exec/tswap.h"
 #include "target/arm/idau.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
@@ -1172,7 +1173,7 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
 
     info->endian = BFD_ENDIAN_LITTLE;
     if (bswap_code(sctlr_b)) {
-        info->endian = TARGET_BIG_ENDIAN ? BFD_ENDIAN_LITTLE : BFD_ENDIAN_BIG;
+        info->endian = target_big_endian() ? BFD_ENDIAN_LITTLE : BFD_ENDIAN_BIG;
     }
     info->flags &= ~INSN_ARM_BE32;
 #ifndef CONFIG_USER_ONLY
-- 
2.47.2



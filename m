Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB440C369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JIJ-0002TE-2O; Tue, 22 Apr 2025 15:28:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIC-0002NM-PZ
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:28 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIA-00069e-QV
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:28 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-306b6ae4fb2so5284600a91.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350105; x=1745954905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Xpt+c4uiLvgJ+aGohvTC4gUHZh3/iFralC/z/ZOSEk=;
 b=AJkTW+9ftFhrmkVvlbLxSN2QyIU1xcjyW3cUR2NjCHoj5TgjKW3qIC7LDO94Nz+oK0
 VZydhExLvJuvPMg/2cP6lM1K4rCNKx+slYrpivyV/+yrvtZxMM38nUZ0I5xp+gtpvPFE
 c0ygmktQomPfmRboJyDJJzH0W3FCj0598Z4/+52XJ8tfRYTAs9kki2FneabdYYDkYscx
 YSY9NSJlFJx2DO2h+KyP4rgP0B9VUCUaSyNxk+NS6pRyt6r7Gf7NEWUI9RFUA78fTv3d
 mEpog1uUg6F5lhJZJC9vlbc/Wh3yYe8KO9z80ezRDUyORjruh1Ug143iMTtN7HZYM8TN
 leKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350105; x=1745954905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Xpt+c4uiLvgJ+aGohvTC4gUHZh3/iFralC/z/ZOSEk=;
 b=oTYbuKjdaRJgR0amE+3rFETxXRDuH41YbOzj3VgbNdx1+kUE5FJEx3trVWIxk9B1x8
 XNc9CWQltfgRU7bQccaeO+zfbI6l6/FloJNpRYSmFwwCGllqqOIKLXasZO5LgRrP4Dt7
 VHXTSHV/WJFktbYxRNvDEZpPsWWhwKx1S3B0Guo+zYFGafOKEWUMMxXvZytSliHHHG7i
 vHTw0l8xIsRFgK24yUnzTM9oRGFuiQi7TQJMv1whGFBxk+DQS4XUM99ln68iyDfaKbV6
 JID58dfQ1j8lhzJ3/Mo8zbq7TXjdexsUd6ANRd1BncVqWEACfVFQoUBZTSfK9dlsEg8Z
 o4Dw==
X-Gm-Message-State: AOJu0YxJC2S8A1Tfg6HZeG/PCJWt3ORkmFz6u7/gLhOGuWQOyljF6JIb
 HFUrbGLCJdWdwi22xPpTZBU0MZzjiPYu7IECRJ8iq2FkUYsjOEr0rCtECKlVwwcY18r5vLGAgZp
 W
X-Gm-Gg: ASbGncuiS24Y4iaQkSAKUqh+qllWL0je2gqvrW4dpGI7Qzcbw/qIxlDb65r+xp7PHAl
 k7frQhvIebAli32Kk6khBfxlO375WrJgncqtcjyrsbNKoyKQYCkUS4S7jlFIJHQNBnZR/yjWIdr
 drPeMRJAzOo5+Gaq74TZVly08A045iHTuqx9KfCvISEKIjLxB4J/rbBd+/BIefmjAqsLbrJIWaF
 L99F0vGMCQhrt3FJODB/ZrOxihmmAGsed+WKaK8smdfl3rTIuEhDu+SdpcdBVJsmKXSE5QLi5jd
 SyTLOBGLsTXRu0fnMAZ/nN6mhs0hQVLmL4rQXMW3QusHBxjhUe75zkKrbMVG2IMXBTTUhlPd8LY
 =
X-Google-Smtp-Source: AGHT+IH3x2aXa/9/bcpLDj6C3FFfu5OsE0z83V5FQKwGk0hf3NO7Ye+wz+xJ46ttyppI1pa2vkZYtA==
X-Received: by 2002:a17:90a:d010:b0:2fe:7f40:420a with SMTP id
 98e67ed59e1d1-3087bb69218mr26026419a91.17.1745350105226; 
 Tue, 22 Apr 2025 12:28:25 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df21278sm9146865a91.29.2025.04.22.12.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:28:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 007/147] exec/exec-all: remove dependency on cpu.h
Date: Tue, 22 Apr 2025 12:25:56 -0700
Message-ID: <20250422192819.302784-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Previous commit changed files relying transitively on it.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250317183417.285700-8-pierrick.bouvier@linaro.org>
---
 include/exec/exec-all.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index dd5c40f223..19b0eda44a 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -20,7 +20,6 @@
 #ifndef EXEC_ALL_H
 #define EXEC_ALL_H
 
-#include "cpu.h"
 #if defined(CONFIG_USER_ONLY)
 #include "exec/cpu_ldst.h"
 #endif
-- 
2.43.0



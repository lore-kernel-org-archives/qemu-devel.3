Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FD9E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfho-0000R3-35; Fri, 20 Dec 2024 11:18:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfgp-0007Zm-NQ
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:17:28 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOfgm-0007zr-M8
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:17:23 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-37ed3bd6114so989093f8f.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734711436; x=1735316236; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t48vEQ5OnozhVllpD7L+ytn5qFi6DPWUpTegHz2iL4s=;
 b=icgQ//Xr1RKQsYB/Ew+W/MB/TxfUeOgXapZf4YvOlRagEirYTGEsJuDVppRBckrjnh
 ZVBjAt1vlV7MdlLYwhIz/f5KE7x7n8LUoDcIYoGIspE115kDyIok9mzeOjUqPLCfOgf4
 5vQVf3yWQkV5I4a8ZZBZMM50ib9Vf9ElhcmwxIw5QBOgd/H9ECGU+7gMea+RDAH4rVv3
 HyCSFWx9+6uJn8ZdLHjdrHwr4tHvwVTkaZEKrro+e4s6ddJyvTCopAPRKkL6P7iau0z/
 mo/i62SKIFWQaLVtupeyAb/R3Bw3y/YfLgNkXkv7nisdnMZxFX3MhbdWwthvlHHyIz4C
 JSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734711436; x=1735316236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t48vEQ5OnozhVllpD7L+ytn5qFi6DPWUpTegHz2iL4s=;
 b=rsCOBIdPCObkpHAv4XKPRk7okN6flpZ+TgIrbUattrzdrEawUx6ZL2E0emOLCjBRu/
 hy0cnTxcp+T+vAx7JC+Ci8YJbZ7EjXMQFfR6s/fwd5/q7O4mvuk97IYYvpveVJxrRJOk
 J0WGGkMiHJ7be+WTcj3PxWKl7dgBdxY0A4jqlhqaKxLHe5isByPZghWxGZCxhHL3IIWR
 GLOCfOaMnKFyNeeq8j1oEGvcMcUFOjA5h4dw7bjNGNFwIWakMEtbrgxyujgJI8o41lfj
 VtxHVGZogM+xTxh/3ytGSFjs5dWKgJsI7zBvsM9xufh3cQR17y7Xr7nK863kA5E813EX
 BMBw==
X-Gm-Message-State: AOJu0YytjV2fzr/376k3SZfuq5zDf5TBi0MT627mCtbigg/dMyvN4T4F
 uDyD47TYIOmvn5WO/b92FNMpl7YxwnX7P3th6ieLow8AWaOYiLMrl2fLAS6Q1s+W77STyDqXiKI
 V
X-Gm-Gg: ASbGncvKY7+KLHAuOJ32/Qv/R5zGLWhj3hSmCS/Z8LjwaElCRVUmZ1e+6cjK6AN+Phv
 hfj0g9jJZObVxabwyAyVa1y+NfwAgBN7qVNvLx+IHeKvQlW2B7anVWvxFun43lCN89wdLartwSp
 YXQyf5waDUfTki9rN5wJT5enexa++mV9FsCbpxz8lrEJrYeKrKBhZkaVwHqowqtWUruoGMqycR7
 Mb4iDmtbOTl5Si+JhMPAC5iiR61rVK7jwPREdfrH3PFttzgMdu3lc+Od6xzd4GPdEZY9ZhAqtM=
X-Google-Smtp-Source: AGHT+IEEZ0wwAf7dJ7xNfd+/R3Yv8ermY52FOOkOf4qgHbigjRvMOFz03W4wZ8T3Fd0j0rgiiwdfpw==
X-Received: by 2002:a05:6000:1785:b0:385:fd07:85f8 with SMTP id
 ffacd0b85a97d-38a222003abmr3308454f8f.29.1734711436588; 
 Fri, 20 Dec 2024 08:17:16 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4364b053e91sm117393185e9.1.2024.12.20.08.17.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Dec 2024 08:17:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 18/59] exec/translation-block: Include missing 'exec/vaddr.h'
 header
Date: Fri, 20 Dec 2024 17:15:09 +0100
Message-ID: <20241220161551.89317-19-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220161551.89317-1-philmd@linaro.org>
References: <20241220161551.89317-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

'vaddr' type is declared in "exec/vaddr.h".
"exec/translation-block.h" uses this type without including
the corresponding header. It works because this header is
indirectly included, but won't work when the other headers
are refactored:

  include/exec/translation-block.h:56:5: error: unknown type name 'vaddr'
     56 |     vaddr pc;
        |     ^

Explitly include "exec/vaddr.h" to avoid such problem in a
few commits.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20241114011310.3615-4-philmd@linaro.org>
---
 include/exec/translation-block.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index a6d1af6e9be..b99afb00779 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -9,6 +9,7 @@
 
 #include "qemu/thread.h"
 #include "exec/cpu-common.h"
+#include "exec/vaddr.h"
 #ifdef CONFIG_USER_ONLY
 #include "qemu/interval-tree.h"
 #endif
-- 
2.47.1



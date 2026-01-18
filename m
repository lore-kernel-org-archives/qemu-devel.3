Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3006CC9830C
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhauR-0005uT-WB; Sun, 18 Jan 2026 17:06:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhaty-0003rr-5P
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:05:42 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhatw-0000vq-Gh
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:05:41 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-c3e921afad1so1471134a12.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768773939; x=1769378739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1nYgK0g6eEdhcQX8r1Op2+JuLhyO76+gPoRJlKgReBU=;
 b=LXzDxNJpW/tDKFrBlYs21L2djtmfq59pp6RF+hphD9TluDqR+A7775dGjL8bYX97XN
 4ixPUpCYEDyEA45hpfYt2L5dqOWji1AuQknO58qbrtMLnsl2lQY8N4rOKJ+oKgAEqE+I
 I+S9r9WdQG/JF30IWZecbDm7f4Sw7VTRwDnAIr0oHIvEpYCdnLiqT9KUg+URW+2/xnkP
 sdFv2i9x/Z3T0u/xAxCoMjyYiI4E0W9aD8xj7DBkLG/ZV9CbsI39GbOcK7o4LF+rvkc5
 EndEVSFJ5B0ApCETybi2RAjoxO0drJfRRimvfu251chEJB9yoFmP7vfd//l6XFkaubu8
 O7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768773939; x=1769378739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1nYgK0g6eEdhcQX8r1Op2+JuLhyO76+gPoRJlKgReBU=;
 b=Je1EaDXlPphZc7xSpBtk/rGmpaQILPV41SY19rtYn556NG78gwx1i822HkwSzMvbwZ
 JJ9/0QQ1x9jPkkgf2bCVo1THuUlCEZEFaaa7KL72y6jJBjFd/gPzoSQVykZdnFJANpZa
 e/W4ub2UYm70pbliipCPvJI94ohD9c7WNz4rjXUpy8WP0zjKUwQJkDOWxEyzae3SUeir
 LypEEiDxyp9Iqjsx8Gf7mnPIxUKLIkGZlfHhGI8AcfNgnlXHo1h8uu1hgjcjkXrx19yR
 Ya8pupwsglw1HhXQ+WtoqngtbTTpWu1SBUiRqG6jGcqCxGGzsnl7zrn/Bujx48SS4Uml
 Maiw==
X-Gm-Message-State: AOJu0YxqLVQ09rVe3tIDEzqkUiRrU1KRP488K4GcM8TrDvpeFYWnMfZG
 0oWxBdzpTiCQc7berT5gPX1cO+tyi4AGGJVrXqBS8SBLRu29ZuyWrMUt6GGhkpyAJNwd5c7nI1T
 gjjKUoXynMw==
X-Gm-Gg: AY/fxX7t3JU+/PUJUxQaQcqBN00LpWnu+2d7pjUL0hqsJ1PSW1frzYFp8cP01xBIJlC
 7ii4agBrubvJzs3Y4C3PWUL9TGlrIayVPjIdmqNLTlvTq4CgzLUPZ/cbXcbO25hlTcwuTQPe65e
 qdMZ/iulSA7q+IoQm03AvzZX4898Ytox+OkoAo6oeQNxLiXmREqwczCaOfPhw7sID7t5FgZPpU1
 N0vIR+3kwyWOqVZNMedzXQpSNd4B79iIouQfRifYdakbbnZR9krm0Aoknz4JBrI6sBSrGyYhEun
 ZPc4+TbHD99zgMN4nr0NhlG82LVMnXQDEpT5jWztgnBdONfVpSwi2nsltx2Ixy1wItpQPjjAQTo
 YREbqM1i2wxuwqirnJxDLW3S9LgufDTGW56E0Yf+u0yCUSSVG/5ERF2LkxEbGLuXXtY8ibBl5Sp
 B9ljMcRDDzfqkduIpU8g==
X-Received: by 2002:a05:6a21:483:b0:35e:11ff:45c1 with SMTP id
 adf61e73a8af0-38dfe5a938dmr7467511637.18.1768773938879; 
 Sun, 18 Jan 2026 14:05:38 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193dbb74sm74402865ad.56.2026.01.18.14.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:05:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 33/54] tcg: Drop TCG_TARGET_REG_BITS test in tcg-has.h
Date: Mon, 19 Jan 2026 09:03:53 +1100
Message-ID: <20260118220414.8177-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-has.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
index 2fc0e50d20..27771dc7f0 100644
--- a/tcg/tcg-has.h
+++ b/tcg/tcg-has.h
@@ -9,11 +9,6 @@
 
 #include "tcg-target-has.h"
 
-#if TCG_TARGET_REG_BITS == 32
-/* Turn some undef macros into false macros.  */
-#define TCG_TARGET_HAS_extr_i64_i32     0
-#endif
-
 #if !defined(TCG_TARGET_HAS_v64) \
     && !defined(TCG_TARGET_HAS_v128) \
     && !defined(TCG_TARGET_HAS_v256)
-- 
2.43.0



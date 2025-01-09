Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87ABDE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 17:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVvzV-0004i7-F1; Thu, 09 Jan 2025 12:06:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvzP-0004hN-1b
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:36 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tVvzN-0006z1-KA
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 12:06:34 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5d3f57582a2so4314782a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 09:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736442391; x=1737047191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7fkCPXOa8A9Xl79fpL/YYXVm1xiiiaH5KvVpCQywK3U=;
 b=zjI4v/ZpZmk5/FUq9Rl4IPhTdZZU+xFA6VRs22YpCNpikX092Hx7ve/s7sPptvk1Rj
 wtFLFQcbiqOCKhaH9dH0FTCLHWKfWOfNuj3oD7dlGNZj5ylwTH0lLp1NsuyTyqOGUbva
 fLgUItDi3oTAn29HawvUZFBukcf7lR/57bUghRF+EZamCEDfG+GbrMAkpJWm7QYccxV/
 zTVE5jM1e8X6YEwWH0eE6B/1qhYPuuw1h9isqixFrnVq11vqyOi4NYs4j0PqDoCC5nJH
 Xpn06Wn6gtO5xHsetmQ3WOH8W+zKldzdTpSTND9szE4/c7F8e6dwHO4NNAZFpGHUV2qW
 ZVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736442391; x=1737047191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7fkCPXOa8A9Xl79fpL/YYXVm1xiiiaH5KvVpCQywK3U=;
 b=PCcJLQ2VzH/qosjanuPAYd5gtnB0r0BqDN1P1xRjx2dIL/6G10OcQJpHP2pc+belZV
 aMZv7B2sscbcUScnHMtWCHJts87pYXSRyvzva07+So5OgO5A6KuSIurJgxlRJDgyKJGb
 x2eh43peFuO2I9lgvc/vsFvAcX90/xopLv32MzYPHDiDajk/a66jEmR5oAY2WHOZCzAB
 y7FoGMe0Htui5ZHet7yMvAFSvWZ1hsRDCvUHU2828xQ4Uzs97OPI3Vs5qsB02w9GpI1G
 RthyUOgYi32qb7/RL7Xt03/YLg+iDt3t7M54UU5Wcz4fZmwMU48W4jkjxuKnmYLu2izG
 gSjw==
X-Gm-Message-State: AOJu0YxVHQPeCDr2UmzZOCXNxpw9lNpDxQFD9D2+78ytsa5SwRF0k9Xx
 GbS49FSA4E5J2PCk8l84JsnsHB4/T9YWsZKZtXMswg0bMgKy08A1bCEeBv99Xrs=
X-Gm-Gg: ASbGncvu4lpN4kBSRKrepjln9TqxTkjRrtbjPBj97exp+Byo5L73fOixeTtGvPGQ8vE
 K4lRf+rjcODP28sThRmjuyoMSt/uQmrE7lAOpOuelHjFcIgGl93EndKyEIj4blKmUrujKUUokuY
 kT7lWxWNMsS0H/YC1+kAVs4Tve0D8yjqTDmzkZSM6XA1UWvIIrf6d+Too/NEPzYlONEHQFLzhFa
 BLPbBn+ROUpg/dKK8ZNxiwW6JfVRD1hMO0D+GCEDByf4sc/mYhF0es=
X-Google-Smtp-Source: AGHT+IGVrIWhvQg1deMRhcRYsCiV4IsypINb4ZTlGfwFAIrTUHa6sZ8Qh14OTiGNlLXwS8g7uMlZew==
X-Received: by 2002:a17:907:72d5:b0:aab:ef03:6d46 with SMTP id
 a640c23a62f3a-ab2c3c63f95mr363175066b.4.1736442391046; 
 Thu, 09 Jan 2025 09:06:31 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c913804esm88921566b.84.2025.01.09.09.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 09:06:21 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2DE1E5F9D7;
 Thu,  9 Jan 2025 17:06:20 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 04/22] semihosting/uaccess: Include missing 'exec/cpu-all.h'
 header
Date: Thu,  9 Jan 2025 17:06:01 +0000
Message-Id: <20250109170619.2271193-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250109170619.2271193-1-alex.bennee@linaro.org>
References: <20250109170619.2271193-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

TLB_INVALID_MASK is defined in "exec/cpu-all.h".
Include it in order to avoid when refactoring:

  ../semihosting/uaccess.c:41:21: error: use of undeclared identifier 'TLB_INVALID_MASK'
     41 |         if (flags & TLB_INVALID_MASK) {
        |                     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250103171037.11265-3-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 semihosting/uaccess.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c
index dc587d73bc..382a366ce3 100644
--- a/semihosting/uaccess.c
+++ b/semihosting/uaccess.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "exec/cpu-all.h"
 #include "exec/exec-all.h"
 #include "semihosting/uaccess.h"
 
-- 
2.39.5



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84730C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 19:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxXSJ-0007i2-Fz; Thu, 18 Apr 2024 15:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXQM-0001Yt-Tc
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:28:01 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXQI-0007f9-6b
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:27:58 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5176f217b7bso2158942e87.0
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 12:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713468470; x=1714073270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zNTjYBQSXlJdcfDAGNfhN/k6Tw+ZuKx0L+6ToWVAoUI=;
 b=ZwyPaKn3Ee4HVquN364xaRf+LilSRpTtrJ8VmCW+TGl1THY1hUvfr8bJkbPCVzTL0O
 eOfFSGovndkedIMQESYB4sfNRG3VeIayto6YgEZujgdXS5yw9LxH7MCYweGwZrWnG1Nr
 uXNOrw/epMEXW1V5da6QQq4zwoyehC4IqsDYwlfq1NHmZakLWDwaIzmVs85LErki8gkR
 YWrMZqt1mKSt+2xFOvAyK9TYopkQETpvPlSHgQoBFJBW9pVB63e6xv6m1RuBONfJZ34y
 jyj/LX9VHhv+0ne8ET2lSC6rssyBbzaOPr0yEMKmkrFGIsvIaV5Ki4XNhkY0OZuUQ9nS
 Sl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713468470; x=1714073270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zNTjYBQSXlJdcfDAGNfhN/k6Tw+ZuKx0L+6ToWVAoUI=;
 b=ABobP0CXXEeHQAhPn7Quq5NbrVgQmn5fZE4ZvpCGqDovFNi3xwrqb9O+ehQ5v91YH2
 68zX3OXZJP4zp8N+Zn2ws/Xu9aZOxDiaHnH2ocRHKwfL+PnaVk2NEME0E+UH62cxCxTS
 FpqC9PG49hSCfwWDJTuaDieu0mkzGkQ+7MIT1xh0WGEPwxdhYqrjoMk1zdTPONAzCtZm
 zwRLClbE0oE7t48jh7/cY6Ee2r6OZVRbKgjPLZlAIKFo62ulSiiICJmtYV5ln/xSlkfw
 /BZ2oxKxzgREVi+Bo0/MsIlL021pe8pFHQqFzx4F1VL+mBkwbuz3rqAgAUDTnWbPsIu0
 iqXA==
X-Gm-Message-State: AOJu0YyGDAZTx+TEQsHIxh7XdSxrrwSddZf7SlvUyGhT+tXj8DIXp3eg
 0b2KnltuiYpuFR/NrmX/cCYYHf+Qxv9OOE94/J+w0Rbtvdlzfr6Q6B/zny4o/34MpJtFK0chnte
 N
X-Google-Smtp-Source: AGHT+IGRtbT7LlcI6CQVHjULTyTQXTmBNJ6XYFrkIeD3sIOYqal3qJsUOamHWsXIg/SR6F1S1/+Vaw==
X-Received: by 2002:a19:550e:0:b0:516:d250:91a7 with SMTP id
 n14-20020a19550e000000b00516d25091a7mr8569lfe.12.1713468470564; 
 Thu, 18 Apr 2024 12:27:50 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.151.213])
 by smtp.gmail.com with ESMTPSA id
 z5-20020a170906714500b00a51bbee7e55sm1259679ejj.53.2024.04.18.12.27.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Apr 2024 12:27:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 18/24] plugins: Include missing 'qemu/bitmap.h' header
Date: Thu, 18 Apr 2024 21:25:17 +0200
Message-ID: <20240418192525.97451-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240418192525.97451-1-philmd@linaro.org>
References: <20240418192525.97451-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

"qemu/plugin.h" uses DECLARE_BITMAP(), which is
declared in "qemu/bitmap.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/plugin.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 12a96cea2a..41db748eda 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -13,6 +13,7 @@
 #include "qemu/queue.h"
 #include "qemu/option.h"
 #include "qemu/plugin-event.h"
+#include "qemu/bitmap.h"
 #include "exec/memopidx.h"
 #include "hw/core/cpu.h"
 
-- 
2.41.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64FB8C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 18:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxA1v-0000O4-NY; Wed, 17 Apr 2024 14:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA1t-000070-M5
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:29:09 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA1r-0003Ps-Ug
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:29:09 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-418c979ddf3so436865e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 11:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713378546; x=1713983346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ui+hlZ4hNideAomElccoReBpzAydVF/XtIhgQiumYZo=;
 b=EGTUH2IheAc3DO5o6N+5I7u9ou3FwxekVs5XC462GeDHCygYU8ysDKs3VtT0K4cdWl
 AzRYtaqwoiDvYj6bh/nQvYHnjpcPYm0FKhpCQeCV37sYgwN0CDP4w2GZUWcKiQRZyETT
 KcmCqlkCztnz8SxQccSdEZtuEc8WhBr7Xlkyz19HW2EgLo0WIROFITSyNszXufxO+m4E
 bTLLUX9TVB85NA5pVxcRXCWpKW81ruYwH5u7mgBQgTs4KrjvgPiX2zFpD4rmlQr2UsBK
 qmpYHZmE2igPeWbFhsBCPa4glJyAleQm2iRra5Jar4RsK274kxGayo1gkNmNJk9tbM9t
 r49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713378546; x=1713983346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ui+hlZ4hNideAomElccoReBpzAydVF/XtIhgQiumYZo=;
 b=vu/JeJgdiuXOcoBwQRXf6Da0mxshZWPRYJZjnfNq1iWSQiNQqZTNGWrBtTv9ptrds8
 P5hptkqIAqUAqp2L14T9CuUYNRybqjpqOY9fmIgLLyCaBHEA2XHQwLFu4qz0DhzpvNOY
 lWtI2A8X7NtcRwkupPUHlV7UcQR86e/ZDiBUi3J0pAEnYRiufqpIFPLzhdlYPS/oVfhH
 LFn/JR/6j0Z7PYChIgtm00qlAoM4/VgBwMUlYH6/aaKgRDBW6OGXh3w3cQGQbmxNQwoG
 zC/YDDJCu1A6e125M80JKFqQSfgDAfGgEih5osSxvcpdyfXFcqSYB715dx6H+1Byk4I3
 d+eQ==
X-Gm-Message-State: AOJu0YyOhfMhA/DJ32HTdsMV4oJCbs4Xh4tj1Em7PYAuE4VP8XTX0kaW
 0AtkqD16hRXsX0YgzQFLvu93nRejtkwKHSynRi4so9ZOtYu9st/xBPTdRYhO7QP2A8gu5vwRlBg
 z
X-Google-Smtp-Source: AGHT+IGv5WFrrSGT4RU6KKvuR+Kv21oVrAeXTqMbXeGUAKLOo9buSZzZe83kTzFScWH8cZAC0VPTNQ==
X-Received: by 2002:a05:600c:b8f:b0:416:3de5:133d with SMTP id
 fl15-20020a05600c0b8f00b004163de5133dmr309810wmb.7.1713378546093; 
 Wed, 17 Apr 2024 11:29:06 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.201.23])
 by smtp.gmail.com with ESMTPSA id
 jx12-20020a05600c578c00b0041674bf7d4csm3585001wmb.48.2024.04.17.11.29.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Apr 2024 11:29:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 10/21] semihosting/guestfd: Remove unused
 'semihosting/uaccess.h' header
Date: Wed, 17 Apr 2024 20:27:55 +0200
Message-ID: <20240417182806.69446-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240417182806.69446-1-philmd@linaro.org>
References: <20240417182806.69446-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Nothing in guestfd.c requires "semihosting/uaccess.h" nor "qemu.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20231212123401.37493-8-philmd@linaro.org>
---
 semihosting/guestfd.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/semihosting/guestfd.c b/semihosting/guestfd.c
index 955c2efbd0..d3241434c5 100644
--- a/semihosting/guestfd.c
+++ b/semihosting/guestfd.c
@@ -12,10 +12,7 @@
 #include "gdbstub/syscalls.h"
 #include "semihosting/semihost.h"
 #include "semihosting/guestfd.h"
-#ifdef CONFIG_USER_ONLY
-#include "qemu.h"
-#else
-#include "semihosting/uaccess.h"
+#ifndef CONFIG_USER_ONLY
 #include CONFIG_DEVICES
 #endif
 
-- 
2.41.0



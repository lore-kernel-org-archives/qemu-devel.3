Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749FAC28B28
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 22:00:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr2Dk-00027H-Pd; Sat, 08 Mar 2025 17:00:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr2DW-0001qk-Ut
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:00:23 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr2DS-0001w4-ON
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 17:00:20 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so3960925e9.1
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 14:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741471217; x=1742076017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=44/LDZlqaEganREVnKWvgKaapu9QDS5IWFeFvuBpP6I=;
 b=OCacKSfw+iX5Zm6aXTnQopxPEKVdTqXPdL8hyhNAJUQVDsuvxeLNjjzfDMcR9Zn20y
 uEzyJ6ziLytDWaWODL4ObGC6rPQ6PoFSrOQLZYG/BUPlD/aZ7xtkgp6bYpLyy8u0ZUS+
 kkUL32pCW18pT4ykeajqSNZbCI/m5QAuCkaKZgNAvVrWXe6HZkRZ8WXdfdHda7kXMvaN
 ggSA8HnYqZO/IiW+Xe6hH1OLGTMpxv0x3BYs6YtMva02I2RlCoHl8l8BGrBBaGrrgEbe
 cvG0Y+O4Ac6UsaKIIXxeeoajOjgfFxyksmSsIHSbkkLG1YR0lzJsRGGz5Lt8++SKUwhy
 bJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741471217; x=1742076017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=44/LDZlqaEganREVnKWvgKaapu9QDS5IWFeFvuBpP6I=;
 b=E0CnJpkd6yjq8eu4dM4xAsuAT/zz7BjK5osgP4TtjI896cRQfHVYqUdFwv6vicJ1yo
 vICz/c5N161PCCJ0XUBznOntuiAyxcffY5zgcuVdQiMwxL9CNFADOV9FP/Cbrq5ajEwK
 JlZrzHot47ro6RkMwfr5d6RipAUWAv+hGu3NOMsMl35FOvj9EMWP76KBT0CUlIVBkrci
 UaEpco5QpDMK2t2y3Hdn8QqqdOTomS3rUwXtAm/JIl0mHc8S1FcWC12h7dUnWdUz2lXf
 LjZGUrjq97s9XlZ1TEDpCTNB/FjvfKgQy8KE7IR0zpuQL0O7JJnLBncuH1+Iya9LpK6V
 jVKg==
X-Gm-Message-State: AOJu0YyPgd4/6pc4uxijU8U/hTDa4QR1q/KN3uZdYwLlUgmvFy4Rqlwj
 VPLfVNgPIFiGBOgaoOBczivf7GS61vrakty2FLhDr54yx+Q8ctdiq/CouLMLW7U=
X-Gm-Gg: ASbGncutT78yJUAm+dCXYqlXhqt1zJcieEVu6fdWdh+6Q02lJbQybBu4xDxICh83txU
 9HQPj8WWgE0m7BRGccNTdXuOwiAY7VoihtubA68+9oExjlqW4SU0zpxl0W1AxwfLkGwTVaRZpgG
 uJsS3vfeoy9KRwIcaGJ6G6l+xqPPp4N5drAU/DnvrMzh0fJlaJIeaLd6M+XOCFbUTRKF3VDeggv
 R4pgq8gPN72wG9jzc1QYVBGpZNdAFCA08L6g+HWATynHJvRADzy7SSu60XwdKO2cmr89mNHiGsn
 YWMXJcVsMaCHIZFVseAL16L22iA+UPh/HuCONjP14v+M0Ok=
X-Google-Smtp-Source: AGHT+IHY4KbNV0oWN4QAmmwZKzkLvv50s2QVCLl2fmGRRAUVFBZfHnpWdd2obinCEp/mrLqC/haKAQ==
X-Received: by 2002:a5d:588f:0:b0:390:f394:6274 with SMTP id
 ffacd0b85a97d-39132da9214mr5278193f8f.52.1741471216842; 
 Sat, 08 Mar 2025 14:00:16 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfb7928sm9907940f8f.1.2025.03.08.14.00.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 14:00:14 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BC0D86086F;
 Sat,  8 Mar 2025 21:53:28 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 23/31] plugins/api: clean-up the includes
Date: Sat,  8 Mar 2025 21:53:18 +0000
Message-Id: <20250308215326.2907828-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250308215326.2907828-1-alex.bennee@linaro.org>
References: <20250308215326.2907828-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Thanks to re-factoring and clean-up work (especially to exec-all) we
no longer need such broad headers for the api.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250304222439.2035603-24-alex.bennee@linaro.org>

diff --git a/plugins/api.c b/plugins/api.c
index fa4d495277..c3ba1e98e8 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -39,9 +39,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/plugin.h"
 #include "qemu/log.h"
-#include "qemu/timer.h"
 #include "tcg/tcg.h"
-#include "exec/exec-all.h"
 #include "exec/gdbstub.h"
 #include "exec/target_page.h"
 #include "exec/translation-block.h"
@@ -51,7 +49,6 @@
 #ifndef CONFIG_USER_ONLY
 #include "qapi/error.h"
 #include "migration/blocker.h"
-#include "exec/ram_addr.h"
 #include "qemu/plugin-memory.h"
 #include "hw/boards.h"
 #else
-- 
2.39.5



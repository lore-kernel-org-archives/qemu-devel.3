Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60C0C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 11:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmsoP-0001dT-Vh; Tue, 25 Feb 2025 06:09:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmsnz-0001Xi-5R
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:08:54 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmsnx-0007kk-CC
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:08:50 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-38a8b17d7a7so3045585f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 03:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740481727; x=1741086527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qb1orkQ+AqcTmWd0ljpleeeoHkiMqn4rSUOQc4oEDwE=;
 b=lnB3x4ljrfWTdtZzi8b0foad1PWvext1RnqxIKCMEU3G5Ah4P6FTmNhVaPrvGio16C
 qwh9ZIa2140bqwOWPi7cXEjusDw/j4/yEkYQskct/1bFEdBhKVilpFo2mTRomCRCjtQb
 HaWGiDoWxd5r/lTOaUYG1c3S1a9gDGn7/PV9pE2HiDifKJYiuK0XBLRgwRqugc1ibjhq
 pB/csvEBWUJHZF4bLvAyNKxthtz5fPlC6aKpe+/mV1COLmPQrU9DTTZ6WLPwNyJK36uK
 F3IRea11/icgfvnoFAgxOWvSJOl+N5uBICRVfgb5Nk71/UgCc5xo2mO4/F/psRholNKd
 Ej1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740481727; x=1741086527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qb1orkQ+AqcTmWd0ljpleeeoHkiMqn4rSUOQc4oEDwE=;
 b=qhiwQZlc8OPNj/YOe/GrKO63IV4VxdR7SqkxQQpvZ6Bk9SysbNvDsreTivkRqkOuNw
 2+IOSHuTaACs7XZIrUa/CbkGjpmqa5TG9wttR1uSMJCwrjfp2cCdWNuqKfIYGztfr0lj
 7wFrWb+n/rNlth1vhFuDrsqGOSzqcXdMNqSCnd8Ap2+iCTfp816EPsDgHbGGTSjZNCLF
 Fd18t3Ond4S/T6F75LBz5HzRfVZEsoK7pxiWg59G+80gvjKoWko4KfEm0JoMhwMr/bOQ
 +l1cHJeHGotqJZBPAvuLnqZPeDjkgWSZV8KhnEVR8v0+ZqjmEvmHvrk4ssveOf7u1/yL
 msfw==
X-Gm-Message-State: AOJu0Yyj49kHhSrvdpxY1PCzIJal2g8DlZqgAPHJkpgGePVg3SrC4gVE
 A1sqFEiTRgaOrFS45J9feRz2NY1i2+/04BuOwmhf0s2PEV/dtdPERbxAH3Fs8GA=
X-Gm-Gg: ASbGncsvJFW4kwAL9G0kZOe4lvKqHDWF1lsN/eXD+TCNeduCEcfWuiPkITV341ompgm
 Lw3L7IcNHWQWtM7AZzVj9Yi1ULiG7GwSoGDYFItV2jIrd7MVZiC6Dw7hZqDalzcqlS8iAugtxBf
 jWrvkCYANL1mkEUKBkey0YOEGJrLcA1C42co2lAKyqwVqH5uE5M5lQfxiseIBMkqRhEbVzU/SDt
 N+d2/t5hZupwx7Rbs6/TOrqDsttj4h3NaI2d/3SDE/Ppsj+JgO7lqIUXxmYngBjCMAh4N4xCZ2i
 gi9ZFhAPu6//4MK/FLzz22jsyQt2
X-Google-Smtp-Source: AGHT+IE5hol5zn1f9Zl4riLKeuflmsqjRzcccRFs5N7gs5KGfEDWcfEtzR3/gcilid0iKrI7qRNxMg==
X-Received: by 2002:a05:6000:2c3:b0:38f:4251:597b with SMTP id
 ffacd0b85a97d-38f6e754752mr14287017f8f.8.1740481727545; 
 Tue, 25 Feb 2025 03:08:47 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd8fcca2sm1898230f8f.96.2025.02.25.03.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 03:08:45 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 83BFA5FA34;
 Tue, 25 Feb 2025 11:08:44 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH 04/10] plugins/api: clean-up the includes
Date: Tue, 25 Feb 2025 11:08:38 +0000
Message-Id: <20250225110844.3296991-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250225110844.3296991-1-alex.bennee@linaro.org>
References: <20250225110844.3296991-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 plugins/api.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/plugins/api.c b/plugins/api.c
index 10b258b08d..3e1aac7bfb 100644
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
 #include "exec/translation-block.h"
 #include "exec/translator.h"
@@ -50,7 +48,6 @@
 #ifndef CONFIG_USER_ONLY
 #include "qapi/error.h"
 #include "migration/blocker.h"
-#include "exec/ram_addr.h"
 #include "qemu/plugin-memory.h"
 #include "hw/boards.h"
 #else
-- 
2.39.5



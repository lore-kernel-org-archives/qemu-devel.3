Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4AFE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 14:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNYKo-0000DA-4o; Tue, 17 Dec 2024 09:14:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNYKe-00005t-FA
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 09:13:52 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNYKa-000274-Qj
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 09:13:50 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-7265c18d79bso5696989b3a.3
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 06:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734444827; x=1735049627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+AInIhe3xWLXuYtEN1l+ucfFt841V2nbagQTKyY3VfE=;
 b=BmrA7PGAFMzQ8462QW/Lx7HKiQf00HqY7Ei8IWDnoz3SzmGX4o0iJAytVpxFXTEYiv
 +UUS5jcNAu9bXjyhJAMU+b9Ci7dljIRnJI8+IYZPJs1H0PKA21BisjQ/eBtbFcNoB5Fj
 N09zcxDWURgwCgaavNmNZ38ruN5N1nuqu27dazj4RFtyOK5+MS0ZXUkjlC9KDJVSsIgy
 TnaEUn8cZNq8rrm2Efz0nSCZ0QijnlotBbgqaj9HrWCPvYtWVFvcqao4MYE0YSrGnYWx
 0oMa/RQMdTdmGA89dWlz2uYWoOOOdzv+ao1MswcbRSazfIgVsI3v8FOr+nI4wT9IU2eb
 1Qgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734444827; x=1735049627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+AInIhe3xWLXuYtEN1l+ucfFt841V2nbagQTKyY3VfE=;
 b=lRJ2/EDK/UrCJhL88rcfi9ng4y4VHsn6CVhdUB5/cw5CL36RcPpqhC6nIvF8AsSZOc
 GgiHf5jEST2QSHPQiXU0hs2ZDGsLxOPKrfHpF390P5XonWsvYiUFGBnKweBPmzKIOXJy
 JoxP1GmlW1/6qDDFKFYzLq3D0Wno4vV19pEqOe+/fD72UTjLfXRELyXqQ0JjjeuW06hl
 voN2Q9bz8AV5sgN8ngEepIvueEfl0VR2CR366VgWmsTleUYClzAwNUfUOZyLOICG2rWB
 X8+GYeAg6RiEB4GPmrs+2beUvyKsOWSP0LKPQ28VSrzpQfgsgWvJNPrVUcQudS9McK1c
 PUmQ==
X-Gm-Message-State: AOJu0Yyfy6DJ05JHaaGHYZcQ1XnyM/TMFpu1go7Q+Mr+WlwzB+d8oO/r
 Rb/TMvy9niLtNdUIOV3qI9T9ECpVPBz8/rMiiJdAruZibhCiDT7SwXfLzHz0xLILv8rt+FY6x1A
 0
X-Gm-Gg: ASbGncscJQNjqvF5zZhvHIfQqUauulMo6WovssjIf3qpVmKpC8oE8b1HWug6BD0531k
 sp+0FH3sqxNv1j+w1Y9IV8a5Ucm/THiow6A41lwzv6T11D//gvvWSid07hTvslD9vBsUqVIQxdF
 l3cLrM3zVuHWsaq+Q9Emw+0UOqRZ0ZjpUIkuVwje4CnhnFtoCNvck+dqOOkycMm4dpWlvGLZSXd
 J9GTdkopde8fXAo7KTmo5fnHTyOEUa0d6cQwoB/P1KPaSJtMQTTFvjEFKfvJEBBG34GjFJ3AjRe
 KM7f
X-Google-Smtp-Source: AGHT+IH/YtRibfR2S2DXipZ7jPyMQ6GmXJj+RxHTfdpdUm0lFBmUvyLl/w/P0MH8ZL8lcytgBim/1g==
X-Received: by 2002:a05:6a20:2d14:b0:1e1:f5a:db33 with SMTP id
 adf61e73a8af0-1e1dfdda9edmr23047208637.36.1734444827298; 
 Tue, 17 Dec 2024 06:13:47 -0800 (PST)
Received: from localhost.localdomain ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-801d5c3ded0sm5838893a12.83.2024.12.17.06.13.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 17 Dec 2024 06:13:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/2] exec/translation-block: Include missing 'qemu/atomic.h'
 header
Date: Tue, 17 Dec 2024 15:13:25 +0100
Message-ID: <20241217141326.98947-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241217141326.98947-1-philmd@linaro.org>
References: <20241217141326.98947-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x42e.google.com
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

When moving tb_cflags() in commit 88d4b5138a8 ("tcg: Make
tb_cflags() usable from target-agnostic code") we forgot to
include "qemu/atomic.h", which declares qatomic_read().
Explicitly include it now to avoid issue when refactoring
unrelated headers.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/translation-block.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index b99afb00779..81299b7bdb5 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -7,6 +7,7 @@
 #ifndef EXEC_TRANSLATION_BLOCK_H
 #define EXEC_TRANSLATION_BLOCK_H
 
+#include "qemu/atomic.h"
 #include "qemu/thread.h"
 #include "exec/cpu-common.h"
 #include "exec/vaddr.h"
-- 
2.45.2



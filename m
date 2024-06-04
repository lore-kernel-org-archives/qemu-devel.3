Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A476C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 09:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQwF-0006eA-0Q; Tue, 04 Jun 2024 05:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQwC-0006Qq-RU
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:58:41 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQwB-0002L1-3A
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:58:40 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52b9dda4906so1978410e87.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 02:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717495117; x=1718099917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fenTnqVRpu5N0h4sB+9IKfbou1R637umnDD1Q49OsQo=;
 b=HLZOaw8atNr7louzNmdzCxjob+fdDDKJi4X5U52xVT6wRWoAm6fvcVNmoh7v/UhV2J
 rOEqKSS/kRgfRMMB25XmgQ2wgQlod3sZz1TK1TPmksl7Mpb2A+qZswq4VUOK1AB9MPJG
 h4hmteVLNKqsQkZN6GhaZO++EGZB5oxzG/Lq/TC6Zba/7+sEPDqbGxKEM+n1/MUwokLq
 kXvyt5HBfdLcb/i3FKhKsq/+UorZT7KtB1usmVKWv+1X9Gxiu6WTpGevTAegmx9A/eAX
 Zeqkk5hQbpgBXQm/0gm2DLFBiYCDfk3gY7w+twUGSvigrZ8z4w9bjOrxXaUPLuJHsruG
 Wqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717495117; x=1718099917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fenTnqVRpu5N0h4sB+9IKfbou1R637umnDD1Q49OsQo=;
 b=TfJgApEmCs904UI6AWPkS6uUZCS51QJ5bjc7qi0VrTnz/wPwRTnkYEBYJCqbkr8zSS
 LDOYVKqDLEAtgSwsVUSQM8klj2vuYSMVouwqzaw0C5i+0beeLcQRoVWWqVVeXvZg4uI5
 r5NJrGdjDq+6wgnPHNFbXA+sZbduZalPyhttYkKyG+t5U5iacWRsbZJRWnshOZ2eCsbq
 BF05MaTvkZE6XOcZgpcj5b7lXT4USLIEze41ZLzTf4+9pzfhVdlz79Wv3OzEj6oLKasO
 z08sdlyZL6NdN1vVMlX/5V1jMJSruvfZUq3n0Cj63KGcxYkw0heyJpL3P+YbJHOzBaTl
 31Pg==
X-Gm-Message-State: AOJu0YxrqgbpSQwJs6Ob90URP7OyBVGcYQHpD9YPonwq2Ly7JGpG2aED
 Ll1NhjEy5G/RvO0aTWHnWbwH7LzVqIeEs038j81tLKz/4pn8rBrcgEjogPIT2svgtQ1MKnprq6P
 T
X-Google-Smtp-Source: AGHT+IHUA11IW1AKvmEzUAac9DNZ0j6nmv78yeSZMEg64da3ya/uY+STP5HLyUYf8awk6HuH2Lf7Pw==
X-Received: by 2002:a05:6512:3e24:b0:52b:8455:fb1f with SMTP id
 2adb3069b0e04-52b895609e6mr12046025e87.10.1717495116852; 
 Tue, 04 Jun 2024 02:58:36 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd062fe96sm11004277f8f.67.2024.06.04.02.58.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jun 2024 02:58:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 27/32] hw/misc/debugexit: use runstate API instead of plain
 exit()
Date: Tue,  4 Jun 2024 11:56:03 +0200
Message-ID: <20240604095609.12285-28-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240604095609.12285-1-philmd@linaro.org>
References: <20240604095609.12285-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Thomas Weißschuh <thomas@t-8ch.de>

Directly calling exit() prevents any kind of management or handling.
Instead use the corresponding runstate API.
The default behavior of the runstate API is the same as exit().

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240523-debugexit-v1-1-d52fcaf7bf8b@t-8ch.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/debugexit.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/misc/debugexit.c b/hw/misc/debugexit.c
index ab6de69ce7..c5c562fd93 100644
--- a/hw/misc/debugexit.c
+++ b/hw/misc/debugexit.c
@@ -12,6 +12,7 @@
 #include "hw/qdev-properties.h"
 #include "qemu/module.h"
 #include "qom/object.h"
+#include "sysemu/runstate.h"
 
 #define TYPE_ISA_DEBUG_EXIT_DEVICE "isa-debug-exit"
 OBJECT_DECLARE_SIMPLE_TYPE(ISADebugExitState, ISA_DEBUG_EXIT_DEVICE)
@@ -32,7 +33,8 @@ static uint64_t debug_exit_read(void *opaque, hwaddr addr, unsigned size)
 static void debug_exit_write(void *opaque, hwaddr addr, uint64_t val,
                              unsigned width)
 {
-    exit((val << 1) | 1);
+    qemu_system_shutdown_request_with_code(SHUTDOWN_CAUSE_GUEST_SHUTDOWN,
+                                           (val << 1) | 1);
 }
 
 static const MemoryRegionOps debug_exit_ops = {
-- 
2.41.0



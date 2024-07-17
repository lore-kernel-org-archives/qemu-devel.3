Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5955EC3DA5E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 10:59:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2Lt-0002ji-PO; Wed, 17 Jul 2024 06:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU2Ls-0002ec-Fx
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:57:40 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU2Lq-0005cA-Ue
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:57:40 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-368313809a4so275675f8f.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 03:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721213851; x=1721818651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=anM9EOpDNnsAeOw8+e0Zh8fKDzaQ6DzWrkazNPeEQ8s=;
 b=u05j5Ay9z5riM9nRuuFpszVbqPt2OUksQTs0aRagCUeBrPlC6nKbg5PjYcYcjG2riC
 Z/gqDTG6id7tlDpXpQRY3npDJrXinh7zXn1LNjP9RhmmaZpInOsPg7NViONvsAYBwn8u
 4fAShowAK/mnHkkns+F3tw/qxnk+FEGkkACKATS2np0CVgZiv0JlohILFVi273awNKMQ
 yyMkYOzbDqwIoymGyqGpISRM0iq92eJZZj8UTobsk7ZInZxMdceb9pSX1kU64cSBXTai
 cBaTRdVdWzMrOF36p/M27wm8Got0Ux6kFitRDLPuKdjNB4fYypKgiGW373afM/or7gGz
 Q/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721213851; x=1721818651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=anM9EOpDNnsAeOw8+e0Zh8fKDzaQ6DzWrkazNPeEQ8s=;
 b=DxeoXvpO7yFI0cUIVCy5dq1bV4jsMBj7XE45ocWizeZug+7PmSwsmlyikR3cwI9UQn
 kz/j/8Gxvx3OWtVRapQu5rNKgE25LeMOaiBOYvbjbYljw6lhKPuXC2RQCecCmJTv7yrM
 YAZ0XxoLcONPfiJq7mrDdDu0csEUSyD452Mx+DFpKi/oEIBNd3gCtaTlwL3XydezVPhm
 xU3D3w0Ccp9BwCiF4WpKNG9XtU2MVSnal2U2FD6EVbcYimEiYmfaQ2m+SYsXSHojP+1q
 /q8CMY7VSFI8eL5uadSbQkB7iweaaB3sH0VTcyrrc5rP0omXK2NAuDh7eHl+HZoro3l4
 s5kw==
X-Gm-Message-State: AOJu0Yzu27B3o2bSao/F5K/Unmf2v2rFoKu106siQzHPh1A3e9N8a4uP
 dz2bJldLa3LTxtZeaVvTBNdc490Nr9NtyWxj9jYn492+sLv1SAPJaH8YKdIHeSVjXcru/QOwJfP
 LziB+FQ==
X-Google-Smtp-Source: AGHT+IEwovGhsY+bkb3/ZgiiCZom4FZB/H059O8NbmDHkvZVSmIHXKHRLHAXx9EkW43q3IwzdRR4pg==
X-Received: by 2002:a5d:4583:0:b0:368:377a:e8bb with SMTP id
 ffacd0b85a97d-368377aea6bmr808541f8f.28.1721213851197; 
 Wed, 17 Jul 2024 03:57:31 -0700 (PDT)
Received: from localhost.localdomain ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f25abf0sm204165295e9.14.2024.07.17.03.57.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jul 2024 03:57:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 1/8] semihosting: Include missing 'gdbstub/syscalls.h'
 header
Date: Wed, 17 Jul 2024 12:57:16 +0200
Message-ID: <20240717105723.58965-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240717105723.58965-1-philmd@linaro.org>
References: <20240717105723.58965-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

"semihosting/syscalls.h" requires definitions from
"gdbstub/syscalls.h", include it in order to avoid:

  include/semihosting/syscalls.h:23:38: error: unknown type name 'gdb_syscall_complete_cb'
  void semihost_sys_open(CPUState *cs, gdb_syscall_complete_cb complete,
                                       ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/semihosting/syscalls.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/semihosting/syscalls.h b/include/semihosting/syscalls.h
index 3a5ec229eb..b5937c619a 100644
--- a/include/semihosting/syscalls.h
+++ b/include/semihosting/syscalls.h
@@ -9,6 +9,8 @@
 #ifndef SEMIHOSTING_SYSCALLS_H
 #define SEMIHOSTING_SYSCALLS_H
 
+#include "gdbstub/syscalls.h"
+
 /*
  * Argument loading from the guest is performed by the caller;
  * results are returned via the 'complete' callback.
-- 
2.41.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A62C3DA61
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 09:48:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUNhs-0004Je-5H; Thu, 18 Jul 2024 05:45:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sUNhj-0003h1-DA
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:45:39 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sUNhd-0007dp-J5
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:45:39 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52ea5dc3c66so216187e87.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 02:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721295932; x=1721900732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TIv8kXkJQxNuIpW4TekgSCMbtMULcZSn0Uoke+OjUOE=;
 b=x7MWVlMRa0NaNFOWDd5dG7KUvwoGDJfrQ+bETitL8SCIunChPQX/e4JbkLsZtTQ2RZ
 CWSc1clwrk/c+xF5m6OUhgEcUFSKoNIqyOuxyDw/qtl3EtXZoAHYL598TWZ3qSWH3+2c
 zP8fFEr+ZlRAM6XdsLqYc8qM+/GDCxnAs6rE7caKtLnXVAUSNLYG3OhplAU7+vYgXQHO
 12grYzKZGtMpckF8Ha5ds9+XW7x1loTlGHoNH6Lo3DRBsZW8A+RCocW6q9Tj+98144tz
 IrS+4mcr1BXjmKkVyrcL77wUfuZ2T3E2ttGa3R1dGfR+aAlSMXxF3vrWHawPrxGrcro9
 ubAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721295932; x=1721900732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TIv8kXkJQxNuIpW4TekgSCMbtMULcZSn0Uoke+OjUOE=;
 b=ZZjiiVZE5eNAaygwLFmHXZEuWPXNpzZOefzd3EXotfrLbx0Txj7+s7qvUkoE4IDgDp
 u2W01c84ov3J94tgjMJKjKNEiBNmBioMSPPtw84UdruVcHBWtAZKgOkfnpY6qZf3K59I
 Ic6fWUjWP5xwLokVcRRyAumVc01047IbZgjIhugYslwc6TsBVdDcnHMYejsSSwYwELXB
 NuPe8griSMd0gMsyE1VtY/nbTxtBZzW8AN80I8d4HZg9JF6Ivc9CSTL+3ffNTOwBFydy
 S4rdaXr2hG6abSEyu6+kbQKooCoki7fttTgeeotpk/8v9CWSg5bkm2zNDfKCoN659D0W
 CQYg==
X-Gm-Message-State: AOJu0YzOc0+gXvxXRvhkmRVPCLBuFbbZVkxDpclmbkGQSTBIAlpgPuIK
 tJZXYbMHAaZonsZlkp9Eu84Z7q8o39xi+uY/w4SpascL3cEivU57eH0CtzNwM74=
X-Google-Smtp-Source: AGHT+IGp3dN7qhJXUtVzrL7rq1oB9YMtgrO102/BpwWX6muKcame7yTrvld/T24kNxIFrNNo4i4Niw==
X-Received: by 2002:a05:6512:12d4:b0:52c:e091:66e4 with SMTP id
 2adb3069b0e04-52ee5433cd3mr3475108e87.44.1721295931330; 
 Thu, 18 Jul 2024 02:45:31 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc820e32sm540039566b.204.2024.07.18.02.45.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 02:45:28 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C24075FA3D;
 Thu, 18 Jul 2024 10:45:24 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Bin Meng <bmeng.cn@gmail.com>, qemu-riscv@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Beraldo Leal <bleal@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Ed Maste <emaste@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 08/15] semihosting: Include missing 'gdbstub/syscalls.h' header
Date: Thu, 18 Jul 2024 10:45:16 +0100
Message-Id: <20240718094523.1198645-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240718094523.1198645-1-alex.bennee@linaro.org>
References: <20240718094523.1198645-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x129.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

"semihosting/syscalls.h" requires definitions from
"gdbstub/syscalls.h", include it in order to avoid:

  include/semihosting/syscalls.h:23:38: error: unknown type name 'gdb_syscall_complete_cb'
  void semihost_sys_open(CPUState *cs, gdb_syscall_complete_cb complete,
                                       ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240717105723.58965-2-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
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
2.39.2



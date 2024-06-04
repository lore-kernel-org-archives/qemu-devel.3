Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E45AC27C50
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 09:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQtz-0005Ih-A4; Tue, 04 Jun 2024 05:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQtx-0005Hg-IR
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:56:21 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQtv-00021f-Lm
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:56:21 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-354f3f6c3b1so826889f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 02:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717494977; x=1718099777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gcCJYiy8N4VBhdUv3burvHdpVxEgBVi2moNCcKrRfBA=;
 b=M2bQH9bQJK9K0Vh96uMX6+442VmSDtJlIWdQINKQaLs7NLmiMiOlmV1GMeNxH8KMdU
 j65LxeZXWu1Ogj0FXlZZ1fpQCBGSZjBullaV18DbKa+BBZUbXnM/61vCYJmehbXg7vUu
 liHzbIl64FwOE0Ss39QpTI9zEP3ECx7xqxt3OrnzuLOv29SJCrmbWQQFhDxbhKTq9Mt1
 ilEF4mKfZTezKZDQgyEDzBdCiNSKv9CxD3HzIvi5TSG82ww6KKJYMKzgB8OiKZE92QFH
 zkHVF7TqptM+etHGUkZBTv53Sdkjq9MXFd28dJrI02XAWuPuJXzPW0KxDqooWRGsmOax
 1M+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717494977; x=1718099777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gcCJYiy8N4VBhdUv3burvHdpVxEgBVi2moNCcKrRfBA=;
 b=uf22uOwKbBQO47cnRZUfVVvWoHs473AAmPpWBhFdCURVDY9Nkz+m+ul79Yg+U3rx4o
 ryJrv6vfyDwrWNcaikRwcvMpjhAR8rF6zuAKSYM/vsqJE94enkefVhOPrmfdwgNnplip
 ByiELXQQ69HzmbnSxy2Pmz5IOPAs7sERgl0BGf7v68hpim4DCzO7rqVLPak6d9LOrdl1
 kNE+ZGie54RTdQ8pnVIbP76i8Gvsve4vCFgRD5FqzmwPii/CJMochd+/vIP4dslN/D5L
 Neaw+yW5/aYTaCYqVSEBYyp9R9qCCnOrbbfVJ0F1VbxTTctpCkSMj71mB2fmyCqow4NZ
 cxNA==
X-Gm-Message-State: AOJu0Yw2ckDfNDUy070+nK3VMWMj9l9zqe4vqAeYu3yRNTfO5rTTyplq
 RxtIcJZhfFGUc/1QypA1us4U6fiCsJVXVtAuEV1MU5JfhEhBFDLld39B/SrnioiR9u0B1+8riYQ
 G
X-Google-Smtp-Source: AGHT+IHfK7kEuDLuzAHU50rjklAg5lDDfmOLGhsNMlUmjILR0rMNJIDvN3xdz7d53ta26FZo3M+YFg==
X-Received: by 2002:adf:f58e:0:b0:35b:5a14:984a with SMTP id
 ffacd0b85a97d-35e0f30c7d4mr8709071f8f.56.1717494976953; 
 Tue, 04 Jun 2024 02:56:16 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd064b684sm11187323f8f.100.2024.06.04.02.56.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jun 2024 02:56:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 01/32] target/riscv: Remove unused 'instmap.h' header in
 translate.c
Date: Tue,  4 Jun 2024 11:55:37 +0200
Message-ID: <20240604095609.12285-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240604095609.12285-1-philmd@linaro.org>
References: <20240604095609.12285-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20230626232007.8933-2-philmd@linaro.org>
---
 target/riscv/translate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 2c27fd4ce1..32a453f686 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -28,7 +28,6 @@
 #include "exec/log.h"
 #include "semihosting/semihost.h"
 
-#include "instmap.h"
 #include "internals.h"
 
 #define HELPER_H "helper.h"
-- 
2.41.0



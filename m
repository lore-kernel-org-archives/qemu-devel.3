Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB001E7718A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 01:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOSG8-00021s-UK; Thu, 19 Dec 2024 20:56:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSFv-0000xh-IW
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:56:43 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tOSFu-0004e0-0I
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 20:56:43 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-725ed193c9eso1283904b3a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 17:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734659800; x=1735264600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hja11IV5nNA1bZBHCKOlY+QF4apsmUpXaGb/2G3nPWw=;
 b=ilZZK2XfjsEoYjAsCMnc3o+BeXVDFeKjO7xi45xxDuEZtRXGafMrLNR9oVXx1eeMf3
 4/GRLQ6EQ/AActpFeqUUay0+pVFH7P37zv32sfxXOqWCtGC1de1qXlcrc/uKV6EmZ+bn
 bDIMDvia1bwr+KrtZi8q/WHe1urQCM5iZmXIbvMC6qvIRixA6GBej2PQlBiWClEkMuyN
 UY4gYBsTJm872iSKGN890/8Skn6yHjP2A5KoLLTy8tlWiTxj63/oLIJGfPwHQcoteZSg
 xTxw0sSQx9/kR7aBUVe7MhvLtKCstXUvVIMuAaJebCyYB5iYUTEQVYNNopJxQ/ujrF+L
 jtnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734659800; x=1735264600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hja11IV5nNA1bZBHCKOlY+QF4apsmUpXaGb/2G3nPWw=;
 b=LsyJrbzcFgFF8/XzpwC7ARjJODUCs37iF9X+wEIRKOcsNlS7bkEevibJjK6JeVJPhE
 Cxrp/d6grTrDjjlEjJc4dN4yjkHLOMI6Rtet2Lfj0M81QPWkyEKzHqYgaQCVSMBFJH8j
 hIhqtevdNA6HS31Gdhmp8PAX/c8o5t24B1aAjQ7nUSR/L5wURaww9qkFXhlVrZxwGNhw
 E+5NM0+yvv+tYzQMp79xnLN4vUxlX/p98LoKkbiZJooNuLK91QRAgtVzy7O3H0C4tvQO
 ZjkUoKGBc7iobjqMBysmP4aooiusG5dhqe40HlUzpv/J7QYighLk6LB7eIwrALE57UG4
 vHCQ==
X-Gm-Message-State: AOJu0YyAUiO6rnLqQ7KSmhkg/NhTNiJHoT7PKYH3Muj8qLCKt4VxB5dx
 tkDnt67FtMg5aIQr3P8NAvkPBo4kUctHagIkf/hNHV7ahjBH8JCllK+TA81K
X-Gm-Gg: ASbGnctD5pmWN/T9Rg/bpeapJvNgyFD6F6HB2mWvkvr/a/OPD3evZY9gZtL1KEB8f0i
 K0secWlX97JtF8a7rq9ZI7MacfNw8mlFLfkqzSUxRbrLL4YIJAYRpgcoCWixniaMSSmWb7JX4pv
 edKEblILKsM3jOafw++ZxwA99/iytjkCfIp1+4vMT1edAKOtOjgbz2/hXHvhxyHtiBWeXxzQvxN
 fQR+ULRCVdUyjRZmFRABoZmpGasICFZXSCnALZV2RCFYJpPL3Ok3ZZ7mWi7XR4qs/tlOtLoavYS
 ZZ4OrSn7dg7x33ayWxk4rAU0d9wlSmA46GBYcFhrxM1Ux2wmo1uFpWXJULQ5Gu4=
X-Google-Smtp-Source: AGHT+IHsn+jw4yQGh9Q3zguckdd3dIUaevudysAAdzt6GjEm8Ve/k2ZuFBDq6Iqj/5le8xd7tkH79w==
X-Received: by 2002:a05:6a21:394a:b0:1e0:df27:10d6 with SMTP id
 adf61e73a8af0-1e5e0497c5fmr2020057637.23.1734659800481; 
 Thu, 19 Dec 2024 17:56:40 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8164d3sm2002539b3a.15.2024.12.19.17.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 17:56:40 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL v2 35/39] target/riscv: Include missing headers in
 'vector_internals.h'
Date: Fri, 20 Dec 2024 11:54:35 +1000
Message-ID: <20241220015441.317236-36-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220015441.317236-1-alistair.francis@wdc.com>
References: <20241220015441.317236-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Rather than relying on implicit includes, explicit them,
in order to avoid when refactoring unrelated headers:

  target/riscv/vector_internals.h:36:12: error: call to undeclared function 'FIELD_EX32'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     36 |     return FIELD_EX32(simd_data(desc), VDATA, NF);
        |            ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20241203200828.47311-2-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_internals.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/vector_internals.h b/target/riscv/vector_internals.h
index 9e1e15b575..a11cc8366d 100644
--- a/target/riscv/vector_internals.h
+++ b/target/riscv/vector_internals.h
@@ -20,6 +20,7 @@
 #define TARGET_RISCV_VECTOR_INTERNALS_H
 
 #include "qemu/bitops.h"
+#include "hw/registerfields.h"
 #include "cpu.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "internals.h"
-- 
2.47.1



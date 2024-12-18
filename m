Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AD9E7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:38:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2cL-0007Ja-0f; Wed, 18 Dec 2024 17:34:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2aN-00049t-Sa
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:32:11 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2aL-0003Vd-PN
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:32:06 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso1588875ad.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561124; x=1735165924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hja11IV5nNA1bZBHCKOlY+QF4apsmUpXaGb/2G3nPWw=;
 b=jGe4rP/HYGJivCwbj7bqau2QNzTl4x262ENRYQL/okS2k8Q5ynbhBwa8nyP3CoEcBn
 DiHH3sbhxjZMRNpwnpi5fIVx57u7FHeKP8h9uZaEU+5M5NsRsUdgC3CDemFYQtvvroV7
 XAB2KvbZ1DXwRGcXCYC1P0BJQSoOQlIMedFIjkAn3APu0E3NpamvafbbrkLSzKOqx7Ai
 SUAiazkOOnVHbgiXmuFeQ//iocZjZ49VoQKqh+ynjS/uNkYYk6mYqjE4ukNwlZDpgrjg
 v0f2MXQOBJBKMa9hSZx9M1NYDrJ6vcY8GSxtfsSyh6tEsRdxtbDclSEMsebHL+moIEhm
 ygUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561124; x=1735165924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hja11IV5nNA1bZBHCKOlY+QF4apsmUpXaGb/2G3nPWw=;
 b=woT+hI4GH3t9R53fO4/8fpAC19lrnr7VHcc5h51CxXxG9JiJHrPB0mOAZaInMtWygC
 ZdkGM2wlHmwogzjHye6SSg5iKcIZIFNscKMFkZqAGPdnXoHDbfKXrfAQ7XdWxm2ms5iY
 UjGa01wyq44VKddBc4SBjfo11W33X8nyJWSxOdBmXx/jW0QTlV4Jq3usf6Aw+NSgR4Fa
 BUQBaJALnwP/QcMLSCYGUHIRp6ekljiFXSO2zTqmzJg5kU7lh4fo++ZKpqqz1jASbpWc
 jkMKyCKXWpwXtRZQn6JmzfTH/Q7YTFVrquD1M6R6cytE/okDiDIvp+/XzpYEkJZTCIB9
 kl3A==
X-Gm-Message-State: AOJu0YxLLMfmL3L1/atsVok1fK5qtlU8aqaCZn9ExOb8nUDxAf9jXbq7
 pScSZbJIkG2OWDyUT4m+qTj264ITOg3JU1cQXXTa9ce+p3qsWZgLL42/oNkN
X-Gm-Gg: ASbGncuhJrx8+t/RQQmiySv9a0SXa0+7PiDeCGDAWolmT33z6jlCWLPzugPg8ne3Xmg
 +8WW0bFpCEL00nfVfIb8mA/dvbBGSgdl7xQfkcWR13VbKFTl9HkkkA4KnikUZlmMqRJpPOOAvsN
 Mv0DNuqoaF5VgzZupJe9wn89sBnBTzuBjLoLIqNvwTAgjTrcn2E/Ca/Hc89t8YmClEbbebVVrzx
 T2RF7+r/wuRlO6z9sBS3iLZNXBgOi6zX+Vj/PvwL0w2v8kPvd3/RrDswPtwGlnMY3ruAjCCD+eq
 jNJjCl4RKZe8V0urgTGtPYHiRNo2MLNDWWLTqzJPmymyIyoabUx7QYA/Y7cc06s=
X-Google-Smtp-Source: AGHT+IEVa2JA97mkD1gKEtaY0Co6q+GESgmOKX1HsgpuEpyt3UPs15rZwvN59mARCDWNvRNMyX0e5w==
X-Received: by 2002:a17:902:e5cd:b0:215:a2e2:53fe with SMTP id
 d9443c01a7336-218d725a604mr68662315ad.40.1734561124169; 
 Wed, 18 Dec 2024 14:32:04 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:32:03 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 35/39] target/riscv: Include missing headers in
 'vector_internals.h'
Date: Thu, 19 Dec 2024 08:30:05 +1000
Message-ID: <20241218223010.1931245-36-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62f.google.com
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



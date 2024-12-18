Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1362E7718D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 22:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO2e4-0000ax-SK; Wed, 18 Dec 2024 17:35:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2aQ-0004Bt-D0
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:32:13 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tO2aO-0003Vw-LA
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 17:32:09 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2165448243fso2042235ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 14:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734561127; x=1735165927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jxMLDcONSvYYPpx6U61hKxGfs4I1jXSi4kLYiSJ5F/M=;
 b=HU9uhzcIaaK1VsF+cpHRY9C6VYa7n/yDz9Lerr9vSWMmsYcBwmChSjIYZbCJj0v3EA
 WjOfdG6IYe9NOxlWAK1jYBiMLQjYdQxbDix7v5obpsjYJu4/esId21awtxXOV5vIi3Ut
 lswLAsdqPmoOqAwUIpDs7O7mgha5sw+g9snf/A/1VokwfzCpV16ROAiXdD7YLv0J61wY
 eDMD+Q/IjI41NhseQFmGXsmTgHkMrADsz0iUkBeHP7mnAZL8+r/TtYWDM1ekc+DTSUgs
 sDFSoIc/Iq/tt/2pzBs3N9a83aZjOToAWi8h0ydlPiqRrlQAvhLZvH03Ijzq9OVcceBz
 e4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734561127; x=1735165927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jxMLDcONSvYYPpx6U61hKxGfs4I1jXSi4kLYiSJ5F/M=;
 b=On5X1zUBuNHftZSNUfr4erezeBVPc3l/cESciJnhV34msF4pTdhQBEOyf4ffxyJsu7
 bmyxulKAoGwKQu8uuVdXJh+8kn7/moqpcZ7oz8S2IOpx6MBHV8+mpQeWzy5+M+X9ZOE6
 sIHXZZpnsATQKGGS/neEm6m3ADnAqlK1VTWa5QSWGW76vyftp89L+tbw/ApOZLaTzF2W
 pCGuLAO+KX+2XBW7SKSuXINtqrob56B9Pvqa02J9Mqrh14tXSYJEB69lTw1ty6KOaweY
 1c8l7OrmBWdxhtm3XsMRrdoCC+C1H5tIbztbCdcyp+3ATzO8h6kakYk+glI6fpcj543y
 JhTg==
X-Gm-Message-State: AOJu0YzCJAR1qy2dE2fF+2/oiOvFcwD9HRHP5NLQL3IFhyHAiFYDdEEq
 AkCVuE8lhPaJ4YZAjXrgHDl87AIvSTFczpp8AfoIRR2iAD+OpveHypsgRGGL
X-Gm-Gg: ASbGncs16pbbrTZUMzwBYRQBseCDu6wvTI6veOQQtN3VLOxfqz3HaJSVxOyptUmQE1h
 cxd8hMYHB74pA6EA/71o57kOXXTrrsSErrdoe9HLpLUjwHiDgKT47uysHFhOysu/GXjB3QCpLcD
 l5kRVP4SfB5Op8ri42gbzsdIMeGiWeZS7xz7uiFGdc7dlASJc4GcyQpZEdXAnZRTgBRastz703/
 LpxoXCrVuZgZEyuaX49GJd9rhAhYvq6Noo+9lJ8uct34nfVHb/qzSA/c36h5zTgGNkLUaxIgrrC
 A1RU96QVp1MYrSNKRRNXCc4zrmWD3z3j4wfW9uMxUuUgqh8dXLwEzRc2uW8Y3NU=
X-Google-Smtp-Source: AGHT+IF3rriY4P5A3Rt8ahehMaI0RWgOE7hlhajjb9NqKHoJ8DLW5CHyc9VIaMT7EHlAqjNvkl5oFw==
X-Received: by 2002:a17:902:e542:b0:216:7d7e:c010 with SMTP id
 d9443c01a7336-218d7252c97mr62049165ad.37.1734561127143; 
 Wed, 18 Dec 2024 14:32:07 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc9705d7sm375775ad.102.2024.12.18.14.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 14:32:06 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 36/39] target/riscv: Include missing headers in 'internals.h'
Date: Thu, 19 Dec 2024 08:30:06 +1000
Message-ID: <20241218223010.1931245-37-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218223010.1931245-1-alistair.francis@wdc.com>
References: <20241218223010.1931245-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
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

  target/riscv/internals.h:49:15: error: use of undeclared identifier 'PRV_S'
     49 |         ret = PRV_S;
        |               ^
  target/riscv/internals.h:93:9: error: call to undeclared function 'env_archcpu'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     93 |     if (env_archcpu(env)->cfg.ext_zfinx) {
        |         ^
  target/riscv/internals.h:101:15: error: unknown type name 'float32'; did you mean 'float'?
    101 | static inline float32 check_nanbox_s(CPURISCVState *env, uint64_t f)
        |               ^~~~~~~
        |               float

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20241203200828.47311-3-philmd@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/internals.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index ddbdee885b..76934eaa7b 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -19,7 +19,10 @@
 #ifndef RISCV_CPU_INTERNALS_H
 #define RISCV_CPU_INTERNALS_H
 
+#include "exec/cpu-common.h"
 #include "hw/registerfields.h"
+#include "fpu/softfloat-types.h"
+#include "target/riscv/cpu_bits.h"
 
 /*
  * The current MMU Modes are:
-- 
2.47.1



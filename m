Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91812EE01F6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 21:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vagzA-0001co-R3; Tue, 30 Dec 2025 16:10:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagym-0001JR-2M
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:10:10 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagyj-0002Yd-5i
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:10:07 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-430f57cd471so5006284f8f.0
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 13:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767129003; x=1767733803; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aWZ/wGhyjNTDvmvQyGMp4r18x0TBLO5WgYXXIpLUaQg=;
 b=f6SQupp5E+KDMq6YYap3MCRcTCqB+Q6sr83AcTZvF6W8l75Vy/00pXCuhWCCm7chGD
 +GfrWCIkN9Fr0EdpuoGMpCeVWSElBIWl2mxuZJ6yuY4uuZxaoMTb3dzeGBhFPkcZE9+z
 zQygEHTS6KVOYiyUCLskf4sRm+1xFxIsXIQ93MT/sASfLRKxhLan6EU5zuG/PHzEC8WZ
 5qX65NdWUU1l4ZVfgXWYen+J8lisf3Y6FG6nPmPRB1+CoLeOikK8kEfkqQ04OKw3cBGO
 Xl5YPzKLdModDQWvkQgY8ECBPV2zp5mMocS4IiQjpSeg4G00Dsq2/yTXRNykrdoNw++k
 76Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767129003; x=1767733803;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aWZ/wGhyjNTDvmvQyGMp4r18x0TBLO5WgYXXIpLUaQg=;
 b=ib4lBDtiMROBR5d4LzItKXX3oq/aXfIOmPnHrVbcWPJt9mj/MYEBxGQJ8RupSNSYYe
 x92jmUIAGjmkzIS07q35Qd7SfPoCSBLVO4GiPX1Uzysi4sRqhTG0gjjMfu1RT7JtZ7wA
 g/ELiyljCGczkxonZHxh1n0Ht1BYnEpEmZ9cqhtqGorg1Do5Hzb2te4jQBZKpaCXWsZh
 NvaUEmriNiDXgSvPSDRD4e/TzM9gQ5U99KCEASLQtRE26nMcyFr2gbaASivIfGilveMV
 VPL/Pgfzw15rd8wJONP+wgM0aMdJ94aRmTzNq2jfikBAfUE7cWInWMnvktSiM0F+bB7s
 Jvmw==
X-Gm-Message-State: AOJu0Yxnwjn5CbFNvYR6Dnzm3ID4Q61QFkQ1Moj/ldpQMuoUM46yP3oN
 TOyUTPAVxHktl4C71aXIZvPFO/FKlNMw6Ds+c3KP/JlxC7+w3KTplda+2hm4Be7NmdqrT1l4B/T
 IyEt3i64=
X-Gm-Gg: AY/fxX5nG9BkkZoL01jB6LaNQOm57ZagSm85ufxkf+lmF+4qJAh+XZZJ5dAjBiG6ZTb
 N5DmxnKbYB+wU2y8Dr6z/ol0CV1Nd1UBl0T/naFGFW3Zjs8ELJahYYuJgFsArJhl27r/+C86peQ
 CF7PPfwHkjnBMizIEx3H+otl4JwwvxtQJswwPqSz2RX8AUmpiWKQUNrJx2lYnv5hWDIQYuIZDc9
 y9ixd+cvBqq492PaT5aHn0UxHw8u0tmLLxjk7X9+XmbKgzz6dg5q31GrOlZ1FuXmGMd/rteBc7z
 cnL3gwtTtvd5BLk82qUPTKnIYhyhZ7U2yVfI5Ebtn8RLIRMEJI1xi+EABWRTq8ltyYLxGebMa+y
 u9xFREapFjbf743X8aX0FKYrugH63SS2RmrlB/oBG4TRkyv+l5n/elhAoaYk/H9SeCzEn08ypUf
 DvuVtzbDs3rIVYSYsCEzn4zir3BGsHJQW8Q5DxZ+uGr1cLV5XGfFhNlXdCc0Ti
X-Google-Smtp-Source: AGHT+IFedSR6Q+ZstquTPJxsRRYF2RqcXOnttR5U2EYfYKcywkm9JQ9awEXysIRZnwDp6Wyfcn2UCQ==
X-Received: by 2002:a05:6000:2dc7:b0:430:ff0c:35fb with SMTP id
 ffacd0b85a97d-4324e50d03dmr39984358f8f.52.1767129003310; 
 Tue, 30 Dec 2025 13:10:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea830f3sm69502845f8f.22.2025.12.30.13.10.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 13:10:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/34] target/hexagon: Include missing 'cpu.h' header in
 'internal.h'
Date: Tue, 30 Dec 2025 22:07:41 +0100
Message-ID: <20251230210757.13803-20-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210757.13803-1-philmd@linaro.org>
References: <20251230210757.13803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Both CPUHexagonState and TOTAL_PER_THREAD_REGS are defined
in "cpu.h" which is luckily indirectly included. However when
refactoring unrelated files we get:

  In file included from target/hexagon/helper.h:18,
                   from include/exec/helper-proto.h.inc:56,
                   from include/exec/helper-proto.h:13,
                   from target/hexagon/op_helper.c:22:
  target/hexagon/internal.h: At top level:
  target/hexagon/internal.h:29:25: error: unknown type name ‘CPUHexagonState’; did you mean ‘CPUPluginState’?
     29 | void hexagon_debug_vreg(CPUHexagonState *env, int regnum);
        |                         ^~~~~~~~~~~~~~~
        |                         CPUPluginState
  target/hexagon/internal.h:30:25: error: unknown type name ‘CPUHexagonState’; did you mean ‘CPUPluginState’?
     30 | void hexagon_debug_qreg(CPUHexagonState *env, int regnum);
        |                         ^~~~~~~~~~~~~~~
        |                         CPUPluginState
  target/hexagon/internal.h:31:20: error: unknown type name ‘CPUHexagonState’; did you mean ‘CPUPluginState’?
     31 | void hexagon_debug(CPUHexagonState *env);
        |                    ^~~~~~~~~~~~~~~
        |                    CPUPluginState
  target/hexagon/internal.h:33:44: error: ‘TOTAL_PER_THREAD_REGS’ undeclared here (not in a function)
     33 | extern const char * const hexagon_regnames[TOTAL_PER_THREAD_REGS];
        |                                            ^~~~~~~~~~~~~~~~~~~~~

Fix that by including the missing header.

We don't need the "qemu/log.h" since commit 0cb73cb5a02 ("target/hexagon:
Remove HEX_DEBUG/HEX_DEBUG_LOG"): remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Message-Id: <20251224134644.85582-9-philmd@linaro.org>
---
 target/hexagon/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h
index 32e96f00d97..5fc837ae229 100644
--- a/target/hexagon/internal.h
+++ b/target/hexagon/internal.h
@@ -18,7 +18,7 @@
 #ifndef HEXAGON_INTERNAL_H
 #define HEXAGON_INTERNAL_H
 
-#include "qemu/log.h"
+#include "target/hexagon/cpu.h"
 
 int hexagon_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int hexagon_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
-- 
2.52.0



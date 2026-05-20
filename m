Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B85CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmYl-0002Uz-35; Wed, 20 May 2026 15:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmYT-00022S-4Q
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:26:12 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmYQ-0002XZ-4D
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:26:08 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso44232525e9.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779305163; x=1779909963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kBr+LBh4ShdLh2TbYc/Cau75o/rd59lVQzLibQM/zcc=;
 b=QPZKPmAvHLF4q4POBFvK2nmgoqfOmi7Mg8emINlORB67DZMOvGCJV+V9xK5byrR3HI
 0wSf+tOK1ukQOMQqefkttBzcFQZ/nNHjoEyCBuap1/MlPacTQGwGa5veJaVC7wg5dqtW
 H3MXxumlIX1DzkzzE1BvVcU4vTJ9R/uOCD/nWvdsw4QXKwhpMn9RSxBaoDzmsReoyt6s
 1Ezsr59O4N1LQYZ19GR6saDioPiXD9i8MdpjsZ89TndrrlJfnAmouAHYvjldGz0FhAzx
 VxF5SN9X4f0exKyA2TCeHIBMcOzV7aJZ0F6obeQacWqnD0A+oWm6LPWgDMb5vGEg+TBp
 2log==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305163; x=1779909963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kBr+LBh4ShdLh2TbYc/Cau75o/rd59lVQzLibQM/zcc=;
 b=sColPAaDi4ICD/48NDK6UWOBJ6eJgop0FSXCB3rJ5w2+Bigg/R9zvyjeOj37vASgt1
 gmlrq57RDN7bdPKPXGCpFcSktiGEM8rz01hV4Awra/G1T4AAR6KpdIrBNKnQzmZOGZlq
 NVtGXoapA+6rN861SRR6K8c0/N+eFcygyjIeW+ATv2Y9nkzz564rq0DgwZZkoGqzhvFm
 u7zalXYxKiK/1UzVyI3a5oJ25zEakd4cb5I+sGaqItlTFR+PNaXV9mydLZHn+3otEgcN
 IGGL8y+Z4pxzoSGyN/3V5505O460xlaPWNaMUUGLjFIQ+0iBx6IOz0ZSJniyyhJbqQ8b
 2oSA==
X-Gm-Message-State: AOJu0YzodRLVZMmgOGchzmc5RhgHrGkpxO+uOJMV+l4BiDwTX21Yc1qe
 VAM5q7qUTDXtbWk2TIaeg4lY8t/tXhysKH7JwerPSwgFRIsiyKwFyuTAHnPNeyniR1H/GGhBwLI
 Amt81mHg=
X-Gm-Gg: Acq92OGQ6KLczIv1nB0PZYAVRQ6GTSeKcMDclvF0BdE34WV3FereyOE7sgC0FTfWVnY
 QTvLJwtg4FpqmGzYQay61Sn2i6Vguw/3jspUTy5toSIkC1ky/QpfuJVRf3d0D14u6e7s26dWsG5
 BUZcD77DHuidrgQwi3W2Ku4d8/zuNzBtlSVoS0+pwjRobEjZefMqejqYYdhI69A2clZFkPBJTxY
 mLdBI9NPUjAfVj9JgWse5V9tyXTMtljX8zn4CJ7AmH+vYdKzQWT31ZdB+SVElFCZFDSjXPQ+8lz
 I5enSdH41BaMrU4+48jemqmmcaXrEAaV7TXX4+s76Gnevs11uQdTf8jrBOnPmlOlQ7OAwgGh6Cp
 lYmlGw+Q55jS8xMv2QHQltZmyChkxx4qaPBeO373G4NHGS4J8Hw75HxtUR7E76FoeB/CPPF21Cv
 Buc+NuwL6p6fdEHjbe3LaY18PAwASalLZS6p31Y2+uvuoJRad1c/+j9AlQMaMcgwkVIHaNoLyiX
 rBRxbapyaM=
X-Received: by 2002:a05:600c:6d2:b0:48f:f199:4c02 with SMTP id
 5b1f17b1804b1-48ff1994c86mr202027545e9.9.1779305162912; 
 Wed, 20 May 2026 12:26:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d8e24bsm11874915e9.10.2026.05.20.12.26.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 12:26:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/33] target/mips: add Octeon LWUX instruction
Date: Wed, 20 May 2026 21:23:25 +0200
Message-ID: <20260520192338.40036-21-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520192338.40036-1-philmd@linaro.org>
References: <20260520192338.40036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: James Hilliard <james.hilliard1@gmail.com>

LWUX performs an indexed unsigned word load from base + index and
zero-extends the result into rd.

Add the decode entry and route it through the common indexed-load
translator with MO_UL.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20260520172313.23777-13-philmd@linaro.org>
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 8a755075e8e..db7d5f55f0a 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -50,5 +50,6 @@ LWX          011111 ..... ..... ..... 00000 001010 @lx
 LHX          011111 ..... ..... ..... 00100 001010 @lx
 LHUX         011111 ..... ..... ..... 10100 001010 @lx
 LBUX         011111 ..... ..... ..... 00110 001010 @lx
+LWUX         011111 ..... ..... ..... 10000 001010 @lx
 LBX          011111 ..... ..... ..... 10110 001010 @lx
 LDX          011111 ..... ..... ..... 01000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index f897b42807b..401c4bd14bb 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -166,4 +166,5 @@ TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);
 TRANS(LHUX, trans_lx, MO_UW);
 TRANS(LWX,  trans_lx, MO_SL);
+TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);
-- 
2.53.0



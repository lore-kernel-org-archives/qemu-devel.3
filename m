Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD73CCD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkfT-0005UG-0Q; Wed, 20 May 2026 13:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkf6-0005Nk-3V
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:24:53 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkez-0003q1-J4
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:24:47 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43d734223e4so3423390f8f.0
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297883; x=1779902683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xj4LscJe5qbbyCvumcZkKMp4Wyep599tHoKrYhpUv9c=;
 b=bTZxUB2cPVp6dPyugYl5H8QNtlenHSqJ2nNJvguC3uTKuYrHnpAWF9S5KgdbRzdAh4
 q4QNGJCmF6s4qReqG3SbbAA927xmu5oLPgpF9RDMnFpGrkcohu2LvrwOK/GZJ3HLhiAL
 zmMBcH6RnMg551vb7kbsGtFtj41zsxS/1hwIgftxQdBkeNPXEs2Hb4duSq7xTvvBwlm5
 Y/8rKMVIe7e/LqOvlMBbjt0vnx4WijYuqnrigt46R0xpPnHpNL2KIBFr/u/9sjzDxwNT
 3WEp8wNDurCbs9tS8S7fkgByOz7K/OBZ+6aUePrqsViEGJBJ+l7JVZ82VFb+a0Avblk8
 oM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297883; x=1779902683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xj4LscJe5qbbyCvumcZkKMp4Wyep599tHoKrYhpUv9c=;
 b=s5TPNM8uyjB9eeB9QgjkNWqvQ/cJnoRzNtFUCxVarx+xqyoz+vnPHOnQF3xniaXFjY
 MaUD73HbxYvYEFs5F2LzEHPNffWA/px7yIN5GN9/AEq4yuBgI5y1rh5NoUzM+eYvaapl
 BmJpBXAysPG818NPAQmjl0Firrn9ct+eLF9agUYiNDuSIoMExA6rf6HlGsPC7GPbiOdK
 L1/fxtStWvdRG1b5gIxT5qTXr0uhuycnsyS3YbAjGXW/D6iswOQ9JR8eZptN7L1WiiEQ
 lW9et4sVED/qGiBdPRXSOm6MsReMihZMEG8KvzAYaHzyc5b4YyJTKqyQ8Y0Npj21ca23
 3tRA==
X-Gm-Message-State: AOJu0YxlnMJFxH/MCdctPvf7cIJkhD/38i/oWnI8p5rzq9tmkE8ivBj8
 EwqMxbv/CiX+WhdmxWzzKvZ0190R1QP0rGbtJp7ncq47jvtG3xUm3tZX2yG1NoWZ3W6sCIDrEe2
 VSbmvXVY=
X-Gm-Gg: Acq92OGsdgl+CQdcldL955Os6Hi9U4NNaqsN7zdcihy6+qqhbeWhVY2CEFrKlby0GjI
 F+g/CjX37DNjkkkSHNfs/4PGdMIgckAKJd4pD//d1lyaNY8stWV2JICj+42ytm0Upv/leZEsuou
 XN2TO3oSkW7CbFyT0Pm4oOPJEue8mxN+iwxRtwBhtyTSDnLpDYtFZ73GrCQDtHoIdxDNiQNkL45
 tBIyE6QXMJj662cV7p7TEvRYZ0ki5D2OBFA7YtZmLMluRlAjJ+APp2jBFaL8fPrUFaAMB4cPXjj
 GibrIrFUWEdYu3sMcjkyXbt0Z/maJsUAHUSMX62IPv8wZ+KytmqTROMgtmx9vuBmEKfSlyerIor
 2h6ieyeo3L/R2v5nO28p3SAtteFv+4WWhj5TwkUVlcTXAi9oTB2BMqwtpoTwl23YKw9rUICVIWI
 bdIaoDB7XoXK4A0xCLDAh4pB5FJmgMSm5Am+1ykCu995PwwOQwwt9PNDOrnctV5rftRC9SlHT1
X-Received: by 2002:a5d:5d86:0:b0:453:dc4d:9265 with SMTP id
 ffacd0b85a97d-45ea0b1c8fdmr763945f8f.10.1779297883518; 
 Wed, 20 May 2026 10:24:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a562dsm56505130f8f.33.2026.05.20.10.24.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 10:24:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v12 12/24] target/mips: add Octeon LWUX instruction
Date: Wed, 20 May 2026 19:23:00 +0200
Message-ID: <20260520172313.23777-13-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520172313.23777-1-philmd@linaro.org>
References: <20260520172313.23777-1-philmd@linaro.org>
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



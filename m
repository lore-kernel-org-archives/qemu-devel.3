Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6665CC54E41
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 14:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhsa3-0006kc-2s; Wed, 06 Mar 2024 09:49:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsZy-0006h9-Nu
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:49:10 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rhsZp-0004Mf-WA
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 09:49:10 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33d90dfe73cso621532f8f.0
 for <qemu-devel@nongnu.org>; Wed, 06 Mar 2024 06:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709736540; x=1710341340; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jSaTEw7HdvNrh+oHFXPMzlQIiNjmc7BE8/LanxovJAc=;
 b=cFTWRlYHDd4S6pg8OOc3wIiZK70ccK+ru75QlQPg8eW4jvzHivzuJEbHzlGlFfNaNm
 9CRrBFp2kP31RRWJ2fTTgZ2PEC0BO/t6QMGT9U5JVfCcqx966ognDKeo3vjyruMgnRtQ
 rvRnzieB2vqmBaKbUqyQiH5gZlPm1kssDmhfWK8YUdeiCJWK2Qz+iu72mD0eJ7QphM0f
 KBM6pWa61oO4vxw6tFMxPsULiL/1v98aQ7oZnPUADUVAMzf3nTZ+zlQvUSWdMjwegR+1
 3BEtCKhhKTlUhXaiuDTtphF4YQE7w0COoo2dvzGSY1fa4U2dfSN9XLFO6I3+dws2u3u4
 2+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709736540; x=1710341340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jSaTEw7HdvNrh+oHFXPMzlQIiNjmc7BE8/LanxovJAc=;
 b=RXTXJP6FPDot2ilLF6lkElf2wFyUv/hAiylgK0omzj3Letlf+Fw2N6Cp1Id4Uiruyz
 k5/aL633SSi704MCiYu9KI9cYs3/sSrl1vO8nUdZkEUlpfDf/JuQuYsPBdqZFEIVAiG+
 sce7JbtRvPBB9QuS50wNYqoRsLVybZFI4mHcauG0aurP4Gn9lZPdE++5JJjFLcG+lT2q
 KIXnxOVzIrnsGmnuw/tu+yD/M9VpLvo3ompOI51jaY2Efpe0zH0sNslALTELwTYgJfwL
 uYUwRYyRQI0JeSs6H9geEEI6B8TlXFd1GQJe0iBxP1rbd7Nk8hQXPlcNqljZ4gfJb0XH
 Zdmg==
X-Gm-Message-State: AOJu0YyAD+QGlmWdtU3KTAertAcPN5ymnuSc84LVlfF45xYR8SgB1cLm
 uiks7zIZNb9vk4VbHKpF5SlzObFh/rhB9mn585LE4ySWHoY5tZRdOJVz/S7Hbc+E37R9mkQydQe
 K
X-Google-Smtp-Source: AGHT+IHOW3aIAwxkRLfxwqMAuH940EfdHziP4jBHM/ilfN/PqPpdaqWZGmewI30bezUVMLG/d3BCow==
X-Received: by 2002:a5d:4212:0:b0:33e:835:668b with SMTP id
 n18-20020a5d4212000000b0033e0835668bmr5030839wrq.22.1709736540304; 
 Wed, 06 Mar 2024 06:49:00 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 cr11-20020a05600004eb00b0033dd2c3131fsm17580691wrb.65.2024.03.06.06.48.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Mar 2024 06:49:00 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E358C5F9F3;
 Wed,  6 Mar 2024 14:40:43 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 26/29] disas: introduce show_opcodes
Date: Wed,  6 Mar 2024 14:40:38 +0000
Message-Id: <20240306144041.3787188-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240306144041.3787188-1-alex.bennee@linaro.org>
References: <20240306144041.3787188-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

For plugins we don't expect the raw opcodes in the disassembly. We
already deal with this by hand crafting our capstone call but for
other diassemblers we need a flag. Introduce show_opcodes which
defaults to off.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240305121005.3528075-27-alex.bennee@linaro.org>

diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
index 2324f6b1a46..b26867b6417 100644
--- a/include/disas/dis-asm.h
+++ b/include/disas/dis-asm.h
@@ -396,6 +396,14 @@ typedef struct disassemble_info {
   /* Command line options specific to the target disassembler.  */
   char * disassembler_options;
 
+  /*
+   * When true instruct the disassembler it may preface the
+   * disassembly with the opcodes values if it wants to. This is
+   * mainly for the benefit of the plugin interface which doesn't want
+   * that.
+   */
+  bool show_opcodes;
+
   /* Field intended to be used by targets in any way they deem suitable.  */
   void *target_info;
 
diff --git a/disas/disas.c b/disas/disas.c
index 0d2d06c2ecc..17170d291ec 100644
--- a/disas/disas.c
+++ b/disas/disas.c
@@ -299,6 +299,7 @@ void disas(FILE *out, const void *code, size_t size)
     s.info.buffer = code;
     s.info.buffer_vma = (uintptr_t)code;
     s.info.buffer_length = size;
+    s.info.show_opcodes = true;
 
     if (s.info.cap_arch >= 0 && cap_disas_host(&s.info, code, size)) {
         return;
-- 
2.39.2



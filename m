Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E611AC38150
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPl08-0002ge-NZ; Fri, 05 Jul 2024 11:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPkzw-0002bL-4m
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:37:20 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPkzu-0001Hj-HN
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:37:19 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-58ba3e38028so2365220a12.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720193837; x=1720798637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RP3B/0cPkW5+Move7SaNmebJelEP2P1mPvRnO3rEjf4=;
 b=lvuWJuOSWefr+gjQaTwklWxx6VQ/e/GNzz6gurV7EfnRg0A14rW8XpivBgCQyP0ptN
 SeMm9Uc4jpJTsNPGUEbD4gRR5R+k8KiukAk6jltJubbSYoCD2lRxZV+UAMhYyFI4O4LX
 C62BP3YJ/jeq4X5XRzUfAHsGMpO/72T7IV1X4BuaGMXgTfT3GWKmNH5Fch2H8VhUPKuz
 Q7tCDUIDcnAQxy79M/vGSLNkvOTHprtBcU7Sp5qbTPXGgND3MHDve7hWk99acl84Bxhf
 S6H9l6tBqacfSveLRxiGdA1r75qZDIUIBa4XPtIu9kv+sLDr8l2VHkeWRzDbjcZi095U
 dGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193837; x=1720798637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RP3B/0cPkW5+Move7SaNmebJelEP2P1mPvRnO3rEjf4=;
 b=PBHbZkRRi8NWwu9E2QapLOv00Mcdk54GAVNEI4C52Hqv7Qq3x3lOJH9VCXpVyNIaJZ
 j6oBPOeRMtPSvXP46jgtZXBE7ai2GcFu0x55XJksorG8mxG9/hqomHxlIPpPczyNo6vW
 8A86arqZZvRGTUKWXe/4XJrnZD7XdSIorQtbVkLEJYBVhcGrSzKMimPbqqwROWvCtcVl
 pyIJnUPBFM8f7J9V5mN5eZRuOVmdecCnKAo0BtMC3YZPAOXKfpnquW+8VgqX5hyRQAa7
 ZM8/s/MwPvt5fDGo1/RmLM89pMH5GkMVtALUO63qq5h7YO+r0/N8KFAG17gb0BKxFUVs
 YnWQ==
X-Gm-Message-State: AOJu0YyV4aSRtPz7mtzT0wx8/DVsqptP5/efSrAHKkP+1A/epxBJ0TS8
 Z8iIrROnLR3hsxO0+s8vC5gV90+lO6MYKB3OwPgI+F2ZiXzGruXtaIR3ifrDq0U=
X-Google-Smtp-Source: AGHT+IEsXcdPA9DWU3UXkw9eQ3VkaZvKs7/u4HBjVDh7e/yRtBHCqEXbAfRYLaa3ao0IyM8dUnbuMg==
X-Received: by 2002:a05:6402:2548:b0:585:c001:c1b5 with SMTP id
 4fb4d7f45d1cf-58e5a6f21bemr3745678a12.5.1720193836880; 
 Fri, 05 Jul 2024 08:37:16 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58f9893a747sm972496a12.19.2024.07.05.08.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:37:14 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4891E62142;
 Fri,  5 Jul 2024 16:30:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 24/40] plugins/lockstep: make mixed-mode safe
Date: Fri,  5 Jul 2024 16:30:36 +0100
Message-Id: <20240705153052.1219696-25-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705153052.1219696-1-alex.bennee@linaro.org>
References: <20240705153052.1219696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
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

The ExecState is shared across the socket and if we want to compare
say 64 bit and 32 bit binaries we need the two to use the same sizes
for things.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240705084047.857176-25-alex.bennee@linaro.org>

diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index 67a779ee9d..8b90b37f67 100644
--- a/contrib/plugins/lockstep.c
+++ b/contrib/plugins/lockstep.c
@@ -57,7 +57,7 @@ typedef struct {
 /* The execution state we compare */
 typedef struct {
     uint64_t pc;
-    unsigned long insn_count;
+    uint64_t insn_count;
 } ExecState;
 
 typedef struct {
@@ -148,7 +148,7 @@ static void report_divergance(ExecState *us, ExecState *them)
 
         g_string_printf(out,
                         "Δ insn_count @ 0x%016" PRIx64
-                        " (%ld) vs 0x%016" PRIx64 " (%ld)\n",
+                        " (%"PRId64") vs 0x%016" PRIx64 " (%"PRId64")\n",
                         us->pc, us->insn_count, them->pc, them->insn_count);
 
         for (entry = log, i = 0;
-- 
2.39.2



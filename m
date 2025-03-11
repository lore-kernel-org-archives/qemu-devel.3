Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19441C28B30
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzKx-0002TN-Cf; Tue, 11 Mar 2025 09:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzEN-0005TK-Sp; Tue, 11 Mar 2025 09:01:21 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzEK-0000Db-IS; Tue, 11 Mar 2025 09:01:10 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2feae794508so8085970a91.0; 
 Tue, 11 Mar 2025 06:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698065; x=1742302865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Qg32i2ZNEVpFinMGEejCFLsCi4jerRMng5QMzQ5ljg=;
 b=jPOZJ1W6a7aU1DT7kM0gJiUtabIfAzBQb4KKuH26N0KVhsiWN8YCeVLipCpN7B/zC+
 y2DYd8Xb/Yph0IdPxGmUTKz0GiqWoSd0Zc1nIofNqDh6uq17ooVECq357hRBRAw1gMqE
 4y6MPGXX4It96/6JjjmFOq6b7w1kkd1bE0OcOBqtP1Wj52GiyCQtHr4CUJ4PVCYP6TU1
 L8GJwNXd5VM5ocge0sXvJYUUNh5FXpfK8ks4aGV5ubii17gB8BOuD4Y1KX0GRcSLaEEp
 LWLYOmmXVJfu2PSzeHm7ad5I/0cebsZlfd5I2CyMgvggkOerjps2CcY21l9iBu9tNj64
 L7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698065; x=1742302865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Qg32i2ZNEVpFinMGEejCFLsCi4jerRMng5QMzQ5ljg=;
 b=IdqH/hlw4he3UCoVoeyEAB8EpozjnY/dhVCpEkZLlrJB9a0+9dQUMmHlcrDhUtB4ZV
 YGC5n3ToYhnpk8SMLygpOQQ+E3Sa4rBqjGAJKs/Sdmka27rdu6IfcJIAe6Cl0P0LFDqO
 P9wGhJDEDozFUACbSrPgKENjBwZ6xHTCW5++iykDzmHXTd5wkVK+sKL1DojkFyjh5CZs
 SxjQL5ueodq5jZgtew0P8eHFnQQzSiAK8ziXLnDeSnBldkfG/QZDd5Q/+/Zz8lThjdCc
 H9nwzanTEIp/bLDVwEgSTf0EF1EJfqcTCohp3hATZrweckCqSwfQp0EK58rdrlZwpgGX
 f62A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeSkxcgUlu7YwIP65J3tMk8i17+OdlUgQI3UYeHGdsw1CbtH+CeMo6Pm+10LDiDjp6K3xOQneKWQ==@nongnu.org
X-Gm-Message-State: AOJu0YyIlBmgbFYmqzuzbHnqfSOht+W7rD3oGnQmDSMKaVa6zUD5tIrD
 uTwDbGae/v3Yrc7PSDC6leHU1l40q5BnEBHYSe5TEtLpF9ZD8L9orWPtjw==
X-Gm-Gg: ASbGncsD74c4hbiuy+05dcEIcw79DfWJ0FxwOrA/+U+j7DEW/cdXkw++OXXFtT81j96
 6k9CyEzPLjSNJ32DeCfjP43O8maPEVFXFVoUtm99dg78hWFQ1N83SOVimIcA1+P0adUb1i4HijD
 ATv3oYr9RiYPJ0QBgAZtFxmXUEucCJMLGTkvJ3aWUwMwniCY9frycS9aB3BjwCfLqk1rZsndQz7
 HlmFaadjM/J7/Z/aaqcEcOOgpFX64PfDtP1oBbdxMZJgFktihnQptoGpcAEGo8ZuDQTgmnc9ja2
 gixdNTXYE1JW4xgXrZFiFdPnMDaNVGBUQ36mLvE0w9OJMJgVlk8=
X-Google-Smtp-Source: AGHT+IEwarqDwS1tOb+Lcio8qbjL4V185hjh6m8ZxICy60WOf2aj6Auap8YBaJFrK7xSUUIxW68g1Q==
X-Received: by 2002:a17:90b:1c05:b0:2ee:a583:e616 with SMTP id
 98e67ed59e1d1-2ff7ce6d543mr27902162a91.9.1741698065313; 
 Tue, 11 Mar 2025 06:01:05 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.01.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:01:04 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 52/72] target/ppc: Make powerpc_excp() prototype public
Date: Tue, 11 Mar 2025 22:57:46 +1000
Message-ID: <20250311125815.903177-53-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

In order to move TCG specific code dependent on powerpc_excp()
in the next commit, expose its prototype in "internal.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Message-ID: <20250127102620.39159-14-philmd@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 2 +-
 target/ppc/internal.h    | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 659852543f..9ba5335698 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1571,7 +1571,7 @@ static inline void powerpc_excp_books(PowerPCCPU *cpu, int excp)
 }
 #endif /* TARGET_PPC64 */
 
-static void powerpc_excp(PowerPCCPU *cpu, int excp)
+void powerpc_excp(PowerPCCPU *cpu, int excp)
 {
     CPUPPCState *env = &cpu->env;
 
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 62186bc1e6..9012d3809c 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -291,6 +291,8 @@ bool ppc_cpu_debug_check_breakpoint(CPUState *cs);
 bool ppc_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp);
 
 G_NORETURN void powerpc_checkstop(CPUPPCState *env, const char *reason);
+void powerpc_excp(PowerPCCPU *cpu, int excp);
+
 #endif /* !CONFIG_USER_ONLY */
 
 FIELD(GER_MSK, XMSK, 0, 4)
-- 
2.47.1



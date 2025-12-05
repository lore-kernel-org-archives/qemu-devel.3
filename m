Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFD7D32D9C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 15:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRXSr-0003dP-D6; Fri, 05 Dec 2025 10:11:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRXSp-0003bt-Nt
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:11:19 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRXSo-0001Rg-8L
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 10:11:19 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-47778b23f64so14294655e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 07:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764947477; x=1765552277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SNRoxsNNrYd1+8NJrEKrokd9NPN4VEeWaFFpiw4lBGU=;
 b=EV9kqBqhkbgPotbM8PWa8huUzaT/jVLZzbNtfxcgRAzCGRvHLTM6igwGGak2GHwqWY
 dxZBWSrigXRjhZ9q4vLR8k5o+3YmvVjf9vd5NYBWHN3Wu+XMDwlxPIUSimA4905VZnlp
 gZgJuWZfbtEwFu73Dqe8JJhe7d8kWTJOM35PvivrfPqlm51geNIVmpgUe4krIpBP63PI
 aFzumXAcNXzT4P0zCKV+hKAnu/yk9yg/Sp290y6w3pflKIyAas5/hPZu91YUIoha1myS
 pN7O0wZsXE6udtY+y95IksbNt02axlQ2JhV/nl3GDS/OPII8JdYh8elA99Cm+pvmkNNe
 MzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764947477; x=1765552277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SNRoxsNNrYd1+8NJrEKrokd9NPN4VEeWaFFpiw4lBGU=;
 b=PBa6TY6mTzN8iARQWzxFzOYbUrBJi8xdAYZ5aiCT26XtCIr6T6sZZTWqBg9/jkf3Q8
 ZTok2TyJGnaQq2JmWKbHAXDALwUP8VY1cCGc+QPfEmvgGK4lKVekkEjMtxfpJP3M36Y1
 VmHXCdve4KbZwTw4xapzLSGHdOmik3eC1/mnamnhq4vSpiOZsC6RG/TaxfDNIlcjP7gw
 J+AacOOnmvV8PkeOObyiKuaarM/cXywWrwFVVQ6dvNioJqklMpeF0l3SP3bTYDV1Tbx4
 44VMtbsVqlY9jlKE0hfsmQnmjj15Bbycf5PxBTJaUlsbKZPKLfK41CZGqHozuA0GA0nO
 kGcw==
X-Gm-Message-State: AOJu0YwrtEpO5LE8K9yW7zjD7hL2++TProLh4cls13Qvc6Vd93ceoRyr
 4+mwEiem47GpMA/btph10fRdf7FY0biuBnHoc7IAnmIg0U05HDsvHga37fRUD/Xxlp0=
X-Gm-Gg: ASbGncsFY1PpT3GV9AkLOXiRxH4jqihM7TecVOZvh1ctl5x0d7UzRWACHfXdSduxhjA
 2k2RbzZf0UNl6OZmSJgkMVwDRpIIwZ3NK+Uyq9SB0nzZpdLe2frMA9yn+wSVLqVqX2JhA1ITfd1
 wy9Mrl+Y6KGh6eg0j2ZuZavXRcsPhtVM7NdmZPzQ5EVp1CxqOBcis+ue+aDHo+O7vxKHRgmlFxm
 J7KDRun7vTRUHmrUSHYJuUm4h99L8ofIfPSBdt4XFPE6AhKfyrylzIMRaMxOYKVpo0Gnr5kyYFG
 oYP6MW9s//jB5+BDOM7oHMZNqx0W4vyMG/OwmvwLRTRjpJ9Mgg/RX95nGeY2TXpKzQqdCMcj1HT
 NxtfIuT8TZSe+3mYDL1Z+uDkqGZDL1G1jCagKDZkzCSnJgwYi7dl6UxPw788V31IKBiXRxsWsVd
 sFY/W9sY661Dw=
X-Google-Smtp-Source: AGHT+IGT9nMbbGKbe0jvIAstlq9HEshYBDi2cuW5ilozLcsEOgE8dadbKnKf/wfgUO2Hq3l1x1dkoQ==
X-Received: by 2002:a05:600c:3106:b0:46e:1a5e:211 with SMTP id
 5b1f17b1804b1-4792af1b207mr106135245e9.21.1764947476663; 
 Fri, 05 Dec 2025 07:11:16 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47930ca15adsm93255835e9.13.2025.12.05.07.11.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 07:11:16 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 71E565F833;
 Fri, 05 Dec 2025 15:11:15 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 1/2] Revert "target/arm: Re-use arm_is_psci_call() in HVF"
Date: Fri,  5 Dec 2025 15:11:14 +0000
Message-ID: <20251205151115.2035930-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251205151115.2035930-1-alex.bennee@linaro.org>
References: <20251205151115.2035930-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

This breaks a pure HVF (--disable-tcg) build because the fallback stub
will always report false.

This reverts commit 4695daacc068cd0aa9a91c0063c4f2a9ec9b7ba1.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/hvf/hvf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index de1e8fb8a05..70d34063df8 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1935,7 +1935,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
         break;
     case EC_AA64_HVC:
         cpu_synchronize_state(cpu);
-        if (arm_is_psci_call(arm_cpu, EXCP_HVC)) {
+        if (arm_cpu->psci_conduit == QEMU_PSCI_CONDUIT_HVC) {
             /* Do NOT advance $pc for HVC */
             if (!hvf_handle_psci_call(cpu)) {
                 trace_hvf_unknown_hvc(env->pc, env->xregs[0]);
@@ -1949,7 +1949,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
         break;
     case EC_AA64_SMC:
         cpu_synchronize_state(cpu);
-        if (arm_is_psci_call(arm_cpu, EXCP_SMC)) {
+        if (arm_cpu->psci_conduit == QEMU_PSCI_CONDUIT_SMC) {
             /* Secure Monitor Call exception, we need to advance $pc */
             advance_pc = true;
 
-- 
2.47.3



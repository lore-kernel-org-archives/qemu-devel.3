Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72210CCF9F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 15:58:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE8Yu-0005mH-QF; Wed, 29 Oct 2025 11:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8Yf-0005O3-CG
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:57:59 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vE8YR-0003Y4-Ul
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 11:57:56 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-63bea08a326so10581740a12.3
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 08:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761753453; x=1762358253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VMZ8smhJoOFXlVYHZrThhvPhMrsexYC+bniZ9hCR8Ac=;
 b=uYG0vhbtZbAUHbdSRebkWmbAINJBy5du9FO+nKhh8skO2YWu+V+tSvGqIC2vGTn5Ro
 GebSbgTVgfHHJYKM/Fo4+BysOWTCIGYtH7aPz6dsGacK6T1zdkTxl9pTzaL5uefIARZL
 +l7VSNvsB+LCGhcgC4dYI4LoAvb2mUAvRcJpV/MnxCGjVS7Ruc2HAtz66cvq4T/xOx9C
 izsTVgYmxxX3kcUn1UWsOltdtR4yKyyIn8aqt3cb0ZML/p06xxae2f8BDry9w3U4GjdR
 zyRrHL4A0F0TorjP/7vxZ6kETQfs85tzkaQFCkof2TxO8/xw6ruI31e2z0hsJLG/h5vE
 CW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761753453; x=1762358253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VMZ8smhJoOFXlVYHZrThhvPhMrsexYC+bniZ9hCR8Ac=;
 b=qrNMKr+kFeIvu/JuOnyOVM+H/P/dNEOX2xDpZ5NzIjIUd4IsM/VWjWeIsH6D5VPhZF
 jbpAcFD4319VULUO3y48zxKW0BbE/vzLNTI/lqHYkbrGU7clDpH5HkgDmvhC6qAAdUsN
 zh8GMb9cVOIeZA2zUZhQCVXTfqN6ssNGM6JR9dpTxKqmr8BQlKNELcB1OmpY1Go5+2Ru
 ALssjktVeHiEkCihGs1dWSsHd4FsAci5Aw22/MBsDMiEOr0czc/O576zDO+mjaBzMv+m
 UwKTJkgFTx69ZiV3I1ESy5ygADJqfP1GygdoeCDS1z2jEMz31+n50r7KE/tl7H6hqbbj
 lJZw==
X-Gm-Message-State: AOJu0Ywcxwg17vkA17QjMDnB9SSTCcbRcf1MGEGNYi3fw7ndurkshMHD
 t1v6eETNxd98dfnb+C8WFbU1lYSQjMP/LHJnWdJNSjeAs58/R2JvlwjVP3xwsOmJOVw=
X-Gm-Gg: ASbGncsAmonhObiCcWgh97p+ocA/XFfJNzawX0V3meVxOSRc3mcD9NFz0I59RAuaSOV
 STYMdjBcZSL8H5sqG11ZyGEQ+6lPGVQFO1qtTPY+JClraG2PDGan3khJNdVBOBpNaQxO2Da4SZb
 V41zA8QASRpiTEmoTph78skXbLroeCkBSd4egXjTDhR5GJjgnkUOXeTb84nWi9q9j7PFhdtst+C
 hdUGNkrmZC3ZyuvyhBXGluCM0RU1Zc5wM42j8Q0hFxxe/ECu6TCIydKxlDOL4tfoO3rAdCiKwiH
 NfOQh3+oi/6zSd5Pz9WYtwUx+ATFEvZo/8qR19rwYasulzSKZNovyR8ScBmsOjoZe3CQUhLkzvs
 w3YUHMO4mEJgWYC48lO+5/a1a/E/Gd5iUKTon5yBb2n5SC8j2L+0qXkXBOGUd5ykljVOLAwqnUY
 Ug
X-Google-Smtp-Source: AGHT+IEFR5WgsjTAhfOCc8293iI6N7DEgFbm+6qB7nZfQEAYYWH16dtVqi7CqJw//qeCs7ahrkr8xA==
X-Received: by 2002:a05:6402:1d4b:b0:63c:32a6:e9ff with SMTP id
 4fb4d7f45d1cf-6404418a630mr2909489a12.8.1761753453187; 
 Wed, 29 Oct 2025 08:57:33 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e7efb818esm11750111a12.24.2025.10.29.08.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 08:57:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 82A5360F51;
 Wed, 29 Oct 2025 15:50:48 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 27/35] target/tricore: call plugin trap callbacks
Date: Wed, 29 Oct 2025 15:50:36 +0000
Message-ID: <20251029155045.257802-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251029155045.257802-1-alex.bennee@linaro.org>
References: <20251029155045.257802-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Julian Ganz <neither@nut.email>

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places an exception hook for TriCore targets. Interrupts are
not implemented for this target and it has no host calls.

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Julian Ganz <neither@nut.email>
Message-ID: <20251027110344.2289945-28-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index 610f148a237..2c8281a67e0 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -19,6 +19,7 @@
 #include "qemu/host-utils.h"
 #include "exec/helper-proto.h"
 #include "accel/tcg/cpu-ldst.h"
+#include "qemu/plugin.h"
 #include <zlib.h> /* for crc32 */
 
 
@@ -29,8 +30,11 @@ void raise_exception_sync_internal(CPUTriCoreState *env, uint32_t class, int tin
                                    uintptr_t pc, uint32_t fcd_pc)
 {
     CPUState *cs = env_cpu(env);
+    uint64_t last_pc;
+
     /* in case we come from a helper-call we need to restore the PC */
     cpu_restore_state(cs, pc);
+    last_pc = env->PC;
 
     /* Tin is loaded into d[15] */
     env->gpr_d[15] = tin;
@@ -90,6 +94,7 @@ void raise_exception_sync_internal(CPUTriCoreState *env, uint32_t class, int tin
     /* Update PC using the trap vector table */
     env->PC = env->BTV | (class << 5);
 
+    qemu_plugin_vcpu_exception_cb(cs, last_pc);
     cpu_loop_exit(cs);
 }
 
-- 
2.47.3



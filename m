Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE3AF9EDCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 13:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFXE1-0001BF-4I; Wed, 22 Apr 2026 09:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFXDu-00017B-CP
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 09:02:37 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFXDs-00017x-SK
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 09:02:34 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b941762394aso742002366b.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 06:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776862951; x=1777467751; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LHt/fkh4CQTgDK0U2IQzNp32v6ZUUxM/zBvWXPy5kqQ=;
 b=Wxi+pm+99B7NDMe/CvI0mI8ztzTd/FlU2nGgcxJCBRffewpwxpf/g4Oh0MDH4fI2Si
 A1HZMPWqLACQQ1OBSo5GheiwLYVMCgCYx5FPHq7+OoiMTYLvAADenPkxwZ153g09fosi
 J2TClK4r/I50GUy86DeX2J8dOWRZoEOPLl8KGQOHlzqg/iHd5nMIn/qkGtgwqve2ea4V
 /ewbFKAdX2/+0VA01tA3sRgAy/YBmYw8IrNzj8rHUM5UCVuaL9t2FKaL+KYsJeaQj04y
 +sbfofDMLV0vxTi0dwD3y1qqSMfOIIuOQSEWZJ3oLJf6G8IRlmJFSwR2eNC8TXRbLzV5
 pVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776862951; x=1777467751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LHt/fkh4CQTgDK0U2IQzNp32v6ZUUxM/zBvWXPy5kqQ=;
 b=T2cqTiLx7SKo4SfjcmVgcm/ypD/PVsOHyGim+5kLKgI01QWHtWotBSjF1H8BlHo+Mb
 kCmARPaq3QOLrUpBFFRh78/5rMC9sZ2TTOThMOaQvxaL+bcS3GoSr3pG8ju8kEO92q+l
 GahxAHmMxTThx1R03Eo2AOEUAgUJEuJXM52/jgEzmmsqpmUFzQu5OXawXGfGZy/lKQ6i
 NZ567gN8p2UE6+Uwn/dQR/uNYJfBVDw0OMJ65DA9sdL4OHMNJnXwvTJOvbmUiheJcU6z
 wK0Lw2WpPAJjW/admQyNHudw/iVW70qw/usG5TpLBaw1yRQeqZKluesTlfRLERWfDNH/
 DKvA==
X-Gm-Message-State: AOJu0Yz2w7rc+LC1XzBWIvW6kvZuRdfXULIc9whyELUC/wJsKDbQQoJC
 KPoq49s8fsIozsY39o5XOny6BSq8mHc9x0QiL3kbDFTdCHnrD0RPWq+v4/rNxrjeVKA=
X-Gm-Gg: AeBDiesWaBLqEj3NWmW86q7XrOlOBMilAWWNNuEhZd+FTosZF63X/27umUm1TQnucSx
 ogZ8tIivvwkVNnJaG7vckJAL4sP/qo85xBB4SHvaaOPL1YqamRw42knfV5xCI8sEdtO6dy7lL4r
 gRJdWRJCfU7epnkYW7JHnCdaP25Z4RgJCtQrIowUDMJJ1DJJKOZw6xk9bq5uJoGyUFpNFahYCMx
 5KQeFKrCD3WR1suiE0mc9K/RIFJg4E/XqiudSk+1L+lkDKV+/q+M90z2SZ9yWtM/VNITe3Fn7TV
 zz6HclzM24QqOrtaQzwNl2CswtU/ua45roOQDExwrRS+3Xt/mWmqmaiYmJGXEIkxHBlAALdZRS9
 JGa3ZnRWL/1udjZcE65x6RAs2mM5oRlqg6T7BkyGD4i+/YXXFNNi931U3oon5Us4Fdwa3Hd8kgT
 ySoA2zRdOcpJ9hUfXVdBO2OOyUqei/HxG1tw==
X-Received: by 2002:a17:907:3d4c:b0:bab:1e1d:40b9 with SMTP id
 a640c23a62f3a-bab1e1d40fdmr140947566b.44.1776862950837; 
 Wed, 22 Apr 2026 06:02:30 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4d6casm41420944f8f.32.2026.04.22.06.02.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 06:02:27 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 15D7E61667;
 Wed, 22 Apr 2026 13:52:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 26/32] target/arm: ensure aarch64 DISAS_WFE will exit
Date: Wed, 22 Apr 2026 13:52:43 +0100
Message-ID: <20260422125250.1303100-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422125250.1303100-1-alex.bennee@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

This mirrors the logic for DISAS_WFE in 32 bit world.

Fixes: 252ec405768 (target-arm: implement WFE/YIELD as a yield for AArch64)
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/tcg/translate-a64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 073454b9195..d79c8ab431b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10917,6 +10917,7 @@ static void aarch64_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         case DISAS_WFE:
             gen_a64_update_pc(dc, 4);
             gen_helper_wfe(tcg_env);
+            tcg_gen_exit_tb(NULL, 0);
             break;
         case DISAS_YIELD:
             gen_a64_update_pc(dc, 4);
-- 
2.47.3



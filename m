Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14695C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUagT-0008Up-HO; Mon, 29 Jan 2024 18:05:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUaeB-0006xo-7v
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:02:39 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUae9-00005H-Lm
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:02:34 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6ddc0c02593so1489575b3a.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706569352; x=1707174152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mOPcVGQzJ6S800tkZazccfXJHRzcbDUG6SoAa/uVeRg=;
 b=utIwoHYBZ2XpeKrSNphEJ/8P7a+iq70nO4oAQitxwzJtWvzxPlWUmeYCi0qGy/QaWi
 sLQKtkbaTgyThnTp+U0pJXF1um47feB2kp63nZX7d0l7Y/nwXfU6fKU/JFT0wW4C/6NU
 NS2h0NtsJc8U6avH6YefOPJZwcHA+JCEhjqjVtdg2+m4mDKYMUVO1CIFzls3NILlaDLk
 Pz+8u4+HYA5jNuwMKUxgHVMRLfn2ctL2c2XqQ6TF/shchAxSKQ0r/8kmuh0FRhfEVOCt
 0CxOoeplMqPDoj4r+raZg/o9nqhymYTSLtR5QVTZL/76VsPxgrlpDsYoXgDgIBkL753R
 xXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706569352; x=1707174152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mOPcVGQzJ6S800tkZazccfXJHRzcbDUG6SoAa/uVeRg=;
 b=qCcJ87UUx8BdBmIkqj3nQyieDOa+JdSvyhbeo2dXQRx2CHESjaQQeKpUxvREidw4TD
 i+8GFWoRudPhtpxHBeO5IuTVuuX3PAHUIwfW8GnQKSbhsjlK3DF+nNTG+kNj2moNpuqo
 yp5y9z+mca0cuGmWkazl+3QoZr0JVymmxkvsfS1QeEUCfkiX0dfWme92bIGaeLoCm9Hx
 LGDjuwgdEP/RXNS6HzPSCc7jMkO55PY1AE4ce1us5rS5wE79exyBb+QY3Yb6NjoUBIOR
 PDCDrWJIBnKi8RsXiD4/zhFNHVAzISCXcv4qLI6sMZWCxz6nIx5YCqIGCXND9G0VwJ5P
 tXBQ==
X-Gm-Message-State: AOJu0YxTikyOc2qRcqGH4C2hyAYb5fwjG3xVYJ+Cy5Ow9wE9dVYwHVoj
 N9B4kLaPZ3LlPheT3pnn42XKLEl1Occt/KnQTQES2TVh4s4uxsuX32GuCGlHSCkTTzsoJTGETnk
 XhWo=
X-Google-Smtp-Source: AGHT+IEOs4hYoxBzj6NRdLGYBdhNm+09r6c0rK57T204LDDquNjtMyBvBPTJaK8Wuf+yPKji2GoXFQ==
X-Received: by 2002:a05:6a00:2f13:b0:6dd:b12f:c394 with SMTP id
 fe19-20020a056a002f1300b006ddb12fc394mr2848911pfb.32.1706569352011; 
 Mon, 29 Jan 2024 15:02:32 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 r10-20020aa78b8a000000b006ddcf56fb78sm6419368pfd.62.2024.01.29.15.02.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:02:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/31] target/loongarch: Constify loongarch_tcg_ops
Date: Tue, 30 Jan 2024 09:01:15 +1000
Message-Id: <20240129230121.8091-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129230121.8091-1-richard.henderson@linaro.org>
References: <20240129230121.8091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index dd3e46a726..fb8dde7def 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -734,7 +734,7 @@ void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 #ifdef CONFIG_TCG
 #include "hw/core/tcg-cpu-ops.h"
 
-static TCGCPUOps loongarch_tcg_ops = {
+static const TCGCPUOps loongarch_tcg_ops = {
     .initialize = loongarch_translate_init,
     .synchronize_from_tb = loongarch_cpu_synchronize_from_tb,
     .restore_state_to_opc = loongarch_restore_state_to_opc,
-- 
2.34.1



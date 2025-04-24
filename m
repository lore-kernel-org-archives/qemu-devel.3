Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0715BC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kw0-000358-FP; Wed, 23 Apr 2025 20:59:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktU-0005pQ-V4
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:52 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7ktR-00055x-Vw
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:56:48 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-73712952e1cso396493b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456204; x=1746061004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N1UQyMwl8FkxNsbxCkJPrCVn5egihsCexcKX6axRuSQ=;
 b=WS1C1c+ugBjrYIdqnineW9M7Z3D7knUAFxMWIoRtsZammahAZvhLvHxdXYUY1IMfkW
 eVtKMdFB3nt2frsU4GbMHQiT/klZCG4m3QVlN/0ER9lcFHJSBmTat+34bH7n0Msij6sE
 poQ+gCQ8DYczPaI4QreIYL/eKRarG1k8ffPPv4f+L2KIjPj+oxnHfpsGFwSe8q9rCfPP
 NsCTMLdk75W/VfB1ggI72xR8IU7/Veg/K/csJGQaHQpCFP2+B5mFhE/JPuWqXJGdlnIG
 AU/CJpyhZ50rtYOABco3Yd4wzAd09CBwW4z8RZnaMPGvOZmu/HS+Ar0oi5sixOIHjKOr
 vFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456204; x=1746061004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N1UQyMwl8FkxNsbxCkJPrCVn5egihsCexcKX6axRuSQ=;
 b=TdXA87wuy40D3LezwCwwJydF/JSVJh+YNHm8rN+xuHYJfq9Qio1huBqVupSSB7MxcW
 h2FYAfRjEKZ1o074rtcQ3/yWlOunFIeC2HtA9mbaB5KVnjeEDiP+UKKG5jifdI2e6yUw
 36K0YY0NJZEtqLhVAmZB4zLBhxsy5yq+UBJJp1VYYyVoEiTlBsIB7YUkwcYn8LVdDooT
 condG/LK3ZI/4Ktuf+L4lI14jg5IXglemtbLlTgB2fKHrOpDlYYEcPCmBmg358cCSqXC
 BTbZLUKkTyFfHO2boWhOzkhSyoaCXP3ohx6rnaw3vOHpu4G5os0DMZJfMpB+K63GqghH
 hECQ==
X-Gm-Message-State: AOJu0YzGvd+ylPRi3GbtwQqOHhpskL3/9JNY2yWD6JTNWZHk7ojkLBQU
 k6LO7DxwiOFr/KzODR6O7qvpsy7Yl1Hh8+K4uyeedz6vEItYJVyDGsEcsAFevJ7jvpYoxj25KDx
 m
X-Gm-Gg: ASbGncsk3HbVDmcLkVmOxhNo68n+8xJtH9hlurmHSB9PZFhCweqz+2mgYbg//FqaMZz
 tg793WUOjLbNcqHQsIE42pQASJ+VjtaH4vYnrelQ/90H668GRxxTT0B80DW1sTZvpjmNGez6+Wg
 tIDKHQHuzg8lf3fFF4Py+c2CWPd2S80xOCihp3kXOcCzCItln0fR63j/v1Vx4gYEXXgt+vO2Ozw
 hjSoxh168QyCvYvkVKL5/pJERE3L0k0lJFOmlFLe2m+UBDbXpqF7A4QrXEr18lsS1EUMnPgEYQH
 sIrnTQ1SC3bVsp1qDURJKr0+fKeSDof554NdiAYfG2APzbXdmpKHjEHKK4CEW6ZQf3mS9zLUR6o
 =
X-Google-Smtp-Source: AGHT+IEjQNNf7QNYkzcIa6PawSwDDPPkT/W9J10UmWhT7URaBjnVCCyuU0Z+7GB4GkSAA3/Li0T/0g==
X-Received: by 2002:a05:6a20:6f88:b0:1f0:e3df:fe1 with SMTP id
 adf61e73a8af0-20444e6e4d2mr893118637.4.1745456203776; 
 Wed, 23 Apr 2025 17:56:43 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa907fcdsm119775a12.54.2025.04.23.17.56.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:56:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PULL 094/148] target/hexagon: Implement TCGCPUOps.mmu_index
Date: Wed, 23 Apr 2025 17:48:39 -0700
Message-ID: <20250424004934.598783-95-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

This hook is about to become mandatory.  Since hexagon
is still user-only, the implementation is trivial.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hexagon/cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 766b678651..ad1f303fbc 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -313,6 +313,11 @@ static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
     mcc->parent_realize(dev, errp);
 }
 
+static int hexagon_cpu_mmu_index(CPUState *cs, bool ifetch)
+{
+    return MMU_USER_IDX;
+}
+
 static void hexagon_cpu_init(Object *obj)
 {
 }
@@ -324,6 +329,7 @@ static const TCGCPUOps hexagon_tcg_ops = {
     .translate_code = hexagon_translate_code,
     .synchronize_from_tb = hexagon_cpu_synchronize_from_tb,
     .restore_state_to_opc = hexagon_restore_state_to_opc,
+    .mmu_index = hexagon_cpu_mmu_index,
 };
 
 static void hexagon_cpu_class_init(ObjectClass *c, void *data)
-- 
2.43.0



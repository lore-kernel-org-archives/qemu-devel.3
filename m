Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1443C5CFC1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 19:50:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvKKq-0007Sq-1Q; Sat, 15 Aug 2026 15:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvKKh-0007Jm-Qc
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 15:46:21 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvKKf-0008L8-D5
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 15:46:19 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2ccf2360620so21440805ad.3
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 12:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786823176; x=1787427976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l5FefkHt4+mIAwzFGxwVE4fW9WR3b86gApc4aXRCX/Q=;
 b=yehZofRQ7Z/gNC9jJNCKPylGA6hUwn6fST0Coxi3Zi3tq/svwvIPIhIvE7ZXI4lQWJ
 Eo1KAenPJOTlXlJC9zyVFoKWkXWx1qyp6pcAKpmhFA+xcScvTYEGNndtnr5NdOHxEKx/
 t9mp8B1amcJaHrzI/KtQ0ZnIx6+8laR5dvbkcwISZ4tng51QQGyX6DAU8tX0wmcP2fmp
 IRDA6c9JFTiHuABUQWbk/NXfPfr0YWZTpwXqWzskKjC/bIGlFY9CgZTX3SG3ekYL/dGX
 JTR1rTw9cQtZT5CZMNaYhJYljkrXQGyeZLGrc26nyZnN28A6xIhTBMZszKOSpay7XTpY
 TCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786823176; x=1787427976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=l5FefkHt4+mIAwzFGxwVE4fW9WR3b86gApc4aXRCX/Q=;
 b=rEXxi+8HBxpuQ9aySx3QpYj10Rh/IiJG33D1oki9PdknOZUz/AL0jWiK25xWgfCXI9
 tOjvO+rRD+CclpMg3Ezl8OgYd2YF02LN7ilcyb17da8vdyKcXxD4llMJdeeYEAZqhVXi
 ShSxW4FkORZODRfQKQVTIL/hS2BioN0r5YL8WsIMO9JSg81JHDwtU7FkINlcUH6q0Ocp
 zncqY7dv8rjCGoMF9atM+ris7Nbu1IkJeXzkx96JQuQ/iXjy5eODXGCiNweKSo5Bfgjx
 cgPF5QUdL3P9PM8wqK9eThKaRvfYwgdECKtnmh+Y+ZO6pS/4bl8dsw4UBNs20G1zSYqv
 zFEQ==
X-Gm-Message-State: AOJu0Yxam/WDdZsQMYikuitpxfcubbJgtl3xvhF9J+nKXeChtPc1l8Rh
 RomhckLPZreNo5/MCziw9miG/1j1dJJBnNzYD2XXzy6H4E4XBd0KKBg9eZJ3qftdShfRVvjUlAm
 NF5sd
X-Gm-Gg: AR+sD1152dcWd2Ayq36DRbebadLnxQvWCyzard4Kj48vuKFfQqLxciv3LuSjGUYnIkZ
 zgsaUK/IuWqNS7LJ0EK/SbaeIYoetcDZidT5UW3SLHCfFqpfaRpF79AhGEJlb7EjKcjk6+irByw
 w270ijnUn5IXxEwLPg/X2HHyWgl9WNGAXSM3gU6+0VOx5GLOHEShDsXs9PVGIbtwuJrXg/95ugA
 THfdUe1tNqASXQpkX9T5z/VPRMmtvWQacY4AZl83+jYRbSrvCv2IQc/HrnwzLddHY+Mn+8IWtME
 GKFWqQKHQav1UUmnch25SarkHQ6w8e96klQwnDYhGkcwZx6EY9bGOlB6Ywdrqyb6iBjqR6CVxwj
 iNyblK9AKYm2wv7w9elh/D0G3iJJA1WTi3hoXjIaWHF12yyJ1MdNZDDv8DU87HHRkWhoZdGOrDl
 YwMAeKkccwhdLTNTyJ47U/oS4SRcF3Jq3JMJx6iM7VKj5nbOk6WxNuXPvKjVP2uNXx8PXYXpMAB
 iVrCRAKliDnza5h8ATT
X-Received: by 2002:a17:902:d592:b0:2c2:62ee:5a0d with SMTP id
 d9443c01a7336-2d3b0d5cec9mr179207975ad.14.1786823175954; 
 Sat, 15 Aug 2026 12:46:15 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d3ae753ebcsm21179465ad.5.2026.08.15.12.46.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 12:46:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: frank.chang@sifive.com,
	max.chou@sifive.com,
	qemu-riscv@nongnu.org
Subject: [PATCH 15/23] target/riscv: Remove unused VDATA,WD
Date: Sat, 15 Aug 2026 12:45:40 -0700
Message-ID: <20260815194549.1377505-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260815194549.1377505-1-richard.henderson@linaro.org>
References: <20260815194549.1377505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/internals.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 5d84e4de96..9e4da39ea0 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -94,7 +94,6 @@ FIELD(VDATA, VTA, 4, 1)
 FIELD(VDATA, VTA_ALL_1S, 5, 1)
 FIELD(VDATA, VMA, 6, 1)
 FIELD(VDATA, NF, 7, 4)
-FIELD(VDATA, WD, 7, 1)
 
 /* float point classify helpers */
 target_ulong fclass_h_bf16(uint64_t frs1);
-- 
2.43.0



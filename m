Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 891D6C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmcx-0000zh-Jy; Fri, 17 Jan 2025 08:43:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcu-0000x4-I3
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:08 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcq-0002Cy-8c
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:07 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aa68b513abcso397510966b.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737121381; x=1737726181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SUu6i8T057JPO442k8CSrwOIxRNKi1DJo3XfOqemq7M=;
 b=gpceqZ25XuXEym/X1EKiqezLap5I0/ZMG58Yg0xM7NTmfT6PPSlEdEYLP+NDxREjYE
 mvS1786s0D/KnmSTVdvEVw2ZXQDXBhRfIIAAYew82+x23lPC8WQh5HF3eWDofx0I79fU
 tFt9ETMIK9/y6ikaxIDAuwH1yuxJDQ5Ozt/h78i/43zg2dm4e5aG5VwnUpEFRkfD1Aus
 nNTPlIAk45bqPW9X0RaBo1g8TgCFO2FSnZW79OesOoP4Pmkt4gOADh/yO4XH2li3uZth
 POYBDEnjDrA6vn7i4pMEFIKAYjvfpqPO50foZnqPmL8GInGEMWNxsHeskmbTMIm6ochD
 Bvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737121381; x=1737726181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SUu6i8T057JPO442k8CSrwOIxRNKi1DJo3XfOqemq7M=;
 b=lBjuJLui3RTmFb0nT++jmfVDbPNhMRPY/GZrHMaFuo07+O85fCRYplU7+vqoJSA0x1
 vVmsEg7r+tGQGp10ocBQLtlaXHA4s0pm+HrxgatcqJ2wzmQnmDYYAGnNHQCB79yGzXyQ
 2GxmMC9jX2G5nPY6qvhCF+zjWGz7tZDaC9/MHrtYBxHrRIUeJK5cXGWIC0vu6YWsOVU4
 GZTHAC0V00UFEsewb6bWtOMQiQDrft4i71m6AaQglUqmjXgApQ/Tmv8tSi+GLrN/mvGE
 92tUPO6Ch/5WY7COBHf287meuPvey5ijp66EUAi3Ik9k7+fFQAzix+LrFKRcmlq4GfF5
 Ud8Q==
X-Gm-Message-State: AOJu0Yw9YhmOA1QZl76+lXWO2cUtjBdLEqjPc+60t7Q1SRcDayX6vcDx
 xIqaDTG6MIHj6O1Iyv6lT1NT2iShVL9uFT+Z8UP21Hc5tgObWhxTbdg8/tk1o8Y=
X-Gm-Gg: ASbGncvFF2L1I2h4KZidOQrIpiBrfXXd2z3NokvFbYfwexo8zTJe15JfTonIkhWvPHL
 JxktMnCJEg4VVTDzgJYvGQYQcbXiDKM12r4TOoudlFmAnKztTpHty/oR/US0/QBSJaZzWoA7ioG
 pAJHwXrG7Xd00lM4xTN1ahs/ff73Us0QZH04ZYdfvO5zi6GH51kIEb1E9o7K4r3CgpEOHF+6O98
 qsIOZIcHYYxIOXIicXApkDqWgiqfApStN22ZQsNPdqgPIGm/n0AkMs=
X-Google-Smtp-Source: AGHT+IGR4a7Cuptm2vqne97yegTbYKQuTTA5GmdVOe+oNfF8mTmcExAw/t1nTu7Rf0LD0YkhNkaD/g==
X-Received: by 2002:a17:907:1b1c:b0:ab2:c0ba:519e with SMTP id
 a640c23a62f3a-ab38b3701d1mr258354466b.35.1737121380624; 
 Fri, 17 Jan 2025 05:43:00 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384fc35ffsm170337766b.160.2025.01.17.05.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 05:42:58 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5486960865;
 Fri, 17 Jan 2025 13:42:57 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 05/37] semihosting/arm-compat: Include missing 'cpu.h' header
Date: Fri, 17 Jan 2025 13:42:24 +0000
Message-Id: <20250117134256.2079356-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117134256.2079356-1-alex.bennee@linaro.org>
References: <20250117134256.2079356-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

ARM semihosting implementations in "common-semi-target.h"
must de-reference the target CPUArchState, which is declared
in each target "cpu.h" header. Include it in order to avoid
when refactoring:

  In file included from ../../semihosting/arm-compat-semi.c:169:
  ../target/riscv/common-semi-target.h:16:5: error: use of undeclared identifier 'RISCVCPU'
     16 |     RISCVCPU *cpu = RISCV_CPU(cs);
        |     ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250103171037.11265-4-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250116160306.1709518-6-alex.bennee@linaro.org>

diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index d78c6428b9..86e5260e50 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -166,6 +166,7 @@ static LayoutInfo common_semi_find_bases(CPUState *cs)
 
 #endif
 
+#include "cpu.h"
 #include "common-semi-target.h"
 
 /*
-- 
2.39.5



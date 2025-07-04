Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BE8C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhLx-0003z2-UO; Fri, 04 Jul 2025 10:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIN-0005JR-Fh
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:43 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhIL-0005xt-5Z
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:21:43 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-2ef461b9daeso865728fac.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751638900; x=1752243700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rqIaBK24/nk8jMN0M07Cgetn4Lo2/0ptp5VJcxzRmEg=;
 b=Z1bK5mgeuc5qmQWtDACZPyqzxlLzDVmooPaFqRstNz1EQQiPMm1hRc3gXW1WrqQrd4
 dKyEd/Bu3Dr23SnxcmPImNUTPG9Xpjfq5/VnhXck4VZv3Sv0+E3czIyoJMi/XtehlWyD
 ja3pEwTR//xISZ5iQOQn6nor5xzxjH9konOHNbIvZ8JEYE28m5O63kTcldrIJHMIb6CT
 uibNM679cLNP4eg8CZJugHWNa+py0fTK/lyvXuNJyx3ym0nGY88APn8VDjaiHyEeC9Ft
 BPR2ecE8sLDXWL4SgCal4gppcLrUK0QnbClKXZ0itT3xd5LBgSB4y9GKyAasjuR9qQvZ
 cr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751638900; x=1752243700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rqIaBK24/nk8jMN0M07Cgetn4Lo2/0ptp5VJcxzRmEg=;
 b=NmDph+Li+BSy9Zy/xNH5HFoy2MWkM/n7J1vWeK5schjKaiKrFOLaPpE9BjzBwsGWo2
 Za2QE8oeEgyp1NjDAMzEbpiDoxtO0vYHTPKLfj1vLjF2K6szhrSp6OQukz2ft7cGLHGf
 3aq6MIqqvm7qvQLFohgSZJU5QuQpMyRB8jS8fGUc8D2IYx7Eefeo1DJMJdw044vUDMJm
 8oalJtNe7ShiSurWiKBoI2H6RQvbz0G3xswji9nssJ12tPtpBqBFk9z4SxnDoM5+ujsC
 F9Cv/sg9jfgsdL2G8U/0vtJREjLgsWCeE+fCVq20wnJxomDh/rCwJDM7qmMyo+sLUZgO
 U5Rg==
X-Gm-Message-State: AOJu0Yyg1mkvp42z82/zcwCqBUBRdmQEJ6jDUlakSiQMwPJRXwpbNMxH
 24f4+fMBnR+Uf/x9KKeSWBUMULjPEEx5VmFijixUAy+TN9HEtrtvhvwKPW5pmNsHw3i2pbc7PBM
 g952Ul5o=
X-Gm-Gg: ASbGnctumzk/PNvY5dUDs7JQ+gPafgb77hNBfjqLonVVZzMj2aIlO8ZJAIuhuOOQVBf
 xF742QQSnCow1dq4J5m3Ue0jLtSGmMzvGCy1vveJ4p6vevB/eYKt916Mc2DLFUMXcWG1q6EddME
 Bn7Y0iGQRT54En+Q0MfjfKuuqNIiIdddPtQGs8U9SAtJKVbPxeDOH7Vde3UEMatEpNCWaDujwNA
 D+CkdcQ6sXhVvRFHnkGCDK3KNakRJkhY79MgNlrJH4VzxvGa0O17k3LK/LoxXC8QvLIQhnCi4XI
 JX8K6LJ5gREauMeTyZoy8nDl+SzeOEyfsOEm7qhZ2lAvhqPg3kxVtgX4/YTIjICng/16rfCx9Vz
 xw2w0C4NR/hKpRBUqgDrbjjk8mkoePDATRkvlmqGsqJPNqPul
X-Google-Smtp-Source: AGHT+IFOhUXStVuBZrwPFmDLMOF6bETY/w9L8mWLFARvttAShCBDRnZdKq7S0zHY+DlBY3WKaPUd3Q==
X-Received: by 2002:a05:6870:c154:b0:2bc:6675:2043 with SMTP id
 586e51a60fabf-2f796ba7168mr1806318fac.14.1751638899933; 
 Fri, 04 Jul 2025 07:21:39 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff0471esm528016fac.3.2025.07.04.07.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:21:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 024/108] target/arm: Introduce ARMCPU.sme_max_vq
Date: Fri,  4 Jul 2025 08:19:47 -0600
Message-ID: <20250704142112.1018902-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h   | 1 +
 target/arm/cpu64.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 39a9234ff2..c8cf0ab417 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1136,6 +1136,7 @@ struct ArchCPU {
 
     /* Used to set the maximum vector length the cpu will support.  */
     uint32_t sve_max_vq;
+    uint32_t sme_max_vq;
 
 #ifdef CONFIG_USER_ONLY
     /* Used to set the default vector length at process start. */
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 77e7c4a6a5..bd33d6cc6e 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -363,6 +363,7 @@ void arm_cpu_sme_finalize(ARMCPU *cpu, Error **errp)
     }
 
     cpu->sme_vq.map = vq_map;
+    cpu->sme_max_vq = 32 - clz32(vq_map);
 }
 
 static bool cpu_arm_get_sme(Object *obj, Error **errp)
-- 
2.43.0



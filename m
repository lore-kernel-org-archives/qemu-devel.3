Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B910BC87FCF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwRs-0005IL-Te; Sun, 27 Jul 2025 04:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPq-0004SN-KS
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:07:33 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPo-0004ue-Fx
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:07:30 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-23c8f179e1bso39877755ad.1
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603647; x=1754208447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WR7r+Hh17fQ0ME4q6Jovo/isLIn3L83iyAvcPtqKwiQ=;
 b=UTCbTJMOr6KISlFIU4i4RWufSMuLgT7hR7VyotV0lSV1ygvAokyAWKOv678JdUfpPl
 5qU/tuXGjIfyXkqwQmje7gyf3DhAo/ylwKipf+zTdRv78ASMZmvASHO7uVppVlmBd/rQ
 z1bNPvy50n5rdA9x87taXmkpWjkM7pgcu/kDrRVM7B3oz0ihzrhNAFk/jL8nw61vnAxi
 ksFaE/65wr9iYFHFEgtRP2fDHPhQbc7OdetIuhQlhXgCVF/KGDv0TB1vS0MH1vs/9jPh
 kGSQdGsB8Wfb9Wj+Kgt9NVA+8Ec0DbJ5p7+DSWcRFD2mdL1vgBYwFVmwIjhYPglcEIFm
 VfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603647; x=1754208447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WR7r+Hh17fQ0ME4q6Jovo/isLIn3L83iyAvcPtqKwiQ=;
 b=dslLL2I/w1iULjeOIZNW9JhyjGq3Ex+924i9wYTxVBpK/WWegDG+PJWlDI46S2Y075
 xxZNiHfQce5q9ZlZa63BLRMZ1uc8mbSGqW833D4Qh7Jcpgau9OHqZQ28ytn5IwQZQPbq
 qX/eZ3xE4mz1so6+xXOf8717jI8SAMaP2JkE7CXBFKAw7uR+IFz5fMt4xcbAfDoArb6d
 MSHH5kmzDH3mRZd2tlfvasnwWtnjbQbOqn9CoMUWGwQwgFSc/XU2szSmC46t8OqNbFqP
 zmWRjBtSLGMpL+eEOc8BwEcTHcFz7PU335bE35wTybAjMrecIDvsb1+ZMl/vN7iEhkC4
 riPw==
X-Gm-Message-State: AOJu0YyKA3NabTqB0Run2iKuKOQNoWUSWkyzi35e9Lz3Ew4V2sKLIw3q
 Ff+TC+TFzxqWNdgXCsCHbiZsOEyP2RliMOSKCTpRfPYaddBOPb3WTMk6ve2k2NKEduDIiepm+VV
 V9z9M
X-Gm-Gg: ASbGncskcj4jsoB7B7UsC2pruYgP0o+jdNxJ8dEVk6v+2cBROf5/6CSzSXkvr9krke7
 BhAxXdaTt5HzttTAshTTw1+ZD2am41DMIOF3moBCzyLTSygpRGVpojifDc87zhIADiG32/2+9js
 MoBUwxaZqrtIBVDK3NuE+cjW9oM1cXoNFF1FCZK2f0QssmySDTfA6O1mwdtFLLIIF25q/7J8UwY
 Wae69ZRSU9/+JkoWVIYIbjyke7Ljk9ENjPJzoA3u2ahaYhK9DhYOujyiNba+PpX6GMInlETqp2G
 hW0xFT5TRMDlWCiJSyq3i/vfAhXxd7xzjnW67FpCWyTqIX8CwOWy8vZJA0YY2bIfCbr0HTFDw8M
 I7LrBBQSlDMRkLDlfVoUZPTi5wz4FDfG1kAhS8y/a5c2eomi/qLblA67e8G6AQ5Pt1ZMqztdVsw
 ZJDgIznidt9w==
X-Google-Smtp-Source: AGHT+IH72wYXaufke0LU8TNswAbPJxGaBVoBKpbQ5s40qTUYYqEXcaFdM9cXKUSB3NrSFVmh/0HLkQ==
X-Received: by 2002:a17:903:f87:b0:237:e818:30f2 with SMTP id
 d9443c01a7336-23fb31e4605mr129353225ad.50.1753603646977; 
 Sun, 27 Jul 2025 01:07:26 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24011d5bcbesm3908065ad.10.2025.07.27.01.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:07:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 75/82] target/arm: Enable GCSPR_EL0 for read in user-mode
Date: Sat, 26 Jul 2025 22:02:47 -1000
Message-ID: <20250727080254.83840-76-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index ec63297165..284d1870ec 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -317,6 +317,10 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
         env->cp15.mdscr_el1 |= 1 << 12;
         /* Enable FEAT_MOPS */
         env->cp15.sctlr_el[1] |= SCTLR_MSCEN;
+        /* For Linux, GCSPR_EL0 is always readable. */
+        if (cpu_isar_feature(aa64_gcs, cpu)) {
+            env->cp15.gcscr_el[0] = GCSCRE0_NTR;
+        }
 #else
         /* Reset into the highest available EL */
         if (arm_feature(env, ARM_FEATURE_EL3)) {
-- 
2.43.0



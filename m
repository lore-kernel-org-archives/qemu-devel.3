Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090AEC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 08:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt0Ap-00014l-WA; Fri, 14 Mar 2025 04:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tt0Ao-00014B-08
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 04:13:42 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tt0Aj-0003HV-Nu
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 04:13:41 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso34189175ad.1
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 01:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741940011; x=1742544811;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CyjoW/KyG+IekCP/byAanaMOrZmEHo+RD2zSHnIJRzw=;
 b=AEVpq8zfM84342yPnl9G0KaNRRTTSfIcCm/xgk62g2OUNRRF48gjly/h0WlgKzXlFs
 VVqAoCwjvs+hvKMEXW2b9aYJT2AzWQ3K5Rq74YGCNWzXPc9k69MMLc6X6CjU1nUFYZEe
 f98WlaQwMcWp9BNrGkgHJFEa51t78Dc5mO/xb42JYSg03jH24LTnNyY2ABvzNV65H3EO
 wq95qC/RmUDGKbva9gH1fEdHJCCTNGnTFlsILZX3pF8F7SviGyLTNxgsAhj1cOpXguGj
 +2kodpZ47/0R7E/j5vhM2YNghwvb5Xx5yJwmDX+FR5ob6igsK7NjeWBdMnfPwnTzzVlT
 UHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741940011; x=1742544811;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CyjoW/KyG+IekCP/byAanaMOrZmEHo+RD2zSHnIJRzw=;
 b=dEL+FEi4iqJQzuwd/Y33euXhJu1G1TmbNfZUkPwtLkuzhNapbuwBqbykPOciK0ASi3
 QReFKw8fvbTTa3oXLZNB+T8Xr6sAsn1rLtxl8ELsiDHtgNi6Ef16MZEANKgnOk2+L0uP
 SrzbMqY3TtYcBnHEw9QcvpIZiUkzSscumJZMVC1crUHUEWJvii0dATgnqJxkLokrPZ4K
 hcLxLxK5YvTsb0yWDCwxdXeW+cyRLKzZg8FOfE4eT0byqy85O3K6kGqxkAjdHqIjSrp1
 Ch/F3ymEeHji5qUKwT7zqICemtA9dbmY6d2byz78WzJZuSMlY3SuD0U3BAfly0KgJ0iZ
 G1cA==
X-Gm-Message-State: AOJu0YzDX7S5vHPktznF54yaq3BMwQHP9482x/gaO2OOMhFYEvu8JaYg
 hMwbOghFCzBu4rm7XgdH2QVeuXRy6tqDbayOH9dzdw52lHhsSQDOeCcgE4H9bQg=
X-Gm-Gg: ASbGnctCbOXkWA+1TsU/YFeq4j6PNn6I54Bt28N00Ecc/+p4Yjra7KmzrGtrDb2r1k6
 99lO7tQTEKaz3GTeuYctXTcF+fWiy0dbfu+bVoT4Y3XMst8S3vACXl1v4dgINdcp8xnvueNdw9I
 roVDEAxAktqqZkzbIZDkmdk7mF31xu+qQHJDSFVdTRRmY8dd7ytXA0nT41fbVA7ifZzXUIjMhP2
 SyO9ot+etiADDkqia+Pkum0dedI0WgYDYluzJmXaF8OEW7XhL3/5URjrVrwNPRbK9oLqVHN/mIR
 1Y2hpNEfTlj6lPsNHbDcB1yP/4j/ypgo1PzmPy6yOilSO2vS
X-Google-Smtp-Source: AGHT+IE2Utzchjs2Aahj2B8fMPaRdS+AnJiBZLmMuVL2hOw+t2TQ4T/guVA4b9IPZErwR55VUP5lSw==
X-Received: by 2002:a17:902:dac1:b0:21f:6d63:6f4f with SMTP id
 d9443c01a7336-225c64f42bdmr70453355ad.2.1741940011292; 
 Fri, 14 Mar 2025 01:13:31 -0700 (PDT)
Received: from localhost ([157.82.205.237])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-225c6ba6d16sm24502315ad.139.2025.03.14.01.13.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Mar 2025 01:13:30 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 14 Mar 2025 17:13:22 +0900
Subject: [PATCH v2] target/arm: Define raw write for PMU CLR registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-clr-v2-1-7c7220c177c9@daynix.com>
X-B4-Tracking: v=1; b=H4sIACHl02cC/1WMyw7CIBBFf6WZtRhe1taV/2G6QBjsJAoGDGnT8
 O9idy7PzT1ng4yJMMOl2yBhoUwxNJCHDuxswgMZucYguTxxJRSzz8R6o/SgRC+H+xna853Q07J
 XblPjmfInpnWPFvFb//0imGDSWj06r7nH8erMGmg52viCqdb6BULYHbqXAAAA
X-Change-ID: 20250313-clr-6a34831628b7
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Raw writes to PMCNTENCLR and PMCNTENCLR_EL0 incorrectly used their
default write function, which clears written bits instead of writes the
raw value.

PMINTENCLR and PMINTENCLR_EL1 are similar registers, but they instead
had ARM_CP_NO_RAW. target/arm/cpregs.h suggests this flag usage is
inappropriate:
> Flag: Register has no underlying state and does not support raw access
> for state saving/loading; it will not be used for either migration or
> KVM state synchronization. Typically this is for "registers" which are
> actually used as instructions for cache maintenance and so on.

PMINTENCLR and PMINTENCLR_EL1 have underlying states and can support
raw access for state saving/loading. Flagging a register with
ARM_CP_NO_RAW has a side effect that hides it from GDB.

Properly set raw write functions and drop the ARM_CP_NO_RAW flag from
PMINTENCLR and PMINTENCLR_EL1.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v2:
- Added raw write functions to PMCNTENCLR and PMINTENCLR.
- Dropped the ARM_CP_NO_RAW flag from PMINTENCLR and PMINTENCLR_EL1.
- Link to v1: https://lore.kernel.org/qemu-devel/20250313-clr-v1-1-2cc49df40fe9@daynix.com
---
 target/arm/helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index f0ead22937bf..d05865983416 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -1899,7 +1899,7 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmcnten),
       .accessfn = pmreg_access,
       .fgt = FGT_PMCNTEN,
-      .writefn = pmcntenclr_write,
+      .writefn = pmcntenclr_write, .raw_writefn = raw_write,
       .type = ARM_CP_ALIAS | ARM_CP_IO },
     { .name = "PMCNTENCLR_EL0", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 12, .opc2 = 2,
@@ -1907,7 +1907,7 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
       .fgt = FGT_PMCNTEN,
       .type = ARM_CP_ALIAS | ARM_CP_IO,
       .fieldoffset = offsetof(CPUARMState, cp15.c9_pmcnten),
-      .writefn = pmcntenclr_write },
+      .writefn = pmcntenclr_write, .raw_writefn = raw_write },
     { .name = "PMOVSR", .cp = 15, .crn = 9, .crm = 12, .opc1 = 0, .opc2 = 3,
       .access = PL0_RW, .type = ARM_CP_IO,
       .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmovsr),
@@ -2024,16 +2024,16 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
     { .name = "PMINTENCLR", .cp = 15, .crn = 9, .crm = 14, .opc1 = 0, .opc2 = 2,
       .access = PL1_RW, .accessfn = access_tpm,
       .fgt = FGT_PMINTEN,
-      .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_NO_RAW,
+      .type = ARM_CP_ALIAS | ARM_CP_IO,
       .fieldoffset = offsetof(CPUARMState, cp15.c9_pminten),
-      .writefn = pmintenclr_write, },
+      .writefn = pmintenclr_write, .raw_writefn = raw_write },
     { .name = "PMINTENCLR_EL1", .state = ARM_CP_STATE_AA64,
       .opc0 = 3, .opc1 = 0, .crn = 9, .crm = 14, .opc2 = 2,
       .access = PL1_RW, .accessfn = access_tpm,
       .fgt = FGT_PMINTEN,
-      .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_NO_RAW,
+      .type = ARM_CP_ALIAS | ARM_CP_IO,
       .fieldoffset = offsetof(CPUARMState, cp15.c9_pminten),
-      .writefn = pmintenclr_write },
+      .writefn = pmintenclr_write, .raw_writefn = raw_write },
     { .name = "CCSIDR", .state = ARM_CP_STATE_BOTH,
       .opc0 = 3, .crn = 0, .crm = 0, .opc1 = 1, .opc2 = 0,
       .access = PL1_R,

---
base-commit: 825b96dbcee23d134b691fc75618b59c5f53da32
change-id: 20250313-clr-6a34831628b7

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>



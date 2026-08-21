Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466F6C5DF7D
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN0s-0008TT-Ni; Fri, 21 Aug 2026 07:02:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN0q-0008Eo-Kr
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:16 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN0o-0007NK-Pc
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:16 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-499b6c02b02so3966675e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310133; x=1787914933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4fLZD1ZpuLL9G6fmiVIFQ4fHwh4kYhArYqzEkRdpzKM=;
 b=njankd1rgqcDERk7dXvkIXbCL3cHYz+P58Is6jWP6+ulbNXAulAKfbZxhYZVZVrkyu
 0RZUBAgC2aXLZzFUd9PukmU90bxakEDpZeAY82qDAmDGqxL1ojTTerwcTpqhlPaH+UPN
 Gq8LPzdrN3tpPL522MW1HHYP5zV3YuQlE5dDjkRwiq2el6YiD/he44f55NP1p5aD1j8K
 eGLMAjodpko3GJxhyO97ENw7Uc3DC+s6Gva6Bk4D7Epvm4aRWs/DGOFmpT8memxMyrko
 QHvOjTT7JkgIoJMgM4bsuXwu75xufEEzH5bgZkpDN0BlKRNZnVmgXL67zRZGeWpRsIVg
 Npuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310133; x=1787914933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4fLZD1ZpuLL9G6fmiVIFQ4fHwh4kYhArYqzEkRdpzKM=;
 b=Df8H0qCTAq+OG0bR5hUt3V9ketOM1WH81IP7weBo7XR6Olbsyto/JQAoVEAI9pUCmB
 fDPjwVUcKtJPzKyRb80KLo9/4RrTgsefZx1aZG9ADkZmqS27dhmPykdk45DmSkJ6yy6J
 +RfiomrYM9SAlKjr+m3ET3W6YuOgbahEUUBzBM2lFLuF8gNN2qIdw1+RdOSEQNSV87wq
 RNpGU1X8c5vzsrcy6iD+ffsCvxPQxMzj9+/ULiEISef88eE4PePUgUgLq8E5C3w9r++b
 GCMEB/g7XZCS9F9rv58pxM06xHiff/8wUnNJrbJE+K9u7O/UiDE4C8OsOUeMhsPSdyAd
 Ndaw==
X-Gm-Message-State: AOJu0Yw3/ST2et8shLafHo+77YHxJ4uNn6XiQQk8iKnl48d/GUPMa+UR
 sg8eTqQDKH2KinXPi02Zz/33+gAmZs1k7E3Py6sddJARpq9ClHdzFEYlZagfkB4pM+2fJvG0Ytu
 5H5Ea
X-Gm-Gg: AR+sD12FovyncB3NcfSGKjF0/P0Pslzv4WwfYU6YRRiOrxRDrd/zBn+qQwTg8YqQ+cQ
 1WSjCHR9TUqLotat8SOJuDM7M1KPaoitz8dRCOA4o6z0e9bXc8XdNBICEbAaEny0CI4kd7S6qhS
 0LQhvl48Cjdv8yAnMTIsIdEPTRxb/7bRagh9nJDZSgwloty1E78I4F47QRprZw2syoYK4WZRq5C
 SQ6gqywtelcQkUtDsQpJrHxHe4aKY+idqpSX/uXztrBXwrpNjs+CsHi6PX8kQgoBYMu6AhUM9oB
 QU+kzkIE9hjr6ei2whmcaLOXBWiopPvNG5ZdRSj91Ck4ZbmN0FO/Xe/xxuMZ3oQl90v4bFhTU0f
 J/V269ObBKdaYRgpMDDb02mb4vEZKYurPgDIqwnHRHHl5mcQj/B9pla5Z6yPttGutfUey+1nGD+
 A3Km9KVRMh9wQ2Gzk0Q0A9nd401H4xlZNb/eQYnkAbSd6VmVA9Q67wkQnKSmHrw/EEXrG8aGTo+
 ZXFKn93/d8tyMc8U7vH6QB7tG6T8gnzATT0Dt5MuuhRi+jFFzXiGWitKFu1cm/1z+LTHA==
X-Received: by 2002:a05:600c:6610:b0:499:a660:f926 with SMTP id
 5b1f17b1804b1-499b8454bb5mr67077195e9.11.1787310133019; 
 Fri, 21 Aug 2026 04:02:13 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.02.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:02:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/43] target/arm: Update confusing comment in cpacr_write()
Date: Fri, 21 Aug 2026 12:00:36 +0100
Message-ID: <20260821110101.3971391-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

In cpacr_write() a comment says "In ARMv8 most bits of CPACR_EL1 are
RES0", and the mask value is left at 0, implying that we enforce
those RES0 bits.  In fact we only enforce RES0 when ARM_FEATURE_V8 is
not implemented, and for v8 and up we allow the guest to write any
bits.  The addition of architectural features in v8 and v9 has also
resulted in the addition of new bits to CPACR_EL1, so "most bits are
RES0" isn't really true any more.

Update the comment to be a bit clearer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260817123838.1578060-4-peter.maydell@linaro.org
---
 target/arm/helper.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index d582eeba577..7de38d82010 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -554,7 +554,17 @@ static void cpacr_write(CPUARMState *env, const ARMCPRegInfo *ri,
 {
     uint32_t mask = 0;
 
-    /* In ARMv8 most bits of CPACR_EL1 are RES0. */
+    /*
+     * The AArch64 view of CPACR_EL1 has a different layout to the old
+     * AArch32 one. We also need to permit the old AArch32 bits to be
+     * read and written so that an AArch64 EL2 hypervisor can set up
+     * the register for an AArch32 EL1 guest.  So we choose not to
+     * enforce any RAZ/WI or RAO/WI bits for v8 based on feature
+     * presence/absence.
+     *
+     * For v7 the situation is a bit simpler and there we do choose to
+     * enforce RAZ/WI and RAO/WI.
+     */
     if (!arm_feature(env, ARM_FEATURE_V8)) {
         /*
          * ARMv7 defines bits for unimplemented coprocessors as RAZ/WI.
-- 
2.43.0



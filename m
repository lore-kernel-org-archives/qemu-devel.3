Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEE3CCA472
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v29AH-0001CV-Pk; Fri, 26 Sep 2025 10:11:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v299N-00007r-GA
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:10:20 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298a-0005ku-2R
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:10:16 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3ee15b5435bso1341147f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895759; x=1759500559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oZNZzIbU8+zBKDT0tmts3YWUFIV3vAidFupq4Opogxk=;
 b=XE3FK27GLiySxmxmirbJ11eKKjnDHNGX7uZfgHswvsUONBHMl+nMBrZD2pC9JINVRf
 F8ASthNre6dMK6l1LQWeiEsJRNukO5iVuIPuzJBxxD67raKlMHFLT+KWkxLGxo1nf2Bd
 8ZIoFwh8G5CULEnoJSHpx6Q3SppHxb/xHRZ/AM0h7wUHPf8ddY8PbCvupO/MjqlPM+88
 aYPbS/hJJks7bdpnOvGq+CrwJQIktkD7D8c0/NA+ttLikd8KevUJeZGRQVD/H6H0Uo35
 JXi2KIQYpcpL4t8LQ1NQOmNORtsqS7n37rBqvD+paAGv5+dTKe4rfdsRLjBS3AOK4MHL
 80zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895759; x=1759500559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oZNZzIbU8+zBKDT0tmts3YWUFIV3vAidFupq4Opogxk=;
 b=BLNjP9wm0Gb/WYtNFkk0WIGDB7fNtBV3G9dwHc4QQc0H46TttQOkNtgLZ/rfTWjQqs
 yNT+8oc+ee3Kz8AkMVOzANWBOl3LFPUYFih49X1YnGmSqhS+i2Ix982jMcY2E6FD1cz6
 QjTFNBztHTubnABvJZgVkLAI+suold1d+VrV2lXPlqPOscvZS4ZidhqxB+bpY/Ix3lZv
 j0T61xEtR/slxo/LP1GCDhwn+kGWMuD77joNtAsZvLkmHyYtTxEAU1VGbY35gr1Hcq/g
 +KXSxgbzhqhUHekg5sP0pm4bWGnMMWwXmx9MicvGhfYmwonr9lyF6BrS1selntqGrSK4
 sklQ==
X-Gm-Message-State: AOJu0YwS0e9G1Y46A9UzDjX7gmIXdG9l90/sONMzyz0xKJ3bHb9/Gv2W
 uA63gVdqJWh3XHtLqK+/0g4At9PcNud6Bi4lTCoh9bi6L1K12bXq0iPApt5goUiP90d4R8J/1L/
 XiblL
X-Gm-Gg: ASbGncsAgRqZTjory9f92w+zZV720ae9eRLs419zmdURWXbGsgadlTgiqdOJ+Q3+FmL
 CVmCcasSwy3rAHbpj066gIB+qulkyja8qinULQzKQvAiSi9MYwTNIisbjyoG2GVIONI0LaFj1gn
 Wbi44EyHehkFNxAvlS/YE5D5vq4voGwfhuY91de3Q+9mNfExPMsseof5cpHuc8dDAdFrUZ0eIWc
 JF2hR3qFQ3irsHSxBZLFCxfik3TXlzU/HrUtbRckM9+Qbtw8cuGFhbtcoMWpTpAJkqQLDOSKQSa
 IWmcHovcActNq3aSXoiUXOV1dDdM55MAkt4iZm14mUXt/dRp109dktozTaSBDQmhf+sMML3bwSs
 V3qZFLlQTcNBpKX154Ampxmw2SpLb
X-Google-Smtp-Source: AGHT+IFAIKraLHOs+uPwXDQKVrpe6WjVrgXVabxbr67IeW1MaNzZNMHrygbSFgCHiNOlSj+80yQaPw==
X-Received: by 2002:a05:6000:613:b0:400:ac58:b35f with SMTP id
 ffacd0b85a97d-40e4364293cmr6405273f8f.21.1758895759101; 
 Fri, 26 Sep 2025 07:09:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.09.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:09:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/44] target/arm: Move endianness fixup for 32-bit registers
Date: Fri, 26 Sep 2025 15:08:32 +0100
Message-ID: <20250926140844.1493020-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Move the test outside of the banked register block,
and repeat the AA32 test.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4063c8a0b6f..18066b0c5dc 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7438,14 +7438,21 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, ARMCPRegInfo *r,
                  */
                 r->type |= ARM_CP_ALIAS;
             }
-
-            if (HOST_BIG_ENDIAN &&
-                r->state == ARM_CP_STATE_BOTH && r->fieldoffset) {
-                r->fieldoffset += sizeof(uint32_t);
-            }
         }
     }
 
+    /*
+     * For 32-bit AArch32 regs shared with 64-bit AArch64 regs,
+     * adjust the field offset for endianness.  This had to be
+     * delayed until banked registers were resolved.
+     */
+    if (HOST_BIG_ENDIAN &&
+        state == ARM_CP_STATE_AA32 &&
+        r->state == ARM_CP_STATE_BOTH &&
+        r->fieldoffset) {
+        r->fieldoffset += sizeof(uint32_t);
+    }
+
     /*
      * Special registers (ie NOP/WFI) are never migratable and
      * are not even raw-accessible.
-- 
2.43.0



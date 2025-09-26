Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C14CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v298w-00082t-91; Fri, 26 Sep 2025 10:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298t-0007uo-5E
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:48 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298T-0005i8-Bm
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:46 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46b7bf21fceso16761575e9.3
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895750; x=1759500550; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NF7qfHw2I9shSn+UnJOx9Y2E4M/oZXJIVSezgmWGofU=;
 b=C6gTO6csZMO87vybUy3Pa1CRHqosUPBJnynqUJTDPyWy4EJWlU+TCOu5v3TKvWOdfl
 Rg7F5vpmW+atShiUcsCWGv/iwh6YovEwU6CNUCESejQ8LOP2/6RjCYI5s5P2msDKHo8N
 0sDg16liSZFCrNAdLVXXopGU4kOIV+lI0FTfhWDjPMyjwpAe4b2YsVad1TrivbHWpK1x
 Z4+3wcMWAICyYk2VLQ4muLMarj8UmDObbQvvf8G2KFsgKZ+NlPYBmgQrMltANVOPgTaG
 hMPbPVbDZujvBMDgFBVeFpbOuJD+YIw8lxiAG04mAhJhXnxjZS4G2RLVcid3Y8magzOU
 8pJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895750; x=1759500550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NF7qfHw2I9shSn+UnJOx9Y2E4M/oZXJIVSezgmWGofU=;
 b=REOxqYleHM3bhxQyQrCkxSjIAofQDy/RcIC9Lqxl38Pgnzc0pS31lQxPG0CcHocxj9
 LpuSs3abDpnEBko8WqupCPk9IGQU4FlP4FMHn1o4BstXPLp2wRJXgtDhP41+cjvX2AuJ
 +XSTvK+5htwEEOR0/6b77G+zSZwesQixKm/anrjveSEb84TtRWtw79dD4wHGxKv0JypQ
 hXNJAORbGbMavotlcdZw5YUTCbt9+VOj9J8osX35gx82IlbatDoMxwmHfcW361xFHfb/
 eshrivF+fUDHnvwDZuDay4KZkksYL0P0JSZhD+0SoTud+0+pADGPR8Ce75ySjJjvqAYF
 y4AQ==
X-Gm-Message-State: AOJu0Yz8ulJl1PqeKMAHx29kv/eB6GlmwGz1O7SwhwwwDeKJNdUf9eHx
 FEeG0tb7rUwM0CJrq/cSGaivTiSlXL8lRDrGpuYggtSedaaCrcAXn41wm9g0R4ZXvWmbd7ndUr3
 kJRRg
X-Gm-Gg: ASbGnctPNi/eTw/N8BeKZH+/3xoBHCM76dUaZB7NCMbhjc7JUFTeReFbAf59bQxSebB
 2joeeESEXxozNVDdXDeIe9H1Qucv0j01EwTGIzCY0Ncp3ATbYjwsBGjipnN+fk8MJOLAw3+iQUK
 QIOnMASdwSbKoxhfyzMuWfo2GCLZvNWWWqug9r5OFzHUDa0VyZ1M3USvj4q4brjF6vm6a6lZohq
 z+arQQQQ1jWQRND0bMhheaZw2KI1WMFsEuDd0zbGAwkPAzSs2QGzz6cRQs0T0Y2Cig5jqNTGzHA
 2Ye2wSw5b5pPtEkXVgwPpeGpke5g+klmOIsL8xJuqAc4n5BgFrBYzELsI2A5w9sE/3c3FLJ0Q7c
 J42w3rk5pJVJVQXTo74jLIy4Rp8FiKrKVyitEHgM=
X-Google-Smtp-Source: AGHT+IFxyQ5fRCh29XFQpbTbmUSgvhsUcG0GWGRa4w0LmXlGkrdUj9H57dbB2qGDFeeb9CopjtsdBw==
X-Received: by 2002:a05:6000:1a8c:b0:3b9:148b:e78 with SMTP id
 ffacd0b85a97d-40e4cd576f0mr7648851f8f.53.1758895750498; 
 Fri, 26 Sep 2025 07:09:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.09.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:09:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/44] target/arm: Improve asserts in define_one_arm_cp_reg
Date: Fri, 26 Sep 2025 15:08:23 +0100
Message-ID: <20250926140844.1493020-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Reject ARM_CP_64BIT with ARM_CP_STATE_BOTH, because encoding
constrains prevent it from working.  Remove some extra parens;
distribute ! across && to simplify.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 39f5297a1a7..8c2b7e037e8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7651,12 +7651,17 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
     int opc2min = (r->opc2 == CP_ANY) ? 0 : r->opc2;
     int opc2max = (r->opc2 == CP_ANY) ? 7 : r->opc2;
 
-    /* 64 bit registers have only CRm and Opc1 fields */
-    assert(!((r->type & ARM_CP_64BIT) && (r->opc2 || r->crn)));
+    /*
+     * AArch64 regs are all 64 bit so ARM_CP_64BIT is meaningless.
+     * Moreover, the encoding test just following in general prevents
+     * shared encoding so ARM_CP_STATE_BOTH won't work either.
+     */
+    assert(r->state == ARM_CP_STATE_AA32 || !(r->type & ARM_CP_64BIT));
+    /* AArch32 64-bit registers have only CRm and Opc1 fields. */
+    assert(!(r->type & ARM_CP_64BIT) || !(r->opc2 || r->crn));
     /* op0 only exists in the AArch64 encodings */
-    assert((r->state != ARM_CP_STATE_AA32) || (r->opc0 == 0));
-    /* AArch64 regs are all 64 bit so ARM_CP_64BIT is meaningless */
-    assert((r->state != ARM_CP_STATE_AA64) || !(r->type & ARM_CP_64BIT));
+    assert(r->state != ARM_CP_STATE_AA32 || r->opc0 == 0);
+
     /*
      * This API is only for Arm's system coprocessors (14 and 15) or
      * (M-profile or v7A-and-earlier only) for implementation defined
-- 
2.43.0



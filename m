Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93799C61DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 22:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05Jn-00011j-QZ; Fri, 28 Aug 2026 18:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x05Jm-00010d-2y
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:45:02 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x05Jk-0004Md-KV
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:45:01 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-38e07ebd263so1242469a91.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787957099; x=1788561899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wqyWqrNHgCEd77o3WFnPquFGCTdKezfyPjVR9D6xPB0=;
 b=a/wi0unMDjLpPZpCNrWDMU3dkFyGrPcMjY/kTy+A4HkuCXZbPVI9LH745eVLloiHG2
 h6QMu9JRmTGTwfW/+QcJey/PWbhdWHLfqFMJvRTC0Vcyy0Sya8/Nln9NKMFZOfd1U1Mj
 bCqto2MogBX/e0kSVRETkgNQjwYfOKTpdHZ4S6lciNJbhUga3stjqAK7NOnXbQFbm3WZ
 zLgpW2xFO1i4mLeFaIAa4tpktO92oIzi3LHZkiO/BPbvfPjjTfo1qecOjmuJLYxRwzp3
 1t22X2L5VWIbpmwyaBrkVIwJCTHGl4Tgk4L/M2Nqn8SYoUlYQIczk4lOEyoSY6HcWYlK
 GMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957099; x=1788561899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wqyWqrNHgCEd77o3WFnPquFGCTdKezfyPjVR9D6xPB0=;
 b=ANmuoA5OwMz2SyoRZ9hNb5hfSq2GHXHWPXt9ee3VS8Xi3faupZtSb58qQnBwM8jjGT
 b0IyPv4WIgWFYIZpdxijU5aPbnG4McKzRkq+TWK0cSCMmNNUPSzHgKikpGn9w5pPqUKH
 WM6Fjzz8ah+SdpytliJS54gvtUSZPxlFSb0XQJXDxvNS20/XDzrUWm1r8LgFw/gDb1vg
 lh/skD7CJ0JE3Of+AhfyekJSrKr4ThP57tkwwowqH+++vOGpk7F70JYTJcpUKf1WeQLN
 vx1qRpEvAfraqMlR4KtgzyRh4qRt4hb/yySTRXTaUsdR9lKeefFCss8uJ0gK5Tbeddad
 H7Eg==
X-Gm-Message-State: AFuF++n/lpf2jvcUo705vltcGvSDIWS1AK3B4oWBE/rTXe9DP+fy7cZ6
 nOihDTagsdIl6cjrJxwVBaacrgYsqjJOdBrcd5wxZ9JrnPpnaXMp4CXtjO1I/8dMzsAU2PDBbay
 CCoOik3w=
X-Gm-Gg: AYBFou2CQ53YD469T30Fw9W6eSjowKWh2RG97Qqnf6Ha9fBUcXWVlJQAc8wAPh6VFDW
 7n977R5T2PfpN7/eTuUuPHLZjm+DapAW6VUHFxOLhDtpFi7tzLiw2n45RHNj/ILvS3mben0X6np
 +49eLmdBPpRiW7izXWjEpWSA9hOLz/QdRosS2HlLYnfQfPwfz3t8JdXBQi5EFROgFwSPOGiaRQK
 EWD9UU9n3VJkAWofsxxw01nwN3ce11HKFkd1a598fWlwSI3DRmZ6NvrvdAHiidGZiBU/aL/Xi00
 FL55mWUj2l9her9qN7BdkakMLaPeK7qkUYXUZATlKM1dehKjhHlnxP6AT65DHi71F2iBpUqkors
 ExUwlavsNFIjyHwcc+pG9bjKOiWLWSXf9VnKhnTTLWfppFKsUpCeXV17N3mdFhqB83nLG6eJ2bH
 IYYMd8aMCISTXcy7Mb9hGGr97OwvboA8BbYr84JRzyJ27bywMpov8etDVQN9gn551RrgdSbUtcR
 cryNUErTbZsUVsKOLpV
X-Received: by 2002:a17:90a:e710:b0:381:528a:808c with SMTP id
 98e67ed59e1d1-396d10085b8mr20699264a91.12.1787957099247; 
 Fri, 28 Aug 2026 15:44:59 -0700 (PDT)
Received: from stoup (71-212-39-143.tukw.qwest.net. [71.212.39.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-398a2f5187fsm427594a91.1.2026.08.28.15.44.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:44:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH 08/16] target/s390x: Use tcg_gen_lea_i64 in get_address
Date: Fri, 28 Aug 2026 15:44:43 -0700
Message-ID: <20260828224451.1564072-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260828224451.1564072-1-richard.henderson@linaro.org>
References: <20260828224451.1564072-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

While there's no actual shift, use the compound function
to add two registers and an immediate in one step.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 1b6023168bb..4eb2eba5e45 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -460,8 +460,8 @@ static TCGv_i64 get_address(DisasContext *s, int x2, int b2, int d2)
      * displacements early we create larger immediate addends.
      */
     if (b2 && x2) {
-        tcg_gen_add_i64(tmp, regs[b2], regs[x2]);
-        gen_addi_and_wrap_i64(s, tmp, tmp, d2);
+        tcg_gen_lea_i64(tmp, regs[b2], regs[x2], 0, d2);
+        gen_addi_and_wrap_i64(s, tmp, tmp, 0);
     } else if (b2) {
         gen_addi_and_wrap_i64(s, tmp, regs[b2], d2);
     } else if (x2) {
-- 
2.53.0



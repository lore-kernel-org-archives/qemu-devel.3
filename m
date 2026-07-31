Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D364C55173
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 18:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpsPX-0007RC-F5; Fri, 31 Jul 2026 14:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpsPN-0007PE-KB
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 14:56:38 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpsPK-0002Bc-LZ
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 14:56:37 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2cc7ef7ec27so16297415ad.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 11:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785524193; x=1786128993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Dn3IREGhd3sws58iriMS8UCIlWXDOrw+hseSIR02xxQ=;
 b=IXNVSqGox8Muf/5mcgeTVPGuMJ5mejiyTUHP9Mt59CMWgZpIwSm4kEeaf6zTmjuT+m
 xiUXQNanUtzCKWCmkQcTH6cdSanOpTWyisehRB7AVXFMkYAmcO5zNUWqMEw4Ythv0lvS
 vp4T+SUU4HXC3Lrd4BKb5WrrQJCqz/aOMiA4wEj4sFwYvCwr7q6erwLM6YLKIyrNb5TY
 ukji7WdJBYgBQICpZyXFtNLSnCVU6oCUhmvEHtQIvgfouxD9dxJCGb4TQGWtljFamRd2
 E2TIe3bQAQqDOOFiD/hKj6hKP7jXRfKnccCgYiNn1CDkeog/ls8Rx/3ripqRe/9OvrKA
 h0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785524193; x=1786128993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Dn3IREGhd3sws58iriMS8UCIlWXDOrw+hseSIR02xxQ=;
 b=kz2t6gjtTXdjJUu5vCIt3E+6DpRTQFCi+IVhP4i8UHn+aCgPw7WXO73Q8sN1jc/9nR
 DvIrsdIATS2nQoy+hsydZqm7oQ8KGIDdBh09Uo0dj+mOdoJWXS4QQcHtJOxzpPuOFE24
 3Zg2XYSEqBcwWHwJ/90HIINefCYK+6KERx1/pzy3uNbbduVkDxaKMOJKQOFvJvBQ+Wm9
 i9MKiiMM/UBy0ryVUfF1W4+ELexUi2fTihuNVlThovrDR+FAURKmiwXVRIXRs6hYCcLM
 elTFGXbDSUIiZuiqX/AuBJn4qsKQhqfn5twshCHYxrLrJDbAyMot/YZnFm71cdoaQDSt
 l5jA==
X-Gm-Message-State: AOJu0YyjY0a4vjHrumU9kn0CCN0aHT2bsfqv7kWWRsolhZ3YhFae53pl
 7Fg/0k+FeErU58PXMaJ1H3jE8U/n9gWVMkG0US5TNq63MIt0NFFg41baCXpuumdqCvDJuOFsPMV
 0TsBL
X-Gm-Gg: AR+sD13iuG1GPrmXB3DALdM0SPvK/ikD8ZBue8atF+Kz3IjanWpq2E3QZc3/DNbcSoN
 +OY/3rwgAAwRHJ3bP4TcSHmaCUpOIMdgGrOGTw7ZsS+rgmCDmkjPmC0qztuGevBefMhJVOYPufZ
 LC826reh5J/Co4iFEeglCBpMDlYW2BcWnIwDsA0xhY7kE5IGsTeydi4vip8LQzWy2wo1SQnrFZR
 0qZASu4gGFwXmdv7sgfssdEKYPumJWaRb+MUa6lWYCDq2gwPTNKVwIBR8O9pKhmlFpTBg7/YOoO
 jkHZlWUcvQQKK4jf24xEvEO7t9x8LhAUHDhieOLr5sjiawuwaAdyLHvG1W7ibKOTAzBNUgd272j
 2Pxuz59zNVSQATCdd3Q1HHyHAACzbb/pS95FPpbpgvblGHeqW5d0jJC5jAYXgtc15DmfMqnfpUU
 271WPFkdoZUrKplZ8XBMcHie8On45G1SpJ+eqG5+NoOFL4KVx1HT9oF/Kmci+ogR872Fooz60cv
 qdApOlBzhGnc0S7CFWcNw==
X-Received: by 2002:a17:903:2287:b0:2c9:97a7:3278 with SMTP id
 d9443c01a7336-2d0523f215dmr10193245ad.41.1785524192881; 
 Fri, 31 Jul 2026 11:56:32 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d04ae193fasm9356625ad.7.2026.07.31.11.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 11:56:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
	philmd@oss.qualcomm.com
Subject: [PATCH 04/14] target/s390x: Convert op_ld16u to op_ld
Date: Fri, 31 Jul 2026 11:56:17 -0700
Message-ID: <20260731185628.23161-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731185628.23161-1-richard.henderson@linaro.org>
References: <20260731185628.23161-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
 target/s390x/tcg/translate.c     |  6 ------
 target/s390x/tcg/insn-data.h.inc | 10 +++++-----
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index e0546ba791..d18450f764 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2755,12 +2755,6 @@ static DisasJumpType op_ld(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-static DisasJumpType op_ld16u(DisasContext *s, DisasOps *o)
-{
-    tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s), MO_BEUW);
-    return DISAS_NEXT;
-}
-
 static DisasJumpType op_ld32s(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s),
diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index ea023fc168..d6cc157cb2 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -530,13 +530,13 @@
 /* LOAD LOGICAL HALFWORD */
     C(0xb995, LLHR,    RRE,   EI,  0, r2_16u, 0, r1_32, mov2, 0)
     C(0xb985, LLGHR,   RRE,   EI,  0, r2_16u, 0, r1, mov2, 0)
-    C(0xe395, LLH,     RXY_a, EI,  0, a2, new, r1_32, ld16u, 0)
-    C(0xe391, LLGH,    RXY_a, Z,   0, a2, r1, 0, ld16u, 0)
+    D(0xe395, LLH,     RXY_a, EI,  0, a2, new, r1_32, ld, 0, MO_BEUW)
+    D(0xe391, LLGH,    RXY_a, Z,   0, a2, r1, 0, ld, 0, MO_BEUW)
 /* LOAD LOGICAL HALFWORD HIGH */
-    C(0xe3c6, LLHH,    RXY_a, HW,  0, a2, new, r1_32h, ld16u, 0)
+    D(0xe3c6, LLHH,    RXY_a, HW,  0, a2, new, r1_32h, ld, 0, MO_BEUW)
 /* LOAD LOGICAL HALFWORD RELATIVE LONG */
-    C(0xc402, LLHRL,   RIL_b, GIE, 0, ri2, new, r1_32, ld16u, 0)
-    C(0xc406, LLGHRL,  RIL_b, GIE, 0, ri2, r1, 0, ld16u, 0)
+    D(0xc402, LLHRL,   RIL_b, GIE, 0, ri2, new, r1_32, ld, 0, MO_BEUW)
+    D(0xc406, LLGHRL,  RIL_b, GIE, 0, ri2, r1, 0, ld, 0, MO_BEUW)
 /* LOAD LOGICAL IMMEDIATE */
     D(0xc00e, LLIHF,   RIL_a, EI, 0, i2_32u_shl, 0, r1, mov2, 0, 32)
     D(0xc00f, LLILF,   RIL_a, EI, 0, i2_32u_shl, 0, r1, mov2, 0, 0)
-- 
2.43.0



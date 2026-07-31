Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46306C5516F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 18:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpsPX-0007Rd-JU; Fri, 31 Jul 2026 14:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpsPO-0007Pr-Mp
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 14:56:39 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpsPL-0002BK-5n
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 14:56:38 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2cf52d15d88so11464965ad.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 11:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785524191; x=1786128991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ssxnq1fZWvusp6QPJxLqALNlhOeT8Nu72SByH+hZVnc=;
 b=cwUu0M+rjLkFewFheiTs7mMWcOtWtQSnDlffREOrsXEhq3OfQesldNtKFrPN2KMcbl
 Mp1SRjo/4nIj05iBw5yjlpZFUKoz3A4RqSH3l+R3wKVl+ZZ86ZIb+grNgdoXgk8NwXTT
 UmWSxs4cnOFzcfDjyq5O2PJ0GbMBZEuGrd91V4qk9geTCu/l5x+fhWaCul+rWtT/zgrX
 CKoIDDXxrqmFwqyukU5kkAEKBUgcnnte3mDHjtlhempI0B7PyCjZYBd2jVQbNeFtaytn
 p/J8t9bnGw3zuT5Wy0weV9CioF9wQg833Gi5bCiLfmRKg4JIjBjF0QfgJTYzjMbpX+tC
 Noig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785524191; x=1786128991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ssxnq1fZWvusp6QPJxLqALNlhOeT8Nu72SByH+hZVnc=;
 b=G2tW15z+8B3p6x63bu58wEXDjRx8u+PMpE28U0b7sSbMo2DbEDz1MKVp6R+PDTxFUT
 U+bs7SopfGB0NWp3/uaRNCS5R7YxOjPxAx0QYXgFJxRBjCiIhLhmixqWKUoQTntp90QW
 OtYdgi34ZOOBZouMLDuAzQ6qxj3JDEae3AZifpv9EqyEBw0Jnn3twjimE2HzZ0ygxXY+
 ODPhWVxYBkMq4nR5utvRmqMd2cF6dg+Ii5skfBHEEihvdw+eYeEzxGcydQ7GPfSB+zKw
 CgN+ujs6kFRXXu6WS+PrlgLvQvCGmRso5N0tRC1urkWDbtAvgEtoL7icHzbSBCEXPbXg
 2wGA==
X-Gm-Message-State: AOJu0Yy/9LRuIpb3ZfM27aWFaTKtqddWXsKNCNEopHn6EpGafdCDdTKe
 dsq68h+abe1evvzCTs3IkoGB9BdoXFvQRWVuIiloybXH5E8gx7P0LdGnSbenVqTsPyHe5pLe7S4
 3JM2b
X-Gm-Gg: AR+sD13WhQpjHLlH6iwjHcfrNnkcbFwOcRMrHAwD/oNShSVpF0DvOw01d1GElkpiMfo
 pnEPi2E+IMWpggmGbuL0lnuPM15KfDQV6FKAHASbDHWpDbUhs/+cohJe6q787YBty2rL4mp9/oE
 E7+WONVYyviEbSpEPLh1p9yU1UO+rgJ+Odaz0EANwsRCWZhdmtKfYiB6QmPODXwG7AO/b6jrB9k
 CgDfEet56dOZk9tm3uk5jK9sb0Kn6dNhrZhk7ShQEhWWkl/cI0iSQckIyAiEP0+kguQ0i3tmN/+
 f3Apr8xyTWvrGgt8cTgj6RC9XrBBgdiUXvq5tNdGRYI6a3JS4y19KmmBtU+FHgMZBL39ouAtqHz
 8yJFafZRCsxmnnwtj7SEYEYxTvQDZyGJ6B+LphPn7LF/LCQJdk1PLMVU2DOHkiXSsscdyweK9J+
 CJ99zvauQEmDN3vWujCoLsBsHObVxzw1K02Z3HMGwtHMilegW8ss//Jsn2LVlsR/jt0QbBFowm6
 q6HoKLiyr6g8PgwGfRT
X-Received: by 2002:a17:902:d48f:b0:2cc:8267:31b5 with SMTP id
 d9443c01a7336-2d0521b7e94mr10697305ad.19.1785524191053; 
 Fri, 31 Jul 2026 11:56:31 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d04ae193fasm9356625ad.7.2026.07.31.11.56.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 11:56:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
	philmd@oss.qualcomm.com
Subject: [PATCH 02/14] target/s390x: Convert op_ld8u to op_ld
Date: Fri, 31 Jul 2026 11:56:15 -0700
Message-ID: <20260731185628.23161-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731185628.23161-1-richard.henderson@linaro.org>
References: <20260731185628.23161-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
 target/s390x/tcg/translate.c     | 6 ------
 target/s390x/tcg/insn-data.h.inc | 6 +++---
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 25a7842409..055e163837 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2755,12 +2755,6 @@ static DisasJumpType op_ld(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-static DisasJumpType op_ld8u(DisasContext *s, DisasOps *o)
-{
-    tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s), MO_UB);
-    return DISAS_NEXT;
-}
-
 static DisasJumpType op_ld16s(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s), MO_BESW);
diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 989e40ce34..865ef23ebd 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -523,10 +523,10 @@
 /* LOAD LOGICAL CHARACTER */
     C(0xb994, LLCR,    RRE,   EI,  0, r2_8u, 0, r1_32, mov2, 0)
     C(0xb984, LLGCR,   RRE,   EI,  0, r2_8u, 0, r1, mov2, 0)
-    C(0xe394, LLC,     RXY_a, EI,  0, a2, new, r1_32, ld8u, 0)
-    C(0xe390, LLGC,    RXY_a, Z,   0, a2, r1, 0, ld8u, 0)
+    D(0xe394, LLC,     RXY_a, EI,  0, a2, new, r1_32, ld, 0, MO_UB)
+    D(0xe390, LLGC,    RXY_a, Z,   0, a2, r1, 0, ld, 0, MO_UB)
 /* LOAD LOGICAL CHARACTER HIGH */
-    C(0xe3c2, LLCH,    RXY_a, HW,  0, a2, new, r1_32h, ld8u, 0)
+    D(0xe3c2, LLCH,    RXY_a, HW,  0, a2, new, r1_32h, ld, 0, MO_UB)
 /* LOAD LOGICAL HALFWORD */
     C(0xb995, LLHR,    RRE,   EI,  0, r2_16u, 0, r1_32, mov2, 0)
     C(0xb985, LLGHR,   RRE,   EI,  0, r2_16u, 0, r1, mov2, 0)
-- 
2.43.0



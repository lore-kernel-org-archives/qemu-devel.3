Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51F9C55173
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 18:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpsQY-00082e-2n; Fri, 31 Jul 2026 14:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpsPQ-0007QX-2H
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 14:56:40 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpsPM-0002C4-Gf
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 14:56:39 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2cacb8416a1so14416785ad.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 11:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785524195; x=1786128995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SMhM82aqgxn22bGiYbWYYKiqcYa2Y0nvCh1znZr+dsg=;
 b=Lc1MOjT7GdV8G2kC+bjfpg8zZ4amBj5/Qd2Wq1sjs7u3tVNJPBhsJMKpJ1kwvVA/xF
 Dcyh6nZI2puCDkV8ya/OGoF3U8tDShPnP/tzAuBJlT42/XekrMPXvE1R3A2S7JbZvvnV
 NyIwsvT5xaWpHPqQAZYY/LPnavRfpHD6j5Kbizv4bSFrZGX0FuG5vVHT2QAzqLb0FwTG
 b525SYbwsxdDZwXoPuxY8RAFbk8fwWTP5VRRa+yXCcNdNP9+QSU9CvbgyTnSGzwxHYvj
 En4AWgpSBvwvfpOHrnAGZ0RLU70BWkGKcjtyS70t9GhAhqFviPgfaKoZNt5ZkPuKy2RU
 MMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785524195; x=1786128995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SMhM82aqgxn22bGiYbWYYKiqcYa2Y0nvCh1znZr+dsg=;
 b=hX+sOnVbks3UKj1MRSe9mPbuE6FfIR7LmtKoAVeNM8Qi1dNyEOeY0C+dEdI1Oy8jpI
 VFR+NI48gEP6LRF3Foq/BUhmlaEg9e0HWbSYZ0APGsrEK6GPi4WEFIyCE4KrQKdRKBv6
 jHSg61sCY2CFGyHUz8jG09FXYgLqeI7HTf5PwKddpP4XRtdLzXL3V2WyI7H4GM7nJYLy
 EAGnbpaxJz2XjJeEIyp5JTbDu9CIW1s1ZOOskngxAq1lHwdPNsSBPppgFYsgGToxwanu
 hGQoY868ul3V4WJFhijcQuq13ns2Nh4iXlwc9Nk3LEwAnv9YvR9wlk4fVoibmZhLNY99
 p5eA==
X-Gm-Message-State: AOJu0YwuFmnmSZQVNpVYYKPw5KIkFQvlgUfDZ0v5MHiOguACrgVPYxs5
 V6tELSArYr6/TMKbD/sumsfenm5ATMUec5YqHeGj5LkouDT1uc7d8DQdMg/PMxOfXEiLNQ8Hy+s
 PEAx4
X-Gm-Gg: AR+sD117J8Ylb2nndrFe36y87iLQrOxoJMdThLUgNKh1yo83QCmdlh5H7TddmaLGo+r
 oeOpXsmE5wa9MlezwzLKIjaRG2F2j8la30+U3TVYDNbqOYIl8qwgSZINHvPXt0aXfzgy1Y2g0rN
 bYrQRZJsTkPkAx6YExxBl43AtKww5km5MNMnDD8vBuZsNZxjcZbHx8Xlwm1jdp2u+bo7GNTWj21
 IG1zLyLzAS8vYfi7JxHDrtoSqFBrPpirC49OZE1teH+9IvSlPc47mMW1/bQOlzu25JgVKeG0gcg
 kLe/Q6B8E6V+RrdZImwtYlaP/r6I5B2cyVY95z5MESjHLX9giLp4OfqRRY4cZRa3z+qBMTRwG5e
 NLq2URwmzAlJRqKDxuLaM0foTqe8aO0z6tcbLqZuW8N2MYB0qgu+aYp5zMxRCSJqR/qPNpmL5l5
 ns7+/4Q90WFm3Hqz3E7zUlXmwFo2rjL0KlXarodh/E5v7oFIAUbu/GUfHkBHNeSpjndj1EhowsY
 8V2DLuQfvRNAV6K2LoW
X-Received: by 2002:a17:903:3d0d:b0:2cb:2b53:559f with SMTP id
 d9443c01a7336-2d0523be798mr9560245ad.35.1785524194766; 
 Fri, 31 Jul 2026 11:56:34 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d04ae193fasm9356625ad.7.2026.07.31.11.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 11:56:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
	philmd@oss.qualcomm.com
Subject: [PATCH 06/14] target/s390x: Convert op_ld32u to op_ld
Date: Fri, 31 Jul 2026 11:56:19 -0700
Message-ID: <20260731185628.23161-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731185628.23161-1-richard.henderson@linaro.org>
References: <20260731185628.23161-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
 target/s390x/tcg/translate.c     | 7 -------
 target/s390x/tcg/insn-data.h.inc | 6 +++---
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 79e02534cd..4f1e8db780 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2755,13 +2755,6 @@ static DisasJumpType op_ld(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-static DisasJumpType op_ld32u(DisasContext *s, DisasOps *o)
-{
-    tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s),
-                        MO_BEUL | s->insn->data);
-    return DISAS_NEXT;
-}
-
 static DisasJumpType op_ld64(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s),
diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 46a4a23d2a..00c8994345 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -510,16 +510,16 @@
     D(0xc405, LHRL,    RIL_b, GIE, 0, ri2, new, r1_32, ld, 0, MO_BESW)
     D(0xc404, LGHRL,   RIL_b, GIE, 0, ri2, r1, 0, ld, 0, MO_BESW)
 /* LOAD HIGH */
-    D(0xe3ca, LFH,     RXY_a, HW,  0, a2, new, r1_32h, ld32u, 0, 0)
+    D(0xe3ca, LFH,     RXY_a, HW,  0, a2, new, r1_32h, ld, 0, MO_BEUL)
 /* LOAG HIGH AND TRAP */
     C(0xe3c8, LFHAT,   RXY_a, LAT, 0, m2_32u, r1, 0, lfhat, 0)
 /* LOAD LOGICAL */
     C(0xb916, LLGFR,   RRE,   Z,   0, r2_32u, 0, r1, mov2, 0)
-    D(0xe316, LLGF,    RXY_a, Z,   0, a2, r1, 0, ld32u, 0, 0)
+    D(0xe316, LLGF,    RXY_a, Z,   0, a2, r1, 0, ld, 0, MO_BEUL)
 /* LOAD LOGICAL AND TRAP */
     C(0xe39d, LLGFAT,  RXY_a, LAT, 0, a2, r1, 0, llgfat, 0)
 /* LOAD LOGICAL RELATIVE LONG */
-    D(0xc40e, LLGFRL,  RIL_b, GIE, 0, ri2, r1, 0, ld32u, 0, MO_ALIGN)
+    D(0xc40e, LLGFRL,  RIL_b, GIE, 0, ri2, r1, 0, ld, 0, MO_BEUL | MO_ALIGN)
 /* LOAD LOGICAL CHARACTER */
     C(0xb994, LLCR,    RRE,   EI,  0, r2_8u, 0, r1_32, mov2, 0)
     C(0xb984, LLGCR,   RRE,   EI,  0, r2_8u, 0, r1, mov2, 0)
-- 
2.43.0



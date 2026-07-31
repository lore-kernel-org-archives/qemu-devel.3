Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C77C55174
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 18:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpsQL-0007m9-VD; Fri, 31 Jul 2026 14:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpsPR-0007RF-Ju
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 14:56:43 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpsPP-0002DO-L9
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 14:56:41 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2d049069377so8707205ad.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 11:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785524198; x=1786128998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0zga4fJJv4fba9suqYuJ61tlwNTGA2bHgKBpKuNfcU0=;
 b=wbAaxek8WeBMusJ+QRU5fctEtfrR78/ukNpvoHXIXkTEMWlYAvPZNbysHp3qTRifqQ
 hThFuDQDKV36xfa1myogz68TA/jWNBKzWqUhOzoqvqfjl6wYRkWF3z/RiY+cLfgTUkRH
 nxNTNk6eF+mJAItDb0V/S72HpqeRFxonbZLW7ECQV7k8MlK30qhIJa5HBfOxoZlHfoA7
 QqOzpu6fXEFJGk81ScWnps0deA3yUQKvUJ0+v/wBD0L+pqlXBxhexWdrYz0WPcHsA6uf
 DaHRf+e0ZiC1/VXkFBdefCaLhJsQZdCvBuD1vYLZhTXamjRg5geN6a2K3JabxbdvZYXT
 QLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785524198; x=1786128998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0zga4fJJv4fba9suqYuJ61tlwNTGA2bHgKBpKuNfcU0=;
 b=igvLxZzky6poYczYf9Ey8nLWLdtyL1IPlR8HJNXkM2OLtiSE7H91MzvKa3sTAmcRMt
 HubO5WA1GOjAoDH6oC3pUAX4F1dKleb56cJfU9OxrKRKcBP6H/gAhDl+HD7s4KAHh58K
 cyNYhKth9KfHChMeFJtzxQ8kGu/V2OXsbPasD8uTCWQ0CrMrI7Nw7TsO7MNJ+oXZcqGr
 RRnBLFWWVAds+R10H2gXAPwSn/OGC1YL2J//kJNp5YxvjFf3/2BgOdqjlGZi3eJQCWRn
 UpcupRz77svxo2CG0YpGWPAIb3uzR+yYjZtKgjBuknogN4KYvlKMOJgQptdyWzUCx2AI
 HE7A==
X-Gm-Message-State: AOJu0YxZC9/XOomd2c4FPM4WwsivnE3C3XwVxTMg3YMpuxNDy5z64Iui
 K1OkSedP/hdOHS1U7Z4A1kAvgZY2Mzp5CMJJCHEU1Crnyy0/UDeFoJbSN9QuyX5wVf4YrDaNOri
 czJnU
X-Gm-Gg: AR+sD10dJSQpnOlPFQ09g5rr8a3zB9BopjYxElXNAGYuqFDACq0n0IaQap8KKrNj7I7
 NwPcZauUSobamdwmo7hAchv8dHZoQU06ZM+N/727R/zKoWIAzI6ZRBPfyxqU/MSzSnoeFub/Fxf
 nR03ukp6Bs82LUJQaEohuaii2aRYeXtVk8CthdIcFCdvYz5VVbV0Tpanzyh+I4WK2HnAX2+93s/
 APN+30XH30smtgijQ1Fodl7JCCrnCG15BaV/8iWAfm10ydNivpYtp+3uvdMFG7ID56Hoxfy7oT4
 ZTNGNnfInxObXorCYf1TwfJuM/dkfF4XicGxConkMstpq2m3Av3+VmNFt22bSbR9r1IfEC2HuiZ
 x6v9fLmCv4YYqKikIGDdWgU5mOmbXT/XanQodOkxq7zT34LLsitvbn2liROrmAQ4VNKulY/W7+d
 3XuX+gjl1RN1rOtxtjuZz1oSV3Dumrt35TnYa+jKcQShrFD6H6Nb2oNGFqP7E1L4VxiyNJK/vOL
 G2IcuhAuqYqZjUMfG9JC1ag8rawfoU=
X-Received: by 2002:a17:902:d986:b0:2c9:8f4a:90b with SMTP id
 d9443c01a7336-2d05219f70cmr10638955ad.3.1785524197985; 
 Fri, 31 Jul 2026 11:56:37 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d04ae193fasm9356625ad.7.2026.07.31.11.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 11:56:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
	philmd@oss.qualcomm.com
Subject: [PATCH 09/14] target/s390x: Convert op_st16 to op_st
Date: Fri, 31 Jul 2026 11:56:22 -0700
Message-ID: <20260731185628.23161-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731185628.23161-1-richard.henderson@linaro.org>
References: <20260731185628.23161-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
 target/s390x/tcg/insn-data.h.inc | 8 ++++----
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index feaada544a..8339a7868c 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -4348,12 +4348,6 @@ static DisasJumpType op_st(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-static DisasJumpType op_st16(DisasContext *s, DisasOps *o)
-{
-    tcg_gen_qemu_st_i64(o->in1, o->in2, get_mem_index(s), MO_BEUW);
-    return DISAS_NEXT;
-}
-
 static DisasJumpType op_st32(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_st_i64(o->in1, o->in2, get_mem_index(s),
diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 6fdd730985..ca495d1dd4 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -868,12 +868,12 @@
     D(0xeb2d, STCMY,   RSY_b, LD,  r1_o, a2, 0, 0, stcm, 0, 0)
     D(0xeb2c, STCMH,   RSY_b, Z,   r1_o, a2, 0, 0, stcm, 0, 32)
 /* STORE HALFWORD */
-    C(0x4000, STH,     RX_a,  Z,   r1_o, a2, 0, 0, st16, 0)
-    C(0xe370, STHY,    RXY_a, LD,  r1_o, a2, 0, 0, st16, 0)
+    D(0x4000, STH,     RX_a,  Z,   r1_o, a2, 0, 0, st, 0, MO_BEUW)
+    D(0xe370, STHY,    RXY_a, LD,  r1_o, a2, 0, 0, st, 0, MO_BEUW)
 /* STORE HALFWORD HIGH */
-    C(0xe3c7, STHH,    RXY_a, HW,  r1_sr32, a2, 0, 0, st16, 0)
+    D(0xe3c7, STHH,    RXY_a, HW,  r1_sr32, a2, 0, 0, st, 0, MO_BEUW)
 /* STORE HALFWORD RELATIVE LONG */
-    C(0xc407, STHRL,   RIL_b, GIE, r1_o, ri2, 0, 0, st16, 0)
+    D(0xc407, STHRL,   RIL_b, GIE, r1_o, ri2, 0, 0, st, 0, MO_BEUW)
 /* STORE HIGH */
     D(0xe3cb, STFH,    RXY_a, HW,  r1_sr32, a2, 0, 0, st32, 0, 0)
 /* STORE ON CONDITION */
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D022BC982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 21:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Jo1-0002kN-Jk; Thu, 17 Sep 2026 17:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Jnx-0002bh-8w
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:38:05 -0400
Received: from mail-pz2-x0d.google.com ([2607:f8b0:4864:3b::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x7Jnv-0007hp-Nf
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 17:38:05 -0400
Received: by mail-pz2-x0d.google.com with SMTP id
 d2e1a72fcca58-85469e211a3so102344b3a.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 14:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789681082; x=1790285882; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jyZU+N5yvu1LYP5CuwJMUAje60lBK/WP3jpnYZoxaoM=;
 b=TicY3K2GNubJgd9bYbc0o48GfD4uhd9QmzpS6UstCwlD2Bky16B6qQ2TUjyCYdonT8
 8hz+eEUA5VLPe8neIZdFwlrWEEnh2/jrzG5U4eXpRYhb7DGSSJ0sD10LGp/42/imujft
 aHFe5PpzOt5RKIiDUMCfSOIrhdz6sFG8ZNS80a61aRnyUhobHm+rK+0J6ZQ3OQchq3Ja
 lS5YG9StKX+aSmvdw5/KLPYuKUD54MdBJadA6xC0dyQhq1CaQdKcaSbb84HAtO8+1s3y
 Xn6kAOulR4mO9I3QNb2oDEvj6I+EMUn99I1ZcG258tpkHZOrwsNjUZFcP+IHnOXDVXoX
 8RsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789681082; x=1790285882;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jyZU+N5yvu1LYP5CuwJMUAje60lBK/WP3jpnYZoxaoM=;
 b=JJbjceOabYtjj7ptCXewEobz3au/dNtp0iqQUc8TVppvzt6Nl1S6soJJLqeEwMzhlX
 ToLCdzE5XinFMjf7hMTOw7iv/DA6X6oWJ6rJBDG8pCn9+oIwrJIE2tm7sjIWp/ijJioe
 7JpA19UiY5vUl39F/Lovd9zjspWWrfOhs9GtbRSKYz6uLg/w77Oxf0h5w5vu/1uB6MfW
 AZn6W67tvGU5SprIDN9xDskcxMZJNXV48luvzKsq61dqI5MPPF+ON5W+5opLaKANw8vu
 J+oDK7o8hgZN6fHX9iq7mvGrQ+Ba1q6x/PfiwUqMZMMP+/2jGlLeaRN9DNn66E9sB9vo
 X0Zw==
X-Gm-Message-State: AFuF++ljQmMAKRWquCHFLdl7prlmgSymiWu4b3gkp8Dnz59dBU54psRs
 0f5DNdvtulpIwgYl4Tha/XR2qZpwUiKDdtiXFUsuVkmgWCCAEjJ7CSYtx7ekhHY/6rVLG2TpgvX
 l4my+/iQ=
X-Gm-Gg: AYBFou3Bx8Uau01N+Sd7Qw1dkyPm3wquEIx/iIEZ1c24o2eeFhz0w39JX7Skg1CdmYo
 1RjMgs27gZEvI7KzWIFg3xSJK/DGvSOGKL/sKct5yDVjwZi4dFxtfzFDy5cqwGmNAK7QAU6czfa
 uutWaM+77mEY0uEEAOUTWBu446QvzEX0GikOiXYN6G4w4VbaWae61JWNA90VRjjcs2zDHd5cmB2
 u+jLQgu/4IbcifbSJpgM7ezLWQx5vyhxkO3Za/qGbyRm1aP22tVPh3vXU8OCOq9rv/dybb7R64w
 lKV/n3dilCm+DY4Nai2eNSm/THgEX2PNKSaeWfn8rnXY7V3CB2RsVGJa9IwC1N061hzg3MGVUs/
 yghJ7b1JmqmglwTdSye32DY8MGuJcjo7A5rLwItUJ99nn0IxpiAB90EikJclDknljmAsNAp2Dyx
 CRAwEvBSRtqtCZ31TeoOAS8vVW/sTHKfc5o7XRiNCQDa7BQFeHrj1thdBrwzQk+BQTm1htpj7Mg
 1zAUtc=
X-Received: by 2002:a05:6a21:3482:b0:3d1:8876:fb1e with SMTP id
 adf61e73a8af0-3dd8c21b4e7mr716253637.0.1789681082166; 
 Thu, 17 Sep 2026 14:38:02 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:5a4b:653b:1dce:569f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf56d7e5bsm18178395eec.0.2026.09.17.14.38.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 14:38:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 08/15] target/s390x/tcg: Convert op_st8 to op_st
Date: Thu, 17 Sep 2026 11:37:42 -1000
Message-ID: <20260917213749.36756-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917213749.36756-1-richard.henderson@linaro.org>
References: <20260917213749.36756-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Begin unifying store operations by storing MemOp in insn->data.
Start with op_st8.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260731185628.23161-9-richard.henderson@linaro.org>
---
 target/s390x/tcg/insn-data.h.inc | 6 +++---
 target/s390x/tcg/translate.c     | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index b7d174b7c69..fe90d61c885 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -859,10 +859,10 @@
     D(0xc40f, STRL,    RIL_b, GIE, r1_o, ri2, 0, 0, st32, 0, MO_ALIGN)
     D(0xc40b, STGRL,   RIL_b, GIE, r1_o, ri2, 0, 0, st64, 0, MO_ALIGN)
 /* STORE CHARACTER */
-    C(0x4200, STC,     RX_a,  Z,   r1_o, a2, 0, 0, st8, 0)
-    C(0xe372, STCY,    RXY_a, LD,  r1_o, a2, 0, 0, st8, 0)
+    D(0x4200, STC,     RX_a,  Z,   r1_o, a2, 0, 0, st, 0, MO_UB)
+    D(0xe372, STCY,    RXY_a, LD,  r1_o, a2, 0, 0, st, 0, MO_UB)
 /* STORE CHARACTER HIGH */
-    C(0xe3c3, STCH,    RXY_a, HW,  r1_sr32, a2, 0, 0, st8, 0)
+    D(0xe3c3, STCH,    RXY_a, HW,  r1_sr32, a2, 0, 0, st, 0, MO_UB)
 /* STORE CHARACTERS UNDER MASK */
     D(0xbe00, STCM,    RS_b,  Z,   r1_o, a2, 0, 0, stcm, 0, 0)
     D(0xeb2d, STCMY,   RSY_b, LD,  r1_o, a2, 0, 0, stcm, 0, 0)
diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index ffbef87f595..beb714b554b 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -4344,9 +4344,9 @@ static DisasJumpType op_stfle(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-static DisasJumpType op_st8(DisasContext *s, DisasOps *o)
+static DisasJumpType op_st(DisasContext *s, DisasOps *o)
 {
-    tcg_gen_qemu_st_i64(o->in1, o->in2, get_mem_index(s), MO_UB);
+    tcg_gen_qemu_st_i64(o->in1, o->in2, get_mem_index(s), s->insn->data);
     return DISAS_NEXT;
 }
 
-- 
2.53.0



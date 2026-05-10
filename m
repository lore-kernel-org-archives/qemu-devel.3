Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D96CCD37B2
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 20:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMAwh-00052n-VM; Sun, 10 May 2026 16:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwg-000528-92
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:14 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwe-0003yh-Nz
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:13 -0400
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-47c941f6bdcso2424194b6e.3
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778445611; x=1779050411; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PEu4bxdZzBvm/FcrMu/o48/BBVs1bzBzMRb6ggGLE68=;
 b=l7CopqDtx8zQD+WZjsS9ZdNQdxnA11iLSkB1p6fOiGXoGIXVazogqESGF/1qL86jpV
 +YdNpY9maAUUZj/andXfbNwOTHmu64M3nR7GU6Vcwm+vje/iFq6E/AuuhyEfhWtZ6XqU
 SvJ4c4jTexZ9reR9ukmL/zmkxWT75CcrrDjQZOnACLYHr/wMhniC5wz8lDritgOKRJPK
 9AkBQXzKQNF5Op+Ttb5n34MO8DwnR8hJ4jQoyPxpvY3S59acddZo0SER84kFbZz9Dh14
 A50e1BQVNo3a8Ti6q3tN19uOJR96A0Qk4vu8G8EyZ9VtjsHe2pRaFSnKgQeZzx5/pdjE
 eDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778445611; x=1779050411;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PEu4bxdZzBvm/FcrMu/o48/BBVs1bzBzMRb6ggGLE68=;
 b=kRykoMhYqL5LOyB64r1v9pRwpHEBpj8HZ+co7fmXVNpx4UAr3lD2l3zkk+op2IQMnm
 juxeTU4HmnmcX7YwaXk75CqDCPElEgipaUMj2Zn2QPFvih/VU33JeD8oire4Q6TTtA1j
 TfVg48vul/h+bGOhHn8AqPl9mBzDivZaZPAifvySBPgaQfGX8BRRROqyS9f7pQQyzzc5
 0Rz/Im1YjAUg4V2h6EuF634vKTHxlcm7CrAKan1CHGOCBHpa6QL3FOaRwQCD7NTWx+aI
 HOLbmLRsMbcIDR5ibDb3JDvL22FhqqYrkyZrw2aAyb2hvW7ngZMmIDrZD9N4gzzP0Hvo
 xfxg==
X-Gm-Message-State: AOJu0Yy4yewBah5jjXbq1nBeSsy/paAH7AIqZKthQEk7KZ3KzJgEI5eU
 3ce0JAXr3/vMuR/QGXazBdp8+GbGHAbGNK9zVlqR3Ddh2OZUP/7SxZSW
X-Gm-Gg: Acq92OGrU3YAwIeinLab9wCoSZRkmKCwHGepoTrnRFy+gMoosF4Vb4LdPgTcoV3U/FP
 yztN3doLXS1Z6Yu6JGrNJ90DJWOzjLKQ+wgHck6DwLGSUywkSpXQ0WfxUdZrIXtr078E+q+cQ8e
 LGChjbadO3Jr9aGoAzMs+TDqB6oMsbL17DEc6/xO9SsKkntFdjDjbWkmTEaPh00pb/1PxTbWKuV
 RNSLdXYl3RCUgPxcVOyqAVXunRwIEzEGkCpaGK+VBB4rk4UU405eJCX+dK/JzxZfkZWmrBLU3hC
 wTcs/NTkOEWcAx9e28QTLWPkxkZhr4jzS6dfxrMB+YOTUW3pYH6Myf2QhjIN0ucW/Qb3qyYJ9Lm
 hqQppBe9eLSPGbVx6YZAS/e/6FnFtU1d0DCpH9cXSM2C0piiebCV3hBtdjqCKPrBLep/igoG1z1
 /Pbs9G8GN02AVGZ5plXq+VwtK4iTo3vrTei3T4rQ5tI0eYxaG+mJeOabgrBDaFwhiyFQpFSYWnr
 tXk4VMZrxZTIG3UDD1X6I3eXIBsPtOcH4PAOQ0V4Wk=
X-Received: by 2002:a05:6808:150d:b0:467:1a69:d0be with SMTP id
 5614622812f47-480424e1a7dmr13433253b6e.32.1778445611515; 
 Sun, 10 May 2026 13:40:11 -0700 (PDT)
Received: from MacBook-Pro.local ([209.245.15.183])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76935637sm18908207b6e.12.2026.05.10.13.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 13:40:11 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 10 May 2026 14:39:39 -0600
Subject: [PATCH v5 09/32] target/mips: add Octeon LHUX instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-mips-octeon-missing-insns-v2-v5-9-d5d2668d15ab@gmail.com>
References: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
In-Reply-To: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x236.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

LHUX performs an indexed unsigned halfword load from base + index and
zero-extends the result into rd.

Add the decode entry and reuse the common indexed-load translator with
MO_UW.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split LHUX out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index efb1a48b38..8a755075e8 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -48,6 +48,7 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
 LWX          011111 ..... ..... ..... 00000 001010 @lx
 LHX          011111 ..... ..... ..... 00100 001010 @lx
+LHUX         011111 ..... ..... ..... 10100 001010 @lx
 LBUX         011111 ..... ..... ..... 00110 001010 @lx
 LBX          011111 ..... ..... ..... 10110 001010 @lx
 LDX          011111 ..... ..... ..... 01000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index ecdce6ab9b..5a189c6484 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -164,5 +164,6 @@ static bool trans_lx(DisasContext *ctx, arg_lx *a, MemOp mop)
 TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);
+TRANS(LHUX, trans_lx, MO_UW);
 TRANS(LWX,  trans_lx, MO_SL);
 TRANS(LDX,  trans_lx, MO_UQ);

-- 
2.54.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10BB3CD3427
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 20:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMAwl-000548-EF; Sun, 10 May 2026 16:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwj-00053f-VY
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:17 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwi-0003zh-CK
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:17 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-479d85152c9so1433198b6e.2
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778445615; x=1779050415; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3hmk9qzN5HeCVX+0rIOHRUrubJl8uCd6CnVJBu3Bj/I=;
 b=YIaZbnoIOysPsAriF0DJ9d+FJdsZhGxJWtVj5ob7CGopbiwU7+B6dY7CwGJ4VCvD0m
 aFKyvCNnUFzR+XOVRsOqy7ouf/iRffY+P7O/wmPjt4MdPAhN/ubkpbmu8gDBiXHgcJuA
 IPimjxRE2a3AVLDiJTnqaP4JrYDwvhyuPGOXYCbTKdtdnvihWS2VuTGpXi/9jkUS2ILv
 lyAp9CqvAirNat+QiPbDrNKWCkNUFcU6B3ekVrZrKs5jDsBomxO0nKbDqdmJ/plQkbUb
 /KASfZNAafanN3ITpxNFBCfzN7V+BwyGHDWqwSZb9K/WzwuHzLxxePaartNnWOr5gzeP
 5sDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778445615; x=1779050415;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3hmk9qzN5HeCVX+0rIOHRUrubJl8uCd6CnVJBu3Bj/I=;
 b=LKEEGaoLLVVFjRou11yXh7xGeYbhFCktjerzPPDWMtaP/4enagh+KSTh9E5sF15yBY
 49zme+iL/XEq0kZeB55XhCHXpQb81wK1FfcEV8tBwbPv9c4zQv2B5SCjyWB1gM4GGzc7
 6DZequ+Y2cPBF9SpMFYZy5pqsEYzEobOoFK69BX8jr6JrMKpeSPw5mIpJ6CHMyj83dbY
 O4+1MGJnuTp3xS+dh4UxhA7JbTcI3htaCKO3/+uOmOUVQB9pY26G2CuNCr0konJ+8RJb
 9fX61rIoOwACSH2rIXJrrnIrKtJV7Ed48b60YNwUI9ywNwAqVXFfGNf8ZCvGX0KNmn6+
 Wl9w==
X-Gm-Message-State: AOJu0YwRVQ0le9c53TL4JFYXHkb8sgxD+JtXZ08nmrnWzSNlOBJM1tqs
 pVnDSL85b8i4jY9+4Lr7Sc2mMq1P9QNV4jn45EEv/88srVVdWcdlqEaI
X-Gm-Gg: Acq92OEc9qdDSb+DhsKe5ihM0mjGN3lOuG2V5rd+CdOZxK4oArmo7wSpfnsILuNAdOu
 chh0aU3j6mtlllOwaW4iyAtsyG8Lf29xwRukoJBZcQK33XWuPTkpOtQVgzaA/SczHD7hFPOD1jC
 utyn8TF/KVe5cq8NnZpciqoruwq2r64h0cvoj2V3zgYRWng9Hp+aSI7LhjUxR8irYvLpM28rp6/
 ZWwZcDH8RDHIeOGc0mk8ma1Gmn4AcNqijlT96xejjNTujGD4teuT6hm55cosYghZoy7eS27E203
 Q/6XdP904lPYXPxCbJlF8/ISVgVqaPZ2BypiuzANbbFmQt59gqOYIrOfFfBYotPo+BctiMWB67+
 DX24sPG61I/D2+tcmXxX78LOGd4TksyXUtfAqoXtqnPbOmluU7Lyz6sdYF0zkA3yo+wjz1J3lKK
 OVrurv2eZwIbwilfSb4hlJ6oAWIAfi/n0etl9C1NfeT4oibYxMa2vjYnmTjiqXeQlQNfBbKXL96
 TBoKPUH+FVhXHsuM9b38TBuuARL3Ztb0KIpV4QXips=
X-Received: by 2002:a05:6808:10d3:b0:474:7000:9669 with SMTP id
 5614622812f47-480420dcf07mr12186941b6e.4.1778445615285; 
 Sun, 10 May 2026 13:40:15 -0700 (PDT)
Received: from MacBook-Pro.local ([209.245.15.183])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76935637sm18908207b6e.12.2026.05.10.13.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 13:40:14 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 10 May 2026 14:39:42 -0600
Subject: [PATCH v5 12/32] target/mips: add Octeon SAAD instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-mips-octeon-missing-insns-v2-v5-12-d5d2668d15ab@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x234.google.com
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

SAAD is the doubleword form of SAA: it atomically adds rt to the
naturally aligned 64-bit doubleword at base and discards the old memory
value.

Route it through the common SAA/SAAD translator so the MemOp selects the
aligned doubleword transaction size.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split SAAD out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Note that SAAD shares the Octeon+ gated SAA translator path.

Changes v4 -> v5:
  - Drop the Octeon+ gated wording/path and keep SAAD under the existing
    Octeon feature bucket.
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index d6b241de42..d77717cd50 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -47,6 +47,7 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
 SAA          011100 ..... ..... 00000 00000 011000 @saa
+SAAD         011100 ..... ..... 00000 00000 011001 @saa
 
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index f5f09464ce..dc16a5935e 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -175,6 +175,7 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
 }
 
 TRANS(SAA,  trans_saa, MO_UL);
+TRANS(SAAD, trans_saa, MO_UQ);
 TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);

-- 
2.54.0



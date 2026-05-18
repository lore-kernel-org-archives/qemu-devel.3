Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B385CD343F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 05:36:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOqZ6-0000BX-Hf; Mon, 18 May 2026 01:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqY8-0006vO-S5
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:30:06 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqY3-0003Ui-3j
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:29:55 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-482de4ef03aso2000146b6e.1
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 22:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779082179; x=1779686979; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=P2Mj45RAAwGdrfXORpwPuB7qb1PJq617SPQj0GFS17U=;
 b=ib6XrKd/AtFuWzJ/EL0Dcnpaf2EISdlzbSKGVHmNGABIg+txS/U4qSZrjJMr+SbQYz
 REyNditq0SznpX343+eGlEf8OmPoVBTyhju6MgHb7mFLUWj63OaJTAJW6QvYWvoS/qPv
 a3j1hWN3xfhu5TE98DUo4YrIT192mviotAuNNvScBlQVw/S5nl4VkfUTC0z1aWyps2/+
 ZyJgwNdBA/boQJ4i7URmwbgVoy2Mu19yniQcvan0zn5rvBhPutQtGwlki+WYRXj1UaRg
 VdRNvBljXjSrjeuFYJ81jFaid4nQ9uNmzSqUZ78OylxwbStrb3xcb0SGTAQlazQRaR9L
 qEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779082179; x=1779686979;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=P2Mj45RAAwGdrfXORpwPuB7qb1PJq617SPQj0GFS17U=;
 b=p7lgpz8bzkfmGkucVfIW/60AzyXXZ870HlYc44YZuqhdm+YB+dTYmgYJPsq43W/Xid
 w3jwpovRWqwXdQTTHQHYn3aWRpC5b4uvU7wCySth7I9n370WwH+nvD1yWKq9Ms5m1YrX
 ldRZpFAOq3w161G4zxA34j5fuEM/67blgjXZn/GDEj/tg99D4uje+/hArQHlh70q68wp
 Y6RCuQnUAgZNFyzSWFWQ22LMDDPb+Fom+jQzTckXM/HCW9SX5DDpKl8hRWiFVCuYFhUQ
 OyAYsRa5q5NfRyy7yHPCwwqAvja4O8H+JFHlS6G9zitKX+yoGMX7OCJgJfjktrujQx8c
 k+xg==
X-Gm-Message-State: AOJu0Yz9meQT4eqQtdK4IbC3B7E+GLbYASG2KotNkd+w/vNZeEDTK5Tl
 pTZgrHSYCJdhB7LKUMbQOKOPQN1SSY5w1BFWgDKUj0v3WXPp64C7s+NI
X-Gm-Gg: Acq92OHvJJB/KOynfajAFQKV/9HgolC+hoV1+cpsiKOJZ2e4iyk+LeqCgTwOsko/fcJ
 CFYlBjWhZ7xboRk3+VotJky0N1gXxe4FHeMcPJZaadhW+igCc0Oza/CUKY8/0B0g5z6DDZKmjLu
 +X/h/SyTku+oZtcEy+V3H52frtefezo+XGbJzL1qWwcqvgQQajSY2GAKIf3ihLz0+dWpXVxOPyK
 I99IRVfnOBjdLuPuS68Q8yhQ3ER6MljKr9AivdGKwVvqkC+0xHvzmcBbgC22ZM5T+6cIL9xcf6/
 TCa3agy8WSg57H/LyuZSw4usANKGP4Duj+ALeMN74CA7c+pSdGBXk+EB23+KdkjZIcKgokgYW/B
 qrT0Q0UmwkElYzkApvCCr3hB8JwQSV6YzNBu2PlpKpc4uKEYzU72j5EMpOxsllosh8UeVv8VAMv
 wVJKcKz0e+R/yvd0fzAQrszGHE4PuKV4+p7cbU/Wxs9kpl80JmDsrmyJdGjPHHVn4U8FC03g3Dr
 0Edz45ZFF5pN3pkZFtmuDGOSgAfEQ3L3kwwSqbAAULHQ7nOZb9QKdPsZFKfpGt9xK7ERig=
X-Received: by 2002:a05:6808:1482:b0:47b:d07b:ec9a with SMTP id
 5614622812f47-482e4646ab6mr7967191b6e.15.1779082179010; 
 Sun, 17 May 2026 22:29:39 -0700 (PDT)
Received: from mac.localdomain (71-218-255-245.hlrn.qwest.net.
 [71.218.255.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-482ee5349a5sm4628357b6e.15.2026.05.17.22.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 22:29:38 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 17 May 2026 23:29:13 -0600
Subject: [PATCH v8 16/35] target/mips: add Octeon MTM instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-mips-octeon-missing-insns-v2-v8-16-206151ee77ec@gmail.com>
References: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
In-Reply-To: <20260517-mips-octeon-missing-insns-v2-v8-0-206151ee77ec@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22b.google.com
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

Add the MTM0, MTM1, and MTM2 forms that load the Octeon3 multiplier
operand pair from rs/rt into MPL[x] and MPL[x+3], then clear the partial
products. For MPL0, also set MPL[1] to zero for backward compatibility
with Octeon2 VMULU.

Legacy single-source encodings have rt encoded as $zero, so the same
translator path also preserves the older Octeon behavior.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

---
Changes v2 -> v3:
  - Split MTM0 out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Keep the Octeon3 two-source rt high-lane operand and document that
    legacy one-source MTM encodings use rt == $zero.

Changes v5 -> v6:
  - Clarify the CN71XX-defined MPL1 zeroing after checking the
    register-state table and description.

Changes v7 -> v8:
  - Combine MTM0/MTM1/MTM2 in the v7.5 inline TCG translator form from
    Richard Henderson.
---
 target/mips/tcg/octeon.decode      |  7 +++++++
 target/mips/tcg/octeon_translate.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 01ed3b50be..5139543b15 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -44,6 +44,13 @@ SNE          011100 ..... ..... ..... 00000 101011 @r3
 SEQI         011100 rs:5 rt:5 imm:s10 101110 &cmpi
 SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 
+&r2          rs rt
+@r2          ...... rs:5 rt:5 ..... ..... ...... &r2
+
+MTM0         011100 ..... ..... 00000 00000 001000 @r2
+MTM1         011100 ..... ..... 00000 00000 001100 @r2
+MTM2         011100 ..... ..... 00000 00000 001101 @r2
+
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
 SAA          011100 ..... ..... 00000 00000 011000 @saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index d89e53045e..0abc839907 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -210,3 +210,35 @@ TRANS(LHUX, trans_lx, MO_UW);
 TRANS(LWX,  trans_lx, MO_SL);
 TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);
+
+static void octeon_zero_partial_product_state(void)
+{
+    for (int i = 0; i < OCTEON_MULTIPLIER_REGS; i++) {
+        tcg_gen_movi_i64(oct_p[i], 0);
+    }
+}
+
+static bool trans_mtm(DisasContext *ctx, arg_r2 *a, unsigned int index)
+{
+    /*
+     * Octeon3 two-source MTM forms load lane index from rs and lane index + 3
+     * from rt.  Legacy one-source forms encode rt as $zero.
+     */
+    gen_load_gpr(oct_mpl[index], a->rs);
+    gen_load_gpr(oct_mpl[index + 3], a->rt);
+
+    /*
+     * Octeon3 clears MPL1 with MPL0 so that VMULU sequences remain
+     * backward compatible with Octeon2.
+     */
+    if (index == 0) {
+        tcg_gen_movi_i64(oct_mpl[1], 0);
+    }
+
+    octeon_zero_partial_product_state();
+    return true;
+}
+
+TRANS(MTM0, trans_mtm, 0);
+TRANS(MTM1, trans_mtm, 1);
+TRANS(MTM2, trans_mtm, 2);

-- 
2.54.0



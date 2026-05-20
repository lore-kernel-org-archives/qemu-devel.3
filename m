Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F12CD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:42:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYgg-0001Ap-5J; Wed, 20 May 2026 00:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgd-000193-MU
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:39 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYga-0003oK-H8
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:39 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7e4de538f83so2561210a34.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251854; x=1779856654; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4/74NRrBxg1oIEQf38kJVSZR++dNhK44DvSC+CVqWhk=;
 b=GocxordfWYXqxTI3kXG9iytDHVQTXMqgHvnoymzMgiZFOE7432stt9SkT7klB98xDV
 sjMWpHEq/Cbe8NJnb8DtLNp65HQCVjhiry6aBHAkgIKnl9sdGzTnNjnzrBBYQ46lUmaT
 1CLa0ml4soHHNb66oWZOZ2oOZLHokrx5VENgO5xeF0e+3dfvI6fel+F73unhylC+CF/N
 EDkVFWLm5S4xnH7nUAmnVbSN3xsePQQ+uyGyVrUr6MBlLoyAPhZFF1pajPK2D3W2LVYk
 d8vf/ov4l97LLINi20y9qpmu2naVMLNHztWMvZnx86efIEdohjlVlMSoaguExzksgPHx
 sUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251854; x=1779856654;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4/74NRrBxg1oIEQf38kJVSZR++dNhK44DvSC+CVqWhk=;
 b=ax0ErZi2/l7Lfg4zx5nYt1x1EodXXhJDBk1OPMxzj7POSi/0Iip+fIZxBgtPpYM3eT
 f1yywerjDj0TiByP42mFxSh028XANleAr3yt2840gzWf6iC8YepoVIo9vaizA2aJLPO/
 sTeWcCDg/Yl00eK7nm+63Vsu8aTGOglcAwnivC7qnsZycQGzmaVhTVrustwfdI5HkqV9
 IToRt3KQ2M3gruyvZNZClCZ9zTCKs0gu8WOb2/Ka/TGghzlVO3QPYOhW8xH55gKg0TDE
 XevMkoM4uqY3pp2NxzP8xSKneYPcdVsOuVx/Pyf0IXeKFtz3d5HeT2AOujXBY2xNs89c
 tMLg==
X-Gm-Message-State: AOJu0Yw5DJWFTGtBrdLekPlvID8BjHAtTI05LO2V0YFX1VjzfEZK7YK0
 Z0JGJ+1GvqIj5QNc5VvLeDCvDOgf1I1IU91sgGmZTNR9Et3W6DXp9bjnAp7rynan
X-Gm-Gg: Acq92OH3xIsnYoO2slxp6dVrwa7McZERNHcJsQwtEt4B5+OZOedGibqEg7n2+CpgJ9E
 j2+HdzrM7/cJTMlWGi50fQRz0SEbAvZh0/N1PxvCi7EG/Qoy2QKO2ZKEtRIA7b6FlcNaH1cbaDq
 3Y7MQpd6Xq5cIZfcmqWdBEbk6M3VCa6omIXv0OZH2ulMVmSHlfc8rSJ9+S8aPi4pc+xqdyD5NOI
 ScXVKBp/K8W8CFW7Amw8lvo2dJoJJq2Z6BOht4W90p0KDTseJa2WdAZJRlzeIa1fQLRaEf/BUcM
 eF0NKl3uBGvwbSzIW9Vhlvnulvdtf0ZsJ9gmERXjUtNtHWsQzqjKiHt9pX2Mq5hqdKPl97rD2TX
 7d+hmQ8FRlx0gsEcnGVTtGtwzh9RvTHUCbtqhlrKcwX6WC8EpF0kvWihYvAU+qisrUo4tDGS/y5
 bjtz86cbMY0ngCgxQ1gO0rzzD1Z79S9RrtkSvACnJfdc9fsn1DLiQmS/nRAkw6hN4gf0fs/eAVU
 oNH/vxLsAcgYJJO9OwJjlMxs/oPfZpWocSnKmbwbSFkfXvb+nHRdJ98P9w8OHAu8EUu
X-Received: by 2002:a05:6830:8c6:b0:7e5:68ca:8856 with SMTP id
 46e09a7af769-7e568ca8bb2mr8262896a34.26.1779251853673; 
 Tue, 19 May 2026 21:37:33 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:37:33 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 22:37:10 -0600
Subject: [PATCH v10 16/45] target/mips: add Octeon MTM instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-16-306f9edfe15b@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32a.google.com
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
index b5ebad9804..aae6e9811c 100644
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



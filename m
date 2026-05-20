Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4379CCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPf5I-00028N-6Q; Wed, 20 May 2026 07:27:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf4o-0001VE-J2
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:27:04 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPf4f-00044C-9B
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:26:58 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-67be871ed3fso10565357a12.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 04:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779276410; x=1779881210; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y2ftIcejqF7pf3PGV+e0jciQnSDe6xE1w0+bNOQvv6Q=;
 b=vfvDduzXkhwDvwFMZgdVBXr8x5ziYc7yLfXiPR+AeKl45oXrtyCZdlKOZuWY6icHOG
 B748t7I4yewL98GYoETjRE4v/GFBrufmyZgwpaVT1qGNKKCIkN920KFB3myHXJRokERZ
 4djpJPsZuEOpHn4YOF2KQpuT6+4qHo51a3puri+5GVp/m7QrmhOsZ6DGUswiaAunyUOM
 XkCIIdyTvLsBdN+Zxk+asJ8lY5jwSVqDsTaeWtNTwhCpArS/4fF7T/pzQCw6o/mos5ZU
 lhcnilC0ODJphNz95OL3kZJlSjqPdlc4LPB53Ui3OonpzSg1eWrbvoZu0oK8LTxhLVV0
 1ILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779276410; x=1779881210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y2ftIcejqF7pf3PGV+e0jciQnSDe6xE1w0+bNOQvv6Q=;
 b=FtLixnfWZ/NI0CZpLZq7GPvwxf+mRPs34vpPmPJp15xLx+I4J/jyGOnMwx6N3ZGkVu
 AnpZ6JpdhhSabDMwuWodysz0k0EAa+dLg/3kKFfrZQRdso3CzmUFgvlJ3XqDtkQVKwju
 59hTd4YPONHIny2yGcmSjj1n7UZWndyOi2Fbx76Ea/9AXOH9JbqpnAfZ8nv3DBTGta0Z
 jgIOLEbOHZzYuShtGiwZ4n7RsJ86/pKTcz/KeozOvHyegeafj+XA5+EzvSO4swEMpV02
 vBsZohPdJlf1EsdiaCNVxnTcBWOfj5WciYWdVNUIY27Pe8AJY4OW2hTvy/J0Lp2V0asd
 ru+A==
X-Gm-Message-State: AOJu0Yx/YUJbgG83jreWBvkfz6GoCh1CAMbZD4bedjihYQ3e653uOtSc
 W+fEQElRDob94F1SPCs6aX2zuAIuD1jeS0/w9O3Zpa1WFv6dB46ytxhjTgRuvoZN24vLU+YrC0a
 kE+3e3gE=
X-Gm-Gg: Acq92OH4Xg/iQr4yh7nWiBqfF4TNlZzLNDL7V6JlZhhEqYros/DWTGb3r7oZh7oaMKQ
 26rv5cJcUTIePfnMu+2ByO6J/53P4fUniu2DEt6g0XbduMEnqQhhPHr1CHqBGj67hYNpHkGBPk2
 dKHQb0fnt8P3/JYlAstyqKCEzzsw98hjL50lbLCuVX9nvfYyq/CmnfSCOYMN3CH8X0zLEpDaUc7
 /70rY/rhipaMBWWneMp9xNhz0bxV9bcwS4F3kQ3jS9ZZzdbpmJec7Z5XphTKBgO6fkK5MFTTYqM
 dr4qdkSlTk5knlHrUFIeo9q7cGblA084Q+aTDDmE6VDpAblt3Xru65nMmt28TWXMY+3A96VMNzA
 fu3CY/f8JHeV3NhFemIIBnQiK5W/YovXyKHSVn+LJJzF5AX92kLlPX/tjY5TwJ78rv8xTLkeJkW
 qUu4MsjTxJVhctgwXjDW71zZBHG+UJ8mTO+dn7Dv8cy5x565em65pZnx0xxUyFvvgNxS14B4rwz
 qi8Ww==
X-Received: by 2002:a05:600c:6d2:b0:48f:f199:4c02 with SMTP id
 5b1f17b1804b1-48ff1994c86mr182031885e9.9.1779272423651; 
 Wed, 20 May 2026 03:20:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feb00e5easm127454855e9.13.2026.05.20.03.20.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 03:20:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v11 18/24] target/mips: add Octeon MTM instructions
Date: Wed, 20 May 2026 12:17:59 +0200
Message-ID: <20260520101807.9971-19-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520101807.9971-1-philmd@linaro.org>
References: <20260520101807.9971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
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

From: James Hilliard <james.hilliard1@gmail.com>

Add the MTM0, MTM1, and MTM2 forms that load the Octeon3 multiplier
operand pair from rs/rt into MPL[x] and MPL[x+3], then clear the partial
products. For MPL0, also set MPL[1] to zero for backward compatibility
with Octeon2 VMULU.

Legacy single-source encodings have rt encoded as $zero, so the same
translator path also preserves the older Octeon behavior.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/octeon.decode      |  7 +++++++
 target/mips/tcg/octeon_translate.c | 32 ++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 01ed3b50beb..5139543b153 100644
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
index b5ebad98048..aae6e9811c8 100644
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
2.53.0



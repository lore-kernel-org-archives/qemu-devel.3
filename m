Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCD0C624D4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ONB-00012A-8R; Tue, 01 Sep 2026 09:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ON5-00010C-T3
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:52 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1ON4-0007A6-0j
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:51 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c25420fe973so145344566b.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268667; x=1788873467; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=x6RZtMUWEU74PB1FgRz3pqt0ToXGlta6YwXXlSSBNRk=;
 b=a5SXPX111un6KznJjxzMLbTKgJXIzyXoa2xr1WhNBm1KLDNHXLcZCi4ofUC7VoVPbX
 tQorSmN4nmgdGbXUD3mFr/rpzzfkpFJHVJrG8aacsDqIaVRXuDwcuoYwfJSSUup90SRf
 RKbPnC511tpXa9Q3OnkgAqwQfUE69XgGWyNcmOpXOFu/R/MKo4C+ANuW3h+PTFDwXuRM
 V0zcyEfmRCy4+gGR69DxXkMu1FIZ/b7nbxw06Mwu8J/XxHEeAa7cYEMOgzfkVnlDH7Yf
 lLy9Yl96oLsJHLZq5Y14oxl6/ZtU9uaZdbBapTTzRmMxwQG4nGTgZTd7/e97+Dcj2PSa
 4AIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268667; x=1788873467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=x6RZtMUWEU74PB1FgRz3pqt0ToXGlta6YwXXlSSBNRk=;
 b=ovN87HZc1I7oajoUPESKtmBpGKFFa5byO0im8laayNhCHLe8xbkwf3Vr3s/GoRn2f7
 KOKckmRjm3/2iOmPkeqTBLbsCPwIgFv6T9ZBffeRvqx5Zvmt/0HO4gTOPzuakZGV+2J/
 Pga5iBKG8qo8jDEPfDcPqmbuU9uyE5JwjevZnQhDVEg1dr5D4NqVJ69VW4x9vzUp0B3P
 7RTF3kSCEX6VTeazuMEwdEK+Dmf9N7AUn7oL5qJFOVRziFtXOMq4xm21IJqzipqEWWrs
 XJEhjM7LpKyO+sZqOg66gb9hInVEJP6XwEaPOcwF1zj9UYW51lVbrxfuTbgfS4oF/VEE
 Kmng==
X-Gm-Message-State: AFuF++kxJfg0dHxmJaTz3fhF4d8WvqLrYKNEwuT1RxE4RvmiV4RtgzwS
 6DtMUjmyvjnF8QhPaZjKA4SiaV5V5V3P2S/G1/FQA0sw28pQTave1ExzNaEzyDUD3kAT9dc/4Im
 SE1HUyLc=
X-Gm-Gg: AR+sD119EtHCzgIwO6k4xqwmFxESetWZJ8jJrU7m5vzaXudQykKl06s5Uh4S/k+ZQjz
 rX6yc/bP91XxAei+SkplVV3aLPsy6L2lSTAhkhe8Xz7gs/4NBFzE2Mda0u/BUyzeJAzWorrYLYS
 J3v2UnNjaFKX74ZtVNpaHtu5//+Ipw1s+n3o/HJjzq8bW0Ym800Mmi9BXiuUQ0A543VFkbc+NMu
 HKQwJ/cdtsnQZ/q+LsWZMeGALt3jg7pAdI75PSi2uUmuoDoGshWNfTiOWKjyhKws8JlG0KU6ysf
 D2e/DBqKWBNKicfur/ywIos641bv4BxyJHoTmM8KkRd5fsG522kYiWD/nRLUJmLQ0I0UjEG7NxL
 6J74++1KP712FiG1pVctwTAWFlHMLxUSM1QOgT0pxEHVtskIkKvNAS1dQfiHZvfPaNkFtUD03Zo
 KrHkNJsEGUS6KY2Fo1F11DTXypfJ2xFKeB5rSk4s0YFgvPd8CB8/XN8FM3ty8FjX9Ssp2+rmX8+
 jPDX6/jQnpLQUsVUYaTrr7DFX7rth42W1qgYvBpVC3QiJqjdxPe97gtnRmna66WXCf1fQ==
X-Received: by 2002:a17:907:3e04:b0:c1c:2173:d412 with SMTP id
 a640c23a62f3a-c2556fe9307mr2076595066b.1.1788268667603; 
 Tue, 01 Sep 2026 06:17:47 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.17.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:17:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/58] target/arm: Make Thumb T1 hint space UNDEF before v6T2
Date: Tue,  1 Sep 2026 14:16:47 +0100
Message-ID: <20260901131732.2263947-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
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

The "hint space" is a region of the encoding space which is defined
to NOP if not specified as an architected instruction, so that future
instructions can be added there which fall back to NOPs on older
CPUs.  In the A32 encoding, this hint space was carved out of the MSR
(imm) insn by using the fact that a field_mask (bits [19:15]) of
0b0000 meant that an MSR (imm) would set no parts of the CPSR from
the immediate, so it was always NOP on existing CPUs.

For the T1 encoding, the hint space is in a range that used to UNDEF
in Armv5, and so the hint insns and the NOP region must all UNDEF
before v6T2.  Rather than putting this check in the trans functions
for each hint insn and for the NOP space (which is a lot of places,
and awkward since those trans functions are often shared with the A64
and A32 encodings), put in a decode line that covers the whole space
which we check before any of the hints and which will explicitly
UNDEF if necessary.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4208
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260821132550.168896-4-peter.maydell@linaro.org
---
 target/arm/tcg/t16.decode  |  3 +++
 target/arm/tcg/translate.c | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/target/arm/tcg/t16.decode b/target/arm/tcg/t16.decode
index 9a8f89538ac..43cd36e949c 100644
--- a/target/arm/tcg/t16.decode
+++ b/target/arm/tcg/t16.decode
@@ -224,6 +224,9 @@ REVSH           1011 1010 11 ... ...            @rdm
 
 {
   {
+    # Before v6T2 this was not NOP space and must UNDEF
+    MAYBE_UNDEF_T1_HINT 1011 1111 ---- 0000
+
     YIELD       1011 1111 0001 0000
     WFE         1011 1111 0010 0000
     WFI         1011 1111 0011 0000
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index f013f94b217..8c56348a665 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -3340,6 +3340,24 @@ static bool trans_NOP(DisasContext *s, arg_NOP *a)
     return true;
 }
 
+static bool trans_MAYBE_UNDEF_T1_HINT(DisasContext *s,
+                                      arg_MAYBE_UNDEF_T1_HINT *a)
+{
+    /*
+     * The Thumb T1 encoding hint space was only defined starting
+     * in v6T2 for A-profile. For M-profile it always exists, even
+     * in v6M.
+     */
+    if (arm_dc_feature(s, ARM_FEATURE_M) ||
+        arm_dc_feature(s, ARM_FEATURE_THUMB2)) {
+        /* Allow decode to fall through to the hint insns and NOP space */
+        return false;
+    }
+    /* On the earlier cores, we must UNDEF */
+    unallocated_encoding(s);
+    return true;
+}
+
 static bool trans_MSR_imm(DisasContext *s, arg_MSR_imm *a)
 {
     uint32_t val = ror32(a->imm, a->rot * 2);
-- 
2.43.0



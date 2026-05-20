Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1CACD5BAB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:27:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmYs-0003N1-53; Wed, 20 May 2026 15:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmYe-0002IH-FM
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:26:21 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmYc-0002aP-MG
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:26:20 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43d76dd4ee8so2157630f8f.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779305176; x=1779909976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D2tq82yI60+rZ9tglV17LktFpgu56FwTNLrlnTN4T5c=;
 b=YlekA/8OEwNIRBOVxvELf00Banmde8zX6hBnTTtXZXdwF5FCxN6YEMluGekSil2cN/
 Zo44LKcSSjX6VMmP0349rvVab8hkpCzkBFlNJjHfl1pmEA14c9opLQTLYgUVtepdSxX1
 Uzu7KMIMt1Xtm+CWIyVCcz1/Bu+BgtrEoy47UR7x8K251jwFQ2usykg/yW8Hg85U22cO
 cNE9z9MOAtKN16z0wJQVa1UZPAN9HWrTk0Z5Q6brfjTwgOC/Vbqbp10NDg+kEJa3TYHm
 cBJsREDGADDZ+u46wwWzv+78n4V+KO9gwfk1euCYuKppEOn7xDWxuY/LsGk5O+q8DIqZ
 VwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305176; x=1779909976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=D2tq82yI60+rZ9tglV17LktFpgu56FwTNLrlnTN4T5c=;
 b=jnCylVxrRxPuTSu7SMnw6BIawOAfzuJQ8mCgJRlszDSehaiFtVRlYk/XuNuiCq6du1
 8HcHvWAwYyjhEq+8pRca5/yF/28cRuEr1Evspyz0nphRx9ksPq8wbCsUGrwEiO5ADwzf
 XWWz64bzplSR2gGxRNNLviEZVBBpFkae9gvo2XOhxKgTaVMyOfmJxv/V1nFL7QsDsdet
 4pKjz57Ys+HAl+KPNri0SoN0ez8+V1LsNO4dm82oyvfiRifOEdbkE17i1Yi50KNjqkcw
 rSJ5OzEfow7VcwChvF4uOFkF7wiZ3F/V+llkBLfLgDIunw4tE0UudgmhaKu/1MYoKg7R
 bzZg==
X-Gm-Message-State: AOJu0YyKmq07kJ4jKk5PI4Bp9urWcQGmiLOCHmMoGyP24Mia8O+r1xrt
 Zcd56IqjqwLSkc2YQzc4+fT7f3NrmlQa/7AFzbe6vZth30gPiKs+o/gn/yL1M9XB4hRTt+zwS3M
 3fL6S/uk=
X-Gm-Gg: Acq92OHqIedA1dWGx6ILm1H7DQ74GmcBSille2x655uwXUSfbnQMQm47BM+6wU8WbBU
 Sg9LlmhYu/G5drasOtH+I4ph1SmAYFCIbvoMl7GL9Pc40kymFMw6OqgeTcPULaaew0Lm758GR/y
 eHbzCCVFvQE2XoKSR1KpR+irJ2Ygz32raqOGFLfeKi1Bd4Rb3OzOya4MwnUdlSOAkh5pwuJHhnD
 z1w96lg2ZUQXgXhLmdCeDOWd6VkPrjg3ikSDKioBI3/ugLf7QmGL/xycgINA9UG4sBQg6Ay2vju
 13dT8hkccMOU8GgS8nNVpAKy+ikPgujhf+pRiFWk4XLlxVMIlwOmuQuDwNyH8xsxc5wV41hh0p+
 66/7evqaRVT5IwIoSamSIg3dW23vgVd0Dt+MvpRceocXCWdmU/FR9znlJI7tz8XF5rGRgeca61U
 N4LYm2v793iNHk8cTj4hBKIKBQje+3qSKCVvTetmiYz806KzyXDKA4XgoXt5wYMg/PQwYgdhc6
X-Received: by 2002:a5d:584c:0:b0:446:db72:e8ec with SMTP id
 ffacd0b85a97d-45e5c587281mr41881500f8f.23.1779305176376; 
 Wed, 20 May 2026 12:26:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e767cb9sm53927589f8f.2.2026.05.20.12.26.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 12:26:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/33] target/mips: add Octeon SAAD instruction
Date: Wed, 20 May 2026 21:23:27 +0200
Message-ID: <20260520192338.40036-23-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520192338.40036-1-philmd@linaro.org>
References: <20260520192338.40036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

SAAD is the doubleword form of SAA: it atomically adds rt to the
naturally aligned 64-bit doubleword at base and discards the old memory
value.

Route it through the common SAA/SAAD translator so the MemOp selects the
aligned doubleword transaction size.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20260520172313.23777-15-philmd@linaro.org>
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index d6b241de421..d77717cd507 100644
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
index 33b45611f20..23748695a14 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -183,3 +183,4 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
 }
 
 TRANS(SAA,  trans_saa, MO_32);
+TRANS(SAAD, trans_saa, MO_64);
-- 
2.53.0



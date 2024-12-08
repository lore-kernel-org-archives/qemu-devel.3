Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FEEE77173
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2024 22:51:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKQ5i-0007Pl-DY; Sun, 08 Dec 2024 17:49:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKQ5N-0007DN-Mi
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:49:11 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tKQ5M-0006Gv-CA
 for qemu-devel@nongnu.org; Sun, 08 Dec 2024 17:49:09 -0500
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-71d40003870so1003046a34.0
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2024 14:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733698147; x=1734302947; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bZcHraMwog49FpjWBRy/5OvBtZMMG8nX2q4nrJkRJ4E=;
 b=KUXTFPUnJ3mYpFD8rolXON8FSOrsl4yt1cys4cWnspxaU8+ki1cwxmsYa+LZl3+yVX
 OzdNz3n71QZScLOX0YguMu+K4qTWW/A/qFl16ynLzcSp61XrMWWWkFAae9D5hIwSUlgH
 QWThEp0Qs1HP3CkEp2zrq29lGKOMcg6duzl2bin4yTEahlA6a82WnCGwdUDtjdjlpZ+Z
 73FNkYh0+r5zJMiujkDh6OdAEJJtMOvNxRwCj03wGI7RuANtok5KWRfbKVJvbYg2BrnD
 wQ2G3PAew0pbIgOBx5oawNBHue63dlxII1y8RgLUAAPmL8DWnMplMUvH7E4ckBx9+hZR
 /bWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733698147; x=1734302947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bZcHraMwog49FpjWBRy/5OvBtZMMG8nX2q4nrJkRJ4E=;
 b=h1+RRircYvKxXl/ylH+PYTb/C+P57pdfxnUTVvzxfdYzGh/ZNR8OVSZwtkP3oTVpzV
 MusYQs9+F5jFQLena+VtZ1Nf+fst9HICv0o731NvTuxRmLhozt5GMlRBrNLQ8Jv1iT4+
 YFkNFb7YQySBwwtos/AkS7OtGcBKT1LD9aQx+LkyMgGFEO3iao/5jSVA80Zj/9x/QAi9
 21vo/o1wrXdebIhb4jkQHYNzS1HHHsu3q9QI2npWIHqLiE3h/h3c9d5ZPT2EKzliSEcw
 6UDQXaNAykqgfw0jZh50a4pdDvEpPfo0HcbzZdt4OYYhKqEkosAgQteFNkCg0Wl9UOc9
 Vu9Q==
X-Gm-Message-State: AOJu0YwidJJIXCeAxsK6YcXVySbOsfXl3UHQVOH/8FfX9LaVM8Z182H3
 B0sewuHMXaMN40R4yZtucPSQUMn8og5qksMiOYbG+CgTCP6hHJblXsN95Wrl2GV8fCkW5Nl9qEh
 543Le2Q==
X-Gm-Gg: ASbGnctFE1iA6CZXUHyW+XP9VPkHUIjV5raL2k8bJvOBUM/Ec3HZCRSdxrVDo68yCuF
 HMttMuQ6M/AYiG418k/kljKZSF2CX4M0krqZItfjVH+5Df+dwfzsqA+EarEco7cQaKYfQOG9uJD
 nVeAo7WtvQKsVMR6A8RaEkgpfLoBX123wFEIpVIpX1YcZnD+OKhf6u9YMF7uh4Gk/v1MIKdpw5G
 tyh3eU0KhZPD7JnvcYfhJQDPIuUWDR7QbRkWzlPs/ZLtVGwhdD2lBm9NWkCnU38/bw0hD9vrvir
 uH72iWSbgG4Dqt2Dorm2DeBXbHkicsn9r+bb
X-Google-Smtp-Source: AGHT+IGV3cEQGm049RUkepu7/hyLkoDYYAtJ6gCc16+xCmhLVyuEMh1KaKSKFF/pinfcVsFByotWVA==
X-Received: by 2002:a05:6830:25c4:b0:71d:4488:19f2 with SMTP id
 46e09a7af769-71dcf55937emr5427991a34.26.1733698147214; 
 Sun, 08 Dec 2024 14:49:07 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71dc497ee8fsm1925198a34.39.2024.12.08.14.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 14:49:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: bcain@oss.qualcomm.com, peter.maydell@linaro.org,
 mark.cave-ayland@ilande.co.uk
Subject: [PATCH 17/17] target/hexagon: Simplify internal_mpyhh setup
Date: Sun,  8 Dec 2024 16:48:44 -0600
Message-ID: <20241208224844.570491-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241208224844.570491-1-richard.henderson@linaro.org>
References: <20241208224844.570491-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Initialize x with accumulated via direct assignment,
rather than multiplying by 1.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hexagon/fma_emu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hexagon/fma_emu.c b/target/hexagon/fma_emu.c
index 6749538c09..bc6e742639 100644
--- a/target/hexagon/fma_emu.c
+++ b/target/hexagon/fma_emu.c
@@ -453,7 +453,7 @@ float64 internal_mpyhh(float64 a, float64 b,
         float64_is_infinity(b)) {
         return float64_mul(a, b, fp_status);
     }
-    x.mant = int128_mul_6464(accumulated, 1);
+    x.mant = int128_make64(accumulated);
     x.sticky = sticky;
     prod = fGETUWORD(1, float64_getmant(a)) * fGETUWORD(1, float64_getmant(b));
     x.mant = int128_add(x.mant, int128_mul_6464(prod, 0x100000000ULL));
-- 
2.43.0



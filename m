Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA39BC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 13:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tclzX-0002p7-Cx; Tue, 28 Jan 2025 08:51:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tclzS-0002eU-4O
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 08:50:57 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tclzO-0005p5-IE
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 08:50:53 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso38166755e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 05:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738072248; x=1738677048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=52mhp+vtFIClG/JV9VKGPgaQ+SxucWci0KhLtwQ6JRY=;
 b=c+yePwLZCzXKq47sRt4fibuKJ2qwIixD9Arnwp6ZEA8aefJWjwN44l5p7P+H26YoRM
 P2lSdZEYZDRVW7i0D3SJKCHgHJEhZ1HeIrmCqBGrOJBAfvANXmJvqNl3DqZXzEjEfnOV
 VZNzfTZSFZ5fNA1MceIUR+yXcmLKYI6Rd/Q/QbGKFaCaaoqKRrL+RwY+744klMNXC5ZI
 3saSl8ctqAdjHnt1kBAwG7i36xZ5kiuVGkBDYIPsTO6JTC7oAzye7KDcNttizA4Yz5tU
 C4xcJpgf5Nz+R29bexQcYKzEN9qDt6mjTcqLQcc3fLCpJ+upi9AVNLc8oo+OoRWQ5YmL
 7CmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738072248; x=1738677048;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=52mhp+vtFIClG/JV9VKGPgaQ+SxucWci0KhLtwQ6JRY=;
 b=Jbe6Txt0ILWoyD8m5X6tXglsCCvZTRlIc+S3GqqinOOOVH4CNhTQXs1jFayYEt3lw+
 JznDbRIhmgYEvgTMq4PYcgYGBzqKyWikEexv7P5QT+km5w2Qy1F2Pk9JZ4x7nsN2e2I5
 MkeewXu+aX07sb9h5pCTFqPA75Bxn795o3US1PK7v2eD+fuZqckudOTAAj/vlXAHNJsM
 t+JTzxwPsoIxI6IZzEoiugX38IZm5JfAPdiPpgkyp/Qd7zLkZOL0ziM4jAuOg4iKg1v5
 Q2+C/oG1H4CDry3qH84SrrVdUvLY4xuNWmdC+QQ59oKFRATQ5OetSUV++38f+lKwyrWU
 uZcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIpwP2Z7/kOBcMDibhn8Lsg96jdS8K+I7D7L/FuqhftXgjsk/1j7xI653AlAwTHijA4/iZkv1de0xf@nongnu.org
X-Gm-Message-State: AOJu0Yy19juLaT+wwxUkFcxmrJc8uzJfQpFV0MyIXzE917YFm4ZRk1hF
 N8Jot+pLNu9OMI2Np6lsZGNhitgH6eHWpKFL7hicBlSSOvgbLR3+JWRtxp79jNM=
X-Gm-Gg: ASbGncsASb1RgwMnCR2dpDVLF1IwAwLV0KF0o5mrWgnK/b5wAhxOxKPwJCcQ1rtsTgY
 pOIPsVqIytFMAVeelT9GNUA72yVI68b+s8qcNVOx/Um3LDwEDsISP943+HsT0BHaMVKm9e+DnRI
 fgHCJ+0za9ladoL1fC4a+u5vKYhK4TgEj9VzbBQmeIxBNWsBSTROj57d81ldnjSXS+GOJPK+ZGC
 EGVb1sC4XvkxVd+c4+j/FoAzXVpAxftofSoTMsvnu+Hz3fAc/saT0mtSFhF98g8omws55nxGekF
 nVgrD+izuF2yL6xcHlw1zg==
X-Google-Smtp-Source: AGHT+IEh7NajhsGVT+p5BZnUFwExbYLAQgtpWBOplA7yJvZkqNPuMLywkb7IBRzYZaRsYOZTU1h94w==
X-Received: by 2002:a05:600c:1da8:b0:438:da66:fdf9 with SMTP id
 5b1f17b1804b1-438da66fffbmr12841735e9.18.1738072248280; 
 Tue, 28 Jan 2025 05:50:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd48a906sm174368445e9.18.2025.01.28.05.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 05:50:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Drop unused AARCh64DecodeTable typedefs
Date: Tue, 28 Jan 2025 13:50:46 +0000
Message-Id: <20250128135046.4108775-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We removed the old table-based decoder in favour of decodetree, but
we left a couple of typedefs that are now unused; delete them.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index bd814849c19..155169aeafd 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -75,17 +75,6 @@ static int scale_by_log2_tag_granule(DisasContext *s, int x)
 #include "decode-sme-fa64.c.inc"
 #include "decode-a64.c.inc"
 
-/* Table based decoder typedefs - used when the relevant bits for decode
- * are too awkwardly scattered across the instruction (eg SIMD).
- */
-typedef void AArch64DecodeFn(DisasContext *s, uint32_t insn);
-
-typedef struct AArch64DecodeTable {
-    uint32_t pattern;
-    uint32_t mask;
-    AArch64DecodeFn *disas_fn;
-} AArch64DecodeTable;
-
 /* initialize TCG globals.  */
 void a64_translate_init(void)
 {
-- 
2.34.1



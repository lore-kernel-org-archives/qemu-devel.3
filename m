Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AAFC3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYjLP-0003sk-1S; Tue, 30 Jul 2024 05:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLN-0003mL-Er
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:33 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLL-0000cT-IH
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:32 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-368526b1333so1544766f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 02:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722332430; x=1722937230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bV8H5RVK0b+LxsupxZcm8cD3g3amlRE8yjf1z8/+Mwk=;
 b=DDOLs4fdM2IeNlbh6TtmsLdxaGCc84bXoFcunIZCXH8GLagfROfSmSAQHlgHcLObEQ
 cMcEv+UwP3oAkAynKdgIQ4DhKOc0gSeSEZfAeZj73PpREaViNfFnKwug/qYb4LX/Pbpd
 zAEKDuFV2ZQPXFevJBuD6fdspbyJ/c1YxhZbZ9pHzRevEzwC8eKrEpBdvkAg6OTaQg2Q
 OPPNGYsfVY5HR3ZK/qPXMGjgptac5aJggGbBu/0S7gQVXxZJlbaWzSez6p0INIb2IJy9
 fwgQZVURLAqi6Fp4DzK4luU/aN0bmSidzPOYZGUrWy6Epknkvi67raNk+mG8GQZBngQh
 2zig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722332430; x=1722937230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bV8H5RVK0b+LxsupxZcm8cD3g3amlRE8yjf1z8/+Mwk=;
 b=gdIi5ryp26NT5IA9ZvAfpbQwIumZ9gN5yAdRAE7YlamjeCZAq5KHfKhtDRyobm26Ch
 GHa/pj5f1gi5d1rU7jtjprfoHEUZZOTvfKi5NlA5Mywin6toTWLsdXVI1CrK36TWdHhr
 aIrhHUQpdFjHh6txWpnCsVgkrgTqWXDf5Fmq5HaugcOLpOwLcu2C7BCrUrCtz8r4Q7Vc
 qTIlTMFB2qS52IO9ZTFtEvKXWQwNu/+tjNJhgCTCnBUy4x3++BDYvGR5DQJndl/GEF3f
 geLm9lIiojwfTer+XDVFqcEIAK11xekRrZTWAjS4IhHZVzTMOvt97Ca07lk71n3vy5mB
 /KcQ==
X-Gm-Message-State: AOJu0Yxl+Sd1sas6t7/72XicMpxlN9f1qwRsdb0B/ifC0wPHh4SdfEIg
 Kq8hbVQd4X6ERLCbMfeMVA564whglgorARpLrpSSZLq545WAxn2JeVKnQ6b7F1dCXjGiK+h68ms
 s
X-Google-Smtp-Source: AGHT+IGmviJ5DQ+0j9n9zkrKIPgQHyJEZagTewrufB3D7XbyWcVyurnxNTE6679OyWb275vqFpi7Wg==
X-Received: by 2002:adf:f549:0:b0:367:8fd9:db6b with SMTP id
 ffacd0b85a97d-36b8c8df31fmr1081238f8f.9.1722332430071; 
 Tue, 30 Jul 2024 02:40:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36862549sm14194974f8f.106.2024.07.30.02.40.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 02:40:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/21] target/arm: Avoid shifts by -1 in tszimm_shr() and
 tszimm_shl()
Date: Tue, 30 Jul 2024 10:40:13 +0100
Message-Id: <20240730094020.2758637-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730094020.2758637-1-peter.maydell@linaro.org>
References: <20240730094020.2758637-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

The function tszimm_esz() returns a shift amount, or possibly -1 in
certain cases that correspond to unallocated encodings in the
instruction set.  We catch these later in the trans_ functions
(generally with an "a-esz < 0" check), but before we do the
decodetree-generated code will also call tszimm_shr() or tszimm_sl(),
which will use the tszimm_esz() return value as a shift count without
checking that it is not negative, which is undefined behaviour.

Avoid the UB by checking the return value in tszimm_shr() and
tszimm_shl().

Cc: qemu-stable@nongnu.org
Resolves: Coverity CID 1547617, 1547694
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240722172957.1041231-4-peter.maydell@linaro.org
---
 target/arm/tcg/translate-sve.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 798ab2bfb13..a72c2620960 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -50,13 +50,27 @@ static int tszimm_esz(DisasContext *s, int x)
 
 static int tszimm_shr(DisasContext *s, int x)
 {
-    return (16 << tszimm_esz(s, x)) - x;
+    /*
+     * We won't use the tszimm_shr() value if tszimm_esz() returns -1 (the
+     * trans function will check for esz < 0), so we can return any
+     * value we like from here in that case as long as we avoid UB.
+     */
+    int esz = tszimm_esz(s, x);
+    if (esz < 0) {
+        return esz;
+    }
+    return (16 << esz) - x;
 }
 
 /* See e.g. LSL (immediate, predicated).  */
 static int tszimm_shl(DisasContext *s, int x)
 {
-    return x - (8 << tszimm_esz(s, x));
+    /* As with tszimm_shr(), value will be unused if esz < 0 */
+    int esz = tszimm_esz(s, x);
+    if (esz < 0) {
+        return esz;
+    }
+    return x - (8 << esz);
 }
 
 /* The SH bit is in bit 8.  Extract the low 8 and shift.  */
-- 
2.34.1



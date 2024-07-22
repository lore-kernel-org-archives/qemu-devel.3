Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DFE7C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 17:32:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVwrZ-0000Fk-4S; Mon, 22 Jul 2024 13:30:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sVwrX-00006e-0i
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 13:30:15 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sVwrP-0006O1-RH
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 13:30:13 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-427d2cc1c4eso32447365e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 10:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721669401; x=1722274201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sbbsiddWGomdgmf8A4MCaSQ4lYafoX1GSRn6PujArso=;
 b=vZSceE9/t1u2xvvepcrN1jjLZBO/pHm59pnHfxW4rLa2AlQlL0PdboXwD46nYylDYZ
 jNNhCXzErrTc0Ax1EogVvJA6wooY5ic/rF/+h3nG9V2FCL2YabQM3Z2TSG/98OyV6y9E
 oXmz9tA61NQ8QH4ylP5TNTGhj6t8wOY1Xdx96ebQkJpWEv+YJqqGK6hTVpfBz+bm2iaX
 Vv40FHJvihCM3fpcSX3LqliFmDl9Qa8aYA09TSUvn4bKoCH5XIwNfRwKW/7T1Oxc4fsw
 BDnqn9jcvetYUUyzZknbjSZOXHcV4GXJymyqcgk3Yw1YjSF0hUR6W9+CC1WxqvbZ5X79
 Y6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721669401; x=1722274201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sbbsiddWGomdgmf8A4MCaSQ4lYafoX1GSRn6PujArso=;
 b=cirzhwouGkVTBwIymPj48TEObHJGzTUzffggCiUj3GIR3T297MqE+O8fcOXHqR6xmT
 rKKrl2Y+v4SRWJIVk60MY6jJ4OIrNiJWutfcN667Mi8ZcDescUT4tBSK8B+BnUxVoDM0
 0dk1Y8nyBGHrhszERBtZUanjrsZbuyfjp4y8oqWH9YnEyJIXM4Y8x5cmp3zmrvKruSNb
 wtvlyAYqvQkxwyLg7vs6dQdx6ilGUMyT2mgIg4PrRJWK8PsHdtVD/wBAoZ2OAVG0xCcR
 nzUetEthJqncxb8DXKyHbEgIbg1A39+8nd92K0tse2BamoD5pK93gJhVmAWVJwmqdttE
 muLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvm8KyLe3cTwJaLSpLS8U231PIDKVoIKSl6jRpPs5bleJX4QfRJG1ehbpYl7I2eKrYOk6o7Ikru4bvy/uZPsYCqgfOXAY=
X-Gm-Message-State: AOJu0YwvRYqzJCC38cPRAkL97eNAvy/Zlf/gUouiYnKmaMUF7JqWobvp
 C3X2EBUNxbLoqyEzBSAW6Q8TWdYYRItkD9TwxP1SGYR3bw/6aSjRtyF47cb5vYI=
X-Google-Smtp-Source: AGHT+IFScLrj7a7xZGF9KbmL/b6Qap7uNZ9kv86wDB+xJY0wejgmKMu11lO4DfPa6botSdOCL4/Lww==
X-Received: by 2002:a05:600c:4f4f:b0:427:d8fd:458a with SMTP id
 5b1f17b1804b1-427ed001c92mr4015635e9.19.1721669400910; 
 Mon, 22 Jul 2024 10:30:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d68fa493sm138035665e9.10.2024.07.22.10.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 10:30:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PATCH 3/4] target/arm: Avoid shifts by -1 in tszimm_shr() and
 tszimm_shl()
Date: Mon, 22 Jul 2024 18:29:56 +0100
Message-Id: <20240722172957.1041231-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240722172957.1041231-1-peter.maydell@linaro.org>
References: <20240722172957.1041231-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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



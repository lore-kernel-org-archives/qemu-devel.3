Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E88E77194
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPbZ-00073v-2x; Thu, 02 Jan 2025 13:07:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbE-0006yP-Vp
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:19 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPbB-00058V-3m
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:07:11 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2166651f752so183410705ad.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841227; x=1736446027; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Jcsw74ROmrA9JgNDfgtKTSV+FBCBbdIl9oAhaUb/ofk=;
 b=g8HqXlgHGb6/Ym9uDdfdbDYl6XIo2NaaYlAEalE742BfKQ43Y0rqqxv1YqfB1UCeJZ
 FQPW18oRY/hGqe3O1yStRXb8KQ0OH4oIDRULRqex0UTBgnp8WuCwc/OZWNxRdzXDe48j
 TbRlg4VjA8kdPY6qxUqwsqWiEs7BP3FMYV+4qor8nSMKXhusmCbJP5+8NQw3d6MKwaFT
 0TFPTswMp/NvQ6zi4UgUUry2sYJFs48kaYDqR9KIt98Dw0lk7c65Qwkn/V6sf3OZ0/QL
 1lyJc1SakHPl4F3MXN4uIka3lkGZbLl0vsDPJvaVNH175+mlpQ1w7vxAjUpe9TXzRsuV
 idCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841227; x=1736446027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jcsw74ROmrA9JgNDfgtKTSV+FBCBbdIl9oAhaUb/ofk=;
 b=MxZg/fx513SzFARJriqv9NgyBC8ddSCIehmWgea22U0Tgfkv/wOadgsXM5cEzn9P99
 GW2c4LzalW6l1HaUIkdPXYSAlCaHwPrNQWeAogDwTW7cwyMLx/MxkxJP+vpyz+XSkCU/
 kOcc3CiX1kF6Tfz9btZSD6hb9zpx3/4+QkoCcUP3bsZaigxaZeWCBjXldcIlf8E4FqJx
 MwXO8p+dbekVyJ/KJk2m/Kys2jtPa5jqvaNh2cOYqkuUfjer+mzwif/TTLCFCCRxna3W
 1cU+VcAjtPBV7Eq+JjhEJZ6dDiVIQDgv38EEEzFUGUvios4Yv+5OQEMAphyXVzaXNH2A
 /0Hw==
X-Gm-Message-State: AOJu0YyZPwSFHMl41nsH3c1UXUyMt6IiRgcF1SfD+NmE+ixZ71HnLZ5N
 qSk/onFsyygn9XKzEMN5ScnBvOAnWtCSAO6eEn1xeNuec8IVHolq0q4EQqJBSQPxaveEzqAsLdJ
 O
X-Gm-Gg: ASbGncuJSOR4uAF0EFhsfaYlmgzltuYQZRKhDRtg4B/ltfo5EIotPxpv49f11yVHv/f
 H6r7LTdbuIQmvt5xWUqnDjGdjIBQ+0FLpAJaA4OU7l2DBFyhVMC2fKD/+gBss42x9RsAgfb0iRg
 aB0SjRybxCcsZuhhy6z40ddfB6azV7HUkMG486P16I1yqdSK7GlyIPOvKnehqkjmHuG9F73JEde
 szjbN9GJccV0DIvvZEaVlzRODM5r4OW61IGmJzgNvaY/TCoxrAMahPZ7HW35Q==
X-Google-Smtp-Source: AGHT+IEIWLpQiO9oSEApXJbDEwbI3wIWwXdgRoJJ+ozmlj0WSU9VLpc6B97C4vxGv0B9vlYdt8uBug==
X-Received: by 2002:a05:6a21:7899:b0:1e1:bf3d:a18a with SMTP id
 adf61e73a8af0-1e5e0801d78mr80630582637.32.1735841226787; 
 Thu, 02 Jan 2025 10:07:06 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm20604456b3a.154.2025.01.02.10.07.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:07:06 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/73] target/i386: Use tcg_op_supported
Date: Thu,  2 Jan 2025 10:05:54 -0800
Message-ID: <20250102180654.1420056-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Do not reference TCG_TARGET_HAS_* directly.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/emit.c.inc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index a2b940a5c3..00f7a6123a 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -24,9 +24,9 @@
  * The exact opcode to check depends on 32- vs. 64-bit.
  */
 #ifdef TARGET_X86_64
-#define TCG_TARGET_HAS_extract2_tl      TCG_TARGET_HAS_extract2_i64
+#define INDEX_op_extract2_tl            INDEX_op_extract2_i64
 #else
-#define TCG_TARGET_HAS_extract2_tl      TCG_TARGET_HAS_extract2_i32
+#define INDEX_op_extract2_tl            INDEX_op_extract2_i32
 #endif
 
 #define MMX_OFFSET(reg)                        \
@@ -2993,7 +2993,7 @@ static void gen_PMOVMSKB(DisasContext *s, X86DecodedInsn *decode)
     tcg_gen_ld8u_tl(s->T0, tcg_env, offsetof(CPUX86State, xmm_t0.ZMM_B(vec_len - 1)));
     while (vec_len > 8) {
         vec_len -= 8;
-        if (TCG_TARGET_HAS_extract2_tl) {
+        if (tcg_op_supported(INDEX_op_extract2_tl, TCG_TYPE_TL)) {
             /*
              * Load the next byte of the result into the high byte of T.
              * TCG does a similar expansion of deposit to shl+extract2; by
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1594FCD343F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 05:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOqYO-0006zr-3D; Mon, 18 May 2026 01:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqXv-0006t4-DW
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:29:45 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wOqXl-0003Sz-1q
 for qemu-devel@nongnu.org; Mon, 18 May 2026 01:29:36 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-479d9b155deso467461b6e.3
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 22:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779082168; x=1779686968; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RGGA0O2hVedaSvcxfeu4Aj34rW6xAzUt7vUilCpMyqI=;
 b=jA5tvjivgfWwzAKbtjUzovVzIH8VYOAzBgcTgQVn7vLDYLiS2TpVlu0A5JLUoiLHyT
 k//sxMb77ctLyWO/5/AjIkdELgEbYFzhqK1wVxz2iPRy0/i5K6MtlBgViIViONGlYFDg
 donsNu9eadVIfbE6JWQGZF2sgTI7Coy/olRiJzrzrfVVNKuW2HscaPTCGNUQgMdssmpC
 4TbYl31KnwlSRS8U/3ctWZo6EElcCbBVytZVj3ImfrNT277PsP1tE3pAsiRh2qomX8HR
 n5Z9pvmrm2rjIT9zB6Klk3DFDoh6xvlNTcxo+Nn0CRRwZzEPBWWS6c19Gn4JnEmJ9rHp
 ko0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779082168; x=1779686968;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RGGA0O2hVedaSvcxfeu4Aj34rW6xAzUt7vUilCpMyqI=;
 b=Qi3O2MiSh295mlPxcFbrYI+MidRegezPsdIe/UgIPXRGmaeH6wuKUFukvp7vtTVskI
 Ke32DB8A46Ot00TrZq7CoPRAk84ySCiSTB+ye5kCTcBVuvaircfYYMPYFefxeZ5PFYWV
 xXWtA0sfPztEd9rtFMeZObGOPa3r4pPpx9oAkHQJY73+eyfHixc3gLcJx1sGteLhZkME
 ZH/3PtcGW8/EkJ2p0eA6P1irMq+xVNkcFneUfw6XGRvch2kn71RBeq8eDsbYht9+p+iv
 TIkac4oMdwkkxS/5gMcsrOdSn+nMgo6FGStTseTrDJxbi47ESYIirtrwkDRxbMN27CUi
 1EsQ==
X-Gm-Message-State: AOJu0YyQaCXfVv1VnBW7zmnb7vwSPfgbswC434aXfHNoqcpddJQ2QQoE
 GvrTf1dLC5ow8BLf2TRRE26m7p0aFT/NzH5TfbNl3Mqfff+lsJiXtpQL
X-Gm-Gg: Acq92OF83gMpSic1SX0py40ORXo2nHcC3RmWktzu3DQFv8d1LcOs/SbRA5dm+Pzwv8y
 iIOpP2r7xlmpeI1g3vojwWKVJzRLqE0fLHWri3SQN4DoFSTd0JFNg8Lvl5maF8phQ8tepyZkh78
 T9o8SQgckf2708QBHviKiT4ifCEtd7zOmeD+ovV62ih6BTMkAJU3p89AK5LqvvUO3MKizomB7QS
 rCBQ9REVc1nUwjexhTlpK/Rkquj6tZ2/R25WpDrs1oKNM0Ntz5bd6/fYuFpho25Pd7X61wmZjag
 6gh8y/arLVigj60Kxz9RDSdIhUEbsJwOyqszOZ9ZTUJXtcUPRxgH/JOZ47dzaWi5BFFx0cSXPM6
 MLwNNGxXweQLjI4akEuOIUw0x55VO8Z2djIZ00JVIQnaW9x9drtYKfmLjd/QM0+cwfkfbHm3hQ9
 JnhMCcnSkNZQI4tvg1TtC2JiafSuNp9kqvxv9aeIOfda5AiTzdzAYDt3oMeAdORS02AHu3K63Rm
 bZsQJo4RxDOCX/vEBo4pnR+pDz3/ffE6uBMqmFs4o2v+OGj0W1m3QuM3Zqhp+XEiwIsQUn3JnNJ
 gvz9Gg==
X-Received: by 2002:a05:6808:22a8:b0:479:e7c7:dc71 with SMTP id
 5614622812f47-482e57987e7mr9083389b6e.38.1779082168543; 
 Sun, 17 May 2026 22:29:28 -0700 (PDT)
Received: from mac.localdomain (71-218-255-245.hlrn.qwest.net.
 [71.218.255.245]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-482ee5349a5sm4628357b6e.15.2026.05.17.22.29.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 22:29:28 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 17 May 2026 23:29:04 -0600
Subject: [PATCH v8 07/35] target/mips: add Octeon LBX instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260517-mips-octeon-missing-insns-v2-v8-7-206151ee77ec@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x232.google.com
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

LBX performs an indexed signed byte load from base + index and writes the
sign-extended result to rd.

Wire the existing indexed-load helper to MO_SB so Octeon user-mode
binaries can use the signed byte variant alongside the existing LBUX
path.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split LBX out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index a2bfd0751d..efb1a48b38 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -49,4 +49,5 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 LWX          011111 ..... ..... ..... 00000 001010 @lx
 LHX          011111 ..... ..... ..... 00100 001010 @lx
 LBUX         011111 ..... ..... ..... 00110 001010 @lx
+LBX          011111 ..... ..... ..... 10110 001010 @lx
 LDX          011111 ..... ..... ..... 01000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 5497ddfb10..451737cda1 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -161,6 +161,7 @@ static bool trans_lx(DisasContext *ctx, arg_lx *a, MemOp mop)
     return true;
 }
 
+TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);
 TRANS(LWX,  trans_lx, MO_SL);

-- 
2.54.0



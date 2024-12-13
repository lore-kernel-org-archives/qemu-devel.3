Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0AF2E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:40:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9a3-0008Ef-VL; Fri, 13 Dec 2024 12:36:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xn-0007rv-DO
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:39 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xi-0001gZ-PN
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:39 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso14803935e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111213; x=1734716013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3mdlWNNeHXJsgcTtnZPbD4pcaM8JSPdYHOgC0phOQbk=;
 b=IptiSBPR0ymzk02ypTlb8p5MNI3QAaDq5dIm8DAwCK8xCiJwVz1rfnthn428Yocpsk
 gG6M3e94KRS+P3ZsiYtSuMzL1dme+dEpm6NKJhpoZ+EPZkOBawP/+zG1mcTI0Oh4Y95H
 Hh0qlPuZNbEb0BvUBYZDhE6QmvqcTKKTu1zlsUUAZAju0Ib5CDeJX2jX8DR8Hm14GKvj
 LC702eiQghcD0Yt55T4dpLzBcJ7Z6msofpo8dVFMFC/ZEmi9PcK7Po3Pt26xtC8zgpSi
 sTbn/ibK7sotHDXAf/fRZpjjII8RooH+XpDW0BpCfu0p8MGKr08mKe7hV1czrDIeEmr7
 giqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111213; x=1734716013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3mdlWNNeHXJsgcTtnZPbD4pcaM8JSPdYHOgC0phOQbk=;
 b=rmB1fjjeJ001uP5/7WKYP6EEAXHTWjOIR6WExTWbyf44FwGjovRRb+Vl+2S9t4Ncol
 9JdO9X94Wh9afbibLWKO3w+2Tssr3T/QiJtOVsL+2Zvoi/twuW6PXNdDgcl//THD/vuI
 JrNoAOEyKD3Cgo90OG4tZ/IFZbQYkMV3UmHK9pUBVRQVCkzw6NBq4gTQY0q+7+Qa8WrY
 aTzV8BUtgNcx9V2o6c5bH/dgGm9cFullpcYDTMNyzA9zHgk4gK1awWs0//xlspTQOVL3
 VBwNrs65daLOnqKD+7ihS3FT2DotyrzecHo6uKOWZg3efWqHiU9Hoceh8rUPjhSVgSE2
 0q2w==
X-Gm-Message-State: AOJu0Yxf7yuhkhL8ZuC8w+jSpMQVKneaiAxBS0g4eq0QH9kMiY5iEi3v
 meVLEIMVChtZjduFylTKYkVvt03KnZ6JgkSaoYyE2hVeFmSRjYbseCrVVDCgfGmC1TQdGN51g0r
 K
X-Gm-Gg: ASbGnct4BbtRl9u50BKkoFVZAFU0saHWy/GAaRnO2Rr5OdylM6Abayd5FH9ilTS/qXf
 kRD5oj+v1Km58KbCQ2yD5NxVph5bO9iZyDglqdPmOqAhOGQ1eS/Y8YSlkQgZktQj1L6qojAJMgM
 1rvefr944PUIbcQW+ggvEXSQPZmW/eShzJZP0OnDTUiA6yQLZU6vk5DYIIbjMG9QeaFB/1JruPu
 PGbMxlLdhjXRvrhcIdu7lINMfJIrxWJJI8rYWXojcLnCGabkaVOeMPqmVF1aA==
X-Google-Smtp-Source: AGHT+IERCLbt/oc38MTvjjqh1dQIbKhyE/Vo4RjC2FabV0wwklR+2OOyGIzDrPNuHG2wK+5Wu2x+yQ==
X-Received: by 2002:a05:600c:1c1c:b0:434:f917:2b11 with SMTP id
 5b1f17b1804b1-4362aaaa01dmr30117275e9.21.1734111213197; 
 Fri, 13 Dec 2024 09:33:33 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:32 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 58/85] target/arm: Convert FCVT* (vector,
 fixed-point) scalar to decodetree
Date: Fri, 13 Dec 2024 17:32:02 +0000
Message-Id: <20241213173229.3308926-59-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-59-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      | 19 +++++++++++++++++++
 target/arm/tcg/translate-a64.c |  4 +---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index f7fcc32adc5..f66f62da4f0 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1682,6 +1682,25 @@ FCVTAS_f        0101 1110 0.1 00001 11001 0 ..... .....     @icvt_sd
 FCVTAU_f        0111 1110 011 11001 11001 0 ..... .....     @icvt_h
 FCVTAU_f        0111 1110 0.1 00001 11001 0 ..... .....     @icvt_sd
 
+%fcvt_f_sh_h    16:4 !function=rsub_16
+%fcvt_f_sh_s    16:5 !function=rsub_32
+%fcvt_f_sh_d    16:6 !function=rsub_64
+
+@fcvt_fixed_h   .... .... . 001 .... ...... rn:5 rd:5       \
+                &fcvt sf=0 esz=1 shift=%fcvt_f_sh_h
+@fcvt_fixed_s   .... .... . 01 ..... ...... rn:5 rd:5       \
+                &fcvt sf=0 esz=2 shift=%fcvt_f_sh_s
+@fcvt_fixed_d   .... .... . 1 ...... ...... rn:5 rd:5       \
+                &fcvt sf=0 esz=3 shift=%fcvt_f_sh_d
+
+FCVTZS_f        0101 1111 0 ....... 111111 ..... .....      @fcvt_fixed_h
+FCVTZS_f        0101 1111 0 ....... 111111 ..... .....      @fcvt_fixed_s
+FCVTZS_f        0101 1111 0 ....... 111111 ..... .....      @fcvt_fixed_d
+
+FCVTZU_f        0111 1111 0 ....... 111111 ..... .....      @fcvt_fixed_h
+FCVTZU_f        0111 1111 0 ....... 111111 ..... .....      @fcvt_fixed_s
+FCVTZU_f        0111 1111 0 ....... 111111 ..... .....      @fcvt_fixed_d
+
 # Advanced SIMD two-register miscellaneous
 
 SQABS_v         0.00 1110 ..1 00000 01111 0 ..... .....     @qrr_e
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 71f1d6f7786..894befef4dc 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9535,9 +9535,6 @@ static void disas_simd_scalar_shift_imm(DisasContext *s, uint32_t insn)
         handle_simd_shift_intfp_conv(s, true, false, is_u, immh, immb,
                                      opcode, rn, rd);
         break;
-    case 0x1f: /* FCVTZS, FCVTZU */
-        handle_simd_shift_fpint_conv(s, true, false, is_u, immh, immb, rn, rd);
-        break;
     default:
     case 0x00: /* SSHR / USHR */
     case 0x02: /* SSRA / USRA */
@@ -9551,6 +9548,7 @@ static void disas_simd_scalar_shift_imm(DisasContext *s, uint32_t insn)
     case 0x11: /* SQRSHRUN */
     case 0x12: /* SQSHRN, UQSHRN */
     case 0x13: /* SQRSHRN, UQRSHRN */
+    case 0x1f: /* FCVTZS, FCVTZU */
         unallocated_encoding(s);
         break;
     }
-- 
2.34.1



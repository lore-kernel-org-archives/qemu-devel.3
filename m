Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A707D49775
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlbC-000330-I7; Sun, 01 Dec 2024 10:11:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlaS-00086a-FQ
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:10:18 -0500
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlaQ-0005FZ-4W
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:10:15 -0500
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5f22ea6d72aso698736eaf.1
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065812; x=1733670612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KNqtqTuKoxYAuNJH11iEZWZMebxY/Sc4ANTRRmTFsYE=;
 b=EdaZMdWedawncj8CCKSuBxxzpqJ+gCUkLh2D1GhEQY8CYTTQyIRgnnawNwaztRZYhQ
 J02AcsWyALJQWphHGsAaH26Vvakc6p7hZW2p8h9lgltXgk/yIpvIfRHTdbovRqpgHjck
 8C6qDS2eVHES2/pI/AmT5YWZect7anicbmbkn78dxkA9F0ih/jgN67p99Ln27gewRfa6
 YJkqZXXqIdehVEdpTshqcE8ffs3Uul4TdGvC7oOXOyLLIi48ViMgldgM6gwc7WKDDCWW
 s6FjQOvqtgq0DWGW1UNbfGrq0OrEZUMpTPrbvNMl8NurzFoTnWhFFPtfSvpycJ8WcO5t
 rpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065812; x=1733670612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KNqtqTuKoxYAuNJH11iEZWZMebxY/Sc4ANTRRmTFsYE=;
 b=n7Jq0vyRTS9GDDP6qXT3v9DYJ7M7p75cW6Kyw0EhwCK0DW95w+ZMPLB8ZvOFrEMhOA
 NK0qIl+sRz/YDmX+2vbdoMeSHs1ZPN02Ic6UlFItwiQP0lR4hU5JCZ7i07EwBd13VDZ1
 ++JnR2ixzJEHwbUBVYlR8496Z2rsCnly+zg13STK2KGbTrrs5Dy2UPHahgXXbtdiO4Qk
 aloBmu95viBdFmjT/D6ZQBtr0LzqVUfUn+ElsDGtiVsHsSJV01qPggtfnR7/bzgdpMK6
 bnPAti6bhlG1cGXYnRZYHn2LyYHKrUS7ctRPCMA/lbLb0WWOv8k2hRE3zC/O70Y73+av
 bLnQ==
X-Gm-Message-State: AOJu0Yzj/e/cIKU4yJqFc3whet0OUKmwH/MijEKzFgxe9vTmecyFq9F3
 jh1aapAE+Cc11iU0h50xLYvXc4nMeyrWohLT5/rGHIRAMGzJpdBoWkVf/98/iel12StGuE5i+qD
 PZrk=
X-Gm-Gg: ASbGncshxuvXspmqDO8bAul6w0Dp+fT+ujzjXdJJx3M3PysHPhCxjaixPUPO9G4N7XB
 xzeXEWVHoZJru3bnj0PgaH6Ywpgv2XxJ3F/LDxVTJq8zTiZuwqlkv7kc/h19k1MY5SLM5suvrWV
 ILosVdrI0mr1mrauOkhYLsgWzYt1yfsjt9CbjYCueO7ADmGPTf+3Df7jxb6YiwMMBnjsbaRMr3c
 JXZFraRzXwRIVPnvLyj9mn3goHiswwWH4I8bMhmFQigfOHwrAnjfNiHBJ2MF3hdvwBDKF/2g3qV
 BRhKWCZdblreOmsj1OG0gnLruCF0tuj0SN4M
X-Google-Smtp-Source: AGHT+IGck9XOERoXCPL+fVxFg/Mc7hpSpwjo8+qzIH3fJcq2b0VXjpopUtu76QZrBjrR4C5l/ZE1AQ==
X-Received: by 2002:a05:6820:2183:b0:5ee:dc92:ffb4 with SMTP id
 006d021491bc7-5f20a1baf19mr12961931eaf.5.1733065812734; 
 Sun, 01 Dec 2024 07:10:12 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f21a4cd78fsm1807008eaf.32.2024.12.01.07.10.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:10:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 56/67] target/arm: Convert FCVT* (vector,
 fixed-point) scalar to decodetree
Date: Sun,  1 Dec 2024 09:05:55 -0600
Message-ID: <20241201150607.12812-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc35.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c |  4 +---
 target/arm/tcg/a64.decode      | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index ad245f2c26..bdeb0288fd 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9547,9 +9547,6 @@ static void disas_simd_scalar_shift_imm(DisasContext *s, uint32_t insn)
         handle_simd_shift_intfp_conv(s, true, false, is_u, immh, immb,
                                      opcode, rn, rd);
         break;
-    case 0x1f: /* FCVTZS, FCVTZU */
-        handle_simd_shift_fpint_conv(s, true, false, is_u, immh, immb, rn, rd);
-        break;
     default:
     case 0x00: /* SSHR / USHR */
     case 0x02: /* SSRA / USRA */
@@ -9563,6 +9560,7 @@ static void disas_simd_scalar_shift_imm(DisasContext *s, uint32_t insn)
     case 0x11: /* SQRSHRUN */
     case 0x12: /* SQSHRN, UQSHRN */
     case 0x13: /* SQRSHRN, UQRSHRN */
+    case 0x1f: /* FCVTZS, FCVTZU */
         unallocated_encoding(s);
         break;
     }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 617bbc6380..4cb5b20826 100644
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
-- 
2.43.0



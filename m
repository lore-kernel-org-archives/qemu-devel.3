Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC1FCD5BAB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 17:27:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPkeo-00052W-P9; Wed, 20 May 2026 13:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkem-0004uH-OK
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:24:32 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPkel-0003hV-4G
 for qemu-devel@nongnu.org; Wed, 20 May 2026 13:24:32 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so40407305e9.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 10:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779297870; x=1779902670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QR8rmkB59QouyU42X5BEd3gCdl+c+memYAH/UwzBTo4=;
 b=FUwJMZlXaq31CHmK4ehMVMJLDWrI4D7EIgVpVwN8XA531hKWtiT2wgdBKX0XUiY+LQ
 547o3usAFwqlOTNCpg/38BTzeXziHr60P+fBCQ42E8yJqTGfuWa6LuaIsW0DS/G9NeAb
 0oxLuTpgb1vvCG4wQfOnh/flIXWmTNkhuJjflwvIsCBKNLD3g3ALu6uG2MvjSEFCyYWk
 71Mt1GZh0wHNvPppPoLdsjnCm3JB/DKy55R4sWX+ph0nnM8BYxoOUwKMtwQ7J5A4nLIV
 XFMLeBf5c7mT0PE24VgV4kYzNRdmRVy8SeXaoenE3t9KWdZd1I9s1O60RtXPjpYxgSeD
 AIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779297870; x=1779902670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QR8rmkB59QouyU42X5BEd3gCdl+c+memYAH/UwzBTo4=;
 b=TMAFSS5rVnvcuoh56hi8jPX+kq/oaHOZIPRWm4tKPtQpZ0v86nbQ/orDsJ1duCCfex
 XV+ZYjmQO+TxeEAFuWZdXcYhcEotdVBxpB+dDhuZlyheJoWN6kqpoS45S7V7PFPHHEyc
 Rba5C+Wcv1tDODn4eO2kQzd6tGR7LYlBJcxeZli99sgyN/jaqanTulOKC0KkG9wp+fPF
 R0EOX2/w1EoYZ/xXLmEfhXTRGxWatLUTSn0dRazqcUsqT5H7JELquzzGlZO+b+zrXr5v
 aaZqUtuzpMExJF/HqWNUBpUeo0/8feJ5YSoDiuvzblVbJW23hTFGVIEWE6Ex/ujtRxkB
 7NmA==
X-Gm-Message-State: AOJu0Yz54UBQydA345S4iwWG/+o5oc+dJmo5acErxsgacome/9wMhb68
 jKLZYiEGcPjTfKsIK03nP29LXW5PYZ2rLa8kldPxISHpl571vNsoW36KV2oRVYthI/nXc6ozuKK
 6zLmW9wU=
X-Gm-Gg: Acq92OFTIi4vOixpQCZAy1bCgS2qrssNUUnCm3sJ+UfHRaoOfhi5F8nfUn+K6+xMcHL
 M71RFIStEEtyP+Gul34lAbPn24pKEbeHwy54ERblYvSSpGl2nwa/EyCUWS8ZQoDnmVTuufIZ11T
 mTlwPC+Fj2wfAVQbi/zshjXfifWx1B0J0Gto2hEbZfQPzNNtUzYPh4AHbOX2Yj1PE8hMXlnzyQA
 wPovJ9tFNrI91V0EyAO0y0lgTV3irjRYZ2Hw/NKHXI3neyF+WZQ7fRdpXNTMD6plL2kjdTivt4t
 fcGzGlsCWJGY4nEuOOjN2Q0UR7aWzPZo4wsUb9hK7UNAaiWLanqQsNuMmAs+0QMflBCfoJMVLtn
 uj42KcCv69U1vAPMK/wcclM6dQZivhnCDzqYtQ8Tvn+F/5hBPtnTTbgm1E79jIpceeIOzv4xq+c
 qnmWkmi4dBmK4ikCGRYUldlf7Q+Ia7dupK51OWy7mzQUYUbaJa0TjKFkPCvS/nk338+eBC8XNpr
 aLqOeTU/VA=
X-Received: by 2002:a05:600c:34d4:b0:48f:e230:c3fa with SMTP id
 5b1f17b1804b1-48fe6626a58mr398904255e9.32.1779297869626; 
 Wed, 20 May 2026 10:24:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe6b60csm203712575e9.6.2026.05.20.10.24.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 10:24:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v12 10/24] target/mips: add Octeon LBX instruction
Date: Wed, 20 May 2026 19:22:58 +0200
Message-ID: <20260520172313.23777-11-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520172313.23777-1-philmd@linaro.org>
References: <20260520172313.23777-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

LBX performs an indexed signed byte load from base + index and writes the
sign-extended result to rd.

Wire the existing indexed-load helper to MO_SB so Octeon user-mode
binaries can use the signed byte variant alongside the existing LBUX
path.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index a2bfd0751d3..efb1a48b38a 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -49,4 +49,5 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 LWX          011111 ..... ..... ..... 00000 001010 @lx
 LHX          011111 ..... ..... ..... 00100 001010 @lx
 LBUX         011111 ..... ..... ..... 00110 001010 @lx
+LBX          011111 ..... ..... ..... 10110 001010 @lx
 LDX          011111 ..... ..... ..... 01000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 5497ddfb108..451737cda1d 100644
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
2.53.0



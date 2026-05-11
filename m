Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1586CD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:25:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVHc-0004kq-0g; Mon, 11 May 2026 14:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHR-0004i5-MX
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:01 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHQ-0002gP-3w
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:01 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7dca00c1591so1572281a34.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778523779; x=1779128579; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FUxO3ut9ObnZrS6XN2L4dCBHexksaIUiGR+LxlMcBuc=;
 b=d714ENlOSufkVZ8kgxv36Gx0WTOte5PaAkeSsQuJux5+xe7MkTmB6/NNV6KMAex1+Z
 p2i3757ypdPA55LqrOxfL6R2AtbtHu+6z/LNrs6d39LUWG1xu2RoXdbpt3lHWbT8Sviy
 vLp/b+qDGzBZvFCpgddMxuPtN1cgD5Ddc81MNCMWi4hUnmrPrEn8IILWs/cnHIAmYZnp
 xN51kPYezdenJ/EVLugsxbUCsiqWM4mzMMsq7pyLwbPyAH+A8Q2Cm4y+OhxBxxCVYmI9
 s8ERAMagEM7uEC9t5C5NnmURsmxj0Dp8YjloE3+CZ0zfuf2ragsznxZN6bdZGJl+r+34
 6tMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523779; x=1779128579;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FUxO3ut9ObnZrS6XN2L4dCBHexksaIUiGR+LxlMcBuc=;
 b=RDzoMTEKeD+T4+WrjGs/fzYqxXMdHRC94t7JC59XcB06dDl0f3lltXcagdAEcdaRW5
 19eAfU2PWzen+dWqggXhZDv9+9j4e+AKf3LCqOTWs0V39MFq2x18RJQaoKbOYCxf48i3
 jexh/WOWtIb4Mo52bquQBTvBxgGqfu669UIwrVfWtub8cF/xBvN+gJJcbdsRtEaUUf7Y
 GQTEOd2kfFjdsH6h/GOTl3TzyW8TNl6bWFdAElxczxwWiG6WVnI32FlXKcuJ2+1DqWS+
 0LwjdtAX0lzyfAV6MtU/aDOU8E/ihTRM8F5XxExZz+oJpuogpmP1WVIDyHYBWNu83PDa
 OrXQ==
X-Gm-Message-State: AOJu0YwGvNO9NHhy5fuRkEosn0VpPhz2AHTBxDxfDfP6wGTafCeTZXVq
 8H5wu55vO8NAUETRSTollXkPww6c2wQzNgK2x7a1SIuUlHVQBEsdg5GX
X-Gm-Gg: Acq92OHuN7+kbbbgee8j1af/QS38Teyeb71LzvrKge7F/CTyimEIxfv7qCb66YWnqw0
 mhcH9UPkRGIo/JQwuJgVTL8IO/Ksuk47XQIAS3KR3g5VXqbWJvJZtnXojKEIP1w1QynH/KWsu4I
 ANQFOtV+zsCNjGSzOgybq6AyjjDVH8WhErlYHH9p3COs5Hgex/pa5LwpXCLn2Ayuk8xq8j2FnsC
 9JqZTyjbH20Q7/U1Gu9jrdYomF3ljN6QnQdSRre6n1eS++Ydu9k7sO7lHCUuGpqHU4EtsKMUW7w
 efLPyjUKJmRrdgKTipdqvRRUALfePtmFHLU/LvEFuP+ZUTdjVuAQpJlivSrPiqampr4DLu7QWOO
 r78I7RjNtPkuAXAbxC6VOgTqYd+COLe4r8T+D/mC/WvTLWT6Iwwu5ZF06fV1EQsQ2DnIfXWRUyG
 okS4druN7aIAjc5QuROKYRBl0q6E1E9M8TrFaiEQGaNU4CloRyOMo05KLuRCHOuOw2PYDUBuECD
 1nYx3E0JFEefgmLsviMseeClpw+W9i3Ed7t1KBbou2rSmOQOGPAhL5CId/Y7k6ifrW+
X-Received: by 2002:a05:6830:921:b0:7d7:d615:3040 with SMTP id
 46e09a7af769-7e1defe8469mr14955148a34.17.1778523778980; 
 Mon, 11 May 2026 11:22:58 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d90148sm7504871a34.20.2026.05.11.11.22.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:22:58 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 11 May 2026 12:22:39 -0600
Subject: [PATCH v6 08/35] target/mips: add Octeon LBX instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-mips-octeon-missing-insns-v2-v6-8-5062889c4d3c@gmail.com>
References: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
In-Reply-To: <20260511-mips-octeon-missing-insns-v2-v6-0-5062889c4d3c@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32f.google.com
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



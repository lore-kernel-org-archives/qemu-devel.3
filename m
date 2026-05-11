Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16276CD4840
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 18:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMVHc-0004kt-9s; Mon, 11 May 2026 14:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHS-0004iQ-Fp
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:03 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMVHQ-0002gn-Up
 for qemu-devel@nongnu.org; Mon, 11 May 2026 14:23:02 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7df05fc49e5so4527023a34.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 11:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778523780; x=1779128580; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4oy0U3XEsfWbYaF1iik522GRUy0oG3xJODsuybXn2yw=;
 b=a/J3BTnj/TsvLuA7mXfmcyaZxpBPQZpqIWORdTJjXpsU5WFcZ0tl+Ow4SHMqUL9CiD
 l2N4FxpmTwqlTVVBX1119ywhDRUWgg0Cbg+VH+gqRTqzvAyHOsv5FGimrnZ7LVMmC3Xs
 dSzeff/mXTF6n3olaYQ/ngnB98syGcXlVN+eMZXkGttWpYByhT7NYPqFMXrfHMRXS9fJ
 lUeQWp6aXsf/qJFj5a9wfH7mXAadzEC5Rb6amLrsom/7CnA3qxp+lOFldwaAWXqPeZIE
 XnzLHKJRBlUaFc/zjI7MtpE/OpLmmgL0AnkyfW/wac1G619lTCk3BO6hXzo8sZL2VKK6
 Gwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778523780; x=1779128580;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4oy0U3XEsfWbYaF1iik522GRUy0oG3xJODsuybXn2yw=;
 b=e1B+DSbXcXvXJCmQQT+CA9rOUmVhVL5TZk9oTvXCFRRI8NSuVuRVlkGsMh6yUTqKIj
 pNlnXn9fSgilXhiGPGeJAjVmw5L5M3FX/rIOc60jl1GgkW+wLdm21VE4lS3PHD/uav6m
 vHZAF1SfMdkrkzDP8/Ili9Kuj9K/8UH7vhoRAIxLNzMcc99BwLq/XZF8NBrgUaP7F6zt
 SZnLfHRX2VNg4aZ3Gqi32++geBvvE8s3yH8U+1vr/1ZPp5tKE7UnCp19nCd/fQ2uT90s
 KKlas/ku9itNhh8iTEFqUamFtP4k5AZdpuyiQBjf0PliD/lUtzoXhEihBbnf/2iMw/i0
 pspQ==
X-Gm-Message-State: AOJu0YzHgbWEC9CW1lq6A+5GIAsMrgejwtNKUwhYbGQdJTiTlqfBz3xE
 nF3TDXp/3irBufS9DIut45p5aPeedym8FQcNDN47+k9ng+LSOUWIdRr3
X-Gm-Gg: Acq92OFXf4dJwCLjdmTITaNwMKYCD8SHk800bpnhB41H7KtVFWNx9tQYvn+TGmK1+87
 vc48UQqYk8CVnfDbxqQwQbfOPNtTvceRx4OMUjm+1NBXnQcOsSZl/C5eiEfyCifglHqH+0SId+h
 aKLfO6wgXuSdzU89iqCq00oNt0pFK5ONchMQznBfXDWTlzmPnGJRzbAu5v0vGHFMyxRrWc97eCP
 foVo4Z6GqJ/pAbheEeJ0Jf19WVlBX1AEBvfecMo51aUA9N0n5kVSzZFCtQpnPil6scBKaeWs1oK
 xRw6ntz4tlQUXVD62Wsv8EX2R1ahIgVfHyU9dQLAJeE64xRuX6ecmNTueUGpISU7RLj3veqIrX2
 /7FMrB476A5Mc3rYUDtvNFUADVOPqtiJ6t9FjnsUCPDsPe/YYD50qTM+82qfaImeCskPxp5mxFq
 7fOwZNxhJRTdBXX2uROI7bxzjmH4XVEnHGKurd9qbLiI8y+T+ann23bT6u2Tj5b4hKn0L0PebIq
 rWyxYmV0LqSGibzsjxwKFBQTyzIpWtXTDyRNvFPgAbF11Jp06iYfe2XeWfIu8S1mBtp
X-Received: by 2002:a05:6830:2656:b0:7e1:f7e9:327e with SMTP id
 46e09a7af769-7e382157b1emr6645945a34.22.1778523779831; 
 Mon, 11 May 2026 11:22:59 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d90148sm7504871a34.20.2026.05.11.11.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 11:22:59 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Mon, 11 May 2026 12:22:40 -0600
Subject: [PATCH v6 09/35] target/mips: add Octeon LHUX instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-mips-octeon-missing-insns-v2-v6-9-5062889c4d3c@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x32d.google.com
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

LHUX performs an indexed unsigned halfword load from base + index and
zero-extends the result into rd.

Add the decode entry and reuse the common indexed-load translator with
MO_UW.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split LHUX out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index efb1a48b38..8a755075e8 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -48,6 +48,7 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
 LWX          011111 ..... ..... ..... 00000 001010 @lx
 LHX          011111 ..... ..... ..... 00100 001010 @lx
+LHUX         011111 ..... ..... ..... 10100 001010 @lx
 LBUX         011111 ..... ..... ..... 00110 001010 @lx
 LBX          011111 ..... ..... ..... 10110 001010 @lx
 LDX          011111 ..... ..... ..... 01000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 451737cda1..f897b42807 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -164,5 +164,6 @@ static bool trans_lx(DisasContext *ctx, arg_lx *a, MemOp mop)
 TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);
+TRANS(LHUX, trans_lx, MO_UW);
 TRANS(LWX,  trans_lx, MO_SL);
 TRANS(LDX,  trans_lx, MO_UQ);

-- 
2.54.0



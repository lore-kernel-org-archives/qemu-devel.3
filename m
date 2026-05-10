Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A651CD37B2
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 20:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMAx4-0005AC-Gb; Sun, 10 May 2026 16:40:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAws-00057l-1b
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:28 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwq-00041V-I8
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:25 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-48270ea6dd1so168826b6e.3
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778445623; x=1779050423; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Us5V/KDI1RjDObhdRXZc+Uih5zpydnP1PLdcrgbfNdw=;
 b=FHawLBlhYKKnQbXOPix+rOoLE49h1+PEsS3oYldWfYGSATEEwACftAYhyU7ErBz1y6
 TvAl7+EmcaIpLUV5h66hC6Wh97k7O7QWQmoAxHE51inFY3XlGdcBjJ8pWCfCOs2mmIeF
 znsZvmCtdNunC/HX+nMdBhRFsoOlDNVmjY6u5cVAFKJNUDvYf/NBBIn/sj5ziGUIgh4x
 IZwFBKCjF9zU2r6wcMr9CtEu/OT9PCkzc5J35w9v8hZwK1qMSHp5yPIjgMS4X+GmiNYO
 WbfYEIXO6/jEzDV7RpzRKhzC+T1eyZkgfwKPDCTymF+nrittctd59HaPJpfaZFatbaBw
 WqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778445623; x=1779050423;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Us5V/KDI1RjDObhdRXZc+Uih5zpydnP1PLdcrgbfNdw=;
 b=mHlsxcVs1LZdIsLlx4mLI+Ml85Y92PLxIW/5FXrLxieZ16cnL+YeIs0jK8MuiB8dyC
 /u+LRo76IZoT42zVq0iGvnlDH2GgtjN2nLcoXvCL+GRLXV1rwdFbOyjl2xhILoGo7nqZ
 QEIsp97V66azR1RnNPTqD7thGFS3aMku6ELsdtMg5qyIH2S1V+F0tF6c2HzyjTlIAbwl
 TMh7ksrltiFur7clLelo17xEtYOTT9LRomszBelnbXuabTi3XNXPufFTiJvKqCe78MRl
 6evWmbh0kOz3wbWGAlQoQrr25Sf875eo1LxbwFZaFkiGpNVmKywJ+MPJvuJI5qMOmx7T
 AXMg==
X-Gm-Message-State: AOJu0YwLauaL/PbWBd6I6Rrg4ISRERPekDmNJinhIk4COSSlGI/p2O6X
 ulvbZBWSKtpEznKJtbKqogEOCmNK9RhaIgTSPWpRvvE7VZNdpoaPCDi2
X-Gm-Gg: Acq92OE2Xv8Fml0ikb2C8zW2Y/aM5nfwBMIUnLQF6H3lW3n2H4Fr1NHctxxTMaS4u9M
 MYNPMmM1tvRoO3v0W1o9sm4UbiZw1ZMplkzNdlQm7IzkwFSqLGPUnm+UMAoT+OWrO/bHeStBJ3W
 La1pm2ng0EjHoAhdyv8u0V9WuJlpqpFIq59pTrwuISI2C54IEJRIiFVBfasXa8/JBtlrkC18VKt
 dq4IhyR389tyxGYZEJM3pwdNU/7VOoL4QQJdCOpvzb1qWAB/rH+LIAZe158dv4c4uIE/ONBoXYK
 6M6IhAgZA2T/3RnbiZLBxyF52pgvk04iqpIjWM3AxtAEVz3CPoYBYE2VErU3ZpfrQVnnW1QE0Su
 CY0kWhPSQwaT3DGA9BK3YnY6UGnumFcLRZnUlyTX+JHB70m6t6v0G5eyA2NRX3gpw/Vs3FSK52O
 vZ9CIdH7BqZ4auimNqwJixL9gBaHsOk3VVZjv1BwsVgQYMo31CvdwY9w75B5MViGAEYjWRZ+Lsz
 aXamF83z7YfX5fhY8ScsqXZ7PhJ881ous4GTPbcCglXpxinH8UClw==
X-Received: by 2002:a05:6808:1481:b0:47c:3c56:c96c with SMTP id
 5614622812f47-48042532387mr11962833b6e.39.1778445623335; 
 Sun, 10 May 2026 13:40:23 -0700 (PDT)
Received: from MacBook-Pro.local ([209.245.15.183])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76935637sm18908207b6e.12.2026.05.10.13.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 13:40:22 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 10 May 2026 14:39:49 -0600
Subject: [PATCH v5 19/32] target/mips: add Octeon MTM1 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-mips-octeon-missing-insns-v2-v5-19-d5d2668d15ab@gmail.com>
References: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
In-Reply-To: <20260510-mips-octeon-missing-insns-v2-v5-0-d5d2668d15ab@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x234.google.com
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

MTM1 loads the middle Octeon3 multiplier operand pair from rs/rt into
MPL[1] and MPL[4].

Like the other MTM writes, it resets partial products so the following
multiplier operation starts from the newly programmed operand state.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split MTM1 out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Describe the Octeon3 rs/rt MPL[1]/MPL[4] pair handled by the shared
    MTM translator.
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 99606c80f6..c85199ae32 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -48,6 +48,7 @@ MTM0         011100 rs:5 rt:5 00000 00000 001000 &r2
 MTP0         011100 rs:5 rt:5 00000 00000 001001 &r2
 MTP1         011100 rs:5 rt:5 00000 00000 001010 &r2
 MTP2         011100 rs:5 rt:5 00000 00000 001011 &r2
+MTM1         011100 rs:5 rt:5 00000 00000 001100 &r2
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index f128b4adae..bc01b890fa 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -275,6 +275,7 @@ TRANS(LWX,  trans_lx, MO_SL);
 TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);
 TRANS(MTM0, trans_mtm, 0);
+TRANS(MTM1, trans_mtm, 1);
 TRANS(MTP0, trans_mtp, 0);
 TRANS(MTP1, trans_mtp, 1);
 TRANS(MTP2, trans_mtp, 2);

-- 
2.54.0



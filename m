Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D59CD37B7
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 20:41:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMAwn-00055R-Tu; Sun, 10 May 2026 16:40:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwm-00054a-N3
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:20 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wMAwl-00040I-1Q
 for qemu-devel@nongnu.org; Sun, 10 May 2026 16:40:20 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-4043b27ddeaso2198134fac.1
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778445618; x=1779050418; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4IK85PPMBI2youTGdlMjIY8YEP9i5/O2uDLfdpbX004=;
 b=X9XsbO/s7h539N6Wu03sbinDLatTyOmUQOd8sP1fZl8U1X904+IaNBMopoNmXrtXir
 ANoodSUKYQmP7qMuVUWXdDopUZ3fgKNhRce/CaVn3OZd8jyv4ex4//gdpWzGP4h0f399
 wa2TtgcSNaDdcFIPXqlKwO/KNtx5kHXvaBr2FcCJThwjICHRKGqaFVVYowM4pNkacnrY
 0wyngkqopdz9JRNkUQqGWDOVb/+8eRfTDaGZbuxsScoY9tKo8OWNk+HSTAoXU+MgIkna
 3VkuYE6TfhOEt0d9wn8Wf/agTAeSl4AvW5fuZoSl4UB/yD5uf2rUsuqJWQJIHobK3g5r
 kcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778445618; x=1779050418;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4IK85PPMBI2youTGdlMjIY8YEP9i5/O2uDLfdpbX004=;
 b=PzQuruvS8dIQf7Hg6VjLjQQe6JhSGsKVXt8nUOw8cS7Lee6pkTQts1qCKAt6v/SzZH
 NoJdIGNfPJFzbJHyXCFZbh8bS0BHcxEuvR6dSbEM+150uh6Vih18iWUl3fEV87FR7gf8
 wHoZbd8ZAwe59xtlxlBGj10Iau5TyNxo8wHQZy4xKtZDKtC8HJP9VM8NIpNSVfEVPAv6
 NfGilG7HCcf9m5/7yazCdmsA2BRQmuxLGhHnPY65jlyqSU1KQ6eXYm28UfMFrjDlwRsC
 09DlWwRzr4tjNl3Y/RXFR+IDpqJ3Jt0omhSIeBTEssNPMVrd3flW2NC+1OIucQ18/2io
 42YQ==
X-Gm-Message-State: AOJu0Yyx3HeQ5fmCNxDFNgTyApYiUOdGOSvjXI7U5cUmo8cO1sC8Pwx/
 8mVNcmrkpmkHfxkcaAsCod/t8r3g69HmUzsIXpSOlePgv/T+OXznMmiW
X-Gm-Gg: Acq92OFJlV61ju3YY/aB94HV/UduqZuu91cCjvtRlnAPyXpMqpuYG3zvhI7f6PWygwj
 fw7dXeLbBxDWdkfX8SbwDu7+5zftsvpIMOuq9FL9o42cwovB/xWZlm2/8/trs2HdyT9n6m2kNdB
 zgnRcc0U+RDyAQiSZoQ6yrZr70C9LgJNds5dFoC+6Hx9466ft/ShxpbvTgTOH/jZPlnv05XaXGZ
 R7bIFRIB/N6rumArBBVv7SJYUJtxLcLI8mfw+5Ym8sJUWylr0RfBHzy1IqcBCPNzbs3pScpR5+s
 x1FQHtQ1RMiTR+H2VcoPuc+Ms1SDTJIZ45pKIntxJ1Y8L4h2WR6Hz2fKZqFbaC3xkC5T+JLEdAw
 ssmD9cOiXc0c3LkxFLi9bD8NiVUY8GpeuKiax24EQb3Ehpx9XeleK9eCTyZxiS6Vb81raN87tDp
 xKpZBfSx8XPGvixX7ZmWuovi2/1GMenewto5ZhGHJVSG28ujD7I0p8VPxMNd/UGIbJxGWHiK5S8
 pY03Vl4dGN8CGzPW8CuP6B1zmmp20lEKfbODOCx5WM=
X-Received: by 2002:a05:6808:3a13:b0:482:6b96:5ad0 with SMTP id
 5614622812f47-4826b967455mr2081193b6e.26.1778445617734; 
 Sun, 10 May 2026 13:40:17 -0700 (PDT)
Received: from MacBook-Pro.local ([209.245.15.183])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76935637sm18908207b6e.12.2026.05.10.13.40.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 13:40:17 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 10 May 2026 14:39:44 -0600
Subject: [PATCH v5 14/32] target/mips: add Octeon ZCBT instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-mips-octeon-missing-insns-v2-v5-14-d5d2668d15ab@gmail.com>
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
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oa1-x33.google.com
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

ZCBT has the same user-mode memory effect as ZCB for QEMU's purposes.

Reuse the ZCB translator so both cache-block-zero forms clear the
containing 128-byte line.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split ZCBT out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v4 -> v5:
  - Fold ZCBT into the ZCB decodetree entry with a selector comment
    instead of adding a separate translator thunk.  (suggested by Richard
    Henderson)
---
 target/mips/tcg/octeon.decode | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index d8a1bfce77..5377f7b3ef 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -51,6 +51,7 @@ SAAD         011100 ..... ..... 00000 00000 011001 @saa
 
 &zcb         base
 ZCB          011100 base:5 00000 00000 11100 011111 &zcb
+ZCB          011100 base:5 00000 00000 11101 011111 &zcb  # ZCBT
 
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx

-- 
2.54.0



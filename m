Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 147C6CD5BAC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:38:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYgZ-000179-BR; Wed, 20 May 2026 00:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgW-00014i-FJ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:32 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgT-0003mz-LM
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:32 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7de7dc85b74so4360554a34.2
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251848; x=1779856648; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UADH+4H0+NWhce4iEtIjPf3ElkgBOHbMXUCIk3Pg91I=;
 b=kjA/6cf/213MrvOeaZNoOH6gv9s0VaX8TinX15Y9sdH6mxGxz15thJQWiK0XZFk1ko
 icGqg8Jl5NnxhtDCA5HlEJowKMyzuj4sxBiPpCgynFpk9Y7oLDsbHJxL4cCD7LKipKB2
 Th141S7hP70tyOPHl6hqGw034NKyWcNKn0FJ0zjiiAtsCYidITkNOPQxSqHb1bP+YPEh
 cQW+QnlgehfDmcWAMSxJV0+6zylTmgDa0t7lMEjYJmFLk/cw9W4HdJwIRbLDHNiU4dr/
 Iu3rfhOp7VHTPAd+QACjF1CiVEr7mcdWjQaiyG5FjgAUxjQt1W1k9yMFlDrznL4rPlHX
 6cHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251848; x=1779856648;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UADH+4H0+NWhce4iEtIjPf3ElkgBOHbMXUCIk3Pg91I=;
 b=fJsnY6sA5O8y1KKtbjWdEf9PPWhP26ZORjcqA3kPowQjhxF4ZoHJmq9FpVL517dLFC
 0pDMJYZL9Kz+Wr10C/4jSXx9JwtrqJoQintrL9JW1K+rR3/3wHVhswLoHFt8Ilkjouwr
 pMAtUmsT9/YTiwa+ppLYylYZ2DusRLg50zGkkwzbw7e4QFW9M9CZoH17kqDh4P+ZeIPL
 Xe2+S456Hl0KBbHaDXV542yXg4y5CqeBa+6lVe+RoUh6BluZu1UCbRlzTKdhqesPE14y
 DWQee/OfFppPM84Xfu6PPOfyzrXYp8cGKBsldockVx1pPukLPjVJ04eNDaOPDFp6kFjA
 QLcg==
X-Gm-Message-State: AOJu0Yz3sKNf6wmglA/dj/HiWnOkdVk4ZN8cu7OGXWlJ0i2FIOVqa7WI
 VrDzLyAE6zN/Hz2EtSSZmYH5wfXEFe1VlF2fFKQ01pBvyfh0M70lH6kW
X-Gm-Gg: Acq92OFi3eAtI5Ie8Ej9yVmEz1K0fOTWS0aK3alrTcUS3LWzr5vIlwuRZYbXQ1VpRuX
 HIDTgvMpwhngrQkeeclBLiCvD2N1MMgoadUYueqZ5QiFHyjFPMNfx2V5qM0CO89KzLmu1gOieCJ
 m8W55BC2WmYa3wb1Ic9zoTJYFfmP9haCI1LP9HJ5O9NI6W6YqzIA121LSjQjkKuHuROJjKl2R3m
 9A1JpYz5zFDMd6BgQjipF5ByEYc9fPLVaGifuDVtjjBpJF7JX9ChPkEpHDmmV2fPP+9WjO01YYx
 FZa5x17o7N/8mV+riEF9rrdBJ6tC+RT7qcPi55z/+bIz/fNMbl2MKtiBwNyJj5CvBEV/fuxKwe4
 NKQR5xw6ugPCCOYNyVv0PmEt1en/j1OpGNtnsJ291MWHUz+n638YfxmOkfl4ENpdsb85bec4IXo
 9UcvIVTKtnTYtgmG5JsPBfGpPb20+/RCwwZgQGwPN0l1A451A8CJgzbPnyBtTYL3gGE/xcXRD2T
 IktFJ5TlPPIXzi8dWqYw7RInfJcwhwXlOrx1eSzFMVx6jv8l57Hl5IYlkuNrHexCkOD
X-Received: by 2002:a05:6830:6b0f:b0:7dc:3db6:f02 with SMTP id
 46e09a7af769-7e4ea08882amr14682851a34.9.1779251847644; 
 Tue, 19 May 2026 21:37:27 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:37:27 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 22:37:05 -0600
Subject: [PATCH v10 11/45] target/mips: add Octeon SAAD instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-11-306f9edfe15b@gmail.com>
References: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
In-Reply-To: <20260519-mips-octeon-missing-insns-v2-v10-0-306f9edfe15b@gmail.com>
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

SAAD is the doubleword form of SAA: it atomically adds rt to the
naturally aligned 64-bit doubleword at base and discards the old memory
value.

Route it through the common SAA/SAAD translator so the MemOp selects the
aligned doubleword transaction size.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v6 -> v7:
  - Use MO_64 for the doubleword atomic transaction; the signedness bits are
    irrelevant for a discarded fetch-add result.  (suggested by Philippe
    Mathieu-Daudé)

Changes v2 -> v3:
  - Split SAAD out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)

Changes v3 -> v4:
  - Note that SAAD shares the Octeon+ gated SAA translator path.

Changes v4 -> v5:
  - Drop the Octeon+ gated wording/path and keep SAAD under the existing
    Octeon feature bucket.
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index d6b241de42..d77717cd50 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -47,6 +47,7 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
 SAA          011100 ..... ..... 00000 00000 011000 @saa
+SAAD         011100 ..... ..... 00000 00000 011001 @saa
 
 &lx          base index rd
 @lx          ...... base:5 index:5 rd:5 ...... ..... &lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index f00692830a..d3dfef2e0c 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -175,6 +175,7 @@ static bool trans_saa(DisasContext *ctx, arg_saa *a, MemOp mop)
 }
 
 TRANS(SAA,  trans_saa, MO_32);
+TRANS(SAAD, trans_saa, MO_64);
 TRANS(LBX,  trans_lx, MO_SB);
 TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);

-- 
2.54.0



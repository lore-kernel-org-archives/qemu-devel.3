Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8349CD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNa2X-0003QG-2l; Thu, 14 May 2026 13:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa12-0000rn-Ak
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:33 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wNa0x-0003uC-M5
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:38:30 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-4824b15c19eso4704249b6e.2
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778780284; x=1779385084; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UADH+4H0+NWhce4iEtIjPf3ElkgBOHbMXUCIk3Pg91I=;
 b=aHXkZs/cgYyXwDzh7PDA3DzUo94Ga8Hj7PnXC/4Wrx+53OIr+i2z54GnHKbAi3gkRn
 7RUWErQpyydWabnVKIh0TNIapAdEdtt63Kd9FI6HfCf0EChv6IebcVgupb4rjI1Wn7l7
 rREKpHCjRRN09wCYYZ79mgCNjT/33JyyWEHesEOXbfNcWlkCIoYj7+Q+9NSeYNdh6upt
 845n8fRhetQMc57AH9S5MwLowCCmzugZ6THChaFLnZzly9xIjjL0nGZBDnw4ETrotS2V
 8sSYMM6Ece46YcXt15yWDdmNAAWm/tUkIEHAmwpOyuxSjrnBwVx4KX+dzjZt0Y40/xgl
 h4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778780284; x=1779385084;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UADH+4H0+NWhce4iEtIjPf3ElkgBOHbMXUCIk3Pg91I=;
 b=ED/Od45TMZ4HmgTRjLGv1n+wQ3a5KEuHlepXw1ghcmjncY9o2x3AdQQHnuGo3AMoRd
 RfW51UP/xAQg1o2u03oGmYA0M4HVjhI7cefL8sQxj5Jdrztkbs4lb6JW4SiTAS+APUUs
 XKBhftG7asiGV5OuZn88WxzhVAAlxGfhof3UNCRhF4tl64OR5UjFWuMKly6e08jXnw+6
 1CZe9uZV/NnPeeW0pylW3Nf619tYHq+znm9hQW6I0izVSxsaMttdfDRS06vwk6d4i7Zn
 xL4eSzTss6RANWgZwRYCPM6ptMV38IxR/XA9fxFkuEKmi3dReDwczh/yrgTbq7LLnwNx
 koqA==
X-Gm-Message-State: AOJu0YzZv7+1Tpgz4evcUknxBdsJaoAubj713sQmjb6y/ELBoQpU1NaI
 xj+C4GrcWrGQneLGf9JIosX0+W9G3SB/WjgyphTyVihhrUfumvHZXumR
X-Gm-Gg: Acq92OGmWf6VqfsCAKEWbmXwqfCsm3gTLM3RCXY1Xb5pymxApCi6v5xO8MTAnWJjs1S
 cY0l2BJX1x6e+PxRzAEQOWco0JFvLaAfhC3EqA3fYrFO2stjc3WH7lVRUdeqwvq+fSh/t4zuXIX
 ExEyDpmW6drhZ7J3nrp1xZuywLzY42b+oYCAqlfcvSRKivwq0vGcrvi739sPwlf223jqKZ4YunJ
 CcWOCCMXqRyGwpDadLokllGXWXyq4rKJt8hN6nP8XhfPegvqPaLjmMIzP7rmhFgxQfzB8/eROM8
 DRaJrD3f4Y3JeJmKgk2AInlIDtcxsGtLEcJiaPWzBWThcxFniqhhilKAMzlSlAij7bBCsGKn/tC
 +NkbKaWAgqQEV+EwM27MMMABdsmMzeL+fYvs28l0Ya4S1hN3SmtJzs9sFACSjn/kL25jVqYx3jr
 YxZVJTo0BptASpCAhzJIaLQy27wQo4KTyGpw7tx2qKpPNSnfgxKDD96kJrEGiW17Yw6/UDli7XH
 HIGDwL3uc83DgqSiw6ijD/oMETOWscsqbYZSvXnjU9HzoVrChlVWITq4AYen8r+F1vxUBGJn2d0
 jr4=
X-Received: by 2002:a05:6820:602:b0:680:89db:fd86 with SMTP id
 006d021491bc7-69c942cc0a7mr320547eaf.13.1778780284579; 
 Thu, 14 May 2026 10:38:04 -0700 (PDT)
Received: from mac.localdomain (71-218-106-55.hlrn.qwest.net. [71.218.106.55])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b8ccdc74esm1687254eaf.13.2026.05.14.10.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 10:38:03 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 14 May 2026 11:37:00 -0600
Subject: [PATCH v7 11/35] target/mips: add Octeon SAAD instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260514-mips-octeon-missing-insns-v2-v7-11-226686be4ce1@gmail.com>
References: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
In-Reply-To: <20260514-mips-octeon-missing-insns-v2-v7-0-226686be4ce1@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x229.google.com
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



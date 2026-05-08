Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463A6CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMtj-0002xC-8C; Fri, 08 May 2026 11:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMtG-0002gk-6U
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:22 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wLMtE-0001k7-Ie
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:13:21 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4756e74f8edso1489160b6e.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778253198; x=1778857998; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iof6LsSVlMEYc7I1zyXWBTsPIAQRVQg2PoVAkzUPzms=;
 b=o1+fiALF+E3BCPhjhSFLNl7bNfgGTytIjysWAR2spqSjsYY7ANSigaV7SztNVGdgac
 +MjDHp2lY9gcV6OJbpUpyPB0I6zgxCUsnZ+Fc1RVZcIxhDaBLAdvBk3D+KZOqHYKtwEe
 s7iobh6THYutgl1Tdpuitbu9C/mn80YwRHK4fH4B/a0MGaHRdh5uF6myDLzFZ5yDWQzq
 5ndLXBcw3Je7ZOv6T+rpeeYvMOjWm0mi6KTw/cukiQPIm+kPTcaCJMLRB6ZReVn5ItRC
 QNhV67HuRAo6TypQDOPQDnWUFscRvJcGJmuuL95mbHTAktdq4OpF/q9moi/qUT4RyxNh
 u+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253198; x=1778857998;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iof6LsSVlMEYc7I1zyXWBTsPIAQRVQg2PoVAkzUPzms=;
 b=V4Woo/Ii+JQp/X1dB2pZGQ9Gmw3aeRnna7kXngPMRoKzpUIL1m3IFcaH4/ISbBcXi0
 TpPDvIPHhhJRow7MBOYG8pSESFikbfi6K6EstZS9TmRXZ6KASTVjOmy7M617fNfD4I8l
 9igfYFd7dfaoZB6BQeAnOUqYBMi67+yUNEfEXmaIkiqNUY9nkgrWh4rAFj4rwjaz55Sr
 1yFcxIxMQ51pkbiHAPOiyehZqfxsC2E29xDiey2bZjl5IxnRZTShUvgF6c3YwyD6Tkew
 yYFFAV4df5YijVmdikX1SF7Z84RHMKZalyIr3AKKVjgJnwrFKPdm2sw/sWrfiE2DSPGt
 LIbg==
X-Gm-Message-State: AOJu0Yz9/yvhmi1DVW4zqJEzszfnPimpxm8Y1ss+/YLVei+YRHq95BvJ
 44/mEEqfzvgwp+dqYepZmEId3eRcd/j3vmCF/j7euAbQKpU+m40FkvMyKJUMZw==
X-Gm-Gg: AeBDietgW9UEgO6/hULi4abKqdiif5tswXuzsQGewvb8n/rYxSkFpxVnJGh5bPX3CsR
 76JqkMP/CvFzaD35Zt2DUsP9bCR3Jwg27qRRxJubI56G6eBozaajIXquJKXDpX/YRlObD6fjDyP
 V3oY0vCZjzuCJIM6C0lLVpT4M9Ou5bFR11M1aqkNzx84Nc3y0HguoVenrTj/fwvn8q8UUHx3Did
 TMX53xE2ER7JLUwnoTA2s7WzIeFFCTHUQPKzW8NKgGdyDSFrKOALJKY4dY+5u2WXHDQzZbeWZVM
 RXgFXqLIBvfF9l2ZW2/RSvSt+d8MiwaacXqxxgwmeC1wO4W/n3BZ5YemrAsPjshtTsqEzaXZZMH
 OjqAbk5B0F2eEW9GlmT3piwxiIl/k5FVxLtqSI42fexU+hk5zDC/JtFjejPFG7+M1GJKORL0nPQ
 ZFS5j84F05NSsSV9iFNwSVJWwVH+OJfVl3kFkrmxNBux3SYpjFq+JvJVinm6P6+1xGKsOv8GOjv
 RlnoAqBHJwG7pAh/XolRcRsteebdg8TcMF4DBon9CUXxG8MgSyY+8wRW7ZMq4yFydisLKCA1S9L
 i2CHQNEmQEDkX79r750FfRY2XowSwyPHhkZdjj12GOOCVaxn0RKQ1XmzA+dQvN801+uvIVo=
X-Received: by 2002:a05:6808:191d:b0:467:5f1:fc93 with SMTP id
 5614622812f47-480420bb06emr7736924b6e.9.1778253197958; 
 Fri, 08 May 2026 08:13:17 -0700 (PDT)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 (71-218-113-237.hlrn.qwest.net. [71.218.113.237])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43557109b7dsm1897904fac.5.2026.05.08.08.13.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:13:17 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 08 May 2026 09:12:20 -0600
Subject: [PATCH v3 20/32] target/mips: add Octeon MTM2 instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260508-mips-octeon-missing-insns-v2-v3-20-bcbec96357d9@gmail.com>
References: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
In-Reply-To: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=james.hilliard1@gmail.com; helo=mail-oi1-x22e.google.com
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

MTM2 loads the high multiplier operand pair from rs/rt into MPL[2] and
MPL[5].

This supplies the final operand pair consumed by the V3MULU three-limb
multiplier helper.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split MTM2 out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 82d0410e6c..7de2a8f6ec 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -49,6 +49,7 @@ MTP0         011100 rs:5 rt:5 00000 00000 001001 &r2
 MTP1         011100 rs:5 rt:5 00000 00000 001010 &r2
 MTP2         011100 rs:5 rt:5 00000 00000 001011 &r2
 MTM1         011100 rs:5 rt:5 00000 00000 001100 &r2
+MTM2         011100 rs:5 rt:5 00000 00000 001101 &r2
 
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 74533014d6..4207f01e85 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -292,6 +292,7 @@ TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);
 TRANS(MTM0, trans_mtm, 0);
 TRANS(MTM1, trans_mtm, 1);
+TRANS(MTM2, trans_mtm, 2);
 TRANS(MTP0, trans_mtp, 0);
 TRANS(MTP1, trans_mtp, 1);
 TRANS(MTP2, trans_mtp, 2);

-- 
2.54.0



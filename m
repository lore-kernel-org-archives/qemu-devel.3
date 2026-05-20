Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CDBCD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 04:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPYgX-00015f-Gc; Wed, 20 May 2026 00:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgU-000146-EC
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:30 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <james.hilliard1@gmail.com>)
 id 1wPYgR-0003me-NC
 for qemu-devel@nongnu.org; Wed, 20 May 2026 00:37:29 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7dccb8644c4so2435081a34.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 21:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779251845; x=1779856645; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7mCE7v1CMCCdQhzPLrKhoNSMg70i/ioZcq2tZRejjeA=;
 b=X/9yOF2CRJt3hsslOYq+kpkrpTA1Cx3DWBwpiwFO7T0MQujKaw10mKXPgHz7ESsYkA
 0s1/HjUTPf2KdYkFkAxmzhkhjoqkcoa+GtmVEcp/p3VyZxYnprSb4gTVHYhC3I6hJZN3
 gfJbVfLcKIU8YkDYY/jsQTqP41t8YfkaFFqhZDAnYk0FLsgmrrW+JBMilDQ0n15KAtNS
 emzy7y6IRa0y+7K+rgeU1DZSr7p9lAp9KoinyeqhmS+4H6eNvco7YtqsNn5JWhqfzj/0
 VGnWTgaWx++T7GTGJwBH+s+nutW5Sc+iwHnQwwSr+EPbd+jYmE+7un6JSdq9szNYvYZn
 nNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779251845; x=1779856645;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7mCE7v1CMCCdQhzPLrKhoNSMg70i/ioZcq2tZRejjeA=;
 b=DhX25MLuemFZLi0riDcjbAXY2vdmEVElG3e21NMXuhuyMbHEPcBn1wxKrOhy/sJK4+
 qnkLDF5vjpoTK/ilT0hvoB7YUJy4jEHnDi2dpk1C47ENZLPS/06UY/qB6zgTkgo56GiW
 U7wjLmgIxcZeOZs42ZqPR1PTrjjN+IcpKykhEUImCAI8VISrRYN5qrGCAHmF0KXRW9wS
 btyIUfYeEXoRbBH/3d/Msd0Y4A6w5bTx4/tAT8LL3JqV7TeQGRD4N/Pje9C59968KTpo
 lacODDkjZl9yYFmV0qwTRSQ8Om5vJoiCL2COfHsOEfWQQrjfLrv9Pbqtbgd+DF2DDyy5
 qu9Q==
X-Gm-Message-State: AOJu0Yz1o12jKj+BBhzKdtvbQItzpznDB2hn68bZGdo22HTft4NadU9H
 7FkcRsHLf+KhGV2QFurMHkSIjLcycjBHC0ORUROfmoyy/NdLh89RtyVM
X-Gm-Gg: Acq92OEJTOjGRXzKZhoZULrD27KlrM0oWsDSTBI0B6AgD9ZQw4P/J6dN145bPnI4BJ3
 xLpM0okAwkd9bqu3wMQG2JPelnJX+7HHpXS6ocJo8TuP+gSekLcSW4wMTi1nKl4sNJJmDH/mI+H
 MzeA9NAujTbUwCs0zBnTleELEXaNfVagIupHtBMq457h19OT0JOEQMnUb1clnH4rOLHhsp7T+vn
 O7BdC+XnI7HUsTMpqFt+4u40VLGgO74CNDOM8Ui697v7K1W6OpUvEDBgADRrf84vyzsaXnPAQwx
 rz+JR67u/dr/1M99RMgJHBspCLcxE3fAyPBw0zAFEKMuRpfGCsXWcwNW1Oe6WOYJ32HyCXel4gC
 W5B4HQnF1prnBEDe7h+NmuF5sghQNTBJWpD7YtrTMLULcWSf7sup7EIOpsFfXQD9ohv2zwisqtx
 eFrDt5+DwbqIpwzzn7OyxauN5baHkRgoGn9p6mr8/U/PAHUd3JxdulcBRNp/RX3aCH+1+oGoJBp
 Pvf9lfH0uJ1XP4kMSHs4tw/eR5LXqdMIHAfQLxAhHHNl1uBVvbKaOikGK62ELzH/NaH
X-Received: by 2002:a05:6830:3149:b0:7e4:163:49cc with SMTP id
 46e09a7af769-7e4f2a1e5b6mr15295412a34.7.1779251845279; 
 Tue, 19 May 2026 21:37:25 -0700 (PDT)
Received: from mac.localdomain (184-96-146-19.hlrn.qwest.net. [184.96.146.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bc4f04fsm11574634a34.27.2026.05.19.21.37.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 21:37:24 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 19 May 2026 22:37:03 -0600
Subject: [PATCH v10 09/45] target/mips: add Octeon LWUX instruction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-mips-octeon-missing-insns-v2-v10-9-306f9edfe15b@gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=james.hilliard1@gmail.com; helo=mail-ot1-x335.google.com
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

LWUX performs an indexed unsigned word load from base + index and
zero-extends the result into rd.

Add the decode entry and route it through the common indexed-load
translator with MO_UL.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
Changes v2 -> v3:
  - Split LWUX out of the combined Octeon arithmetic and memory
    instruction patch.  (requested by Richard Henderson)
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 8a755075e8..db7d5f55f0 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -50,5 +50,6 @@ LWX          011111 ..... ..... ..... 00000 001010 @lx
 LHX          011111 ..... ..... ..... 00100 001010 @lx
 LHUX         011111 ..... ..... ..... 10100 001010 @lx
 LBUX         011111 ..... ..... ..... 00110 001010 @lx
+LWUX         011111 ..... ..... ..... 10000 001010 @lx
 LBX          011111 ..... ..... ..... 10110 001010 @lx
 LDX          011111 ..... ..... ..... 01000 001010 @lx
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index f897b42807..401c4bd14b 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -166,4 +166,5 @@ TRANS(LBUX, trans_lx, MO_UB);
 TRANS(LHX,  trans_lx, MO_SW);
 TRANS(LHUX, trans_lx, MO_UW);
 TRANS(LWX,  trans_lx, MO_SL);
+TRANS(LWUX, trans_lx, MO_UL);
 TRANS(LDX,  trans_lx, MO_UQ);

-- 
2.54.0



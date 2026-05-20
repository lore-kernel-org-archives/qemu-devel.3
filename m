Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C9F9CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 11:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPeuy-00015f-0X; Wed, 20 May 2026 07:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPetL-0000lv-ER
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:15:13 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPes3-0007r5-83
 for qemu-devel@nongnu.org; Wed, 20 May 2026 07:15:06 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bccd251d622so811619066b.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 04:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779275609; x=1779880409; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QR8rmkB59QouyU42X5BEd3gCdl+c+memYAH/UwzBTo4=;
 b=IMq4lTb1BQdGeKx3awNUstJORspXup2tolrVQSQ3FkmwAYbRZgppVk4uJEqkZ4KOy7
 9+z5wJ1Vgee8ucOgL6h89c/QJZfgicNF59MxD8dOafbVW+lwGhU/pYrON2jNPsGvo3Rw
 E6WH+qc8wxk1XepFrwMbk49MTWL5ded7TvtPrGwDNBDnlg7PEIery3iqOvs+dUJ8pVQL
 Gz0+UWxsw42wiF78ypYQXCn6KPiVMUwApUVYu4qcCAyPwMkl2FEAyBoRq3CTRPSJO804
 bZhjFbUITpvXDMgigR889jGO/BNKCIc3pthndmtwSHciwm7NHZuRYgxls8oBAZse5psD
 k+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779275609; x=1779880409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QR8rmkB59QouyU42X5BEd3gCdl+c+memYAH/UwzBTo4=;
 b=PayDpAnQDYPWJs5Nef8SJKK81xJepyJU0Jn9ImyY5sKWjqSpiXOV4sy8dEaynnR8/9
 HBs1DJzTlr1V1PDkJ7YtOCRt9pb9/X5FX8hMTMfgy2TjYoL9AGyskMh6OuNCDuOKcflu
 q5rGyHVywpB4JS30t/I0Fuikm3Qoy+Wn45mmV3eSxo1GXJvRlsu1xJ50l65NIHfq4Q80
 na72eEP+JXdl0mVqYjZyIhSttFkXVno9HCaIx2w4RhA3iZW0/JVnYXkReiHPxvH3HTYk
 hWDK85u+nmhO/hCNtnpaD/UNuJQTT4CwpLznzQGBwbi3XepGH/ZSP+nwOh3zraFD71tk
 oHBQ==
X-Gm-Message-State: AOJu0YweUMAcgwQMa2OiSbhFZk5yniDGq42FNRtatBnlTMPSbq+SDKei
 p6AhAlOEpoqFcga0MFzLYlOToYHNKJTr5BDANMitRNsGfPhjpAcHSumv5ErrZb6HHczfd0J+s4g
 p1Jm7PRU=
X-Gm-Gg: Acq92OGibW4rh3PHqdpNPKfQO988r3jZ7ifk6pB41rgPj+o4z2c7ETgMhI4f2/FX0XR
 1vDqc6MOPk1rkgraZog0CJJyy5t/tK8HBbmVknQOK1z59h4Z91IiSaNE2ToUMfn5tnRMCJGIKsT
 aeAbCr+o64S0kAJlbch0+N8TaoIgXM1wyrYxoxqIDWPDj8JY5bdb8R2ByzJ77qxyY3uU1PjH7oh
 Lyv8Y9z6WibvUwHsZedu8lcpD+Ayv/3A+pgye0rsxR2yGvadwY7fHLqJPZ7vvuRMOWrL0j5Rv+A
 ttq3NWeZ8ry+Z96mi78Ezl+tR0qGp0WU/wGcVJ2MwZkcqo9154BojihBbxh489NcPTCA/0xIB5U
 I4wSHECvr9Sw013osQh5Nk4OJ+3cG5thtex0+ST61gPxsOuJMLMZizRM1fSJ5ZQmwuPop75Hbm5
 VkJxk7Bcq44lkPVatzQfXaECZmJFsSFPUBzHIgn8CQjYADcr73Hh8MKKsZddxbxUsTwHrCyfyCP
 3RiFJBYZttENz59
X-Received: by 2002:a05:600c:c494:b0:48e:706b:53e8 with SMTP id
 5b1f17b1804b1-48fe60ecd88mr337360835e9.11.1779272365243; 
 Wed, 20 May 2026 03:19:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4dac000sm396157575e9.0.2026.05.20.03.19.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 03:19:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH v11 10/24] target/mips: add Octeon LBX instruction
Date: Wed, 20 May 2026 12:17:51 +0200
Message-ID: <20260520101807.9971-11-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520101807.9971-1-philmd@linaro.org>
References: <20260520101807.9971-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BF8CD5BAB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmYj-0002NB-NB; Wed, 20 May 2026 15:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmYJ-0001vZ-Ho
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:26:05 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmYH-0002WK-NY
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:25:59 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-490229aa522so19586675e9.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779305155; x=1779909955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DxXDtkFhZKOWxRNtCtZ0V96NkTqI2RVN4zuIdmotLa0=;
 b=cdpg4l8DUZA9CLh5oEfYspDs6beu+vVrnJxQt1T501o841ieaoeMgYDD+8ny/+OhXU
 btZFgkK5+jYqIw24j3L4VUSmTODhx45dWN65qKx3YCiwxyeGrb6+MQEF5x39e8gh7j0Z
 SRgmasmxTIlutxpuEDfTRJuTH/NO/nlSffah7p/Gc2UqG33kptfeO6CJwkMzEuTHKsK6
 Dd/MPTaPWlKHVD0k7zdWcivoPY7aBQ//OIca+dOisacURWm0YOt4TPr44TYgPOIcPlq5
 sfCrbTvls0s7dbSBOcRWjGPo0z5CWPeAB9QkwW5d6PCxE6hluM61mjQEq4O+I5I1z5A5
 atxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305155; x=1779909955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DxXDtkFhZKOWxRNtCtZ0V96NkTqI2RVN4zuIdmotLa0=;
 b=UPPI1UB9rwLtw18Tr2Ois7RjP7aul6ItBPqIm1eji/VE/Ck9yGPDqp7uFsMLwNUY7i
 G8RMzjEEoKJ4kyqnLse2vKT6EbQccUzSmoJaAT4WuXYfvlTky/u+rv9HhHLBPfRasSe7
 yA1TzkmR5+4sliEb7IGByR6XAvQApAbTTRSblp7Nk0gP3SYGJD+mFEoF5I3r9r31kYKl
 HNhC0D+juW6nGmnRzyQoLJT/PJA7plktUryaJI9/uklIpfmCz0SteBESah5MpWoOo+Gj
 zMOFw3EDjUD3tj/a5s69RpZLTjWNbsNme7i05fI/2SxZRlkMZM+UaeKWTA2ZdZ4sq+s7
 NMeQ==
X-Gm-Message-State: AOJu0YyeePLZBwRgBZ44sSAR6zmO8zPaI4mCc1RgHXRJg7BoML3qHR7O
 8GSN00dx76W7CZyrhjtoKupMYw5JYYz87ZCXnQsRb11T82SznEn3l1OPNAWneiuzma9Sy8/vtsj
 JyIAD+hE=
X-Gm-Gg: Acq92OF+AOKltKXCbxrpz55HRwhKOP5lPKJbSjv/5KAVE05ttOhnS0aUfAXVWTyWXv3
 XmWmJ+t5vk33I2idPb2EpxtVl1+zwE16enmErvjgz2Kk0J8iMUsIBnPocE0v57sonvbrc4IyBtD
 YdJKYZL4B44FC/vUebEJwhf6Fkdp9r1Pw0b1ZVg70XLcO2NzHTmR96QCFeLlEKBOgukSk4Fb1Do
 fNR0uwMMF2xAGwrvCJGg97swQcenKScIMUJNA6DSzTDpaF4xpePRZT0iVbHfUon3WUC2Ay6wDMo
 Sd6CpnnZt+m7SH3M1HtRaUjkahCV3fyJ0hpXIU7/uEfJivEaDpfzN839C5Uj6YAQRQajJ2Rney0
 m60roy4s1tNrSfhan7T/X/MmeNpL5P/miUG9zdbVE31LxhwjgjpJn8CEaI9kbZMjS0GoOtnxWRg
 HPy/VMXIQd2mV/1iko9qMUOANGu85mmxUwrOlhOZOn9m+skL5GVAylMuAnXLwe41LN802hW39s
X-Received: by 2002:a05:600c:1d0d:b0:489:1ff1:74df with SMTP id
 5b1f17b1804b1-48fe5fcdf50mr371960735e9.1.1779305155480; 
 Wed, 20 May 2026 12:25:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d3f99csm19435385e9.6.2026.05.20.12.25.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 12:25:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/33] target/mips: add Octeon LHUX instruction
Date: Wed, 20 May 2026 21:23:24 +0200
Message-ID: <20260520192338.40036-20-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520192338.40036-1-philmd@linaro.org>
References: <20260520192338.40036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

LHUX performs an indexed unsigned halfword load from base + index and
zero-extends the result into rd.

Add the decode entry and reuse the common indexed-load translator with
MO_UW.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20260520172313.23777-12-philmd@linaro.org>
---
 target/mips/tcg/octeon.decode      | 1 +
 target/mips/tcg/octeon_translate.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index efb1a48b38a..8a755075e8e 100644
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
index 451737cda1d..f897b42807b 100644
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
2.53.0



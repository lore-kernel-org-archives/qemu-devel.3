Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F7BC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUR44-0001HY-Ku; Thu, 18 Jul 2024 09:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3l-0007uJ-AW
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:38 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sUR3i-0004Sn-NR
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:20:37 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-52e9b9fb3dcso355547e87.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 06:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721308831; x=1721913631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cAG6/a6hlbAJcA7xle3K3QGG4JF+dWFlZQV04eIRpCY=;
 b=AMTTUvm8pG3gLFeld2bBPH5xJ89aBp0IfHgHL6o7YnfiFsa6npqYqE1CVZ4Ejg9HUq
 tDLK2RWkVrD/WSOr7kgoKZjitXAiiuACijQh/Xocwu/+lApAaudwqgKwL2jD4brTL4oj
 nLdgWLJgUMtRIWtA4P7caWkScr8GBpfPVxVpvqzNeLP46LidX+Himo9o3m/vdRExT+US
 5LCVxYCP6ivkHS1i0omdoklQpU48K60qxPO9gR2cxPuHvZ8c4V3WwzPqIzXZJkEqzjK+
 PWInuLwiCwH2V5ibukU+xtftmIzUx++8XtHYH43NMAmUY7ixedTgtLWi7/rjV7ESs1Ol
 eP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721308831; x=1721913631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cAG6/a6hlbAJcA7xle3K3QGG4JF+dWFlZQV04eIRpCY=;
 b=u/cBPtM2Rvg8ckmBmmYpb4DTUeMtqeR94P6Faw2mp4LK/EMKgYG1WKXOSiczPj5Y7W
 D0x+JEQOxpB5YSwEKlBBvy7ucw49+sXuHHDR5jHb/FmFvMh8eJ3nptIKZpn3ekz5J6wZ
 Y1MehVyxRYvA66Pd2ipgxd1whHIcMXWe78AHyf2LPue5agNv0Bg91h+GsBdBG9KAbLYo
 NOCZ5w2yr1wm6txqIotQifFT2LnA5EngZ075VyAZf8vc3bCLrI80AKErxzj7n9AqRSgZ
 yxrTZxSs25KQKk9UAtsf2ZFquCV1Uy84DTfhPL+PK3Cimrye2EB1qPt5y7LhfuDmlksG
 i6bw==
X-Gm-Message-State: AOJu0Yz2X0/Py6zS52zN93qq2GfgvuHEFVH9BYjXGiAeS8YxfLjtHFat
 hfg2lJhZULVL2zqq2KbJ6FjHz1kYMhuh2hlHHOcmh4A7PGXzz5SCyQYCQb4Q5BumJtLm7zNdr2J
 Z
X-Google-Smtp-Source: AGHT+IHPu7ekE2nyYfgEmF/OkvZpQ8Ph2ltGOjy1OwXyVq5rzjmsNmhfDVtWo2ITL5uXWlV95qzYVQ==
X-Received: by 2002:a05:6512:1281:b0:52b:bf8e:ffea with SMTP id
 2adb3069b0e04-52ee54113d0mr3636635e87.40.1721308830611; 
 Thu, 18 Jul 2024 06:20:30 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a8e420sm14059315e9.35.2024.07.18.06.20.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 06:20:30 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/26] target/arm: Fix handling of LDAPR/STLR with negative
 offset
Date: Thu, 18 Jul 2024 14:20:03 +0100
Message-Id: <20240718132028.697927-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718132028.697927-1-peter.maydell@linaro.org>
References: <20240718132028.697927-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x133.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When we converted the LDAPR/STLR instructions to decodetree we
accidentally introduced a regression where the offset is negative.
The 9-bit immediate field is signed, and the old hand decoder
correctly used sextract32() to get it out of the insn word,
but the ldapr_stlr_i pattern in the decode file used "imm:9"
instead of "imm:s9", so it treated the field as unsigned.

Fix the pattern to treat the field as a signed immediate.

Cc: qemu-stable@nongnu.org
Fixes: 2521b6073b7 ("target/arm: Convert LDAPR/STLR (imm) to decodetree")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2419
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240709134504.3500007-2-peter.maydell@linaro.org
---
 target/arm/tcg/a64.decode | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 2922de700ca..62df4c4ceb4 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -520,7 +520,7 @@ LDAPR           sz:2 111 0 00 1 0 1 11111 1100 00 rn:5 rt:5
 LDRA            11 111 0 00 m:1 . 1 ......... w:1 1 rn:5 rt:5 imm=%ldra_imm
 
 &ldapr_stlr_i   rn rt imm sz sign ext
-@ldapr_stlr_i   .. ...... .. . imm:9 .. rn:5 rt:5 &ldapr_stlr_i
+@ldapr_stlr_i   .. ...... .. . imm:s9 .. rn:5 rt:5 &ldapr_stlr_i
 STLR_i          sz:2 011001 00 0 ......... 00 ..... ..... @ldapr_stlr_i sign=0 ext=0
 LDAPR_i         sz:2 011001 01 0 ......... 00 ..... ..... @ldapr_stlr_i sign=0 ext=0
 LDAPR_i         00 011001 10 0 ......... 00 ..... ..... @ldapr_stlr_i sign=1 ext=0 sz=0
-- 
2.34.1



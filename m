Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A9C0C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 17:11:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6WdW-0005W8-Ai; Tue, 15 Sep 2026 13:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdS-0005SB-3M
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:07:58 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x6WdQ-0003XF-Cv
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 13:07:57 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e69b9e16aso491435e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 10:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789492075; x=1790096875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+bXCjmu21euJUmgHKxj3AplYyvMlR+hu+L+3McdRLpA=;
 b=aKiCBD3oDZBoS+RRc7emuJMep/YDLH7N+qa0XH1lj3QtJ94lXmfnImPGbMXvfx4cE7
 tIGlF/2/bU6UsKVRehgOQ2P2Gx/WlNLks4PkbEiTyVtDisW5y+PNOwBj2nrhV21CXN9X
 5u5hzA3FLUsNRwWcupJREyXNDljwRCK17CBRAEQANbgV8MnPZ/6zSkANNfDJa1Zm39kp
 3b04uuWQMnD9Oc4jouPLzD7+Ftb1FV/3PEUzIK3m4lX4StrsBZvgYuLSekisfbltJ2ih
 JpOHbXVTTHu7fAke5AS3U5QvADg7DF/9vzqgz6goKDtSRWIWdWei6M08cOoteue2+hfD
 zB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789492075; x=1790096875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+bXCjmu21euJUmgHKxj3AplYyvMlR+hu+L+3McdRLpA=;
 b=XwDozNaD79mlybSG+VXguZCiWBkIbphGjDikG/EAb6aOhGJBjfE6p8akFqCEEVFX9g
 lR81syWX9C2YDT7x/jmo60sJLaNGWu1SqOWHMrboBu/Mzkd+dFD/fAOeMxNHEk3wvPX2
 Bnqma1OKrZ7tQ1xOI46/nSSbsA1QM36MIgfENcxFaAZVzYwxbdYB2RwUjSVan19nqSxv
 gxoUOSO/PServWv5u++3BzJai7Pv/Ewu9dLrFKBx9bzfgtsi55oX0zXkrqPHk+/dar8C
 ol+uSGW8mwVN4xrdvsrmX2t1fh2ByxzsDJHEclmLmvUW+6o52Lupl+H6EvYcARzGCgek
 tlDQ==
X-Gm-Message-State: AFuF++maftejvN7P1q5YsHFHiETfPLO5cuhm+dm5KRnvQIrLqXEDTfhG
 Bd15GHSZ1BuK3TO9sfcLeBxOxVrqj42O9Km5H0bDEYgrFsfs7GwN9PxC5ylQ+zAl1tSB+cukrsb
 0JjoSEOI=
X-Gm-Gg: AYBFou0FS4fNTA7DvDGsScP+WDGg/kEddaiwAiRSgBvLFKrl5McNBIlSBTq94qkdzt/
 nyTMGV4rNWIqtyCuJ6yGVUBkiBMPeB54/dBgJSGs98LmHz8aqTR8XENFE/ANIFOZi3UPJ90M8+Q
 YSOqDnz62FVqJdUFY4zWw9qtsE4jc9IA1eueHeA6/rKx2JLtjcjLIbC3UkJNLFMc9PtapFU/xCm
 TvwZClquXrurRVaOAGgqWOq+5fOsyPS/p0t8cO7neQhhPzLF6aAcGnb3A0ZauGaK8qslflEuFeQ
 00VHM9WYogzXVs+OYh6fP6MyYp9sR2cwb2eIiwLLy/iMVUJleIVXNd7Gurb/e1eezAeVLtvPXHh
 KuZnnEdYv3+I2+YsLTBQtMolUm1Y+7VhsxPi0mwU7H2B2RoTvJYB4RvCfWSv2VnEbujjGfqATFM
 X7hOERX6LBpY9qBv8W29DRJNW9pjmYIrmzPRl/7DM4eKnlfC1vgUor7Bl0KgeAEf9qmqu4yoK5t
 QC8dpUmPRTO0TXZjj8pG4b6Wkqnlg8iy8UmxnvnHH7d6DVuqpEgo8zhONXUWuoll0gFejspYgbK
 OQkI5QqjkGAJbJE=
X-Received: by 2002:a05:600c:3b9f:b0:49c:fa21:1c86 with SMTP id
 5b1f17b1804b1-49e7a6933bbmr115547075e9.27.1789492075019; 
 Tue, 15 Sep 2026 10:07:55 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf33e01sm431826f8f.23.2026.09.15.10.07.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 10:07:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/20] target/arm: initialize SCTLR reset value for arm11mpcore
Date: Tue, 15 Sep 2026 18:07:30 +0100
Message-ID: <20260915170735.425445-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915170735.425445-1-peter.maydell@linaro.org>
References: <20260915170735.425445-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: vpyr <vpyr@proton.me>

Initialize reset_sctlr to 0x00054078 in arm11mpcore_initfn.

Previously, the generic reset mechanism initialized SCTLR to zero because
reset_sctlr was not set by the ARM11 MPCore CPU initialization function.
The new value follows the fixed-bit requirements documented in ARM DDI 0360F,
section 3.4.7, Table 3-20:

- Bits [21:16]: 000101, contributing 0x00050000
- Bit [14]: Should Be One / Read As One, contributing 0x00004000
- Bits [6:3]: Should Be One, contributing 0x00000078

V, U, and EE remain clear because their reset values depend on the VINITHI
and CFGEND configuration signals.

After rebuilding, the test read SCTLR as 0x00054078 instead of zero, and the
0x00050078 mask check passed.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4454
Signed-off-by: Felipe Junger <vpyr@vpyr.dev>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/cpu32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index f292a269bf2..1999e502904 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -218,6 +218,7 @@ static void arm11mpcore_initfn(Object *obj)
     cpu->isar.mvfr0 = 0x11111111;
     cpu->isar.mvfr1 = 0x00000000;
     cpu->ctr = 0x1d192992; /* 32K icache 32K dcache */
+    cpu->reset_sctlr = 0x00054078;
     SET_IDREG(isar, ID_PFR0, 0x111);
     SET_IDREG(isar, ID_PFR1, 0x1);
     SET_IDREG(isar, ID_DFR0, 0);
-- 
2.43.0



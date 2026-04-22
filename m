Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D81F9EDC7
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 12:55:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFX5e-0006YV-0x; Wed, 22 Apr 2026 08:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFX4r-00065w-1M
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 08:53:13 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFX4l-0005Wo-LX
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 08:53:10 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-483487335c2so53946615e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 05:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776862386; x=1777467186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rop61lo3CsCy/AA+flQ6RjC7mnHYxt45F3om3vFlXxk=;
 b=WisRWG2jEcHb9a2Hb+Xmgtr6O3txfV5Ti+TO/q9XTzOWgZRHIEz6gqwAwHTc90/H0N
 vtGPBpe7vo0KLlFxlcvft8GukwF0xiMGkKiapcGKHByZRWJG9s5X3zHBUOz1yVUTZCkb
 m2gjvIHILjOBaUDRCT0SzvxdS4kEGN4dm4C97IEVF6SkD3Foz3CPj4XXxFtjMKQEXVkv
 e45lr9VeOLrF30OxhyIK6VMnkBbwc86lSOEIV8fvbb5YIBcFo114vPSFBuOqMy6kL0x6
 CcWBcGV8fEG00rKu/Aqw2aP5b9NY7d57n3gNUsUo5bDj2AhNvhvpza0Dw036YgeHGKk7
 JXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776862386; x=1777467186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rop61lo3CsCy/AA+flQ6RjC7mnHYxt45F3om3vFlXxk=;
 b=mn0Ddelhmxl90P7kP3I2UHKgU6iZvTqi7rn9lY8DtrGI0djhNgs982wzN15j8F3VR1
 YdTHeVv18KKT+QgupZXiiWDFi7DM/J/DCsHXsRgKQTJo1xc7uvPN+TEbNTozQD8LtDIl
 wNjb1YsLbduVMoKotgIdgenyCPgUmyI/tjoGCyaLK+fpXpSEs6MO84cV5902GJ9yO54R
 0N0HMrOXpxWN0xVsOb0gKYqOBQB3sIFq96qd6vQ7nroZlufcZrx6CMfC8o3dgXGsnfVl
 wwzYCJkXfbB12P4gsPoHjE+XlSJKTIAzuNALmgw7Iu/85xJdz0x36HELricATeIecpAH
 B1zQ==
X-Gm-Message-State: AOJu0YznnyASIk2I+EjlI6WlfbPxMv1248A9ynn0j/IL7NyIAgUuN7eM
 P+5n3mOOlOrGYHDLR6QNSQX/q3XHvhf05h0wdiQVStOcajTxo8NjJRLxKn7AP7/HNY8=
X-Gm-Gg: AeBDietiZVRg9txMBPelR4XfKa28T5/e/yyVrsmXopRistFzVmhZM6UI+Ruyc2SwLz5
 Fjo5c447B08Hg+9Fz6RG/Mue/lBRV2q+hvyZD5PV0En0YhuCmEJuABRkxDiVPMZfMRqratlRSBK
 j422m97ozXr0KUcKjZgMS8lj9R7ZHrHOUMHzIzGd1KD1FdvM2xPaSY+05WQ0pTeuPsAMKnilvQV
 G9Ho9146MuXOFr60LC9/r0uXAXMA9Egx/z65TQiG6oQvZzLxsGk6z5OJOIvRwp0OeWYdF7A0JPz
 Ywb7bSQqF2IA6PXYhN4rkWaoT8A1EKJEkXygq+x990yxgYRNAdW5pBnDbd31gwTRxsOFlg8py3I
 wN5n9BLKkKQxFGjywdbQXBh/pBu6n26UEPLa3tx4JtkOguTIXCGQ2omHhyFDduH2687kL6DdnPN
 NFg3Lx7q9lInbCjga6wyOsEV8TpwJCIFvP5A==
X-Received: by 2002:a05:600c:19d3:b0:489:1ae1:4eb9 with SMTP id
 5b1f17b1804b1-4891ae14f23mr179317695e9.28.1776862386147; 
 Wed, 22 Apr 2026 05:53:06 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a52583fe7sm162310925e9.13.2026.04.22.05.52.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 05:53:02 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8B960612AD;
 Wed, 22 Apr 2026 13:52:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 20/32] target/arm: use syndrome helpers in
 merge_syn_data_abort
Date: Wed, 22 Apr 2026 13:52:37 +0100
Message-ID: <20260422125250.1303100-21-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422125250.1303100-1-alex.bennee@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

One more step to removing the old defines.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/tcg/tlb_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 565954269f9..c74d8e785a6 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -56,7 +56,7 @@ static inline uint64_t merge_syn_data_abort(uint32_t template_syn,
          */
         assert(!fi->stage2);
         syn = syn_data_abort_vncr(fi->ea, is_write, fsc);
-    } else if (!(template_syn & ARM_EL_ISV) || target_el != 2
+    } else if (!FIELD_EX32(template_syn, DABORT_ISS, ISV) || target_el != 2
         || fi->s1ptw || !fi->stage2) {
         syn = syn_data_abort_no_iss(same_el, 0,
                                     fi->ea, 0, fi->s1ptw, is_write, fsc);
-- 
2.47.3



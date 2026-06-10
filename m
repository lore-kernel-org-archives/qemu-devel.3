Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F3FCD98CE
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:18:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLXz-0000Lz-Mc; Wed, 10 Jun 2026 12:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXu-0008Ht-Hl
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:50 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXs-0005bE-Vu
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:50 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-45ef4223be7so3860293f8f.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107967; x=1781712767; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z84GzXxQ7U2GULN3oFy8cILUf1DiwIBW7XhtGdCfcHw=;
 b=LO82+gv2fKY2CXm4UD6ayfElHOO8AnKUVnqVisuyS2yJrQ5CTwqnwERsAM7LsMtzpa
 rku0PfgcNAjMM68eE00a9qhid0Qjv0hCHm6fwEqFhibIK9QPC1+1lGqqhJAI647QCZU2
 jls1sGJDYICImZia26d8WhkD8dBd3qbq6FRDljEvfchCBFRFlVK4k0e9gRdvlDGIPko6
 UrHHOvsGNni2MfHNXW8IDaA8qyxzlwmWDb8S8IZM6Yab+NwTBBk5GlR2mH55n8dL7tqR
 mtS06dq0oXXj03DwqzlzB7S6AVW/v4tfPuCD3ur3NuMtIM3YyHWEeBD266lBK90F9IDT
 CTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107967; x=1781712767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Z84GzXxQ7U2GULN3oFy8cILUf1DiwIBW7XhtGdCfcHw=;
 b=dpNhGr4bwvVCmwYOH+hLdBhFVwhdcFDaOkJ9HnfJ14ymIxpI/OWNMXdJuyF0IagUZ1
 9PhT7cDnQXaPrQEcQBuvkVl4E9m73ArlrVg5EEKDUtK/cwCyjhone/aeDLLUu/AemIK4
 J1KQVOSuLDXD2ol5ott0aO2czjpxOVITDPsNFJweFFWxdvC2uryXaZM59LX1IF5hBfB0
 Jwo0kdsP1rpidOH5IPiB7/NuBmDR/9iLQ/9HAk+6p8fSt06RSUiJIVcNuVbMAqlP7hOI
 Y9itQQwrzoilTPFCMOCfVIKyJ2H+fL/XnQ5zLNeOSD9M3CcTCoXtaA0J1Roouwc523gt
 ybZA==
X-Gm-Message-State: AOJu0YzXobuZzTx51zQV3e57FA0FDyD4hbwERwe7OuCsSnDiOvUObT9L
 E30bDsuBS1gcgA3c6d+QNVA2p0nQWIRzgRj98B2F6KF+KH1pIqx67TBhVtRMsj/CsozZVUKMYgQ
 2XKhM
X-Gm-Gg: Acq92OHN1j69/sc6hQY2Tw/b453QGKJ1R+DrHaweZqAkFyKhMe5VYdnpV6AcSJ55E9a
 72tDjI8DLlXNZ/oH677O6EpHowgZWqez3NlSmyyxdyZRFDuD5sEFhGWzRh5vHR+6oQjzYedeZea
 Vn58dFzrpn9Fa2LDJMgkAjb4+UcIi6CVAJ1MEXZ85zQqyQJ0h/Ey7Ki1GdjhBFn4KZKLFrzRmag
 Eo3uDl2FVZhaNVxHsYXNhHZIbqiltLo2pjcID675CJEUo5UGH/XpXU3Oi3Jjrs9Mqc2S98L3LBC
 Lx7WIl+qSfyYMTdeYMpFJy5NEGqbWG/LsTR4VD7d/mtbZhubrHdeaadp/qIE4vea1KzdasR2rF5
 Ud6ffBKqMdZcry1SBoKfyraGUhpkxoWuWCXoWX/JfAitbVWNDSo5xyhq6Bz+5rKBULhGWA4382C
 0EDwiHjVr0zVrOWYr443CQNgTUptrgBgc3iiwAM0RheMWn267Omo8WoCaA8EHP9bH6aBGAfT+V9
 HlZq3Blvll5Cz1q0niTeOfSalfctztkw3BjE1AetAg=
X-Received: by 2002:a05:6000:2504:b0:460:3b5d:43b6 with SMTP id
 ffacd0b85a97d-460566c97f1mr11745637f8f.31.1781107967425; 
 Wed, 10 Jun 2026 09:12:47 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/71] target/arm: Set e4m3_nan_is_snan
Date: Wed, 10 Jun 2026 17:11:23 +0100
Message-ID: <20260610161202.2235298-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

The unique e4m3 nan encoding is SNaN for Arm.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260609192110.752384-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 10daca0ad6..419e0b3ed4 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -326,6 +326,7 @@ static void arm_init_fp_status(float_status *s)
 {
     memset(s, 0, sizeof(*s));
     arm_set_default_fp_behaviours(s);
+    set_float_e4m3_nan_is_snan(true, s);
     /* We want 0 for all other settings. */
 }
 
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734CFF8A14B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDIrp-0006ED-8u; Thu, 16 Apr 2026 05:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqj-0005JL-AG
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:36 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDIqg-0007qe-76
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 05:17:23 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48897fd88ebso78404855e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 02:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776331041; x=1776935841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JuPO4uFBl65kDGkG1gjbDe4+0gSW2d4Gf2OZu/Qakf8=;
 b=aP1S/dAAEyKLc+ugYdN/tMVXaLGQM7pFbbZyfy3wbfTMLc8KZG178HGBVRvNrBL9Eu
 btNnuP8Ez1XkYvYDrnsOxnhzAVqPQqPzyGTE2IDRL0dnL5ySHJgCo5D+gXk9w9l8gMYd
 0S9qhqmPssc29uz/ew3gf4zY7aok4RGhj5yeg8e53eZela8OGkkxogz5a3L6RoBA9dBl
 GYzk71xHNLOjvW6a7PN8p3UvluBx1FWiVNbQ9XvbjgUT0FHxtsXARSVMK3q2kYa8V5S6
 KJjYZ/MiwXN+gc9EfgVOGw5FTTdGS2+EVbd/7cROWCZrRAUJx+8ReD1ZejOM6Z5aSf0/
 mfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776331041; x=1776935841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JuPO4uFBl65kDGkG1gjbDe4+0gSW2d4Gf2OZu/Qakf8=;
 b=F+xfFEfXjEXTpCqjM8/buA9i4CHicRbe/VwHRqGI0uL56cBwPg8aMrNME1edvJ7JaE
 XDCC40wSsllpVGP8pEs1AHohaDa2Ep1j2hjqhzAa+AMCheXtNH72T3aN09hxQdayOeI0
 YPp0vm97I0Myixh68EtU9Y64liU0l7+sKTBAsTKzo8A3Hs0ewaAf+jbTsPwfABspxkFY
 NtZFqfdvCk/X4NcBULEkCIHc46Dmep5bICm5A3P4NvcBkSqX0PW+cdFhVMFL/7n3Vs4f
 3o+AukI8P7C8e9N/+l1QBT+DOX+nmQvkcPdRkj76fOmxfmZyBojBsTjDEpb2PEGuURDf
 b1bQ==
X-Gm-Message-State: AOJu0YwnWRO2y6w9i947metTcf+s3BbNVo40eAqrijki9F8l1hSyoS3H
 c3qxJof09L8xx1NwPayy5lnkX93C02j6CRm7cJH77iYOqP8jfVUZOmZEVw+WxRn/jZxnWX9CqT6
 D/d/VGng=
X-Gm-Gg: AeBDieudUGGyEXpQ2R3zUexTgpjdWZYIPBzgG9cgQCwiAefG8Osm4wZBgbhRyqMecZv
 Om+l/tS8ux/LRG2ikPfdaZpwQ2MMqDpZytzS5LiTKWdFIty7PGC0KWSMSv8P2vzpgyLd/nvuee5
 I56kFIU7NzC3WrwMYgM6pYrig80/+jxv39HVvJPsQWYNMM3EeXI5oB+xBeE4eJstYRguH6dy0tH
 tq0e7udkK0IecPnyLsXx3yFXoxV4/a0i3XEdmuu5ZlpujXfH3FZStvWOeG2mG59BHT4rQJOOrH1
 hXkSVQv8jrkl3ympYMwwbeaEvocwtdOFzWQY1KRGYhaZluYRMpV0ANOtTGBFoJg6L9BjnkJXPyn
 N+ElQZng8YPRFmfzOI6/+01rHwoHB5nt8EL2blXhBzqcQboYMmml+vlX2Vfh1MSrcilQEwIi5dB
 qaapc9rYBVEAVzEDOAVF1G+cVUclOqGpCqXjgl1d/wE78nxNiTrGBJiw6ABWhZLJ3Z/LtpixN/n
 Nz9kOyH5fCmUlGjd+cZNheoaO1lEf/W1jX/tT5gdNsiDaIzzmb3
X-Received: by 2002:a05:600c:c108:b0:487:12c:e7e1 with SMTP id
 5b1f17b1804b1-488d68539e3mr237705015e9.11.1776331040753; 
 Thu, 16 Apr 2026 02:17:20 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5818da1sm37186565e9.6.2026.04.16.02.17.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:17:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 24/28] MAINTAINERS: Remove Vijai Kumar K
Date: Thu, 16 Apr 2026 10:16:50 +0100
Message-ID: <20260416091654.316158-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416091654.316158-1-peter.maydell@linaro.org>
References: <20260416091654.316158-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Vijai Kumar K has not posted to qemu-devel in some years and did not
respond to a query about whether they still wished to be listed in
our MAINTAINERS file.  Remove them, on the assumption that they are
no longer active in QEMU.

This makes the Shakti C class RISC-V SoC orphan.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ef51955e0..043d26b0c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1732,9 +1732,8 @@ F: include/hw/misc/mchp_pfsoc_ioscb.h
 F: include/hw/misc/mchp_pfsoc_sysreg.h
 
 Shakti C class SoC
-M: Vijai Kumar K <vijai@behindbytes.com>
 L: qemu-riscv@nongnu.org
-S: Supported
+S: Orphan
 F: docs/system/riscv/shakti-c.rst
 F: hw/riscv/shakti_c.c
 F: hw/char/shakti_uart.c
-- 
2.43.0



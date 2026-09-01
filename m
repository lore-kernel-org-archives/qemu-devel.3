Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 106A0C624D4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:24:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ON1-0000wx-2d; Tue, 01 Sep 2026 09:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1OMy-0000w5-8I
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:44 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1OMw-00077o-Mk
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:17:43 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6a0c8283146so390767a12.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788268661; x=1788873461; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M0YLelMvdPY0PFJ+LIacPHO7n6wFdYWwaSVpnDcAu9k=;
 b=Gbv0OCx1xz3ZIG1zOo0lgIyhzvM3YQt5XeLW5NHZz7QAZh3oHT3kN7RCbUxAztLPCy
 h7rhwaeSONw9EaEv9NNhAP20O343F+C5v3GT2SLRuXl7+5kXbdbgdZwdMIBk3zE7EQ7S
 bdaWoZh7iIQPIcBqChCwKs1Kra1EZT0O8jKPY8CWXIYOkvOZR/oZJiS5paul2hE7Mgl+
 jsPXPFXechA5SYleZr9jnSUvqmSyBy9BN/5Ww8LQkQv6kqEcM1DSdORXgDnPf5JtQu2y
 Z6kUxUuX4KA7XZ4d1/M/2LvAAAQv0VEsvh4LdKiC6zaF89WxzDPTWz/nYyd1AvrsiMZ1
 7giw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788268661; x=1788873461;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M0YLelMvdPY0PFJ+LIacPHO7n6wFdYWwaSVpnDcAu9k=;
 b=rS4Yy+SaSJuzepkOJ3M1vzxwmzCo7arTzNow9bEchIt24LY0B2lIbyDQjFDRKOpyei
 gWHtknytIePbVhnr1dR2/anssJbwFr7kjj3DuPrcrLb10ysJA6eXwms6TS+fuUdMdl9l
 f85TU567q3PRsp60uAqn8HGF+EhoqshaBTJyBzaCagArIMEoW4r+qKSZxpbsCa9kzMH/
 ItkKCGe70Zml5yo0+5Oo6rWeRVaTYEoC6kziDguGecAl7VazazGSDoRPWQLmbYJ8cKDO
 90+uxltJEPpxqwUcpejWAUHwFg2cnXv1esMKMMj9x9UJYbuW1KREgWLcsh6Balru4Wc7
 OCzw==
X-Gm-Message-State: AFuF++l01liIvYPgVOdu1dDsGXbNqXr4UhwnydxX9/Uk9QcugZSyM8i1
 6+Wn9uy+xj4NqKF6G2SgRZgwpV3ciV/joOx1552b+u/n6RcyHTWbi7VgWcTMqnlalskcDjPhPUS
 pocXiBTE=
X-Gm-Gg: AR+sD11UMMWSILIDj+JSiku0q65TJ7YHInZI1jBv1E8uHCkXJ1qrxfJiqLMq2mKyCUa
 vkKd8oRs41NBtv/rPPV/cWToKwPkVjdwZGWdyGlyh319hJbJnHTFdu0/GA7lICZuyjKE5vGWDna
 aOoDPeL05dKZvUxqBrj/pDLFnbIc9xDkoYrs46hfFqK9eiJ5umjSC0bVNSEIYT4CIqga2aSWMxq
 NCzHflAGZHbvdmD6Fc7dGhW1pEZEiRLaRwy2uQytcgrNb2XjocS6e9R+wzSYXI+Tbv81dUJCtKg
 gd2G/oEJ0AA3TNGrl+EMH5uoTD2Uy8q+H3H3IYRphycl8nY6bBngyLLiPf7t6LgU0juaSZAwtZL
 lAuwwvPJKmV2j1KJKPnn8qCmjNwZZejQHZxdjWBkv6LJvyAHtJh2+UWYYwn1RjjRQB+rqPA47IQ
 5hcnqu3/AHuLZb38SLIvi6VWQNzovNuMAsVFhcB1XuFH3cB4/4/NK1UtKOFiO033yfY33wB9Bh7
 bi/whZN97uEBl4pI4GVRbmixzOza3F8H0TJPekjPSBaU2GHpkHhop9++EelTQnQRU5oTMowg+oe
 752J
X-Received: by 2002:a17:907:1992:b0:c25:4da2:1eb5 with SMTP id
 a640c23a62f3a-c25b3c9ab25mr651906366b.13.1788268660666; 
 Tue, 01 Sep 2026 06:17:40 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee2853dsm617907466b.18.2026.09.01.06.17.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:17:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/58] hw/arm: Remove spurious WM8750 dependency from Realview
 Kconfig
Date: Tue,  1 Sep 2026 14:16:40 +0100
Message-ID: <20260901131732.2263947-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901131732.2263947-1-peter.maydell@linaro.org>
References: <20260901131732.2263947-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

The REALVIEW Kconfig stanza has a "select WM8750"; however the board
itself doesn't actually use this i2c audio device: its audio is
provided by the pl041 (which connects to an LM4549). Remove the
spurious dependency.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Acked-by: Jan Kiszka <jan.kiszka@web.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260819185430.3467629-3-peter.maydell@linaro.org
---
 hw/arm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 260d2f07516..5e9a0bd8dc6 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -155,7 +155,6 @@ config REALVIEW
     select ARM11MPCORE
     select ARM_TIMER
     select VERSATILE_PCI
-    select WM8750 # audio codec
     select LSI_SCSI_PCI
     select PCI
     select PL011 # UART
-- 
2.43.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F2710F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYPH-0000hX-Ty; Wed, 08 Apr 2026 15:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAYMS-0006Al-HS
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:14:48 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAESR-0005W9-BO
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 17:59:40 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso49972705e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 14:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775599177; x=1776203977; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p3wWXjzOY7eN/MkISFSo7wNwF1Jd1biTE5Rgyb00uNY=;
 b=YeEOLNmjwb5+xljjaAVvTY6ndzJY05gOlaJkp7gw/jop3UD9CWSX2qM2B3i7kv7Jqj
 YTUR1r/t5Du0zbshnqR2CiChresq06epkL0HOIUdc1G4zyC/T7qP2ccxTawLwKwrmpSW
 dv9+i9XEs76MOSRjmj1xKwr9KSoKgGfr0YjL1VWU1yMhitYf7aPRoSLkU8vTo5jPDAGr
 lg0JSqb0xdZLTCWraHIC9lIGEx7PzzljegxGTaMnuujTYx6gVCekgwihrvB+H1M12y5Z
 0HhWkObtRPno62sYpylzodjzw6uX7a+xdpzvsaFWgmjaQ7iHa9tZSQ9vAwSdNGaKtFAx
 8Gjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775599177; x=1776203977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p3wWXjzOY7eN/MkISFSo7wNwF1Jd1biTE5Rgyb00uNY=;
 b=pnu7dD54yjjGGgqvYzS9SIlAMpGORbxTxFa0fAZaXtN1S5BJRMidb2+EuStn3lwQjE
 thi1F1BPU17ZHD1kdWHDH20hQsMq/DOt8THZ6QXCOnE0S7LifdJU6XKNJdHS9/o1FvZd
 xjgpbuI3m0/NISjNW02aBGeWri3mJyUZ0NByHuSSWy/LFcNbTpYHxaLxY4mB/h7JxTMd
 jU5mEMyjZrgJ8CHcZ9wLgMOdVhKpXLywnF1fmRzvQzj6ixGW9pwOyAJIyiLGkAyDuKjH
 mhhjfZdZnNFHS0NBYx3Z8oWEUbTwwqvaLUyAa1edyAM7tnMFshPomuaDpXoDmYci4Ltw
 yI7g==
X-Gm-Message-State: AOJu0Yy+8Xga7xV9IR50KqJtZPd8fXsLPEIjp88Z5MA3N0+RcUP0Zs4f
 usiujU7OTy/w7UPFA+IoXeCxLHHdibkxXShyu4ptcFV/O833ZzzeLP+QSbBaNWod4yYBg3/JUX5
 wofwrjKs=
X-Gm-Gg: AeBDietAZd9/9+A4S14bDyVlffVym42i/65RVcoE31aS55vcKS8mG9I1ZzyZC/o/EFJ
 DwnTq2UBKj8o7BkXx4opOSL5hme1KgZ6ZyV92aEuxyiPtCI3lR314GeH6oKKinyt273D+qi+btT
 r4rIJkz9speuxiSXMzqhBTUNKOz0dmtXCpBYUHfRHQ1SuVniRhgKoP7nvZSoz7zAXr/IqdRb23C
 vfeVSJjDrUZwdBvmyeBy3Cwq1ve1S3Q5JQD+EgipHuDtCYWtaBbnFOLOCrizb5cZFSlx7Y5seL/
 p7woNAAN9QuIY4/CHS+Iw+AeDAD6Sh6knCi4igMslSzopUXy9lZr0+MS+rRVC+S6tXuuejMS6A1
 9sJJiyFLYR3F4XZbveekmfGFhuqhhvW2k+R/BcNoTFkZzfbIqo0bpU23hCJcZRR8OJV3pigcR0K
 LyuTGbF3nRCcAPjZhDHgbL33+3uRHUcj+R1t7ngBf18YwKbQC2HOq0HaINecTlPXkOExFILQFZ8
 oLE9P12oUw=
X-Received: by 2002:a05:600c:8b54:b0:488:869c:edaa with SMTP id
 5b1f17b1804b1-488996d9cdcmr282324695e9.7.1775599177517; 
 Tue, 07 Apr 2026 14:59:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e822227sm659497595e9.4.2026.04.07.14.59.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Apr 2026 14:59:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Fabiano Rosas <farosas@suse.de>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH-for-11.0 5/6] ati-vga: Update mode on CRTC_PITCH change
Date: Tue,  7 Apr 2026 23:58:59 +0200
Message-ID: <20260407215900.63390-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407215900.63390-1-philmd@linaro.org>
References: <20260407215900.63390-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

When changing line length we need to update display parameters so call
mode change when changing CRTC_PITCH if the value has changed.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Chad Jablonski <chad@jablonski.xyz>
Message-ID: <3f54ff54a873a8f8a0cc5f14660703b4025a69e2.1775228029.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index a283afbfff5..7bb57c44d95 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -743,7 +743,11 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         s->regs.crtc_offset_cntl = data; /* FIXME */
         break;
     case CRTC_PITCH:
-        s->regs.crtc_pitch = data & 0x07ff07ff;
+        data &= 0x07ff07ff;
+        if (s->regs.crtc_pitch != data) {
+            s->regs.crtc_pitch = data;
+            ati_vga_switch_mode(s);
+        }
         break;
     case 0xf00 ... 0xfff:
         /* read-only copy of PCI config space so ignore writes */
-- 
2.53.0



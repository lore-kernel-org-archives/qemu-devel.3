Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2340CD3446
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 19:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL4iB-0002vX-LW; Thu, 07 May 2026 15:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL4hZ-0002mS-0J
 for qemu-devel@nongnu.org; Thu, 07 May 2026 15:48:09 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL4hU-00069U-Tl
 for qemu-devel@nongnu.org; Thu, 07 May 2026 15:48:03 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso12312295e9.2
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 12:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778183255; x=1778788055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ELnoXPwV7hchkGAh18z/4PAMA/A/fUY2drl+3JQwIO0=;
 b=aMrq35HEiIj54TmQk4g94oWVjV38DAZ5o954aymSjGyGkHH8tWenY5ozc7p4iynbDA
 RJbSfHZfZJL89VPtxGgAIuVQAYuT1uRiP027fCKFO6Yerg6e0gmeSHd3BFFZNafgih0d
 tomHByFCCRGIoRJ76o/M7Rbc0nnu0oSIA2ix7UGlNUqcgvaSlqrCoTe/cbmqDVHSeyPn
 3jlBvkNEeHT1MaBqrd0ZE/uXbIaxwvdOd4f/5G0Vx4O5isqn+eLShdEV3VHaZMq9tfzc
 1pXDgdyjzifCvb2cu5V3t6V9uwJti9dNpfYIE2Klr/fKZ4IN0bFb62z/J94ChIau8xNt
 8F4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778183255; x=1778788055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ELnoXPwV7hchkGAh18z/4PAMA/A/fUY2drl+3JQwIO0=;
 b=hhItHgAk3DtgZI9R+vmF9Y2VU2ZCufbd0Ivv9Zba6nKBun+ZcMzfaYoKx25Eb4Th5S
 34IgL3WLOeOx3LGalhAcdUZMWBeB+ql5V5afJLmFGL+16tiuBzAt9fSH/sjMZBM1E4aG
 7fqkU2AAWi/bjE+DxxI7HqIDr/BvTYEDA8e1yr5hIhXm4I4oy/UJ4y+GFHK5dT3+DGEQ
 sRYgObX/2/zg4WV/6gSzWhcyXOgtm1fjUzpn0zg5tSUP0orJza/QfXLaBJzmGYKvHgCN
 0notwnIhWSpNk7nYb7w6Da7yy4gitFzBIBjlqVl0vlzk7FRQIDVJiQoFQFzLdlbA2iya
 32NA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+/xXTPMpwhcXnlWZObVJYwDOrhpz3QadphyOBpSjxsU/jHB5+OlHvVZW4MayrARaghwD/imLfjEQen@nongnu.org
X-Gm-Message-State: AOJu0YwWyBtoz3NFYY/rrBO6zt59W40IXNVW9k/a4d/Z1V76Nwn4HQm0
 3nka4nMM5gfHcybAWEJyiOVbu4z8wCQHOM3qnJTpYzNWj4787YO0MNASoZ7RhqYmxKs=
X-Gm-Gg: AeBDies4DdSehwtAH0Mu3D4a1hsLm9vHyho3ZPdrGMb5Xx4JxJ6XlAxCCwntDaMf+8F
 LByZ/SRrR5bxSCNtzh387gh5X62hwDVmtf15WkkRRggaahvEoXUvtG7yXzY2e9753VlwrBSiCg2
 DDQAYro/WgdMUVuq4+65i5mq70SWTcOc57xDg7nmfHLd1V7IGYgWe1tbYIQ8pKvwqE9JzZedAiC
 +bydcjb3hgDswst6iKsCFwaW40LGfkQlXHWzRLPUgeLBwZ1Zv/arOijnOXPgTwFngEdQxQiEoLb
 93uJYnKKoQx0KVQ9cJQ8Jic/Sdt8bMWtolWhjvfANf1suHXZs8VeOqgKGTUAN/fm+XgHetuqH/L
 r3JQNZJv/rtVJ94IgG1pqHu0V7O4uLGvbrPuQRbMI55gA9EmEGvC5sN45ClYuZp5GFGTkdUG6HK
 Lo5u12nMWL9QRzGI+vhqy+fib9DpYdTG/fFSYI/GU8UUWdf2ngN26ZNGLzqb3NCHjTwUZqrHv+9
 Wah1MgX1DU66uPQ3mLbSwmEHguexa92y51aKStbz2VUpaD+E0Qn
X-Received: by 2002:a05:600c:3e8d:b0:48a:6268:18a9 with SMTP id
 5b1f17b1804b1-48e51f32797mr161698175e9.13.1778183254836; 
 Thu, 07 May 2026 12:47:34 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e65c145aasm958375e9.25.2026.05.07.12.47.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 12:47:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 3/6] tests/functional/test_kvm.py: Use -cpu max, not cortex-a72
Date: Thu,  7 May 2026 20:47:25 +0100
Message-ID: <20260507194728.2034696-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507194728.2034696-1-peter.maydell@linaro.org>
References: <20260507194728.2034696-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The test_kvm test claims to run on any accelerator supporting
nested virtualization, but it specifies the cortex-a72 CPU.
This doesn't exist for KVM-only builds. Use max instead.

This fixes a failure like
  Output: qemu-system-aarch64: unable to find CPU model 'cortex-a72'

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/functional/aarch64/test_kvm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/functional/aarch64/test_kvm.py b/tests/functional/aarch64/test_kvm.py
index 7545f5ed55..fed18aba60 100755
--- a/tests/functional/aarch64/test_kvm.py
+++ b/tests/functional/aarch64/test_kvm.py
@@ -38,7 +38,7 @@ def _launch_guest(self, kvm_mode="nvhe"):
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
                                f"console=ttyAMA0 kvm-arm.mode={kvm_mode}")
 
-        self.vm.add_args("-cpu", "cortex-a72")
+        self.vm.add_args("-cpu", "max")
         self.vm.add_args("-machine", "virt,gic-version=3,virtualization=on",
                          '-kernel', kernel_path,
                          '-append', kernel_command_line)
-- 
2.43.0



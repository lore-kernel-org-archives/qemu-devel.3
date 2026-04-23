Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30880F589DA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 13:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFuSU-0000gQ-Ur; Thu, 23 Apr 2026 09:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFuSN-0000dy-CG
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:51:04 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFuSK-0005Xq-0G
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 09:51:02 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43eada6d900so6540680f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 06:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776952257; x=1777557057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2wxBEBB/EqofxzUMFpni53mEDOf2aR/ncAD/U+J6XFw=;
 b=ORgOHcbst7zoaD9WrYxQ1dvDUsBBU+3qNaurDepoGKrG/BTZFq3AncDOodcOHQCpdn
 iyTwCjUz5wUQ1w4Xc3BmB7tI4z7k/jrvpulHcbMyVick1qUJ/f3zqXNmLnPkXeQ1aUZZ
 X6Cr6OeDsDdvS/nN4BDD9xqOU77i4nRcoS+KoXMfgYKOi9BXI/9iZwTSSkxmkhY5KTzl
 e7tlIDh2JM/9Q7WNmHR8R18IDjTU45IFORLUpj3QRrg0NlKk8ND2HwbvpO38dnDqdl1e
 i3SCf2LkzBF4uthmr/5RX9TheRPDsmeBVV3EcAiMEZRxw5Q1TxCTSDKj9VPxOuREBEHg
 ZgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776952257; x=1777557057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2wxBEBB/EqofxzUMFpni53mEDOf2aR/ncAD/U+J6XFw=;
 b=JXu5uUhCYzcADsWC+YZP2SfyMjvQLwz5/CcHUNKjBofsDPmKNpD2hwC4kOPqwB16Po
 /2Tty4t7QQespK1RdecwhCENxdM5On3GEEmggkZYfr2GrsNIHR98eZG+OXqJn4Xb06AH
 +W5uzeJmODfHFz77dYhHBB+sFVjAU5K6YQkBqfOqaS2SY11lfV6B/RLK0wrKwnKkkXzI
 u/ZlrMf5Co3MZ/h9ZbA8gpdv6lI+6b79PNERy/I9E6gTwrWPSVk7Zqnd7JgPqMOIOxG1
 Aweg5pwyIiHgNCZFMCNgHT/eqJIrlcdRTTWM6hu5GSH+VUucvxKES0Pl1x9rgHNrTcrH
 mVeQ==
X-Gm-Message-State: AOJu0Yz17UFMz+1SBr+AEEkhbhe0HJR2mKnCpcCsZATQlCUiRomsicUP
 Db7PLLwr5t6kRQqaxpxjiHfLvco0pi0rsOgv7/DjgMk6pMaUUB9ucYmfnv67EbQlU1zV9RB8pWB
 08mPtct0=
X-Gm-Gg: AeBDietPMcQ5D85KJUwrYideajaklPOQhdHUwZgJVjvQdB+LMX/GXxM6lyKlCL2rnBU
 k0a0PKiD8yciY1VYqWe76VdLrUDNxQV+LNb+O1yd19Dc6FIwWJ1LoeB7RUZw62f0wiVTSBB2kww
 AJ76BIrfyH8mKOqkuoHSkFZyVfWilCNCSsLaY4zzzqadUKDhglPlCuMExF5Gew2ZxyyN0YMJIEg
 l8I2p86ith4ELuj+LmSqZL6SjhB8WVzrO1NskpGGfS81BT6A4MJfanw96gs5yc8bBKxucBDUbxK
 QHp/rVXs8vAXLNtCMzDhWSQjL54MDN9LSlEuweFrXvLLtujzpP3EcgVqRXCY/TdvTzgwM5rU3+L
 ZQ9wahU6Rr0cgIWAuR834jjZ2Q+ouQgf59Dmc90MfHVpwkod9Lvj68RRI7oIalWD6gq8BSoMq9o
 AyzbDbYxWPe6smhL2Ju6AiPURSWxCrTfX5/JEXKQtAtiLW0msuEzl09ldCQHebvbOsUmovtOY0p
 De7pNzebcs=
X-Received: by 2002:a05:6000:610:b0:43d:4df5:3de with SMTP id
 ffacd0b85a97d-43fe3e0b5fbmr42130174f8f.31.1776952256845; 
 Thu, 23 Apr 2026 06:50:56 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4412150a092sm19035292f8f.23.2026.04.23.06.50.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Apr 2026 06:50:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/9] target/s390x: Do not compile KVM stubs for linux-user
 binary
Date: Thu, 23 Apr 2026 15:50:28 +0200
Message-ID: <20260423135035.50126-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423135035.50126-1-philmd@linaro.org>
References: <20260423135035.50126-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

None of these KVM symbols should be used in the qemu-s390x
linux-user binary. Do not build the stub there, prefer a
real linker failure.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/kvm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/s390x/kvm/meson.build b/target/s390x/kvm/meson.build
index 588a9aa737e..437e12f221f 100644
--- a/target/s390x/kvm/meson.build
+++ b/target/s390x/kvm/meson.build
@@ -1,5 +1,5 @@
 
-s390x_ss.add(when: 'CONFIG_KVM', if_true: files(
+s390x_system_ss.add(when: 'CONFIG_KVM', if_true: files(
   'pv.c',
   'kvm.c',
   'stsi-topology.c'
-- 
2.53.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8645AC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 15:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpqqZ-0008GU-4Q; Wed, 05 Mar 2025 10:39:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqqR-0008FF-N6
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:39:40 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpqqQ-0002EQ-0H
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 10:39:39 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-390eb7c1024so4143874f8f.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 07:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741189176; x=1741793976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A2FkBxorOu2f4P3hJ5OavZpNo+Kja/eoTDhM7V1YPN0=;
 b=dzaVYMjZVcmhbx1F6DAq42eQbo5WWmlHf5qeP+CPfEgTl/ihKST4d0C8eqbEoCLu19
 rAihHIxu7K1NoVrAVs0GnGMyjOxByvqi8rSOjrxg1e8cxW+RrcvWMCtJvd9+OL/HoHLQ
 oMPQUCFKCEFdGyzuAuHWWAtnNEjYHoMQqT4h5xYZXUB2SHlsOdTfF+ZfFIviMy3qZc/p
 sBLE6vAoGVnyhqU+M1DwBAO7iACl6Vjfi+Yz75XDR1m8H3QOJ3ceZWErw6mpXQpPq9Lx
 /ewtha/+Bfv/yGe0XZTxwsvKCNBaigGMrWcVuyOzBx5W+BaOX59EWlYdHwa//AKcSoDN
 cnww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741189176; x=1741793976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A2FkBxorOu2f4P3hJ5OavZpNo+Kja/eoTDhM7V1YPN0=;
 b=Wg0xu3AYd0M+7rudV5r/N6yD7u5Tt8eZkcLcCMsfU9jrEsHRltEOACZ9hMG/lbXYCu
 Uc2LgpiZCusE/Yoh3GOdAMhVEptyfRWPpTAw8NVr4UsNzoaYkATkYGR6b9Z1LOtCyWhg
 FjPsZPimeaeeFOUg8VoCzab9d1a+is2D86d0FAzHjMKCDmxabykPdZ+f7KVR+/A9fixH
 eQnb7nyJb3YobQGLThM4aykd9aiyES/kYTI+Ngdp2pb4nQXjeIcL44NeB5oVyn/QSpxv
 VlSNLT1FJsthvxDJLJ5imaRsZc0anjWuaskn9Sdrl1XR4Y2TqE7m+UQC6E499PyhJWel
 Uc4g==
X-Gm-Message-State: AOJu0YyltUX3AtH8l5VAi/1h+m8aP0/A0KrCqozZFAZi3vq9GoQrNgnu
 g+XHOgbwl3mSoIZyHs+HtQnUubBFGvEbdXVpnYP9KngqGtQ1Fs2/QtW6LyiWP8Rg1k9HKF9dsgr
 fi4Q=
X-Gm-Gg: ASbGncuehPRg1R5cc0UYpe1vsjrbvbvuRANx61xGi03dsGXwVEs2EH3N9dSPe+ex/vH
 mJgxmsz81PVhetHcxo61GDzdldZ9ZfBv30yNxjgEr0v2/g1pVMsWgvXLRxQs7dhaeQFXpZuZJV4
 e/HpPOUvBrsmN1rDt18/ARhldQbwa2cRtlW8uGhQ2mXwUckdtINeBM7IY94fKRjh1ER2wRXit5Y
 wEGWFE4vQybk3OsF4UQSX2Ms3LYptnJVu5PJUA+3XF4nVslvVSPqr07DGTnUab6YVIv04dA/vpB
 ETYN4GeWYYgN+zpoLlYv3kVPLzWfPnuzwcwyfp3bNew+IxxopvpRdZnGVpHN5UgwQn63obMpKh2
 F/CieQAPAAfr/oT/rEIs=
X-Google-Smtp-Source: AGHT+IG5I5DsZdbodVA3yFmcxk6l1JA1RGsMnT8bwoIQ/GvDweKhkl2ceTzOvhZ6IXKu6cEFk5jkOg==
X-Received: by 2002:a05:6000:1aca:b0:390:d954:5e7c with SMTP id
 ffacd0b85a97d-3911f7c3d08mr3750964f8f.38.1741189175736; 
 Wed, 05 Mar 2025 07:39:35 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd42c81c2sm20834945e9.24.2025.03.05.07.39.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 05 Mar 2025 07:39:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH 01/18] hw/xen/hvm: Fix Aarch64 typo
Date: Wed,  5 Mar 2025 16:39:11 +0100
Message-ID: <20250305153929.43687-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305153929.43687-1-philmd@linaro.org>
References: <20250305153929.43687-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

There is no TARGET_ARM_64 definition. Luckily enough,
when TARGET_AARCH64 is defined, TARGET_ARM also is.

Fixes: 733766cd373 ("hw/arm: introduce xenpvh machine")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/xen/arch_hvm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/xen/arch_hvm.h b/include/hw/xen/arch_hvm.h
index c7c515220d2..df39c819c8f 100644
--- a/include/hw/xen/arch_hvm.h
+++ b/include/hw/xen/arch_hvm.h
@@ -1,5 +1,5 @@
 #if defined(TARGET_I386) || defined(TARGET_X86_64)
 #include "hw/i386/xen_arch_hvm.h"
-#elif defined(TARGET_ARM) || defined(TARGET_ARM_64)
+#elif defined(TARGET_ARM) || defined(TARGET_AARCH64)
 #include "hw/arm/xen_arch_hvm.h"
 #endif
-- 
2.47.1



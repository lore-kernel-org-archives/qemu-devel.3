Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBEDC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 15:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJb86-0006Ey-NS; Tue, 18 Jun 2024 11:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sJb85-0006Eg-UB; Tue, 18 Jun 2024 11:52:17 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zheyuma97@gmail.com>)
 id 1sJb84-0005NU-86; Tue, 18 Jun 2024 11:52:17 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52cc129c78fso1535821e87.2; 
 Tue, 18 Jun 2024 08:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718725934; x=1719330734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R47u/FZXyOroD489vwpfSVxxMCbbmGOXkx4mZjG/Eno=;
 b=LNHeuw3cfuqxTprHN4miKYANmPdfeoAMsVvBIt3JuMAMrnAhqd2goXrCSGkssRxmuh
 iDraT5d1HPyCVBeHhVKyD/LUBZ3iH0IqUXqc5jLQG8BhXJIQNnSP6byVwU+RB1n1RIhS
 gXzIoraRqLdV0ipFSVbURa/LuATh82yrl+J6M/eVNX4wxJ+UC3F27V/wHaYOmUxQ6iAr
 6CdPRStFBHcGF43wAmuUGmf4b8bqpwBJHyUQhKzMpVQJ3zqqARvQ7yAXrN5bEeN5+d0J
 TFUHqdyBoV0cxhOVm5uZGeTuQ1r6z30I3I23a3kunTmuwLFO2jBtiPUyMFGYvmYIoT9d
 RxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718725934; x=1719330734;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R47u/FZXyOroD489vwpfSVxxMCbbmGOXkx4mZjG/Eno=;
 b=Tc1faEnUnPzDNWxGYwlLGY5HX0KrfyTX20jLc+9RPCwglaC4Pr7OYIOPaE0+1u45JV
 z8GkOHsDtXc8muvcuA1WB37V3vt8PqCsP759FaJ4bITUBovFexG+xORXaHkGbC8mgGX0
 ajh7MfLrz2dWcxff9h2AiX1mlF4Nr0vW0sQWtVSyLx1aGW0Xs8iC8ciHHW6SFLa/QTyX
 mUCampJgVf8yzU4GWQvvjUwR8BM0iRiJ9vQW/KXxpjLXVwZbpwpLBbQ8jx3nJlljPJZt
 7qfMqWWGs5EY76E0dW9rNnc3y8pFg0wbJ2rbQI1gcWJ8Xs9+zJNLSlGjHgfmTn2orca3
 t1ZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlS9ek2bi3IeQzbH3qbgltBOwORK96jtCsaV7IC5E/f0rJHLTI8sXLCk4/Q6Icven9IYZfX+AARyJqtcH9uMGJodkl8GREdf3YOTwmhz+hExrVhbIuWug0TqE=
X-Gm-Message-State: AOJu0Yxe6i8cz3F64cmVfjdOfVx2pkOHA0kpAU1UzHLZ2Af/nnzga0IM
 UJOkYmJo3D5t5FUgpCSY8CEJ6745x3i2Rt2hg4rwAoVEpRZ+IpLqWfhOT/nAQQ==
X-Google-Smtp-Source: AGHT+IEKomsC24o6wWv19PojPc/fmT3QAu3Q3ocTtnhFSrp/8kIOgwPZzsRFKacIxcQwXYY58qqlcA==
X-Received: by 2002:ac2:4e0b:0:b0:52c:90aa:444c with SMTP id
 2adb3069b0e04-52ccaa5f1a7mr23692e87.28.1718725933860; 
 Tue, 18 Jun 2024 08:52:13 -0700 (PDT)
Received: from wing.epfl.ch (dhcp-122-dist-b-021.epfl.ch. [128.178.122.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422870e9145sm229217205e9.22.2024.06.18.08.52.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 08:52:13 -0700 (PDT)
From: Zheyu Ma <zheyuma97@gmail.com>
To: Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Zheyu Ma <zheyuma97@gmail.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2] hw/misc: Set valid access size for Exynos4210 RNG
Date: Tue, 18 Jun 2024 17:51:59 +0200
Message-Id: <20240618155159.3183256-1-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=zheyuma97@gmail.com; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This commit ensures that accesses to the RNG memory region are properly
validated and align with expected access sizes.

Reproducer:
cat << EOF | qemu-system-aarch64 -display none \
-machine accel=qtest, -m 512M -machine smdkc210 -qtest stdio
readb 0x10830454
EOF

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 hw/misc/exynos4210_rng.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/misc/exynos4210_rng.c b/hw/misc/exynos4210_rng.c
index 0756bd3205..674d8eece5 100644
--- a/hw/misc/exynos4210_rng.c
+++ b/hw/misc/exynos4210_rng.c
@@ -217,6 +217,8 @@ static const MemoryRegionOps exynos4210_rng_ops = {
     .read = exynos4210_rng_read,
     .write = exynos4210_rng_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
 };
 
 static void exynos4210_rng_reset(DeviceState *dev)
-- 
2.34.1



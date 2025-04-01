Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5B1C36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 08:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzX1t-0000dW-M7; Tue, 01 Apr 2025 04:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1tzX1j-0000aS-Mp; Tue, 01 Apr 2025 04:31:20 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1tzX1f-0000wU-1F; Tue, 01 Apr 2025 04:31:17 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2279915e06eso107945485ad.1; 
 Tue, 01 Apr 2025 01:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743496268; x=1744101068; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NXJzMkbHeNL7hvhp7UIYqNGKaUhKAfMEt68Iz/x8HeI=;
 b=Yy7DunYrSD0aeQ/7az0LUS89ZHnyW2QVV9tkqJ/9ybZ+fumTxad0Kp1SiJmqozhQ2+
 IV/RLkDJZB9MgJK2/sc1uK1QbBI6eXFl5bQv2CmP6J4ra62NrEuLmHaRiON+Mtjpq+3S
 cCxdgSVZRG4lPSTttFsmopNtWyPy6zSicI7qM2pDvzwgDfMlWuFvWrK9fe9jTspBWDk4
 cuYGRBdJhWlSnwIDXe5bSXu2J2FCRVxqxkyybqtVnap0H3OgWnrBcUKA7YYHSGPzfGv6
 yltRp6yqVmY7gTcDZPMSrvkKglf6wD9AEaAhvK48EapXUHzp8m7PdhOXcYZpOwGy6KdL
 zI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743496268; x=1744101068;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NXJzMkbHeNL7hvhp7UIYqNGKaUhKAfMEt68Iz/x8HeI=;
 b=p17oSCmwp1aubZdOoy30PdBcRaA/HDysZ7HlqBupjtvf2DGXyUkvQGdBVgazX8uiv8
 GC34PkKmR26IpufxvL6Qkno6ZZpK07TJsdDKsLs9BgOa5bo/OTOaZ/f3unIfRgx2sL+d
 qUn8ATzdVFZmqyj9SSrtfXLqWSCYJ+TfsTD1DymKKtz71sSKsXWB6GFThgAJji71ibx6
 k2CPPUxcqgKP779yDTj0NjY87kukwZSs4LqW7sD+v0B0UxiRqx72IpnhJkzjsYV75Bsi
 ib/ugqBbuFtLTKIYBidO4tuo0+C+mHAkKnua6P1O95Mbep8OLEktY+j6+9UEStDOROMI
 VjeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbvYNECsrQ4KCvzUONf1+0wMsWMpALoo+pFaaWbA2e9aFZGRQER2khUBEUQbDb85GUH6HYdFyM+Q==@nongnu.org,
 AJvYcCW3rEuCYm3KeqC2TQRkwXvNaj+4xB75yTqpOV/U+0Q4ybsiuDZ6WDlJ/yTgkSF03imkwg82Ssy/Kl/EBEpV@nongnu.org
X-Gm-Message-State: AOJu0Yz7G4hbiOX8iVbkIhRP10BSoxzNMWq+HzgWJmAivZFlTvtpCZ76
 4UEVIxhP7K7zMMtlQDPdMU93ah1r+GrxCGE2sN/8jD7qJ/KUE4HLIcYXsQh9680=
X-Gm-Gg: ASbGnctuKvqqNDcz20iHE5sFBlrDILGHYbY7qRoTvRccCHzOSp8yu1JY07P5ayA7FUS
 BchL5uhkRrxqY7aT4Z21+sLSuDIssPiOyEUoMwGpb4xMxSKRJ1sF1H1x12sZRqd7nyitTtgWZ6v
 GH1AemikLvgvB1r2lHejZTR21tTqUKff+FjIM3w/ZJDWnaKmUqLbzwOnyNK0woa5sBAdDIFGdpj
 FBUDlSm8zoK3NOL3ehH4f9m3Iq43euuWGQhao0Mbc09+baeJ2KwQgPcvkJ74P2sRALvkEaEdepv
 pJCbA5ETj+fh3T09rBSoj/C659iFkOjFtSvEyuSbbSvL+w==
X-Google-Smtp-Source: AGHT+IHNZv3Kv6gKN1/cHshYekmdNNUAEylUSMAv2yFeBPwTzTziDQ78mwe3dTwNzYJ8unNXlHmUoA==
X-Received: by 2002:a05:6a00:4f8d:b0:736:476b:fccf with SMTP id
 d2e1a72fcca58-739804397f9mr19522271b3a.18.1743496268177; 
 Tue, 01 Apr 2025 01:31:08 -0700 (PDT)
Received: from localhost.localdomain ([129.227.63.233])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7397106aea5sm8574597b3a.100.2025.04.01.01.31.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Apr 2025 01:31:07 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Zhang Chen <zhangckid@gmail.com>,
	qemu-trivial@nongnu.org
Subject: [PATCH] docs/arm: Add apple HVF host for supported guest CPU type
Date: Tue,  1 Apr 2025 16:31:02 +0800
Message-ID: <20250401083102.72845-1-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

In my test, latest QEMU already support Apple HVF for -cpu host and max.

From guest VM lscpu:

Architecture:             aarch64
  CPU op-mode(s):         64-bit
  Byte Order:             Little Endian
CPU(s):                   11
  On-line CPU(s) list:    0-10
Vendor ID:                Apple
  Model name:             -
    Model:                0
    Thread(s) per core:   1
    Core(s) per socket:   11
    Socket(s):            1
    Stepping:             0x0
    BogoMIPS:             48.00
    Flags:                fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp asimdhp cpuid asimdrdm jscvt fcma lrcpc dcpop sha3 asimddp sha512 asim
                          dfhm dit uscat ilrcpc flagm ssbs sb paca pacg dcpodp flagm2 frint

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 docs/system/arm/virt.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index adf446c0a2..6a719b9586 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -70,11 +70,11 @@ Supported guest CPU types:
 - ``cortex-a76`` (64-bit)
 - ``cortex-a710`` (64-bit)
 - ``a64fx`` (64-bit)
-- ``host`` (with KVM only)
+- ``host`` (with KVM and HVF only)
 - ``neoverse-n1`` (64-bit)
 - ``neoverse-v1`` (64-bit)
 - ``neoverse-n2`` (64-bit)
-- ``max`` (same as ``host`` for KVM; best possible emulation with TCG)
+- ``max`` (same as ``host`` for KVM and HVF; best possible emulation with TCG)
 
 Note that the default is ``cortex-a15``, so for an AArch64 guest you must
 specify a CPU type.
-- 
2.49.0



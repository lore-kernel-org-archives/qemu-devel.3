Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA5DC8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgHW-00057J-7Y; Thu, 28 Aug 2025 13:19:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRy-00035o-5S
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:54 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urbRw-0007Kk-Kb
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:09:53 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-76e1fc69f86so1583490b3a.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756382991; x=1756987791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=63iK1SN6YM8JdMQkXOxn88bESvY73aSwuUnStQVlbgM=;
 b=PFZPXvmcyhjfKt9TmNff1wKzIN5CzEN8fXZr0vSL9fr+a+cDPGy7zEWdsWMZqHIBgV
 Z6MmW6LXel7xxN0pIR5DE6SA2Tq11CZJLDnRxwOM5yeiD0K3jAaAdob058KjlsfOYuQd
 iRYtAtyGMRngT5M/bjPEfmt5RKpXnZS6nmMK8axDRx00/8kr1Pzi9roZuWkpkiN6DPu+
 qIbvol63frhIRYEg7xpEcFrWNkhZABS3nP6WuEPeMmibdkKPlRtsUbb8Ym7RFyTJGmb0
 o4E0ge68mJwFKmvTICLcht4tdW7scZDjVW06iR2IUtNHefGNg/prcg0wKjpAivkuwdeA
 Qivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756382991; x=1756987791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=63iK1SN6YM8JdMQkXOxn88bESvY73aSwuUnStQVlbgM=;
 b=Ig76aDDkmlu/1+0hRvPECcWMH/pMd3OVpB5arxUWBmWfZpqXCezZbXRDVX1NIkGGoA
 0XOBNEq5400vG9R5cBRKObUeJZVH+nFb5voiLC75HZq6HHNvyTv+BgzIbw3As1LI6ggY
 h/hDGsCit/vd+GvFsjlk6kjL2LSXxIA/2Ci/FFYFBUNIo799pLz+K0IqV9KF7hBHV/PY
 YaxiurcfXYv4FwFa71SsjwHzM+jc1bzuaeZArJbkA5YWjDoWrq8/AuLnc/rko9hWDrk2
 LHJFhI2ZXs/a1aUPRkPzroj/3ILrxLoatpF1VvBq1uHp3o1oyNl0bpq3qyjd66k16YLG
 m1nA==
X-Gm-Message-State: AOJu0YzpdYh9apKOudw+6Yx1pl0r8a2gDnCs6i0cF2E7sxRBtpZWcheZ
 k5bcfMqgFlmpATMDyaPPonfW78qe5yvtGw0p6/iBQUsGuxdS6TkHKCJa/c8qD88NZB/as4L0hQP
 QSIHq/6Q=
X-Gm-Gg: ASbGncvoaBhGIqEVru0Wy7VfAkJWnshdQG3Dxd4g0BBjuP2PiS5dW2tzyaHeecuks+x
 Ry2cXkzMNLmazAwJkyJ4DFQ5NFLEj+pT3v5AP7VZqjrZawlWf5kRqUcgqSiqluLwdXJAMpUBWZ7
 Qti32+t9zMfFIVILdoei8yNvyT4APL8tiIOJuR+4+4+Y1AuFLqwI8EUsywnlXocWTBuA7SeW2CR
 q5YLwIBXMq7hHjdW61/rLyV6CFusYnhCP9t7mgb90+vQL7zzBKo/j/3VkUXzO1qcbm3pbhWcQ0o
 gqnTphpe4bUIxUSEKB713I0KwpChA1eAbQlsWUw7xdCDHwhYKOXI0FM6j8xJsi9UsbPGyBKjDDB
 uKQ1ToKmagCDcBzqhzYWqmqWQXg==
X-Google-Smtp-Source: AGHT+IHS/mGPLwhduz2J7Mhn+pPd7ysFkwnZBVsfsHEhtJeYdy29CZ5QqF1z6HfCstaXTl4oTreJMQ==
X-Received: by 2002:a05:6a20:12cc:b0:23d:659c:aadd with SMTP id
 adf61e73a8af0-2438facc8b5mr11588158637.22.1756382990788; 
 Thu, 28 Aug 2025 05:09:50 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b49cb8b4b98sm13933222a12.19.2025.08.28.05.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 05:09:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v3 29/87] linux-user: Remove target_elf_greg_t,
 tswapreg from elfload.c
Date: Thu, 28 Aug 2025 22:07:38 +1000
Message-ID: <20250828120836.195358-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828120836.195358-1-richard.henderson@linaro.org>
References: <20250828120836.195358-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

These are no longer used within the generic file.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 5cdbdc20d9..07d83c674d 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,14 +130,6 @@ int info_is_fdpic(struct image_info *info)
 #define ELF_DATA        ELFDATA2LSB
 #endif
 
-#ifdef TARGET_ABI_MIPSN32
-typedef abi_ullong      target_elf_greg_t;
-#define tswapreg(ptr)   tswap64(ptr)
-#else
-typedef abi_ulong       target_elf_greg_t;
-#define tswapreg(ptr)   tswapal(ptr)
-#endif
-
 #ifdef USE_UID16
 typedef abi_ushort      target_uid_t;
 typedef abi_ushort      target_gid_t;
-- 
2.43.0



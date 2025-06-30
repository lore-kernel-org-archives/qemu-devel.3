Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C769CC83030
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 13:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWEGY-0005w0-1F; Mon, 30 Jun 2025 09:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWEGW-0005vJ-06
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 09:09:44 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWEGU-0003ud-34
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 09:09:43 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a6cdc27438so1780400f8f.2
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 06:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751288980; x=1751893780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=J4xYxzQNhLcyF00H/g7Tqzz7gyhKM10HOzZKk6JKWJM=;
 b=mHToZ9wbWxKQLaC8uGByJdWa0FyrIwvYzM16pYfY9rKAq/DOCKcz62sHfDr8uIZFRQ
 SyUeQRkiODrtVA3oaVucZ3/o7PcDLD3eYOcObjxkfifNxxsy1N3N6XdIGonfY6SGXuW6
 WBdvzB9yWN031JJqNAYHaEW+XLZVrSlPtHx4G6gfI2w8J+xersjAb83b5CM0eGe/shJW
 vbvVS3pMdGUOwHW+4tp1YJxGZaKYNfJdympRrzqvG5H/85ZvGtshXJEF4mGdHX7T0sjX
 VDQEPPZZbZiK5rMT1czTENPoojEdcaO/h7xr1OR3RXZWPHWf1FynYu8l14f421Bp5PXj
 2wgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751288980; x=1751893780;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J4xYxzQNhLcyF00H/g7Tqzz7gyhKM10HOzZKk6JKWJM=;
 b=etslcztjFz0X+fAgjSAm5dMKhQrifmoP6tbBfg7C3pzS6YwJ4jYaCYEk43NU+bXBOA
 uep/Qf1iQCZxYdTQg8wkzy/w4p9k0ah08LvpdPRv4MSPfZBvv0Pn5OIuxUfgz/5zQew+
 pk1mAWBN5/EYL4v2jRMbsc+WGrIIiJiGfIuM3ewp8CE2coNklg2l1vGffblxsUHhnMNJ
 53qmaZpIuCZC/nppPvAYg+sfeuha+SOpnTB+3m11GMg0LAAJ8uXBEUFV3A+6neWGBvKt
 91JnazIFw4Vy76NaYYQRQhz9fdJ01t0uVy4H6slT3pWHmvSJkWmf+v7JY4b0sm7nre3e
 DCrw==
X-Gm-Message-State: AOJu0Ywycso24hrJ+sqqHeGDHOKK7W7ZHisUeZHi2Ijghc24B86TDy8v
 2CergzLChHTsWQufESxay1G1GRJxYNfXAmgezEEqeOXDtkBYkjqeeODWURa0AVnsj3MojZ6sQMk
 mcjZS
X-Gm-Gg: ASbGncvVbTzS33oGECGffaFH+quFk9IKn7IDyrBReZ6lsd2j3U8KHo1ZkJLt0TYkkZk
 gVjsq2VgcjB2dcnfhK1kRixjLarpnQlg5xGZz11tNMp9tZgUQqOxi2iax37vzQVxTfqbyWRir4C
 aVZXeG3VvHQlM9CE4ocnQu567oJ/W/j9rmtYGTWwA3nWdg/Ac264sV+j2PBx+u1Dw6I9F3CYSop
 6RSCyW0/JJ9VHYbBjkdzP5o9U3vO82TZnmex0IeDaPgZmKo0IQGJce9a9hjgt1zir6CXF86q/UD
 Nfe+ws2SMeox/C14QV2LDS9Q+chWsaf9fTsqDKzc9HybLi08xeNjN09QRbyDAoVLd1GNujzrkxv
 qTAXxrGvxiXjudeO7Tej9y7gI+eTHpK531sQi
X-Google-Smtp-Source: AGHT+IHkxJ5nWCkCC4GVurCf6yTBAYDFE52nieG9J36qbUMb2ltXs1GQGS4fPZ0NknjV775ZoPvkxg==
X-Received: by 2002:adf:a21a:0:b0:3a5:88cf:479e with SMTP id
 ffacd0b85a97d-3a8fe79c8e3mr7865075f8f.48.1751288979763; 
 Mon, 30 Jun 2025 06:09:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e52be0sm10606213f8f.64.2025.06.30.06.09.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Jun 2025 06:09:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/6] target/arm: Few accel cleanups
Date: Mon, 30 Jun 2025 15:09:31 +0200
Message-ID: <20250630130937.3487-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Based-on: <20250623121845.7214-1-philmd@linaro.org>
     "arm: Fixes and preparatory cleanups for split-accel"

Philippe Mathieu-Daudé (6):
  target/arm: Only set CPU_INTERRUPT_EXITTB for TCG
  target/arm: Only allow disabling NEON when using TCG
  target/arm: Better describe PMU depends on TCG or HVF
  target/arm: Re-use arm_is_psci_call() in HVF
  target/arm: Share ARM_PSCI_CALL trace event between TCG and HVF
  target/arm: Allow arm_cpu_tlb_fill_align optionally set
    CPUTLBEntryFull

 target/arm/cpu.c            |  4 ++--
 target/arm/helper.c         |  2 +-
 target/arm/hvf/hvf.c        |  7 ++++---
 target/arm/machine.c        | 10 +++++-----
 target/arm/tcg/psci.c       |  3 +++
 target/arm/tcg/tlb_helper.c |  4 +++-
 target/arm/trace-events     |  3 +++
 7 files changed, 21 insertions(+), 12 deletions(-)

-- 
2.49.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC853E784BE
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 16:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZtTh-0001ji-I0; Sun, 28 Dec 2025 11:18:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZtTg-0001jZ-8o
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 11:18:44 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZtTe-00078R-Pw
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 11:18:44 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so88789075e9.2
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 08:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766938719; x=1767543519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EqIDVG4Vst2Askn3/wFwiTIG0UUnOigrKGotRr0ttlo=;
 b=NWY7NonLTIpQ/Ggj33LVZC2t3BYOaCIOTKgz/i0NI1Jnn6+H4o/PN5sHxUnV17lzxJ
 4AapiIyuRXR/8JFeopAhyyw2+MPocg+G54Flrjslg2BBQLMwCg0shl9eAY4jYgRl1Zj0
 6rDr8bRJQ0nJfDrDT6q/UZBl2FdTug1CCLC86nXuRUmBF4Mf9fsQsC2gfJg3byg6m0bC
 fRBfWXtdQtpw/VZZ8s94a9A1dkkzqjiKcRL1+cf9IqZOTYdMk1kJhSw2Aaiv3Y7VEIF1
 onv5LcIwJixFedYSRHJqpIb51xy/RCB+N4EAuivF504t/g6qWnw0LY9UYeX6w/QhskZL
 aNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766938719; x=1767543519;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EqIDVG4Vst2Askn3/wFwiTIG0UUnOigrKGotRr0ttlo=;
 b=woR7WLA/+jtJIrFUOUKnJu+syPR0O189lzEzwePJ3EZydbz3A7V356EmyggkAESQvr
 AjfV+IE5cP1SUQzTmaJEDXQfkYci/w4oA7fJNNLpljkmSeRRfyVW/nUrGgGQmIV0ds0t
 szRmHwaXWN8p0RBNhE3DZp97rnsuCJccMAhaLEowntpBcY6N4IyN+nym19dkTZUescn+
 K80Lvgt9ZlreeS82NOlTa1BeIVEPO/8u8WDuJBB++Gyz0S0k9i4hPJbJLBITw2kasUFN
 XY0l2IcYOQ9m0BNFqJb8obHoAw2+FAJzrl63zZTwspOi1cJLQSzbZxMc4c8JFmCTugBG
 nsNQ==
X-Gm-Message-State: AOJu0Yw2BoQXy5Tvt71qCNtZvfdimGM7lznEzq/IsDOjJY/m5Jl5wAFY
 WArK4CwrPjbXhhYJUdCnGyeux0Y4FFRQ21dlrtrTlR/RX/O7quOVkQcYbZanx2Tgdxb0CLoNDVp
 +Dj61
X-Gm-Gg: AY/fxX5vwfPD0o1ED5DbewK3rC4xtQwp0DkF70aHVlcoLfvEAcI8IAaNZ7Lvowpi88V
 f3WuAPr5UsmE+WqURzbrFPxAMadacIUCzWbDnP7318e2rDk0x+MGerum7NwB8zEFHM0VyyBJKqP
 tVndPgP4vddy+Fy6dirW+3AEqKcLtF0nwVhOognQTg/Yr3c9yYQ7H/Xx/+5w/wrvDhnxQGBzw7V
 O250UhPuwt7rCScULfptb4nZPF3tqo8RUw4lJSgjkZ0Kv+CW9aKZOht/+Ty4uyOFr5p9WQnBnY/
 l6O6hTVA33/LzwnxzzaSXO7oAtjDtUZwNbKD9YmbfH9jPdyE/ogrnwESRfNgjEL+84bvK97UWW9
 BNZkYS7kjaXSx7UROPJS6NPgKdtjWB5hlAmVoE2rsJNn0I2Ej/lMACCDJHeO4JEqXHu92pWswFv
 4Za1cuqvGfhnKnFCsGZARVoGytpv7IkLz0ZT9PcuUvnYwOxMnZo5bd
X-Google-Smtp-Source: AGHT+IG4u0MMCQQHNqISyFB5ZzBlcfnILcXTNDAy1c9eSwhqPijL64zxSqdmqcWa4tU8h5cfBqGJeg==
X-Received: by 2002:a05:600c:4e49:b0:471:13dd:bae7 with SMTP id
 5b1f17b1804b1-47d195911b8mr286892895e9.30.1766938718984; 
 Sun, 28 Dec 2025 08:18:38 -0800 (PST)
Received: from m1.home (alyon-655-1-564-32.w80-9.abo.wanadoo.fr. [80.9.105.32])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be27b0d5asm554084565e9.13.2025.12.28.08.18.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 28 Dec 2025 08:18:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 0/3] system/memory: Clarify unaligned load/store API
Date: Sun, 28 Dec 2025 17:18:33 +0100
Message-ID: <20251228161837.12413-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

I have been confused by the load/store 'host endian' API
for years: this is just about unaligned loads/stores.
Rename to clarify.

Philippe Mathieu-Daudé (3):
  system/memory: Remove ldn_he_p() and stn_he_p() helpers
  system/memory: Extract 'qemu/memory_ldst_unaligned.h' header
  system/memory: Rename unaligned load/store API

 include/qemu/bswap.h                 | 95 +++++-----------------------
 include/qemu/memory_ldst_unaligned.h | 67 ++++++++++++++++++++
 accel/tcg/translator.c               |  7 +-
 hw/display/ati_2d.c                  |  3 +-
 hw/display/sm501.c                   | 21 +++---
 hw/remote/vfio-user-obj.c            |  5 +-
 hw/vmapple/virtio-blk.c              |  3 +-
 net/checksum.c                       |  7 +-
 system/memory.c                      |  4 +-
 system/physmem.c                     |  8 +--
 ui/vnc-enc-tight.c                   |  3 +-
 util/bufferiszero.c                  |  8 +--
 accel/tcg/ldst_atomicity.c.inc       | 10 +--
 13 files changed, 128 insertions(+), 113 deletions(-)
 create mode 100644 include/qemu/memory_ldst_unaligned.h

-- 
2.52.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6888EB363C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 22:04:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxBM5-0000Jg-V7; Mon, 02 Mar 2026 17:03:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxBM4-0000Hp-84
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 17:03:08 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxBM2-00016V-I5
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 17:03:07 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-439b7c2788dso963085f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 14:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772488984; x=1773093784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TtSSxc4Ah1ot2GgQBdeTXSOp3+KBMfYLcFsfHrMmRLk=;
 b=f1rmWHumNZ3vV0LVp0UkUYP9Spj/mt4wwLrkG9c9qPhs1xKgXymg6FErL/NQmb/nSA
 sQDONW84Hm0R+2g51FkYHSXuKoKQPDP+LIMeQiJNqP3Y/wxyZwzitxwJWzsWkFtszd9c
 oC/V+YPv0JGaxLvN3Sx5/zMiasat97sg5nr8ZYG+mz9l8CYPFd0aREmzvpqHGOQE+ENn
 zK7S+z4I9K0T9c9s7wYobGgMp5YJ90mNv/tOaEwETB/PrfHOrcnAzoeMhlBqRsuv2sqr
 Dgqbj3U4fGh2L1xUyzk/UOdNAWDzX+2oMcFtqYd67AhxJzAUd9eblTOa4KCnQUUMI9sm
 E+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772488984; x=1773093784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TtSSxc4Ah1ot2GgQBdeTXSOp3+KBMfYLcFsfHrMmRLk=;
 b=EFqgAO9zgZ5XNsMT4zJO1PxQMX1Hk/RCSMp2q8ZBwyXZ1nP8oOWOY3kAA3s0hWVwED
 6OnKCdhcy6H2igEq1Jy5v0V7yz3ydvy56nbM8cgJgNxyJnOenuxsOnUDxVOWWjxl+dDN
 tovZxrq785XrHX7AW6PgGViMMz49E+Dyf/6juViTMS+asFWZt43/tDJUVyYcwT9dHVD8
 /9Od/4YdGni8HnmMxn5b4YEK9CGOZFI4UGzLyi/erKxJCpnpeaN4oyRX/aejFrdF1bsG
 LTfcGkOeN4F+4tg3Wb9JxlwMsevzZtafRETdvfxvu6sf8lZgw+yr0VeHCi3mBsQM1cR3
 1luw==
X-Gm-Message-State: AOJu0Yx1qeESm2ZzEXwkPEwCyDxaS19MfUDXRj4B8ooz9x5igcQvPpqd
 BweBFdCfRMNfiMAS9B9q28J5aDi+l33KgVjprW51LXIKubpTuYKFlnfU6ySbaQ==
X-Gm-Gg: ATEYQzz+GRE4UxGU/i/KEePwdRDlB8j+eYCdYUzyOmbgH11owfGBXs29RWS5TbCWf+F
 tMr+jt9Fmv+6ZbYNKFbO5/fSUAzTtPfbn0l6OzyaQ+gwVO+HiZQm3jrbK9rQEUJeFEfeop9SXCD
 4OTfla0s5yr1nZld7KFiJ1tda8fE2al37ZnJS9HZmPBG1hHU8UJ5Zk3hUP9hNfO1NSfGZdwxko2
 oY+UtRkVKKTLfNH+IIaGvjExdJB4SnPtTpRSfk1+fgAtn9o3kZHXfYunUIBkBdewH5b7Ss0ue1K
 nnqcYElUy2/mPqq2NU73uxYiiaU3cwNUr5SRsUSJHLaqBrZLWarkf9w0EUZBmLE/AJi4pWmQuOw
 oD9NhQMKgwK7x3Vv5+NYUU2ZfGRJtHW9jYP426skDW75eNCkxOtxO4Br86ZiGAPb7DCZObRqPYS
 ZLT2Eo+BoyQclGgXjkuqtjBVVTwRTK30cHd98DOQXFo4dKyo/JR7rBEyq21+NcdkV1/epLGYv9D
 eoxxyBrCpKA6SCYUyBn2l5O6otK5zgZsdIG7Fv4Xng0lS8=
X-Received: by 2002:a05:6000:18a6:b0:439:b886:20cd with SMTP id
 ffacd0b85a97d-439b886219amr7543680f8f.16.1772488984307; 
 Mon, 02 Mar 2026 14:03:04 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-2a02-3100-2e0b-4800-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2e0b:4800:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c765c38sm29308102f8f.31.2026.03.02.14.03.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 14:03:03 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Helge Deller <deller@gmx.de>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Troy Lee <leetroy@gmail.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 01/12] hw/arm/Kconfig: Fix serial selection for NPCM8XX
Date: Mon,  2 Mar 2026 23:02:43 +0100
Message-ID: <20260302220254.1166849-2-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302220254.1166849-1-shentey@gmail.com>
References: <20260302220254.1166849-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

CONFIG_SERIAL selects the internal TYPE_SERIAL device which is akin to
an "IP block" that needs to be integrated with glue logic. In case of
NPCM8XX this glue logic is TYPE_SERIAL_MM which the code uses already.
Fix Kconfig to select CONFIG_SERIAL_MM which matches TYPE_SERIAL_MM.

Fixes: ae0c4d1a1290 ("hw/arm: Add NPCM8XX SoC")
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index c66c452737..20e99e52b1 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -493,7 +493,7 @@ config NPCM8XX
     select SMBUS
     select PL310  # cache controller
     select NPCM7XX
-    select SERIAL
+    select SERIAL_MM
     select SSI
     select UNIMP
 
-- 
2.53.0



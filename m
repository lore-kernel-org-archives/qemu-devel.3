Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03986C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 13:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruBgK-00064w-5z; Tue, 09 Apr 2024 09:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruBgC-0005uB-5w
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:38:28 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruBg7-0008Dj-Iy
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:38:26 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4169d794358so6526265e9.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 06:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712669900; x=1713274700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DYq6emMuo84KXuK6pkPRkrWEaAEwv9PfaiSXDO6YJ5M=;
 b=cxnoEpD6KAKtBEw5QDjDUrmguX7lzbDV0x8vzdsb8XUcaMF+c/PECNPb7qMz3cRse5
 tuxwcywIHcy90NfWqp6yOx6VwXG+HWWsEZKBWJS0BNqFrS4xHazn3UXT8pimj86Y0KVC
 q1m63i4uFPfJn5/HFRi1e4b8BqsfjtHw3sQSHlMu8btsw2AVJTavZnfbKsEQdNPLW3QW
 KvhKctv52gsS4lJBXwTKIlvz6A/p7fLQSxxlVaaR3s67NrqwtxPvjdOnQ/AGceSYg2PP
 MyWKWXxGlCtLZ0L7dUcQciD+QH/PaY2EetO2VxruQu06qROX9zJMkf6ArpNpr7EZcJDL
 wGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712669900; x=1713274700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DYq6emMuo84KXuK6pkPRkrWEaAEwv9PfaiSXDO6YJ5M=;
 b=iwSJqAlFIeLsuyfXngx4Yi+p3UELVI0Wbb2VkjKQ2hbP2lheAJZu+HPzi1REF82yIu
 mbgUsbU+A/WwLNJZSvl6tXlNoJ6+l3Y6d9M88657zQYf/pvTB4SUgr72vax5TTS7Kb6e
 AbS+uqQbxm21A+5qwfjNGid+ViCP61O2/xF4oSX+Y4bqubsQ39GBxXyySZ8FYuWMKSXP
 LxDTkip13EXhNbBzynOTuqB0o9DjDPfZPbQsz2DE7i/o3mftLy6FDiBQFG9sR+AIJg1w
 w8Bl7lTDLzVW2JX4npHVEqXy1dHUncqcf+xR3Al3uBwFkr6ONcuV0o5+ozM28hw1C8+r
 V2Hg==
X-Gm-Message-State: AOJu0Yxdc3nkIgptEP4kJqcC6ypspimYEl1DpPnIeBbfZrlA65NbCmuZ
 WpBG1hfAj21aPFV9akjzMdq2+ALewbQf7/ce1wcngiMemwR5sDmJgBCHwdDTq07xpfod+NAHOFo
 L
X-Google-Smtp-Source: AGHT+IFJNO3vuW3jY8RQ657X4tebjgJoKiFR1/PXa+vWUhVI1oog2dETBoUsBWazwOm1m14Pi+htyg==
X-Received: by 2002:a05:600c:4f0e:b0:416:6e42:ecc5 with SMTP id
 l14-20020a05600c4f0e00b004166e42ecc5mr4129262wmq.40.1712669899965; 
 Tue, 09 Apr 2024 06:38:19 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 q23-20020adfab17000000b003437799a373sm11657644wrc.83.2024.04.09.06.38.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Apr 2024 06:38:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chuhong Yuan <hslester96@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 v2 03/11] hw/net/lan9118: Remove duplicated assignment
Date: Tue,  9 Apr 2024 15:37:52 +0200
Message-ID: <20240409133801.23503-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240409133801.23503-1-philmd@linaro.org>
References: <20240409133801.23503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

s->txp->fifo_used is zeroed in the next 3 lines.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/lan9118.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 91d81b410b..d6f0e37eb1 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -438,7 +438,6 @@ static void lan9118_reset(DeviceState *d)
     s->hw_cfg = s->mode_16bit ? 0x00050000 : 0x00050004;
     s->pmt_ctrl &= 0x45;
     s->gpio_cfg = 0;
-    s->txp->fifo_used = 0;
     s->txp->state = TX_IDLE;
     s->txp->cmd_a = 0xffffffffu;
     s->txp->cmd_b = 0xffffffffu;
-- 
2.41.0



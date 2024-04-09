Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D79C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 13:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruBh3-0006pW-N2; Tue, 09 Apr 2024 09:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruBgO-00069R-2K
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:38:40 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruBgL-0008F7-KY
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:38:38 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41551639550so39139205e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 06:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712669916; x=1713274716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7TiWem1ZhFBanlvNYVKtTUilTqsESzuwGclOakf5YZY=;
 b=nAkfqxAW/T5g4qa2Bse3sU0USrdEIaSGp1zsofwDjAoO18sSR/JDwM2qwGRpFENxc8
 Qpuw8DSYRbV/Zw+/vXB77nWZp50XgMtFyzLYBlS2le/PRuGUo6kZvgWEdb9CfIuzXSaL
 NbJ9QQAf7j/QTyCnqe1oEH6BqBcsAjJqvqyNXGk2DXl4zw6+ClkIxgNHdbV4R0UULCen
 2icsg0I1Zcvt198RnDVfh8p61bLQGahRt9H+z2Uzps5nJRBN1nXbwzM09KtUEJTBryS+
 aToh6CxCCEMSHcYBonA6iBJ7kynbtxi5OoZU2X7eqphJD87JH3al1z2HxyZ73eTAgxzX
 l2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712669916; x=1713274716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7TiWem1ZhFBanlvNYVKtTUilTqsESzuwGclOakf5YZY=;
 b=NjrueuLXcRkV/TqFNkWo5P+vUaY3GmTqpkcOGpAT4osvhsgYJGXpH09Lvif7tmlnrD
 vHn4YJKKlvz6ZS970cqymiuAwfRfhQNWod4zlEX7MJuAcEkuDzKE+FrfOmMis+FN8GAl
 qju0oCVSpq3ojw1oJkpZcVqYznIvnLNFOCQsur9IGamJBYPTeShTCHTP46nNeJkBYfIm
 +ha8/SEJbXbdScTHB0yFrz0h7/fXI4vdcCn5Rxp+ZY5DJ6FggBB6ABcJ9NzfMOYdE5w5
 TQ5+BHS7/tapkm+Wu+bM+azaNzR792WHi4JPEg+gCaE5aBd6u8/d2wFrtTn2JTpTiT8+
 9SsA==
X-Gm-Message-State: AOJu0YybXwtBOxACu6SBJWgsldE5XCcv9vJykew3FKF4JlBpjHq/aVeS
 4sG+vdC7/Uh2j8JD3oz8aOFgNfAe/DS0tv/F4BVN+mlL/PbN+8W+q1P+7N88Ex04YgVZxfFle/F
 2
X-Google-Smtp-Source: AGHT+IHmi+P6WalSbuDs5RPZz+RSQUCcpEkI99bSHFwdHTk199Eu3eQbfb9VoNgS+hTcXQkMr9YNzg==
X-Received: by 2002:a05:600c:154d:b0:416:902e:51ac with SMTP id
 f13-20020a05600c154d00b00416902e51acmr3520404wmg.39.1712669916012; 
 Tue, 09 Apr 2024 06:38:36 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 l13-20020a5d668d000000b0034354a99d43sm11483355wru.43.2024.04.09.06.38.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Apr 2024 06:38:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chuhong Yuan <hslester96@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.1 v2 06/11] hw/net/lan9118: Use TX_DATA_FIFO_BYTES
 definition
Date: Tue,  9 Apr 2024 15:37:55 +0200
Message-ID: <20240409133801.23503-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240409133801.23503-1-philmd@linaro.org>
References: <20240409133801.23503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/lan9118.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 00409927fe..ba92681e2e 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -456,7 +456,7 @@ static void lan9118_reset(DeviceState *d)
     s->txp->cmd_b = 0xffffffffu;
     s->txp->len = 0;
     s->txp->fifo_used = 0;
-    s->tx_fifo_size = 4608;
+    s->tx_fifo_size = TX_DATA_FIFO_BYTES;
     s->tx_status_fifo_used = 0;
     s->rx_status_fifo_size = 704;
     s->rx_fifo_size = 2640;
-- 
2.41.0



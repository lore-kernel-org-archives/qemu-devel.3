Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60A4CD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 10:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtmbf-0002ra-BW; Mon, 08 Apr 2024 06:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtmba-0002qP-Jw
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 06:52:05 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtmbY-0007r0-Dr
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 06:52:01 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2d6fc3adaacso54378891fa.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 03:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712573518; x=1713178318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MNFkEWahBP6+0XNPWOMbRiFKrOw7mESIctQanLUg3j4=;
 b=v7sk+vPQQqcBIBr9wBaYl8id6gWxDAMt2HxYjO7j0vHBY2ynPyXJsSLHr+bnvW1hsa
 8xARVyNmH+c7KvYRgXFA+JSPVyCd4MXX0sJNJL6FpMek/zO9z3IM9xjDvilFX3kCVewp
 lT1bYwWI4M6uYzZAhdYYMySXBCtDg+1Q6/fyk+BodgVMDxAIRU+oQr12oE+6U7/0hiFa
 WEuJTacypyO8zYkgLvqcAO01uksNE0uHfjpwv/I/jJxhJj941zwSfrCxtc7/hDwuVSzM
 vErmfb3QlBLQmqW2OcRE4I0aNVeSc24lbNnrUWKA5IFVVZdfRG2HCtXhsMurz1hEx2c/
 7xRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712573518; x=1713178318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MNFkEWahBP6+0XNPWOMbRiFKrOw7mESIctQanLUg3j4=;
 b=ejIAC/6JzpeVQW/bHGWuIrGK96Dj1DZyaiCJHNxQ/GP7yMBxG12BsKuWUNH+q7RKNJ
 xHRtWBCL+nneh5jtrvFMA6GlbXqyvsSDU0yjFfSB8BYSm7zoW2Bz40KD8r1lJb9DcID0
 nm0f/SD+tPCK8YvYXUhZb0HFpa3l7WzhXNOsR0iH191nkCqiKlAQhJRgaj2QHdVSh1Hx
 WN2ZgMN70Rp+Shk4YkMsfXzRt7lXS4bHEQ+5g1D25iNNNZo+sMUXC0UPu68qrIFGenx7
 +8YOxJYaqdhVRtXB+QeYjq1TIovwwasb+CQ9GsJguFqYKh7xiQJBZOn9DXX98OMHNf1j
 Popw==
X-Gm-Message-State: AOJu0Yy33A85AjLg5uTMKAjB/z/cChGWy7OwTHUac8lgKniFkvNNYkkn
 MwrUrEYvZkBNdHic8W8VOM+QwugZFymmjN+ot2aAIjnIzVGarf1U9zPXcgxcCGdMdg8j0BwKQY8
 H
X-Google-Smtp-Source: AGHT+IGuU114wAEJj6GTy0xj0eSHS45aOJ0lyqmd3sNchGCSh5YOJbulHyRvt04fKkf7lD3WruBIkg==
X-Received: by 2002:a05:6512:554:b0:513:da61:9b46 with SMTP id
 h20-20020a056512055400b00513da619b46mr5192172lfl.53.1712573518197; 
 Mon, 08 Apr 2024 03:51:58 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 y13-20020a5d4acd000000b00343eac2acc4sm8044440wrs.111.2024.04.08.03.51.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 08 Apr 2024 03:51:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 qemu-arm@nongnu.org, Chuhong Yuan <hslester96@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0? 1/2] hw/net/lan9118: Replace magic '2048' value by
 'PKT_SIZE' definition
Date: Mon,  8 Apr 2024 12:51:48 +0200
Message-ID: <20240408105149.59258-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240408105149.59258-1-philmd@linaro.org>
References: <20240408105149.59258-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/lan9118.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 47ff25b441..7be0430ac5 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -150,6 +150,8 @@ do { printf("lan9118: " fmt , ## __VA_ARGS__); } while (0)
 
 #define GPT_TIMER_EN    0x20000000
 
+#define PKT_SIZE        2048
+
 enum tx_state {
     TX_IDLE,
     TX_B,
@@ -166,7 +168,7 @@ typedef struct {
     int32_t pad;
     int32_t fifo_used;
     int32_t len;
-    uint8_t data[2048];
+    uint8_t data[PKT_SIZE];
 } LAN9118Packet;
 
 static const VMStateDescription vmstate_lan9118_packet = {
@@ -182,7 +184,7 @@ static const VMStateDescription vmstate_lan9118_packet = {
         VMSTATE_INT32(pad, LAN9118Packet),
         VMSTATE_INT32(fifo_used, LAN9118Packet),
         VMSTATE_INT32(len, LAN9118Packet),
-        VMSTATE_UINT8_ARRAY(data, LAN9118Packet, 2048),
+        VMSTATE_UINT8_ARRAY(data, LAN9118Packet, PKT_SIZE),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -544,7 +546,7 @@ static ssize_t lan9118_receive(NetClientState *nc, const uint8_t *buf,
         return -1;
     }
 
-    if (size >= 2048 || size < 14) {
+    if (size >= PKT_SIZE || size < 14) {
         return -1;
     }
 
-- 
2.41.0



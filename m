Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADF3C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 13:19:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLjXt-0002iI-N8; Mon, 24 Jun 2024 09:15:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjXk-0002Wm-IG
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:15:38 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLjXj-0005Pf-0z
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:15:36 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-362b32fbb3bso2930488f8f.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 06:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719234933; x=1719839733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Te+GIxXW5gxfuWRPules7rOyRScrC1BJa4kjtT/0R0c=;
 b=EcW/XXJF+iN5ouAe7RWaQicBoYHFZj3RWCaz5nAgCtl+4mBKv1QjL1czSvuZtaCf2x
 mXEOW7sMhx+jFpIdbJrvm1bKiXsbcTJEOl5wkGxGLkpSlp6gzsV4YAIqR6NqUbKfBWoi
 f7YdUx3bXZzYpg17/cvIrEpPd9uLKOgW34HeFfYx5dpWE4e+Yk1hYuRlDD9d+AGYZTTu
 +rQ2PNxGK0FARe//K9HrOM29szC0005cM3Gl3zDZV4+1QZtcaehHxAD/G85uL0IVu8zf
 HHdkWPIwP9uDECxJ70SEmzOHBG6F83S1RKD+yKOT+R1HWeRpPwpESrdOglKq06QSn9WV
 M/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719234933; x=1719839733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Te+GIxXW5gxfuWRPules7rOyRScrC1BJa4kjtT/0R0c=;
 b=KPNaStrdW9SPDwASSvv2X78zllXamNZeKuOWICymMFgJdhRoLwZke0B4KhJzWCakUa
 lE9N/rY1HfmqKP/7rJp+eyaPh8bL5vHz62gM+CagIOWa46xE86KwMOc+0jkjr3/VjWGg
 d5C1fyepsuEcKq269lugPV9+aTMDZVwfC/w5EkfxPjmO/9Ffn/EFNeQs4EG7zsoekbqr
 2tnbnu9IMN+mwP9cT8ZVJKrAMfwk7m6aAkP9obWvIv+HtWVFmBoGsy03MSCcmRKsB1Ij
 O4lvQeR8nHupbBkueG0A2tl3VE48b4nJ8Q/XFm8wB/vdlGpg01C5RYNmCT1mAHI4DAYl
 yWBg==
X-Gm-Message-State: AOJu0YxTPcerKtdMoGa9PyBF6Xj24nrfBUlpa7YOmzDXxDpvUasM6JBJ
 MmSmA2GlknmEL0aMcNTNoczWCRNSO72yE363eARuZdJkVALU17H6DgNGOXme51WnHyhrkeDm5TO
 8
X-Google-Smtp-Source: AGHT+IH6toEszfWTYfOKgCh9I2fmxLt20QYVDKJ7HQVNVoi5h4sWO0/cOZ+E6wYKJF+5qP1VkOoOYg==
X-Received: by 2002:adf:f610:0:b0:362:bb3e:93da with SMTP id
 ffacd0b85a97d-366e7a637e1mr3579520f8f.62.1719234932841; 
 Mon, 24 Jun 2024 06:15:32 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36638301cffsm10046735f8f.10.2024.06.24.06.15.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 06:15:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 09/19] hw/sd/sdcard: Remove ACMD6 handler for SPI mode
Date: Mon, 24 Jun 2024 15:14:30 +0200
Message-ID: <20240624131440.81111-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240624131440.81111-1-philmd@linaro.org>
References: <20240624131440.81111-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

There is no ACMD6 command in SPI mode, remove the pointless
handler introduced in commit 946897ce18 ("sdcard: handles
more commands in SPI mode"). Keep sd_cmd_unimplemented()
since we'll reuse it later.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240621080554.18986-8-philmd@linaro.org>
---
 hw/sd/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 6e346e28ca..08a6d0aff8 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1012,6 +1012,7 @@ static sd_rsp_type_t sd_cmd_illegal(SDState *sd, SDRequest req)
 }
 
 /* Commands that are recognised but not yet implemented. */
+__attribute__((unused))
 static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
 {
     qemu_log_mask(LOG_UNIMP, "%s: CMD%i not implemented\n",
@@ -2154,7 +2155,6 @@ static const SDProto sd_proto_spi = {
         [52 ... 54] = sd_cmd_illegal,
     },
     .acmd = {
-        [6]         = sd_cmd_unimplemented,
         [41]        = spi_cmd_SEND_OP_COND,
     },
 };
-- 
2.41.0



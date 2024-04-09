Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B792CD1299
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 10:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ru992-0001Q5-P2; Tue, 09 Apr 2024 06:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ru991-0001PQ-5z
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 06:56:03 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ru98y-00039r-IL
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 06:56:02 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a51d0dda061so296776866b.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 03:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712660158; x=1713264958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9koRp/akTxCLkggEjRm+VVx6B9q0FvygX7l6hjj+Eio=;
 b=Oa9cNFhtX1Sv9iAqsWZBpBWnRLhlHtuoXu952DnD7cVr4d8WeStvenuTuy12dbOL2S
 s2iWZ9fCEPFkoc7zMMP8HjTsM0DwUTC8ZY2D+hPXulHYcj5sweRYp/g4x+zRcVjv+RoK
 m06KbbQeO1sql7HlrRGlnpZSKIyzMBte5aj3egixHIKJb9uek6otm5rbEJWAUL3GgISG
 3NHTRUX0SEu928mek/3amMxzySY0ACUkMlJXF+kAsVtYox1bG7IVbrR61CsWrStLJppb
 6EPTrJho/RBk9QGbulJDQNUVMaH4Lo7MBz7UlDNnpeDfJtBbCAk6qQvr0WToiBfkHSK9
 PBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712660158; x=1713264958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9koRp/akTxCLkggEjRm+VVx6B9q0FvygX7l6hjj+Eio=;
 b=FNQa/zAL/6xnXTcR7rxFaKyyRS3kom+VE+rQs1BPRKca75ZuAnuyD2WewK6cFMi5Fp
 QvBvCrbXOU7yZNZftCR396DulpzD31ZUNwBgbSPDnY5WStW+kR2qFcVUcKY4jCgWM00Q
 cgftRTUbigQ0kFG69uXa6ot+PZB1uYjdF+tn159a3bnAIlcUuU4j0Pkz0AGf32732lus
 SWa0Wysd0Zl9G4zlVhZLPGuqeoSQeIVXS8MrMj9STyg00TeNxQNg676+IiSiSi+bCnXe
 0rhqPBHOpoei217jZb7H+oGR5JpjxzTjt1aTe2rjQEEwi4ASSgT17/MEg7rLom+SM7iF
 kTHw==
X-Gm-Message-State: AOJu0Yy+DgnQ5cURBPZuEb3vOOLLP902w+qV5cRH/po2y/5HwiDjvE12
 SCK62Oj2LAFO20FsZ7KLfqTJD5Q+LsM9RJldJ5af6GsLecZXFZ8BIsbshY8SjtzKPV/4c3G7Gv5
 G
X-Google-Smtp-Source: AGHT+IEC0/VDjJWrZqo+C4W8afMaFOf5E/U93L3cdKZ2Wht73bcqH0umZCGCs+2Na3IaAARxZO/NSQ==
X-Received: by 2002:a17:906:d205:b0:a51:d081:4bab with SMTP id
 w5-20020a170906d20500b00a51d0814babmr1999966ejz.21.1712660158691; 
 Tue, 09 Apr 2024 03:55:58 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 gl2-20020a170906e0c200b00a4df5e48d11sm5565924ejb.72.2024.04.09.03.55.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Apr 2024 03:55:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Amit Shah <amit@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Alexander Bulekov <alxndr@bu.edu>
Subject: [PATCH-for-9.0 v2 3/4] hw/char/virtio-serial-bus: Protect from DMA
 re-entrancy bugs
Date: Tue,  9 Apr 2024 12:55:36 +0200
Message-ID: <20240409105537.18308-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240409105537.18308-1-philmd@linaro.org>
References: <20240409105537.18308-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

Replace qemu_bh_new_guarded() by virtio_bh_new_guarded()
so the bus and device use the same guard. Otherwise the
DMA-reentrancy protection can be bypassed.

Fixes: CVE-2024-3446
Cc: qemu-stable@nongnu.org
Suggested-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/virtio-serial-bus.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 016aba6374..2094d213cd 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -985,8 +985,7 @@ static void virtser_port_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    port->bh = qemu_bh_new_guarded(flush_queued_data_bh, port,
-                                   &dev->mem_reentrancy_guard);
+    port->bh = virtio_bh_new_guarded(dev, flush_queued_data_bh, port);
     port->elem = NULL;
 }
 
-- 
2.41.0



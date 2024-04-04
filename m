Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BF7CD1297
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 19:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsSXF-000655-6c; Thu, 04 Apr 2024 15:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsSXD-00064l-Ua
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 15:14:03 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsSXC-0005Yu-5m
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 15:14:03 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56e2ac1c16aso438213a12.0
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 12:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712258040; x=1712862840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nmbBsanBBRtDgmvGjwsi0q571XomYrt8GuyHHF5Ax64=;
 b=lwvE15QOJt8t4LqYJ07SG7cf/PGyJqINW/i+W2+cpxieWsDJFelgASEOCynp34R6Tb
 LSHPtSnZSFHgFfgiMcjXpyFlnNRAv9ipNXzBefJPz0M9/komkmWLgwaK9DXfOG2Myd5S
 CxQAqVO+XprMdacc4K2b9KkDmbFZHmIFIjkLasl7tOiEUnth3qIvZljt+muq3ZYdoeeo
 UE3r9OniJfGbdBxLTpfHmRJoGtJAoZrQ56OhHbYisE5v11tOWJFBibRM3gpAOGmAyvQ+
 uHWN82lyWNEG8w8NCI/N38N/Fg2p+cvOHI4eyccnXuhb2jtZC0wEIBYl5bwn0cosnSbU
 PnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712258040; x=1712862840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nmbBsanBBRtDgmvGjwsi0q571XomYrt8GuyHHF5Ax64=;
 b=GwfgdhSwy3D+JWW0oBvWqSQENcirf7UbnxKDODQIHBg4AsNiW+VX4H0+ueTNgjSCep
 Az8LnvabpUSdDRbqWFOYeEXpWkjvtNjtbXwyLojOuPJmGlRg/9trVS61YRxvsHJ2w2HO
 GVLxOI2MUGeH4zwQWCE7EWJKIng2jswg2dXk3ivJ21IZlrMMFbdvMjnhG5n4pPg0pTrS
 W/x+9CkrtoHWJPeF2GVb9M6GzWP9TF9Bs3+4mtQkoubV1NXmWk86hln+ThIZgnSu++Q9
 Ist27aIUaf7wHFNQj1lLI8ncA3A+3XBytVDBlb1mvY4y7UWLtW1wDUlGO4CtQOgNT+/X
 8QFQ==
X-Gm-Message-State: AOJu0YzERTgaMPpD7bQuShsybg8oPGxHOr8bPwNm3/d+nK5Ysi5brCGz
 PQq4sKkH1iLhF1BmiVirBRlBDh+AHPRR96O9syLKR+40/a5XYwKkgRF+3a0s8OUyJMwRW9c+K2B
 M
X-Google-Smtp-Source: AGHT+IHzQgExUEiyKXr1XoMxerC8C70IW7AvrBGiWSbZ5JstN9UY8fZogPe4cUUzTBQ3aTyLU6gXyg==
X-Received: by 2002:a17:906:c449:b0:a4e:2f6:ed21 with SMTP id
 ck9-20020a170906c44900b00a4e02f6ed21mr2183209ejb.41.1712258040484; 
 Thu, 04 Apr 2024 12:14:00 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.216.111])
 by smtp.gmail.com with ESMTPSA id
 l1-20020a1709061c4100b00a5194b5b932sm618492ejg.16.2024.04.04.12.13.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 04 Apr 2024 12:14:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Amit Shah <amit@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH-for-9.0 3/4] hw/char/virtio-serial-bus: Protect from DMA
 re-entrancy bugs
Date: Thu,  4 Apr 2024 21:13:38 +0200
Message-ID: <20240404191339.5688-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240404191339.5688-1-philmd@linaro.org>
References: <20240404191339.5688-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

Replace qemu_bh_new_guarded() by virtio_bh_new_guarded()
so the bus and device use the same guard. Otherwise the
DMA-reentrancy protection can be bypassed.

Cc: qemu-stable@nongnu.org
Suggested-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/virtio-serial-bus.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 016aba6374..cd0e3a11f7 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -985,8 +985,7 @@ static void virtser_port_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    port->bh = qemu_bh_new_guarded(flush_queued_data_bh, port,
-                                   &dev->mem_reentrancy_guard);
+    port->bh = virtio_bh_new_guarded(vdev, flush_queued_data_bh, port);
     port->elem = NULL;
 }
 
-- 
2.41.0



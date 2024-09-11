Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34ACBEE499D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMJj-0000nD-Tx; Wed, 11 Sep 2024 08:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMHt-0001AI-G8
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:17:35 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMHd-0007Xj-PK
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:17:23 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-374cacf18b1so3844308f8f.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057024; x=1726661824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hfxOj5NR0Ht31q1ownUsuoc8rftv6XD0P5kK9ITK60I=;
 b=JcQRuHyAOYdj3XHK92dOLtLBqWhhC27BjxwbOLPanW5rRHu1YVOslRhymNJQiflhQw
 ARXcPp0yN65ArXGPo0TV6hVOrWO6nczgLWgrXhw0C7yngrH3pGnqwSWCGPlqXbF4+ba9
 53DJ3/E3cu01uhsHw4R0H31ZhoM/DKTSNTs6pxUESTskHGGQDqrLL49SAzemXdEX/lbX
 dWyI369bBZ8J8tIPmuWuiaIYKzi9ZtPojoY23097AvzGSlZRxMHjBKGiS1+KxosYZUYl
 TROjPiOaNgb4nmOZxN8z2VvWeIv+2LGPDocz6e3qu5CRCwQSJkNtKxFuDX/1XFjtNCDR
 eyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057024; x=1726661824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hfxOj5NR0Ht31q1ownUsuoc8rftv6XD0P5kK9ITK60I=;
 b=wh0tiq8qxCQkMpRRv908ochjpKPFlzJqcJLm6d96IEr84Uxcy5LjHyH7haXhsyl5dk
 FsPCGa/7vtU01yDRKPfcpvcihpnKFbSURnhKJdbCKaVfBp0jtrHx3lVdMUIfHvAOCYsr
 xfIHhsubWwBzbSx3k3v+X+bZI923e8OUDoHJRWUcPXarIU/ddjEJ4YNcM0+P0Iwqm/uG
 1NzlZyugTwHBE+fqHD70eF4XdP0fHfbUdCt43CqFTbG3//jSLU06swjHie9sDNFQDL3m
 hd4bDwsAqoZDR8iQEJBry/00OA6pyIoIn6QKv9UIjhUHAArktd89H6GP2TU0hBL6qrCE
 y7nA==
X-Gm-Message-State: AOJu0YxO+CtX1zZj9ZN6Uq4ocz+2kZCgBh21KdKgq1IL54g6/UYCR9Q/
 O+f/CUUYZaSJOV4C6zdd9jJ86tD12ga/+k/of0oN8Zzu4Q2fC4m6IT8eDiCWc7agLZemwudLBcE
 0
X-Google-Smtp-Source: AGHT+IG09Pk6Nh0NqE+9UitbkvuQExuSvPbKMYBjNVTuyMyrtJMGO+z4MU6z9UZa2UMMMtaQg7wr7g==
X-Received: by 2002:a5d:4609:0:b0:378:8dea:4bee with SMTP id
 ffacd0b85a97d-3789269ed5bmr7520785f8f.33.1726057024211; 
 Wed, 11 Sep 2024 05:17:04 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956654e8sm11446564f8f.41.2024.09.11.05.17.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:17:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 23/56] hw/char/pl011: Remove unused 'readbuff' field
Date: Wed, 11 Sep 2024 14:13:48 +0200
Message-ID: <20240911121422.52585-24-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Since its introduction in commit cdbdb648b7 ("ARM Versatile
Platform Baseboard emulation.") PL011State::readbuff as never
been used. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20240719181041.49545-3-philmd@linaro.org>
---
 include/hw/char/pl011.h | 1 -
 hw/char/pl011.c         | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/hw/char/pl011.h b/include/hw/char/pl011.h
index d853802132..4fcaf3d7d3 100644
--- a/include/hw/char/pl011.h
+++ b/include/hw/char/pl011.h
@@ -32,7 +32,6 @@ struct PL011State {
     SysBusDevice parent_obj;
 
     MemoryRegion iomem;
-    uint32_t readbuff;
     uint32_t flags;
     uint32_t lcr;
     uint32_t rsr;
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index f8078aa216..260f5fc0bc 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -549,7 +549,7 @@ static const VMStateDescription vmstate_pl011 = {
     .minimum_version_id = 2,
     .post_load = pl011_post_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT32(readbuff, PL011State),
+        VMSTATE_UNUSED(sizeof(uint32_t)),
         VMSTATE_UINT32(flags, PL011State),
         VMSTATE_UINT32(lcr, PL011State),
         VMSTATE_UINT32(rsr, PL011State),
-- 
2.45.2



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96E23C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvpi-0000TG-9L; Wed, 03 Jul 2024 04:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvpg-0000SM-EP
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:59:20 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvpe-0005qT-Jv
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:59:19 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so2388515e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 01:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719997156; x=1720601956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fgn8PLemwWACiNJVUNHy/Gc3f7nfIUu7gDJ9WbyXjRw=;
 b=j3CdjjTSeqZerS/Ln4LFs6tZ73YDz9s1qmkVtQigkZPEnSh7t3Tob5rDxHs5HTUKsD
 Ko3HdKdw5rCh256ENX5pDwlo5zdWWIEHoTNQf8IHV/I1X08+AkIQ/uI8twGLpzLSm4P2
 02EmRgaLqfRV7PhQhLoxigEF7daErAST0AUoQU7crB61guFjmhNcezd+xQI8M1rfKaPp
 FBYWJf7IXAjE8OlNRz9TUeT/0CIpVTX6KIMmXGt2X7GfElH1yZgW0wAxBHIDscbngtbx
 KFOTQyBCD8LTt1xJ/bSyut1N1W9QO+pB0ymc2riXMyZ35CxbtMHifETwOYv6RwWY8utp
 lBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719997156; x=1720601956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fgn8PLemwWACiNJVUNHy/Gc3f7nfIUu7gDJ9WbyXjRw=;
 b=h0niJPTnfV+smWKHtayAgmincuXf3yA6h5HepOI5dTdytjMyNsNtrj+iEvt2mjPsal
 JEJfVItV+qBlH3l/g/LThctL9Gv4VGGqE3s28EAmxWzO4LmIIjCYB6BdiG+xrE35I/Eh
 +u71gapD59U85jh1HYLo9l7nN4QbwCRbRiwTOPzIneJBwU4wSqNJyjodjGHxOabqdMsC
 lICr578ctKMdXjZ1nnv0tdl4OlJPeHPl+eyezh1x8M4Ctjx5g8rOGplPtdS4YPtlw5wZ
 Nh/d4L7v3FXl1vsXmQxznrAp3u/5UJSk/EUiS9KWYVu7HOOoBQWR1PB1KR/2YMeHiA4B
 4p2w==
X-Gm-Message-State: AOJu0YzbGF7Cko0O65T7KfYVW2MbYoa+SRaVrcoutyVDJMrh1eL4tRoc
 nMSt+IgilR6ELom4pbVLx0IxclNIQsQHVWoe37TYYATMq10JDopkuYiVGhrHlQhuACzm8FHxtMw
 6
X-Google-Smtp-Source: AGHT+IGqnx9zkfeEAdjOP3+3kUaphK2jefMjYf7dZLfH2PmYZPSn5gOWe0AvEdd2DXWMvz19RcoJcw==
X-Received: by 2002:a05:600c:4f42:b0:424:8dbe:817d with SMTP id
 5b1f17b1804b1-42640914a77mr8741115e9.10.1719997156514; 
 Wed, 03 Jul 2024 01:59:16 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af37828sm237052545e9.9.2024.07.03.01.59.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Jul 2024 01:59:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v45 1/3] hw/sd/sdcard: Remove leftover comment about removed
 'spi' Property
Date: Wed,  3 Jul 2024 10:59:05 +0200
Message-ID: <20240703085907.66775-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240703085907.66775-1-philmd@linaro.org>
References: <20240703085907.66775-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Commit c3287c0f70 ("hw/sd: Introduce a "sd-card" SPI variant
model") removed the 'spi' property. Remove the comment left
over.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b158402704..53767beaf8 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2473,10 +2473,6 @@ static Property sd_properties[] = {
     DEFINE_PROP_UINT8("spec_version", SDState,
                       spec_version, SD_PHY_SPECv2_00_VERS),
     DEFINE_PROP_DRIVE("drive", SDState, blk),
-    /* We do not model the chip select pin, so allow the board to select
-     * whether card should be in SSI or MMC/SD mode.  It is also up to the
-     * board to ensure that ssi transfers only occur when the chip select
-     * is asserted.  */
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.41.0



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C47ECD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 10:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSBal-0001Dk-TX; Wed, 27 May 2026 06:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBaS-0000m4-0s
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:34:12 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSBaO-0001b4-LU
 for qemu-devel@nongnu.org; Wed, 27 May 2026 06:34:07 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so122391915e9.3
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 03:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779878043; x=1780482843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BDxMo5/9OgUZXKqAgMxYAx4x+l4PPjRCkQ2+p6SpiYc=;
 b=m+20tJRzEIfxPOrlRH9ZkGFNTg1F4o52F/7feDAIPQC8Q4aKWPkfxz+wsWcgglNzNA
 qteA4crZUQZBEtHr7OTjEIr75xTy1/IGELF3hL7e1+TuddSi85GkQa6N1qgT+VblH1HN
 AnPtv/U2IFbX3AyCvpQa6spb9q6K/vK+g1lZAHw7WqVssXghtzNjt7Jsdk3lByS7BOqr
 XelNoU2Npo1KSS0sCqiDlZI6XAS5O+VCRW8P5Rykq5fT9UOcD6vyo3Kya7JMxbuiMZ4E
 OhyyAdomBWp/xgfgrrdK/RxYadq2uavqAIGTDa60twvR6WSncAWEXAd/krnWS6cIA7G2
 9jgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779878043; x=1780482843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BDxMo5/9OgUZXKqAgMxYAx4x+l4PPjRCkQ2+p6SpiYc=;
 b=lV0ZBjHaCwowZEJiTnsybsxpIGZOH7c34Gi3uy9RFdb0gXQhVMOFPfskwdauBgc8f1
 uDcgrG3tD3OFxdLSBX34jidmi0DxOkONs3DvVgYi1q42NajSIin6zh9xK3zbCbuQokNH
 NXP3rnQzLn0f8y2zb5c5bMARinBEaQpRXGGs3VDJb4odGj0aNA1Q/m/68vtTzrzCBMol
 unobPRT1XQBg2BhvL7yS7zQTkqPu9BscGtI1Za1179RJFySdt+E75SsaD8pvrQ1g1Wy3
 RfHsM60a+3iF15xptzPAl2Ra93vpnIXEWcL5UllIgcAtfEdTSb00fCWCvozc1nLcS28c
 r0/w==
X-Gm-Message-State: AOJu0YyXPknjMovSfz9TQQtHKBMbt2K5QFowJwcZN58DBI7471L3pWVm
 /OLCwI9CRBDiAmNZQWcmrx3f/FCwuDLVfQAx0cihPncMkSEoeK1ox1bJlyuLxFsOGhr6LlnmeRd
 WU+ghIYkWSA==
X-Gm-Gg: Acq92OGgsHZ6f0/m4as0USkZau4wMCSwniSvUmZQnboc0Ton6ZWCBPIbyqVdvvo+0w1
 duNGFz7hgj4V6rioipQNvBlq4ZazM0QmjOjndAZItnIE5RtRdy41Db01S4Yejht6/N6lrTxP5bo
 5yPKfS1lH8guOQ3RxYZrPUFS6zGM8FM8nvcbh2dK/Vv4crQiKqPI8SavtpR4q2xRz5kQiNuwOeD
 IE214LocBqZUTXkpPfhwmUBcaUakty9YyWsHe2/+QiN50saEX1U9lQK6Q3gwen027XBf0FTAfxS
 +3cmaDo5V6FtPfyM1J2WS8E4XXYIa6TOpMPmEM08ud2ObsCCozNdN4Lvq09fDHVfI4RIRoFIBjq
 QHVuOnREOiMbyV1RjEpvNbifZEUQthv60YkNYKkP9ze5FJ68TLxtJsDvXzxcZCvfba4Z9VhP+Zv
 RdYInIwTWlbCWtmQazchy95Wqb3Aq+mNUpySB+96pcswL4Y/6UEmw8VtsMKlK5GlLPQg==
X-Received: by 2002:a7b:cb8b:0:b0:490:3fdd:d353 with SMTP id
 5b1f17b1804b1-490424ad5d3mr240683055e9.8.1779878042843; 
 Wed, 27 May 2026 03:34:02 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904561a33dsm354994905e9.11.2026.05.27.03.34.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 May 2026 03:34:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/32] MAINTAINERS: Remove PhilMD from firmware sections
Date: Wed, 27 May 2026 12:30:34 +0200
Message-ID: <20260527103037.4461-31-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527103037.4461-1-philmd@linaro.org>
References: <20260527103037.4461-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

I'm not paid to support this code. I haven't followed
it neither, so be fair and just remove myself. Demote
the status to 'Orphaned'.

Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel P. Berrange <berrange@redhat.com>
Cc: Kashyap Chamarthy <kchamart@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260519173014.98967-3-philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <20260527063102.91205-1-philmd@linaro.org>
---
 MAINTAINERS | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd5c4831e27..15982c04614 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2874,9 +2874,8 @@ F: hw/usb/vt82c686-uhci-pci.c
 F: include/hw/isa/vt82c686.h
 
 Firmware configuration (fw_cfg)
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Gerd Hoffmann <kraxel@redhat.com>
-S: Supported
+S: Orphaned
 F: docs/specs/fw_cfg.rst
 F: hw/nvram/fw_cfg*.c
 F: stubs/fw_cfg.c
@@ -4004,14 +4003,12 @@ F: docs/specs/fsi.rst
 F: tests/qtest/aspeed_fsi-test.c
 
 Firmware schema specifications
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Daniel P. Berrange <berrange@redhat.com>
 R: Kashyap Chamarthy <kchamart@redhat.com>
-S: Maintained
+S: Orphan
 F: docs/interop/firmware.json
 
 EDK2 Firmware
-M: Philippe Mathieu-Daudé <philmd@linaro.org>
 M: Gerd Hoffmann <kraxel@redhat.com>
 S: Supported
 F: hw/i386/*ovmf*
-- 
2.53.0



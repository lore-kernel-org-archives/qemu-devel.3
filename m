Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49556E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 23:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMF9I-00049e-NI; Fri, 13 Dec 2024 18:32:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF8w-0003kT-09
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:32:24 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF8t-00036K-BM
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:32:20 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43626213fffso13238095e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 15:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734132734; x=1734737534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lt4NvnYVTtqdPMld1oQGXyolzuYk019fPIRKwhmtiI0=;
 b=v4yxnjHL0p1kDr48omlZvD5zvFpNMOvEYG7/lN4JnzKRoJqtWA5wRdo9x3Esmr8CnK
 4wBttLxpp/YmfmBwEQGGNNa4qeBbX1IF28TJIdW7Uj4zq6UR+ass1M11jt7A/JnH79L/
 7lxzB+BCVICWwiXLZG9o8UrAAv+R6wHQh96lzcYVJWY+66TE4f67odI9EakmlCzNr1sK
 f1UxLaRhYzxtgyAOwnXgYYuoUG7jbXCPVaHUblTvOQzks8+5gbvF4sSxCiuVyrnPbBGP
 zg0cHaXs0FQ/G/gp8kC5dFortf+rOTyd6+mRT86JZAtlB504c5BRKtLQ0y1Mac5CzaXT
 +4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734132734; x=1734737534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lt4NvnYVTtqdPMld1oQGXyolzuYk019fPIRKwhmtiI0=;
 b=EJDJtCQdlKgTlTxD7R16FAzqG4HwzUV5vOCY15rCaMlSbsLT7WYSkDxzfrOC+CWL8+
 8Asy1mmYimqb4M2reUcyntX8MbS67b8yrWkRFLbRJc5iD80LrYXCXo7onLj7Xh5mK+Cg
 32W9zOKoc/gsavgcvlfxqHRnrDrjc+wBnGxHxTeR/AMKCA6AIRNpomU7yeDw7RsBa5H1
 0L8BZHTcVI/yngcbmlKvYD3TEp4y8tkZ490AWjuNghMmP6yHYTpEVF3W8LZSvx7bGA3y
 Fnu+z/fKZDgFUL8FQetHbrnVZFXEgkk6a4dgdUgDuDpZGDtZvJN6LzGOOI7pbEnQ87RC
 2iXQ==
X-Gm-Message-State: AOJu0Yy8+uQwiLgbnlAFWWDitypz1f2H/BNNfF3D9r6aNXHVpSs1Oymi
 GkYN23GLbHBhy/jeSFx1BbP/iabsCGr7DBj8JiR0YKG4uxgoMLHIzpMiHzRIQtj9brPu8Zpm8UX
 +ZGA=
X-Gm-Gg: ASbGncuGM+0CJFczQw0IQiG06LFjylF+5u2VwNIOAdE1vaMAf8g9sIEMBVf/wfolFU3
 8yYDwYag0Rmf4rP+/p+ckwFEN6UXRtOOTYOG8Ca7ZuCXeEuByHDlPCW161H5NeKtrbrj0/DyEel
 YqthnS+EsrYIeWh2tBIIK6u/gHBQ+MMmZ3slpj7LWa2ykI9+Q+cNs9NLxNX0YPMafdttyL+Ntn0
 K2xygdba8l+lGiQmYg8zK303OdPvd+tkalMPXp8+ckwSNinsJnM9TXjphroCRzu3a20yRsczXVV
 fdJfFQ==
X-Google-Smtp-Source: AGHT+IF5nX/6//qQ/UBpE7uBxrCqmP5UgpY1y2PWFdvI4t6UpDVjaIuKRkwSBuWKkEMc4EEXwMQxVw==
X-Received: by 2002:a05:6000:481c:b0:382:485b:f976 with SMTP id
 ffacd0b85a97d-388c366d18dmr3192610f8f.15.1734132733994; 
 Fri, 13 Dec 2024 15:32:13 -0800 (PST)
Received: from localhost.localdomain ([45.93.146.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8016bdfsm841465f8f.43.2024.12.13.15.32.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 15:32:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/20] hw/usb/hcd-xhci-pci: Indentation fix
Date: Sat, 14 Dec 2024 00:30:50 +0100
Message-ID: <20241213233055.39574-16-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213233055.39574-1-philmd@linaro.org>
References: <20241213233055.39574-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: Phil Dennis-Jordan <phil@philjordan.eu>

Fixes number of spaces used for indentation on one line.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Message-ID: <20241208191646.64857-6-phil@philjordan.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/usb/hcd-xhci-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index a039f5778a6..e110840c7a0 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -94,7 +94,7 @@ static int xhci_pci_vmstate_post_load(void *opaque, int version_id)
     PCIDevice *pci_dev = PCI_DEVICE(s);
     int intr;
 
-   for (intr = 0; intr < s->xhci.numintrs; intr++) {
+    for (intr = 0; intr < s->xhci.numintrs; intr++) {
         if (s->xhci.intr[intr].msix_used) {
             msix_vector_use(pci_dev, intr);
         } else {
-- 
2.45.2



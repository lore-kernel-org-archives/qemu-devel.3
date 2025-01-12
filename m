Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC830E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 21:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX55T-0004Rp-NY; Sun, 12 Jan 2025 16:01:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tX55R-0004R1-50
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:01:33 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tX55M-0006Mg-N4
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:01:32 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5d88c355e0dso6429930a12.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 13:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1736715687; x=1737320487;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y742HvnBW/DaljtWfLgOW0bZlwROPRmuvKZaV8wXJYw=;
 b=sqMyZGlussrSXI/NpkCg9lAmrMjNWWfDy+j88gi8D3IlDUwP24N2NWYg8pngQAOu4L
 nem3Upehu1+y0CFQCs+86+2nPRWysGh5SvdxctevMINYIYOsZH6fU04Iq99Z5Aig49YI
 mOQOOcn3I720mIRwlt1NEdaoh3zNK3olWsmP6VnE2vi3vKOBJFPzb1HUZW18v6DSXYgI
 6TqkZefjzZwLYXqQU8tMWTwiJhSWTfQFCySPbpOOfaJk3zNuqL2I7ToVbDSDXB4oXlW3
 j49Ljf39Gm3u7MDR6SwFwuYGugwK56IUaxVzb7cuSrTc0rxNFH1E1/PoS5MSCTBlOQ1V
 DiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736715687; x=1737320487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y742HvnBW/DaljtWfLgOW0bZlwROPRmuvKZaV8wXJYw=;
 b=HyOi55ZEuUwyxgpWDj4bTqnbAScZYgLgqN1JhYT9qmkVSPmNZIqlYhSCS/gx8ywprJ
 t5FFMoN15CEm9QzmfA9XSX9uhgMpDGVd4Getw+VBZ5mQvToqZh0/V+wSsKLLitY49WlF
 AVgd6MK/zYfDkqXqfCCtlKxrXRAHf/7hN7aYpqbTmXxy/w1y7beziaV2Ur1ZaF4exqlJ
 WAQ2dIewoRV6flxad34IisPGBjT/cVsemvbjoHm4u8qEs3H7KzurP82l+EdT/nw/rNme
 b4TicZZbBbMHwrTtP7nR09vVIxkcJhgGBqgP93HU3HYuvCekT6c78mrqYbRsZya4hEdk
 r0fw==
X-Gm-Message-State: AOJu0Yy3vTm7KufKaQQiqBOYzLM07Mz96Tbobfesc+EzbO9XUqRJIpaB
 /P0gytJQ1gh/q7c+OlozwwYZLaqRszhHsg1fBXuVLvQRDP0p1G9Jjt+VAsoFohWN0qBfxQ8Cs5A
 FVQ==
X-Gm-Gg: ASbGncvnTf0Um7j7wsA3KJlRz+CDhEatJ3VYnzUBwDynd5Oh8lRZWHej1SHf25DvHDW
 29So8PST7gV/lk07It9U3JDaXfQ2FT91+FSgrAeUlcv/pSCXNvDE+G3sC6r6o50inFvdhsznSXz
 F2dOuKiBKfd9G60EI6hB87oEXj+2l5BlnxDmoc1nBTHBCB6bcFQycidhQRLLgqnqctS5+W8gQIM
 zo75eN/ogJi3BAbMPwE4lmArYtm9XrsS/OBu6OkzhQnGdeoYsPDbs+QM0lGqa1pTtGGiDf5o6Os
 8hvMP1n0kuqDbJ243n1xhSpxIYP+v5NE
X-Google-Smtp-Source: AGHT+IF8ib8KPBCDqP3pUOpHbbVJfb4vIM+xZ+zpuHk1n/+0FRttrfmhRxbbEYdcMTGIGevD8mK5Fw==
X-Received: by 2002:a17:907:60d5:b0:aa6:a228:afaf with SMTP id
 a640c23a62f3a-ab2abcb139cmr1756254366b.52.1736715686921; 
 Sun, 12 Jan 2025 13:01:26 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c905e283sm418276666b.31.2025.01.12.13.01.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 13:01:26 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, phil@philjordan.eu, peter.maydell@linaro.org,
 pbonzini@redhat.com, mst@redhat.com, stefanha@redhat.com, kwolf@redhat.com,
 hreitz@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, marcandre.lureau@redhat.com, philmd@linaro.org,
 eblake@redhat.com, armbru@redhat.com, qemu-block@nongnu.org,
 qemu-arm@nongnu.org
Subject: [PATCH v17 01/11] hw/usb/hcd-xhci-pci: Use modulo to select MSI
 vector as per spec
Date: Sun, 12 Jan 2025 22:00:46 +0100
Message-Id: <20250112210056.16658-2-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250112210056.16658-1-phil@philjordan.eu>
References: <20250112210056.16658-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::52d;
 envelope-from=phil@philjordan.eu; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

QEMU would crash with a failed assertion if the XHCI controller
attempted to raise the interrupt on an interrupter corresponding
to a MSI vector with a higher index than the highest configured
for the device by the guest driver.

This behaviour is correct on the MSI/PCI side: per PCI 3.0 spec,
devices must ensure they do not send MSI notifications for
vectors beyond the range of those allocated by the system/driver
software. Unlike MSI-X, there is no generic way for handling
aliasing in the case of fewer allocated vectors than requested,
so the specifics are up to device implementors. (Section
6.8.3.4. "Sending Messages")

It turns out the XHCI spec (Implementation Note in section 4.17,
"Interrupters") requires that the host controller signal the MSI
vector with the number computed by taking the interrupter number
modulo the number of enabled MSI vectors.

This change introduces that modulo calculation, fixing the
failed assertion. This makes the device work correctly in MSI mode
with macOS's XHCI driver, which only allocates a single vector.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---

v2:

 * Switch to modulo arithmetic for MSI vector number rather than dropping,
   as per spec.

 hw/usb/hcd-xhci-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/usb/hcd-xhci-pci.c b/hw/usb/hcd-xhci-pci.c
index a069b42338..49642aab58 100644
--- a/hw/usb/hcd-xhci-pci.c
+++ b/hw/usb/hcd-xhci-pci.c
@@ -74,6 +74,7 @@ static bool xhci_pci_intr_raise(XHCIState *xhci, int n, bool level)
     }
 
     if (msi_enabled(pci_dev) && level) {
+        n %= msi_nr_vectors_allocated(pci_dev);
         msi_notify(pci_dev, n);
         return true;
     }
-- 
2.39.5 (Apple Git-154)



Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AFCC5DF74
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 13:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwJvp-0003n2-9g; Tue, 18 Aug 2026 09:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wwJvo-0003m8-3z
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:32:44 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1wwJvl-00008r-7m
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 09:32:43 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4955aa106b1so42313995e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 06:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787059960; x=1787664760; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0bkQ7XcsLrO7GnW6QWyxFWLeTXrsnESl6attSVhp0hY=;
 b=Zwgj1UyqHyCo8yOfidSMB1geDe5gb3BPtv880s0BQH81TgpFWpp7zh81D8WevR0rvv
 gAoCVU4lJEqqW2NtQQTswtWvfF1nQXzAUfybmJe8IQcmbg3axMzVhjBt0ngfYdBoYhkV
 1vzxWs6m2lIckMAC4O17hq3m2LI63K39eLFFF3eUDlUIX2SP5MM2daMcFYHTgfuZZItp
 mOj57jj/poCijicKW4cN2B8svkaDLxsbz0yco3XzoYcHoHDSOFOwEDrN5hxQYbyw1ODW
 DjVKxtVqqNRx709M9XzrOFVIcqZyxb2MaD94MD/kaKQ4x0L5eGOfvMDN8PLSkRyxHlYY
 l7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787059960; x=1787664760;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0bkQ7XcsLrO7GnW6QWyxFWLeTXrsnESl6attSVhp0hY=;
 b=SQQGGLuG45nWyL2bKCzetn1JDarjozznYTR6KGo/OxIb7ozpXvuUIyl783cwWMX84P
 xl19VTeD1F8EKE4SkKLNOHyC6rv9AQ/XduZjV6UBL+KQh0OkBHxnQNOhEdr+Lu2f82n0
 GNSG44ZzTH4N5O30YGU+/pCJZRkp7JJCDzDjXRI7fnlLXO8k/VcQnk/rFrzIhTpfFlHX
 XIIV6Ag6exjHfXwMm3tnTtMyr+E829mU6mbedS0RYbDudFdqU7ni7G6tms8HgskcALgi
 jRafytDVQEOPKPRwMnOU73OowaIytggJrlvbv8EOHAlSY240tpleqVv4UZtS0Bn0w3zG
 qerg==
X-Gm-Message-State: AOJu0Yx2/tXlK3nf1fjDXHjnnt80Fmv40aFAfXrq6R7YHeBQRmP1JJ4J
 wVtcfJb14j7FFCXPfUYesnXBJyLNuTX9+7XLeY2Sd+W4N6hRN98OtgvrqE+JH4qCFsLrTa21+Ai
 CaC8Bg2I=
X-Gm-Gg: AR+sD116R6Olrsl5UcIx0r2v9IvPxHWE/imYeM0+dOZeQqE9YV7lABmYSVWFoyI8/IJ
 25t1gMX1E+2yBJzn7EDAf7wks5ZswXQUWbIVGd3P+0PtFI6CTnO2YKBBO909IaJ5NXsKsM23eYl
 P8iWURefRUYKt7V1IJ5cfPNFA/FOS/CLqlXTZkqPhWIskyTYuM00rTDIknZp23+nFTsnrD3dgXV
 1vKc0LjBxZIl7ptajw/kBhomNGVffVIUaNF0vBkapraN+QicSL8WZ6c4XNFgAgLbIsjNXMPEsrs
 W41FAGg+JS8y5tIAsie9TE1KZcOF1slMSF7FS5HwPCq11MyqMZFdfDCbvHDTwlPJcJEt7Pt922E
 vCMw1+6c1Q9G+EmVgFGVQktumwTlWwRvuXzynVv28tNJg84GiTUwErMLJ4pT7TXa+Yp3+OjXp6j
 oBG2EuDTfNVPl3B3vFYzgAYBg4rYCmnusPz5jAnImUlTCMOyytPRyXqsGgJYwRdXn0
X-Received: by 2002:a05:600c:6b72:b0:499:7a19:408b with SMTP id
 5b1f17b1804b1-4998795f96bmr430405615e9.11.1787059959875; 
 Tue, 18 Aug 2026 06:32:39 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:c289:2687:e46c:f7e3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49987b203cfsm298360625e9.3.2026.08.18.06.32.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 06:32:39 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Tue, 18 Aug 2026 14:32:02 +0100
Subject: [PATCH RFC 4/4] hw/pci/msi: extract msi_message_address_register
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-jmac-rme-da-prep-v1-4-30fab951bc75@linaro.org>
References: <20260818-jmac-rme-da-prep-v1-0-30fab951bc75@linaro.org>
In-Reply-To: <20260818-jmac-rme-da-prep-v1-0-30fab951bc75@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>, 
 "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x332.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

We need to access this address from smmu, to know if we are translating
an MSI.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 hw/pci/msi.c         | 19 +++++++++++++------
 include/hw/pci/msi.h |  1 +
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/hw/pci/msi.c b/hw/pci/msi.c
index b9f5b45920..7361776ace 100644
--- a/hw/pci/msi.c
+++ b/hw/pci/msi.c
@@ -137,6 +137,18 @@ void msi_set_message(PCIDevice *dev, MSIMessage msg)
     pci_set_word(dev->config + msi_data_off(dev, msi64bit), msg.data);
 }
 
+uint64_t msi_message_address_register(PCIDevice *dev)
+{
+    uint16_t flags = pci_get_word(dev->config + msi_flags_off(dev));
+    bool msi64bit = flags & PCI_MSI_FLAGS_64BIT;
+
+    if (msi64bit) {
+        return pci_get_quad(dev->config + msi_address_lo_off(dev));
+    } else {
+        return pci_get_long(dev->config + msi_address_lo_off(dev));
+    }
+}
+
 static MSIMessage msi_prepare_message(PCIDevice *dev, unsigned int vector)
 {
     uint16_t flags = pci_get_word(dev->config + msi_flags_off(dev));
@@ -146,12 +158,7 @@ static MSIMessage msi_prepare_message(PCIDevice *dev, unsigned int vector)
 
     assert(vector < nr_vectors);
 
-    if (msi64bit) {
-        msg.address = pci_get_quad(dev->config + msi_address_lo_off(dev));
-    } else {
-        msg.address = pci_get_long(dev->config + msi_address_lo_off(dev));
-    }
-
+    msg.address = msi_message_address_register(dev);
     /* upper bit 31:16 is zero */
     msg.data = pci_get_word(dev->config + msi_data_off(dev, msi64bit));
     if (nr_vectors > 1) {
diff --git a/include/hw/pci/msi.h b/include/hw/pci/msi.h
index abcfd13925..6f0e02c0fb 100644
--- a/include/hw/pci/msi.h
+++ b/include/hw/pci/msi.h
@@ -32,6 +32,7 @@ extern bool msi_nonbroken;
 
 void msi_set_message(PCIDevice *dev, MSIMessage msg);
 MSIMessage msi_get_message(PCIDevice *dev, unsigned int vector);
+uint64_t msi_message_address_register(PCIDevice *dev);
 bool msi_enabled(const PCIDevice *dev);
 void msi_set_enabled(PCIDevice *dev);
 int msi_init(struct PCIDevice *dev, uint8_t offset,

-- 
2.43.0



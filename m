Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BA6C79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:05:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WPy-0000yV-0w; Fri, 04 Sep 2026 12:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1x2WPo-0000r9-Tq
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 12:05:24 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1x2WPj-0006GA-Vj
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 12:05:20 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c262204cc80so40808166b.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 09:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788537913; x=1789142713; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0bkQ7XcsLrO7GnW6QWyxFWLeTXrsnESl6attSVhp0hY=;
 b=zAjXEIQmgWg2yDFTfYrP4bgtDisprGuUf+dyfjRcSDLzgVpSCEnnJiVqTr6H2ZWyZ2
 9KOXAOLb+CIgkiijDn0JRMZ7Q3SmEFnwRaY2H4+qzyxfaorbH3U443qSCr5/NvjUXGEz
 sua0fk/tPIg/5kgXkEpfVQrC9Peouccx0urQpWhT3nDfUE502udsr4D7svR3NLZGB56o
 xS26RzW6fnxHQm9BvwY19VReN9sFRxrSWtinJYrTeSgpWmUEeiE1UtkDbkrwACSJppys
 f/VcdKuFgmL+PTf/HaMK7L0hIdb3r7KYGNp4P74jCx9kldpPQ1vrKwOPJ2pUE7/XNzwd
 0UuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788537914; x=1789142714;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0bkQ7XcsLrO7GnW6QWyxFWLeTXrsnESl6attSVhp0hY=;
 b=V/0jdMKyzb6+PzYeVIUGksfw7j57WCMpF8fmuk327fHAbgMBmysg08EqgUROuvC4kQ
 5M5roQqeiCRw3j9WV/UQeD3FcwqHWEx2kcW3nozJECs040LeWxfSCIFVJtdHH+SjaU1u
 UYYiVknGvIuUWSIpyn+3xbSgs2H/K0vzmPDSr1MdL0nBY3AsQhxt4Yp861Lb2jfuefjE
 ye5kYXlOP7foRlSiEUpvEeCGSxLJvJ2m3yP96lxcxU/K9b2JH9wyqpuXZ2yHwFvnGhrk
 8O0TBgxXxGklv/j2pZ87MKwH50IWxMmdaNAmnRMCoz68qU4j0o/0RBEK875vKOOLGJTl
 s3yw==
X-Gm-Message-State: AFuF++lFqyhBoX/aNUdQuxCWlQjq3/1mEJ4QLb+W3M2IEqt73DRL2np8
 KjUBUbZjnfCeerSDCYne8dWmIPOQVVnVzHIoEvegiVT+G3zUeDzssTKk/BlY5rJTcaI=
X-Gm-Gg: AYBFou2ykSBw/wVhUKO8eff+va7UCVXl6BqTzDeWClMCE4GrDoFrzjCmfsF29e+Pgss
 bJobF9jE2BnrMBCg4UF51o+ousf79+4lOsZXsFHympWvE9gkqYFtHaxGzpBAhf1cX88s3rLZ7U4
 awKb+1YLq0t706l/t7HYcViGwau83tvKe6zcrzc3gsU4Ce4F176vWCVig59cMucZCETTzNBAXFO
 8ybzdLClLzYqZyePyPty567ABIHzw8C0NwwSfRG3Pm7GIy1I7OvXjguKXQ3rNDNKXxdsvzRFY6L
 p32MQ1ViA2elYgQE1mCb2YgDekAt2qKocSy9m5MmENqETI9GvajNSzLkFK1nHANk36LZeg5hjxg
 i7hG3dU8pzpr2E84TuApb/hiYvfq4m/5FqaibJ+Xu6RBISiiv0PS4mAD1jbPteg/9aTs4YwNY5o
 294hIGMc50TGtB3GLtVepV72XE6moAg1//v1m+DGMlskAjQ9/2Sw==
X-Received: by 2002:a17:906:4fc5:b0:c26:22ec:db92 with SMTP id
 a640c23a62f3a-c2622ecdcadmr45988166b.47.1788537913551; 
 Fri, 04 Sep 2026 09:05:13 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:60d5:49d3:5d47:8dbd])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d036674sm133815966b.8.2026.09.04.09.05.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 09:05:13 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Fri, 04 Sep 2026 17:05:04 +0100
Subject: [PATCH v2 4/4] hw/pci/msi: extract msi_message_address_register
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-jmac-rme-da-prep-v2-4-fb461d78bbb2@linaro.org>
References: <20260904-jmac-rme-da-prep-v2-0-fb461d78bbb2@linaro.org>
In-Reply-To: <20260904-jmac-rme-da-prep-v2-0-fb461d78bbb2@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>, 
 "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org, 
 Jim MacArthur <jim.macarthur@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=jim.macarthur@linaro.org; helo=mail-ej1-x62f.google.com
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


